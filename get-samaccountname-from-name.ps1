$file="names.txt"
$output="userlist.txt"

Get-Content $file | Foreach-Object {
	$name = $_ # get-aduser below won't accept $_
	$lastname = $name.split(" ")[-1].trim()
	#$firstname = $name.SubString(0, $name.LastIndexOf(' ')).trim()
	$firstname = $name.split(" ")[0].trim()
	$filter = "DisplayName -like ""$firstname $lastname"""
	try {
		$name = (Get-ADUser -filter $filter)
		if ($name) {
			$name = $name.SamAccountName
		} else {
			$name = ""
		}
	} catch {
		$name = ""
	}
	echo $name >> $output
} 
