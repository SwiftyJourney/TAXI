# One Dark Theme (for Xcode)

This is a port of [xcode-one-dark](https://github.com/bojan/xcode-one-dark) with support for multiple font variants.

## Screenshot

![screenshot](.screenshots/screenshot.png)

## Font Variants

| # | Variant | Font | Style |
|---|---------|------|-------|
| 1 | One Dark | [Fira Code](https://github.com/tonsky/FiraCode) | Monospaced with ligatures |
| 2 | One Dark - Monaspace Neon | [Monaspace Neon Frozen](https://monaspace.githubnext.com/) | Neo-grotesque sans-serif |
| 3 | One Dark - Monaspace Argon | [Monaspace Argon Frozen](https://monaspace.githubnext.com/) | Humanist sans-serif |
| 4 | One Dark - Monaspace Xenon | [Monaspace Xenon Frozen](https://monaspace.githubnext.com/) | Slab serif |
| 5 | One Dark - Monaspace Radon | [Monaspace Radon Frozen](https://monaspace.githubnext.com/) | Handwriting |
| 6 | One Dark - Monaspace Krypton | [Monaspace Krypton Frozen](https://monaspace.githubnext.com/) | Mechanical sans-serif |

## Installation

### Swift Package Manager (Recommended)

Clone the repo and run `swift run`. An interactive menu will let you choose which variant(s) to install:

```bash
git clone https://github.com/SwiftyJourney/OneDarkTheme.git
cd OneDarkTheme
swift run
```

The installer will:
- Show an interactive menu to pick one or more font variants
- Download and install the required fonts automatically
- Copy the selected theme(s) to Xcode's themes directory

(Optional) Remove the cloned project after installation:

```bash
cd ..
rm -rf OneDarkTheme
```

### Manual

#### Fira Code variant

1. Download [Fira Code](https://github.com/tonsky/FiraCode) and add the fonts from the `ttf` folder to your Font Book
2. Copy `One Dark.xccolortheme` into `~/Library/Developer/Xcode/UserData/FontAndColorThemes/`

#### Monaspace variants

1. Download [Monaspace Frozen](https://github.com/githubnext/monaspace/releases) and install the TTF fonts for your chosen family (e.g. `Frozen Fonts/Monaspace Neon/`) into Font Book
2. Copy the corresponding `.xccolortheme` file (e.g. `One Dark - Monaspace Neon.xccolortheme`) into `~/Library/Developer/Xcode/UserData/FontAndColorThemes/`

> Create the `UserData` and/or `FontAndColorThemes` directories if they don't exist.

After installing, open Xcode (restart if it was already open), go to **Preferences > Themes**, and select your preferred One Dark variant.

## Attributions

- [Bojan Dimovski](https://github.com/bojan), for making a nice theme accessible for the iOS community.
- [John Sundell](https://github.com/JohnSundell), because thanks to his libraries and its own theme, made this great installation process easier.
- [GitHub Next](https://githubnext.com/), for the [Monaspace](https://monaspace.githubnext.com/) font superfamily.
