$groups = @"
"@ -split "\n"

$Owner= Get-QADUser "" # | where {$_.primarysmtpaddress}

Foreach ($group in $groups) {
	$group = $group.trim()
	$name = $owner | Select-Object -ExpandProperty displayname
	$id = $owner | Select-Object -ExpandProperty samaccountname
	Set-QADGroup -Identity "QBEAI\$group" -Notes "Owner: $id $name" -ObjectAttributes @{Extensionattribute1="$name";Extensionattribute2="$id";Extensionattribute3="$id"} 
}
