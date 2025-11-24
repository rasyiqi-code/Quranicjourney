# Flutter Build Artifacts Copy Script
# This script copies APK and AAB files from Gradle output to where Flutter expects them
# Run this after a successful Gradle build if Flutter can't find the files

$apkSourceDir = "android\app\build\outputs\flutter-apk"
$apkDestDir = "build\app\outputs\flutter-apk"

$aabSourceDir = "android\app\build\outputs\bundle\release"
$aabDestDir = "build\app\outputs\bundle\release"

$filesCopied = 0

# Create destination directories if they don't exist
@($apkDestDir, $aabDestDir) | ForEach-Object {
    if (!(Test-Path $_)) {
        New-Item -ItemType Directory -Force -Path $_ | Out-Null
        Write-Host "Created directory: $_"
    }
}

# Copy APK files
if (Test-Path $apkSourceDir) {
    Get-ChildItem -Path $apkSourceDir -Filter *.apk | ForEach-Object {
        Copy-Item $_.FullName -Destination $apkDestDir -Force
        Write-Host "Copied APK: $($_.Name) -> $apkDestDir"
        $filesCopied++
    }
} else {
    Write-Host "APK source directory not found: $apkSourceDir"
}

# Copy AAB files
if (Test-Path $aabSourceDir) {
    Get-ChildItem -Path $aabSourceDir -Filter *.aab | ForEach-Object {
        Copy-Item $_.FullName -Destination $aabDestDir -Force
        Write-Host "Copied AAB: $($_.Name) -> $aabDestDir"
        $filesCopied++
    }
} else {
    Write-Host "AAB source directory not found: $aabSourceDir"
}

if ($filesCopied -gt 0) {
    Write-Host "`nSuccessfully copied $filesCopied file(s)!"
} else {
    Write-Host "`nNo files were copied. Make sure you've run a Gradle build first."
    exit 1
}
