$MDSModelDeployCMD =  "C:\Program Files\Microsoft SQL Server\130\Master Data Services\Configuration\MDSModelDeploy.exe"
$outputFolder = "F:\DataManagement\MDS"

$list = & $MDSModelDeployCMD listmodels

Write-Host("-----------list:")
$list

Write-Host("-----------Matches:")
$regex = 'Models:\s+(.*)\sMDSModelDeploy' 

$listResult=[regex]::Match($list,$regex,[System.Text.RegularExpressions.RegexOptions]::Singleline).Groups[1].Value
$listResult.trim() -split(" ") | ForEach { 
    "Processing Model:$_"
    $package = "$outputFolder\$_.pkg"
    & "C:\Program Files\Microsoft SQL Server\130\Master Data Services\Configuration\MDSModelDeploy.exe" createpackage -model $_ -package $package
    
 }
