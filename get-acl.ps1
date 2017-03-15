# Source: https://mywinsysadm.wordpress.com/2011/08/17/powershell-reporting-ntfs-permissions-of-windows-file-shares/

#Set variables
$path = "\\qbefiles\depts\Financial\Secure\SP\Financial_Reporting_FPS"
$filename = "Files.txt"
$date = Get-Date

#Place Headers on out-put file
$list = "Permissions for directories in: $Path"
$list | format-table | Out-File $filename
$datelist = "Report Run Time: $date"
$datelist | format-table | Out-File -append $filename
$spacelist = " "
$spacelist | format-table | Out-File -append $filename

#Populate Folders Array
[Array] $folders = Get-ChildItem -path $path -force -recurse | Where {$_.PSIsContainer}

#Process data in array
ForEach ($folder in [Array] $folders)
{
	#Convert Powershell Provider Folder Path to standard folder path
	$PSPath = (Convert-Path $folder.pspath)
	$list = ("Path: $PSPath")
	$list | format-table | Out-File -append $filename

	Get-Acl -path $PSPath | Format-List -property AccessToString | Out-File -append $filename

} #end ForEach
