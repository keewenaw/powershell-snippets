<#
  .SYNOPSIS
  	Diffs two files to see the differences in their contents

  .PARAMETER file1
  	The first file to diff
  .PARAMETER file2
		The secondfile to diff
	.PARAMETER verbose
		Do you want to see the actual differences or not?
        
  .EXAMPLE
   	PS C:\> .\diff file1.txt file2.txt F

  .NOTES
   	CREATED:    08/25/2016
#>

Param(
    [Parameter(HelpMessage="First file",Position=0,ValueFromPipeline=$true,Mandatory=$true)]
    [String]$file1,
    [Parameter(HelpMessage="Second file",Position=1,ValueFromPipeline=$true,Mandatory=$true)]
    [String]$file2,
    [Parameter(HelpMessage="Verbose output? (T/F)",Position=2,ValueFromPipeline=$true,Mandatory=$false)]
    [String]$wordy
)
    
$file1contents = Get-Content $file1 # Get contents of file 1
$file2contents = Get-Content $file2 # Get contents of file 2

# Do the comparison
$diffresults = Compare-Object $(Get-Content $file1) $(Get-Content $file2) | Sort-Object { $_.InputObject.ReadCount }

# Print results
if ($wordy -eq "T") { # Print out useful input
    if (!$diffresults) { # The files are identical
        Write-Host "The files are the same"
    } else {
        $diffresults | foreach {
            $change = $_.InputObject # What the change is
            $linenumber = $_.InputObject.ReadCount # What line are we on?
	    Write-Host ""
            if (!$change) { # Change is just a space
                $change = "[space/new line]" # Make it human-readable
            }
            if ($_.SideIndicator -eq "=>") { # Only in file 2
                Write-Host "Line $linenumber : `'$change`' added to $file2"
            } elseif ($_.SideIndicator -eq "<=") { # Only in file 1
                Write-Host "Line $linenumber : `'$change`' removed from $file1"
            } else { # Shouldn't hit this
		Write-Host "Line $linenumber : unknown change made"
	    }
        }
    }
} else { # Just say whether they're the same or not
    if ($diffresults) {
        Write-Host "The files are different"
    } else {
        Write-Host "The files are the same"
    }
}
