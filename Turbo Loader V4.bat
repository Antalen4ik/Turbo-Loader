<!-- ::-
@echo off
chcp 65001 > nul

:: Проверка прав администратора
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Для работы геймерских твиков запустите скрипт от Администратора!
    pause
    exit
)

if not exist sites.txt (
    echo https://youtube.com> sites.txt
    echo https://vk.com>> sites.txt
    echo https://discord.com>> sites.txt
    echo https://google.com>> sites.txt
    echo https://itorrents-igruha.org>> sites.txt
    echo https://yandex.ru>> sites.txt
)

start "" mshta.exe "%~f0"
exit
-->

<html>
<head>
<title>Turbo Loader v5.3</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<style>
    html, body {
        margin: 0;
        padding: 0;
        height: 100%;
        width: 100%;
        font-family: 'Segoe UI', sans-serif;
        color: #ffffff;
        overflow: hidden;
        background-color: #121212;
    }

    .wrapper {
        padding: 15px;
        box-sizing: border-box;
        display: flex;
        flex-direction: column;
        height: 100%;
    }
    .header {
        font-size: 18px;
        font-weight: bold;
        color: #00ff99;
        text-align: center;
        border-bottom: 2px solid rgba(255, 255, 255, 0.1);
        padding-bottom: 8px;
        margin-bottom: 15px;
        flex-shrink: 0;
        text-shadow: 0 0 10px rgba(0, 255, 153, 0.5);
    }

    .status {
        font-size: 13px;
        color: #cccccc;
        text-align: center;
        margin-bottom: 15px;
        flex-shrink: 0;
    }
    .btn-container {
        display: flex;
        flex-direction: column;
        gap: 8px;
        flex-grow: 1;
    }
    .btn {
        width: 100%;
        height: 38px;
        background-color: #0078d7;
        color: white;
        border: 1px solid rgba(255, 255, 255, 0.1);
        font-size: 13px;
        font-weight: bold;
        cursor: pointer;
        border-radius: 4px;
        transition: background-color 0.2s;
    }
    .btn:hover {
        background-color: #1e90ff;
        border-color: #00ff99;
    }
    .btn-ram { background-color: #c82828; }
    .btn-ram:hover { background-color: #e64646; }
    
    .btn-rat { background-color: #d16d00; }
    .btn-rat:hover { background-color: #f58100; border-color: #ff3333; }
    
    .btn-edit { background-color: #555555; }
    .btn-edit:hover { background-color: #777777; }
</style>

<script language="JavaScript">
    // Фиксированный компактный размер окна без изменений геометрии
    window.resizeTo(460, 320);
    window.moveTo((screen.width - 460) / 2, (screen.height - 320) / 2);

    function LaunchSites() {
        var status = document.getElementById("statusText");
        status.innerHTML = "Запуск любимых сайтов...";
        status.style.color = "#00ff99";
        
        try {
            var shell = new ActiveXObject("WScript.Shell");
            var fso = new ActiveXObject("Scripting.FileSystemObject");
            
            if (fso.FileExists("sites.txt")) {
                var file = fso.OpenTextFile("sites.txt", 1);
                while (!file.AtEndOfStream) {
                    var url = file.ReadLine().replace(/^\s+|\s+$/g, '');
                    if (url !== "") {
                        shell.Run('cmd.exe /c start "" "' + url + '"', 0, false);
                    }
                }
                file.Close();
                status.innerHTML = "Сайты успешно запущены!";
            }
        } catch(e) {
            status.innerHTML = "Ошибка запуска сайтов!";
            status.style.color = "#ff3333";
        }
    }

    function CleanRAM() {
        var status = document.getElementById("statusText");
        status.innerHTML = "РЕЖИМ ТУРБО: Применение полного пакета твиков...";
        status.style.color = "#ff9900";
        
        try {
            var shell = new ActiveXObject("WScript.Shell");
            
            // 1. ОТКЛЮЧЕНИЕ ЗАЛИПАНИЯ КЛАВИШ (Shift)
            try {
                shell.Run('reg add "HKCU\\Control Panel\\Accessibility\\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f', 0, true);
                shell.Run('reg add "HKCU\\Control Panel\\Accessibility\\KeyboardResponse" /v "Flags" /t REG_SZ /d "122" /f', 0, true);
            } catch(e) {}

            // 2. ОТКЛЮЧЕНИЕ XBOX GAME BAR (DVR)
            try {
                shell.Run('reg add "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f', 0, true);
            } catch(e) {}

            // 3. ОТКЛЮЧЕНИЕ ТЕЛЕМЕТРИИ И СЛЕЖКИ WINDOWS
            try {
                shell.Run("cmd.exe /c sc stop DiagTrack & sc config DiagTrack start= disabled", 0, true);
                shell.Run("cmd.exe /c sc stop dmwappushservice & sc config dmwappushservice start= disabled", 0, true);
            } catch(e) {}

            // 4. БУСТ ПРОЦЕССОРА (Оптимизация схемы питания ЦП)
            try {
                shell.Run("powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c", 0, true);
            } catch(e) {}

            // 5. ЗАКРЫТИЕ ТЯЖЕЛОГО ФОНОВОГО МУСОРА
            var targets = ["discord.exe", "steam.exe", "tg.exe", "telegram.exe", "mediaget.exe", "vlc.exe", "obs64.exe", "capcut.exe"];
            for (var i = 0; i < targets.length; i++) {
                try { shell.Run("taskkill /f /im " + targets[i], 0, false); } catch(e) {}
            }
            
            // 6. ОЧИСТКА ВНУТРЕННИХ ПРОЦЕССОВ ЧЕРЕЗ WMI
            try {
                var wmi = GetObject("winmgmts:\\\\.\\root\\cimv2");
                var processes = wmi.ExecQuery("Select * from Win32_Process");
                var enumItems = new Enumerator(processes);
                var whitelist = " explorer.exe mshta.exe svchost.exe taskmgr.exe wininit.exe winlogon.exe csrss.exe services.exe lsass.exe spoolsv.exe nvcontainer.exe cmd.exe chrome.exe browser.exe msedge.exe opera.exe firefox.exe ";

                for (; !enumItems.atEnd(); enumItems.moveNext()) {
                    var p = enumItems.item();
                    var pName = p.Name.toLowerCase();
                    if (whitelist.indexOf(" " + pName + " ") === -1) {
                        try { p.Terminate(); } catch(err) {}
                    }
                }
            } catch(wmiError) {}
            
            // 7. УДАЛЕНИЕ МУСОРА ИЗ ПАПОК TEMP И PREFETCH
            try {
                shell.Run('cmd.exe /c del /q /f /s "%temp%\\*.*"', 0, true);
                shell.Run('cmd.exe /c rmdir /s /q "%temp%" & mkdir "%temp%"', 0, true);
                shell.Run('cmd.exe /c del /q /f /s "%systemroot%\\Temp\\*.*"', 0, true);
                shell.Run('cmd.exe /c del /q /f /s "%systemroot%\\Prefetch\\*.*"', 0, true);
            } catch(tempErr) {}

            // Перезапуск проводника Windows
            shell.Run("taskkill /f /im explorer.exe", 0, true);
            shell.Run("explorer.exe", 1, false);
            
            status.innerHTML = "ПК бустанут! Твики применены, мусор удален!";
            status.style.color = "#00ff99";
        } catch(e) {
            status.innerHTML = "Ошибка выполнения очистки!";
            status.style.color = "#ff3333";
        }
    }

    function KillInternet() {
        var status = document.getElementById("statusText");
        status.innerHTML = "СПАСИ ОТ РАТНИКА: Сеть полностью заблокирована!";
        status.style.color = "#ff3333";
        try {
            var shell = new ActiveXObject("WScript.Shell");
            shell.Run("ipconfig /release", 0, false);
            alert("ИНТЕРНЕТ ОТКЛЮЧЕН! Сеть сброшена.");
        } catch(e) {}
    }

    function EditSites() {
        try {
            var shell = new ActiveXObject("WScript.Shell");
            shell.Run("notepad.exe sites.txt", 1, false);
        } catch(e) {
            alert("Не удалось открыть список сайтов!");
        }
    }
</script>
</head>

<body>

<div class="wrapper">
    <div class="header">SYSTEM AUTOMATION by antalenn v5.3</div>
    
    <div class="status" id="statusText">Система готова к работе v5.3</div>
    
    <div class="btn-container">
        <button class="btn" onclick="LaunchSites()">ЗАПУСТИТЬ ЛУБИМЫЕ САЙТЫ</button>
        <button class="btn btn-ram" onclick="CleanRAM()">ГЛУБОКАЯ ОЧИСТКА (ТУРБО)</button>
        <button class="btn btn-rat" onclick="KillInternet()">СПАСИ ОТ РАТНИКА ⚠</button>
        <button class="btn btn-edit" onclick="EditSites()">НАСТРОИТЬ СПИСОК САЙТОВ</button>
    </div>
</div>

</body>
</html>
