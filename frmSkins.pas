unit frmSkins;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UCL.TUText;

type
  TfrmSkin = class(TFrame)
    UText3: TUText;
    ComboBox1: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
    skinsBasePath: String;
  end;

implementation

{$R *.dfm}

end.
