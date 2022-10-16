Add-Type @"
public enum PackageManagers
{
  choco,
  winget
}
"@


Function CommandExists
{
  [CmdletBinding()]
  Param(
    [String]
    [Parameter(Mandatory=$true)]
    $Command
  )

  try
  {
    if(Get-Command $Command)
    {
      Return $true
    }
  } catch
  {Return $false
  }
}

Export-ModuleMember -Function CommandExists
