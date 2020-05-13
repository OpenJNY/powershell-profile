function which ($name) { Get-Command -Name $name | Format-List * }
function open ($filename) { Start-Process $filename }
function settings { Start-Process ms-setttings: }

# rm alternative
Set-Alias trash Remove-ItemSafely

function tf-clean {
    if (Test-Path "./terraform.tfstate") { Remove-Item "./terraform.tfstate" }
    if (Test-Path "./.terraform" ) { Remove-Item -Path "./.terraform" -Recurse }
}