Function ImportCustomProdLibraries {
 <#
    .SYNOPOSIS
        This function imports modules from the specified location
        
    .EXAMPLE
        PS F:\> ImportCustomProdLibraries

    .NOTES
        LASTEDIT: 03/18/2016
 #>

    #========================================================================
    # Load Script Libraries
    #========================================================================
    $lib_home = ""
    New-PSDrive -Name scripts -PSProvider filesystem -root $lib_home -ErrorAction SilentlyContinue | Out-Null
    $lib_dirs = Get-ChildItem $lib_home -Recurse | ?{$_.PSIsContainer}

    foreach($dir in $lib_dirs) {
        Write-Host "Loading the following functions for use..." -foreground yellow
        Write-Host "Location:" -noNewLine -foreground yellow
        Write-Host " $lib_home" -foreground cyan
        Get-ChildItem $dir.FullName | ?{$_.Name -like "*.psm1"} | ForEach-Object {
            Write-Host "[Including] $_" -ForegroundColor DarkMagenta
            $fp = $dir.FullName
            Import-Module "$fp\$_"
        }
    }
}
