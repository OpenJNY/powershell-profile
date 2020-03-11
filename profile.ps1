# profile
$profilePath = Join-Path $HOME "Documents\PowerShell\profile.ps1"
$profileDir = Join-Path $HOME "Documents\PowerShell"
$env:profile = $profilePath
$profile = $profilePath

function Edit-Profile { code $profileDir }
function Update-Profile {
  . $profilePath
}

# Produce UTF-8 by default
# https://news.ycombinator.com/item?id=12991690
$PSDefaultParameterValues["Out-File:Encoding"] = "utf8"

function Add-Path($newPath) {
  $env:PATH = $newPath + ';' + $env:PATH
}

# User bins
$bins = @(
  "$env:USERPROFILE\bin"
  "$env:USERPROFILE\.local\bin"
  "$profileDir\bin"
) -join ";"

Add-Path $bins

# https://www.powershellgallery.com/packages/ProductivityTools.PSTestCommandExists/1.0.3
function Test-CommandExists {
  [CmdletBinding()]
  param($Name)

  $oldPreference = $ErrorActionPreference
  Write-Verbose "Previous ErrorActionPreference: $ErrorActionPreference"
  $ErrorActionPreference = "Stop"
  Write-Verbose "Set ErrorActionPreference to 'Stop'"

  try {
    $command = Get-Command $Name
    Write-Verbose "Command Exists $command"
    return $true
  }
  catch {
    Write-Verbose "Command $Name does not exist" 
    return $false
  }
  finally {
    $ErrorActionPreference = $oldPreference
    Write-Verbose "Restore ErrorActionPreference: $ErrorActionPreference"
  }
}
Set-Alias test Test-CommandExists

# Utils
Get-ChildItem $PSScriptRoot\utils\*.ps1 | ForEach-Object { . $_.FullName }

# Local settings
$localProfilePath = "$PSScriptRoot\profile.local.ps1"
if (Test-Path $localProfilePath) {
  . $localProfilePath
}

# prompt
# ------
if (Test-CommandExists starship) {
  Invoke-Expression (&starship init powershell)
} 
else {
  Import-Module posh-git
  Import-Module oh-my-posh

  # Start the default settings
  # Set-Prompt
  # Alternatively set the desired theme:
  Set-Theme Agnoster
}