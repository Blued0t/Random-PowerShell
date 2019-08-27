<#
.SYNOPSIS
 

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


#----------------------------------------------------------[Declarations]----------------------------------------------------------

$fixturesCsv = ".\fixtures.csv"
$seasons = @("1819","1920")
$previousGamesCount = @(20, 10, 6)
$previousGamesCountAway = @(6, 10, 20)
#$previousGamesCount = @(6)
#$previousSeason = "1819"

#-----------------------------------------------------------[Functions]------------------------------------------------------------
Function getHomeStats
{
  param
  (
    $league,
    $homeTeamToCheck,
    $numberOfGamesToCheck
  )

  $overs = 0
  $overallTotalGames = 0
  $validResults = $false

  #get Total games over seasons
  foreach ($season in $seasons)
  {
    $leagueStats = import-csv -Path $season\$league.csv
    #write-verbose $currentLeagueStats
    forEach ($currentGame in $leagueStats)
    {
      #Write-verbose $currentGame.HomeTeam
      if ($currentGame.HomeTeam -eq $homeTeamToCheck)
      {
        $overallTotalGames += 1
      }
    }
  }

  #Get current season
  if ($overallTotalGames -ge $numberOfGamesToCheck)
  {
    foreach ($season in $seasons)
    {
      $leagueStats = import-csv -Path $season\$league.csv
      #write-verbose $currentLeagueStats
      forEach ($currentGame in $leagueStats)
      {
        #Write-verbose $currentGame.HomeTeam
        if ($currentGame.HomeTeam -eq $homeTeamToCheck)
        {
          $totalGames += 1
          if (($overallTotalGames - $totalGames) -lt $numberOfGamesToCheck)
          {
            $validResults = $true        
            #Write-Verbose $homeTeamToCheck
            #Write-Verbose "$($currentGame.HomeTeam) v $($currentGame.AwayTeam)"

            if (([int]$currentGame.fthg + [int]$currentGame.ftag) -gt 2)
            {
              $overs += 1
            }
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

  $overs = 0
  $overallTotalGames = 0

  #get Total games over seasons
  foreach ($season in $seasons)
  {
    $leagueStats = import-csv -Path $season\$league.csv
    #write-verbose $currentLeagueStats
    forEach ($currentGame in $leagueStats)
    {
      #Write-verbose $currentGame.HomeTeam
      if ($currentGame.AwayTeam -eq $awayTeamToCheck)
      {
        $overallTotalGames += 1
      }
    }
  }

  #Get current season
  if ($overallTotalGames -ge $numberOfGamesToCheck)
  {
    foreach ($season in $seasons)
    {
      $leagueStats = import-csv -Path $season\$league.csv
      #write-verbose $currentLeagueStats
      forEach ($currentGame in $leagueStats)
      {
        #Write-verbose $currentGame.HomeTeam
        if ($currentGame.AwayTeam -eq $awayTeamToCheck)
        {
          $totalGames += 1
          if (($overallTotalGames - $totalGames) -lt $numberOfGamesToCheck)
          {
  
            #Write-Verbose $homeTeamToCheck
            #Write-Verbose "$($currentGame.HomeTeam) v $($currentGame.AwayTeam)"

            if (([int]$currentGame.fthg + [int]$currentGame.ftag) -gt 2)
            {
              $overs += 1
            }
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

$fixtures = Import-Csv -Path $fixturesCsv

foreach ($fixture in $fixtures)
{
  $line = ""
  $currentLeague = $fixture.Div
  $line = $line + $currentLeague + "," + $fixture.Date + "," + $fixture.Time + ", "
  foreach ($previousGameCount in $previousGamesCount)
  {
    $previousHomeStats = getHomeStats $currentLeague $fixture.HomeTeam $previousGameCount
    $line = $line + $previousHomeStats + ", "
    #Write-Verbose  $fixture.HomeTeam
    #Write-Verbose $allPreviousHomeStats
    #Write-Output $fixture.HomeTeam
  }
  $line = $line + $fixture.HomeTeam + ", " + $fixture.AwayTeam + ","

  foreach ($previousGameCount in $previousGamesCountAway)
  {
    $previousAwayStats = getAwayStats $currentLeague $fixture.AwayTeam $previousGameCount
    $line = $line + $previousAwayStats + ", "
    #Write-Verbose  $fixture.HomeTeam
    #Write-Verbose $allPreviousHomeStats
    #Write-Output $fixture.HomeTeam
  }

  Write-Verbose $line

}


