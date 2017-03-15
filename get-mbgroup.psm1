Function Get-MBGroup {
 <#
    .SYNOPOSIS
        This function locates the MB group for the mailbox

    .EXAMPLE
        Get-MBGroup -EmailAddress 'name'
        Get-MBGroup -EmailAddress 'name@example.com'

    .NOTES
        LastEdit: 01/11/2016
 #> 
 [cmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$false,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            HelpMessage="This is the email address or displayname of the mailbox.")]
        [String]$EmailAddress
    )

  Write-Host 'What is the email address or displayname of the mailbox?' -ForegroundColor Yellow
  $EmailAddress = Read-Host
  $MBGroup = Get-Mailbox $EmailAddress | Get-MailboxPermission | ?{$_.User -like "*MB-*"} | Select User,AccessRights
  Write-Host 'MB Group:' $MBGroup
}
