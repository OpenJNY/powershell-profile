Import-Module posh-git
Import-Module oh-my-posh

# Start the default settings
# Set-Prompt
# Alternatively set the desired theme:
Set-Theme Agnoster

function which ($name) { Get-Command -Name $name | Format-List * }
function open ($filename) { Start-Process $filename }
function repo () { cd $(Join-Path $(ghq root) $(ghq list | fzf).Replace('/', '\')) }

function Add-Path($newPath) {
  $env:PATH = $newPath + ';' + $env:PATH
}

$bins = @(
  "$env:USERPROFILE\bin"
  "$env:USERPROFILE\.local\bin"
) -join ";"

Add-Path $bins

# profile
$profilePath = Join-Path $HOME "Documents\PowerShell\profile.ps1"
$env:profile = $profilePath
$profile = $profilePath

function Edit-Profile { code $profilePath }