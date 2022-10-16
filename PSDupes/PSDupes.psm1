# Module created by Microsoft.PowerShell.Crescendo
class PowerShellCustomFunctionAttribute : System.Attribute { 
    [bool]$RequiresElevation
    [string]$Source
    PowerShellCustomFunctionAttribute() { $this.RequiresElevation = $false; $this.Source = "Microsoft.PowerShell.Crescendo" }
    PowerShellCustomFunctionAttribute([bool]$rElevation) {
        $this.RequiresElevation = $rElevation
        $this.Source = "Microsoft.PowerShell.Crescendo"
    }
}



function Invoke-PSdupes
{
[PowerShellCustomFunctionAttribute(RequiresElevation=$False)]
[CmdletBinding()]

param(
[Parameter(ParameterSetName='All')]
[string]$Path,
[Parameter(ParameterSetName='All')]
[Parameter(ParameterSetName='Summary')]
[switch]$Summarize,
[Parameter(ParameterSetName='All')]
[Parameter(ParameterSetName='SummaryMatch')]
[switch]$SummarizeMatchTypes,
[Parameter(ParameterSetName='All')]
[Parameter(ParameterSetName='JSON')]
[switch]$JSONoutput,
[Parameter(ParameterSetName='All')]
[Parameter(ParameterSetName='Delete')]
[switch]$NoPrompt,
[Parameter(ParameterSetName='All')]
[Parameter(ParameterSetName='Delete')]
[Parameter(ParameterSetName='JSON')]
[switch]$Delete,
[Parameter(ParameterSetName='All')]
[Parameter(ParameterSetName='Summary')]
[Parameter(ParameterSetName='SummaryMatch')]
[Parameter(ParameterSetName='Delete')]
[Parameter(ParameterSetName='JSON')]
[switch]$Recurse,
[Parameter(ParameterSetName='All')]
[Parameter(ParameterSetName='Summary')]
[Parameter(ParameterSetName='SummaryMatch')]
[Parameter(ParameterSetName='Delete')]
[Parameter(ParameterSetName='JSON')]
[switch]$EnableResultsOnAbort,
[Parameter(ParameterSetName='All')]
[Parameter(ParameterSetName='JSON')]
[switch]$ShowSize
    )

BEGIN {
    $__PARAMETERMAP = @{
         Path = @{
               OriginalName = ''
               OriginalPosition = '0'
               Position = '2147483647'
               ParameterType = 'string'
               ApplyToExecutable = $False
               NoGap = $False
               }
         Summarize = @{
               OriginalName = '-m'
               OriginalPosition = '1'
               Position = '2147483647'
               ParameterType = 'switch'
               ApplyToExecutable = $False
               NoGap = $False
               }
         SummarizeMatchTypes = @{
               OriginalName = '-M'
               OriginalPosition = '2'
               Position = '2147483647'
               ParameterType = 'switch'
               ApplyToExecutable = $False
               NoGap = $False
               }
         JSONoutput = @{
               OriginalName = '-j'
               OriginalPosition = '3'
               Position = '2147483647'
               ParameterType = 'switch'
               ApplyToExecutable = $False
               NoGap = $False
               }
         NoPrompt = @{
               OriginalName = '-N'
               OriginalPosition = '4'
               Position = '2147483647'
               ParameterType = 'switch'
               ApplyToExecutable = $False
               NoGap = $False
               }
         Delete = @{
               OriginalName = '-d'
               OriginalPosition = '5'
               Position = '2147483647'
               ParameterType = 'switch'
               ApplyToExecutable = $False
               NoGap = $False
               }
         Recurse = @{
               OriginalName = '-r'
               OriginalPosition = '6'
               Position = '2147483647'
               ParameterType = 'switch'
               ApplyToExecutable = $False
               NoGap = $False
               }
         EnableResultsOnAbort = @{
               OriginalName = '-Z'
               OriginalPosition = '7'
               Position = '2147483647'
               ParameterType = 'switch'
               ApplyToExecutable = $False
               NoGap = $False
               }
         ShowSize = @{
               OriginalName = '-S'
               OriginalPosition = '8'
               Position = '2147483647'
               ParameterType = 'switch'
               ApplyToExecutable = $False
               NoGap = $False
               }
    }

    $__outputHandlers = @{ Default = @{ StreamOutput = $true; Handler = { $input } } }
}

PROCESS {
    $__boundParameters = $PSBoundParameters
    $__defaultValueParameters = $PSCmdlet.MyInvocation.MyCommand.Parameters.Values.Where({$_.Attributes.Where({$_.TypeId.Name -eq "PSDefaultValueAttribute"})}).Name
    $__defaultValueParameters.Where({ !$__boundParameters["$_"] }).ForEach({$__boundParameters["$_"] = get-variable -value $_})
    $__commandArgs = @()
    $MyInvocation.MyCommand.Parameters.Values.Where({$_.SwitchParameter -and $_.Name -notmatch "Debug|Whatif|Confirm|Verbose" -and ! $__boundParameters[$_.Name]}).ForEach({$__boundParameters[$_.Name] = [switch]::new($false)})
    if ($__boundParameters["Debug"]){wait-debugger}
    foreach ($paramName in $__boundParameters.Keys|
            Where-Object {!$__PARAMETERMAP[$_].ApplyToExecutable}|
            Sort-Object {$__PARAMETERMAP[$_].OriginalPosition}) {
        $value = $__boundParameters[$paramName]
        $param = $__PARAMETERMAP[$paramName]
        if ($param) {
            if ($value -is [switch]) {
                 if ($value.IsPresent) {
                     if ($param.OriginalName) { $__commandArgs += $param.OriginalName }
                 }
                 elseif ($param.DefaultMissingValue) { $__commandArgs += $param.DefaultMissingValue }
            }
            elseif ( $param.NoGap ) {
                $pFmt = "{0}{1}"
                if($value -match "\s") { $pFmt = "{0}""{1}""" }
                $__commandArgs += $pFmt -f $param.OriginalName, $value
            }
            else {
                if($param.OriginalName) { $__commandArgs += $param.OriginalName }
                $__commandArgs += $value | Foreach-Object {$_}
            }
        }
    }
    $__commandArgs = $__commandArgs | Where-Object {$_ -ne $null}
    if ($__boundParameters["Debug"]){wait-debugger}
    if ( $__boundParameters["Verbose"]) {
         Write-Verbose -Verbose -Message $PSScriptRoot\jdupes\jdupes.exe
         $__commandArgs | Write-Verbose -Verbose
    }
    $__handlerInfo = $__outputHandlers[$PSCmdlet.ParameterSetName]
    if (! $__handlerInfo ) {
        $__handlerInfo = $__outputHandlers["Default"] # Guaranteed to be present
    }
    $__handler = $__handlerInfo.Handler
    if ( $PSCmdlet.ShouldProcess("$PSScriptRoot\jdupes\jdupes.exe $__commandArgs")) {
    # check for the application and throw if it cannot be found
        if ( -not (Get-Command -ErrorAction Ignore "$PSScriptRoot\jdupes\jdupes.exe")) {
          throw "Cannot find executable '$PSScriptRoot\jdupes\jdupes.exe'"
        }
        if ( $__handlerInfo.StreamOutput ) {
            & "$PSScriptRoot\jdupes\jdupes.exe" $__commandArgs | & $__handler
        }
        else {
            $result = & "$PSScriptRoot\jdupes\jdupes.exe" $__commandArgs
            & $__handler $result
        }
    }
  } # end PROCESS

<#


.DESCRIPTION
Finds duplicate files

.PARAMETER Path



.PARAMETER Summarize



.PARAMETER SummarizeMatchTypes



.PARAMETER JSONoutput



.PARAMETER NoPrompt



.PARAMETER Delete



.PARAMETER Recurse



.PARAMETER EnableResultsOnAbort



.PARAMETER ShowSize




#>
}


