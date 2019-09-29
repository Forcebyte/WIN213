<#
.SYNOPSIS
  Tests the path to working directory path and moves course files
.DESCRIPTION
    The scripts uses the ARGS array to store the working directory and directory name to create.
    It then compares the working directory to the $PWD variable, if the user is not in the correct directory
    a mesage is displayed and the user is moved to the correct directory. The script checks for the existance of a parent folder and if it is empty:
    If the folder exists the script renames the folder, if it does not the script creates the folder and subfolders
    A recursive search is done to move all of the course files, which are stored in a folder win213xCopy. The files are then
    sorted by file tag, and moved to the appropriate subfolder. A coutner is enabled to indicate the number of files moved
.EXAMPLE
    PS:> .\Win213R_Lab_TestDir.ps1 workingdirectory directoryname
.Notes
        Author:  Patrick TUrney
        DateLastModified:  Oct/4/2017
#>
## 1: Create 2 Command line variables
#############################################################################

$WorkingDirectory = $args[0]
$DirectoryName = $args[1]

## 2: Checks if variables are empty, and gets user input if nessesary
##############################################################################

If("$WorkingDirectory" -eq ""){
    write-warning "WARNING: Parameter required!"
    $WorkingDirectory = read-host "Enter absolute path to working directory"
    }
if("$DirectoryName" -eq ""){
    Write-warning "WARNING: Parameter required!"
    $directoryname = read-host "Enter directory name to search for in "$WorkingDirectory""
    }

## 3: Test to see if PWD is equal to WorkingDirectory, and if not, move the user
##############################################################################
If("$WorkingDirectory" -eq $PWD){
    write-warning "You are not in the <"$WorkingDirectory">. Do you wkish to move? Press CTRL+C to exit or,"
    pause
    set-location $WorkingDirectory
    }
## 4: Test if directory exists in the working directory
##############################################################################
if ((test-path $DirectoryName) -ne "True"){
    write-warning "Directory <$Directoryname> does not exist"}
Else {
        write-host "Directory <$Directoryname> Exists"}
 
if ((gci $directoryname).count -ne 0){
    write-host "Folder <$DirectoryName> is not empty and will be renamed. Press CTRL+C to exit or,"
    pause
    rename-item Win213x Win213x.OLD}
    exit
else{
new-item -name "$DirectoryName" -ItemType Directory
        }

## 5: Create Variables for Subfolders
##############################################################################
$sub1 = "Lectures"
$sub2 = "Labs"
$sub3 = "Assignment"
$sub4 = "Scripts"

## 6: Loop through collection to create subfolders
##############################################################################
foreach-object $for in ($sub1,$sub2,$sub3,$sub4){
    new-item -ItemType Directory -name $for
}

## 7: Search Documents Folder recursively for files only and save them to a new directory called Win213Copy
##############################################################################
$Files = get-childitem -File *
new-item -name "Win213Copy" -itemtype Directory
$sub1, $sub2, $sub3, $sub4 | copy-item Win213Copy -force

## 8: Get a listing of the files in the copy folder and move them to the appropriate subfolder
##############################################################################

$count = (get-childitem $PWD\Win213Copy | Measure-Object).Count
    Move-Item -Path Win213copy\*Lec*\ -Destination Win213x\Lectures
        Move-Item -Path Win213copy\*Lab*\ -Destination Win213x\Labs
          Move-Item -Path Win213copy\*Assign*\ -Destination Win213x\Assignment
            Move-Item -Path Win213copy\*.ps1\ -Destination Win213x\Scripts


    $count = $count + 1
## 9: Display a message "<$count> files moved"
##############################################################################
write-host "<$count> files moved"

## 10: Remove Temporary Copy Folder
##############################################################################
remove-item -force Win213Copy
if ((Test-Path Win213Copy) -ne "True"){
    Write-host "Directory Win213Copy has been removed"
   }
   else{
   Write-Warning "Directory Win213Copy has not been removed"
   }


