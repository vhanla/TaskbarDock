unit tbicons;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ShlObj, IniFiles;

type
  TForm2 = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    Label1: TLabel;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    AppData: String;
    function ListLnkFiles: Integer;
    procedure MakeBackup;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  // Update taskbar icons
  SHChangeNotify(134217728, 0, nil, nil);
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  ListLnkFiles;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  AppData := GetEnvironmentVariable('APPDATA');
  ListLnkFiles;
end;

function TForm2.ListLnkFiles: Integer;
var
  PinnedPath: String;
  SRec: TSearchRec;
  Res: Integer;
  I, Index: Integer;
  BannedLnks: THashedStringList;
  Ini: TIniFile;
begin
  Result := 0;
  PinnedPath := AppData + '\Microsoft\Internet Explorer\Quick Launch\User Pinned\Taskbar\';
  if DirectoryExists(PinnedPath) then
  begin
    ListBox1.Items.BeginUpdate;
    ListBox1.Items.Clear;
    if FileExists(PinnedPath + 'desktop.ini') then
    begin
      BannedLnks := THashedStringList.Create;
      BannedLnks.Sorted := True;
      BannedLnks.Duplicates := dupIgnore;
      BannedLnks.Sort;
      try
        ini := TIniFile.Create(PinnedPath + 'desktop.ini');
        try
          ini.ReadSection('LocalizedFileNames', BannedLnks);
        finally
          ini.Free;
        end;
      finally
        // bannedlnks kept on memory until we read all
      end;
    end;

    Res := FindFirst(PinnedPath + '*.lnk', faAnyFile, SRec);
    if Res = 0 then
    try
      while Res = 0 do
      begin
        if (SRec.Attr and faDirectory <> faDirectory) then
        begin
          if BannedLnks <> nil then
          begin
            if BannedLnks.Find(SRec.Name, Index) then
            begin
              // let's ignore this lnk
            end
            else
            begin
              ListBox1.Items.Add(SRec.Name);
              Inc(Result);
            end;
          end
          else
          begin
            ListBox1.Items.Add(SRec.Name);
            Inc(Result);
          end;
        end;
        Res := FindNext(SRec);
      end;
    finally
      FindClose(SRec);
    end;

    // if banned was found
    FreeAndNil(BannedLnks);
    ListBox1.Items.EndUpdate;
  end;
end;

procedure TForm2.MakeBackup;
begin

end;

end.
