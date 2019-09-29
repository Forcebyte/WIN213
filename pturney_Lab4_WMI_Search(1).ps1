$SearchItem = "$args"
$colitems = get-wmiobject -list | where-object {$_.name -match "$SearchItem"}
$colitems | select-object -property "Name"
$class = Read-host "Enter a class name" | Foreach-Object -process {$_}
Get-WmiObject $class | Format-list