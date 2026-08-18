<!-- ::-
@echo off
chcp 65001 > nul

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
<title>Turbo Loader v4.0</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<style>
    html, body {
        margin: 0;
        padding: 0;
        height: 100%;
        font-family: 'Segoe UI', sans-serif;
        color: #ffffff;
        overflow: hidden;
        background-color: #121212;
        -webkit-animation: pulseBg 8s ease-in-out infinite;
        animation: pulseBg 8s ease-in-out infinite;
    }

    @-webkit-keyframes pulseBg {
        0% { background-color: #111116; }
        50% { background-color: #1a1a26; }
        100% { background-color: #111116; }
    }
    @keyframes pulseBg {
        0% { background-color: #111116; }
        50% { background-color: #1a1a26; }
        100% { background-color: #111116; }
    }

    /* Экран загрузки */
    .intro-screen {
        position: absolute;
        top: 0; left: 0; width: 100%; height: 100%;
        background-color: #121212;
        display: flex;
        justify-content: center;
        align-items: center;
        z-index: 9999;
        -webkit-animation: fadeOutIntro 0.5s ease-in-out 2.5s forwards;
        animation: fadeOutIntro 0.5s ease-in-out 2.5s forwards;
    }

    .intro-text {
        font-size: 32px;
        font-weight: bold;
        color: #00ff99;
        text-transform: uppercase;
        letter-spacing: 4px;
        text-shadow: 0 0 15px rgba(0, 255, 153, 0.6);
        opacity: 0;
        -webkit-animation: fadeInText 1.5s ease-in-out 0.2s forwards;
        animation: fadeInText 1.5s ease-in-out 0.2s forwards;
    }

    @keyframes fadeInText {
        0% { opacity: 0; transform: scale(0.9); }
        100% { opacity: 1; transform: scale(1); }
    }
    @-webkit-keyframes fadeInText {
        0% { opacity: 0; -webkit-transform: scale(0.9); }
        100% { opacity: 1; -webkit-transform: scale(1); }
    }

    @keyframes fadeOutIntro {
        0% { opacity: 1; visibility: visible; }
        100% { opacity: 0; visibility: hidden; }
    }
    @-webkit-keyframes fadeOutIntro {
        0% { opacity: 1; visibility: visible; }
        100% { opacity: 0; visibility: hidden; }
    }

    /* Главный интерфейс */
    .wrapper {
        padding: 20px;
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
        padding-bottom: 10px;
        margin-bottom: 15px;
        flex-shrink: 0;
        text-shadow: 0 0 10px rgba(0, 255, 153, 0.5);
    }
    .status {
        font-size: 14px;
        color: #cccccc;
        text-align: center;
        margin-bottom: 20px;
        flex-shrink: 0;
    }
    .btn-container {
        display: flex;
        flex-direction: column;
        flex-grow: 1;
        justify-content: space-between;
    }
    .btn {
        width: 100%;
        flex-grow: 1;
        background-color: #0078d7;
        color: white;
        border: 1px solid rgba(255, 255, 255, 0.1);
        padding: 12px;
        font-size: 14px;
        font-weight: bold;
        margin-bottom: 12px;
        cursor: pointer;
        border-radius: 4px;
        transition: background-color 0.2s;
    }
    .btn:hover {
        background-color: #1e90ff;
        border-color: #00ff99;
    }
    .btn-ram {
        background-color: #c82828;
    }
    .btn-ram:hover {
        background-color: #e64646;
    }
    .btn-edit {
        background-color: #555555;
        margin-bottom: 0;
    }
    .btn-edit:hover {
        background-color: #777777;
    }
</style>

<script language="JavaScript">
    // Настройка размеров окна при старте
    window.resizeTo(460, 450);
    window.moveTo((screen.width - 460) / 2, (screen.height - 450) / 2);

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
            } else {
                status.innerHTML = "Ошибка: файл sites.txt не найден!";
                status.style.color = "#ff3333";
            }
        } catch(e) {
            status.innerHTML = "Ошибка выполнения скрипта!";
            status.style.color = "#ff3333";
        }
    }

    function CleanRAM() {
        var status = document.getElementById("statusText");
        status.innerHTML = "Очистка ОЗУ (Перезапуск Проводника)...";
        status.style.color = "#ff9900";
        
        try {
            var shell = new ActiveXObject("WScript.Shell");
            shell.Run("taskkill /f /im explorer.exe", 0, true);
            shell.Run("explorer.exe", 1, false);
            
            status.innerHTML = "Оперативная память успешно очищена!";
            status.style.color = "#00ff99";
        } catch(e) {
            status.innerHTML = "Не удалось очистить ОЗУ!";
            status.style.color = "#ff3333";
        }
    }

    function EditSites() {
        try {
            var shell = new ActiveXObject("WScript.Shell");
            shell.Run("notepad.exe sites.txt", 1, false);
        } catch(e) {
            alert("Не удалось открыть Блокнот!");
        }
    }
</script>

<hta:application 
    id="turboLoader"
    applicationname="Turbo Loader"
    border="thick"
    maximizebutton="yes"
    minimizebutton="yes"
    scroll="no"
    singleinstance="yes"
    sysmenu="yes"
/>
</head>
<body>
    <!-- Экран загрузки с анимацией -->
    <div class="intro-screen">
        <div class="intro-text">antalenn</div>
    </div>

    <!-- Главное меню -->
    <div class="wrapper">
        <div class="header">SYSTEM AUTOMATION by antalenn</div>
        <div class="status" id="statusText">Система готова к работе v4.0</div>

        <div class="btn-container">
            <button class="btn" onclick="LaunchSites()">ЗАПУСТИТЬ ЛЮБИМЫЕ САЙТЫ</button>
            <button class="btn btn-ram" onclick="CleanRAM()">ЧИСТКА ОПЕРАТИВЫ</button>
            <button class="btn btn-edit" onclick="EditSites()">НАСТРОИТЬ СПИСОК САЙТОВ</button>
        </div>
    </div>
</body>
</html>