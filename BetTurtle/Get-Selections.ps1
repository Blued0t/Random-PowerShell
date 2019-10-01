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


#----------------------------------------------------------[Declarations]----------------------------------------------------------



Remove-Item .\#Todays-Selections.csv -Force -ErrorAction:SilentlyContinue
$todaysRaces = Import-Csv '.\today.csv'


#$a
foreach ($a in $todaysRaces)
{
    if(
        ($a.WellHcap -eq "positive") `
        -and ($a.FormRate -eq "positive") `
        -and ($a.Wins -gt "0") `
        -and ($a.ClassChange -eq "Same") `
        -and ($a.RaceCode -ne "FLT") `
    )
    {
        $line = ""
        $line = $line + $a.Course + ", "
        $line = $line + $a.Time + ", "
        $line = $line + $a.RaceCode + ", "
        $line = $line + $a.RaceType + ", "
        $line = $line + $a.Name + ", "
        $line = $line + " Less than odds of 10" 
        Write-Verbose $line
        $line | Out-File .\#Todays-Selections.csv -Append -Encoding utf8       

    }

    if(
        ($a.BeatFav -eq "(BF)") `
        -and ($a.CD -like "D") `
    )
    {
        $line = ""
        $line = $line + $a.Course + ", "
        $line = $line + $a.Time + ", "
        $line = $line + $a.RaceCode + ", "
        $line = $line + $a.RaceType + ", "
        $line = $line + $a.Name + ", "
        $line = $line + " Less than odds of 5" 
        Write-Verbose $line
        $line | Out-File .\#Todays-Selections.csv -Append -Encoding utf8       

    }

}

