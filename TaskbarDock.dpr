program TaskbarDock;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  Windows,
  SysUtils,
  main in 'main.pas' {Form1},
  tbicons in 'tbicons.pas' {Form2},
  taskbar in 'taskbar.pas';

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
