; this file is part of installer for Notepad++
; Copyright (C)2016 Don HO <don.h@free.fr>
;
; This program is free software; you can redistribute it and/or
; modify it under the terms of the GNU General Public License
; as published by the Free Software Foundation; either
; version 2 of the License, or (at your option) any later version.
;
; Note that the GPL places important restrictions on "derived works", yet
; it does not provide a detailed definition of that term.  To avoid      
; misunderstandings, we consider an application to constitute a          
; "derivative work" for the purpose of this license if it does any of the
; following:                                                             
; 1. Integrates source code from Notepad++.
; 2. Integrates/includes/aggregates Notepad++ into a proprietary executable
;    installer, such as those produced by InstallShield.
; 3. Links to a library or executes a program that does any of the above.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
; 
; You should have received a copy of the GNU General Public License
; along with this program; if not, write to the Free Software
; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

Var themesParentPath
Var doLocalConf
Function un.onInit
  	; determinate theme path for uninstall themes
	StrCpy $themesParentPath "$APPDATA\${APPNAME}"
	StrCpy $doLocalConf "false"
	IfFileExists $INSTDIR\doLocalConf.xml doesExist noneExist
doesExist:
	StrCpy $themesParentPath $INSTDIR
	StrCpy $doLocalConf "true"
noneExist:
	;MessageBox MB_OK "doLocalConf == $doLocalConf"
FunctionEnd


Section un.explorerContextMenu
	Exec 'regsvr32 /u /s "$INSTDIR\NppShell_01.dll"'
	Exec 'regsvr32 /u /s "$INSTDIR\NppShell_02.dll"'
	Exec 'regsvr32 /u /s "$INSTDIR\NppShell_03.dll"'
	Exec 'regsvr32 /u /s "$INSTDIR\NppShell_04.dll"'
	Exec 'regsvr32 /u /s "$INSTDIR\NppShell_05.dll"'
	Exec 'regsvr32 /u /s "$INSTDIR\NppShell_06.dll"'
	Delete "$INSTDIR\NppShell_01.dll"
	Delete "$INSTDIR\NppShell_02.dll"
	Delete "$INSTDIR\NppShell_03.dll"
	Delete "$INSTDIR\NppShell_04.dll"
	Delete "$INSTDIR\NppShell_05.dll"
	Delete "$INSTDIR\NppShell_06.dll"
SectionEnd

Section un.UnregisterFileExt
	; Remove references to "Notepad++_file"
	IntOp $1 0 + 0	; subkey index
	StrCpy $2 ""	; subkey name
Enum_HKCR_Loop:
	EnumRegKey $2 HKCR "" $1
	StrCmp $2 "" Enum_HKCR_Done
	ReadRegStr $0 HKCR $2 ""	; Read the default value
	${If} $0 == "Notepad++_file"
		ReadRegStr $3 HKCR $2 "Notepad++_backup"
		; Recover (some of) the lost original file types
		${If} $3 == "Notepad++_file"
			${If} $2 == ".ini"
				StrCpy $3 "inifile"
			${ElseIf} $2 == ".inf"
				StrCpy $3 "inffile"
			${ElseIf} $2 == ".nfo"
				StrCpy $3 "MSInfoFile"
			${ElseIf} $2 == ".txt"
				StrCpy $3 "txtfile"
			${ElseIf} $2 == ".log"
				StrCpy $3 "txtfile"
			${ElseIf} $2 == ".xml"
				StrCpy $3 "xmlfile"
			${EndIf}
		${EndIf}
		${If} $3 == "Notepad++_file"
			; File type recovering has failed. Just discard the current file extension
			DeleteRegKey HKCR $2
		${Else}
			; Restore the original file type
			WriteRegStr HKCR $2 "" $3
			DeleteRegValue HKCR $2 "Notepad++_backup"
			IntOp $1 $1 + 1
		${EndIf}
	${Else}
		IntOp $1 $1 + 1
	${EndIf}
	Goto Enum_HKCR_Loop
Enum_HKCR_Done:

	; Remove references to "Notepad++_file" from "Open with..."
	IntOp $1 0 + 0	; subkey index
	StrCpy $2 ""	; subkey name
Enum_FileExts_Loop:
	EnumRegKey $2 HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts" $1
	StrCmp $2 "" Enum_FileExts_Done
	DeleteRegValue HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\$2\OpenWithProgids" "Notepad++_file"
	IntOp $1 $1 + 1
	Goto Enum_FileExts_Loop
Enum_FileExts_Done:

	; Remove "Notepad++_file" file type
	DeleteRegKey HKCR "Notepad++_file"
SectionEnd

Section un.UserManual
	RMDir /r "$INSTDIR\user.manual"
SectionEnd


Var keepUserData
Function un.doYouReallyWantToKeepData
	StrCpy $keepUserData "false"
	MessageBox MB_YESNO "Would you like to keep your custom settings?" /SD IDNO IDYES skipRemoveUserData IDNO removeUserData
skipRemoveUserData:
	StrCpy $keepUserData "true"
removeUserData:
FunctionEnd


!macro uninstallRegKey
	;Remove from registry...
!ifdef ARCH64
	SetRegView 32
!else
	SetRegView 64
!endif
	DeleteRegKey HKLM "${UNINSTALL_REG_KEY}"
	;DeleteRegKey HKLM "SOFTWARE\${APPNAME}"
	;DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\notepad++.exe"
!ifdef ARCH64
	SetRegView 64
!else
	SetRegView 32
!endif
!macroend

!macro uninstallDir dir2remove
	; Delete Shortcuts
	Delete "$SMPROGRAMS\Notepad++\Uninstall.lnk"
	RMDir "$SMPROGRAMS\Notepad++"
	
	UserInfo::GetAccountType
	Pop $1
	StrCmp $1 "Admin" 0 +2
		SetShellVarContext all
	
	Delete "$DESKTOP\Notepad++.lnk"
	Delete "$SMPROGRAMS\Notepad++\Notepad++.lnk"
	Delete "$SMPROGRAMS\Notepad++\readme.lnk"

	
	RMDir /r "${dir2remove}"
	
!macroend


Section Uninstall
!ifdef ARCH64
	SetRegView 64
!else
	SetRegView 32
!endif
	;Remove from registry...
	DeleteRegKey HKLM "${UNINSTALL_REG_KEY}"
	DeleteRegKey HKLM "SOFTWARE\${APPNAME}"
	DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\notepad++.exe"

	; Delete self
	Delete "$INSTDIR\uninstall.exe"

	; Delete Shortcuts
	Delete "$SMPROGRAMS\${APPNAME}\Uninstall.lnk"
	RMDir "$SMPROGRAMS\${APPNAME}"
	
	UserInfo::GetAccountType
	Pop $1
	StrCmp $1 "Admin" 0 +2
		SetShellVarContext all ; make context for all user
	
	Delete "$DESKTOP\Notepad++.lnk"
	Delete "$SMPROGRAMS\${APPNAME}\Notepad++.lnk"
	Delete "$SMPROGRAMS\${APPNAME}\readme.lnk"
	

	; Clean up Notepad++
	Delete "$INSTDIR\SciLexer.dll"
	Delete "$INSTDIR\change.log"
	Delete "$INSTDIR\LICENSE"

	Delete "$INSTDIR\notepad++.exe"
	Delete "$INSTDIR\readme.txt"
	
	${If} $doLocalConf == "true"
		Call un.doYouReallyWantToKeepData
	${endIf}

	${If} $keepUserData == "false"
		Delete "$INSTDIR\config.xml"
		Delete "$INSTDIR\langs.xml"
		Delete "$INSTDIR\stylers.xml"
		Delete "$INSTDIR\contextMenu.xml"
		Delete "$INSTDIR\shortcuts.xml"
		Delete "$INSTDIR\functionList.xml"
		Delete "$INSTDIR\session.xml"
		Delete "$INSTDIR\nativeLang.xml"
		Delete "$INSTDIR\userDefineLang.xml"
	${endIf}
	
	Delete "$INSTDIR\config.model.xml"
	Delete "$INSTDIR\langs.model.xml"
	Delete "$INSTDIR\stylers.model.xml"
	Delete "$INSTDIR\stylers_remove.xml"
	Delete "$INSTDIR\localization\english.xml"
	Delete "$INSTDIR\LINEDRAW.TTF"
	Delete "$INSTDIR\SourceCodePro-Regular.ttf"
	Delete "$INSTDIR\SourceCodePro-Bold.ttf"
	Delete "$INSTDIR\SourceCodePro-It.ttf"
	Delete "$INSTDIR\SourceCodePro-BoldIt.ttf"
	Delete "$INSTDIR\NppHelp.chm"
	Delete "$INSTDIR\doLocalConf.xml"
	
	${If} $doLocalConf == "false"
		Call un.doYouReallyWantToKeepData
	${endIf}

	${If} $keepUserData == "false"
		; make context as current user to uninstall user's APPDATA
		SetShellVarContext current
		Delete "$APPDATA\${APPNAME}\langs.xml"
		Delete "$APPDATA\${APPNAME}\config.xml"
		Delete "$APPDATA\${APPNAME}\stylers.xml"
		Delete "$APPDATA\${APPNAME}\contextMenu.xml"
		Delete "$APPDATA\${APPNAME}\shortcuts.xml"
		Delete "$APPDATA\${APPNAME}\functionList.xml"
		Delete "$APPDATA\${APPNAME}\nativeLang.xml"
		Delete "$APPDATA\${APPNAME}\session.xml"
		Delete "$APPDATA\${APPNAME}\userDefineLang.xml"
		Delete "$APPDATA\${APPNAME}\insertExt.ini"
	
		RMDir /r "$APPDATA\${APPNAME}\plugins\"
		RMDir "$APPDATA\${APPNAME}\backup\"
		RMDir "$APPDATA\${APPNAME}\themes\"
		RMDir "$APPDATA\${APPNAME}"
		
		StrCmp $1 "Admin" 0 +2
			SetShellVarContext all ; make context for all user
	${endIf}
	
	; Remove remaining directories
	RMDir /r "$INSTDIR\plugins\disabled\"
	RMDir "$INSTDIR\plugins\APIs\"
	RMDir "$INSTDIR\plugins\"
	RMDir "$INSTDIR\themes\"
	RMDir "$INSTDIR\localization\"
	RMDir "$INSTDIR\"
	RMDir "$SMPROGRAMS\${APPNAME}"

SectionEnd


