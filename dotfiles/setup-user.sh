#!/bin/bash

set -e
exec 2> >(while read line; do echo -e "\e[01;31m$line\e[0m"; done)

dotfiles_dir="$(
    cd "$(dirname "$0")"
    pwd
)"
cd "$dotfiles_dir"

link() {
    orig_file="$dotfiles_dir/$1"
    if [ -n "$2" ]; then
        dest_file="$HOME/$2"
    else
        dest_file="$HOME/$1"
    fi

    mkdir -p "$(dirname "$orig_file")"
    mkdir -p "$(dirname "$dest_file")"

    rm -rf "$dest_file"
    ln -s "$orig_file" "$dest_file"
    echo "$dest_file -> $orig_file"
}

is_chroot() {
    ! cmp -s /proc/1/mountinfo /proc/self/mountinfo
}

systemctl_enable_start() {
    echo "systemctl --user enable --now $1"
    systemctl --user enable --now "$1"
}

echo ""
echo "=========================="
echo "Setting up user dotfiles"
echo "=========================="

link ".dmrc"
link ".gitignore"
link ".nvidia-settings-rc"
link ".xinitrc"
link ".xprofile"
link ".xresources"
link ".xsessionrc"
link ".ignore"
link ".magic"
link ".p10k.zsh"
link ".p10k.zsh" ".p10k-ascii-8color.zsh"
link ".zprofile"
link ".shellcheckrc"
link ".zsh-aliases"
link ".zshenv"
link ".zshrc"

link ".config/bat"
link ".config/JetBrains/IntelliJIdea2022.2/options/spellchecker-dictionary.xml"
link ".config/chrome-flags.conf"
link ".config/environment.d"
link ".config/htop"
link ".config/kitty"
link ".config/mimeapps.list"
link ".config/plank"
link ".config/pylint"
link ".config/repoctl"
link ".config/USBGuard"
link ".config/vimiv"
link ".config/genmon"
link ".config/zathura/zathurarc"
link ".config/sublime-text/Packages/User"

link ".local/share/themes"
link ".local/share/icons"

if is_chroot; then
    echo >&2 "=== Running in chroot, skipping user services..."
fi

echo ""
echo "Configuring MIME types"
file --compile --magic-file "$HOME/.magic"

if is_chroot; then
    echo >&2 "=== Running in chroot, skipping GTK file chooser dialog configuration..."
else
    echo "Configuring GTK file chooser dialog"
    gsettings set org.gtk.Settings.FileChooser sort-directories-first true
fi
