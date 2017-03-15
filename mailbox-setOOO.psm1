Function Set-OOO
{
 <#
    .SYNOPOSIS
        This function simplifies setting the Out Of Office message
        
    .PARAMETER Email
        This is the email address of the account being updated
        
    .PARAMETER ExternalMessage
        This is Auto-Reply message sent to external correspondents
        
    .PARAMETER InternalMessage
        This is Auto-Reply message sent to internal correspondents
        
    .EXAMPLE
        PS F:\> Set-OOO -Email $Email -ExternalMessage $ExternalMessage -InternalMessage $InternalMessage

    .NOTES
        LASTEDIT: 07/21/2016
 #>
    [cmdletBinding()]
    param(
        [Parameter(Mandatory=$true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            HelpMessage="This is the email address of the account being updated.")]
        $Email,
        [Parameter(Mandatory=$true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            HelpMessage="This is Auto-Reply message sent to external correspondents.")]
        $ExternalMessage,
        [Parameter(Mandatory=$true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            HelpMessage="This is Auto-Reply message sent to internal correspondents.")]
        $InternalMessage
    )
    Set-MailboxAutoReplyConfiguration $Email -AutoReplyState Enabled -ExternalMessage $ExternalMessage -InternalMessage $InternalMessage
}
