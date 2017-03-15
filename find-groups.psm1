function FindGroups {
	<#
	.SYNOPOSIS
		Allows you to search for relevant AD groups when you have a keyword to search on

	.PARAMETER search
		The search string to search on (must add wildcards)
        
	.EXAMPLE
		PS F:\> FindGroups -Search "*test*"

	.NOTES
		CREATED:    04/21/2016
	#>
	
	Param(
	[Parameter(Mandatory=$true)]
        $Search
	)

	echo ""
	Get-ADGroup -filter {name -like $Search} | foreach { $_.name }
	echo ""
}
