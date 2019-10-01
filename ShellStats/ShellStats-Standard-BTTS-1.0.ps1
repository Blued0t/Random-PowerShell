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

Import-Module .\ImportExcel

#----------------------------------------------------------[Declarations]----------------------------------------------------------

$fixturesCsv = ".\fixtures.csv"
$seasons = @("1819","1920")
$previousGamesCount = @(18, 12, 6)
$previousGamesCountAway = @(6, 12, 18)
#$previousGamesCount = @(6)
#$previousSeason = "1819"
$leagues = @("B1", "D1", "D2", "E0", "E1", "E2", "E3", "EC", "F1", "F2", "G1", "I1", "I2", "N1", "P1", "SC0", "SC1", "SC2", "SC3", "SP1", "SP2", "T1")
#$leagues = @("B1")

#-----------------------------------------------------------[Functions]------------------------------------------------------------
Function getHomeStats
{
  param
  (
    $currentLeague,
    $homeTeamToCheck,
    $numberOfGamesToCheck
  )

  $lastSeasonleague = $currentLeague
  if (-not(Get-Content .\1819\$lastSeasonleague.csv | Select-String $homeTeamToCheck))
  {
    #Write-Verbose "Not found $homeTeamToCheck"
    foreach ($lookUpLeague in $leagues)
    {
      #Write-Verbose "lookingfor $homeTeamToCheck in $lookUpLeague"
      if ((Get-Content .\1819\$lookUpLeague.csv) | Select-String $homeTeamToCheck)
      {
        $lastSeasonleague = $lookUpLeague
      }
    }
  }

  $overs = 0
  $overallTotalGames = 0

  #get Total games over seasons
  #foreach ($season in $seasons)

  #{
    $leagueStats = import-csv -Path .\1819\$lastSeasonleague.csv
    #write-verbose $currentLeagueStats
    forEach ($currentGame in $leagueStats)
    {
      #Write-verbose $currentGame.HomeTeam
      if ($currentGame.HomeTeam -eq $homeTeamToCheck)
      {
        $overallTotalGames += 1
      }
    }
    $leagueStats = import-csv -Path .\1920\$currentLeague.csv
    #write-verbose $currentLeagueStats
    forEach ($currentGame in $leagueStats)
    {
      #Write-verbose $currentGame.HomeTeam
      if ($currentGame.HomeTeam -eq $homeTeamToCheck)
      {
        $overallTotalGames += 1
      }
    }    
  #}

  #Get current season
  if ($overallTotalGames -ge $numberOfGamesToCheck)
  {
    #foreach ($season in $seasons)
    #{
      $leagueStats = import-csv -Path .\1819\$lastSeasonleague.csv
      #write-verbose $currentLeagueStats
      forEach ($currentGame in $leagueStats)
      {
        #Write-verbose $currentGame.HomeTeam
        if ($currentGame.HomeTeam -eq $homeTeamToCheck)
        {
          $totalGames += 1
          if (($overallTotalGames - $totalGames) -lt $numberOfGamesToCheck)
          {
  
            #Write-Verbose $awayTeamToCheck
            #Write-Verbose "$($currentGame.HomeTeam) v $($currentGame.AwayTeam)"

            if (([int]$currentGame.fthg -ge 1) -and ([int]$currentGame.ftag -ge 1))
            {
              $overs += 1
            }
          }
        }
      }
      $leagueStats = import-csv -Path .\1920\$currentLeague.csv
      #write-verbose $currentLeagueStats
      forEach ($currentGame in $leagueStats)
      {
        #Write-verbose $currentGame.HomeTeam
        if ($currentGame.HomeTeam -eq $homeTeamToCheck)
        {
          $totalGames += 1
          if (($overallTotalGames - $totalGames) -lt $numberOfGamesToCheck)
          {
  
            #Write-Verbose $awayTeamToCheck
            #Write-Verbose "$($currentGame.HomeTeam) v $($currentGame.AwayTeam)"

            if (([int]$currentGame.fthg -ge 1) -and ([int]$currentGame.ftag -ge 1))
            {
              $overs += 1
            }
          }
        }
      }
    #}
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
    $currentLeague,
    $awayTeamToCheck,
    $numberOfGamesToCheck
  )

  $lastSeasonleague = $currentLeague
  if (-not(Get-Content .\1819\$lastSeasonleague.csv | Select-String $awayTeamToCheck))
  {
    #Write-Verbose "Not found $homeTeamToCheck"
    foreach ($lookUpLeague in $leagues)
    {
      #Write-Verbose "lookingfor $homeTeamToCheck in $lookUpLeague"
      if ((Get-Content .\1819\$lookUpLeague.csv) | Select-String $awayTeamToCheck)
      {
        $lastSeasonleague = $lookUpLeague
      }
    }
  }

  $overs = 0
  $overallTotalGames = 0

  #get Total games over seasons
  #foreach ($season in $seasons)

  #{
    $leagueStats = import-csv -Path .\1819\$lastSeasonleague.csv
    #write-verbose $currentLeagueStats
    forEach ($currentGame in $leagueStats)
    {
      #Write-verbose $currentGame.HomeTeam
      if ($currentGame.AwayTeam -eq $awayTeamToCheck)
      {
        $overallTotalGames += 1
      }
    }
    $leagueStats = import-csv -Path .\1920\$currentLeague.csv
    #write-verbose $currentLeagueStats
    forEach ($currentGame in $leagueStats)
    {
      #Write-verbose $currentGame.HomeTeam
      if ($currentGame.AwayTeam -eq $awayTeamToCheck)
      {
        $overallTotalGames += 1
      }
    }    
  #}

  #Get current season
  if ($overallTotalGames -ge $numberOfGamesToCheck)
  {
    #foreach ($season in $seasons)
    #{
      $leagueStats = import-csv -Path .\1819\$lastSeasonleague.csv
      #write-verbose $currentLeagueStats
      forEach ($currentGame in $leagueStats)
      {
        #Write-verbose $currentGame.HomeTeam
        if ($currentGame.AwayTeam -eq $awayTeamToCheck)
        {
          $totalGames += 1
          if (($overallTotalGames - $totalGames) -lt $numberOfGamesToCheck)
          {
  
            #Write-Verbose $awayTeamToCheck
            #Write-Verbose "$($currentGame.HomeTeam) v $($currentGame.AwayTeam)"

            if (([int]$currentGame.fthg -ge 1) -and ([int]$currentGame.ftag -ge 1))
            {
              $overs += 1
            }
          }
        }
      }
      $leagueStats = import-csv -Path .\1920\$currentLeague.csv
      #write-verbose $currentLeagueStats
      forEach ($currentGame in $leagueStats)
      {
        #Write-verbose $currentGame.HomeTeam
        if ($currentGame.AwayTeam -eq $awayTeamToCheck)
        {
          $totalGames += 1
          if (($overallTotalGames - $totalGames) -lt $numberOfGamesToCheck)
          {
  
            #Write-Verbose $awayTeamToCheck
            #Write-Verbose "$($currentGame.HomeTeam) v $($currentGame.AwayTeam)"

            if (([int]$currentGame.fthg -ge 1) -and ([int]$currentGame.ftag -ge 1))
            {
              $overs += 1
            }
          }
        }
      }
    #}
  #Write-Verbose $totalGames
  #Write-Verbose $overs
    [Math]::Round(((100 / $numberOfGamesToCheck) * $overs), 2)
  }else {
    1000 
  }
}

#
#-----------------------------------------------------------[Execution]------------------------------------------------------------

Remove-Item .\ShellStats-Standard-BTTS-Fixtures.csv -Force -ErrorAction:SilentlyContinue
Remove-Item .\ShellStats-Standard-BTTS-AllTeams.csv -Force -ErrorAction:SilentlyContinue


if ($doAllTeams){
#All teams
foreach ($league in $leagues)
{
  $allLeagueGames = import-csv -Path .\1920\$league.csv
  [System.Collections.ArrayList]$allTeams = @()
  #$allTeams = @()
  forEach ($currentGame in $allLeagueGames)
  {
    #Write-Verbose $currentGame.HomeTeam
    $allTeams.Add($currentGame.HomeTeam) | Out-Null
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
    $line | Out-File .\ShellStats-Standard-BTTS-AllTeams.csv -Append -Encoding utf8
  } 
}
}





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

  $line | Out-File .\ShellStats-Standard-BTTS-Fixtures.csv -Append -Encoding utf8

  Write-Verbose $line

}




