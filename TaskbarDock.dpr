program TaskbarDock;

uses
  Vcl.Forms,
  main in 'main.pas' {Form1},
  tbicons in 'tbicons.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
