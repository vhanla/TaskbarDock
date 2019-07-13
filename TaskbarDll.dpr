library TaskbarDll;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System.SysUtils,
  System.Classes,
  Variants,
  Winapi.Windows,
  DWMAPI,
  DDetours;

{$R *.res}
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

var
  TrampolineMessageBoxW: function(hWnd: HWND; lpText, lpCaption: LPCWSTR; uType: UINT): Integer;
  stdcall = nil;
  TrampolineSetWindowCompositionAttribute: function (hWnd: HWND; var data: WindowCompositionAttributeData): Integer;
  stdcall = nil;

function SetWindowCompositionAttributeHooked (hWnd: HWND; var data: WindowCompositionAttributeData): Integer;
var
  _data: WindowCompositionAttributeData;
begin
  _data.Attribute := ACCENT_ENABLE_TRANSPARENTGRADIENT;
  Result := TrampolineSetWindowCompositionAttribute(hWnd, _data);
end;

function StartThread(pFunction: TFNThreadStartRoutine;
            iPriority: Integer = THREAD_PRIORITY_NORMAL;
            iStartFlag: Integer = 0): THandle;
var
  ThreadId: DWORD;
begin
  Result := CreateThread(nil, 0, pFunction, nil, iStartFlag, ThreadId);
  if Result <> NULL then
    SetThreadPriority(Result, iPriority);
end;

function CloseThread(ThreadHandle: THandle): Boolean;
begin
  Result := TerminateThread(ThreadHandle, 1);
  CloseHandle(ThreadHandle);
end;

procedure ThisIsTheThread;
begin
//  MessageBoxW(0, 'Hola chico', 'ñol', 0);
end;

procedure Run;
var
  hThread: THandle;
begin
  hThread := StartThread(@ThisIsTheThread);
  hThread := StartThread(@ThisIsTheThread, THREAD_PRIORITY_ERROR_RETURN);
  CloseThread(hThread);
end;

procedure mydllproc(Reason: Integer);
begin
  case Reason of
    DLL_PROCESS_ATTACH:
    begin
      Run;
    end;
  end;
end;

begin
  DllProc := mydllproc;
  mydllproc(DLL_PROCESS_ATTACH);
end.
