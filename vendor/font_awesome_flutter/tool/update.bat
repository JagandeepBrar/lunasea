@echo off

if exist icons.json (
    echo Custom icons.json found, using local data only.

    dart .\tool\generate_font.dart .\icons.json
    dart .\tool\generate_example.dart .\icons.json
) else (
    echo Updating free icons to newest version.
    pushd lib\fonts

    powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/FortAwesome/Font-Awesome/master/webfonts/fa-brands-400.ttf', 'fa-brands-400.ttf')"
    powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/FortAwesome/Font-Awesome/master/webfonts/fa-regular-400.ttf', 'fa-regular-400.ttf')"
    powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/FortAwesome/Font-Awesome/master/webfonts/fa-solid-900.ttf', 'fa-solid-900.ttf')"

    popd
    powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/FortAwesome/Font-Awesome/master/metadata/icons.json', 'icons.json')"

    dart .\tool\generate_font.dart .\icons.json
    dart .\tool\generate_example.dart .\icons.json
    del "icons.json" /f /q
)

dartfmt -w .\lib\font_awesome_flutter.dart & ^
dartfmt -w .\example\lib\icons.dart
