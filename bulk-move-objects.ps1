$file="dns.txt" # List of distinguished names of objects to move
$new_ou="" # DN of OU to move to

foreach($dn in gc $file) {
	$dn=$dn.trim()
	Move-ADObject $dn -TargetPath $new_ou
}
