function getAppSettings {
[CmdletBinding()]
param (
		[Parameter(ValueFromPipelineByPropertyName=$true,
				   Position=0)]
		[string]$appName
	)

$cHandle = (get-process -name $appName).mainwindowhandle | Where {$_ -ne 0} | Select -unique
$cExe = (get-process -name $appName -fileversioninfo).FileName | Select -unique
$appWinPos = Get-AU3WinPos -WinHandle $cHandle

$xSetting = '$x = ' + $appWinPos.location.x
$ySetting = '$y = ' + $appWinPos.location.y 
$widthSetting = '$width = ' + $appWinPos.size.width
$heightSetting = '$height = ' + $appWinPos.size.height
$appNameSetting = '$appName = "' + $appName + '"'
$exeSetting = '$exe = "' + $cExe + '"'
$cmdLine = 'handleApp -appName $appName -x $x -y $y -width $width -height $height -exe $exe'

Write-host "`n### $appName : Application Settings`n"
Write-Host "$xSetting`n$ySetting`n$widthSetting`n$heightSetting`n$appNameSetting`n$exeSetting`n`n$cmdLine"
Write-host "`n`n`n"

}




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




### firefox : Application Settings

$x = 1
$y = 727
$width = 1181
$height = 999
$appName = "firefox"
$exe = "C:\Program Files\Mozilla Firefox\firefox.exe"

handleApp -appName $appName -x $x -y $y -width $width -height $height -exe $exe
handleApp -appName $appName -x $x -y $y -width $width -height $height -exe $exe


### discord : Application Settings

$x = 1
$y = 1
$width = 1182
$height = 864
$appName = "discord"
$exe = "C:\Users\merana\AppData\Local\Discord\app-0.0.306\Discord.exe"

handleApp -appName $appName -x $x -y $y -width $width -height $height -exe $exe
handleApp -appName $appName -x $x -y $y -width $width -height $height -exe $exe


### LCore : Application Settings

$x = 2267
$y = 1122
$width = 805
$height = 600
$appName = "LCore"
$exe = "C:\Program Files\Logitech Gaming Software\LCore.exe"

handleApp -appName $appName -x $x -y $y -width $width -height $height -exe $exe
handleApp -appName $appName -x $x -y $y -width $width -height $height -exe $exe


### ldcfg - Impact Gaming Mouse : Application Settings

$x = 548
$y = 947
$width = 795
$height = 625
$appName = "ldcfg"
$exe = "D:\Program Files (x86)\REDRAGON IMPACT Gaming Mouse\ldcfg.exe"

handleApp -appName $appName -x $x -y $y -width $width -height $height -exe $exe
handleApp -appName $appName -x $x -y $y -width $width -height $height -exe $exe

### Notepad++ : Application Settings

$x = 1340
$y = 1049
$width = 923
$height = 526
$appName = "Notepad++"
$exe = "C:\Program Files\Notepad++\notepad++.exe"

handleApp -appName $appName -x $x -y $y -width $width -height $height -exe $exe

### SndVol : Application Settings

$x = 758
$y = 1
$width = 799
$height = 370
$appName = "SndVol"
$exe = "C:\Windows\SYSTEM32\SndVol.exe"

handleApp -appName $appName -x $x -y $y -width $width -height $height -exe $exe


### powershell : Application Settings

# $x = 1330
# $y = 1165
# $width = 1066
# $height = 954
# $appName = "powershell"
# $exe = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"

# handleApp -appName $appName -x $x -y $y -width $width -height $height -exe $exe








