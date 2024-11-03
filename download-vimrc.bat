@echo off
setlocal

:: Set variables
set "url=https://raw.githubusercontent.com/tobin-ford/Dev-Tools/refs/heads/main/Kestrel-Resources/.vimrc"  :: Replace with your download link
set "output-home=C:\Users\tobinford\_vimrc"  :: Replace with your desired output path

set "vimfilesDir=C:\Users\tobinford\vimfiles"  :: Change to %USERPROFILE%\vimfiles if preferred
set "colorsDir=%vimfilesDir%\colors"
set "gruvboxZip=https://github.com/morhetz/gruvbox/archive/refs/tags/v2.0.0.zip"
set "gruvboxOutput=%TEMP%\gruvbox.zip"


:: Download the file, overwriting if it exists
echo Downloading file...
powershell -Command "Invoke-WebRequest -Uri '%url%' -OutFile '%output%'"

:: Check if the download was successful
if exist "%output%" (
    echo Download successful.
    echo File installed to: "%output%"
) else (
    echo Download failed.
)

:: Create directories for vimfiles and colors
echo Creating directories...
if not exist "%vimfilesDir%" (
    mkdir "%vimfilesDir%"
)
if not exist "%colorsDir%" (
    mkdir "%colorsDir%"
)

:: Download the Gruvbox zip file
echo Downloading Gruvbox color scheme...
powershell -Command "Invoke-WebRequest -Uri '%gruvboxZip%' -OutFile '%gruvboxOutput%'"

:: Check if the download was successful
if exist "%gruvboxOutput%" (
    echo Gruvbox download successful.
    
    :: Unzip the Gruvbox color scheme
    echo Unzipping Gruvbox...
    powershell -Command "Expand-Archive -Path '%gruvboxOutput%' -DestinationPath '%TEMP%\gruvbox'"

    :: Move the colors to the colors directory
    echo Installing Gruvbox colors...
    move /Y "%TEMP%\gruvbox\gruvbox-2.0.0\colors\gruvbox.vim" "%colorsDir%\gruvbox.vim"
    
    echo Gruvbox color scheme installed to: "%colorsDir%"
) else (
    echo Gruvbox download failed.
)

:: Clean up
if exist "%gruvboxOutput%" (
    del "%gruvboxOutput%"
)
if exist "%TEMP%\gruvbox" (
    rmdir /S /Q "%TEMP%\gruvbox"
)

:: CREATE VIM ALIASES FOR POWERSHELL
echo Creating PowerShell aliases...
powershell -Command "Set-alias vim 'C:\Program Files (x86)\vim\vim80\gvim.exe'"
powershell -Command "Set-alias vi 'C:\Program Files (x86)\vim\vim80\gvim.exe'"

endlocal
pause