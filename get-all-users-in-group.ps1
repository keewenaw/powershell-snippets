$input = "users.txt"
$group = "Test"
$output = "report.txt"

foreach ($user in Get-Content $input) {
	$memberOf = Get-QADMemberOf -Identity $user -Name $group

	if($memberOf) {
		echo $user >> $output
	}
}
