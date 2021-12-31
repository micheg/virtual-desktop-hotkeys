@echo off
:: Markus Scholtes, 2021
:: Compile VirtualDesktop in .Net 4.x environment
setlocal

C:\Windows\Microsoft.NET\Framework\v4.0.30319\csc.exe "%~dp0VirtualDesktop11.cs"
C:\Windows\Microsoft.NET\Framework\v4.0.30319\csc.exe "%~dp0IconCreator.cs"

:: was batch started in Windows Explorer? Yes, then pause
echo "%CMDCMDLINE%" | find /i "/c" > nul
if %ERRORLEVEL%==0 pause
