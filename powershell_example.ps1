# Powershell example:

# Asset ID
$assetId = 123  # REPLACE WITH YOUR ASSET ID

# Agent Token
$token = 'xxxxxxxxxxxxxxxxxxx'  # REPLACE WITH YOUR TOKEN

# File names to check  # REPLACE WITH LIST OF FILES TO MONITOR
$fileNames = @(
    "C:\test.txt",
    "C:\other.txt"
)

# Version and info for the agent (Version must be greater than 0.1.0, info is free format)
$version = '1.0.0'  # REPLACE WITH YOUR VERSION
$info = 'Files processed by PowerShell'  # REPLACE WITH YOUR INFO

# InfraSonar Uri for inserting check data
$uri = 'https://api.infrasonar.com/asset/{0}/collector/files/check/files' -f $assetId

$agent = @{
    name = 'files'
    info = $info
    version = $version
}

$items = @()

foreach ($fn in $fileNames) {
    $file = Get-Item -Path $fn
    $items += @{
        name = $file.Name
        size = $file.Length
        access = [int64]([DateTimeOffset]$file.LastAccessTime.ToUniversalTime()).ToUnixTimeSeconds()
        modified = [int64]([DateTimeOffset]$file.LastWriteTime.ToUniversalTime()).ToUnixTimeSeconds()
        created = [int64]([DateTimeOffset]$file.CreationTime.ToUniversalTime()).ToUnixTimeSeconds()
    }
}

$headers = @{
    'Content-Type' = 'application/json'
    'Authorization' = 'Bearer {0}' -f $token
}

$body = @{
    data = @{
        agent = @($agent)
        files = $items
    }
    version = $version
} | ConvertTo-Json -Compress -Depth 5

Invoke-RestMethod -Uri $uri -Method Post -Headers $headers -Body $body

