$ArrCountries = "ARG","AUT","BRA","CHN","DNK","FIN","IRL","JPN","MEX","NOR","POL","ROU","RUS","SWE","SWZ","USA"

ForEach ($StrCountry in $ArrCountries){
    Invoke-WebRequest -Uri "http://www.football-data.co.uk/new/$StrCountry.csv" -OutFile "C:\Data\Repos\Random-PowerShell\ShellStats\Other\$StrCountry.csv"
}


