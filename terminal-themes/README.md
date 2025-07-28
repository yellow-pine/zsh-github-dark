# Terminal Themes

This directory contains GitHub Dark color schemes for various terminal emulators.

## Available Themes

### iTerm2
- **File**: `iterm2/github-dark.itermcolors`
- **Installation**: 
  1. Open iTerm2 preferences (⌘,)
  2. Go to Profiles → Colors
  3. Click "Color Presets..." → "Import..."
  4. Select `github-dark.itermcolors`
  5. Select "GitHub Dark" from the dropdown

### Alacritty
- **File**: `alacritty/github-dark.yml`
- **Installation**:
  1. Copy the contents to your `~/.config/alacritty/alacritty.yml`
  2. Or create a separate file and import it:
     ```yaml
     import:
       - ~/.config/alacritty/github-dark.yml
     ```

### Kitty
- **File**: `kitty/github-dark.conf`
- **Installation**:
  1. Copy to `~/.config/kitty/github-dark.conf`
  2. Add to your `kitty.conf`:
     ```
     include github-dark.conf
     ```

## Color Palette

The GitHub Dark theme uses the following color palette:

| Color | Normal | Bright | Usage |
|-------|--------|--------|-------|
| Black | `#20262d` | `#45525e` | Background elements |
| Red | `#ff6666` | `#ff6666` | Errors, alerts |
| Green | `#98c379` | `#5bbd69` | Success, strings |
| Yellow | `#e5c07b` | `#f0c674` | Warnings, classes |
| Blue | `#3c8dff` | `#659fff` | Keywords, links |
| Magenta | `#b294bb` | `#cc99cc` | Variables |
| Cyan | `#55cfbb` | `#66ddcc` | Constants |
| White | `#c8ced1` | `#f2f7f8` | Text |

**Background**: `#14191f`  
**Foreground**: `#c8ced1`

## Contributing

To add support for a new terminal emulator:
1. Create a new directory with the terminal's name
2. Add the theme file in the appropriate format
3. Update this README with installation instructions
4. Ensure colors match the palette above