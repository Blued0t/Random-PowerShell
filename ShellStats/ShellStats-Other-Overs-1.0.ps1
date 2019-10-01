<#
.SYNOPSIS
 Shows previous stats for teams based on Over/Under 2.5 goals

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
   #[Parameter(Mandatory=$false)]
   #[String] $ConfigFile
   )

Import-Module .\ImportExcel

#----------------------------------------------------------[Declarations]----------------------------------------------------------

$fixturesCsv = ".\other_fixtures.csv"
#$seasons = @("1819","1920")
$previousGamesCount = @(18, 12, 6)
$previousGamesCountAway = @(6, 12, 18)
#$previousGamesCount = @(6)
#$previousSeason = "1819"
#$leagues = @("B1", "D1", "D2", "E0", "E1", "E2", "E3", "EC", "F1", "F2", "G1", "I1", "I2", "N1", "P1", "SC0", "SC1", "SC2", "SC3", "SP1", "SP2", "T1")
$leagues = @("ARG", "AUT", "BRA", "CHN", "DNK", "FIN", "IRL", "JPN", "MEX", "NOR", "POL", "ROU", "RUS", "SWE", "SWZ", "USA")

#-----------------------------------------------------------[Functions]------------------------------------------------------------
Function getHomeStats
{
  param
  (
    $league,
    $homeTeamToCheck,
    $numberOfGamesToCheck
  )

  #Check the team are in this league

  $overs = 0
  $overallTotalGames = 0

  $leagueStats = import-csv -Path .\Other\$league.csv
  #write-verbose $currentLeagueStats
  forEach ($currentGame in $leagueStats)
  {
    #Write-verbose $currentGame.HomeTeam
    if ($currentGame.Home -eq $homeTeamToCheck)
    {
      $overallTotalGames += 1
    }
  }
  

  #Get current season
  if ($overallTotalGames -ge $numberOfGamesToCheck)
  {

      $leagueStats = import-csv -Path .\Other\$league.csv
      #write-verbose $currentLeagueStats
      forEach ($currentGame in $leagueStats)
      {
        #Write-verbose $currentGame.HomeTeam
        if ($currentGame.Home -eq $homeTeamToCheck)
        {
          $totalGames += 1
          if (($overallTotalGames - $totalGames) -lt $numberOfGamesToCheck)
          {
     
            #Write-Verbose $homeTeamToCheck
            #Write-Verbose "$($currentGame.HomeTeam) v $($currentGame.AwayTeam)"

            if (([int]$currentGame.hg + [int]$currentGame.ag) -gt 2)
            {
              $overs += 1
            }
          }
        }

    }
  #Write-Verbose $totalGames
  #Write-Verbose $overs
    [Math]::Round(((100 / $numberOfGamesToCheck) * $overs), 2)
  }else {
    1000 
  }
}


Function getAwayStats
{
  param
  (
    $league,
    $awayTeamToCheck,
    $numberOfGamesToCheck
  )

  #Check the team are in this league

  $overs = 0
  $overallTotalGames = 0

  $leagueStats = import-csv -Path .\Other\$league.csv
  #write-verbose $currentLeagueStats
  forEach ($currentGame in $leagueStats)
  {
    #Write-verbose $currentGame.HomeTeam
    if ($currentGame.Away -eq $awayTeamToCheck)
    {
      $overallTotalGames += 1
    }
  }
  

  #Get current season
  if ($overallTotalGames -ge $numberOfGamesToCheck)
  {

      $leagueStats = import-csv -Path .\Other\$league.csv
      #write-verbose $currentLeagueStats
      forEach ($currentGame in $leagueStats)
      {
        #Write-verbose $currentGame.HomeTeam
        if ($currentGame.Away -eq $awayTeamToCheck)
        {
          $totalGames += 1
          if (($overallTotalGames - $totalGames) -lt $numberOfGamesToCheck)
          {
     
            #Write-Verbose $homeTeamToCheck
            #Write-Verbose "$($currentGame.HomeTeam) v $($currentGame.AwayTeam)"

            if (([int]$currentGame.hg + [int]$currentGame.ag) -gt 2)
            {
              $overs += 1
            }
          }
        }

    }
  #Write-Verbose $totalGames
  #Write-Verbose $overs
    [Math]::Round(((100 / $numberOfGamesToCheck) * $overs), 2)
  }else {
    1000 
  }
}
#
#-----------------------------------------------------------[Execution]------------------------------------------------------------

Remove-Item ".\Overs OtherLeagues AllTeams.csv" -Force -ErrorAction:SilentlyContinue
Remove-Item ".\Overs OtherLeagues Fixtures.csv" -Force -ErrorAction:SilentlyContinue


#All teams
if ($false)
  {
  foreach ($league in $leagues)
  {
    $allLeagueGames = import-csv -Path .\Other\$league.csv
    [System.Collections.ArrayList]$allTeams = @()
    #$allTeams = @()
    forEach ($currentGame in $allLeagueGames)
    {
      #Write-Verbose $currentGame.HomeTeam
      $allTeams.Add($currentGame.Home) | Out-Null
    } 
    
    $uniqueTeams = $allTeams | Sort-object | Get-Unique
    $uniqueTeams

    
    foreach ($uniqueTeam in $uniqueTeams)
    {
      Write-Verbose $uniqueTeam
      $line = ""
      $line = $line + $league + ", "
      foreach ($previousGameCount in $previousGamesCount)
      {
        $previousHomeStats = getHomeStats $league $uniqueTeam $previousGameCount
        $line = $line + $previousHomeStats + ", "
      }
      $line = $line + $uniqueTeam + ", " 
      foreach ($previousGameCount in $previousGamesCountAway)
      {
        $previousAwayStats = getAwayStats $league $uniqueTeam $previousGameCount
        $line = $line + $previousAwayStats + ", "
      }
      $line
      $line | Out-File .\"Overs OtherLeagues AllTeams.csv" -Append -Encoding utf8
    } 
  }
}



$fixtures = Import-Csv -Path $fixturesCsv

foreach ($fixture in $fixtures)
{
  $line = ""
  $currentLeague = $fixture.Country
  if ($currentLeague -eq "Argentina"){ $currentLeague = "ARG" }
  if ($currentLeague -eq "Austria"){ $currentLeague = "AUT" }
  if ($currentLeague -eq "China"){ $currentLeague = "CHN" }
  if ($currentLeague -eq "Brazil"){ $currentLeague = "BRA" }
  if ($currentLeague -eq "Denmark"){ $currentLeague = "DNK" }
  if ($currentLeague -eq "Finland"){ $currentLeague = "FIN" }
  if ($currentLeague -eq "Ireland"){ $currentLeague = "IRL" }
  if ($currentLeague -eq "Japan"){ $currentLeague = "JPN" }
  if ($currentLeague -eq "Mexico"){ $currentLeague = "MEX" }
  if ($currentLeague -eq "Norway"){ $currentLeague = "NOR" }
  if ($currentLeague -eq "Poland"){ $currentLeague = "POL" }
  if ($currentLeague -eq "Romania"){ $currentLeague = "ROU" }
  if ($currentLeague -eq "Russia"){ $currentLeague = "RUS" }
  if ($currentLeague -eq "Sweden"){ $currentLeague = "SWE" }
  if ($currentLeague -eq "Switzerland"){ $currentLeague = "SWZ" }
  $line = $line + $currentLeague + "," + $fixture.Date + "," + $fixture.Time + ", "
  foreach ($previousGameCount in $previousGamesCount)
  {
    $previousHomeStats = getHomeStats $currentLeague $fixture.Home $previousGameCount
    $line = $line + $previousHomeStats + ", "
    #Write-Verbose  $fixture.HomeTeam
    #Write-Verbose $allPreviousHomeStats
    #Write-Output $fixture.HomeTeam
  }
  $line = $line + $fixture.Home + ", " + $fixture.Away + ","

  foreach ($previousGameCount in $previousGamesCountAway)
  {
    $previousAwayStats = getAwayStats $currentLeague $fixture.Away $previousGameCount
    $line = $line + $previousAwayStats + ", "
    #Write-Verbose  $fixture.HomeTeam
    #Write-Verbose $allPreviousHomeStats
    #Write-Output $fixture.HomeTeam
  }

  $line | Out-File .\"Overs OtherLeagues Fixtures.csv" -Append -Encoding utf8

  Write-Verbose $line

}




