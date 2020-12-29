function handleApp {
<#
.SYNOPSIS
  Moves or Starts application then moves it to specified location.
.DESCRIPTION
  Moves or Starts application then moves it to specified location.
.PARAMETER appName
    File file path to executable
.PARAMETER x
    Integer value of "X" location
.PARAMETER y
    Integer value of "Y" location

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
  <Example goes here. Repeat this attribute for more than one example>
#>

[CmdletBinding()]
param (
        [Parameter(ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$appName,
		[Parameter(Mandatory=$true)][int]$x,
		[Parameter(Mandatory=$true)][int]$y,
		[Parameter(Mandatory=$true)][int]$width,
		[Parameter(Mandatory=$true)][int]$height,
		[Parameter(Mandatory=$true)][string]$exe
    )
    process {
		$cHandle = $null
        try {
			Write-Verbose "###`t $prfl : Working on $appName" -verbose
			$cHandle = (get-process -name $appName).mainwindowhandle | Where {$_ -ne 0} | Select -unique
			Move-AU3Win -WinHandle $cHandle -X $x -Y $y -Width $width -Height $height | out-null
		} catch {
			$sleepTimer = 0
			Write-Verbose "###`t $prfl : $appName not running. Staring application." -verbose
			& $exe
			Write-Verbose "###`t $prfl : Waiting for Application" -verbose
			Do {
				$cHandle = (get-process -name $appName).mainwindowhandle | Where {$_ -ne 0} | Select -unique
				Write-Verbose "###`t $prfl : Waiting for Application - $sleepTimer" -verbose
				$sleepTimer++
				Start-Sleep -Seconds 1
			}
			Until (-not $cHandle)
			$cHandle = (get-process -name $appName).mainwindowhandle | Where {$_ -ne 0} | Select -unique
			Write-Verbose "###`t $prfl : Application handle ($appName) - $cHandle" -verbose
			Move-AU3Win -WinHandle $cHandle -X $x -Y $y -Width $width -Height $height | out-null
		}
    }
} 


### wolcen : Application Settings

$x = 3832
$y = 665
$width = 1936
$height = 1119
$appName = "wolcen"
$exe = "D:\Program Files (x86)\Steam\steamapps\common\Wolcen\win_x64\Wolcen.exe"

handleApp -appName $appName -x $x -y $y -width $width -height $height -exe $exe
