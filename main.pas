unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Registry,
  OTLParallel, OTLTaskControl, taskbar;

type
  TForm1 = class(TForm)
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    PinnedIcons1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    tmrUpdateTBinfo: TTimer;
    tmrOptions: TTimer;
    tmrThreadWaiter: TTimer;
    tmrCenter: TTimer;
    Start1: TMenuItem;
    Tray1: TMenuItem;
    Full1: TMenuItem;
    Center1: TMenuItem;
    Transparent1: TMenuItem;
    N2: TMenuItem;
    About1: TMenuItem;
    N3: TMenuItem;
    StartwithWindows1: TMenuItem;
    procedure PinnedIcons1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tmrUpdateTBinfoTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tmrThreadWaiterTimer(Sender: TObject);
    procedure tmrCenterTimer(Sender: TObject);
    procedure tmrOptionsTimer(Sender: TObject);
    procedure Start1Click(Sender: TObject);
    procedure Tray1Click(Sender: TObject);
    procedure Full1Click(Sender: TObject);
    procedure Center1Click(Sender: TObject);
    procedure Transparent1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure StartwithWindows1Click(Sender: TObject);
  private
    { Private declarations }
    Taskbar: TTaskbar;
    Taskbar2: TTaskbar;

    function FindWindowRecursive(hParent: HWND; szClass: PWideChar; szCaption:PWideChar): HWND;
    procedure GetTaskbarWindows;
    procedure Init;
    procedure AutoStartState;
    procedure SetAutoStart(runwithwindows: Boolean = True);
  public
    { Public declarations }
  protected
    procedure WndProc(var Msg: TMessage); override;
  end;

  //Requires setversion.cmd to be run prior to build for release
  {$include RELEASENUMBER.inc}
  {$include VERSION.inc}

var
  Form1: TForm1;
  // Global variables
  AppIsRunning: Boolean = False;
  ThreadIsRunning: Boolean = False;
  CloseApp: Boolean = False;
  fwm_TaskbarRestart: Cardinal;


implementation

{$R *.dfm}

uses
tbicons;

procedure TForm1.About1Click(Sender: TObject);
begin
  MessageDlg('TaskbarDock v'+VERSION+RELEASENUMBER+
  #13'Author: vhanla'+
  #13'MIT License'+
  #13#13'https://github.com/vhanla/taskbardock',mtInformation, [mbOK], 0);
end;

procedure TForm1.AutoStartState;
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_CURRENT_USER;
    reg.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion\Run');
    if reg.ValueExists('TaskbarDock') then
      if reg.ReadString('TaskbarDock')<>'' then
        StartwithWindows1.Checked := True;
    reg.CloseKey;
  finally
    reg.Free;
  end;
end;

procedure TForm1.Center1Click(Sender: TObject);
begin
  Center1.Checked := not Center1.Checked;
  tmrCenter.Enabled := Center1.Checked;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  CloseApp := True;
  Close;
end;

function TForm1.FindWindowRecursive(hParent: HWND; szClass,
  szCaption: PWideChar): HWND;
begin

end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  AppIsRunning := False;
  CanClose := False;
  if CloseApp then
  begin
    tmrOptions.Enabled := False;
    Taskbar2.StartBtnVisible();
    Taskbar2.NotifyAreaVisible();
    Taskbar.StartBtnVisible();
    Taskbar.NotifyAreaVisible();

    if not ThreadIsRunning then
      CanClose := True
    else
      tmrThreadWaiter.Enabled := True;
  end
  else
  begin
    Hide;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  AutoStartState;
  Init;
  tmrUpdateTBinfo.Enabled := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Taskbar2.Free;
  Taskbar.Free;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TForm1.Full1Click(Sender: TObject);
begin
  Full1.Checked := not Full1.Checked;
end;

procedure TForm1.GetTaskbarWindows;
begin

end;

procedure TForm1.Init;
begin
  tmrCenter.Interval := 50;
  tmrUpdateTBinfo.Interval := 750;
  tmrThreadWaiter.Interval := 10;

  Taskbar := TTaskbar.Create;
  Taskbar.UpdateTaskbarInfo;
  Taskbar.TransStyle := ACCENT_ENABLE_TRANSPARENTGRADIENT;

  Taskbar2 := TTaskbar.Create(2);
  Taskbar2.UpdateTaskbarInfo;
  Taskbar2.TransStyle := ACCENT_ENABLE_TRANSPARENTGRADIENT;

  AppIsRunning := True;
  ThreadIsRunning := True;
  Parallel.Async(
    procedure
    begin
      while AppIsRunning do
      begin
        if Form1.Transparent1.Checked then
        begin
          Form1.Taskbar.Transparent;
          Form1.Taskbar2.Transparent;
        end;
        Sleep(10);
      end
    end,
    Parallel.TaskConfig.OnTerminated(
      procedure
      begin
        ThreadIsRunning := False;
      end
    )
  );

  fwm_TaskbarRestart := RegisterWindowMessage('TaskbarCreated');
end;

procedure TForm1.PinnedIcons1Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.Transparent1Click(Sender: TObject);
begin
  Transparent1.Checked := not Transparent1.Checked;
end;

procedure TForm1.Tray1Click(Sender: TObject);
begin
  Tray1.Checked := not Tray1.Checked;
end;

procedure TForm1.SetAutoStart(runwithwindows: Boolean);
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_CURRENT_USER;
    reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run', False);
    if runwithwindows then
      reg.WriteString('TaskbarDock', ParamStr(0))
    else
      if reg.ValueExists('TaskbarDock') then
        reg.DeleteValue('TaskbarDock');
    reg.CloseKey;
  finally
    reg.Free;
  end;
end;

procedure TForm1.Start1Click(Sender: TObject);
begin
  Start1.Checked := not Start1.Checked;
end;

procedure TForm1.StartwithWindows1Click(Sender: TObject);
begin
  StartwithWindows1.Checked := not StartwithWindows1.Checked;
  SetAutoStart(StartwithWindows1.Checked);
end;

procedure TForm1.tmrCenterTimer(Sender: TObject);
begin
  Taskbar2.CenterAppsButtons;
  Taskbar.CenterAppsButtons;
end;

procedure TForm1.tmrOptionsTimer(Sender: TObject);
var
  sm: THandle;
  smr: TRect;
  ms: TPoint;
begin
  try
    ms := Mouse.CursorPos;
  except
  end;

  if Start1.Checked then
  begin
    Taskbar2.StartBtnVisible();
    Taskbar.StartBtnVisible();
  end
  else
  begin
    Taskbar2.StartBtnVisible(False);
    Taskbar.StartBtnVisible(False);
    if (ms.X >= Taskbar.StartRect.Left)
    and (ms.X <= Taskbar.StartRect.Right)
    and (ms.Y >= Taskbar.StartRect.Top)
    and (ms.Y <= Taskbar.StartRect.Bottom)
    then
      Taskbar.StartBtnVisible();
    if (ms.X >= Taskbar2.StartRect.Left)
    and (ms.X <= Taskbar2.StartRect.Right)
    and (ms.Y >= Taskbar2.StartRect.Top)
    and (ms.Y <= Taskbar2.StartRect.Bottom)
    then
      Taskbar2.StartBtnVisible();
  end;

  if Tray1.Checked then
  begin
    Taskbar2.NotifyAreaVisible();
    Taskbar.NotifyAreaVisible();
  end
  else
  begin
    Taskbar2.NotifyAreaVisible(False);
    Taskbar.NotifyAreaVisible(False);
    if (ms.X >= Taskbar.TrayRect.Left)
    and (ms.X <= Taskbar.TrayRect.Right)
    and (ms.Y >= Taskbar.TrayRect.Top)
    and (ms.Y <= Taskbar.TrayRect.Bottom)
    then
      Taskbar.NotifyAreaVisible();

    if (ms.X >= Taskbar2.TrayRect.Left)
    and (ms.X <= Taskbar2.TrayRect.Right)
    and (ms.Y >= Taskbar2.TrayRect.Top)
    and (ms.Y <= Taskbar2.TrayRect.Bottom)
    then
      Taskbar2.NotifyAreaVisible();
  end;

  if Full1.Checked then
  begin
    Taskbar2.FullTaskBar;
    Taskbar.FullTaskBar;
  end;

end;

procedure TForm1.tmrThreadWaiterTimer(Sender: TObject);
begin
  if not ThreadIsRunning then
    Close
end;

procedure TForm1.tmrUpdateTBinfoTimer(Sender: TObject);
begin
  Taskbar2.UpdateTaskbarHandle;
  Taskbar2.UpdateTaskbarInfo;
  Taskbar.UpdateTaskbarInfo;
end;

procedure TForm1.WndProc(var Msg: TMessage);
begin
  if Msg.Msg = fwm_TaskbarRestart then
  begin
    Taskbar2.UpdateTaskbarHandle;
    Taskbar.UpdateTaskbarHandle;
    Taskbar2.UpdateTaskbarInfo;
    Taskbar.UpdateTaskbarInfo;
  end;

  inherited WndProc(Msg);
end;

end.
