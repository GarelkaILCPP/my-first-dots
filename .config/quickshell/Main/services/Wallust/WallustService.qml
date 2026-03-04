pragma Singleton
import QtQuick
import Quickshell.Io // Импортируем нативный модуль ввода-вывода Quickshell

QtObject {
    id: root

    // Дефолтные значения (оставляем как было)
    property var colors: ({
        "background": "#101010", "foreground": "#BDBDBD", "cursor": "#747474",
        "color0": "#383838", "color1": "#242424", "color2": "#2B2B2B", "color3": "#313131",
        "color4": "#373737", "color5": "#3D3D3D", "color6": "#434343", "color7": "#989999",
        "color8": "#6B6B6B", "color9": "#242424", "color10": "#2B2B2B", "color11": "#313131",
        "color12": "#373737", "color13": "#3D3D3D", "color14": "#434343", "color15": "#989999"
    })

    property FileView wallustReader: FileView {
        path: "/home/george/.config/quickshell/Main/services/Wallust/wallust-colors.json" 
        

        // 2. Как только файл изменился — перезагружаем его содержимое
        onFileChanged: reload()
        
        // Когда reload() закончит работу, loaded снова станет true, и этот блок отработает заново
        onLoadedChanged: {
            if (loaded) {
                try {
                    var jsonString = text();
                    var json = JSON.parse(jsonString);
                    var newDict = {};

                    if (json.special) {
                        for (var skey in json.special) {
                            newDict[skey] = json.special[skey];
                        }
                    }
                    
                    if (json.colors) {
                        for (var ckey in json.colors) {
                            newDict[ckey] = json.colors[ckey];
                        }
                    }

                    // Атомарно обновляем словарь
                    root.colors = newDict;
                } catch(e) {
                    console.error("Quickshell Wallust Parser Error:", e);
                }
            }
        }
    }
}