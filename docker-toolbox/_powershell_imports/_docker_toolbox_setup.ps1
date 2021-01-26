$EnvVars = docker-machine env --shell powershell | Select-String -Pattern '\$Env:(.*) = "(.*)"' -AllMatches

ForEach ($Match in $EnvVars.Matches)
{
    $k = $Match.Groups[1]
    $v = $Match.Groups[2]
    Write-Host "$k = $v"
    [Environment]::SetEnvironmentVariable($k, $v, "User")
}
