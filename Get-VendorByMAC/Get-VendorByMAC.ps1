function Get-VendorByMAC {
<#
.SYNOPSIS

	Returns NIC Vendor using MAC Address and macvendors.com

.DESCRIPTION

	Using a MAC Address an API query is made to macvendors.com to obtain the Vendor

.PARAMETER mac
	The MAC Address to use for vendor lookup.
	
	Accepted Formats:
	
	00-11-22-33-44-55
	00:11:22:33:44:55
	00.11.22.33.44.55
	001122334455
	0011.2233.4455


	Get-VendorByMAC 00:50:56:BF:61:1B
	VMware, Inc.
	
.EXAMPLE
	$vendor = Get-VendorByMAC 00:50:56:BF:61:1B
	$vendor
	  VMware, Inc.
#>
[CmdletBinding()]
param(
	[Parameter(Position=1,Mandatory=$True)][string]$mac
)

Add-Type -AssemblyName System.Web
	
	# $mac = "00:50:56:BF:61:1B"
	$encMAC = [System.Web.HttpUtility]::UrlEncode($mac)
	$url = "http://api.macvendors.com/" + $encMAC
	$response = invoke-restmethod -uri $url -Method Get

	$response
}
