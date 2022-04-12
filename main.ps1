$curDir = Get-Location

Write-Host "Enter please virtual machine name" -ForegroundColor Green
$vmName = Read-Host
# if env variable is clean use "cbl-marriner-datetime"
$vmDir = $env:VAGRANT_VM_DIR

if (!$vmDir) {
    $vmDir = "~/Vagrant_Machines"
}

# create dir if it doesn't exist
$currentDatetime = Get-Date -Format "dd_MM_yyyy_HH_mm_ss"

if (!$vmName) {
    $vmName = "cbl_mariner_$currentDatetime"
}
else {
    $vmName = "cbl_mariner_$vmName`_$currentDatetime"
}

# create directory for vagrantfile

$vmPath = Join-Path $vmDir $vmName
Write-Host $vmPath
New-Item -Path $vmPath -ItemType directory -Force

Set-Location -Path $vmPath
git clone https://github.com/GaraninR/vagrant_cbl_mariner.git
Get-ChildItem $(Join-Path $vmPath "vagrant_cbl_mariner") -Force | Move-Item -Destination $vmPath
Remove-Item $(Join-Path $vmPath "vagrant_cbl_mariner")
vagrant up
Set-Location -Path $curDir