SETLOCAL EnableDelayedExpansion

set batchlocation="%cd%"

set echotog=off

::total functions:
set functotal=7
::total pages : 
set pagetotal=2
::CHANGE WHEN ADDING FUNCTIONS

::------------------------------------------------------------------------------

::changes title
TITLE Blue's Cool and Epic Random Functions Menu      (0.2.1)
goto menu1

::------------------------------------------------------------------------------

:menu1
cls
@echo !echotog!
set Input=Q
set menunum=menu1
set menunum2=1
set menunum3=menu!menunum2!
color 0E
echo(
echo    Random Tools (and Junk That is Mildly Annoying to Type Manually)
echo =======================================================================
echo(
echo Please select an option:                     (number followed by ENTER)
echo   1.  Open new command prompt window
echo   2.  ipconfig
echo   3.  Ookla Speedtest
echo   4.  System Information
echo   5.  tasklist / taskkill                              showing 1-5 of %functotal%
echo                                                                  Page %menunum2%
echo q to quit (ENTER)                  select(k) next(l)
echo o for options
goto selection



:menu2
cls
set Input=Q
set menunum=menu2
set menunum2=2
set menunum3=menu!menunum2!
color 0E
echo(
echo    Random Tools (and Junk That is Mildly Annoying to Type Manually)
echo =======================================================================
echo(
echo Please select an option:                     (number followed by ENTER)
echo   6.  chkdsk
echo   7.  System file checker (Admin only)
echo(
echo(
echo(                                                       showing 6-7 of %functotal%
echo                                                                  Page %menunum2%
echo q to quit (ENTER)      previous(j) select(k)
echo o for options
goto selection


:selection
set /p Input=:
If /I "%Input%"=="1" goto option1
If /I "%Input%"=="2" goto option2
If /I "%Input%"=="3" goto option3
If /I "%Input%"=="4" goto option4
If /I "%Input%"=="5" goto option5
If /I "%Input%"=="6" goto option6
If /I "%Input%"=="7" goto option7
If /I "%Input%"=="Q" goto quit
If /I "%Input%"=="l" goto next
If /I "%Input%"=="k" goto menuselect
If /I "%Input%"=="j" goto back
If /I "%Input%"=="o" goto optionsmenu
echo Invalid selection
pause
goto !menunum3!

:next
set menunum3=menu!menunum2!
IF !menunum2! LSS %pagetotal% (
    set /a "menunum2=(!menunum2!+1)"
) ELSE (
     goto fail
)
set menunum3=menu!menunum2!
goto !menunum3!

:back
set menunum3=menu!menunum2!
IF !menunum2! GTR 1 (
    set /a "menunum2=(!menunum2!-1)"
) ELSE (
     goto fail
)
set menunum3=menu!menunum2!
goto !menunum3!

:fail
goto !menunum3!

::menu selection and option selection is messy, could just goto to a list of options with
::the input and not clear the screen to retain the echo of the menu
::that way you could just choose a number if you remember it
::but im lazy and i cant be bothered doing it
::so you get this lazy system where it's printing the entire menu every time, and the selection
::system is part of each menu
::might fix later, idk

::disregard all this, i fixed it at the cost of my sanity

:menuselect
color 0E
cls
set mensel=q
echo --------------------------
echo        PAGE SELECT
echo --------------------------
echo Input page number (1-2)
echo(
echo q to cancel
set /p mensel=Page:
If /I "%mensel%"=="q" goto %menunum%
goto menu%mensel%
pause
goto menuselect

:optionsmenu
color 0F
cls
echo ------------------------------------------
echo                 OPTIONS
echo ------------------------------------------
echo Input desired option
echo   1. Toggle echo
echo q to cancel
echo (Default=q)
set /p optionsel=:
If /I "%optionsel%"=="1" (
    goto echotog1
)
If /I "%optionsel%"=="q" goto !menunum3!
echo Invalid selection
pause
goto optionsmenu

:echotog1
If !echotog! EQU on (
    set echotog=off
) ELSE (
    set echotog=on
)
cls
echo Echo is now %echotog%!
pause
goto menu1




:option1
set cmdyn=N
cls
echo Do you want an elevated command prompt? [Y/N]
echo (Default=N)
echo q to cancel
echo(
set /p cmdyn=:
If /I "%cmdyn%"=="Y" goto cmdy
If /I "%cmdyn%"=="N" goto cmdn
If /I "%cmdyn%"=="q" goto menu1
echo Invalid selection
pause
goto option1

:cmdy
cls
set cmduser=q
color 0F
echo Please enter your account username:
echo(
echo q to cancel
set /p cmduser=Username:
If /I "%cmduser%"=="q" goto %menunum%
goto cmdad
pause
goto menu1
:cmdad
cls
runas /user:%cmduser% "cmd /k cd %batchlocation%"
echo Opening command prompt window
timeout 3 >nul
goto %menunum%

:cmdn
cls
start cmd
echo Opening command prompt window
timeout 3 >nul
goto menu1


:option2
color 0E
set ipc=1
cls
echo ------------------------------------------
echo                 IPCONFIG
echo ------------------------------------------
echo Input desired option
echo   1. Default ipconfig command
echo   2. ipconfig with detailed information
echo   3. Renew all connections
echo   4. Release all connections
echo   5. Release and then renew all connections
echo q to cancel
echo (Default=1)
set /p ipc=:
If /I "%ipc%"=="1" goto ipc1
If /I "%ipc%"=="2" goto ipc2
If /I "%ipc%"=="3" goto ipc3
If /I "%ipc%"=="4" goto ipc4
If /I "%ipc%"=="5" goto ipc5
If /I "%ipc%"=="q" goto menu1
echo Invalid selection
pause
goto option2

:ipc1
cls
ipconfig
pause
goto option2

:ipc2
cls
ipconfig /all
pause
goto option2

:ipc3
set ipcc3=N
color 0C
cls
echo Are you sure you want to renew all connections? [Y/N]
echo (Default=N)
echo(
set /p ipcc3=:
If /I "%ipcc3%"=="Y" goto ipc3c
If /I "%ipcc3%"=="N" goto option2
echo Invalid selection
pause
goto ipc3
:ipc3c
color 0F
cls
ipconfig /renew
pause
goto option2

:ipc4
color 0C
set ipcc4=N
cls
echo Are you sure you want to release all connections? [Y/N]
echo (Default=N)
echo(
set /p ipcc4=:
If /I "%ipcc4%"=="Y" goto ipc4c
If /I "%ipcc4%"=="N" goto option2
echo Invalid selection
pause
goto ipc4
:ipc4c
color 0F
cls
ipconfig /release
pause
goto option2

:ipc5
color 0C
set ipcc5=N
cls
echo Are you sure you want to release and renew all connections? [Y/N]
echo (Default=N)
echo(
set /p ipcc5=:
If /I "%ipcc5%"=="Y" goto ipc5c
If /I "%ipcc5%"=="N" goto option2
echo Invalid selection
pause
goto ipc5
:ipc5c
color 0F
cls
ipconfig /release
timeout 5 >nul
ipconfig /renew
pause
goto option2


:option3
cls
set speedtestlocation=C:\Program Files (x86)\ookla-speedtest-1.1.1-win64
IF NOT EXIST "%speedtestlocation%" goto speedtest2 ELSE goto speedtest1

:speedtest1
cls
color 0F
echo Starting 
echo ------------------------------------------------
"%speedtestlocation%\speedtest.exe"
pause
goto menu1

:speedtest2
cls
color 0C
echo FAIL!
echo(
echo(
echo Sorry, but it looks like you aren't running this batch on the machine it was designed for. I could code this to check if the program is present as a PATH variable, and run it as so, but it's a decent bit of work to get it to go.
echo(
echo You can download the tool and edit the location of speedtest.exe in the batch, if it means that much to you.
pause
goto menu1


:option4
cls
set sysinfc=Y
color 0E
echo Do you want to check current system info? [Y/N]
echo (Default=Y)
set /p sysinfc=:
If /I "%sysinfc%"=="Y" goto sysinfrun
If /I "%sysinfc%"=="N" goto menu1
echo Invalid selection
pause
goto option4

:sysinfrun
cls
color 0F
echo ================================
echo       SYSTEM INFORMATION
echo ================================
echo   Hardware Information
echo -----------------------------------------------
systeminfo | findstr /c:"Total Physical Memory"
wmic cpu get name
wmic diskdrive get name,model,size
wmic path win32_videocontroller get name
wmic path win32_VideoController get CurrentHorizontalResolution,CurrentVerticalResolution
echo   Network Information
echo -----------------------------------------------
ipconfig | findstr IPv4
ipconfig | findstr IPv6
echo   Windows Information
echo -----------------------------------------------
systeminfo | findstr /c:"OS Name"
systeminfo | findstr /c:"OS Version"
systeminfo | findstr /c:"System Type"
echo(
pause
goto menu1



:option5
color 0F
set taskst=1
cls
echo ------------------------------------------
echo                 TASKLIST
echo ------------------------------------------
echo Input desired option
echo   1. tasklist
echo   2. tasklist                    (verbose)
echo   3. Unresponsive programs
echo   4. Unresponsive programs       (verbose)
echo   5. taskkill
echo   6. taskkill            (force terminate)
echo q to cancel
echo (Default=1)
set /p taskst=:
If /I "%taskst%"=="1" goto taskl1
If /I "%taskst%"=="2" goto taskl2
If /I "%taskst%"=="3" goto taskl3
If /I "%taskst%"=="4" goto taskl4
If /I "%taskst%"=="5" goto taskl5
If /I "%taskst%"=="6" goto taskl6
If /I "%taskst%"=="q" goto menu1
echo Invalid selection
pause
goto option5

:taskl1
color 0F
cls
echo TASKLIST
echo ============================================================================
tasklist
pause
goto option5

:taskl2
color 0F
cls
echo TASKLIST (/V)
echo ============================================================================
tasklist /V
pause
goto option5

:taskl3
color 0F
cls
echo TASKLIST (/FI "STATUS eq NOT RESPONDING")
echo ============================================================================
tasklist /FI "STATUS eq NOT RESPONDING"
pause
goto option5

:taskl4
color 0F
cls
echo TASKLIST (/V /FI "STATUS eq NOT RESPONDING")
echo ============================================================================
tasklist /V /FI "STATUS eq NOT RESPONDING"
pause
goto option5

:taskl5
set taskselect=q
color 0F
cls
echo ------------------------------------------
echo                 TASKKILL
echo ------------------------------------------
echo Input PID of program you wish to kill:
echo(
echo q to cancel (ENTER)
set /p taskselect=PID:
If /I "%taskselect%"=="q" goto option5
goto taskl5c
:taskl5c
color 0C
set taskkillc=N
cls
echo Are you sure you want to kill this task? [Y/N] (Default=N)
echo:PID: %taskselect%
echo(
set /p taskkillc=:
If /I "%taskkillc%"=="Y" goto taskl5cy
If /I "%taskkillc%"=="N" goto option5
echo Invalid selection
pause
goto taskl5c
:taskl5cy
color 0F
cls
taskkill /PID %taskselect%
echo Task with PID = %taskselect% killed successfully!
pause
goto option5

:taskl6
set taskselect=q
color 0F
cls
echo ------------------------------------------
echo             TASKKILL (FORCED)
echo ------------------------------------------
echo Input PID of program you wish to kill:
echo(
echo q to cancel (ENTER)
set /p taskselect=PID:
If /I "%taskselect%"=="q" goto option5
goto taskl6c
:taskl6c
color 0C
set taskkillc=N
cls
echo Are you sure you want to kill this task? [Y/N] (Default=N)
echo:PID: %taskselect%
echo(
set /p taskkillc=:
If /I "%taskkillc%"=="Y" goto taskl6cy
If /I "%taskkillc%"=="N" goto option5
echo Invalid selection
pause
goto taskl6c
:task16cy
color 0F
cls
taskkill /F /PID %taskselect%
echo Task with PID = %taskselect% killed successfully!
pause
goto option5



:option6
color 0E
set chksel=1
cls
echo ------------------------------------------
echo                  CHKDSK
echo ------------------------------------------
echo Input desired option
echo   1. chkdsk
echo   2. chkdsk with error correction
echo   3. chkdsk with bad sector recovery
echo   4. chkdsk fast scan          (NTFS only)
echo q to cancel
echo (Default=1)
set /p chksel=:
If /I "%chksel%"=="1" goto chksel1
If /I "%chksel%"=="2" goto chksel2
If /I "%chksel%"=="3" goto chksel3
If /I "%chksel%"=="4" goto chksel4
If /I "%chksel%"=="q" goto %menunum%
echo Invalid selection
pause
goto option6

:chksel1
color 0F
set chkdrive=q
cls
echo Specify drive letter
echo e.g. C
echo(
echo q to cancel
echo (Default=q)
set /p chkdrive=Drive:
If /I "%chkdrive%"=="q" goto option6
goto chksel1d
:chksel1d
color 0C
set chksel1ds=N
cls
echo Are you sure you want to run chkdsk? [Y/N]
echo(
echo (Default=N)
set /p chksel1ds=:
If /I "%chksel1ds%"=="Y" goto chksel1dsc
If /I "%chksel1ds%"=="N" goto option6
echo Invalid selection
pause
goto chksel1d
:chksel1dsc
color 0F
cls
chkdsk %chkdrive%:
pause
goto %menunum%

:chksel2
color 0F
set chkdrive=q
cls
echo Specify drive letter
echo e.g. C
echo(
echo q to cancel
echo (Default=q)
set /p chkdrive=Drive:
If /I "%chkdrive%"=="q" goto option6
goto chksel2d
:chksel2d
color 0C
set chksel2ds=N
cls
echo Are you sure you want to run chkdsk with error correction? [Y/N]
echo(
echo (Default=N)
set /p chksel2ds=:
If /I "%chksel2ds%"=="Y" goto chksel2dsc
If /I "%chksel2ds%"=="N" goto option6
echo Invalid selection
pause
goto chksel2d
:chksel2dsc
color 0F
cls
chkdsk %chkdrive%: /F
pause
goto %menunum%

:chksel3
color 0F
set chkdrive=q
cls
echo Specify drive letter
echo e.g. C
echo(
echo q to cancel
echo (Default=q)
set /p chkdrive=Drive:
If /I "%chkdrive%"=="q" goto option6
goto chksel3d
:chksel3d
color 0C
set chksel3ds=N
cls
echo Are you sure you want to run chkdsk with bad sector recovery? [Y/N]
echo(
echo (Default=N)
set /p chksel3ds=:
If /I "%chksel3ds%"=="Y" goto chksel3dsc
If /I "%chksel3ds%"=="N" goto option6
echo Invalid selection
pause
goto chksel3d
:chksel3dsc
color 0F
cls
chkdsk %chkdrive%: /R
pause
goto %menunum%

:chksel4
color 0F
set chkdrive=q
cls
echo Specify drive letter
echo e.g. C
echo(
echo q to cancel
echo (Default=q)
set /p chkdrive=Drive:
If /I "%chkdrive%"=="q" goto option6
goto chksel4d
:chksel4d
color 0C
set chksel4ds=N
cls
echo Are you sure you want to run chkdsk? [Y/N]
echo(
echo (Default=N)
set /p chksel4ds=:
If /I "%chksel4ds%"=="Y" goto chksel4dsc
If /I "%chksel4ds%"=="N" goto option6
echo Invalid selection
pause
goto chksel4d
:chksel4dsc
color 0F
cls
chkdsk %chkdrive%: /perf
pause
goto %menunum%



:option7
set sfcsel=1
color 0F
cls
echo ------------------------------------------
echo            SYSTEM FILE CHECKER
echo ------------------------------------------
echo Input desired option
echo   1. Run sfc
echo   2. Run sfc in verify-only mode
echo   3. Scan a specific file
echo q to cancel
echo (Default=1)
set /p sfcsel=:
if "%sfcsel%"=="1" goto sfcsel1
if "%sfcsel%"=="2" goto sfcsel2
if "%sfcsel%"=="3" goto sfcsel3
if "%sfcsel%"=="q" goto %menunum%
echo Invalid selection
pause
goto option7

:sfcsel1
color 0C
set sfcsel1s=N
cls
echo Are you sure you want to run sfc? [Y/N]
echo(
echo (Default=N)
set /p sfcsel1s=:
If /I "%sfcsel1s%"=="Y" goto sfcsel1sd
If /I "%sfcsel1s%"=="N" goto option7
echo Invalid selection
pause
goto sfcsel1
:sfcsel1sd
color 0F
cls
cd C:\WINDOWS\system32\
sfc /scannow
pause
goto option7

:sfcsel2
color 0C
set sfcsel2s=N
cls
echo Are you sure you want to run sfc in verify-only mode? [Y/N]
echo(
echo (Default=N)
set /p sfcsel2s=:
If /I "%sfcsel2s%"=="Y" goto sfcsel2sd
If /I "%sfcsel2s%"=="N" goto option7
echo Invalid selection
pause
goto sfcsel1
:sfcsel2sd
color 0F
cls
cd C:\WINDOWS\system32\
sfc /verifyonly
pause
goto option7

:sfcsel3
color 0F
cls
set sfcpath=q
echo Input path of file to be scanned, including filename and extension.
echo e.g. C:\Users\User\Desktop\Notepad.txt
echo(
echo q to quit
echo (Default=q)
set /p sfcpath=:
If /I "%sfcpath%"=="q" goto option7
goto sfcsel3s
:sfcsel3s
color 0C
cls
set sfcsel3sd=N
echo Are you sure you want to scan this file with sfc? (File will be repaired
echo if problem identified) [Y/N]
echo:File location: %sfcpath%
echo(
echo q to cancel
echo (Default=q)
set /p sfcsel3sd=:
If /I "%sfcsel3sd%"=="Y" goto sfcsel3sds
If /I "%sfcsel3sd%"=="N" goto option7
echo Invalid selection
pause
goto sfcsel3s
:sfcsel3sds
color 0F
cls
cd C:\WINDOWS\system32\
sfc /SCANFILE=%sfcpath%
pause
goto %menunum%



:quit
cls