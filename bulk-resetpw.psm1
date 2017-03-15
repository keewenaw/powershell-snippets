Function bulk-resetpw
{
	<#
	.SYNOPSIS
		Resets PWs of multiple accounts simultaneously
	.DESCRIPTION
		Resets PWs of multiple accounts simultaneously
		Useful for victims of phishing, etc
	.NOTES
		File Name  : bulk-resetpw.psm1
	#>
	[cmdletBinding()]
	param(
    [Parameter(Mandatory=$true,
        		ValueFromPipeline=$true,
		        ValueFromPipelineByPropertyName=$true,
        		HelpMessage="This is an array of the users' network IDs.")]
        	$users,
		[Parameter(Mandatory=$true,
        		ValueFromPipeline=$true,
		        ValueFromPipelineByPropertyName=$true,
        		HelpMessage="This is the password to reset to.")]
        	$password
	)

	Import-Module ActiveDirectory # needed if running as SU
	
	$crypted_password = ConvertTo-SecureString -AsPlainText $password -Force
	# $crypted_password = $([string]((Get-Date).dayofweek)+(Get-Random ("!", "@", "#", "$", "%", "^", "&", "*"))+(Get-Random -Minimum 10 -Maximum 99))

	ForEach ($user in $users) 
	{
		$user = $user.trim()
		Get-ADUser $user | Set-ADAccountPassword -NewPassword $crypted_password -Reset
		Get-ADUser $user | Set-AdUser -ChangePasswordAtLogon $true
    
		Write-Host “Password has been reset for the user: $user”
	} 
}
