echo off
rem this file is part of installer for Notepad++
rem Copyright (C)2006 Don HO <don.h@free.fr>
rem 
rem This program is free software; you can redistribute it and/or
rem modify it under the terms of the GNU General Public License
rem as published by the Free Software Foundation; either
rem version 2 of the License, or (at your option) any later version.
rem 
rem This program is distributed in the hope that it will be useful,
rem but WITHOUT ANY WARRANTY; without even the implied warranty of
rem MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
rem GNU General Public License for more details.
rem 
rem You should have received a copy of the GNU General Public License
rem along with this program; if not, write to the Free Software
rem Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

echo on

if %SIGN% == 0 goto NoSign
signtool.exe sign /f %NPP_CERT% /p %NPP_CERT_PWD% /d "Notepad++" /du https://notepad-plus-plus.org/ /t http://timestamp.digicert.com/ ..\bin\notepad++.exe
If ErrorLevel 1 goto End
signtool.exe sign /f %NPP_CERT% /p %NPP_CERT_PWD% /d "Notepad++" /du https://notepad-plus-plus.org/ /t http://timestamp.digicert.com/ ..\bin64\notepad++.exe
If ErrorLevel 1 goto End
signtool.exe sign /f %NPP_CERT% /p %NPP_CERT_PWD% /d "Notepad++" /du https://notepad-plus-plus.org/ /t http://timestamp.digicert.com/ ..\bin\SciLexer.dll
If ErrorLevel 1 goto End
signtool.exe sign /f %NPP_CERT% /p %NPP_CERT_PWD% /d "Notepad++" /du https://notepad-plus-plus.org/ /t http://timestamp.digicert.com/ ..\bin64\SciLexer.dll
If ErrorLevel 1 goto End

signtool.exe sign /f %NPP_CERT% /p %NPP_CERT_PWD% /d "Notepad++" /du https://notepad-plus-plus.org/ /t http://timestamp.digicert.com/ ..\bin\NppShell_06.dll
If ErrorLevel 1 goto End
signtool.exe sign /f %NPP_CERT% /p %NPP_CERT_PWD% /d "Notepad++" /du https://notepad-plus-plus.org/ /t http://timestamp.digicert.com/ ..\bin\NppShell64_06.dll
If ErrorLevel 1 goto End

signtool.exe sign /f %NPP_CERT% /p %NPP_CERT_PWD% /d "Notepad++" /du https://notepad-plus-plus.org/ /t http://timestamp.digicert.com/ ..\bin\updater\GUP.exe
If ErrorLevel 1 goto End
signtool.exe sign /f %NPP_CERT% /p %NPP_CERT_PWD% /d "Notepad++" /du https://notepad-plus-plus.org/ /t http://timestamp.digicert.com/ ..\bin64\updater\GUP.exe
If ErrorLevel 1 goto End

signtool.exe sign /f %NPP_CERT% /p %NPP_CERT_PWD% /d "Notepad++" /du https://notepad-plus-plus.org/ /t http://timestamp.digicert.com/ ..\bin\updater\libcurl.dll
If ErrorLevel 1 goto End
signtool.exe sign /f %NPP_CERT% /p %NPP_CERT_PWD% /d "Notepad++" /du https://notepad-plus-plus.org/ /t http://timestamp.digicert.com/ ..\bin64\updater\libcurl.dll
If ErrorLevel 1 goto End

signtool.exe sign /f %NPP_CERT% /p %NPP_CERT_PWD% /d "Notepad++" /du https://notepad-plus-plus.org/ /t http://timestamp.digicert.com/ ..\bin\updater\gpup.exe
If ErrorLevel 1 goto End

signtool.exe sign /f %NPP_CERT% /p %NPP_CERT_PWD% /d "Notepad++" /du https://notepad-plus-plus.org/ /t http://timestamp.digicert.com/ ..\bin\plugins\NppExport.dll
If ErrorLevel 1 goto End
signtool.exe sign /f %NPP_CERT% /p %NPP_CERT_PWD% /d "Notepad++" /du https://notepad-plus-plus.org/ /t http://timestamp.digicert.com/ ..\bin\plugins\mimeTools.dll
signtool.exe sign /f %NPP_CERT% /p %NPP_CERT_PWD% /d "Notepad++" /du https://notepad-plus-plus.org/ /t http://timestamp.digicert.com/ ..\bin64\plugins\mimeTools.dll
If ErrorLevel 1 goto End
signtool.exe sign /f %NPP_CERT% /p %NPP_CERT_PWD% /d "Notepad++" /du https://notepad-plus-plus.org/ /t http://timestamp.digicert.com/ ..\bin\plugins\NppConverter.dll
signtool.exe sign /f %NPP_CERT% /p %NPP_CERT_PWD% /d "Notepad++" /du https://notepad-plus-plus.org/ /t http://timestamp.digicert.com/ ..\bin64\plugins\NppConverter.dll
If ErrorLevel 1 goto End
signtool.exe sign /f %NPP_CERT% /p %NPP_CERT_PWD% /d "Notepad++" /du https://notepad-plus-plus.org/ /t http://timestamp.digicert.com/ ..\bin\plugins\PluginManager.dll
If ErrorLevel 1 goto End

:NoSign


rmdir /S /Q .\build
mkdir .\build

rem Notepad++ minimalist package
rmdir /S /Q .\minimalist
mkdir .\minimalist

copy /Y ..\bin\license.txt .\minimalist\
If ErrorLevel 1 goto End
copy /Y ..\bin\readme.txt .\minimalist\
If ErrorLevel 1 goto End
copy /Y ..\bin\change.log .\minimalist\
If ErrorLevel 1 goto End
copy /Y ..\src\langs.model.xml .\minimalist\
If ErrorLevel 1 goto End
copy /Y ..\src\stylers.model.xml .\minimalist\
If ErrorLevel 1 goto End
copy /Y ..\src\contextMenu.xml .\minimalist\
If ErrorLevel 1 goto End
copy /Y ..\src\shortcuts.xml .\minimalist\
If ErrorLevel 1 goto End
copy /Y ..\bin\doLocalConf.xml .\minimalist\
If ErrorLevel 1 goto End
copy /Y ..\bin\"notepad++.exe" .\minimalist\
If ErrorLevel 1 goto End
copy /Y ..\bin\SciLexer.dll .\minimalist\
If ErrorLevel 1 goto End

rmdir /S /Q .\minimalist64
mkdir .\minimalist64

copy /Y ..\bin\license.txt .\minimalist64\
If ErrorLevel 1 goto End
copy /Y ..\bin\readme.txt .\minimalist64\
If ErrorLevel 1 goto End
copy /Y ..\bin\change.log .\minimalist64\
If ErrorLevel 1 goto End
copy /Y ..\src\langs.model.xml .\minimalist64\
If ErrorLevel 1 goto End
copy /Y ..\src\stylers.model.xml .\minimalist64\
If ErrorLevel 1 goto End
copy /Y ..\src\contextMenu.xml .\minimalist64\
If ErrorLevel 1 goto End
copy /Y ..\src\shortcuts.xml .\minimalist64\
If ErrorLevel 1 goto End
copy /Y ..\bin\doLocalConf.xml .\minimalist64\
If ErrorLevel 1 goto End
copy /Y ..\bin64\"notepad++.exe" .\minimalist64\
If ErrorLevel 1 goto End
copy /Y ..\bin64\SciLexer.dll .\minimalist64\
If ErrorLevel 1 goto End


rem Notepad++ Unicode package
rmdir /S /Q .\zipped.package.release

mkdir .\zipped.package.release
mkdir .\zipped.package.release\updater
mkdir .\zipped.package.release\localization
mkdir .\zipped.package.release\themes
mkdir .\zipped.package.release\plugins
mkdir .\zipped.package.release\plugins\APIs
mkdir .\zipped.package.release\plugins\Config
mkdir .\zipped.package.release\plugins\doc

rmdir /S /Q .\zipped.package.release64

mkdir .\zipped.package.release64
mkdir .\zipped.package.release64\updater
mkdir .\zipped.package.release64\localization
mkdir .\zipped.package.release64\themes
mkdir .\zipped.package.release64\plugins
mkdir .\zipped.package.release64\plugins\APIs
mkdir .\zipped.package.release64\plugins\Config
mkdir .\zipped.package.release64\plugins\doc

copy /Y ..\bin\license.txt .\zipped.package.release\
If ErrorLevel 1 goto End
copy /Y ..\bin\readme.txt .\zipped.package.release\
If ErrorLevel 1 goto End
copy /Y ..\bin\change.log .\zipped.package.release\
If ErrorLevel 1 goto End
copy /Y ..\src\langs.model.xml .\zipped.package.release\
If ErrorLevel 1 goto End
copy /Y ..\src\stylers.model.xml .\zipped.package.release\
If ErrorLevel 1 goto End
copy /Y ..\src\contextMenu.xml .\zipped.package.release\
If ErrorLevel 1 goto End
copy /Y ..\src\shortcuts.xml .\zipped.package.release\
If ErrorLevel 1 goto End
copy /Y ..\src\functionList.xml .\zipped.package.release\
If ErrorLevel 1 goto End
copy /Y ..\bin\doLocalConf.xml .\zipped.package.release\
If ErrorLevel 1 goto End
copy /Y ..\bin\"notepad++.exe" .\zipped.package.release\
If ErrorLevel 1 goto End
copy /Y ..\bin\SciLexer.dll .\zipped.package.release\
If ErrorLevel 1 goto End


rem Plugins
copy /Y "..\bin\plugins\NppExport.dll" .\zipped.package.release\plugins\
If ErrorLevel 1 goto End
copy /Y "..\bin\plugins\mimeTools.dll" .\zipped.package.release\plugins\
If ErrorLevel 1 goto End
copy /Y "..\bin\plugins\NppConverter.dll" .\zipped.package.release\plugins\
If ErrorLevel 1 goto End

copy /Y "..\bin64\plugins\mimeTools.dll" .\zipped.package.release64\plugins\
If ErrorLevel 1 goto End
copy /Y "..\bin64\plugins\NppConverter.dll" .\zipped.package.release64\plugins\
If ErrorLevel 1 goto End


rem plugins manager and its updater 
copy /Y "..\bin\plugins\PluginManager.dll" .\zipped.package.release\plugins\
If ErrorLevel 1 goto End
copy /Y "..\bin\updater\gpup.exe" .\zipped.package.release\updater\
If ErrorLevel 1 goto End


rem localizations
copy /Y ".\nativeLang\*.xml" .\zipped.package.release\localization\
If ErrorLevel 1 goto End
copy /Y ".\nativeLang\*.xml" .\zipped.package.release64\localization\
If ErrorLevel 1 goto End

rem files API
copy /Y ".\APIs\*.xml" .\zipped.package.release\plugins\APIs\
If ErrorLevel 1 goto End
copy /Y ".\APIs\*.xml" .\zipped.package.release64\plugins\APIs\
If ErrorLevel 1 goto End

rem theme
copy /Y ".\themes\*.xml" .\zipped.package.release\themes\
If ErrorLevel 1 goto End
copy /Y ".\themes\*.xml" .\zipped.package.release64\themes\
If ErrorLevel 1 goto End




"C:\Program Files\7-Zip\7z.exe" a -r .\build\npp.bin.minimalist.7z .\minimalist\*
If ErrorLevel 1 goto End
"C:\Program Files\7-Zip\7z.exe" a -r .\build\npp.bin.minimalist64.7z .\minimalist64\*
If ErrorLevel 1 goto End


"C:\Program Files\7-Zip\7z.exe" a -tzip -r .\build\npp.bin.zip .\zipped.package.release\*
If ErrorLevel 1 goto End
"C:\Program Files\7-Zip\7z.exe" a -r .\build\npp.bin.7z .\zipped.package.release\*
If ErrorLevel 1 goto End
rem IF EXIST "%PROGRAMFILES(X86)%" ("%PROGRAMFILES(x86)%\NSIS\Unicode\makensis.exe" nppSetup.nsi) ELSE ("%PROGRAMFILES%\NSIS\Unicode\makensis.exe" nppSetup.nsi)
IF EXIST "%PROGRAMFILES(X86)%" ("%PROGRAMFILES(x86)%\NSIS\makensis.exe" nppSetup.nsi) ELSE ("%PROGRAMFILES%\NSIS\makensis.exe" nppSetup.nsi)
IF EXIST "%PROGRAMFILES(X86)%" ("%PROGRAMFILES(x86)%\NSIS\makensis.exe" -DARCH64 nppSetup.nsi) ELSE ("%PROGRAMFILES%\NSIS\makensis.exe" -DARCH64 nppSetup.nsi)

rem Notepad++ Unicode package
rmdir /S /Q .\zipped.package.release

mkdir .\zipped.package.release64
rem mkdir .\zipped.package.release64\updater
mkdir .\zipped.package.release64\localization
mkdir .\zipped.package.release64\themes
mkdir .\zipped.package.release64\plugins
mkdir .\zipped.package.release64\plugins\APIs
mkdir .\zipped.package.release64\plugins\Config
mkdir .\zipped.package.release64\plugins\doc

copy /Y ..\bin\license.txt .\zipped.package.release64\
If ErrorLevel 1 goto End
copy /Y ..\bin\readme.txt .\zipped.package.release64\
If ErrorLevel 1 goto End
copy /Y ..\bin\change.log .\zipped.package.release64\
If ErrorLevel 1 goto End
copy /Y ..\src\langs.model.xml .\zipped.package.release64\
If ErrorLevel 1 goto End
copy /Y ..\src\stylers.model.xml .\zipped.package.release64\
If ErrorLevel 1 goto End
copy /Y ..\src\contextMenu.xml .\zipped.package.release64\
If ErrorLevel 1 goto End
copy /Y ..\src\shortcuts.xml .\zipped.package.release64\
If ErrorLevel 1 goto End
copy /Y ..\src\functionList.xml .\zipped.package.release64\
If ErrorLevel 1 goto End
copy /Y ..\bin\doLocalConf.xml .\zipped.package.release64\
If ErrorLevel 1 goto End
copy /Y ..\bin64\"notepad++.exe" .\zipped.package.release64\
If ErrorLevel 1 goto End
copy /Y ..\bin64\SciLexer.dll .\zipped.package.release64\
If ErrorLevel 1 goto End

"C:\Program Files\7-Zip\7z.exe" a -tzip -r .\build\npp.bin64.zip .\zipped.package.release64\*
If ErrorLevel 1 goto End

"C:\Program Files\7-Zip\7z.exe" a -r .\build\npp.bin64.7z .\zipped.package.release64\*
If ErrorLevel 1 goto End


rem set var locally in this batch file
setlocal enableDelayedExpansion 

cd .\build\


for %%a in (npp.*.Installer.exe) do (
  rem echo a = %%a
  set nppInstallerVar=%%a
  set nppInstallerVar64=!nppInstallerVar:Installer.exe=Installer.x64.exe!
		
		rem nppInstallerVar should be the version for exemple: 6.9
		rem we put npp.6.9. + (bin.zip instead of Installer.exe) into var zipvar
  set zipvar=!nppInstallerVar:Installer.exe=bin.zip!
  set zipvar64=!nppInstallerVar:Installer.exe=bin.x64.zip!
  set 7zvar=!nppInstallerVar:Installer.exe=bin.7z!
  set 7zvar64=!nppInstallerVar:Installer.exe=bin.x64.7z!
  set 7zvarMin=!nppInstallerVar:Installer.exe=bin.minimalist.7z!
  set 7zvarMin64=!nppInstallerVar:Installer.exe=bin.minimalist.x64.7z!
)

rem echo zipvar=!zipvar!
rem echo zipvar64=!zipvar64!
rem echo 7zvar=!7zvar!
rem echo 7zvar64=!7zvar64!
rem echo 7zvarMin=!7zvarMin!
rem echo 7zvarMin64=!7zvarMin64!
ren npp.bin.zip !zipvar!
ren npp.bin64.zip !zipvar64!
ren npp.bin.7z !7zvar!
ren npp.bin64.7z !7zvar64!
ren npp.bin.minimalist.7z !7zvarMin!
ren npp.bin.minimalist64.7z !7zvarMin64!

if %SIGN% == 0 goto NoSignInstaller
signtool.exe sign /f %NPP_CERT% /p %NPP_CERT_PWD% /d "Notepad++ Installer" /du https://notepad-plus-plus.org/ /t http://timestamp.digicert.com/ !nppInstallerVar!
If ErrorLevel 1 goto End
signtool.exe sign /f %NPP_CERT% /p %NPP_CERT_PWD% /d "Notepad++ Installer" /du https://notepad-plus-plus.org/ /t http://timestamp.digicert.com/ !nppInstallerVar64!
If ErrorLevel 1 goto End
:NoSignInstaller

cd ..

endlocal

:End