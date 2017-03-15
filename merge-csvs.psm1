Function merge-csvs
{
	<#
	.SYNOPSIS
		Merges multiple CSV files into one Excel spreadsheet
	.DESCRIPTION
		Resets PWs of multiple accounts simultaneously
    Not my code, but do not have source
	.NOTES
		File Name  : reset-password-bulk
	#>
	[cmdletBinding()]
	param(
        	[Parameter(Mandatory=$true,
        		ValueFromPipeline=$true,
		        ValueFromPipelineByPropertyName=$true,
        		HelpMessage="This is the directory where all CSVs are stored.")]
        	$path
	)

	if ($path.substring($path.length - 1, 1) -ne "\") {
		$path = $path + "\"
	}

	$outputfilename = "Merged.xlsx"
	$csvs = Get-ChildItem $path -Include *.csv
	$y=$csvs.Count

	if ($y -lt 1) {
		Write-Host "No CSVs found in this directory : $path. Exiting."
		break
	}

	Write-Host “Detected the following CSV files: ($y)”

	foreach ($csv in $csvs) {
		Write-Host ” “$csv.Name
	}
	
	Write-Host "Creating: $outputfilename"
	$excelapp = new-object -comobject Excel.Application
	$excelapp.sheetsInNewWorkbook = $csvs.Count
	$xlsx = $excelapp.Workbooks.Add()
	$sheet=1

	foreach ($csv in $csvs) {
		Write-Host “Processing File: ” $csv.Name
		$row=1
		$column=1
		$worksheet = $xlsx.Worksheets.Item($sheet)
		#$worksheet.Name = $csv.Name.Substring(0, [System.Math]::Min(31, $s.Length))
		$worksheet.Name = $sheet
		$file = (Get-Content $csv)
		foreach($line in $file) {
			$linecontents=$line -split ‘,(?!\s*\w+”)’
			foreach($cell in $linecontents) {
				#$cell = $cell.TrimStart(‘”‘)
				#$cell = $cell.TrimEnd(‘”‘)
				$cell = $cell.replace("`"","")
				$worksheet.Cells.Item($row,$column) = $cell
				$column++
			}
			$column=1
			$row++
		}
		$sheet++
	}

	$output = $path + $outputfilename
	$xlsx.SaveAs($output)
	$excelapp.quit()
}
