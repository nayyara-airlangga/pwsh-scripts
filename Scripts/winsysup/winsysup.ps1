using module winsysup

[CmdletBinding()]
Param (
  [Switch]
  [Alias("h", "?")]
  $Help,

  [PackageManagers]
  [Alias("p")]
  $PackageManager = [PackageManagers]::choco
)

# Import modules
Import-Module -Name winsysup

[String] $ScriptName = $Script:MyInvocation.MyCommand.Name
$ScriptName = $ScriptName.Replace(".ps1", "")

if ($Help)
{
  [String] $HelpText = Invoke-Expression -Command "$ScriptName -?"
  $HelpText = $HelpText.Replace(".ps1", "")

  Write-Output "$ScriptName  -  Package update automation tool for Windows
  
$HelpText
Options:
  -h, -Help, -?
    Displays this help menu.
"

  Exit
}

if ($PackageManager -eq [PackageManagers]::choco)
{
  if (CommandExists $PackageManager)
  {
    Write-Output it exists
  }
}
