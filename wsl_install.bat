@echo off
echo Installing WSL components...

:: Set TLS 1.2
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12"

:: Reset network settings
netsh winsock reset
netsh int ip reset
ipconfig /flushdns

:: Reset certificates
certutil -setreg chain\ChainCacheResyncFiletime @now
certutil -setreg chain\ChainEngine\ValidationUrlCache\Flush 1

:: Disable WSL features
dism.exe /online /disable-feature /featurename:Microsoft-Windows-Subsystem-Linux /norestart
dism.exe /online /disable-feature /featurename:VirtualMachinePlatform /norestart

:: Enable WSL features
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

:: Download WSL update package
powershell -Command "Invoke-WebRequest -Uri 'https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2023/05/wsl_update_x64_5d0db366.msi' -OutFile 'wsl_update_x64.msi' -UseBasicParsing"

:: Install WSL update package
msiexec /i wsl_update_x64.msi /qn

:: Set WSL 2 as default
wsl --set-default-version 2

echo Installation complete. Please restart your computer.
pause 