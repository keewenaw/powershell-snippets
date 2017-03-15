<#
	.SYNOPSIS
	For a given directory ($path), finds all subdirectories, gets ACL/permissions
	for each, parses all irrelevant security groups out, and gets membership for 
	each group

	.OUTPUT
	Three files:
	1) $permissions (Permissions.txt by default)
		A listing of all subdirectories and ACL
	2) $cleanfile (dirgroups.txt by default)
		A listing of all unique security groups in $permissions
	3) $userlist (Users.txt by default)
		A listing of all users who can access $permissions

	.EXAMPLE
	PS F:\> .\get-users-with-drive-access.ps1

	.NOTES
	CREATED:    08/23/2016
#>


#Set-ExecutionPolicy RemoteSigned

### Go through all subdirectories in the given directory and get a list of permissions

$server = ""
$shares = @"
"@ -split "\n"


ForEach ($share in $shares) {
	#Set variables
	$share = $share.trim()
	$path = "\\$server\$share"
	echo "Drive: $path"
	
	$permissions = "$share" + "_permissions.txt" # Output - all dirs listing w/ permissions
	$date = Get-Date
	
	# Source for this section: https://mywinsysadm.wordpress.com/2011/08/17/powershell-reporting-ntfs-permissions-of-windows-file-shares/
	#Place Headers on output file	
	$list = "Permissions for directories in: $path"
	$list | format-table | Out-File $permissions
	$datelist = "Report Run Time: $date"
	$datelist | format-table | Out-File -append $permissions
	$spacelist = " "
	$spacelist | format-table | Out-File -append $permissions
	
	#Populate Folders Array
	echo "Getting filepaths ..."
	[Array] $folders = Get-ChildItem -path $path -force -recurse | Where {$_.PSIsContainer}
	
	#Process data in array
	echo "Getting permissions for filepaths ..."
	ForEach ($folder in [Array] $folders) {
		#Convert Powershell Provider Folder Path to standard folder path
		$PSPath = (Convert-Path $folder.pspath)
		$list = ("Path: $PSPath")
		$list | format-table | Out-File -append $permissions
		if ($PSPath) {
			Get-Acl -path $PSPath | Format-List -property AccessToString | Out-File -append permissions
		}
	} #end ForEach



	### Get the useful Dir groups for information

	# Working files
	$testfile = "temp.txt"
	$cleanfile = "$share" + "_dirgroups.txt" # Output - all unique security groups in $permissions
	$domain = ""

	foreach ($line in get-content $permissions) {
	$line = $line.trim()
	if ($line -AND !$line.StartsWith("Path:")) {
		if ($line.Contains("$domain")) {
			$line = "$domain\" + $line.split([string[]]"$domain\", [StringSplitOptions]"None")[1]
			if ($line) {
				$line = $line.split([string[]]"Allow", [StringSplitOptions]"None")[0]
				if ($line) {
					echo $line >> $testfile
				}
			}
		}
	}
}

echo "Cleaning output ..."
# Remove all duplicates and clean up final output
gc $testfile | Sort | Get-Unique >> $cleanfile
Remove-Item $testfile



### Get all members of each listed group

$userlist = "$share" + "_users.txt" # Output - All users with permissions

Echo "Retrieving users ..."
ForEach ($value in Get-Content $cleanfile){
	$value = $value.trim()
	echo "$value" >> $userlist
	Try {
		Get-ADGroupMember $value -Recursive | Select-Object Name >> $userlist
	} Catch {
		echo "Empty" >> $userlist
	}
	echo "" >> $userlist
	echo "" >> $userlist
	echo "" >> $userlist
}

echo ""
echo ""
echo "" 

} ###################

echo "Done"




