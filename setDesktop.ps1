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



### chrome : Application Settings

# $x = 2687
# $y = 0
# $width = 1160
# $height = 2116
# $appName = "chrome"
# $exe = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"

# handleApp -appName $appName -x $x -y $y -width $width -height $height -exe $exe


### firefox : Application Settings

$x = 1850
$y = 0
$width = 1226
$height = 1078
$appName = "firefox"
$exe = "C:\Program Files\Mozilla Firefox\firefox.exe"

handleApp -appName $appName -x $x -y $y -width $width -height $height -exe $exe


### discord : Application Settings

$x = 673
$y = 0
$width = 1182
$height = 1072
$appName = "discord"
$exe = "C:\Users\merana\AppData\Local\Discord\app-0.0.306\Discord.exe"
handleApp -appName $appName -x $x -y $y -width $width -height $height -exe $exe



### notepad++ : Application Settings

$x = -6
$y = 1164
$width = 1035
$height = 531
$appName = "notepad++"
$exe = "C:\Program Files\Notepad++\notepad++.exe"

handleApp -appName $appName -x $x -y $y -width $width -height $height -exe $exe


### LCore : Application Settings

$x = 2267
$y = 1087
$width = 805
$height = 600
$appName = "lcore"
$exe = "C:\Program Files\Logitech Gaming Software\LCore.exe"

handleApp -appName $appName -x $x -y $y -width $width -height $height -exe $exe


### SamsungDeX : Application Settings

# $x = 1287
# $y = 1250
# $width = 1540
# $height = 866
# $appName = "SamsungDeX"
# $exe = "C:\Program Files (x86)\Samsung\Samsung DeX\SamsungDeX.exe"
# 
# handleApp -appName $appName -x $x -y $y -width $width -height $height -exe $exe



### powershell : Application Settings

# $x = 1330
# $y = 1165
# $width = 1066
# $height = 954
# $appName = "powershell"
# $exe = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"

# handleApp -appName $appName -x $x -y $y -width $width -height $height -exe $exe






# # Move Chrome with DIM Active
#
# $cWinHandle = Get-AU3WinHandle "DIM - Google Chrome"
# $xPos = -7
# $yPos = 0
# $width = 1129
# $height = 1031
# 
# Move-AU3Win -WinHandle $cWinHandle -x $xPos -y $yPos -Width $width -Height $height
# 
# # Move Discord
# 
# $cWinHandle = (Get-Process Discord | Where-Object {$_.MainWindowTitle -like "*Discord*"}).MainWindowHandle
# $xPos = 856
# $yPos = 0
# $width = 1063
# $height = 1016
# 
# Move-AU3Win -WinHandle $cWinHandle -x $xPos -y $yPos -Width $width -Height $height



