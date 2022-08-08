function Get-BitbucketCommits {
    param (
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
        [string] $Username,
        
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
        [string] $Password,

        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
        [string] $BitBucketCommitsUrl 
    )
    
    Write-Verbose("[URL] " + $BitBucketCommitsUrl)
    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $Username,$Password)))
    $response = Invoke-RestMethod -Uri $BitBucketCommitsUrl -Headers @{Authorization = "Basic $base64AuthInfo" } -Method Get
    Write-Verbose("Azure change response:" + ($response | ConvertTo-Json -Depth 100))

    $build_changes = $response.values | ForEach-Object { $_.message }

    Write-Verbose("[Build Changes count] " + $build_changes.Count)
    Write-Verbose("[Build Changes] " + ($build_changes | ConvertTo-Json -Depth 100))
    $build_changes
}
