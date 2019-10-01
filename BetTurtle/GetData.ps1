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



Remove-Item .\Todays-Selections.csv -Force -ErrorAction:SilentlyContinue
$todaysRaces = Import-Csv '.\today.csv'
$stats = @("HCrs","HGng","HDis","HClass","TCrse","TRType","T14","T30","T60","TJ","JCrse","JRType","J14","J30","J60")


#$a
foreach ($a in $todaysRaces)
{
    $line = ""

    #$line = $line + $a.Date + ","
    $line = $line + $a.Course + ","
    $line = $line + $a.Time + ","
    $line = $line + $a.RaceCode + ","
    $line = $line + $a.RaceType + ","
    $line = $line + $a.Name + ","
    $line = $line + $a.LastRan + ","
    $line = $line + $a.LastWon + ","
    $line = $line + $a.RunsSince + ","
    $line = $line + $a.OR + ","
    $line = $line + $a.Form + ","
    $line = $line + $a.Speed + ","
    $line = $line + $a.Wins + ","
    foreach ($stat in $stats){
        if ($a.($stat + "run") -ge 5){ $line = $line + $a.($stat + "strk") + "," }else{$line = $line + "0" + ","}
    }
    
    <#
    if ($a.Hcrsrun -ge 5){ $line = $line + $a.Hcrsstrk + "," }else{$line = $line + "0" + ","}
    if ($a.Hcrsrun -ge 5){ $line = $line + $a.Hgngstrk + "," }else{$line = $line + "0" + ","}
    if ($a.HDisrun -ge 5){ $line = $line + $a.HDisStrk + "," }else{$line = $line + "0" + ","}
    if ($a.HClassgng -ge 5){ $line = $line + $a.HClassStrk + "," }else{$line = $line + "0" + ","}
    if ($a.Tcrsegng -ge 5){ $line = $line + $a.TcrseStrk + "," }else{$line = $line + "0" + ","}
    if ($a.Tcrsegng -ge 5){ $line = $line + $a.TRTypeStrk + "," }else{$line = $line + "0" + ","}

    $line = $line + $a.HDisStrk + ","
    $line = $line + $a.HClassStrk + ","
    $line = $line + $a.TcrseStrk + ","
    $line = $line + $a.TRTypeStrk + ","
    $line = $line + $a.T14Strk + ","
    $line = $line + $a.T30Strk + ","
    $line = $line + $a.T60Strk + ","
    $line = $line + $a.TJStrk + ","
    $line = $line + $a.JCrseStrk + ","
    $line = $line + $a.JRTypeStrk + ","
    $line = $line + $a.J14Strk + ","
    $line = $line + $a.J30Strk + ","
    $line = $line + $a.J60Strk + ","
    $line = $line + $a.OCrseStrk + ","
    $line = $line + $a.ORTypeStrk + ","
    $line = $line + $a.O14Strk + ","
    $line = $line + $a.O30Strk + ","
    $line = $line + $a.O60Strk + ","
    $line = $line + $a.SCrseStrk + ","
    $line = $line + $a.SRTypeStrk + ","
    $line = $line + $a.S14Strk + ","
    $line = $line + $a.S30Strk + ","
    $line = $line + $a.S60Strk + ","
    #>

    $line = $line + $a.WellHCap + ","
    $line = $line + $a.FormRate + ","
    $line = $line + $a.TForm + ","
    $line = $line + $a.JForm 

    Write-Verbose $line
    $line | Out-File .\Todays-Selections.csv -Append -Encoding utf8
}