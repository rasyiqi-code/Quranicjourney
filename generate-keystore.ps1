# Script untuk generate keystore untuk Quranic Journey  
# Lokasi keystore akan disimpan di parent directory project

$keystorePath = "C:\DESKTOP\quranic-journey-upload.jks"
$alias = "upload"
$password = "quranic2024"
$dname = "CN=Quranic Journey, OU=Dev, O=Quranic Journey, L=Jakarta, ST=Jakarta, C=ID"

Write-Host "Mencari keytool..." -ForegroundColor Yellow

# Cari Java dari Android Studio
$androidStudioJava = "C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe"
$javaHome = $env:JAVA_HOME

if (Test-Path $androidStudioJava) {
    $keytool = $androidStudioJava
    Write-Host "Menggunakan Java dari Android Studio" -ForegroundColor Green
} elseif ($javaHome -and (Test-Path "$javaHome\bin\keytool.exe")) {
    $keytool = "$javaHome\bin\keytool.exe"
    Write-Host "Menggunakan Java dari JAVA_HOME" -ForegroundColor Green
} else {
    Write-Host "ERROR: keytool not found!" -ForegroundColor Red
    Write-Host "Install Java JDK atau Android Studio terlebih dahulu" -ForegroundColor Red
    exit 1
}

Write-Host "`nGenerating keystore..." -ForegroundColor Yellow
Write-Host "Location: $keystorePath" -ForegroundColor Cyan

& $keytool -genkey -v `
    -keystore $keystorePath `
    -keyalg RSA `
    -keysize 2048 `
    -validity 10000 `
    -alias $alias `
    -storepass $password `
    -keypass $password `
    -dname $dname

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n✅ Keystore berhasil dibuat!" -ForegroundColor Green
    Write-Host "Location: $keystorePath" -ForegroundColor Cyan
    Write-Host "Alias: $alias" -ForegroundColor Cyan
    Write-Host "Password: $password" -ForegroundColor Yellow
    Write-Host "`n⚠️  SIMPAN PASSWORD INI! Anda memerlukannya untuk upload ke Play Store" -ForegroundColor Yellow
} else {
    Write-Host "`n❌ Gagal membuat keystore" -ForegroundColor Red
}
