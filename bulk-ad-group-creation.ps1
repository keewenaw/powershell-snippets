$file = "in.csv"
$ou = ""

Import-CSV $file | %{New-ADGroup -Name $_.name -Description $_.description -GroupCategory 1 -GroupScope 2 -Path $ou}
