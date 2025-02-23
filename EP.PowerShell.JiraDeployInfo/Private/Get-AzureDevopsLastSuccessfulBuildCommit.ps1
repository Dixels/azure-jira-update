function Get-AzureDevopsLastSuccessfulBuildCommit {
    param (
        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
        [string] $SystemAccessToken,

        [Parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]
        [string] $AzureLastSuccessfulBuildUrl 
    )
    
    $token = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($SystemAccessToken)"))
    $response = Invoke-RestMethod -Uri $AzureLastSuccessfulBuildUrl -Headers @{Authorization = "Basic $token" } -Method Get
    Write-Verbose("Azure last successful build response:" + ($response | ConvertTo-Json -Depth 100))
    $commit_id = if ($response.value.count -gt 0) { $response.value[0].sourceVersion } else { 'noHashFound' }
    Write-Verbose("[Azure last successful build commit] " + $commit_id)
    $commit_id
}
