$base_OU="" # OU to look in
$title="" # Title to search for

#$OU_list = Get-ADOrganizationalUnit -SearchBase $base_OU -SearchScope Subtree -Filter * | foreach { $_.DistinguishedName }

$filter="title -like ""*$title*"""
Get-ADUser -SearchBase $base_OU -Filter $filter | foreach {$_.name} | sort
