#define MyAppName "Queue Management System - Staff"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Polytechnic College of Davao del Sur"
#define MyAppExeName "PCDSQueue.Staff.exe"

[Setup]
AppId={{8F9F25D2-77E5-4A9D-A1D1-A3EA4EAB4367}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\Queue Management System\Staff
DefaultGroupName=Queue Management System
OutputDir=..\release\Installers
OutputBaseFilename=Queue Management System Staff Setup
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
Source: "..\release\publish\Staff\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\Queue Management System - Staff"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\Queue Management System - Staff"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Launch Queue Management System - Staff"; Flags: nowait postinstall skipifsilent
