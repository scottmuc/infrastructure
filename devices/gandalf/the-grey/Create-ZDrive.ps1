$sharePath = "\\erebor\mcap"
$driveLetter = "Z:"
$username = "smbrw"

if (Test-Path $driveLetter) {
    Write-Host "Drive $driveLetter already exists."
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 0
}

$cred = Get-Credential -UserName $username -Message "Enter password for $username"
$password = $cred.GetNetworkCredential().Password
$result = net use $driveLetter $sharePath /user:$username $password /persistent:yes

if ($LASTEXITCODE -eq 0) {
    Write-Host "Successfully mapped $sharePath to $driveLetter"
} else {
    Write-Host "Failed to map drive. Error code: $LASTEXITCODE"
}

Write-Host "`nPress any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")