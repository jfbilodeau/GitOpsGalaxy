# GitOpsGalaxy

## How to use

**GitHub Foundation demo** — a small ASP.NET Core Razor Pages application demonstrating GitOps-friendly structure and deployment artifacts.

This repository contains a sample Razor Pages app targeting .NET 9 and a Bicep template for deploying the app to Azure App Service.

**What you'll find here**
- Source: simple Razor Pages app (Pages/, Program.cs, appsettings.json)
- Infrastructure: Bicep file in `bicep/gitopsgalaxy-appservice.bicep`
- CI/CD: GitHub Actions workflow in `.github/workflows` (example pipeline)

Getting started
----------------

Prerequisites
- .NET 9 SDK (install from https://dotnet.microsoft.com)
- Git

Clone the repository

```bash
git clone https://github.com/jfbilodeau/GitOpsGalaxy.git
cd GitOpsGalaxy
git checkout logo
```

Run locally (cross-platform)

```bash
dotnet restore
dotnet build
dotnet run --project GitOpsGalaxy.csproj
```

Open a browser and navigate to `https://localhost:5001` or the URL shown in the console.

Run in Visual Studio (Windows)
- Open `GitOpsGalaxy.sln` in Visual Studio 2022/2023
- Set the solution as startup and run (F5)

Notes about configuration
- Environment-specific settings live in `appsettings.Development.json` and `appsettings.json`.
- Launch profiles are defined in `Properties/launchSettings.json` for local development.

Deployment notes
- The `bicep/gitopsgalaxy-appservice.bicep` file contains a sample deployment template for Azure App Service. You can deploy it with the Azure CLI:

```bash
az deployment group create --resource-group <RG_NAME> --template-file bicep/gitopsgalaxy-appservice.bicep --parameters appName=<APP_NAME>
```

CI/CD
- This repo includes a sample GitHub Actions workflow at `.github/workflows/gitops-galaxy-cicd.yml` used by the demo to build and (optionally) publish artifacts. Adjust secrets and targets to match your environment.

## Architecture
Below is a simple Mermaid diagram illustrating the application's structure and GitOps deployment flow.

```mermaid
flowchart LR
  Dev[Developer] -->|push/PR| Repo[GitHub Repo]
  Dev -->|local run| Local[Local dev (dotnet run)]
  Repo --> CI[GitHub Actions]
  CI --> Artifact[Build Artifact]
  Artifact -->|deploy| Infra[ARM / Bicep]
  Infra --> App[App Service (Razor Pages)]
  App -->|serves| Browser[User Browser]
  Infra --> KeyVault[Key Vault]
  App --> Insights[App Insights]
```

Contributing
- This repo is a demo. Feel free to fork and experiment. For changes that you want considered upstream, open a pull request against the `main` branch.

License
- This sample is provided for demonstration purposes.
