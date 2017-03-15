Function Get-SQLRights {
 <#
    .SYNOPOSIS
        This function queries the appropriate database servers to find the security group for a database
        
    .EXAMPLE
        PS F:\> Get-SQLRights -ServerName test -DatabaseName "*"

    .NOTES
        LASTEDIT: 04/19/2016
 #>

  Param(
    # ServerName - the server's name (can be a wildcard)
    [Parameter(Mandatory=$true)]
    $ServerName,

    # DatabaseName - the database's name (can be a wildcard)
    [Parameter(Mandatory=$true)]
    $DatabaseName
  )

  # Powershell's wildcard is "*" whereas SQL uses "%", so we need to replace them
  $Servername = $Servername -replace "\*","%"
  $DatabaseName = $DatabaseName -replace "\*","%"
  $instance = "" # Server instance
  $table = " # [table].[to].[query]

  # Run a query to pull out the requested data from the given server and DB
  Invoke-Sqlcmd -Query ("SELECT servername, dbname, login_name, role_name FROM $table WHERE servername LIKE '%$Servername%' AND dbname LIKE '%$DatabaseName%' AND (login_name LIKE '%SQL%' OR login_name LIKE 'Q%B%')") -ServerInstance $instance
}
