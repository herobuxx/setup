#!/bin/bash

echo "This script will replace PulseAudio and JACK2 with PipeWire equivalents."
read -p "Do you want to continue? [y/N]: " confirm
[[ "$confirm" != [yY] ]] && echo "Aborted." && exit 1

echo "Removing PulseAudio and JACK2..."
if sudo pacman -Rdd pulseaudio jack2; then
    echo "Removed PulseAudio and JACK2."
else
    echo "Error removing PulseAudio or JACK2. Exiting."
    exit 1
fi

echo "Installing PipeWire and compatibility packages..."
if sudo pacman -S pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber; then
    echo "PipeWire stack installed."
else
    echo "Error installing PipeWire packages. Exiting."
    exit 1
fi

echo "Enabling PipeWire user services..."
if systemctl --user enable --now pipewire pipewire-pulse wireplumber; then
    echo "PipeWire services enabled and started."
else
    echo "Error enabling PipeWire services. Exiting."
    exit 1
fi

read -p "PipeWire setup complete. Do you want to reboot now? [y/N]: " reboot_confirm
if [[ "$reboot_confirm" =~ ^[yY]$ ]]; then
    echo "Rebooting..."
    reboot
else
    echo "Reboot skipped. You may need to reboot later to finalize the switch."
fi
