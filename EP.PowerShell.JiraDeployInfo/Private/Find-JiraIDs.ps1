function Find-JiraIDs {
    param (
        $message
    )
    $pattern = '\w{2,10}-\d{1,4}'
    $values = [regex]::Matches($message.Split('\n')[0], $pattern) | Select-Object value 
    Write-Debug ("[JIRA IDs] " + $values)
    $values
}
