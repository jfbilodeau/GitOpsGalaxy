@description('Location to deploy resources')
param location string = 'canadacentral'

@description('Name of the App Service Plan')
param appServicePlanName string = 'GitOpsGalaxyDemo-asp'

@description('SKU name for the App Service Plan')
param skuName string = 'P0v3'

@description('SKU tier for the App Service Plan')
param skuTier string = 'PremiumV3'

@description('Instance count for the App Service Plan')
param skuCapacity int = 1

@description('Name of the Web App to create')
param webAppName string = 'gitopsgalaxydemo'

@description('Linux FX version for .NET 9 (App Service Linux runtime identifier)')
param linuxFxVersion string = 'DOTNET|9.0'

var tags = {
  project: 'GitOpsGalaxy'
  environment: 'demo'
}

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  tags: tags
  sku: {
    name: skuName
    tier: skuTier
    capacity: skuCapacity
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: webAppName
  location: location
  tags: tags
  kind: 'app,linux'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
      alwaysOn: true
      http20Enabled: true
      minTlsVersion: '1.2'
    }
    httpsOnly: true
  }
}

@description('The default host name for the created Web App')
output defaultHostName string = webApp.properties.defaultHostName

@description('Public endpoint for the Web App')
output endpoint string = 'https://${webApp.properties.defaultHostName}'
