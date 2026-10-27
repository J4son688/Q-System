# Windows installers

The installer build produces separate x64 installers for Admin, Staff, Kiosk,
and TV Display. Each package is self-contained, so target computers do not need
Visual Studio or a separately installed .NET runtime.

All four apps default to the hosted API at
`https://pcds-queue-api.onrender.com`. Setting the Windows user environment
variable `PCDS_QUEUE_API_URL` overrides that default.

## Build locally

Install the .NET 8 SDK and Inno Setup 6, open PowerShell at the repository root,
then run:

```powershell
.\installer\Build-Installers.ps1
```

The setup executables are written to `release\Installers`. The script publishes
the four projects as self-contained `win-x64` apps before compiling installers.

## Build using GitHub Actions

Open the repository's **Actions** tab, choose **Build Windows installers**,
select **Run workflow**, and download the installer artifact from the completed
run. A tag named `installer-v*` also starts an installer build. Workflow
artifacts are retained for 30 days.

## Install on each station

Install only the app needed for each computer. The Admin, Staff, Kiosk, and TV
Display apps all connect to the same hosted API and database by default. Launch
the app from its Start Menu shortcut or optional desktop shortcut, then sign in
where applicable. Do not put database credentials in desktop app settings.
