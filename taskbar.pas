{
  Taskbar unit

  Description:
    This unit gets info from windows taskbar, position, icons
}
unit taskbar;

interface

uses classes, windows, graphics, registry, dwmapi, oleacc, variants;

const
  WCA_ACCENT_POLICY = 19;
  ACCENT_ENABLE_GRADIENT = 1;
  ACCENT_ENABLE_TRANSPARENTGRADIENT = 2;
  ACCENT_ENABLE_BLURBEHIND = 3;

type
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

  TTaskComponent = record
    Handle: THandle;
    Rect: TRect;
  end;

  TTaskbar = class
  private
    _reg: TRegistry;
    _position: TTaskPos; // Position on the screen
    _rect: TRect; // Shell_TrayWnd
    _translucent: Boolean;
    _handle: THandle;
    _notaskbar: Boolean;
    _transstyle: Integer;
    _monitor: Integer;

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

    function _IsTransparent: Boolean;
    procedure HideStartBtn;
    procedure ShowStartBtn;
  public
    property Position: TTaskPos read _position;
    property Rect: TRect read _rect;
    property IsTransparent: Boolean read _IsTransparent;
    property TransStyle: Integer read _transstyle write _transstyle;

    property AppsLeft: Integer read _appsBtnLeft;
    property AppsRight: Integer read _appsBtnRight;
    property MSTaskList: TRect read _MSTaskListWClass.Rect;
    property TrayRect: TRect read _trayNotifyWnd.Rect;
    property StartRect: TRect read _start.Rect;

    constructor Create(monitor: Integer = 1);
    destructor Destroy; override;
    procedure Transparent;
    procedure UpdateTaskbarInfo;
    procedure CenterAppsButtons;
    procedure Hide(handle: THandle);
    procedure Show(handle: THandle);
    procedure StartBtnVisible(visible: Boolean = True);
    procedure NotifyAreaVisible(visible: Boolean = True);
    procedure FullTaskBar;
    procedure UpdateTaskbarHandle;
  end;

  function SetWindowCompositionAttribute(hWnd: HWND; var data: WindowCompositionAttributeData): Integer; stdcall;
    external User32 name 'SetWindowCompositionAttribute';

  function AccessibleChildren(paccContainer: Pointer; iChildStart: LONGINT;
                    cChildren: LONGINT; out rgvarChildren: OleVariant;
                    out pcObtained: LONGINT): HRESULT; stdcall;
                    external 'OLEACC.DLL' name 'AccessibleChildren';

implementation

{ TTaskbar }

procedure TTaskbar.CenterAppsButtons;
var
  aLeft: Integer;
begin
  if _start.Handle = 0 then Exit; // make sure taskbar exists

  if _appsBtnLeft = 0 then Exit; // #TODO taskbar being sides centering is not handled yet

  // if taskbar buttons width is full, there is no need to adjust, 6 is a margin constant
  if _monitor = 1 then  
  begin
    if (_appsBtnRight - _appsBtnLeft + 6) > _MSTaskSwWClass.Rect.Width then Exit;

    aLeft := (_rect.Width div 2) - _MSTaskSwWClass.Rect.Left - ((_appsBtnRight - _appsBtnLeft) div 2);

    SetWindowPos(_MSTaskListWClass.Handle, 0, aLeft, 0, (_appsBtnRight - _appsBtnLeft + 6), _MSTaskListWClass.Rect.Height, SWP_NOACTIVATE);
  end
  else if _monitor = 2 then
  begin
    if (abs(_appsBtnRight - _appsBtnLeft) + 6) > abs(_WorkerW.Rect.Right - _WorkerW.Rect.Left) then Exit;

    aLeft := (_rect.Width div 2) - abs(_WorkerW.Rect.Left-_rect.Left) - ((_appsBtnRight - _appsBtnLeft) div 2);

    SetWindowPos(_MSTaskListWClass.Handle, 0, aLeft, 0, (_appsBtnRight - _appsBtnLeft + 6), _MSTaskListWClass.Rect.Height, SWP_NOACTIVATE);
  end;  

end;

constructor TTaskbar.Create(monitor: Integer = 1);
begin
  _transstyle := ACCENT_ENABLE_TRANSPARENTGRADIENT;
  _monitor := monitor;
  if _monitor = 1 then
    _handle := FindWindow('Shell_TrayWnd', nil)
  else if _monitor = 2 then
    _handle := FindWindow('Shell_SecondaryTrayWnd', nil);

  if _handle = 0 then
    _notaskbar := True
  else
    _notaskbar := False;
end;

destructor TTaskbar.Destroy;
begin

  inherited;
end;

procedure TTaskbar.FullTaskBar;
begin
  if _start.Handle = 0 then Exit;

  if _appsBtnLeft = 0 then Exit;

  SetWindowPos(_MSTaskSwWClass.Handle, 0, 0, 0, _rect.Width, _MSTaskSwWClass.Rect.Height, SWP_NOACTIVATE);
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
//  accent.GradientColor := $00000000;
  data.Attribute := WCA_ACCENT_POLICY;
  data.SizeOfData := SizeOf(accent);
  data.Data := @accent;

  SetWindowCompositionAttribute(_handle, data);
end;

procedure TTaskbar.UpdateTaskbarHandle;
begin
  if _monitor = 1 then
    _handle := FindWindow('Shell_TrayWnd', nil)
  else if _monitor = 2 then
    _handle := FindWindow('Shell_SecondaryTrayWnd', nil);
  if _handle = 0 then
    _notaskbar := True
  else
    _notaskbar := False;
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
begin
  if _notaskbar then Exit;
  GetWindowRect(_handle, _rect);

  if _monitor = 1 then
  begin
  _reBarWindow32.Handle := FindWindowEx(_handle, 0, 'ReBarWindow32', nil);
  if _reBarWindow32.Handle = 0 then Exit;
  GetWindowRect(_reBarWindow32.Handle, _reBarWindow32.Rect);

  _MSTaskSwWClass.Handle := FindWindowEx(_reBarWindow32.Handle, 0, 'MSTaskSwWClass', nil);
  if _MSTaskSwWClass.Handle = 0 then Exit;
  GetWindowRect(_MSTaskSwWClass.Handle, _MSTaskSwWClass.Rect);

  _MSTaskListWClass.Handle := FindWindowEx(_MSTaskSwWClass.Handle, 0, 'MSTaskListWClass', nil);
  end
  else if _monitor = 2 then
  begin
    _WorkerW.Handle := FindWindowEx(_handle, 0, 'WorkerW', nil);
    if _WorkerW.Handle = 0 then Exit;
    GetWindowRect(_WorkerW.Handle, _WorkerW.Rect);

    _MSTaskListWClass.Handle := FindWindowEx(_WorkerW.Handle, 0, 'MSTaskListWClass', nil);
  end;

  if _MSTaskListWClass.Handle = 0 then Exit;
  GetWindowRect(_MSTaskListWClass.Handle, _MSTaskListWClass.Rect);

  _start.Handle := FindWindowEx(_handle, 0, 'Start', nil);
  if _start.Handle = 0 then Exit;
  GetWindowRect(_start.Handle, _start.Rect);

  if _monitor = 1 then
    _trayNotifyWnd.Handle := FindWindowEx(_handle, 0, 'TrayNotifyWnd', nil)
  else if _monitor = 2 then
    _trayNotifyWnd.Handle := FindWindowEx(_handle, 0, 'ClockButton', nil);

  if _trayNotifyWnd.Handle = 0 then Exit;
    GetWindowRect(_trayNotifyWnd.Handle, _trayNotifyWnd.Rect);

    {_trayDummySearchControl.Handle := FindWindowEx(_handle, 0, 'TrayDummySearchControl', nil);
  if _trayDummySearchControl.Handle > 0 then
    GetWindowRect(_trayDummySearchControl.Handle, _trayDummySearchControl.Rect);}

  // Get Width and Rect of taskbar application's buttons
  firstBtnLeft := True;
  firstBtnRight := True;
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
end;

end.
