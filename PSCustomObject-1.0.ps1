<#
.SYNOPSIS
 Examples of PSCustomObject

.DESCRIPTION
 Examples of PSCustomObject

.NOTES
  Version:        1.0
  Author:         Jon Kidd
  Creation Date:  
  Purpose/Change: 

  Future possible enhancements:
  
.EXAMPLE
PSCustomObjects-1.0.ps1
  
#>

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#Create a PSCustomObject
$me = [PSCustomObject]@{
    Name     = 'Jon'
    City     = 'Portsmouth'
    County   = 'Hants'
}

write-output "My name is $($me.Name), I come from $($me.City), $($me.County)"

#Add a new property to the object
$me | Add-Member -MemberType NoteProperty -Name 'Age' -Value '30'
$me | Add-Member -MemberType NoteProperty -Name 'Car' -Value 'Mondeo'


#List all of the property types
$me | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name

#Add a scriptblock with args to the object
$ScriptBlock = {
    param(
        [string]$newCar
    )
    Write-Output "I currently drive a $($this.car)"
    if ($newCar){
        $this.car = $newCar
        Write-Output "I now drive a $($this.car)"
    }else{
        Write-Output "I still drive a $($this.car)"
    }
}

$memberParam = @{
    MemberType  = "ScriptMethod"
    InputObject = $me
    Name        = "NewCar"
    Value       = $scriptBlock
}
Add-Member @memberParam

$me.NewCar()
$me.NewCar("Porsche")




