program TaskbarDock;

uses
  {$IFDEF DEBUG}
  FastMM4,
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  {$ENDIF }
  Vcl.Forms,
  Windows,
  Dialogs,
  SysUtils,
  main in 'main.pas' {Form1},
  taskbar in 'taskbar.pas',
  frmIcons in 'frmIcons.pas' {frameIcons: TFrame},
  skinform in 'skinform.pas' {Form2},
  functions in 'functions.pas',
  frmSkins in 'frmSkins.pas' {frmSkin: TFrame};

{$R *.res}
var
  WinVersion: Integer;

begin
  if not isWindows10(WinVersion) then
  begin
    MessageDlg('This program is only for Windows 10', mtError, [mbOK], 0);
    Exit;
  end;

  if CreateMutex(nil, True, '7A375875-9ED3-4BAD-922B-80297D6E922E') = 0 then
    RaiseLastOSError;

  if GetLastError = ERROR_ALREADY_EXISTS then
    Exit;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.ShowMainForm := False;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
