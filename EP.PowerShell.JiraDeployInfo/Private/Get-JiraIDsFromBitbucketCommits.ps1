function Get-JiraIDsFromBitbucketCommits {
    param (
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
        [string] $SystemAccessToken,
        
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
        [string] $AzureLastSuccessfulBuildUrl,
        
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
        [string] $Username,
        
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
        [string] $Password,

        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
        [string] $BitBucketCommitsUrl 
    )

    $jiraIDs = @()
    $last_commit = Get-AzureDevopsLastSuccessfulBuildCommit -SystemAccessToken $SystemAccessToken -AzureLastSuccessfulBuildUrl $AzureLastSuccessfulBuildUrl
    Write-Debug("[last_commit]" + $last_commit)
    Write-Debug("[AzureLastSuccessfulBuildUrl]" + $AzureLastSuccessfulBuildUrl)
    Get-BitbucketCommits -Username $Username -Password $Password -BitBucketCommitsUrl $BitBucketCommitsUrl -BitbucketLastBuildCommitHash $last_commit | ForEach-Object {
        Find-JiraIDs ($_) | ForEach-Object {
            $jiraIDs += $_.Value.ToUpper()
        }
    }
    $jiraIDs | Sort-object | Get-Unique -AsString
}
