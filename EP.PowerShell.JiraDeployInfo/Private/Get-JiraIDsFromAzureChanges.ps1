function Get-JiraIDsFromAzureChanges {
    param (
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
        [string] $SystemAccessToken,
        
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
        [string] $AzureChangeUrl
    )

    $jiraIDs = @()
    Get-AzureDevopsBuildChanges -SystemAccessToken $SystemAccessToken -AzureChangeUrl $AzureChangeUrl | ForEach-Object {
        Find-JiraIDs ($_) | ForEach-Object {
            $jiraIDs += $_.Value.ToUpper()
        }
    }
    $jiraIDs | Sort-object | Get-Unique -AsString
}
