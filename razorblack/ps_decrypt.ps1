$SecureString = Read-Host -Prompt "Enter your Password" -AsSecureString
$EncryptedString = ConvertFrom-SecureString $SecureString 
$EncryptedString | Out-File .\Clowns.txt 
