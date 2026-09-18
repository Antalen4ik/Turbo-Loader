<!-- ::-
@echo off
chcp 65001 > nul
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\elevate.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0""", "", "runas", 1 >> "%temp%\elevate.vbs"
    start "" wscript.exe "%temp%\elevate.vbs"
    exit /b
)
if exist "%temp%\elevate.vbs" del /q "%temp%\elevate.vbs"
if not exist "%userprofile%\Desktop\sites.txt" (
    echo https://youtube.com> "%userprofile%\Desktop\sites.txt"
    echo https://vk.com>> "%userprofile%\Desktop\sites.txt"
    echo https://discord.com>> "%userprofile%\Desktop\sites.txt"
)
start "" mshta.exe "%~f0"
exit
-->
<html>
<head>
<title>Turbo Loader v5.5</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=9">
<hta:application id="oHTA" applicationname="TurboLoader" border="thick" borderstyle="normal" caption="yes" contextmenu="no" innerborder="no" maximizebutton="no" minimizebutton="yes" navigable="no" scroll="no" scrollflat="no" singleinstance="yes" sysmenu="yes" version="5.5" windowstate="normal"/>
<style>
    body { margin: 0; padding: 0; height: 100%; width: 100%; font-family: 'Segoe UI', sans-serif; color: #ffffff; overflow: hidden; background-color: #121212; }
    .wrapper { padding: 15px; box-sizing: border-box; }
    .header { font-size: 16px; font-weight: bold; color: #00ff99; text-align: center; border-bottom: 2px solid rgba(255, 255, 255, 0.1); padding-bottom: 8px; margin-bottom: 15px; }
    .status { font-size: 13px; color: #cccccc; text-align: center; margin-bottom: 12px; height: 18px; }
    .btn-container { width: 100%; }
    .btn { width: 100%; height: 34px; border: 1px solid rgba(255, 255, 255, 0.1); font-size: 11px; font-weight: bold; cursor: pointer; margin-bottom: 6px; border-radius: 4px; outline: none; color: white; background-color: #0078d7; }
    .btn:hover { filter: brightness(1.2); }
    .btn-ram { background-color: #c82828; }
    .btn-rat { background-color: #d16d00; }
    .btn-net { background-color: #008855; }
    .btn-edit { background-color: #555555; margin-top: 5px; }
</style>
<script language="JavaScript">
    window.resizeTo(360, 510); 
    window.moveTo((screen.width - 360) / 2, (screen.height - 510) / 2);

    function LaunchSites() {
        var status = document.getElementById("statusText");
        status.innerHTML = "Запуск любимых сайтов...";
        try {
            var shell = new ActiveXObject("WScript.Shell");
            var fso = new ActiveXObject("Scripting.FileSystemObject");
            var desktopPath = shell.SpecialFolders("Desktop") + "\\sites.txt";
            if (fso.FileExists(desktopPath)) {
                var file = fso.OpenTextFile(desktopPath, 1);
                while (!file.AtEndOfStream) {
                    var url = file.ReadLine().replace(/^\s+|\s+$/g, '');
                    if (url != "") { shell.Run('cmd.exe /c start "" "' + url + '"', 0, false); }
                }
                file.Close();
                status.innerHTML = "Сайты запущенные!";
            }
        } catch(e) {}
    }

    function CleanRAM() {
        var status = document.getElementById("statusText");
        status.innerHTML = "ГЛУБОКАЯ ОЧИСТКА (ТУРБО)...";
        try {
            var shell = new ActiveXObject("WScript.Shell");
            shell.Run('reg add "HKCU\\Control Panel\\Accessibility\\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f', 0, true);
            shell.Run('reg add "HKCU\\Control Panel\\Accessibility\\KeyboardResponse" /v "Flags" /t REG_SZ /d "122" /f', 0, true);
            shell.Run("cmd.exe /c sc stop DiagTrack & sc config DiagTrack start= disabled", 0, true);
            shell.Run("cmd.exe /c sc stop dmwappushservice & sc config dmwappushservice start= disabled", 0, true);
            shell.Run('reg add "HKLM\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Power" /v "HpetPresent" /t REG_DWORD /d 0 /f', 0, true);
            shell.Run('reg add "HKCU\\System\\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f', 0, true);
            shell.Run('reg add "HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f', 0, true);
            var targets = ["discord.exe", "steam.exe", "tg.exe", "telegram.exe", "mediaget.exe", "vlc.exe", "obs64.exe", "capcut.exe"];
            for (var i = 0; i < targets.length; i++) { shell.Run("taskkill /f /im " + targets[i], 0, false); }
            shell.Run('cmd.exe /c del /q /f /s "%temp%\\*.*"', 0, true);
            shell.Run('cmd.exe /c del /q /f /s "%systemroot%\\Temp\\*.*"', 0, true);
            shell.Run('cmd.exe /c del /q /f /s "%systemroot%\\Prefetch\\*.*"', 0, true);
            shell.Run("taskkill /f /im explorer.exe", 0, true);
            shell.Run("explorer.exe", 1, false);
            status.innerHTML = "ПК бустанут! Твики применены!";
        } catch(e) {}
    }

    function CleanBrowsersAndTrash() {
        var status = document.getElementById("statusText");
        status.innerHTML = "Очистка корзины и журналов...";
        try {
            var shell = new ActiveXObject("WScript.Shell");
            shell.Run('cmd.exe /c rd /s /q %systemdrive%\\$Recycle.bin', 0, true);
            shell.Run('cmd.exe /c del /q /f /s "%localappdata%\\Google\\Chrome\\User Data\\Default\\Cache\\*.*"', 0, false);
            shell.Run('cmd.exe /c del /q /f /s "%localappdata%\\Yandex\\YandexBrowser\\User Data\\Default\\Cache\\*.*"', 0, false);
            shell.Run('cmd.exe /c del /q /f /s "%localappdata%\\Opera Software\\Opera Stable\\Cache\\*.*"', 0, false);
            shell.Run('cmd.exe /c for /F "tokens=*" %1 in (\'wevtutil.exe el\') do wevtutil.exe cl "%1"', 0, false);
            status.innerHTML = "Корзина, кэш и журналы очищены!";
        } catch(e) {}
    }

    function CleanStartup() {
        var status = document.getElementById("statusText");
        status.innerHTML = "Очистка автозагрузки...";
        try {
            var shell = new ActiveXObject("WScript.Shell");
            shell.Run('cmd.exe /c del /q /f "%appdata%\\Microsoft\\Windows\\Start Menu\\Programs\\Startup\\*.*"', 0, true);
            shell.Run('cmd.exe /c del /q /f "%programdata%\\Microsoft\\Windows\\Start Menu\\Programs\\Startup\\*.*"', 0, true);
            shell.Run('cmd.exe /c reg query HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Run /s > "%userprofile%\\Desktop\\startup_report.txt"', 0, true);
            shell.Run('cmd.exe /c reg query HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Run /s >> "%userprofile%\\Desktop\\startup_report.txt"', 0, true);
            status.innerHTML = "Автозагрузка очищена! Отчет на столе.";
        } catch(e) {}
    }

    function HardLockPorts() {
        var status = document.getElementById("statusText");
        status.innerHTML = "Блокировка портов RDP/SMB...";
        try {
            var shell = new ActiveXObject("WScript.Shell");
            shell.Run('cmd.exe /c netsh advfirewall firewall add rule name="Block_RDP" dir=in action=block protocol=TCP localport=3389', 0, true);
            shell.Run('cmd.exe /c netsh advfirewall firewall add rule name="Block_SMB" dir=in action=block protocol=TCP localport=445', 0, true);
            status.innerHTML = "Порты 3389 и 445 закрыты!";
        } catch(e) {}
    }

    function KillInternet() {
        try {
            var shell = new ActiveXObject("WScript.Shell");
            shell.Run("ipconfig /release", 0, false);
            alert("ИНТЕРНЕТ ОТКЛЮЧЕН! Сеть сброшена.");
        } catch(e) {}
    }

    function RestoreInternet() {
        var status = document.getElementById("statusText");
        status.innerHTML = "Восстановление сети...";
        try {
            var shell = new ActiveXObject("WScript.Shell");
            shell.Run("ipconfig /renew", 0, false);
            status.innerHTML = "Сеть восстановлена!";
        } catch(e) { status.innerHTML = "Ошибка сети!"; }
    }

    function EditSites() {
        try {
            var shell = new ActiveXObject("WScript.Shell");
            shell.Run("notepad.exe sites.txt", 1, false);
        } catch(e) { alert("Не удалось открыть список сайтов!"); }
    }
</script>
</head>
<body>
<div class="wrapper">
    <div class="header">SYSTEM AUTOMATION by antalenn v5.5</div>
    <div class="status" id="statusText">Система готова к работе v5.5</div>
    <div class="btn-container">
        <button class="btn" onclick="LaunchSites()">ЗАПУСТИТЬ ЛЮБИМЫЕ САЙТЫ</button>
        <button class="btn btn-ram" onclick="CleanRAM()">ГЛУБОКАЯ ОЧИСТКА (ТУРБО)</button>
        <button class="btn btn-ram" onclick="CleanBrowsersAndTrash()">ОЧИСТИТЬ КОРЗИНУ И КЭШ БРАУЗЕРОВ</button>
        <button class="btn" onclick="CleanStartup()">ОЧИСТИТЬ АВТОЗАГРУЗКУ WINDOWS</button>
        <button class="btn btn-rat" onclick="HardLockPorts()">БЛОКИРОВАТЬ ПОРТЫ УПРАВЛЕНИЯ</button>
        <button class="btn btn-rat" onclick="KillInternet()">СПАСИ ОТ РАТНИКА</button>
        <button class="btn btn-net" onclick="RestoreInternet()">ВЕРНУТЬ ИНТЕРНЕТ (RENEW NET)</button>
        <button class="btn btn-edit" onclick="EditSites()">НАСТРОИТЬ СПИСОК САЙТОВ</button>
    </div>
</div>
</body>
</html>
