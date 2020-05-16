
function Select-MyAzSubscription {
    if ((test fzf) && (test jq)) {
        Get-AzSubscription | ConvertTo-Json | jq '.[] | {name: .Name, id: .Id}' -c | fzf | jq -r '.id' | % { Select-AzSubscription $_ }
    }
    else {
        Get-AzSubscription | Out-GridView -PassThru | Select-AzSubscription
    }
}

function az-select-subscription {
    if ((test fzf) && (test fq)) {
        az account list | jq '.[] | {name: .name, id: .id}' -c | fzf | jq -r '.id' | % { az account set -s $_ }
    }
}

Set-Alias azsub Select-MyAzSubscription
Set-Alias azlogin Login-AzAccount
Set-Alias azexit Logout-AzAccount

function Select-AzPSObject ($PSObject) {
    if ((test fzf) && (test jq)) {
        return $PSObject | ConvertTo-Json | jq '.[] | {Name: .Name, ResourceGroupname: .ResourceGroupName}' -c | fzf | ConvertFrom-Json
    }
    else {
        return $PSObject | Out-GridView -PassThru
    }
}