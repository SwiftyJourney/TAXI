//
//  Created by Juan Francisco Dorado Torres on 01/06/22.
//

import Foundation
import Files
import ShellOut

// MARK: - Data Model

struct FontVariant {
  let name: String
  let themeFileName: String
  let fontFilesToCheck: [String]
}

let firaCode = FontVariant(
  name: "Fira Code (original)",
  themeFileName: "One Dark.xccolortheme",
  fontFilesToCheck: ["FiraCode-Medium.ttf", "FiraCode-Retina.ttf"]
)

let monaspaceVariants: [(family: String, description: String)] = [
  ("Neon", "neo-grotesque sans-serif"),
  ("Argon", "humanist sans-serif"),
  ("Xenon", "slab serif"),
  ("Radon", "handwriting"),
  ("Krypton", "mechanical sans-serif"),
]

let monaspaceFontVariants: [FontVariant] = monaspaceVariants.map { variant in
  FontVariant(
    name: "Monaspace \(variant.family) (\(variant.description))",
    themeFileName: "One Dark - Monaspace \(variant.family).xccolortheme",
    fontFilesToCheck: [
      "Monaspace\(variant.family)Frozen-Regular.ttf",
      "Monaspace\(variant.family)Frozen-Medium.ttf",
      "Monaspace\(variant.family)Frozen-Bold.ttf",
    ]
  )
}

let allVariants = [firaCode] + monaspaceFontVariants

// MARK: - Menu

func printMenu() {
  print("")
  print("===================================")
  print("  One Dark Theme Installer (Xcode)")
  print("===================================")
  print("")
  print("Available font variants:")
  for (index, variant) in allVariants.enumerated() {
    print("  \(index + 1). \(variant.name)")
  }
  print("  7. Install ALL variants")
  print("")
  print("Choose an option (1-7, or comma-separated like 1,3,5):")
}

func parseSelection(_ input: String) -> [Int]? {
  let parts = input
    .split(separator: ",")
    .map { $0.trimmingCharacters(in: .whitespaces) }

  var indices: Set<Int> = []

  for part in parts {
    guard let number = Int(part), number >= 1, number <= 7 else {
      return nil
    }
    if number == 7 {
      return Array(0..<allVariants.count)
    }
    indices.insert(number - 1)
  }

  guard !indices.isEmpty else { return nil }
  return Array(indices).sorted()
}

func getSelectedVariants() -> [Int] {
  while true {
    printMenu()
    guard let input = readLine(), !input.isEmpty else {
      print("Invalid input. Please try again.")
      continue
    }
    if let selection = parseSelection(input) {
      return selection
    }
    print("Invalid input. Please enter numbers 1-7 separated by commas.")
  }
}

// MARK: - Font Installation

let fontsFolder = try Folder.home.subfolder(at: "Library/Fonts")

func installFiraCodeFonts() throws {
  let needed = firaCode.fontFilesToCheck.filter { !fontsFolder.containsFile(named: $0) }
  guard !needed.isEmpty else {
    print("  Fira Code fonts already installed.")
    return
  }

  print("  Downloading Fira Code fonts...")
  let fontZipURL = URL(string: "https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip")!
  let fontZipData = try Data(contentsOf: fontZipURL)

  let fontZipFile = try fontsFolder.createFile(named: "FiraCode.zip", contents: fontZipData)
  try shellOut(to: "unzip -o \(fontZipFile.name) -d FiraCode", at: fontsFolder.path)

  let firaCodeFolder = try fontsFolder.subfolder(named: "FiraCode")
  let ttfFolder = try firaCodeFolder.subfolder(named: "ttf")
  for file in ttfFolder.files {
    do {
      try file.move(to: fontsFolder)
    } catch {
      if let locationError = error as? LocationError {
        switch locationError.reason {
        case .moveFailed(let underlying):
          print("  Warning: \(underlying.localizedDescription)")
        default:
          print("  Warning: Could not move \(file.name)")
        }
      }
    }
  }

  try firaCodeFolder.delete()
  try fontZipFile.delete()
  print("  Fira Code fonts installed.")
}

func installMonaspaceFonts(for selectedIndices: [Int]) throws {
  let monaspaceFamilies = selectedIndices
    .filter { $0 > 0 }
    .map { monaspaceVariants[$0 - 1].family }

  guard !monaspaceFamilies.isEmpty else { return }

  // Check which fonts are already installed
  var neededFamilies: [String] = []
  for family in monaspaceFamilies {
    let variant = monaspaceFontVariants[monaspaceVariants.firstIndex(where: { $0.family == family })!]
    let missing = variant.fontFilesToCheck.filter { !fontsFolder.containsFile(named: $0) }
    if !missing.isEmpty {
      neededFamilies.append(family)
    } else {
      print("  Monaspace \(family) fonts already installed.")
    }
  }

  guard !neededFamilies.isEmpty else { return }

  print("  Downloading Monaspace Frozen fonts...")
  let zipURL = URL(string: "https://github.com/githubnext/monaspace/releases/download/v1.301/monaspace-frozen-v1.301.zip")!
  let zipData = try Data(contentsOf: zipURL)

  let zipFile = try fontsFolder.createFile(named: "monaspace-frozen.zip", contents: zipData)
  try shellOut(to: "unzip -o \"\(zipFile.name)\" -d MonaspaceFrozen", at: fontsFolder.path)

  let extractedFolder = try fontsFolder.subfolder(named: "MonaspaceFrozen")
  let frozenFontsFolder = try extractedFolder.subfolder(at: "Frozen Fonts")

  for family in neededFamilies {
    print("  Installing Monaspace \(family) fonts...")
    let familyFolder = try frozenFontsFolder.subfolder(named: "Monaspace \(family)")
    for file in familyFolder.files where file.extension == "ttf" {
      do {
        try file.copy(to: fontsFolder)
      } catch {
        if let locationError = error as? LocationError {
          switch locationError.reason {
          case .copyFailed(let underlying):
            print("  Warning: \(underlying.localizedDescription)")
          default:
            print("  Warning: Could not copy \(file.name)")
          }
        }
      }
    }
  }

  try extractedFolder.delete()
  try zipFile.delete()
  print("  Monaspace fonts installed.")
}

// MARK: - Theme Installation

func installThemes(for selectedIndices: [Int]) throws {
  let projectRoot = URL(fileURLWithPath: #file)
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .deletingLastPathComponent()

  let xcodeFolder = try Folder.home.subfolder(at: "Library/Developer/Xcode")
  let userDataFolder = try xcodeFolder.createSubfolderIfNeeded(withName: "UserData")
  let themeFolder = try userDataFolder.createSubfolderIfNeeded(withName: "FontAndColorThemes")

  for index in selectedIndices {
    let variant = allVariants[index]
    let themeURL = projectRoot.appendingPathComponent(variant.themeFileName)
    let themeData = try Data(contentsOf: themeURL)
    let themeFile = try themeFolder.createFileIfNeeded(withName: variant.themeFileName)
    try themeFile.write(themeData)
    print("  Installed theme: \(variant.themeFileName)")
  }
}

// MARK: - Main

let selectedIndices = getSelectedVariants()
let selectedNames = selectedIndices.map { allVariants[$0].name }
print("")
print("Installing: \(selectedNames.joined(separator: ", "))")
print("")

// Install fonts
print("Checking fonts...")
let needsFiraCode = selectedIndices.contains(0)
let needsMonaspace = selectedIndices.contains(where: { $0 > 0 })

if needsFiraCode {
  try installFiraCodeFonts()
}

if needsMonaspace {
  try installMonaspaceFonts(for: selectedIndices)
}

// Install themes
print("")
print("Installing themes...")
try installThemes(for: selectedIndices)

print("")
print("One Dark Theme successfully installed!")
print("Select it in Xcode's preferences to start using it (you may have to restart Xcode first).")
