unit frmIcons;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UCL.TUText,
  UCL.TUButton, Vcl.ExtCtrls, UCL.TUScrollBox, IniFiles, Vcl.ExtDlgs;

type
  TframeIcons = class(TFrame)
    UScrollBox2: TUScrollBox;
    ListBox1: TListBox;
    imgOriginal: TImage;
    UButton5: TUButton;
    UText3: TUText;
    OpenPictureDialog1: TOpenPictureDialog;
    imgNormal: TImage;
    imgAlt: TImage;
    UText1: TUText;
    UText2: TUText;
    UText4: TUText;
    UButton1: TUButton;
    UButton2: TUButton;
    UButton3: TUButton;
    procedure UButton5Click(Sender: TObject);
    procedure UButton1Click(Sender: TObject);
    procedure UButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function ListLnkFiles: Integer;
  end;

implementation

{$R *.dfm}

uses main, taskbar, shlobj;

function TframeIcons.ListLnkFiles: Integer;
var
  PinnedPath: String;
  SRec: TSearchRec;
  Res: Integer;
  I, Index: Integer;
  //BannedLnks: THashedStringList;
  Ini: TIniFile;
begin
  Result := 0;
  PinnedPath := GetEnvironmentVariable('APPDATA') + '\Microsoft\Internet Explorer\Quick Launch\User Pinned\Taskbar\';
  if DirectoryExists(PinnedPath) then
  begin
    ListBox1.Items.BeginUpdate;
    ListBox1.Items.Clear;
    (*if FileExists(PinnedPath + 'desktop.ini') then
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
    end;*)

    Res := FindFirst(PinnedPath + '*.lnk', faAnyFile, SRec);
    if Res = 0 then
    try
      while Res = 0 do
      begin
        if (SRec.Attr and faDirectory <> faDirectory) then
        begin
          (*if BannedLnks <> nil then
          begin
            if BannedLnks.Find(SRec.Name, Index) then
            begin
              // let's ignore this lnk
            end
            else
            begin
              ListBox1.Items.Add(StringReplace(SRec.Name, '.lnk', '', [rfReplaceAll]));
              Inc(Result);
            end;
          end
          else *)
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
    //FreeAndNil(BannedLnks);
    ListBox1.Items.EndUpdate;
  end;
end;

procedure TframeIcons.UButton1Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    imgNormal.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end;
end;

procedure TframeIcons.UButton2Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
    imgAlt.Picture.LoadFromFile(OpenPictureDialog1.FileName);
end;

procedure TframeIcons.UButton5Click(Sender: TObject);
begin
    // Update taskbar icons
  SHChangeNotify($8000000, $1000, nil, nil);
  ShowWindow(Form1.Taskbar.Handle, SW_HIDE);
  Sleep(500);
  ShowWindow(Form1.Taskbar.Handle, SW_SHOW);
  UpdateWindow(Form1.Taskbar.Handle);
  RedrawWindow(Form1.Taskbar.Handle, 0, 0, RDW_FRAME or RDW_INVALIDATE or RDW_UPDATENOW or RDW_ALLCHILDREN);
  //RedrawWindow(Taskbar.Handle, @Taskbar.Rect, 0, RDW_FRAME or RDW_INVALIDATE or RDW_UPDATENOW or RDW_ALLCHILDREN);
  InvalidateRect(Form1.Taskbar.Handle, @Form1.Taskbar.Rect, False);
  //SystemParametersInfo(SPI_SETWORKAREA, 0, nil, SPIF_SENDCHANGE);
  Form1.ForceForeground(Form1.Taskbar.Handle);
end;

end.
