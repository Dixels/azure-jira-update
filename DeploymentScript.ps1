Import-Module (Join-Path "." "EP.PowerShell.JiraDeployInfo")
$DebugPreference="Continue"
Update-AzureDeploymentInformation -State $Env:JIRA_STATE -EnvironmentType $Env:JIRA_ENVIRONMENT -JiraDomain $Env:JIRA_DOMAIN -BitBucketUsername $Env:BITBUCKET_USERNAME -BitBucketPassword $Env:BITBUCKET_PASSWORD
