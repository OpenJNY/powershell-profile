
function Select-MyAzSubscription {
    if ((test fzf) && (test jq)) {
        Get-AzSubscription | ConvertTo-Json | jq '.[] | {name: .Name, id: .Id}' -c | fzf | jq -r '.id' | % { Select-AzSubscription $_ }
    }
    else {
        Get-AzSubscription | Out-GridView -PassThru | Select-AzSubscription
    }
}
Set-Alias azsub Select-MyAzSubscription
Set-Alias azlogin Login-AzAccount
Set-Alias azexit Logout-AzAccount