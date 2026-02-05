//
//  Created by Juan Francisco Dorado Torres on 01/06/22.
//

import Foundation
import Files
import ShellOut

// MARK: - Color Palette

struct ColorPalette {
  let name: String

  // Editor
  let editorBackground: String
  let currentLineHighlight: String
  let selectionColor: String
  let cursorColor: String

  // Syntax
  let plainText: String
  let commentColor: String
  let stringColor: String
  let keywordColor: String
  let numberColor: String
  let typeColor: String
  let functionColor: String
  let variableColor: String
  let constantColor: String
  let attributeColor: String
  let preprocessorColor: String
  let macroColor: String

  // Declarations & marks
  let declarationColor: String
  let declarationTypeColor: String
  let markColor: String

  // Markup
  let markupCodeColor: String
  let urlColor: String
  let invisiblesColor: String
  let markupBackground: String
  let markupBorder: String
  let linkColor: String

  // Debugger
  let debuggerPrompt: String

  // Block dim
  let blockDimBackground: String

  // Derived values
  var plainText70: String {
    applyAlpha(plainText, alpha: 0.7)
  }
  var plainText50: String {
    applyAlpha(plainText, alpha: 0.5)
  }
}

func applyAlpha(_ color: String, alpha: Double) -> String {
  let parts = color.split(separator: " ").map { String($0) }
  guard parts.count >= 3 else { return color }
  return "\(parts[0]) \(parts[1]) \(parts[2]) \(alpha)"
}

func hexToRGBA(_ hex: String) -> String {
  let h = hex.hasPrefix("#") ? String(hex.dropFirst()) : hex
  let scanner = Scanner(string: h)
  var rgb: UInt64 = 0
  scanner.scanHexInt64(&rgb)
  let r = Double((rgb >> 16) & 0xFF) / 255.0
  let g = Double((rgb >> 8) & 0xFF) / 255.0
  let b = Double(rgb & 0xFF) / 255.0
  return String(format: "%.6f %.6f %.6f 1", r, g, b)
}

// MARK: - Palettes

let oneDark = ColorPalette(
  name: "One Dark",
  editorBackground: "0.152941 0.168627 0.2 1",
  currentLineHighlight: "0.17451 0.192157 0.228431 1",
  selectionColor: "0.239216 0.262745 0.313725 1",
  cursorColor: "0.321569 0.545098 1 1",
  plainText: "0.65098 0.698039 0.752941 1",
  commentColor: "0.34902 0.384314 0.435294 1",
  stringColor: "0.564706 0.764706 0.470588 1",
  keywordColor: "0.776471 0.47451 0.866667 1",
  numberColor: "0.823529 0.580392 0.364706 1",
  typeColor: "0.898039 0.756863 0.486275 1",
  functionColor: "0.380392 0.682353 0.937255 1",
  variableColor: "0.87451 0.415686 0.45098 1",
  constantColor: "0.776471 0.47451 0.866667 1",
  attributeColor: "0.823529 0.580392 0.364706 1",
  preprocessorColor: "0.680619 0.503594 0.999973 1",
  macroColor: "0.327648 0.869403 0.396378 1",
  declarationColor: "0.254902 0.631373 0.752941 1",
  declarationTypeColor: "0.362946 0.846428 0.998966 1",
  markColor: "0.572549 0.631373 0.694118 1",
  markupCodeColor: "0.665 0.052 0.569 1",
  urlColor: "0.823529 0.580392 0.364706 1",
  invisiblesColor: "0.454902 0.45098 0.411765 1",
  markupBackground: "0.220706 0.235137 0.264 1",
  markupBorder: "0.283049 0.296326 0.32288 1",
  linkColor: "0.823529 0.580392 0.364706 1",
  debuggerPrompt: "0.87451 0.415686 0.45098 1",
  blockDimBackground: "0.5 0.5 0.5 1"
)

let dracula = ColorPalette(
  name: "Dracula",
  editorBackground: hexToRGBA("#282a36"),
  currentLineHighlight: hexToRGBA("#333545"),
  selectionColor: hexToRGBA("#44475a"),
  cursorColor: hexToRGBA("#f8f8f2"),
  plainText: hexToRGBA("#f8f8f2"),
  commentColor: hexToRGBA("#6272a4"),
  stringColor: hexToRGBA("#f1fa8c"),
  keywordColor: hexToRGBA("#ff79c6"),
  numberColor: hexToRGBA("#bd93f9"),
  typeColor: hexToRGBA("#8be9fd"),
  functionColor: hexToRGBA("#50fa7b"),
  variableColor: hexToRGBA("#f8f8f2"),
  constantColor: hexToRGBA("#bd93f9"),
  attributeColor: hexToRGBA("#50fa7b"),
  preprocessorColor: hexToRGBA("#ff79c6"),
  macroColor: hexToRGBA("#50fa7b"),
  declarationColor: hexToRGBA("#8be9fd"),
  declarationTypeColor: hexToRGBA("#8be9fd"),
  markColor: hexToRGBA("#f8f8f2"),
  markupCodeColor: hexToRGBA("#ff79c6"),
  urlColor: hexToRGBA("#8be9fd"),
  invisiblesColor: hexToRGBA("#6272a4"),
  markupBackground: hexToRGBA("#343746"),
  markupBorder: hexToRGBA("#44475a"),
  linkColor: hexToRGBA("#8be9fd"),
  debuggerPrompt: hexToRGBA("#ff79c6"),
  blockDimBackground: "0.5 0.5 0.5 1"
)

let solarizedDark = ColorPalette(
  name: "Solarized Dark",
  editorBackground: hexToRGBA("#002b36"),
  currentLineHighlight: hexToRGBA("#073642"),
  selectionColor: hexToRGBA("#073642"),
  cursorColor: hexToRGBA("#839496"),
  plainText: hexToRGBA("#839496"),
  commentColor: hexToRGBA("#586e75"),
  stringColor: hexToRGBA("#2aa198"),
  keywordColor: hexToRGBA("#859900"),
  numberColor: hexToRGBA("#d33682"),
  typeColor: hexToRGBA("#b58900"),
  functionColor: hexToRGBA("#268bd2"),
  variableColor: hexToRGBA("#268bd2"),
  constantColor: hexToRGBA("#d33682"),
  attributeColor: hexToRGBA("#cb4b16"),
  preprocessorColor: hexToRGBA("#cb4b16"),
  macroColor: hexToRGBA("#859900"),
  declarationColor: hexToRGBA("#268bd2"),
  declarationTypeColor: hexToRGBA("#268bd2"),
  markColor: hexToRGBA("#93a1a1"),
  markupCodeColor: hexToRGBA("#d33682"),
  urlColor: hexToRGBA("#268bd2"),
  invisiblesColor: hexToRGBA("#073642"),
  markupBackground: hexToRGBA("#073642"),
  markupBorder: hexToRGBA("#586e75"),
  linkColor: hexToRGBA("#268bd2"),
  debuggerPrompt: hexToRGBA("#cb4b16"),
  blockDimBackground: "0.5 0.5 0.5 1"
)

let solarizedLight = ColorPalette(
  name: "Solarized Light",
  editorBackground: hexToRGBA("#fdf6e3"),
  currentLineHighlight: hexToRGBA("#eee8d5"),
  selectionColor: hexToRGBA("#eee8d5"),
  cursorColor: hexToRGBA("#657b83"),
  plainText: hexToRGBA("#657b83"),
  commentColor: hexToRGBA("#93a1a1"),
  stringColor: hexToRGBA("#2aa198"),
  keywordColor: hexToRGBA("#859900"),
  numberColor: hexToRGBA("#d33682"),
  typeColor: hexToRGBA("#b58900"),
  functionColor: hexToRGBA("#268bd2"),
  variableColor: hexToRGBA("#268bd2"),
  constantColor: hexToRGBA("#d33682"),
  attributeColor: hexToRGBA("#cb4b16"),
  preprocessorColor: hexToRGBA("#cb4b16"),
  macroColor: hexToRGBA("#859900"),
  declarationColor: hexToRGBA("#268bd2"),
  declarationTypeColor: hexToRGBA("#268bd2"),
  markColor: hexToRGBA("#586e75"),
  markupCodeColor: hexToRGBA("#d33682"),
  urlColor: hexToRGBA("#268bd2"),
  invisiblesColor: hexToRGBA("#eee8d5"),
  markupBackground: hexToRGBA("#eee8d5"),
  markupBorder: hexToRGBA("#93a1a1"),
  linkColor: hexToRGBA("#268bd2"),
  debuggerPrompt: hexToRGBA("#cb4b16"),
  blockDimBackground: "0.5 0.5 0.5 1"
)

let githubLight = ColorPalette(
  name: "GitHub Light",
  editorBackground: hexToRGBA("#ffffff"),
  currentLineHighlight: hexToRGBA("#f6f8fa"),
  selectionColor: hexToRGBA("#add6ff"),
  cursorColor: hexToRGBA("#0969da"),
  plainText: hexToRGBA("#1f2328"),
  commentColor: hexToRGBA("#6e7781"),
  stringColor: hexToRGBA("#0a3069"),
  keywordColor: hexToRGBA("#cf222e"),
  numberColor: hexToRGBA("#0550ae"),
  typeColor: hexToRGBA("#8250df"),
  functionColor: hexToRGBA("#8250df"),
  variableColor: hexToRGBA("#953800"),
  constantColor: hexToRGBA("#0550ae"),
  attributeColor: hexToRGBA("#953800"),
  preprocessorColor: hexToRGBA("#cf222e"),
  macroColor: hexToRGBA("#8250df"),
  declarationColor: hexToRGBA("#0550ae"),
  declarationTypeColor: hexToRGBA("#0550ae"),
  markColor: hexToRGBA("#1f2328"),
  markupCodeColor: hexToRGBA("#cf222e"),
  urlColor: hexToRGBA("#0969da"),
  invisiblesColor: hexToRGBA("#d1d9e0"),
  markupBackground: hexToRGBA("#f6f8fa"),
  markupBorder: hexToRGBA("#d1d9e0"),
  linkColor: hexToRGBA("#0969da"),
  debuggerPrompt: hexToRGBA("#cf222e"),
  blockDimBackground: "0.5 0.5 0.5 1"
)

let halloween = ColorPalette(
  name: "Halloween",
  editorBackground: hexToRGBA("#1c1024"),
  currentLineHighlight: hexToRGBA("#241430"),
  selectionColor: hexToRGBA("#2e1a3e"),
  cursorColor: hexToRGBA("#ff6600"),
  plainText: hexToRGBA("#d4c5a9"),
  commentColor: hexToRGBA("#665577"),
  stringColor: hexToRGBA("#50c878"),
  keywordColor: hexToRGBA("#ff6600"),
  numberColor: hexToRGBA("#bf5af2"),
  typeColor: hexToRGBA("#ffaa33"),
  functionColor: hexToRGBA("#ff4040"),
  variableColor: hexToRGBA("#ff9944"),
  constantColor: hexToRGBA("#bf5af2"),
  attributeColor: hexToRGBA("#ffaa33"),
  preprocessorColor: hexToRGBA("#ff6600"),
  macroColor: hexToRGBA("#50c878"),
  declarationColor: hexToRGBA("#ff4040"),
  declarationTypeColor: hexToRGBA("#ff6600"),
  markColor: hexToRGBA("#d4c5a9"),
  markupCodeColor: hexToRGBA("#ff6600"),
  urlColor: hexToRGBA("#ff9944"),
  invisiblesColor: hexToRGBA("#3d2a4d"),
  markupBackground: hexToRGBA("#241430"),
  markupBorder: hexToRGBA("#3d2a4d"),
  linkColor: hexToRGBA("#ff9944"),
  debuggerPrompt: hexToRGBA("#ff4040"),
  blockDimBackground: "0.5 0.5 0.5 1"
)

let allPalettes = [oneDark, dracula, solarizedDark, solarizedLight, githubLight, halloween]

// MARK: - Font Set

struct FontSet {
  let name: String
  let description: String
  let regular: String
  let medium: String
  let bold: String
  let fontFilesToCheck: [String]
}

let firaCodeFont = FontSet(
  name: "Fira Code",
  description: "original",
  regular: "FiraCode-Retina",
  medium: "FiraCode-Medium",
  bold: "FiraCodeRoman-Bold",
  fontFilesToCheck: ["FiraCode-Medium.ttf", "FiraCode-Retina.ttf"]
)

let monaspaceDescriptions: [(family: String, description: String)] = [
  ("Neon", "neo-grotesque sans-serif"),
  ("Argon", "humanist sans-serif"),
  ("Xenon", "slab serif"),
  ("Radon", "handwriting"),
  ("Krypton", "mechanical sans-serif"),
]

let monaspaceFonts: [FontSet] = monaspaceDescriptions.map { variant in
  FontSet(
    name: "Monaspace \(variant.family)",
    description: variant.description,
    regular: "Monaspace\(variant.family)Frozen-Regular",
    medium: "Monaspace\(variant.family)Frozen-Medium",
    bold: "Monaspace\(variant.family)Frozen-Bold",
    fontFilesToCheck: [
      "Monaspace\(variant.family)Frozen-Regular.ttf",
      "Monaspace\(variant.family)Frozen-Medium.ttf",
      "Monaspace\(variant.family)Frozen-Bold.ttf",
    ]
  )
}

let allFonts = [firaCodeFont] + monaspaceFonts

// MARK: - Theme Generator

let themeTemplate = """
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
\t<key>DVTConsoleDebuggerInputTextColor</key>
\t<string>{{plainText}}</string>
\t<key>DVTConsoleDebuggerInputTextFont</key>
\t<string>{{fontMedium}} - 11.0</string>
\t<key>DVTConsoleDebuggerOutputTextColor</key>
\t<string>{{plainText}}</string>
\t<key>DVTConsoleDebuggerOutputTextFont</key>
\t<string>{{fontMedium}} - 11.0</string>
\t<key>DVTConsoleDebuggerPromptTextColor</key>
\t<string>{{debuggerPrompt}}</string>
\t<key>DVTConsoleDebuggerPromptTextFont</key>
\t<string>{{fontMedium}} - 11.0</string>
\t<key>DVTConsoleExectuableInputTextColor</key>
\t<string>{{plainText}}</string>
\t<key>DVTConsoleExectuableInputTextFont</key>
\t<string>{{fontMedium}} - 11.0</string>
\t<key>DVTConsoleExectuableOutputTextColor</key>
\t<string>{{plainText}}</string>
\t<key>DVTConsoleExectuableOutputTextFont</key>
\t<string>{{fontMedium}} - 11.0</string>
\t<key>DVTConsoleTextBackgroundColor</key>
\t<string>{{editorBackground}}</string>
\t<key>DVTConsoleTextInsertionPointColor</key>
\t<string>{{cursorColor}}</string>
\t<key>DVTConsoleTextSelectionColor</key>
\t<string>{{selectionColor}}</string>
\t<key>DVTFontAndColorVersion</key>
\t<integer>1</integer>
\t<key>DVTFontSizeModifier</key>
\t<integer>-2</integer>
\t<key>DVTLineSpacing</key>
\t<real>1.2000000476837158</real>
\t<key>DVTMarkupTextBackgroundColor</key>
\t<string>{{markupBackground}}</string>
\t<key>DVTMarkupTextBorderColor</key>
\t<string>{{markupBorder}}</string>
\t<key>DVTMarkupTextCodeFont</key>
\t<string>Monaco - 11.0</string>
\t<key>DVTMarkupTextEmphasisColor</key>
\t<string>{{plainText}}</string>
\t<key>DVTMarkupTextEmphasisFont</key>
\t<string>.SFNS-RegularItalic - 12.0</string>
\t<key>DVTMarkupTextInlineCodeColor</key>
\t<string>{{plainText70}}</string>
\t<key>DVTMarkupTextLinkColor</key>
\t<string>{{linkColor}}</string>
\t<key>DVTMarkupTextLinkFont</key>
\t<string>.SFNS-Regular - 12.0</string>
\t<key>DVTMarkupTextNormalColor</key>
\t<string>{{plainText}}</string>
\t<key>DVTMarkupTextNormalFont</key>
\t<string>.SFNS-Regular - 12.0</string>
\t<key>DVTMarkupTextOtherHeadingColor</key>
\t<string>{{plainText50}}</string>
\t<key>DVTMarkupTextOtherHeadingFont</key>
\t<string>.SFNS-Regular - 17.6</string>
\t<key>DVTMarkupTextPrimaryHeadingColor</key>
\t<string>{{plainText}}</string>
\t<key>DVTMarkupTextPrimaryHeadingFont</key>
\t<string>.SFNS-Regular - 31.6</string>
\t<key>DVTMarkupTextSecondaryHeadingColor</key>
\t<string>{{plainText}}</string>
\t<key>DVTMarkupTextSecondaryHeadingFont</key>
\t<string>.SFNS-Regular - 23.2</string>
\t<key>DVTMarkupTextStrongColor</key>
\t<string>{{plainText}}</string>
\t<key>DVTMarkupTextStrongFont</key>
\t<string>.SFNS-Bold - 12.0</string>
\t<key>DVTScrollbarMarkerAnalyzerColor</key>
\t<string>0.403922 0.372549 1 1</string>
\t<key>DVTScrollbarMarkerBreakpointColor</key>
\t<string>0.290196 0.290196 0.968627 1</string>
\t<key>DVTScrollbarMarkerDiffColor</key>
\t<string>0.556863 0.556863 0.556863 1</string>
\t<key>DVTScrollbarMarkerDiffConflictColor</key>
\t<string>0.968627 0.290196 0.290196 1</string>
\t<key>DVTScrollbarMarkerErrorColor</key>
\t<string>0.968627 0.290196 0.290196 1</string>
\t<key>DVTScrollbarMarkerRuntimeIssueColor</key>
\t<string>0.643137 0.509804 1 1</string>
\t<key>DVTScrollbarMarkerWarningColor</key>
\t<string>0.937255 0.717647 0.34902 1</string>
\t<key>DVTSourceTextBackground</key>
\t<string>{{editorBackground}}</string>
\t<key>DVTSourceTextBlockDimBackgroundColor</key>
\t<string>{{blockDimBackground}}</string>
\t<key>DVTSourceTextCurrentLineHighlightColor</key>
\t<string>{{currentLineHighlight}}</string>
\t<key>DVTSourceTextInsertionPointColor</key>
\t<string>{{cursorColor}}</string>
\t<key>DVTSourceTextInvisiblesColor</key>
\t<string>{{invisiblesColor}}</string>
\t<key>DVTSourceTextSelectionColor</key>
\t<string>{{selectionColor}}</string>
\t<key>DVTSourceTextSyntaxColors</key>
\t<dict>
\t\t<key>xcode.syntax.attribute</key>
\t\t<string>{{attributeColor}}</string>
\t\t<key>xcode.syntax.character</key>
\t\t<string>{{stringColor}}</string>
\t\t<key>xcode.syntax.comment</key>
\t\t<string>{{commentColor}}</string>
\t\t<key>xcode.syntax.comment.doc</key>
\t\t<string>{{commentColor}}</string>
\t\t<key>xcode.syntax.comment.doc.keyword</key>
\t\t<string>{{commentColor}}</string>
\t\t<key>xcode.syntax.declaration.other</key>
\t\t<string>{{declarationColor}}</string>
\t\t<key>xcode.syntax.declaration.type</key>
\t\t<string>{{declarationTypeColor}}</string>
\t\t<key>xcode.syntax.identifier.class</key>
\t\t<string>{{typeColor}}</string>
\t\t<key>xcode.syntax.identifier.class.system</key>
\t\t<string>{{typeColor}}</string>
\t\t<key>xcode.syntax.identifier.constant</key>
\t\t<string>{{constantColor}}</string>
\t\t<key>xcode.syntax.identifier.constant.system</key>
\t\t<string>{{constantColor}}</string>
\t\t<key>xcode.syntax.identifier.function</key>
\t\t<string>{{functionColor}}</string>
\t\t<key>xcode.syntax.identifier.function.system</key>
\t\t<string>{{functionColor}}</string>
\t\t<key>xcode.syntax.identifier.macro</key>
\t\t<string>{{macroColor}}</string>
\t\t<key>xcode.syntax.identifier.macro.system</key>
\t\t<string>{{macroColor}}</string>
\t\t<key>xcode.syntax.identifier.type</key>
\t\t<string>{{typeColor}}</string>
\t\t<key>xcode.syntax.identifier.type.system</key>
\t\t<string>{{typeColor}}</string>
\t\t<key>xcode.syntax.identifier.variable</key>
\t\t<string>{{variableColor}}</string>
\t\t<key>xcode.syntax.identifier.variable.system</key>
\t\t<string>{{variableColor}}</string>
\t\t<key>xcode.syntax.keyword</key>
\t\t<string>{{keywordColor}}</string>
\t\t<key>xcode.syntax.mark</key>
\t\t<string>{{markColor}}</string>
\t\t<key>xcode.syntax.markup.code</key>
\t\t<string>{{markupCodeColor}}</string>
\t\t<key>xcode.syntax.number</key>
\t\t<string>{{numberColor}}</string>
\t\t<key>xcode.syntax.plain</key>
\t\t<string>{{plainText}}</string>
\t\t<key>xcode.syntax.preprocessor</key>
\t\t<string>{{preprocessorColor}}</string>
\t\t<key>xcode.syntax.string</key>
\t\t<string>{{stringColor}}</string>
\t\t<key>xcode.syntax.url</key>
\t\t<string>{{urlColor}}</string>
\t</dict>
\t<key>DVTSourceTextSyntaxFonts</key>
\t<dict>
\t\t<key>xcode.syntax.attribute</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t\t<key>xcode.syntax.character</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t\t<key>xcode.syntax.comment</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t\t<key>xcode.syntax.comment.doc</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t\t<key>xcode.syntax.comment.doc.keyword</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t\t<key>xcode.syntax.declaration.other</key>
\t\t<string>{{fontMedium}} - 13.0</string>
\t\t<key>xcode.syntax.declaration.type</key>
\t\t<string>{{fontMedium}} - 13.0</string>
\t\t<key>xcode.syntax.identifier.class</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t\t<key>xcode.syntax.identifier.class.system</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t\t<key>xcode.syntax.identifier.constant</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t\t<key>xcode.syntax.identifier.constant.system</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t\t<key>xcode.syntax.identifier.function</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t\t<key>xcode.syntax.identifier.function.system</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t\t<key>xcode.syntax.identifier.macro</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t\t<key>xcode.syntax.identifier.macro.system</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t\t<key>xcode.syntax.identifier.type</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t\t<key>xcode.syntax.identifier.type.system</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t\t<key>xcode.syntax.identifier.variable</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t\t<key>xcode.syntax.identifier.variable.system</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t\t<key>xcode.syntax.keyword</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t\t<key>xcode.syntax.mark</key>
\t\t<string>{{fontBold}} - 13.0</string>
\t\t<key>xcode.syntax.markup.code</key>
\t\t<string>{{fontMedium}} - 13.0</string>
\t\t<key>xcode.syntax.number</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t\t<key>xcode.syntax.plain</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t\t<key>xcode.syntax.preprocessor</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t\t<key>xcode.syntax.string</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t\t<key>xcode.syntax.url</key>
\t\t<string>{{fontRegular}} - 13.0</string>
\t</dict>
</dict>
</plist>
"""

func generateTheme(palette: ColorPalette, fontSet: FontSet) -> String {
  var result = themeTemplate
  // Color replacements
  result = result.replacingOccurrences(of: "{{editorBackground}}", with: palette.editorBackground)
  result = result.replacingOccurrences(of: "{{currentLineHighlight}}", with: palette.currentLineHighlight)
  result = result.replacingOccurrences(of: "{{selectionColor}}", with: palette.selectionColor)
  result = result.replacingOccurrences(of: "{{cursorColor}}", with: palette.cursorColor)
  result = result.replacingOccurrences(of: "{{plainText70}}", with: palette.plainText70)
  result = result.replacingOccurrences(of: "{{plainText50}}", with: palette.plainText50)
  result = result.replacingOccurrences(of: "{{plainText}}", with: palette.plainText)
  result = result.replacingOccurrences(of: "{{commentColor}}", with: palette.commentColor)
  result = result.replacingOccurrences(of: "{{stringColor}}", with: palette.stringColor)
  result = result.replacingOccurrences(of: "{{keywordColor}}", with: palette.keywordColor)
  result = result.replacingOccurrences(of: "{{numberColor}}", with: palette.numberColor)
  result = result.replacingOccurrences(of: "{{typeColor}}", with: palette.typeColor)
  result = result.replacingOccurrences(of: "{{functionColor}}", with: palette.functionColor)
  result = result.replacingOccurrences(of: "{{variableColor}}", with: palette.variableColor)
  result = result.replacingOccurrences(of: "{{constantColor}}", with: palette.constantColor)
  result = result.replacingOccurrences(of: "{{attributeColor}}", with: palette.attributeColor)
  result = result.replacingOccurrences(of: "{{preprocessorColor}}", with: palette.preprocessorColor)
  result = result.replacingOccurrences(of: "{{macroColor}}", with: palette.macroColor)
  result = result.replacingOccurrences(of: "{{declarationColor}}", with: palette.declarationColor)
  result = result.replacingOccurrences(of: "{{declarationTypeColor}}", with: palette.declarationTypeColor)
  result = result.replacingOccurrences(of: "{{markColor}}", with: palette.markColor)
  result = result.replacingOccurrences(of: "{{markupCodeColor}}", with: palette.markupCodeColor)
  result = result.replacingOccurrences(of: "{{urlColor}}", with: palette.urlColor)
  result = result.replacingOccurrences(of: "{{invisiblesColor}}", with: palette.invisiblesColor)
  result = result.replacingOccurrences(of: "{{markupBackground}}", with: palette.markupBackground)
  result = result.replacingOccurrences(of: "{{markupBorder}}", with: palette.markupBorder)
  result = result.replacingOccurrences(of: "{{linkColor}}", with: palette.linkColor)
  result = result.replacingOccurrences(of: "{{debuggerPrompt}}", with: palette.debuggerPrompt)
  result = result.replacingOccurrences(of: "{{blockDimBackground}}", with: palette.blockDimBackground)
  // Font replacements
  result = result.replacingOccurrences(of: "{{fontRegular}}", with: fontSet.regular)
  result = result.replacingOccurrences(of: "{{fontMedium}}", with: fontSet.medium)
  result = result.replacingOccurrences(of: "{{fontBold}}", with: fontSet.bold)
  return result
}

func themeFileName(palette: ColorPalette, fontSet: FontSet) -> String {
  if fontSet.name == "Fira Code" {
    return "\(palette.name).xccolortheme"
  } else {
    return "\(palette.name) - \(fontSet.name).xccolortheme"
  }
}

// MARK: - Interactive Menu

func parseSelection(_ input: String, max: Int) -> [Int]? {
  let parts = input
    .split(separator: ",")
    .map { $0.trimmingCharacters(in: .whitespaces) }

  var indices: Set<Int> = []

  for part in parts {
    guard let number = Int(part), number >= 1, number <= max + 1 else {
      return nil
    }
    if number == max + 1 {
      return Array(0..<max)
    }
    indices.insert(number - 1)
  }

  guard !indices.isEmpty else { return nil }
  return Array(indices).sorted()
}

func selectColorSchemes() -> [Int] {
  while true {
    print("")
    print("===================================")
    print("  Xcode Theme Installer")
    print("===================================")
    print("")
    print("Step 1 - Color scheme:")
    for (index, palette) in allPalettes.enumerated() {
      print("  \(index + 1). \(palette.name)")
    }
    print("  \(allPalettes.count + 1). All color schemes")
    print("")
    print("Choose (\(1)-\(allPalettes.count + 1), or comma-separated):")

    guard let input = readLine(), !input.isEmpty else {
      print("Invalid input. Please try again.")
      continue
    }
    if let selection = parseSelection(input, max: allPalettes.count) {
      return selection
    }
    print("Invalid input. Please enter numbers 1-\(allPalettes.count + 1) separated by commas.")
  }
}

func selectFonts() -> [Int] {
  while true {
    print("")
    print("Step 2 - Font:")
    for (index, font) in allFonts.enumerated() {
      print("  \(index + 1). \(font.name) (\(font.description))")
    }
    print("  \(allFonts.count + 1). All fonts")
    print("")
    print("Choose (\(1)-\(allFonts.count + 1), or comma-separated):")

    guard let input = readLine(), !input.isEmpty else {
      print("Invalid input. Please try again.")
      continue
    }
    if let selection = parseSelection(input, max: allFonts.count) {
      return selection
    }
    print("Invalid input. Please enter numbers 1-\(allFonts.count + 1) separated by commas.")
  }
}

// MARK: - Font Installation

let fontsFolder = try Folder.home.subfolder(at: "Library/Fonts")

func installFiraCodeFonts() throws {
  let needed = firaCodeFont.fontFilesToCheck.filter { !fontsFolder.containsFile(named: $0) }
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

func installMonaspaceFonts(for fontIndices: [Int]) throws {
  let monaspaceFamilies = fontIndices
    .compactMap { index -> String? in
      guard index > 0 else { return nil }
      return monaspaceDescriptions[index - 1].family
    }

  guard !monaspaceFamilies.isEmpty else { return }

  var neededFamilies: [String] = []
  for family in monaspaceFamilies {
    let font = monaspaceFonts[monaspaceDescriptions.firstIndex(where: { $0.family == family })!]
    let missing = font.fontFilesToCheck.filter { !fontsFolder.containsFile(named: $0) }
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

func installThemes(colorIndices: [Int], fontIndices: [Int]) throws {
  let xcodeFolder = try Folder.home.subfolder(at: "Library/Developer/Xcode")
  let userDataFolder = try xcodeFolder.createSubfolderIfNeeded(withName: "UserData")
  let themeFolder = try userDataFolder.createSubfolderIfNeeded(withName: "FontAndColorThemes")

  for ci in colorIndices {
    let palette = allPalettes[ci]
    for fi in fontIndices {
      let fontSet = allFonts[fi]
      let xml = generateTheme(palette: palette, fontSet: fontSet)
      let fileName = themeFileName(palette: palette, fontSet: fontSet)
      let file = try themeFolder.createFileIfNeeded(withName: fileName)
      try file.write(xml)
      print("  Installed: \(fileName)")
    }
  }
}

// MARK: - Main

let colorIndices = selectColorSchemes()
let fontIndices = selectFonts()

let combinations: [(String, String)] = colorIndices.flatMap { ci in
  fontIndices.map { fi in (allPalettes[ci].name, allFonts[fi].name) }
}
let themeCount = combinations.count
let summary = combinations.map { "\($0.0) + \($0.1)" }.joined(separator: ", ")
print("")
print("Installing \(themeCount) theme(s): \(summary)")
print("")

// Install fonts
print("Checking fonts...")
let needsFiraCode = fontIndices.contains(0)
let needsMonaspace = fontIndices.contains(where: { $0 > 0 })

if needsFiraCode {
  try installFiraCodeFonts()
}

if needsMonaspace {
  try installMonaspaceFonts(for: fontIndices)
}

// Generate and install themes
print("")
print("Installing themes...")
try installThemes(colorIndices: colorIndices, fontIndices: fontIndices)

print("")
print("Themes successfully installed!")
print("Select your theme in Xcode > Preferences > Themes (you may need to restart Xcode).")
