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
    if(Get-Command $Command -ErrorAction SilentlyContinue)
    {
      Return $true
    }
  } catch
  {Return $false
  }
}

Function LogError
{
  [CmdLetBinding()]
  Param(
    [String]
    [Parameter(Mandatory=$true)]
    $Message
  )

  Write-Output "Error: $Message"
}

Export-ModuleMember -Function CommandExists
Export-ModuleMember -Function LogError
