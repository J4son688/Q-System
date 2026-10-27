#define MyAppName "Queue Management System - Admin"
#define MyAppVersion "1.0.3"
#define MyAppPublisher "Polytechnic College of Davao del Sur"
#define MyAppExeName "PCDSQueue.Admin.exe"

[Setup]
AppId={{874F92DA-8109-4BF7-B3BB-34C63BE14275}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\PCDS Queue\Admin
DefaultGroupName=Queue Management System
OutputDir=..\release\Installers
OutputBaseFilename=PCDS Queue Admin Setup
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
Source: "..\release\publish\Admin\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\Queue Management System - Admin"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\Queue Management System - Admin"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Launch Queue Management System - Admin"; Flags: nowait postinstall skipifsilent
