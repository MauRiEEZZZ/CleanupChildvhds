$computername = "."

$vhdsOnDisk = gci -LiteralPath ((Get-VMHost -ComputerName $computername).VirtualHardDiskPath) -Include "*.vhd?" -Attributes !Readonly
$vhdsUsed = @()
foreach ($vm in (Get-VM -ComputerName $computername)) {
    Write-Verbose $vm.VMName
    foreach ($vhd in $vm.HardDrives) {
        $vhdsUsed += $vhd.Path
    }
}