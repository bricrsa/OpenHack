$teamCount = Read-Host "How many teams are hacking?";
#get-azlocation | Select Location, DisplayName | Format-Table
$region = "northeurope";

for ($i = 1; $i -le $teamCount; $i++)
{
    $teamName = $i;
    if ($i -lt 10)
    {
        $teamName = "0" + $i;
    }
    
    $resourceGroupName = "ServerlessOpenHackRG" + $teamName + "-" + $region
    $deploymentName = "azuredeploy" + "-" + (Get-Date).ToUniversalTime().ToString('MMdd-HHmmss')
    Write-Host("Now deploying RG to " + $resourceGroupName);

    New-AzResourceGroup -Name $resourceGroupName -Location $region

    $rg = Get-AzResourceGroup -Name $resourceGroupName
    if ($rg.Name -ne '')
    {
        Write-Host("Now deploying template " + $rg.Name + " with deploymentname: " + $deploymentName);

        New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile './azuredeploy.json' -Name $deploymentName -Verbose 

        Write-Host("Deployment Completed for " + $resourceGroupName);
    }
    else {
        Write-Host("Deployment failed for " + $resourceGroupName);
    }
    
}