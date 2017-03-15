$file="users.csv"
$out="ids.txt"

Import-Csv $file | %{
	$first=$_.first
	$last=$_.last
	$filter="Name -like ""$last*$first*"""
	$userobj=Get-ADUser -filter $filter
	if ($userobj) {
		echo $userobj.SamAccountName >> $out
	} else {
		echo "" >> $out
	}
}
