;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; AHK�汾��		1.1.23.01
; ���ԣ�		����
; ���ߣ�		lspcieee <lspcieee@gmail.com>
; ��վ��		http://www.lspcieee.com/
; �ű����ܣ�	�Զ��л����뷨
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;=====��������
;�¿�����ʱ���л����������뷨�ķ���
GroupAdd,cn,ahk_exe QQ.exe  ;QQ
GroupAdd,cn,ahk_exe WINWORD.EXE ;word
GroupAdd,cn,ahk_exe wps.exe ;wps
GroupAdd,cn,ahk_exe MindManager.exe

;�¿�����ʱ���л���Ӣ�����뷨�ķ���
GroupAdd,en,ahk_exe devenv.exe  ;Visual Studio
GroupAdd,en,ahk_exe dopus.exe 
GroupAdd,en,ahk_class Notepad++
GroupAdd,en,ahk_class Listary_WidgetWin_0

;�����л�ʱ���л����������뷨
GroupAdd,cn32772,ahk_exe QQ.exe  ;QQ

;�����л�ʱ���л���Ӣ�����뷨
GroupAdd,en32772,ahk_class Listary_WidgetWin_0


;�༭������
GroupAdd,editor,ahk_exe devenv.exe  ;Visual Studio
GroupAdd,editor,ahk_exe notepad.exe ;���±�
GroupAdd,editor,ahk_class Notepad++




;����
;�Ӽ��������뵽����
sendbyclip(var_string)
{
    ClipboardOld = %ClipboardAll%
    Clipboard =%var_string%
	ClipWait
    send ^v
    sleep 100
    Clipboard = %ClipboardOld%  ; Restore previous contents of clipboard.
}


setChineseLayout(){
	;�����������뷨�л���ݼ��������ʵ��������á�
	send {Ctrl Down}{Shift}
	send {Ctrl Down},
	send {Ctrl Down}{Shift}
	send {Ctrl Down},
	send {Ctrl Up}
}
setEnglishLayout(){
	;����Ӣ�����뷨�л���ݼ��������ʵ��������á�
	send {Ctrl Down}{Shift}
	send {Ctrl Down},
	send {Ctrl Down}{Shift}
	send {Ctrl Down},

	;send {Ctrl Down}{Space} ;�ѹ����뷨���º�ʹ��ctrl+Space�����ѹ����뷨��������ݼ�
	send {Ctrl Down}{Shift}
	send {Ctrl Up}
}

;�����Ϣ�ص�ShellMessage�����Զ��������뷨
Gui +LastFound
hWnd := WinExist()
DllCall( "RegisterShellHookWindow", UInt,hWnd )
MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
OnMessage( MsgNum, "ShellMessage")

ShellMessage( wParam,lParam ) {

;1 �������屻���� 
;2 �������弴�����ر� 
;3 SHELL �������彫������ 
;4 �������屻���� 
;5 �������屻��󻯻���С�� 
;6 Windows ��������ˢ�£�Ҳ�������ɱ�����
;7 �����б�����ݱ�ѡ�� 
;8 ��Ӣ���л������뷨�л� 
;9 ��ʾϵͳ�˵� 
;10 �������屻ǿ�ƹر� 
;11 
;12 û�б��������APPCOMMAND����WM_APPCOMMAND 
;13 wParam=���滻�Ķ������ڵ�hWnd 
;14 wParam=�滻�������ڵĴ���hWnd 
;&H8000& ���� 
;53 ȫ��
;54 �˳�ȫ��
;32772 �����л�
	If ( wParam = 1 )
	{
		;WinGetclass, WinClass, ahk_id %lParam%
		;MsgBox,%Winclass%
		Sleep, 1000
		;WinActivate,ahk_class %Winclass%
		;WinGetActiveTitle, Title
		;MsgBox, The active window is "%Title%".
		IfWinActive,ahk_group cn
		{
			setChineseLayout()
			TrayTip,AHK, ���Զ��л����������뷨
			return
		}
		IfWinActive,ahk_group en
		{
			setEnglishLayout()
			TrayTip,AHK, ���Զ��л���Ӣ�����뷨
			return
		}
	}
	If ( wParam = 32772 )
	{
		IfWinActive,ahk_group cn32772
		{
			setChineseLayout()
			;TrayTip,AHK, ���Զ��л����������뷨
			return
		}
		IfWinActive,ahk_group en32772
		{
			setEnglishLayout()
			;TrayTip,AHK, ���Զ��л���Ӣ�����뷨
			return
		}
		;mlo�л�������ʱ
		IfWinActive, ahk_class TfrmMyLifeMain
		{
			send {F9}
			;TrayTip,AHK, ���Զ�ͬ��MLO
		}
	}
}

;�����б༭�����Զ��л���Ӣ�����뷨
#IfWinActive,ahk_group editor
:*:// ::
	;//�ӿո� ʱ �л����������뷨
	setEnglishLayout()
	sendbyclip("//")
	setChineseLayout()
return
:Z*:///::
	;///ע��ʱ �л����������뷨��Ҳ��������///�ӿո�
	setEnglishLayout()
	sendbyclip("//")
	SendInput /
	setChineseLayout()
return
:*:" ::
	;���żӿո� ʱ �л����������뷨
	setEnglishLayout()
	SendInput "
	setChineseLayout()
return
:*:`;`n::
	;�ֺżӻس� ʱ �л���Ӣ�����뷨
	setEnglishLayout()
	sendbyclip(";")
	SendInput `n
return
:Z?*:`;`;::
	;�����ֺ�ʱ �л���Ӣ�����뷨
	setEnglishLayout()
return
:Z?*:  ::
	;���������ո� �л����������뷨
	setEnglishLayout()
	setChineseLayout()
return

#IfWinActive






