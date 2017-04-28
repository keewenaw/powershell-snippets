$file="users.txt" # List of SAMs
$new_ou="" # DN of OU to move to

foreach($id in gc $file) { 
	$id=$id.trim() 
	$dn=${Get-ADUser $id | %{$_.DistinguishedName}} 
	Move-ADObject $dn -TargetPath $new_ou
}
