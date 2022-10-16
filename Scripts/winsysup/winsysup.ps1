using module winsysup

[CmdletBinding()]
Param (
  [Switch]
  [Alias("h", "?")]
  $Help,

  [PackageManagers]
  [Alias("p")]
  $PackageManager = [PackageManagers]::choco,

  [Switch]
  $Outdated
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
  -p, -PackageManager [choco | winget]
    The package manager to use. The default is choco.
  -Outdated
    List all outdated packages.
"

  Exit
}

if ($PackageManager -eq [PackageManagers]::choco)
{
  if (-Not (CommandExists $PackageManager))
  {
    LogError "$PackageManager not found"
    Exit
  } 
  
  if ($Outdated)
  {
    Write-Output "Listing outdated chocolatey packages..."
    Write-Output ""

    choco outdated | findstr /a:4 "true false"
    Exit
  } else
  {
    if (-Not (IsAdmin))
    {
      LogError "chocolatey needs to be run with elevated privileges."
      Exit
    }

    Write-Output "Upgrading chocolatey packages..."
    Write-Output ""

    choco upgrade all -y
    Exit
  }  
} elseif ($PackageManager -eq [PackageManagers]::winget)
{
  if (-Not (CommandExists $PackageManager))
  {
    LogError "$PackageManager not found"
    Exit
  }

  if($Outdated)
  {
    Write-Output "Listing outdated winget packages..."
    Write-Output ""

    winget upgrade
    Exit
  } else
  {
    Write-Output "Upgrading winget packages..."
    Write-Output "" 

    winget upgrade --all
    Exit
  }
}
