#define MyAppName "Queue Management System - TV Display"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Polytechnic College of Davao del Sur"
#define MyAppExeName "PCDSQueue.TVDisplay.exe"

[Setup]
AppId={{B1A6F012-740A-45D6-A9E0-12B6EFD2E302}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\Queue Management System\TV Display
DefaultGroupName=Queue Management System
OutputDir=..\release\Installers
OutputBaseFilename=Queue Management System TV Display Setup
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
Source: "..\release\publish\TVDisplay\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\tv-display\PCDSQueue.TVDisplay\Assets\notification.wav"; DestDir: "{app}\Assets"; Flags: ignoreversion

[Icons]
Name: "{group}\Queue Management System - TV Display"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\Queue Management System - TV Display"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Launch Queue Management System - TV Display"; Flags: nowait postinstall skipifsilent
