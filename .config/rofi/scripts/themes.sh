#!/usr/bin/env bash

# === Настройки ===
# Укажи полный путь к своей папке с обоями
DIR="$HOME/Pictures/wallpapers"

# Проверяем, существует ли директория
if [[ ! -d "$DIR" ]]; then
    echo "Ошибка: Папка $DIR не найдена!"
    exit 1
fi

# === Подготовка списка для Rofi ===
# Ищем картинки (без вложенных папок, чтобы не сломать пути)
# Формат Rofi dmenu для иконок: Текст\0icon\x1fПолный_путь_к_файлу
ROFI_INPUT=""
while IFS= read -r file; do
    # Пропускаем пустые строки, если файлов нет
    [[ -z "$file" ]] && continue 
    
    filename=$(basename "$file")
    ROFI_INPUT+="${filename}\0icon\x1f${file}\n"
done < <(find "$DIR" -maxdepth 1 -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \))

# Проверка, есть ли картинки
if [[ -z "$ROFI_INPUT" ]]; then
    notify-send "Ошибка" "В папке $DIR нет картинок (png/jpg/jpeg)!"
    exit 1
fi

# === Выбор обоев через Rofi ===
# -theme-str переопределяет тему на лету, делая из обычного списка "плитку" с большими иконками
CHOICE=$(echo -en "$ROFI_INPUT" | rofi -dmenu -i -show-icons -p "  Wallpaper" \
    -theme-str 'listview { columns: 4; lines: 3; flow: horizontal; } element { orientation: vertical; } element-icon { size: 8ch; } element-text { horizontal-align: 0.5; }' \
    -format "s")

# Если нажали Esc (ничего не выбрали)
if [[ -z "$CHOICE" ]]; then
    exit 0
fi

WALLPAPER="$DIR/$CHOICE"

# === Применение обоев и темы ===
# Убеждаемся, что swww-daemon запущен (для Wayland)
swww query || swww-daemon &
sleep 0.1 # Небольшая пауза, если демон только что запустился

# 1. Меняем обои с красивой анимацией "wipe"
swww img "$WALLPAPER" --transition-type outer --transition-pos 0.99,0.99 --transition-step 120

# 2. Генерируем палитру и применяем тему через wallust
wallust run "$WALLPAPER"

pkill qs
qs -c Main

# Опционально: уведомление об успехе

