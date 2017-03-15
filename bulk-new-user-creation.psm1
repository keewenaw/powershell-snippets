Function Create-BulkUsers
{
	<#
	.SYNOPSIS
		Creates shell new user accounts in bulk
	.DESCRIPTION
		Creates shell new user accounts in bulk
	.NOTES
		File Name  : new-user-bulk-import.ps1
    
	A template is needed to run; place it in the same directory as your scripts
    
	You MUST:
		-Set the expiration date
		-Add groups as necessary
		-Create an email
	#>

	[cmdletBinding()]
	param(
		[Parameter(Mandatory=$true,
			ValueFromPipeline=$true,
			ValueFromPipelineByPropertyName=$true,
			HelpMessage="This is the template CSV file, filled out.")]
		$file
	)

	Import-Module ActiveDirectory # needed if running as SU
 
	Import-CSV $file | %{New-QADUser -FirstName $_.Firstname -LastName $_.lastname -Description ($_.SamAccountName + " POC " + $_.ManagerName) -Office $_.office -StreetAddress $_.streetaddress -city $_.city -stateorprovince $_.stateorprovince -samaccountname $_.samaccountname –Manager $_.Managersamaccountname -userpassword $_.userpassword -name ($_.lastname+” “+$_.firstname+” “+$_.samaccountname) -ParentContainer  $_.OU -Object @{extensionattribute1 = $_.managername; extensionattribute2 = $_.managersamaccountname} -DisplayName ($_.firstname+" "+$_.lastname) -UserPrincipalName ($_.firstname+"."+$_.lastname)}
}
