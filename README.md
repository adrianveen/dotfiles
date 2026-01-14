# dotfiles

Bare git repo for dotfiles management across Arch Linux and Windows.

## Setup on a new machine
```bash
# Clone the bare repo
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/adrianveen/dotfiles.git tmpdotfiles

# Copy files (handles conflicts with existing configs)
rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
rm -rf tmpdotfiles

# Set up alias and config
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
```

## Usage
```bash
dotfiles status          # Check what's changed
dotfiles add <file>      # Track a new file
dotfiles commit -m "msg" # Commit changes
dotfiles push            # Push to remote
```

## Contents

### Linux (Arch/KDE)
- `.bashrc` - Shell config
- `.config/nvim/` - Neovim (LazyVim)
- `.config/kitty/` - Kitty terminal
- `.config/plasma-org.kde.plasma.desktop-appletsrc` - KDE panels & widgets (inc. Panel Colorizer)
- `.config/kdeglobals` - KDE colors, fonts, icons
- `.config/kwinrc` - KWin window manager
- `.config/plasmarc` - Plasma theme
- `.config/plasmashellrc` - Plasma shell settings

### Windows
- `windows/Microsoft.PowerShell_profile.ps1` - PowerShell prompt
