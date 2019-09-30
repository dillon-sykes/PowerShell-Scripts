:: Credit: /u/FreeBooter_ from Reddit

:: Add Windows Powershell Script New Context Menu in Windows 10

@Echo Off

net sess>nul 2>&1||(powershell start cmd -ArgumentList """/c %~0""" -verb Runas & exit)

:_Start
Cls & Mode CON  LINES=11 COLS=80 & Color 0E 
Echo.
Echo.       
Echo         Type (R) to Remove Powershell Script from New Context Menu  
Echo.       
Echo.
Echo.
Echo.       
Echo         Type (E) to Add Powershell Script File to New Context Menu    
Echo.       

Set /p input= RESPONSE: 
If /i  Not %input%==R (Goto :_Ex) Else (Goto :_Disable)

:_Ex
If /i  Not %input%==E  (Goto :_Start) Else (Goto :_Enable)


:_Enable

Reg.exe add "HKLM\SOFTWARE\Classes\.ps1\ShellNew" /v "NullFile" /t REG_SZ /d "" /f

Cls & Mode CON  LINES=5 COLS=73 & Color 0E 
Echo.
Echo. 
Echo            Adding Powershell Script File to New Context Menu

Ping -n 5  localhost > Nul
Exit

:_Disable

Reg.exe delete "HKLM\SOFTWARE\Classes\.ps1\ShellNew" /f

Cls & Mode CON  LINES=5 COLS=75 & Color 0E 
Echo.
Echo.
Echo            Removing Powershell Script File from New Context Menu

Ping -n 5  localhost > Nul