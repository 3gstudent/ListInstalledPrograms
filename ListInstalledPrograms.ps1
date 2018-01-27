<#
.SYNOPSIS
This script can be used to list the programs that the current Windows system has installed.
Supprot x86 and x64 
Author: 3gstudent@3gstudent
License: BSD 3-Clause
#>

Function ListPrograms
{  
	param($RegPath)  
	$QueryPath = dir $RegPath -Name
	foreach($Name in $QueryPath)
	{
    	(Get-ItemProperty -Path $RegPath$Name).DisplayName
#        (Get-ItemProperty -Path $RegPath$Name).Publisher
#        (Get-ItemProperty -Path $RegPath$Name).DisplayVersion
	}
} 
if ([IntPtr]::Size -eq 8)
{
	Write-Host "[*] OS: x64"
	Write-Host "[*] List the 64 bit programs that have been installed"
	$RegPath = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\"
	ListPrograms -RegPath $RegPath

	Write-Host "[+] List the 32 bit programs that have been installed"

	$RegPath = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\"
	ListPrograms -RegPath $RegPath
 }
else
{
	Write-Host "[*] OS: x86"
 	Write-Host "[*] List the 32 bit programs that have been installed"
	$RegPath = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\"
	ListPrograms -RegPath $RegPath
}
