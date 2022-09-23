@echo off
echo Copyright (c) Collin Pereira

set functions=Firewall localsecpol audit delfiles remoteDesk diableGueAdm ftp ssh insremoval servicestop

:Firewall
netsh advfirewall set allprofiles state on
netsh advfirewall reset

:delfiles
del *.mp3
del *.gif
del *.png


:: Sets Policys for account

:localsecpol
net accounts /minpwlen:8
net accounts /lockoutthreshold:5
net accounts /maxpwage:30
net accounts /uniquepw:5
net accounts /lockoutduration:30
net accounts /lockoutthreshold:5
net accounts /lockoutwindow:30
start secpol.msc /wait
pause 



:audit
auditpol /set /category:* /success:enable
auditpol /set /category:* /failure:enable

:: Stops FTP 
net stop msftpsvc
goto :eof

::Disables FTP
sc config msftpsvc start= disabled
goto :eof
