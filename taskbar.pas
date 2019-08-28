{
  Taskbar unit

  Description:
    This unit gets info from windows taskbar, position, icons
}
unit taskbar;

interface

uses classes, windows, graphics, registry, dwmapi, oleacc, variants, forms, sysutils;

const
  WCA_ACCENT_POLICY = 19;
  ACCENT_DISABLED = 0;
  ACCENT_ENABLE_GRADIENT = 1;
  ACCENT_ENABLE_TRANSPARENTGRADIENT = 2;
  ACCENT_ENABLE_BLURBEHIND = 3;
  ACCENT_ENABLE_ACRYLICBLURBEHIND = 4;

  //https://stackoverflow.com/a/22105803/537347 Windows 8 or newer only
  IID_AppVisibility: TGUID = '{2246EA2D-CAEA-4444-A3C4-6DE827E44313}';
  CLSID_AppVisibility: TGUID = '{7E5FE3D9-985F-4908-91F9-EE19F9FD1514}';
  //IID_IAppVisibilityEvents: TGUID = '{6584CE6B-7D82-49C2-89C9-C6BC02BA8C38}';
  CLSID_IVirtualDesktopManager: TGUID = '{AA509086-5CA9-4C25-8f95-589d3c07b48a}';
  CLSID_VirtualDesktopPinnedApps: TGUID = '{b5a399e7-1c87-46b8-88e9-fc5747b171bd}';
  CLSID_ImmersiveShell: TGUID = '{C2F03A33-21F5-47FA-B4BB-156362A2F239}';
type

  MONITOR_APP_VISIBILITY = (
    MAV_UNKNOWN = 0,
    MAV_NO_APP_VISIBLE = 1,
    MAV_APP_VISIBLE = 2
  );
// *********************************************************************//
// Interface: IAppVisibilityEvents
// Flags:     (0)
// GUID:      {6584CE6B-7D82-49C2-89C9-C6BC02BA8C38}
// *********************************************************************//
  IAppVisibilityEvents = interface(IUnknown)
    ['{6584CE6B-7D82-49C2-89C9-C6BC02BA8C38}']
    function AppVisibilityOnMonitorChanged(hMonitor: HMONITOR;
              previousMode: MONITOR_APP_VISIBILITY;
              currentMode: MONITOR_APP_VISIBILITY):HRESULT; stdcall;
    function LauncherVisibilityChange(currentVisibleState: BOOL): HRESULT; stdcall;
  end;


// *********************************************************************//
// Interface: IAppVisibility
// Flags:     (0)
// GUID:      {2246EA2D-CAEA-4444-A3C4-6DE827E44313}
// *********************************************************************//
  IAppVisibility = interface(IUnknown)
    ['{2246EA2D-CAEA-4444-A3C4-6DE827E44313}']
    function GetAppVisibilityOnMonitor(monitor: HMONITOR; out pMode: MONITOR_APP_VISIBILITY): HRESULT; stdcall;
    function IsLauncherVisible(out pfVisible: BOOL): HRESULT; stdcall;
    function Advise(pCallBack: IAppVisibilityEvents; out pdwCookie: DWORD): HRESULT; stdcall;
    function Unadvise(dwCookie: DWORD): HRESULT; stdcall;
  end;

// *********************************************************************//
// Interface: IVirtualDesktopManager
// Flags:     (0)
// GUID:      {a5cd92ff-29be-454c-8d04-d82879fb3f1b}
// *********************************************************************//
  IVirtualDesktopManager = interface(IUnknown)
    ['{a5cd92ff-29be-454c-8d04-d82879fb3f1b}']
    function IsWindowOnCurrentVirtualDesktop(topLevelWindow: HWND; out onCurrentDesktop: BOOL): HRESULT; stdcall;
    function GetWindowDesktopId(topLevelWindow: HWND; out desktopId: TGUID): HRESULT; stdcall;
    function MoveWindowToDesktop(topLevelWindow: HWND; var desktopId: TGUID): HRESULT; stdcall;
  end;

  AccentPolicy = packed record
    AccentState: Integer;
    AccentFlags: Integer;
    GradientColor: Integer;
    AnimationId: Integer;
  end;

  WindowCompositionAttributeData = packed record
    Attribute: Cardinal;
    Data: Pointer;
    SizeOfData: Integer;
  end;

  TTaskPos = record
  public const
    Left = string('left');
    Top = string('top');
    Right = string('right');
    Bottom = string('bottom');
  end;

  TTaskPosition = string;

  TTaskComponent = record
    Handle: THandle;
    Rect: TRect;
  end;

  PTaskbar = ^TTaskbar;
  TTaskbar = record
  private
//    _reg: TRegistry;
    _position: TTaskPosition; // Position on the screen
    _rect: TRect; // Shell_TrayWnd
    _translucent: Boolean;
    _handle: THandle;
    _notaskbar: Boolean;
    _transstyle: Integer;
    //_monitor: Integer;
    _monitorRect: TRect;
    _monitorId: Integer;
    _mainTaskbar: Boolean;

    _start: TTaskComponent;
    _trayButton1: TTaskComponent;
    _trayButton2: TTaskComponent;
    _trayDummySearchControl: TTaskComponent;
    _reBarWindow32: TTaskComponent;
    _WorkerW: TTaskComponent;
    _MSTaskSwWClass: TTaskComponent;
    _MSTaskListWClass: TTaskComponent;
    _trayNotifyWnd: TTaskComponent;
    _appsBtnLeft, _appsBtnRight: Integer;
    _appsBtnTop, _appsBtnBottom: Integer;

    _timestamp: LongInt;

//    function _IsTransparent: Boolean;
//    procedure HideStartBtn;
//    procedure ShowStartBtn;
//    function _getIconsRect: TRect;

  public
    property StartButton: TTaskComponent read _start;
    property TrayWnd: TTaskComponent read _trayNotifyWnd;
    property MSTaskListWClass: TTaskComponent read _MSTaskListWClass;
    property Handle: THandle read _handle;
    property Position: TTaskPosition read _position write _position;
    property MonitoID: Integer read _monitorId;
    property MonitorRect: TRect read _monitorRect;
    property Rect: TRect read _rect;
//    property IsTransparent: Boolean read _IsTransparent;
    property TransStyle: Integer read _transstyle write _transstyle;
    property MainTaskbar: Boolean read _mainTaskbar;

    property AppsLeft: Integer read _appsBtnLeft;
    property AppsRight: Integer read _appsBtnRight;
//    property MSTaskListRect: TRect read _getIconsRect;
    property MSTaskRect: TRect read _MSTaskSwWClass.Rect;
    property TrayRect: TRect read _trayNotifyWnd.Rect;
    property StartRect: TRect read _start.Rect;
   end;
{    constructor Create(hWnd: THandle);
    procedure Transparent;
    procedure UpdateTaskbarInfo;
    procedure CenterAppsButtons(center: Boolean = True; relative: Boolean = False);
    procedure Hide(handle: THandle);
    procedure Show(handle: THandle);
    procedure StartBtnVisible(visible: Boolean = True);
    procedure NotifyAreaVisible(visible: Boolean = True);
    procedure FullTaskBar;
    function GetMonitor: TMonitor;
    function IsStartMenuVisible: Boolean;
    function ListMainTaskbarElements:TStringList;
  end;}

  TTaskbars = class(TList)
  private
    FCount: Integer;
    function Get(Index: Integer): PTaskbar;
  public
    function Add(Value: PTaskbar): Integer;
    procedure Refresh;
    procedure CenterAppsButtons(center: Boolean = True; relative: Boolean = False);
    procedure StartBtnVisible(Index: Integer;visible: Boolean = True);
    procedure NotifyAreaVisible(visible: Boolean = True);
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
    property Items[Index: Integer]: PTaskbar read Get; default;
    procedure UpdateTaskbarInfo;
    procedure Transparent;

    function IsStartMenuVisible: Boolean;
    procedure RestoreAllStarts;
    destructor Destroy; override;
  end;

  function SetWindowCompositionAttribute(hWnd: HWND; var data: WindowCompositionAttributeData): Integer; stdcall;
    external User32 name 'SetWindowCompositionAttribute';

  function AccessibleChildren(paccContainer: Pointer; iChildStart: LONGINT;
                    cChildren: LONGINT; out rgvarChildren: OleVariant;
                    out pcObtained: LONGINT): HRESULT; stdcall;
                    external 'OLEACC.DLL' name 'AccessibleChildren';

implementation

{ TTaskbar }

uses ActiveX, Shlobj, ComObj;

(*procedure TTaskbar.CenterAppsButtons(center: Boolean = True; relative: Boolean = False);
var
  aLeft, aTop: Integer;
begin
  if _start.Handle = 0 then Exit; // make sure taskbar exists

//  if _appsBtnLeft = 0 then Exit; // #TODO taskbar being sides centering is not handled yet

  if not center then
  begin
    if _mainTaskbar then
      SetWindowPos(_MSTaskListWClass.Handle, 0, 0, 0, _MSTaskSwWClass.Rect.Width, _MSTaskSwWClass.Rect.Height, SWP_NOACTIVATE)
    else
      SetWindowPos(_MSTaskListWClass.Handle, 0, 0, 0, _WorkerW.Rect.Width, _WorkerW.Rect.Height, SWP_NOACTIVATE)
  end
  else
  begin
    //center buttons
    if (Position = TTaskPos.Left) or (Position = TTaskPos.Right) then
    begin
      if _mainTaskbar then
      begin
        if (_appsBtnBottom - _appsBtnTop + 6) > _MSTaskSwWClass.Rect.Height then Exit;

        if relative then
          aTop := (_MSTaskSwWClass.Rect.Height div 2) - ((_appsBtnBottom - _appsBtnTop) div 2)
        else
          aTop := (_rect.Height div 2) - _MSTaskSwWClass.Rect.Top - ((_appsBtnBottom - _appsBtnTop) div 2);

        SetWindowPos(_MSTaskListWClass.Handle, 0, 0, aTop, _MSTaskListWClass.Rect.Width,  (_appsBtnBottom - _appsBtnTop + 6), SWP_NOACTIVATE);
      end
      else
      begin
        if (abs(_appsBtnBottom - _appsBtnTop) + 6) > abs(_WorkerW.Rect.Bottom - _WorkerW.Rect.Top) then Exit;

        if relative then
          aTop := (_WorkerW.Rect.Height div 2) - ((_appsBtnBottom - _appsBtnTop) div 2)
        else
          aTop := (_rect.Height div 2) - abs(_WorkerW.Rect.Top-_rect.Top) - ((_appsBtnBottom - _appsBtnTop) div 2);

        SetWindowPos(_MSTaskListWClass.Handle, 0, 0, aTop, _MSTaskListWClass.Rect.Width, (_appsBtnBottom - _appsBtnTop + 6), SWP_NOACTIVATE);
      end;
    end
    else
    begin
      // if taskbar buttons width is full, there is no need to adjust, 6 is a margin constant
      if _mainTaskbar then
      begin
        if (_appsBtnRight - _appsBtnLeft + 6) > _MSTaskSwWClass.Rect.Width then Exit;

        if relative then
          aLeft := (_MSTaskSwWClass.Rect.Width div 2) - ((_appsBtnRight - _appsBtnLeft) div 2)
        else
          aLeft := (_rect.Width div 2) - _MSTaskSwWClass.Rect.Left - ((_appsBtnRight - _appsBtnLeft) div 2);

        SetWindowPos(_MSTaskListWClass.Handle, 0, aLeft, 0, (_appsBtnRight - _appsBtnLeft + 6), _MSTaskListWClass.Rect.Height, SWP_NOACTIVATE);
      end
      else
      begin
        if (abs(_appsBtnRight - _appsBtnLeft) + 6) > abs(_WorkerW.Rect.Right - _WorkerW.Rect.Left) then Exit;

        if relative then
          aLeft := (_WorkerW.Rect.Width div 2) - ((_appsBtnRight - _appsBtnLeft) div 2)
        else
          aLeft := (_rect.Width div 2) - abs(_WorkerW.Rect.Left-_rect.Left) - ((_appsBtnRight - _appsBtnLeft) div 2);

        SetWindowPos(_MSTaskListWClass.Handle, 0, aLeft, 0, (_appsBtnRight - _appsBtnLeft + 6), _MSTaskListWClass.Rect.Height, SWP_NOACTIVATE);
      end;
    end;
  end;
end;

constructor TTaskbar.Create(hWnd: THandle);
begin
  _transstyle := ACCENT_ENABLE_TRANSPARENTGRADIENT;

    _notaskbar := False

end;

procedure TTaskbar.FullTaskBar;
begin
  if _start.Handle = 0 then Exit;

  if _appsBtnLeft = 0 then Exit;

  SetWindowPos(_MSTaskSwWClass.Handle, 0, 0, 0, _rect.Width, _MSTaskSwWClass.Rect.Height, SWP_NOSENDCHANGING);
end;

function TTaskbar.GetMonitor: TMonitor;
var
  I: Integer;
begin
  if _notaskbar then Exit;

  Result := Screen.MonitorFromRect(_rect);
//  if _maonitor = Result.MonitorNum + 1 then
  begin
    _monitorrect := Result.BoundsRect;
    _monitorId := Result.MonitorNum + 1;
  end;
end;

procedure TTaskbar.Hide(handle: THandle);
begin
  if handle = 0 then Exit;

  ShowWindow(handle, SW_HIDE);
end;

procedure TTaskbar.HideStartBtn;
begin
  Hide(_start.Handle);
end;


procedure TTaskbar.NotifyAreaVisible(visible: Boolean);
begin
  if visible then
    Show(_trayNotifyWnd.Handle)
  else
    Hide(_trayNotifyWnd.Handle);
end;

procedure TTaskbar.Show(handle: THandle);
begin
  if handle = 0 then Exit;

  ShowWindow(handle, SW_SHOWNOACTIVATE);

end;

procedure TTaskbar.ShowStartBtn;
begin
  Show(_start.Handle);
end;

procedure TTaskbar.StartBtnVisible(visible: Boolean);
begin
  if visible then
    Show(_start.Handle)
  else
    Hide(_start.Handle);
end;

procedure TTaskbar.Transparent;
var
  accent: AccentPolicy;
  data: WindowCompositionAttributeData;
begin
  if _notaskbar then Exit;

  accent.AccentState := _transstyle;
  accent.GradientColor := $00000000;
  accent.AccentFlags := 2; // 2: seems to hide the border
  data.Attribute := WCA_ACCENT_POLICY;
  data.SizeOfData := SizeOf(accent);
  data.Data := @accent;

  if _transstyle = ACCENT_ENABLE_TRANSPARENTGRADIENT then
    SetWindowCompositionAttribute(_handle, data);
end;

procedure TTaskbar.UpdateTaskbarInfo;
var
  res: HRESULT;
  acc: IAccessible;
  childArray: array of OleVariant;
  iChildCount, iObtained: Integer;
  i, j, iBtnCount, iBtnObtained: Integer;
  taskbarCaption, childName: WideString;
  childAccessible: IAccessible;
  childDispatch: IDispatch;
  buttonsArray: array of OleVariant;
  btnName: WideString;
  btnRect: TRect;
  firstBtnLeft, firstBtnRight: Boolean;
  firstBtnTop, firstBtnBottom: Boolean;
begin
  if _notaskbar then Exit;
  GetWindowRect(_handle, _rect);

  if _mainTaskbar then
  begin
    _reBarWindow32.Handle := FindWindowEx(_handle, 0, 'ReBarWindow32', nil);
    if _reBarWindow32.Handle = 0 then Exit;
    GetWindowRect(_reBarWindow32.Handle, _reBarWindow32.Rect);

    _MSTaskSwWClass.Handle := FindWindowEx(_reBarWindow32.Handle, 0, 'MSTaskSwWClass', nil);
    if _MSTaskSwWClass.Handle = 0 then Exit;
    GetWindowRect(_MSTaskSwWClass.Handle, _MSTaskSwWClass.Rect);

    _MSTaskListWClass.Handle := FindWindowEx(_MSTaskSwWClass.Handle, 0, 'MSTaskListWClass', nil);
  end
  else
  begin
    _WorkerW.Handle := FindWindowEx(_handle, 0, 'WorkerW', nil);
    if _WorkerW.Handle = 0 then Exit;
    GetWindowRect(_WorkerW.Handle, _WorkerW.Rect);

    _MSTaskListWClass.Handle := FindWindowEx(_WorkerW.Handle, 0, 'MSTaskListWClass', nil);
  end;

  if _MSTaskListWClass.Handle = 0 then Exit;
  GetWindowRect(_MSTaskListWClass.Handle, _MSTaskListWClass.Rect);

  GetMonitor; // it updates taskbar's _monitorrect

//  if _monitorId = _monitor then
  begin
    if (_rect.Width > _rect.Height)
    and (MonitorRect.Top = _rect.Top)
    then
      Position := TTaskPos.Top
    else if (_rect.Width > _rect.Height)
    and (MonitorRect.Bottom = _rect.Bottom)
    then
      Position := TTaskPos.Bottom
    else if (_rect.Width < _rect.Height)
    and (MonitorRect.Left = _rect.Left)
    then
      Position := TTaskPos.Left
    else if (_rect.Width < _rect.Height)
    and (MonitorRect.Right = _rect.Right)
    then
      Position := TTaskPos.Right;
  end;

  _start.Handle := FindWindowEx(_handle, 0, 'Start', nil);
  if _start.Handle = 0 then Exit;
  GetWindowRect(_start.Handle, _start.Rect);

  if _mainTaskbar then
    _trayNotifyWnd.Handle := FindWindowEx(_handle, 0, 'TrayNotifyWnd', nil)
  else
    _trayNotifyWnd.Handle := FindWindowEx(_handle, 0, 'ClockButton', nil);

  if _trayNotifyWnd.Handle = 0 then Exit;
    GetWindowRect(_trayNotifyWnd.Handle, _trayNotifyWnd.Rect);

    {_trayDummySearchControl.Handle := FindWindowEx(_handle, 0, 'TrayDummySearchControl', nil);
  if _trayDummySearchControl.Handle > 0 then
    GetWindowRect(_trayDummySearchControl.Handle, _trayDummySearchControl.Rect);}

  // Get Width and Rect of taskbar application's buttons
  firstBtnLeft := True;
  firstBtnRight := True;
  firstBtnTop := True;
  firstBtnBottom := True;
  res := AccessibleObjectFromWindow(_MSTaskListWClass.Handle, 0, IID_IAccessible, acc);
  if res = S_OK then
  begin
    // Let's first get access to the button's container
    if acc.Get_accName(CHILDID_SELF, taskbarCaption) = S_OK then
    begin
      //
    end
    else Exit;

    // now that we found the main taskbar's button wrapper, we get the children objects
    if (acc.Get_accChildCount(iChildCount) = S_OK) and (iChildCount > 0) then
    begin
      SetLength(childArray, iChildCount);
      if AccessibleChildren(Pointer(acc), 0, iChildCount, childArray[0], iObtained) = S_OK then
      begin
        for i := 0 to iObtained - 1 do
        begin
          childDispatch := nil;
          if VarType(childArray[i]) = varDispatch then // varInteger is not needed since we are traversing in similar objects now
          begin
            childDispatch := childArray[i];
            if (childDispatch <> nil) and (childDispatch.QueryInterface(iAccessible, childAccessible) = S_OK) then
            begin
              if (childAccessible.Get_accName(CHILDID_SELF, childName) = S_OK) and (childName = taskbarCaption) then
              begin
                //
                if (childAccessible.Get_accChildCount(iBtnCount) = S_OK) and (iBtnCount > 0) then
                begin
                  SetLength(buttonsArray, iBtnCount);
                  if AccessibleChildren(Pointer(childAccessible), 0, iBtnCount, buttonsArray[0], iBtnObtained) = S_OK then
                  begin
                    //childAccessible.accLocation(_appsBtnLeft, _appsBtnTop, _appsBtnRight, _appsBtnBottom, CHILDID_SELF);
                    for j := 0 to iBtnObtained - 1 do
                    begin
                      if VarType(buttonsArray[j]) = varInteger then // now we must make sure it is an integer type, because this time
                      // we found the buttons, which don't contain anymore child objects
                      begin
                        if childAccessible.Get_accName(buttonsArray[j], btnName) = S_OK then
                        begin
                          childAccessible.accLocation(btnRect.Left, btnRect.Top, btnRect.Right, btnRect.Bottom, buttonsArray[j]);

                          // now we must make sure the button found has width and height major than 0
                          if (btnRect.Bottom > 0) and (btnRect.Right> 0) then
                          begin
                            if (Position = TTaskPos.Left) or (Position = TTaskPos.Right) then
                            begin
                              if firstBtnTop then
                              begin
                                firstBtnTop := False;
                                _appsBtnTop := btnRect.Top;
                              end
                              else
                              begin
                                if btnRect.Top < _appsBtnTop then
                                  _appsBtnTop := btnRect.Top;
                              end;

                              if firstBtnBottom then
                              begin
                                firstBtnBottom := False;
                                _appsBtnBottom := btnRect.Top + btnRect.Bottom;
                              end
                              else
                              begin
                                if btnRect.Top + btnRect.Bottom > _appsBtnBottom then
                                  _appsBtnBottom := btnRect.Top + btnRect.Bottom;
                              end;
                            end
                            else
                            begin
                              if firstBtnLeft then
                              begin
                                firstBtnLeft := False;
                                _appsBtnLeft := btnRect.Left;
                              end
                              else
                              begin
                                if btnRect.Left < _appsBtnLeft then
                                  _appsBtnLeft := btnRect.Left;
                              end;

                              if firstBtnRight then
                              begin
                                firstBtnRight := False;
                                _appsBtnRight := btnRect.Left + btnRect.Right;
                              end
                              else
                              begin
                                if btnRect.Left + btnRect.Right > _appsBtnRight then
                                  _appsBtnRight := btnRect.Left + btnRect.Right;
                              end;
                            end;

                          end;
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;

    end;

  end;
end;

function TTaskbar.IsStartMenuVisible: Boolean;
var
  acc: IAppVisibility;
  res: HRESULT;
  isLauncherVisible: BOOL;
begin
  Result := False;
  // Initialization of COM is required to use the AppVisibility (CLSID_AppVisibility) object
  res := CoInitializeEx(nil, COINIT_APARTMENTTHREADED);
  if Succeeded(res) then
  begin
    // Create the App Visibility component
    res := CoCreateInstance(CLSID_AppVisibility, nil, CLSCTX_ALL, IID_AppVisibility, acc);
    if Succeeded(res) then
    begin
      res := acc.IsLauncherVisible(isLauncherVisible);
      if Succeeded(res) then
        Result := Boolean(isLauncherVisible);
    end;

  end;
  CoUninitialize;

end;

function EnumChildWindowsProc(Wnd: HWND; lst: TStringList): Bool; export; stdcall;
var
  ClsName: array[0..255] of char;
  stl: DWORD;
  titlelen: Integer;
  title: String;
begin
  GetClassName(Wnd,ClsName, 255);
  stl := GetWindowLong(Wnd, GWL_STYLE);
  if {(stl and WS_VISIBLE = WS_VISIBLE)
  and} (GetParent(Wnd) = StrToInt(lst[0]))
  then
  begin
    titlelen := GetWindowTextLength(Wnd);
    SetLength(title, titlelen);
    GetWindowText(Wnd, PChar(title), titlelen + 1);
    lst.Add(String(ClsName) + ' ' + ' ' + title + ' '+inttostr(wnd));
  end;
  Result := True;
end;

function TTaskbar.ListMainTaskbarElements:TStringList;
var
  list: TStringList;
begin
  list := TStringList.Create;
//  list.Add(IntToStr(FindWindowEx(Self.Handle,0, 'ReBarWindow32', nil)));
//  EnumChildWindows(FindWindowEx(Self.Handle,0, 'ReBarWindow32', nil), @EnumChildWindowsProc, LParam(list));
  list.Add(IntToStr(Self.Handle));
  EnumChildWindows(Self.Handle, @EnumChildWindowsProc, LParam(list));
  Result := list;
end;

function TTaskbar._getIconsRect: TRect;
begin
  Result := _MSTaskListWClass.Rect;

  Result.Right := _appsBtnRight;
end;

function TTaskbar._IsTransparent: Boolean;
begin
  _translucent := False;
  _reg := TRegistry.Create;
  try
    _reg.RootKey := HKEY_CURRENT_USER;
    if _reg.OpenKeyReadOnly('Software\Microsoft\Windows\CurrentVersion\Themes\Personalize') then
    begin
      if _reg.ReadInteger('EnableTransparency') = 1 then
        _translucent := True;
      _reg.CloseKey;
    end;
  finally
    _reg.Free;
  end;
  Result := _translucent;
end;*)

{ TTaskbars }

function TTaskbars.Add(Value: PTaskbar): Integer;
begin
  Result := inherited Add(Value);
end;

procedure TTaskbars.CenterAppsButtons(center, relative: Boolean);
var
  I: Integer;
  aLeft, aTop: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    //    Items[I].CenterAppsButtons(center, relative);
    if Items[I]._start.Handle = 0 then Exit; // make sure taskbar exists

  //  if _appsBtnLeft = 0 then Exit; // #TODO taskbar being sides centering is not handled yet

    if not center then
    begin
      if Items[I].MainTaskbar then
        SetWindowPos(Items[I]._MSTaskListWClass.Handle, 0, 0, 0, Items[I]._MSTaskSwWClass.Rect.Width, Items[I]._MSTaskSwWClass.Rect.Height, SWP_NOACTIVATE)
      else
        SetWindowPos(Items[I]._MSTaskListWClass.Handle, 0, 0, 0, Items[I]._WorkerW.Rect.Width, Items[I]._WorkerW.Rect.Height, SWP_NOACTIVATE)
    end
    else
    begin
      //center buttons
      if (Items[I].Position = TTaskPos.Left) or (Items[I].Position = TTaskPos.Right) then
      begin
        if Items[I].MainTaskbar then
        begin
          if (Items[I]._appsBtnBottom - Items[I]._appsBtnTop + 6) > Items[I]._MSTaskSwWClass.Rect.Height then Exit;

          if relative then
            aTop := (Items[I]._MSTaskSwWClass.Rect.Height div 2) - ((Items[I]._appsBtnBottom - Items[I]._appsBtnTop) div 2)
          else
            aTop := (Items[I]._rect.Height div 2) - Items[I]._MSTaskSwWClass.Rect.Top - ((Items[I]._appsBtnBottom - Items[I]._appsBtnTop) div 2);

          SetWindowPos(Items[I]._MSTaskListWClass.Handle, 0, 0, aTop, Items[I]._MSTaskListWClass.Rect.Width,  (Items[I]._appsBtnBottom - Items[I]._appsBtnTop + 6), SWP_NOACTIVATE);
        end
        else
        begin
          if (abs(Items[I]._appsBtnBottom - Items[I]._appsBtnTop) + 6) > abs(Items[I]._WorkerW.Rect.Bottom - Items[I]._WorkerW.Rect.Top) then Exit;

          if relative then
            aTop := (Items[I]._WorkerW.Rect.Height div 2) - ((Items[I]._appsBtnBottom - Items[I]._appsBtnTop) div 2)
          else
            aTop := (Items[I]._rect.Height div 2) - abs(Items[I]._WorkerW.Rect.Top-Items[I]._rect.Top) - ((Items[I]._appsBtnBottom - Items[I]._appsBtnTop) div 2);

          SetWindowPos(Items[I]._MSTaskListWClass.Handle, 0, 0, aTop, Items[I]._MSTaskListWClass.Rect.Width, (Items[I]._appsBtnBottom - Items[I]._appsBtnTop + 6), SWP_NOACTIVATE);
        end;
      end
      else
      begin
        // if taskbar buttons width is full, there is no need to adjust, 6 is a margin constant
        if Items[I].MainTaskbar then
        begin
          if (Items[I]._appsBtnRight - Items[I]._appsBtnLeft + 6) > Items[I]._MSTaskSwWClass.Rect.Width then Exit;

          if relative then
            aLeft := (Items[I]._MSTaskSwWClass.Rect.Width div 2) - ((Items[I]._appsBtnRight - Items[I]._appsBtnLeft) div 2)
          else
            aLeft := (Items[I]._rect.Width div 2) - Items[I]._MSTaskSwWClass.Rect.Left - ((Items[I]._appsBtnRight - Items[I]._appsBtnLeft) div 2);

          SetWindowPos(Items[I]._MSTaskListWClass.Handle, 0, aLeft, 0, (Items[I]._appsBtnRight - Items[I]._appsBtnLeft + 6), Items[I]._MSTaskListWClass.Rect.Height, SWP_NOACTIVATE);
        end
        else
        begin
          if (abs(Items[I]._appsBtnRight - Items[I]._appsBtnLeft) + 6) > abs(Items[I]._WorkerW.Rect.Right - Items[I]._WorkerW.Rect.Left) then Exit;

          if relative then
            aLeft := (Items[I]._WorkerW.Rect.Width div 2) - ((Items[I]._appsBtnRight - Items[I]._appsBtnLeft) div 2)
          else
            aLeft := (Items[I]._rect.Width div 2) - abs(Items[I]._WorkerW.Rect.Left-Items[I]._rect.Left) - ((Items[I]._appsBtnRight - Items[I]._appsBtnLeft) div 2);

          SetWindowPos(Items[I]._MSTaskListWClass.Handle, 0, aLeft, 0, (Items[I]._appsBtnRight - Items[I]._appsBtnLeft + 6), Items[I]._MSTaskListWClass.Rect.Height, SWP_NOACTIVATE);
        end;
      end;
    end;
  end;
end;

destructor TTaskbars.Destroy;
var
  I: Integer;
begin
//  for I := 0 to Count - 1 do
//  begin
//    Items[I]._position := '';
//    FreeMem(Items[I]);    // notify handles it instead
//  end;

  inherited;
end;

function TTaskbars.Get(Index: Integer): PTaskbar;
begin
  Result := PTaskbar(inherited Get(Index));
end;

function TTaskbars.IsStartMenuVisible: Boolean;
var
  acc: IAppVisibility;
  res: HRESULT;
  isLauncherVisible: BOOL;
begin
  Result := False;
  // Initialization of COM is required to use the AppVisibility (CLSID_AppVisibility) object
  res := CoInitializeEx(nil, COINIT_APARTMENTTHREADED);
  if Succeeded(res) then
  begin
    // Create the App Visibility component
    res := CoCreateInstance(CLSID_AppVisibility, nil, CLSCTX_ALL, IID_AppVisibility, acc);
    if Succeeded(res) then
    begin
      res := acc.IsLauncherVisible(isLauncherVisible);
      if Succeeded(res) then
        Result := Boolean(isLauncherVisible);
    end;

  end;
  CoUninitialize;
end;

procedure TTaskbars.Notify(Ptr: Pointer; Action: TListNotification);
begin
  inherited;

  if Action = lnDeleted then
  begin
    TTaskbar(Ptr^)._position := '';
    FreeMem(Ptr);
  end;
end;

procedure TTaskbars.NotifyAreaVisible(visible: Boolean);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  if visible then
    ShowWindow(Items[I]._trayNotifyWnd.Handle, SW_SHOWNOACTIVATE)
  else
    ShowWindow(Items[I]._trayNotifyWnd.Handle, SW_HIDE);
end;

(*
  Creates/Updates/Removes taskbars
*)
procedure TTaskbars.Refresh;
var
   LHDesktop: HWND;
   LHWindow: HWND;
   LHParent: HWND;
   LExStyle: DWORD;
   I: integer;
   AppClassName: array[0..255] of char;
   Cloaked: Cardinal;
   Taskbar: PTaskbar;

   curTime: LongInt;
   AFound: Boolean;
begin
  // Unix timestamp
  curTime := Round((Now - TDateTime(25569.0)) * 86400);

  LHDesktop:=GetDesktopWindow;
  LHWindow:=GetWindow(LHDesktop,GW_CHILD);

  while LHWindow <> 0 do
  begin
    GetClassName(LHWindow, AppClassName, 255);
    LHParent:=GetWindowLong(LHWindow,GWL_HWNDPARENT);
    LExStyle:=GetWindowLong(LHWindow,GWL_EXSTYLE);

    if IsWindowVisible(LHWindow)
    and (AppClassName = 'Shell_TrayWnd')
    or (AppClassName = 'Shell_SecondaryTrayWnd')
    and ((LHParent=0)or(LHParent=LHDesktop))
    and (Screen.MonitorFromWindow(LHWindow).MonitorNum <> 0)
    then
    begin
      // check if taskbar is already registered
      AFound := False;
      if Count > 0 then
      begin
        for I := 0 to Count - 1 do
          if (Items[I]._handle = LHWindow)
          and (not AFound)
          and (Items[I]._timestamp <> curTime)
          then
            begin
              // already found, update timestamp
              Items[I]._timestamp := curTime;
              AFound := True;
            end;
      end;
      if not AFound then
      begin
        GetMem(Taskbar, SizeOf(TTaskbar));
        Taskbar^._handle := LHWindow;
        Taskbar^._timestamp := curTime;
        //Taskbar := TTaskbar.Create(LHWindow);
        //Taskbar._timestamp := curTime;
        if AppClassName = 'Shell_TrayWnd' then
        begin
          Taskbar^._mainTaskbar := True;
          Taskbar^._reBarWindow32.Handle := FindWindowEx(LHWindow, 0, 'ReBarWindow32', nil);
          Taskbar^._MSTaskSwWClass.Handle := FindWindowEx(Taskbar^._reBarWindow32.Handle, 0, 'MSTaskSwWClass', nil);
          Taskbar^._MSTaskListWClass.Handle := FindWindowEx(Taskbar^._MSTaskSwWClass.Handle, 0, 'MSTaskListWClass', nil);
          Taskbar^._trayNotifyWnd.Handle := FindWindowEx(LHWindow, 0, 'TrayNotifyWnd', nil)
        end
        else
        begin
          Taskbar^._mainTaskbar := False;
          Taskbar^._WorkerW.Handle := FindWindowEx(LHWindow, 0, 'WorkerW', nil);
          Taskbar^._MSTaskListWClass.Handle := FindWindowEx(Taskbar^._WorkerW.Handle, 0, 'MSTaskListWClass', nil);
          Taskbar^._trayNotifyWnd.Handle := FindWindowEx(LHWindow, 0, 'ClockButton', nil);
        end;
        Taskbar^._start.Handle := FindWindowEx(LHWindow, 0, 'Start', nil);

        Add(Taskbar);
      end;
    end;
    LHWindow:=GetWindow(LHWindow, GW_HWNDNEXT);
  end;

  // delete destroyed taskbars
  for I := 0 to Count - 1 do
    if Items[I]._timestamp <> curTime then
      Delete(I);
end;

procedure TTaskbars.RestoreAllStarts;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    ShowWindow(Items[I]._start.Handle, SW_SHOWNOACTIVATE);
end;

procedure TTaskbars.StartBtnVisible(Index:Integer; Visible: Boolean);
begin
  if visible then
    ShowWindow(Items[Index]._start.Handle, SW_SHOWNOACTIVATE)
  else
    ShowWindow(Items[Index]._start.Handle, SW_HIDE);
end;

procedure TTaskbars.Transparent;
var
  I: Integer;
  accent: AccentPolicy;
  data: WindowCompositionAttributeData;
begin
  for I := 0 to Count - 1 do
  begin
    //if _notaskbar then Exit;

    accent.AccentState := Items[I]._transstyle;
    accent.GradientColor := $00000000;
    accent.AccentFlags := 2; // 2: seems to hide the border
    data.Attribute := WCA_ACCENT_POLICY;
    data.SizeOfData := SizeOf(accent);
    data.Data := @accent;

//    if Items[I]._transstyle = ACCENT_ENABLE_TRANSPARENTGRADIENT then
    Items[I]._transstyle := ACCENT_ENABLE_TRANSPARENTGRADIENT;
      SetWindowCompositionAttribute(Items[I].Handle, data);
  end;
end;

procedure TTaskbars.UpdateTaskbarInfo;
var
  n, i, j: Integer;
  res: HRESULT;
  acc: IAccessible;
  childArray: array of OleVariant;
  iChildCount, iObtained: Integer;
  iBtnCount, iBtnObtained: Integer;
  taskbarCaption, childName: WideString;
  childAccessible: IAccessible;
  childDispatch: IDispatch;
  buttonsArray: array of OleVariant;
  btnName: WideString;
  btnRect: TRect;
  firstBtnLeft, firstBtnRight: Boolean;
  firstBtnTop, firstBtnBottom: Boolean;
  AMonitor: TMonitor;
begin
  for n := 0 to Count - 1 do
  begin
  //  if _notaskbar then Exit;

    // Update taskbar's rect data
    GetWindowRect(Items[n]._handle, Items[n]._rect);

    if Items[n].MainTaskbar then
    begin
      if Items[n]._reBarWindow32.Handle <> 0 then
        GetWindowRect(Items[n]._reBarWindow32.Handle, Items[n]._reBarWindow32.Rect);

      if Items[n]._MSTaskSwWClass.Handle <> 0 then
        GetWindowRect(Items[n]._MSTaskSwWClass.Handle, Items[n]._MSTaskSwWClass.Rect);
    end
    else
    begin
      if Items[n]._WorkerW.Handle <> 0 then
        GetWindowRect(Items[n]._WorkerW.Handle, Items[n]._WorkerW.Rect);
    end;

    if Items[n]._MSTaskListWClass.Handle <> 0 then
      GetWindowRect(Items[n]._MSTaskListWClass.Handle, Items[n]._MSTaskListWClass.Rect);

    //GetMonitor; // it updates taskbar's _monitorrect
    AMonitor := Screen.MonitorFromRect(Items[n]._rect);
//  if _maonitor = Result.MonitorNum + 1 then
    begin
      Items[n]._monitorrect := AMonitor.BoundsRect;
      Items[n]._monitorId := AMonitor.MonitorNum + 1;
    end;

  //  if _monitorId = _monitor then
    begin
      if (Items[n]._rect.Width > Items[n]._rect.Height)
      and (Items[n].MonitorRect.Top = Items[n]._rect.Top)
      then
        Items[n].Position := TTaskPos.Top
      else if (Items[n]._rect.Width > Items[n]._rect.Height)
      and (Items[n].MonitorRect.Bottom = Items[n]._rect.Bottom)
      then
        Items[n].Position := TTaskPos.Bottom
      else if (Items[n]._rect.Width < Items[n]._rect.Height)
      and (Items[n].MonitorRect.Left = Items[n]._rect.Left)
      then
        Items[n].Position := TTaskPos.Left
      else if (Items[n]._rect.Width < Items[n]._rect.Height)
      and (Items[n].MonitorRect.Right = Items[n]._rect.Right)
      then
        Items[n].Position := TTaskPos.Right;
    end;

    if Items[n]._start.Handle <> 0 then
      GetWindowRect(Items[n]._start.Handle, Items[n]._start.Rect);

    if Items[n]._trayNotifyWnd.Handle <> 0 then
      GetWindowRect(Items[n]._trayNotifyWnd.Handle, Items[n]._trayNotifyWnd.Rect);

      {_trayDummySearchControl.Handle := FindWindowEx(_handle, 0, 'TrayDummySearchControl', nil);
    if _trayDummySearchControl.Handle > 0 then
      GetWindowRect(_trayDummySearchControl.Handle, _trayDummySearchControl.Rect);}

    // Get Width and Rect of taskbar application's buttons
    firstBtnLeft := True;
    firstBtnRight := True;
    firstBtnTop := True;
    firstBtnBottom := True;

    res := AccessibleObjectFromWindow(Items[n]._MSTaskListWClass.Handle, 0, IID_IAccessible, acc);
    if res = S_OK then
    begin
      // Let's first get access to the button's container
      if acc.Get_accName(CHILDID_SELF, taskbarCaption) = S_OK then
      begin
        //
      end
      else Exit;

      // now that we found the main taskbar's button wrapper, we get the children objects
      if (acc.Get_accChildCount(iChildCount) = S_OK) and (iChildCount > 0) then
      begin
        SetLength(childArray, iChildCount);
        if AccessibleChildren(Pointer(acc), 0, iChildCount, childArray[0], iObtained) = S_OK then
        begin

          for i := 0 to (iObtained - 1) do
          begin
            childDispatch := nil;
            if VarType(childArray[i]) = varDispatch then // varInteger is not needed since we are traversing in similar objects now
            begin
              childDispatch := childArray[i];
              if (childDispatch <> nil) and (childDispatch.QueryInterface(iAccessible, childAccessible) = S_OK) then
              begin
                if (childAccessible.Get_accName(CHILDID_SELF, childName) = S_OK) and (childName = taskbarCaption) then
                begin
                  //
                  if (childAccessible.Get_accChildCount(iBtnCount) = S_OK) and (iBtnCount > 0) then
                  begin
                    SetLength(buttonsArray, iBtnCount);
                    if AccessibleChildren(Pointer(childAccessible), 0, iBtnCount, buttonsArray[0], iBtnObtained) = S_OK then
                    begin
                      //childAccessible.accLocation(_appsBtnLeft, _appsBtnTop, _appsBtnRight, _appsBtnBottom, CHILDID_SELF);
                      for j := 0 to iBtnObtained - 1 do
                      begin
                        if VarType(buttonsArray[j]) = varInteger then // now we must make sure it is an integer type, because this time
                        // we found the buttons, which don't contain anymore child objects
                        begin
                          if childAccessible.Get_accName(buttonsArray[j], btnName) = S_OK then
                          begin
                            childAccessible.accLocation(btnRect.Left, btnRect.Top, btnRect.Right, btnRect.Bottom, buttonsArray[j]);

                            // now we must make sure the button found has width and height major than 0
                            if (btnRect.Bottom > 0) and (btnRect.Right> 0) then
                            begin
                              if (Items[n].Position = TTaskPos.Left) or (Items[n].Position = TTaskPos.Right) then
                              begin
                                if firstBtnTop then
                                begin
                                  firstBtnTop := False;
                                  Items[n]._appsBtnTop := btnRect.Top;
                                end
                                else
                                begin
                                  if btnRect.Top < Items[n]._appsBtnTop then
                                    Items[n]._appsBtnTop := btnRect.Top;
                                end;

                                if firstBtnBottom then
                                begin
                                  firstBtnBottom := False;
                                  Items[n]._appsBtnBottom := btnRect.Top + btnRect.Bottom;
                                end
                                else
                                begin
                                  if btnRect.Top + btnRect.Bottom > Items[n]._appsBtnBottom then
                                    Items[n]._appsBtnBottom := btnRect.Top + btnRect.Bottom;
                                end;
                              end
                              else
                              begin
                                if firstBtnLeft then
                                begin
                                  firstBtnLeft := False;
                                  Items[n]._appsBtnLeft := btnRect.Left;
                                end
                                else
                                begin
                                  if btnRect.Left < Items[n]._appsBtnLeft then
                                    Items[n]._appsBtnLeft := btnRect.Left;
                                end;

                                if firstBtnRight then
                                begin
                                  firstBtnRight := False;
                                  Items[n]._appsBtnRight := btnRect.Left + btnRect.Right;
                                end
                                else
                                begin
                                  if btnRect.Left + btnRect.Right > Items[n]._appsBtnRight then
                                    Items[n]._appsBtnRight := btnRect.Left + btnRect.Right;
                                end;
                              end;

                            end;
                          end;
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;

        end;

      end;

    end;
  end;
end;

end.
