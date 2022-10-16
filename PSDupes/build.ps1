Import-Module Microsoft.Powershell.Crescendo
$NewConfiguration = @{
    '$schema' = 'https://aka.ms/PowerShell/Crescendo/Schemas/2021-11'
    Commands  = @()
}
$parameters = @{
    Verb         = 'Invoke'
    Noun         = 'PSdupes'
    OriginalName = "$PSScriptRoot\jupes\jdupes.exe"
}
$NewConfiguration.Commands += New-CrescendoCommand @parameters
$NewConfiguration | ConvertTo-Json -Depth 3 | Out-File .\PSdupes.json