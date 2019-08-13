program TaskbarDock;

uses
  {$IFDEF DEBUG}
  FastMM4,
  {$ENDIF }
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  Windows,
  SysUtils,
  main in 'main.pas' {Form1},
  taskbar in 'taskbar.pas',
  frmIcons in 'frmIcons.pas' {frameIcons: TFrame},
  skinform in 'skinform.pas' {Form2},
  functions in 'functions.pas',
  frmSkins in 'frmSkins.pas' {frmSkin: TFrame};

{$R *.res}

begin
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
