Function Register-MyAzureRepository {
    [cmdletbinding()]
    Param (
        [Parameter(Mandatory=$true)]
        [string]$RepositoryName,

        [Parameter(Mandatory=$true)]
        [string]$RepositorySource,

        [Parameter(Mandatory=$true)]
        [string]$UserName,

        [Parameter(Mandatory=$true)]
        [string]$Token
    )

    $url = "https://pkgs.dev.azure.com/${UserName}/${ProjectName}/_packaging/${Artifact}"

    $nugetoptions = @{
        name = $Name
        source = $RepositorySource
        user = $UserName
        password = $Token
    }

    # Register the NuGet source
    & nuget sources add @nugetoptions

    $PAT = $Token | ConvertTo-SecureString -AsPlainText -Force

    $AzureCreds = New-Object System.Management.Automation.PSCredential($UserName, $PAT)

    $psoptions = @{
        Name = $RepositoryName
        SourceLocation = $RepositorySource
        PublishLocation = $RepositorySource
        InstallationPolicy =  Trusted
        Credential =  $AzureCreds
    }
    Register-PSRepository @psoptions
}

