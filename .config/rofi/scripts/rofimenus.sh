option=$(printf "Apps\nWallpapers\nClipboard\nScreenshots" | rofi -dmenu -p "Choose one")

case "$option" in
	"Apps") rofi -show drun ;;
	"Wallpapers") $HOME/.config/rofi/scripts/themes.sh ;;
	"Clipboard") clipvault list | rofi -dmenu -p "Clipboard" -display-columns 2 | clipvault get | wl-copy ;;
	"Screenshots") $HOME/.config/rofi/scripts/screenshots.sh ;;
esac
