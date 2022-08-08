function Get-JiraIDsFromAzureChanges {
    param (
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
        [string] $Username,
        
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
        [string] $Password,

        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
        [string] $BitBucketCommitsUrl 
    )

    $jiraIDs = @()
    Get-AzureDevopsBuildChanges -SystemAccessToken $SystemAccessToken -AzureChangeUrl $AzureChangeUrl | ForEach-Object {
        Find-JiraIDs ($_) | ForEach-Object {
            $jiraIDs += $_.Value.ToUpper()
        }
    }
    $jiraIDs | Sort-object | Get-Unique -AsString
}
