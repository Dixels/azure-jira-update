function Get-BitbucketCommits {
    param (
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
        [string] $Username,
        
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
        [string] $Password,

        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
        [string] $BitBucketCommitsUrl,
        
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
        [string] $BitbucketLastBuildCommitHash 
    )
    
    Write-Verbose("[URL] " + $BitBucketCommitsUrl)
    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $Username,$Password)))
    $response = Invoke-RestMethod -Uri $BitBucketCommitsUrl -Headers @{Authorization = "Basic $base64AuthInfo" } -Method Get
    Write-Verbose("Azure change response:" + ($response | ConvertTo-Json -Depth 100))

    Write-Debug("[BitbucketLastBuildCommitHash] " + $BitbucketLastBuildCommitHash)
    $build_changes = foreach ($_ in $response.values) {
        if ($_.hash -eq $BitbucketLastBuildCommitHash) { break }
        $_.message.Split([Environment]::NewLine)[0]
    }
    Write-Debug("[build_changes] " + $build_changes)

    Write-Verbose("[Build Changes count] " + $build_changes.Count)
    Write-Verbose("[Build Changes] " + ($build_changes | ConvertTo-Json -Depth 100))
    $build_changes
}
