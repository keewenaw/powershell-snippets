### Go through all subdirectories in the given directory and list them
# Source: https://mywinsysadm.wordpress.com/2011/08/17/powershell-reporting-ntfs-permissions-of-windows-file-shares/

$path = "" # Path to search
$permissions = "Out.txt" # Output - all dirs listing w/ permissions
$date = Get-Date

#Place Headers on out-put file
$list = "Subfolders in: $path"
$list | format-table | Out-File $permissions
$datelist = "Report Run Time: $date"
echo $datelist
$datelist | format-table | Out-File -append $permissions
$spacelist = " "
$spacelist | format-table | Out-File -append $permissions

#Populate Folders Array
echo "Getting filepaths ..."
[Array] $folders = Get-ChildItem -path $path -force -recurse -ErrorAction SilentlyContinue | Where {$_.PSIsContainer}

#Process data in array ...
echo "Formatting filepaths ..." 
ForEach ($folder in [Array] $folders) {
	#Convert Powershell Provider Folder Path to standard folder path
	$PSPath = (Convert-Path $folder.pspath)
	$list = ("$PSPath")
	$list | format-table | Out-File -append $permissions
} #end ForEach

