#Create Variables for Log Path Directory, Log Path File, Disk Information, Bios #Information #and Installed Products (Applications) Information and Today's Date. Use CIM cmdlets 
########################################################################

$logfile = "$HOME\Documents\Win213\Lab4"
$logfilepath = "$HOME\Documents\Win213\Lab4\LearnName_Lab4_Logfile.log"
$date = Get-Date
$DiskInfo = Get-WmiObject win32_diskdrive | select-object -property Model,Size | format-table -AutoSize
$biosinfo = get-wmiobject win32_bios | select-object -property Manufacturer,SMBiosVersion,Version | format-table -Autosize
#$appinfo = get-wmiobject win32_product | select-object -property caption,version | format-table -AutoSize



#Create a Message “Gathering Machine Information on <computername>. Please wait…”
#########################################################################

write-host "Gathering Machine Information on <$env:computername>"


#Create Log file and output Log File Title with Computer Name and Date of Report
########################################################################

write-output "Summary information for computer <$env:computername> on <$date>" | Out-file -filepath "$logfilepath"
write-output "=====================================================================================" | out-file -filepath "$logfilepath" -append


 #Create a Disk Drive Summary Header, Get Disk Information and Output to log file
########################################################################

write-output "`n`n`n`n" | out-file "$LogFilePath" -append
write-output "Disk Drive Summary" | out-file -filepath "$logfilepath" -append
write-output "=====================================================================================" | out-file -filepath "$logfilepath" -append
write-output $DiskInfo | out-file -filepath "$logfilepath" -append
write-output "=====================================================================================" | out-file -filepath "$logfilepath" -append



#Create a Bios Summary Header, Get Bios Information and Output to log file
########################################################################

write-output "`n`n`n`n" | out-file "$LogFilePath" -append
write-output "`n `n `n Bios Version Summary" | out-file -filepath "$logfilepath" -append
write-output "=====================================================================================" | out-file -filepath "$logfilepath" -append
write-output $biosinfo | out-file -filepath "$logfilepath" -append

#Create an Installed Software Summary Header, Get Product Information and Output to #log file
#######################################################################

write-output "`n`n`n`n" | out-file "$LogFilePath" -append
write-host "`n `n `n  Installed Software Summary" | out-file -filepath "$logfilepath" -append
write-output "=====================================================================================" | out-file -filepath "$logfilepath" -append
write-output $appinfo | out-file -filepath "$logfilepath" -append
write-output "=====================================================================================" | out-file -filepath "$logfilepath" -append

#Display a Message Log File Created.
########################################################################

write-output "`n `n `n `nLogfile path <$logfile> has been created"