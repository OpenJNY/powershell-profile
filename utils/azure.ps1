
function Select-MyAzSubscription {
    Get-AzSubscription | Out-GridView -PassThru | Select-AzSubscription
}
Set-Alias azsub Select-MyAzSubscription