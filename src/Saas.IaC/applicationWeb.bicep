// Parameters
//////////////////////////////////////////////////
@description('The App Service Plan ID.')
param appServicePlanId string

@description('The location for all resources.')
param location string

@description('The Application App Service name.')
param applicationAppServiceName string

@description('The URL for the container registry to pull the docker images from')
param containerRegistryUrl string

@description('The tag of the container image to deploy to the permissions api app service')
param applicationApiContainerImageTag string


// Resource - Signup Admin App Service
//////////////////////////////////////////////////
resource applicationAppService 'Microsoft.Web/sites@2021-03-01' = {
  name: applicationAppServiceName
  location: location
  kind: 'app,linux,container'
  properties: {
    serverFarmId: appServicePlanId
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'DOCKER|${applicationApiContainerImageTag}'
      appSettings: [
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: containerRegistryUrl
        }     
      ]
    }
  }
}

// Resource - Application App Service - Deployment
//////////////////////////////////////////////////
// resource applicationAppServiceDeployment 'Microsoft.Web/sites/extensions@2021-03-01' = {
//   parent: applicationAppService
//   name: 'MSDeploy'
//   properties: {
//     packageUri: 'https://stsaasdev001.blob.${environment().suffixes.storage}/artifacts/saas-provider/Saas.Provider.Web.zip?sv=2020-04-08&st=2021-06-07T19%3A23%3A20Z&se=2022-06-08T19%3A23%3A00Z&sr=c&sp=rl&sig=kNf0qwTfaCJg02xYeUHlfmHOJvI1bGU1HftjUJ5hl5o%3D'
//   }
// }

// Outputs
//////////////////////////////////////////////////
output applicationAppServiceHostName string = applicationAppService.properties.defaultHostName
