$computername = "."
$vhdsUsed=@()
$vhdsOnDisk=@()
$vhdsOnDisk += Get-ChildItem -path (Get-VMHost -ComputerName $computername).VirtualHardDiskPath -Attributes !readonly

foreach ($vm in (Get-VM -ComputerName $computername)) {
    Write-Verbose $vm.VMName
    foreach ($hardDrive in $vm.HardDrives) {
        $vhdsUsed += Get-ChildItem -LiteralPath $hardDrive.Path
        
    }
}
Compare-Object -ReferenceObject $vhdsUsed -DifferenceObject $vhdsOnDisk  -property FullName -passThru | Where-Object { $_.SideIndicator -eq '=>' }

