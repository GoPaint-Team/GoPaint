; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "GoPaint"
#define MyAppVersion "1.0"
#define MyAppPublisher "GoPaint Team"
#define MyAppExeName "gopaint.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{439330A2-6C8C-40DE-A2C0-8693D144DB74}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={pf}\{#MyAppName}
DisableProgramGroupPage=yes
OutputBaseFilename=setup
Compression=lzma
SolidCompression=yes
WizardImageFile=back.bmp
WizardSmallImageFile=hed1.bmp

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"
Name: "catalan"; MessagesFile: "compiler:Languages\Catalan.isl"
Name: "corsican"; MessagesFile: "compiler:Languages\Corsican.isl"
Name: "czech"; MessagesFile: "compiler:Languages\Czech.isl"
Name: "danish"; MessagesFile: "compiler:Languages\Danish.isl"
Name: "dutch"; MessagesFile: "compiler:Languages\Dutch.isl"
Name: "finnish"; MessagesFile: "compiler:Languages\Finnish.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "greek"; MessagesFile: "compiler:Languages\Greek.isl"
Name: "hebrew"; MessagesFile: "compiler:Languages\Hebrew.isl"
Name: "hungarian"; MessagesFile: "compiler:Languages\Hungarian.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl"
Name: "norwegian"; MessagesFile: "compiler:Languages\Norwegian.isl"
Name: "polish"; MessagesFile: "compiler:Languages\Polish.isl"
Name: "portuguese"; MessagesFile: "compiler:Languages\Portuguese.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "scottishgaelic"; MessagesFile: "compiler:Languages\ScottishGaelic.isl"
Name: "serbiancyrillic"; MessagesFile: "compiler:Languages\SerbianCyrillic.isl"
Name: "serbianlatin"; MessagesFile: "compiler:Languages\SerbianLatin.isl"
Name: "slovenian"; MessagesFile: "compiler:Languages\Slovenian.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"
Name: "turkish"; MessagesFile: "compiler:Languages\Turkish.isl"
Name: "ukrainian"; MessagesFile: "compiler:Languages\Ukrainian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\Users\zohan\Downloads\GoPaint\dist\gopaint.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\zohan\Downloads\GoPaint\dist\back.bmp"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\zohan\Downloads\GoPaint\dist\back.png"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\zohan\Downloads\GoPaint\dist\brush.png"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\zohan\Downloads\GoPaint\dist\color.png"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\zohan\Downloads\GoPaint\dist\fakefinishbitmap.bmp"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\zohan\Downloads\GoPaint\dist\fakefinishbitmap.png"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\zohan\Downloads\GoPaint\dist\gopaint.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\zohan\Downloads\GoPaint\dist\header.bmp"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\zohan\Downloads\GoPaint\dist\header.png"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\zohan\Downloads\GoPaint\dist\icon.png"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\zohan\Downloads\GoPaint\dist\open.png"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\zohan\Downloads\GoPaint\dist\save.png"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\zohan\Downloads\GoPaint\dist\splash.bmp"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\zohan\Downloads\GoPaint\dist\splash.png"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\zohan\Downloads\GoPaint\dist\wizard.bmp"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\zohan\Downloads\GoPaint\dist\wizzard.png"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\zohan\Downloads\GoPaint\dist\wiz1.bmp"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Code]
procedure InitializeWizard();
begin
  { Hide welcome labels }
  WizardForm.WelcomeLabel1.Visible := False;
  WizardForm.WelcomeLabel2.Visible := False;

  { Stretch welcome image }
  WizardForm.WizardBitmapImage.Width := WizardForm.WizardBitmapImage.Parent.Width;
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = wpFinished then begin
    ExtractTemporaryFile('wiz1.bmp');
    WizardForm.WizardBitmapImage2.Bitmap.LoadFromFile(ExpandConstant('{tmp}\wizard.bmp'));
    WizardForm.WizardBitmapImage2.Width := WizardForm.WizardBitmapImage2.Parent.Width;

    { Optionally hide default finish labels }
    WizardForm.FinishedLabel.Visible := False;
    WizardForm.FinishedHeadingLabel.Visible := False;
  end;
end;

[Icons]
Name: "{commonprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

