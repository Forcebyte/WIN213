$SearchItem = "$args"
$colItems = get-wmiobject -list | where-object {$_.name -match "$SearchItem"}
$colItems | Select-Object -Property "Name"
$class = Read-Host "Enter a class name" | ForEach-Object -process {$_} 
Get-WMIObject $class | Format-List