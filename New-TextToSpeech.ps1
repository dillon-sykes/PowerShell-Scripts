<#
.SYNOPSIS
    This function enables easy text to speech usage with PowerShell
    
.DESCRIPTION
    This function allows you to specify text to be read aloud easily.
    
.EXAMPLE
    Say-Text "Hello World!"
    
.NOTES
    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
#>

function Say-Text {
     param ([Parameter(Mandatory=$true, ValueFromPipeline=$true)] [string] $Text)
     Add-Type -AssemblyName ('System.Speech') | Out-Null   
     $SpeechSynthesizer = New-Object System.Speech.Synthesis.SpeechSynthesizer
	 $SpeechSynthesizer.Rate = '0'  # -10 is slowest, 10 is fastest
     $SpeechSynthesizer.Speak($Text)
}