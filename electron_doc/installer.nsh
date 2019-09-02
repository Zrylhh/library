  !macro customWelcomePage
    Function AutoBoot
        WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Run" "electron.app.${PRODUCT_NAME}" "$INSTDIR\${PRODUCT_NAME}.exe"
    FunctionEnd
    ; !system "echo '' > ${BUILD_RESOURCES_DIR}/customWelcomePage"

    !define MUI_FINISHPAGE_SHOWREADME
    !define MUI_FINISHPAGE_SHOWREADME_Function AutoBoot
    !define MUI_FINISHPAGE_SHOWREADME_TEXT "开机自启动"

    ; --start
    ;Var DATA_FOLDER
    ;!define MUI_DIRECTORYPAGE_TEXT_TOP "$(chooseDataDirectory)"
    ;!define MUI_DIRECTORYPAGE_VARIABLE $DATA_FOLDER
    ;!insertmacro MUI_PAGE_DIRECTORY
    ; --end

    ; -- custom start
    !include nsDialogs.nsh
    !include LogicLib.nsh

    Var Dialog
	Var DATAPATH
    ;Var name
    ;Var entry
    ;Var website
    ;Var openMode

    Page custom pgPageCreate pgPageLeave

    Function pgPageCreate
		;读取注册表
		ReadRegStr $DATAPATH HKCU "Software\${PRODUCT_NAME}" "datapath"
				
		!insertmacro MUI_HEADER_TEXT "选择数据保存目录" "程序运行期间产生的数据将保存到指定目录下"

        nsDialogs::Create 1018
        Pop $Dialog

        ${If} $Dialog == error
            Abort
        ${EndIf}

        ${NSD_CreateGroupBox} 0u 10u 100% 30u "目标文件夹"
		Pop $0

			${NSD_CreateDirRequest} 5u 20u 230u 12u "$DATAPATH"
			Pop $1
			# 变更事件
			GetFunctionAddress $R0 OnUserEditChange
			nsDialogs::onChange $1 $R0

			${NSD_CreateButton} 242u 18u 48u 16u "浏览"
			Pop $2
			# 将按钮的用户数据设置为路径框的 HWND 建立关联
			nsDialogs::SetUserData $2 $1
			;nsDialogs::SetUserData $2 $DATAPATH
			# 点击事件
			GetFunctionAddress $R0 OnBrowseButtonClick
			nsDialogs::onClick $2 $R0

        nsDialogs::Show
    FunctionEnd

    Function PgPageLeave
        ${NSD_GetText} $1 $DATAPATH
        ;${NSD_GetText} $entry $1
        ;${NSD_GetText} $website $2
        ;${NSD_GetText} $openMode $3

        FileOpen $9 $DESKTOP\.setting w
        FileWrite $9 "DATAPATH:$DATAPATH"
        FileClose $9
        ;SetFileAttributes $DESKTOP\.electron NORMAL
		; 写入到注册表
		WriteRegStr HKCU "Software\${PRODUCT_NAME}" "datapath" "$DATAPATH"
    FunctionEnd
	
	Function OnUserEditChange
		Exch $R0
		${NSD_GetText} $R0 $DATAPATH
		
		;FileOpen $9 $DESKTOP\.setting1 w
        ;FileWrite $9 "DATAPATH:$1"
        ;FileClose $9
		
		Pop $R0
	FunctionEnd
	
	Function OnBrowseButtonClick
		Exch $R0
		Push $R1
		Push $R2

		# 按钮点击事件中获取关联的路径框的 HWND 以便设置文本
		nsDialogs::GetUserData $R0
		Pop $R1
		nsDialogs::SelectFolderDialog "选择目录" "$APPDATA\my_data\"
		Pop $R2
		${If} $R2 != "error" 
			${NSD_SetText} $R1 $R2
		${EndIf}

		Pop $R2
		Pop $R1
		Pop $R0
	FunctionEnd
	

    Section
    SectionEnd
    ; -- custom end
    
  !macroend

 !macro customHeader
   ; !system "echo '' > ${BUILD_RESOURCES_DIR}/customHeader"
   Name "众信" "众信"
 !macroend

 !macro preInit
   ; This macro is inserted at the beginning of the NSIS .OnInit callback
   ; !system "echo '' > ${PROJECT_DIR}/preInit"
 !macroend

 !macro customInit
   ; !system "echo '' > ${BUILD_RESOURCES_DIR}/customInit"
   
 !macroend

 !macro customInstall
    WriteRegStr HKCU "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\${PRODUCT_NAME}.exe" "WIN7RTM"
   ; !system "echo '' > ${BUILD_RESOURCES_DIR}/customInstall"
    
 !macroend

 !macro customUnInstall
   DeleteRegValue HKCU "Software\Microsoft\Windows\CurrentVersion\Run" "electron.app.${PRODUCT_NAME}"
   DeleteRegValue HKCU "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\${PRODUCT_NAME}.exe"
  ;  !system "echo '' > ${BUILD_RESOURCES_DIR}/customInstall"
 !macroend


