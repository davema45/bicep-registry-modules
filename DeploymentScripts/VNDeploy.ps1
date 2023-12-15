# For Azure global regions
# Set Platform connectivity subscription ID as the the current subscription
$LandingZoneSubscriptionId = "9d2f35f1-13e3-4a2d-a5c6-0043b1b84efa"

Select-AzSubscription -SubscriptionId $LandingZoneSubscriptionId

# Set the top level MG Prefix in accordance to your environment. This example assumes default 'alz'.
$TopLevelMGPrefix = "D2001"

# Parameters necessary for deployment
$inputObject = @{
  DeploymentName        = 'BicepVnetTest{0}' -f ( -join (Get-Date -Format 'yyyyMMddTHHMMssffffZ')[0..63])
  ResourceGroupName     = "$TopLevelMGPrefix-NET-rg02"
  TemplateParameterFile = "DeploymentScripts\vnet.param.json"
  TemplateFile          = "avm\res\network\virtual-network\main.bicep"
}

New-AzResourceGroup `
  -Name $inputObject.ResourceGroupName `
  -Location 'eastus'

New-AzResourceGroupDeployment @inputObject
