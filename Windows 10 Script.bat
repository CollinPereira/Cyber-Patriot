@echo off
echo Copyright (c) Collin Pereira


set functions=Firewall localsecpol audit delfiles remoteDesk diableGueAdm ftp ssh insremoval servicestop

echo Firewall Profiles
:Firewall
netsh advfirewall set allprofiles state on
netsh advfirewall reset

echo Account Policys
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

echo Audit Policy
:audit
auditpol /set /category:* /success:enable
auditpol /set /category:* /failure:enable

echo Disable Services
sc config "PlugPlay" start= disabled
sc stop "PlugPlay"

net stop msftpsvc
goto :eof

sc config msftpsvc start= disabled
goto :eof

Dism /online /Disable-Feature /FeatureName:SimpleTCP

exit
