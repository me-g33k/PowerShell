
function New-WorkingYr {
<#
.SYNOPSIS
  Creates working directories for annual folder
.DESCRIPTION
  Creates working directories for annual folder
.PARAMETER tgtYr
    Year to create and populate
.INPUTS
  None
.OUTPUTS
  None
.NOTES
  Version:        $Rev$
  Author:         $Author$
  Creation Date:  $Date$
  Purpose/Change: Initial script development
  
.EXAMPLE
  new-workingyr 2021
#>
param (
    [Parameter(Mandatory=$true,
    ValueFromPipelineByPropertyName=$true,
    Position=0)][int16]$tgtYr
    )

filter timestamp {"$(Get-Date -Format G): $_"}
$basePath = $ENV:USERPROFILE + "\Documents\" + $tgtYr

$baseFolders = "000 - Operations", "001 - Projects", "002 - Expenses", "004 - Games", "005 - Photos"
$opsBaseDir = $basePath + "\000 - Operations"
$lastYrOpsDNDir = $ENV:USERPROFILE + "\Documents\" + ($tgtYr - 1) + "\000 - Operations\000 - DailyNotes"

Try {
    if (-NOT (Test-Path $basePath)){
        $msg = "Creating new directory: $basePath" | timestamp
        Write-Output $msg
        $nf = New-Item -Path $basePath -ItemType Directory -ErrorAction STOP
    }
} Catch {
    Write-Output "Something went wrong."
}

foreach($itemDir in $baseFolders){
    $msg = "Creating $itemDir in $baseFolders" | timestamp
    Write-Output $msg

    $nf = New-Item -Path $basePath -ItemType Directory -Name $itemDir
}

for($i=1;$i -ne 13;$i++){
    $mnth = get-date $i/1/$tgtyr -format "MM"
    $mnthName = get-date $i/1/$tgtyr -format "MMMM"
    $fullName = $mnth + "-" + $mnthName
    $dnPSScript = $lastYrOpsDNDir + "\mkDailyNotesDir.ps1"

    $nf = New-Item -Path $opsbaseDir -ItemType Directory -Name "000 - DailyNotes" -force
    $nf = New-Item -Path $opsbaseDir -ItemType Directory -Name "001 - FWLogs" -force

    $msg = "Creating $FullName in $opsbaseDir" | timestamp
    Write-Output $msg

    $nf = New-Item -Path "$opsBaseDir\000 - DailyNotes" -ItemType Directory -Name $fullName
    $ns = Copy-Item $dnPSScript -Destination $nf


}



}