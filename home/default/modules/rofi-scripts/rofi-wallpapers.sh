#!/bin/bash

DIR="$HOME/Pictures/wallpapers"
CACHE_DIR="$DIR/.cache"
mkdir -p "$CACHE_DIR"

set_wallpaper() {
  matugen image "$1" --source-color-index 0
}

mapfile -d '' ALL_FILES < <(find "$DIR" -maxdepth 2 -name ".cache" -prune -o -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -print0 | sort -z)

list_wallpapers() {
  for img in "${ALL_FILES[@]}"; do
    filename="${img##*/}"
    thumb="$CACHE_DIR/${filename}.jpg"

    if [[ ! -f "$thumb" ]]; then
      magick -limit thread 1 -define jpeg:size=512x512 "$img" -filter Triangle -thumbnail 320x180^ -gravity center -extent 320x180 -quality 60 -strip "$thumb"
    fi

    name="${filename%.*}"       # Remove extension
    name="${name//[_-]/ }"      # Replace _ and - with space
    words=($name)               # Split into array
    display_name="${words[*]^}" # Capitalize first letter of each word

    printf '%s\0icon\x1f%s\x1finfo\x1f%s\n' "$display_name" "$thumb" "$img"
  done
}

selection_idx=$(list_wallpapers | rofi -dmenu -show-icons -format 'i' -theme-str 'element-icon { size: 150px; }' -p "󰸉  WALLPAPERS")

if [[ -n "$selection_idx" && "$selection_idx" -ge 0 ]]; then
  set_wallpaper "${ALL_FILES[$selection_idx]}"
fi
