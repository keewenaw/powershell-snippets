$group_remove=""
$group_add=""
$file="users.txt"

foreach ($user in Get-Content $file) {
	#$userobj = Get-ADUser $user
	echo "Attempting to modify $user ..."
	try { Remove-ADGroupMember -Identity $group_remove -Member $user -Confirm:$false } catch {}
	try { Add-ADGroupMember -Identity $group_add -Member $user -Confirm:$false } catch {}
	echo ""
}
