{
  Temporary feature: Skin for taskbar icons as background form
}
unit skinform;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DWMApi, GDIPAPI, GDIPOBJ, xgraphics;

type
  TSkinDimensions = record
    Image: String;
    LeftWidth: Integer;
    TopHeight: Integer;
    RightWidth: Integer;
    BottomHeight: Integer;
    OutsideBorderTop: Integer;
    OutsideBorderBottom: Integer;
    OutsideBorderLeft: Integer;
    OutsideBorderRight: Integer;
  end;

  TSkin = class(TComponent)
  private
    Pic: TGdipBitmap;
    Name: String;
    Background: TSkinDimensions;
    BackgroundLeft: TSkinDimensions;
    BackgroundRight: TSkinDimensions;
    BackgroundTop: TSkinDimensions;
  end;

  TForm2 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    _blurbehind: Boolean;
    procedure WMShowWindow(var msg: TWMShowWindow);
    procedure WMSize(var msg: TMessage); message WM_SIZE;
    procedure RestoreRequest(var message: TMessage); message WM_USER + $1000;
  public
    { Public declarations }
  published
    property BlurBehind: Boolean read _blurbehind write _blurbehind;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses functions, main;

const
  WndClassName = 'TSkinTaskbarDockWindow';

var
  WndClass: TWndClass =
  (
    style : CS_HREDRAW or CS_VREDRAW;
    cbClsExtra: 0;
    cbWndExtra: 0;
    hIcon: 0;
    hCursor: 0;
    hbrBackground: 0;
    lpszMenuName: nil;
    lpszClassName: WndClassName;
  );
  WindowList: TList;
  WindowParent: HWND;


procedure TForm2.FormCreate(Sender: TObject);
var
  renderPolicy: Integer;
begin
  Color := clBlack;
  EnableBlur(Self.Handle);
  BorderIcons := [];

  renderPolicy := 1;

  if DwmCompositionEnabled then
    DwmSetWindowAttribute(Self.Handle, DWMWA_EXCLUDED_FROM_PEEK or DWMWA_FLIP3D_POLICY, @renderPolicy, SizeOf(Integer));

   SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_TRANSPARENT or WS_EX_TOOLWINDOW {and not WS_EX_APPWINDOW});
//   SetLayeredWindowAttributes(Handle,0,128, LWA_ALPHA);

//   SetWindowPos(Handle,HWND_TOPMOST,Left,Top,Width, Height,SWP_NOMOVE or SWP_NOACTIVATE or SWP_NOSIZE);

//  Winapi.Windows.SetParent(Self.Handle, Form1.Taskbar.handle);

end;

procedure TForm2.FormPaint(Sender: TObject);
begin
  if TaskbarAccented then
  begin
    Canvas.Brush.Handle := CreateSolidBrushWithAlpha(BlendColors(GetAccentColor, clBlack,50), 200);
  end
  else
  begin
    if SystemUsesLightTheme then
      Canvas.Brush.Handle := CreateSolidBrushWithAlpha($dddddd, 200)    else
      Canvas.Brush.Handle := CreateSolidBrushWithAlpha($222222, 200);
  end;
  Canvas.FillRect(Rect(0,0,Width,Height));
end;

procedure TForm2.FormResize(Sender: TObject);
begin
  self.WindowState := wsNormal;
  
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TForm2.RestoreRequest(var message: TMessage);
begin
  Self.Show;
end;

procedure TForm2.WMShowWindow(var msg: TWMShowWindow);
begin
  if not msg.Show then
  msg.Result := 0
  else
    inherited
end;

procedure TForm2.WMSize(var msg: TMessage);
begin
  if msg.WParam = SIZE_MINIMIZED then
    self.WindowState := wsNormal;
end;

{ TSkin }


(*function SkinWndProc(hWnd: HWND; uMsg: UINT; wParam: UINT; lParam: UINT):HRESULT; stdcall;
var
  i: Integer;
begin
  Result := DefWindowProc(hWnd, uMsg, wParam, lParam);
end;*)

(*initialization
  WndClass.lpfnWndProc := @SkinWndProc;
  WndClass.hInstance := HInstance;
  Winapi.Windows.RegisterClass(WndClass);
  WindowList := TList.Create;
  WindowParent := CreateWindow(WndClassName, #0, WS_POPUP, 0, 0, 0, 0, 0, 0, HInstance, nil);

finalization
  DestroyWindow(WindowParent);
  WindowList.Free;*)

end.
