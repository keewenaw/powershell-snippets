Function Create-DL
{
	<#
	.SYNOPSIS
		Creates a DL
	.DESCRIPTION
		Creates a DL
	.NOTES
		File Name  : Create-DL.psm1
	#>

	# Needed if running as SU

	Import-Module ActiveDirectory

	# Get the DL's name

	$dlname = Read-Host "Please enter the name of the DL"
	$dlnamenospaces = $dlname.replace(' ','')
	$ownerflag = 0

	# Get the DL's owner's name and ID

	while ($ownerflag -ne 1) {
		$ownerid = Read-Host "`nPlease enter the network ID of the owner"
		try {
			$owner = Get-ADUser $ownerid
			$ownername = $($Owner | Select -ExpandProperty GivenName) + " " + $($Owner | Select -ExpandProperty Surname)
			$ownerid = $ownerid.ToUpper()
			$ownerflag = 1
		} catch {
			Write-Host "The user ID is not valid. Please try a new one."
			$ownerflag = 0
		}
	}

	# Get the DL's description

	$description = Read-Host "`nPlease enter the description of the DL"
	$ou = "" # FILL IN

	# Try to create the DL object and fill in the details

	try {
		$dlobj = New-QADGroup -Name $dlnamenospaces -DisplayName $dlname -Description $description -GroupType "Distribution" -GroupScope "Universal" -ParentContainer $ou -Notes "Owner: $ownerid $ownername" -ObjectAttributes @{Extensionattribute1="$ownername";Extensionattribute2="$ownerid";Extensionattribute3="$ownerid"} 
	} catch {
		Write-Host "There was an error creating the DL. Stopping early."
	}

	# Add users to the DL
	
	$moreusers = 1
	Write-Host "`n"
	
	while ($moreusers -eq 1) {
		$usertoadd = Read-Host "Please enter the network ID of a user to add (hit enter without input to stop)"
		if (!$usertoadd) {
			$moreusers = 0
		} else {
			try {
				$usertoadd = Get-QADUser $usertoadd
				$junk = Add-QADGroupMember -Identity $dlobj -Member $usertoadd -Confirm:$false
			} catch {
				Write-Host "The user ID is not valid. Please try a new one."
			} 
		}
	}

	# Print out the details of the created DL

	Write-Host "`n`n***DL created. Please wait for sync before notifying user of completion.***"
	Get-QADGroup $dlobj | Select-Object Name,DisplayName,GroupType,GroupScope,DN
}
