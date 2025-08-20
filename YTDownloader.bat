::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFCFxdi2sFESGVZFcx+rx6umTsXEkYMYwb4HX1bWKHMwc7UqqfJUitg==
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
title YOUTUBE DOWNLOADER

:menu
cls
echo ===============================
echo        YOUTUBE DOWNLOADER
echo ===============================
echo 1. 🎬Baixar VÍDEO (link)
echo 2. 🎧Baixar ÁUDIO (MP3, link)
echo 3. 🔍Pesquisar no YouTube (navegador)
echo 4. 🔎Buscar e baixar 1° resultado (vídeo)
echo 5. 🔁Converter ÁUDIO local
echo 6. 🎞️Converter VÍDEO local
echo 7. 📂Abrir pasta de downloads
echo 8. 🧾Ver histórico de downloads
echo 9. ⏬Baixar o ffmpeg (essencial)
echo 10. ❌Sair
echo ===============================
set /p opcao=Escolha uma opção (1-10): 

if "%opcao%"=="1" goto baixarvideo
if "%opcao%"=="2" goto baixaraudio
if "%opcao%"=="3" goto pesquisar
if "%opcao%"=="4" goto buscarbaixar
if "%opcao%"=="5" goto converteraudio
if "%opcao%"=="6" goto convertervideo
if "%opcao%"=="7" start "" "C:\Users\ZEZINHO\3D Objects\YTDownload\YTDownloads"
if "%opcao%"=="8" goto verhistorico
if "%opcao%"=="9" goto instalarffmpeg
if "%opcao%"=="10" goto sair
goto menu

:baixarvideo
cls
set /p link=Cole o link do vídeo: 
echo.
echo Escolha a qualidade desejada:
echo 1. Alta (1080p ou o máximo)
echo 2. Média (720p)
echo 3. Baixa (360p)
set /p q=Qualidade (1-3): 

if "%q%"=="1" set qual=-f "bv*+ba/b"
if "%q%"=="2" set qual=-f "bestvideo[height<=720]+bestaudio/best[height<=720]"
if "%q%"=="3" set qual=-f "bestvideo[height<=360]+bestaudio/best[height<=360]"

yt-dlp.exe -P "YTDownloads\Video" %qual% %link%
echo [%date% %time%] 🎬 VIDEO: %link% (qual %q%) >> YTDownloads\log.txt
pause
goto menu

:baixaraudio
cls
set /p link=Cole o link do vídeo: 
yt-dlp.exe --extract-audio --audio-format mp3 -o "%%(title)s.%%(ext)s" -P "YTDownloads\Audio" %link%
echo [%date% %time%] 🎧 AUDIO: %link% >> YTDownloads\log.txt
pause
goto menu

:pesquisar
cls
set /p termo=Digite o que deseja pesquisar: 
start https://www.youtube.com/results?search_query=%termo%
goto menu

:buscarbaixar
cls
set /p termo=Digite o que deseja buscar e baixar: 
yt-dlp.exe -P "YTDownloads\Video" "ytsearch:%termo%"
echo [%date% %time%] 🎬 VIDEO (ytsearch): %termo% >> YTDownloads\log.txt
pause
goto menu

:converteraudio
cls
echo Converter arquivo local (necessário ffmpeg.exe instalado)
echo.
set /p arquivo=Digite o caminho do arquivo: 
set "arquivo=%arquivo%"
echo.
echo Escolha o formato de saída:
echo 1. MP3
echo 2. WAV
echo 3. AAC
set /p fmt=Formato (1-3): 

if "%fmt%"=="1" set ext=mp3
if "%fmt%"=="2" set ext=wav
if "%fmt%"=="3" set ext=aac

if not exist "!arquivo!" (
    echo Arquivo não encontrado. Verifique o caminho digitado.
    pause
    goto menu
)
for %%a in ("%arquivo%") do set nomebase=%%~na
ffmpeg -i "!arquivo!" "YTDownloads\Audio\converted_!nomebase!.%ext%"
echo [%date% %time%] 🔁 CONVERT: %arquivo% -> %ext% >> YTDownloads\log.txt
pause
goto menu

:instalarffmpeg
cls
echo Instalando o ffmpeg pelo winget...
echo (É necessário internet e o Windows Package Manager)
pause
winget install ffmpeg
pause
goto menu

:convertervideo
cls
echo Converter vídeo local (necessário ffmpeg.exe instalado)
echo.
set /p entrada=Digite o caminho do arquivo de vídeo: 

REM força as aspas se não houver
set "arquivo=%entrada:"=%"
set "arquivo="%arquivo%""

if not exist %arquivo% (
    echo.
    echo ❌ Arquivo não encontrado: %arquivo%
    pause
    goto menu
)

echo.
echo Escolha o formato de saída:
echo 1. MP4
echo 2. MKV
echo 3. AVI
echo 4. MOV
set /p fmt=Formato (1-4): 

if "%fmt%"=="1" set ext=mp4
if "%fmt%"=="2" set ext=mkv
if "%fmt%"=="3" set ext=avi
if "%fmt%"=="4" set ext=mov

for %%a in (%arquivo%) do set "nomebase=%%~na"
ffmpeg -i %arquivo% "YTDownloads\Video\converted_!nomebase!.%ext%"
echo [%date% %time%] 🎞️ CONVERT VIDEO: %arquivo% -> %ext% >> YTDownloads\log.txt
pause
goto menu

:verhistorico
cls
if exist YTDownloads\log.txt (
    type YTDownloads\log.txt
) else (
    echo Nenhum download registrado ainda.
)
pause
goto menu

:sair
exit
