$file = "contacts.txt" # Input file
$company = "" # Name of third party these contacts are for
$OU = "" # OU to create contacts in 

foreach ($line in Get-Content $file) {
	$line = $line.trim() # Format "firstname lastname email"
	$data = $line.split(" ")
	$firstname = $data[0].trim()
	$lastname = $data[1].trim()
	$email = $data[2].trim()

	New-ADObject -Type contact -Name "$firstname $lastname - $company" -Path $OU -OtherAttributes @{
		'displayname'= "$firstname $lastname - $company";
		'givenName' = $firstname;
		'sn' = $lastname;
		'mail' = $email
	}
}
