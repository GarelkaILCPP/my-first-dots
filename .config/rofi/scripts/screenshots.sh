option=$(printf "Screen\nWindow\nRegion" | rofi -dmenu -p "What need screenshot?")

case "$option" in
    "Screen") hyprshot -m output -o $HOME/Pictures ;;
    "Window") hyprshot -m window -o $HOME/Pictures ;;
    "Region") hyprshot -m region -o $HOME/Pictures ;;
esac
