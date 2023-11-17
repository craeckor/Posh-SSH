$url = curl.exe -s -I "https://github.com/craeckor/Posh-SSH/releases/latest" | Select-String "Location:"
$posh_tag = $url -split "/" | Select-Object -Last 1
If(!(test-path -PathType container "$ENV:APPDATA\Posh-SSH")) {
    New-Item -ItemType Directory -Path "$ENV:APPDATA\Posh-SSH"
    New-Item -ItemType Directory -Path "$ENV:APPDATA\Posh-SSH\$posh_tag"
    curl.exe -o "$ENV:TEMP\posh.zip" "https://github.com/craeckor/Posh-SSH/releases/download/$posh_tag/Posh-SSH.zip" -L -s
    Expand-Archive -Path "$ENV:TEMP\posh.zip" -DestinationPath "$ENV:APPDATA\Posh-SSH\$posh_tag"
    Remove-Item -Path "$ENV:TEMP\posh.zip" -Recurse -Force
} elseif (!(test-path -PathType container "$ENV:APPDATA\Posh-SSH\$posh_tag")) {
    New-Item -ItemType Directory -Path "$ENV:APPDATA\Posh-SSH\$posh_tag"
    curl.exe -o "$ENV:TEMP\posh.zip" "https://github.com/craeckor/Posh-SSH/releases/download/$posh_tag/Posh-SSH.zip" -L -s
    Expand-Archive -Path "$ENV:TEMP\posh.zip" -DestinationPath "$ENV:APPDATA\Posh-SSH\$posh_tag"
    Remove-Item -Path "$ENV:TEMP\posh.zip" -Recurse -Force
} elseif (!(test-path -PathType Leaf "$ENV:APPDATA\Posh-SSH\$posh_tag\Posh-SSH.psm1")) {
    Remove-Item -Path "$ENV:APPDATA\Posh-SSH\$posh_tag" -Recurse -Force
    New-Item -ItemType Directory -Path "$ENV:APPDATA\Posh-SSH\$posh_tag"
    curl.exe -o "$ENV:TEMP\posh.zip" "https://github.com/craeckor/Posh-SSH/releases/download/$posh_tag/Posh-SSH.zip" -L -s
    Expand-Archive -Path "$ENV:TEMP\posh.zip" -DestinationPath "$ENV:APPDATA\Posh-SSH\$posh_tag"
    Remove-Item -Path "$ENV:TEMP\posh.zip" -Recurse -Force
}
Import-Module -Name "$ENV:APPDATA\Posh-SSH" -Global -Force