#vault agent exec -config="C:/vault-agent/vault-agent.hcl" -- powershell -File "C:/vault-agent/convert-and-import-cert.ps1"
# CERT FILES
$pemFile = "C:\vaultagent\cert.txt"  # PEM bundle containing cert and private key
$pfxFile = "C:\vaultagent\cert.pfx"       # Output PFX file

# ENV VARIABLE FOR PFX PASSWORD
$pfxPassword = $env:CERT_PASSWORD

if (-not $pfxPassword) {
    Write-Host "Error: CERT_PASSWORD environment variable is not set."
    exit 1
}

# Step 1: CERTUTIL CONVERSION
Write-Host "Converting PEM to PFX..."
$opensslCommand = "pkcs12 -export -out `"$pfxFile`" -in `"$pemFile`" -passout pass:`"$pfxPassword`""
#-mergePFX may be better
Invoke-Expression "openssl.exe $opensslCommand"

if (-not (Test-Path $pfxFile)) {
    Write-Host "Error: Failed to create PFX file."
    exit 1
}

Write-Host "PFX file created successfully."

# Step 2: Import PFX into Windows Certificate Store
Write-Host "Importing PFX into Windows Certificate Store..."

$securePassword = ConvertTo-SecureString -String $pfxPassword -Force -AsPlainText
$certStoreLocation = "Cert:\LocalMachine\My"  # Change to Root if needed (Trusted Root CA)

# Import the PFX file
Import-PfxCertificate -FilePath $pfxFile -CertStoreLocation $certStoreLocation -Password $securePassword

Write-Host "Certificate imported successfully into $certStoreLocation"
