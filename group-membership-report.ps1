# $groups = Get-ADGroup -filter {name -like "*test*"} | %{$_.name}
$groups = @"
"@ -split "\n"

$file = "Report.txt"	
ForEach ($value in $groups){
	$value = $value.trim()
	echo "$value" >> $file 
	echo "" >> $file 
	Try {
		Get-ADGroupMember $value | Select-Object Name | foreach {$_.name} >> $file 
		#(Get-ADGroup $value -Properties Members).Members | %{echo $_.split(",")[0].split("=")[1]} >> $file 
	} Catch {
		echo "Does not exist" >> $file 
	}
	echo "" >> $file 
	echo "" >> $file 
	echo "" >> $file 
}

echo "Done"
