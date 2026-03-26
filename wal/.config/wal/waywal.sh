#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

choice=$(ls "$WALLPAPER_DIR" | while read -r file; do
    echo -en "$file\0icon\x1f$WALLPAPER_DIR/$file\n"
done | rofi -dmenu -i -show-icons -theme ~/.config/rofi/themes/wallpaper.rasi -p "Select Wallpaper")

if [ -z "$choice" ]; then
    exit 0
fi

FULL_PATH="$WALLPAPER_DIR/$choice"

if ! pgrep -x "awww-daemon" > /dev/null; then
    awww-daemon &
    sleep -.5
fi

awww img "$FULL_PATH" --transition-type grow --transition-pos "$(hyprctl cursorpos)" --transition-duration 2

wal -i "$FULL_PATH"

~/.config/waybar/scripts/launch.sh

notify-send "Theme Updated" "Wallpaper: $choice" -i "$FULL_PATH"
