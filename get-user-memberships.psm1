Function GetUserMembership
{
	<#
	.SYNOPSIS
		Dumps all AD group names that the user is a member of
	.DESCRIPTION
		Dumps all AD group names that the user is a member of
	.NOTES
		File Name  : get-user-membership.ps1
	#>
	[cmdletBinding()]
	param(
        	[Parameter(Mandatory=$true,
        		ValueFromPipeline=$true,
		        ValueFromPipelineByPropertyName=$true,
        		HelpMessage="This is the network ID of the user.")]
        	$user
	)

	$user = $user.trim()
	echo ""
	Get-ADPrincipalGroupMembership -Identity $user | foreach { $_.name } | sort
	echo ""
}
