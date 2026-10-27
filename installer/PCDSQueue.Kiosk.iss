#define MyAppName "Queue Management System - Kiosk"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Polytechnic College of Davao del Sur"
#define MyAppExeName "PCDSQueue.Kiosk.exe"

[Setup]
AppId={{9B79A1D5-F41C-4872-9A68-52DA4412909C}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\Queue Management System\Kiosk
DefaultGroupName=Queue Management System
OutputDir=..\release\Installers
OutputBaseFilename=Queue Management System Kiosk Setup
SetupIconFile=..\desktop\PCDSQueue.Admin\PCDSQueue.Admin\Assets\pcds-queue.ico
UninstallDisplayIcon={app}\{#MyAppExeName}
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
PrivilegesRequired=admin
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
CloseApplications=yes
RestartApplications=no

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional shortcuts:"; Flags: unchecked

[Files]
Source: "..\release\publish\Kiosk\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\Queue Management System - Kiosk"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\Queue Management System - Kiosk"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Launch Queue Management System - Kiosk"; Flags: nowait postinstall skipifsilent
