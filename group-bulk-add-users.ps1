Import-Module ActiveDirectory #needed if running as SU

$usersfile = "users.txt"
$groupsfile = "groups.txt"

foreach ($user in Get-Content $usersfile) {
	$userobj = Get-ADUser $user
	foreach ($group in Get-Content $groupsfile) {
		echo "Attempting to add $user to $group  ..."
		Add-ADGroupMember -Identity $group -Member $user -Confirm:$false
 	}
	echo ""
}

