#!/bin/bash

packages=(
    accerciser
    celluloid
    cheese
    devhelp
    endeavour
    epiphany
    evolution
    five-or-more
    flite
    four-in-a-row
    geary
    ghex
    gnome-backgrounds
    gnome-boxes
    gnome-builder
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-chess
    gnome-clocks
    gnome-connections
    gnome-devel-docs
    gnome-dictionary
    gnome-disk-utility
    gnome-games
    gnome-initial-setup
    gnome-keyring-pkcs11
    gnome-klotski
    gnome-logs
    gnome-mahjongg
    gnome-maps
    gnome-menus
    gnome-mines
    gnome-multi-writer
    gnome-music
    gnome-nibbles
    gnome-photos
    gnome-recipes
    gnome-reversi
    gnome-robots
    gnome-sound-recorder
    gnome-software
    gnome-software-common
    gnome-system-monitor
    gnome-sudoku
    gnome-taquin
    gnome-text-editor
    gnome-tetravex
    gnome-tour
    gnome-user-docs
    gnome-user-share
    gnome-video-effects
    gnome-weather
    gnome-2048
    gnome-browser-connector
    gnome-contacts
    hitori
    lagno
    lightsoff
    modem-manager-gui
    malcontent
    mpv
    polari
    quadrapassel
    rhythmbox
    simple-scan
    swell-foop
    tali
    yelp-xsl
    yelp
)

if [ -f /etc/os-release ]; then
    . /etc/os-release
    distro=$ID
else
    echo "Unable to detect Linux distribution."
    exit 1
fi

case "$distro" in
    arch|manjaro)
        echo "Detected Arch-based system."
        for pkg in "${packages[@]}"; do
            if pacman -Q "$pkg" &>/dev/null; then
                sudo pacman -Rns --noconfirm "$pkg" && echo "$pkg removed"
            else
                echo "$pkg not installed, skipping."
            fi
        done
        ;;
    fedora)
        echo "Detected Fedora system."
        for pkg in "${packages[@]}"; do
            if rpm -q "$pkg" &>/dev/null; then
                sudo dnf remove -y "$pkg" && echo "$pkg removed"
            else
                echo "$pkg not installed, skipping."
            fi
        done
        ;;
    *)
        echo "Unsupported distribution: $distro"
        exit 1
        ;;
esac
