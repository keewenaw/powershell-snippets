$file = "userlist.txt"
$outfile = "output.txt"

foreach ($user in Get-Content $file) {
	try {
		$userinfo = Get-ADUser -Identity $user
    # ? -ObjectAttributes @{edsvaDeprovisionType=1}
		if ($userinfo.name.Contains("Deprovision")) {
			echo "Deprovisioned" >> $outfile
		} else {
			echo "Exists" >> $outfile
		}
	} catch {
		echo "Does not exist" >> $outfile		
	}
}
