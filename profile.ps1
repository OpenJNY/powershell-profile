# profile
$profilePath = Join-Path $HOME "Documents\PowerShell\profile.ps1"
$profileDir = Join-Path $HOME "Documents\PowerShell"
$env:profile = $profilePath
$profile = $profilePath

function Edit-Profile { code $profileDir }
function Update-Profile {
  & $profilePath
}

Import-Module posh-git
Import-Module oh-my-posh

# Start the default settings
# Set-Prompt
# Alternatively set the desired theme:
Set-Theme Agnoster

# Produce UTF-8 by default
# https://news.ycombinator.com/item?id=12991690
$PSDefaultParameterValues["Out-File:Encoding"] = "utf8"

function which ($name) { Get-Command -Name $name | Format-List * }
function open ($filename) { Start-Process $filename }
function repo () { cd $(Join-Path $(ghq root) $(ghq list | fzf).Replace('/', '\')) }

function settings { Start-Process ms-setttings: }

# rm alternative
Set-Alias trash Remove-ItemSafely

function Add-Path($newPath) {
  $env:PATH = $newPath + ';' + $env:PATH
}

$bins = @(
  "$env:USERPROFILE\bin"
  "$env:USERPROFILE\.local\bin"
  "$profileDir\bin"
) -join ";"

Add-Path $bins

# Utils
Get-ChildItem utils/*.ps1 | ForEach-Object { . $_.FullName }