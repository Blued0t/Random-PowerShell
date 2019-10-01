<#
.SYNOPSIS
 Shows previous stats for teams based on BTTS goals

.DESCRIPTION
  

.PARAMETER ConfigFile
  

.INPUTS
  None

.OUTPUTS
  None

.NOTES
  Version:        1.0
  Author:         Jon K
  Creation Date:  
  Purpose/Change: 
  
.EXAMPLE
  
#>

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

[CmdletBinding()]
param(
   [Parameter(Mandatory=$false)]
   [String] $doAllTeams
   )

Remove-Item .\Historic-Results.txt -Force -ErrorAction:SilentlyContinue
$todaysRaces = Import-Csv '.\history.csv'
$stats = @("HCrs","HGng","HDis","HClass","TCrse","TRType","T14","T30","T60","TJ","JCrse","JRType","J14","J30","J60")

$stake = 10
$bank = 0

foreach ($a in $todaysRaces)
{
    #Write-Verbose $a.Name
    if (($a.HCrsRun -ge 3) `
        -and ($a.HCrsStrk -gt 10) `
        -and ($a.HGngRun -gt 3) `
        -and ($a.HGngStrk -gt 10) `
        -and ($a.HClassRun -gt 3) `
        -and ($a.HClassStrk -gt 10) `
        )
        {
            $totalStaked = $totalStaked + $stake
            $sels = $sels + 1
            if ($a.position -eq "1")
            {
                Write-host "$($a.Date) $($a.Name) wins at $($a.avgOdds)"  
                "$($a.Name) wins at $($a.avgOdds)"  | Out-File .\Historic-Results.txt -Append -Encoding utf8
                #Write-Output "$a.Name wins at $a.avgOdds" | Out-File .\Historic-Results.txt -Append -Encoding utf8
                $bank = $bank + (($a.AvgOdds - 1) * $stake)
                $wins = $wins + 1
            }else{
                Write-host "$($a.Date) $($a.Name) loses at $($a.avgOdds)"
                "$($a.Name) loses at $($a.avgOdds)" | Out-File .\Historic-Results.txt -Append -Encoding utf8
                $bank =$bank - $stake
            }

        }

}

((100 / $sels) * $wins)
((100 / $totalStaked) * $bank)
$bank
$bank | Out-File .\Historic-Results.txt -Append -Encoding utf8
