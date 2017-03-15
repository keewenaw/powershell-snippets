$file="emails.txt"
$output="userlist.txt"

Get-Content $file | Foreach-Object {
	$mail = $_ # get-aduser below won't accept $_
	try {
		$name = Get-ADUser -Filter {EmailAddress -like $mail} | foreach {$_.name}
		$name = $name.split(" ")[-1]
	} catch {
		$name = ""
	}
	echo $name >> $output
} 
