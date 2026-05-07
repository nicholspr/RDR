[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [string]$HostName = "rdr.nichsoft.io",
    [string]$UserName = "root",
    [string]$RemotePath = "/docker/rdr/site",
    [string]$SiteUrl = "https://rdr.nichsoft.io",
    [string]$IdentityFile = ""
)

$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$filesToDeploy = @(
    "index.html",
    "styles.css"
)

$sshArgs = @()
$scpArgs = @()

if ($IdentityFile) {
    $resolvedIdentityFile = Resolve-Path -LiteralPath $IdentityFile
    $sshArgs += "-i", $resolvedIdentityFile.Path
    $scpArgs += "-i", $resolvedIdentityFile.Path
}

foreach ($file in $filesToDeploy) {
    $fullPath = Join-Path $projectRoot $file
    if (-not (Test-Path -LiteralPath $fullPath)) {
        throw "Required file not found: $fullPath"
    }
}

$remoteTarget = "$UserName@${HostName}`:$RemotePath/"

if ($PSCmdlet.ShouldProcess($remoteTarget, "Create remote directory")) {
    & ssh @sshArgs "$UserName@$HostName" "mkdir -p '$RemotePath'"
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to create remote directory: $RemotePath"
    }
}

foreach ($file in $filesToDeploy) {
    $fullPath = Join-Path $projectRoot $file
    if ($PSCmdlet.ShouldProcess($remoteTarget, "Upload $file")) {
        & scp @scpArgs $fullPath "$remoteTarget$file"
        if ($LASTEXITCODE -ne 0) {
            throw "Failed to upload $file"
        }
    }
}

if ($SiteUrl) {
    Write-Host "Verifying $SiteUrl ..."
    try {
        $response = Invoke-WebRequest -Uri $SiteUrl -Method Head -UseBasicParsing -TimeoutSec 30
        Write-Host "Deployment complete. HTTP status: $($response.StatusCode)"
    }
    catch {
        Write-Warning "Upload completed, but HTTP verification failed: $($_.Exception.Message)"
    }
}