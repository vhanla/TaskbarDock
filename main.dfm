object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 347
  ClientWidth = 535
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TrayIcon1: TTrayIcon
    PopupMenu = PopupMenu1
    Visible = True
    Left = 216
    Top = 104
  end
  object PopupMenu1: TPopupMenu
    Left = 304
    Top = 128
    object mnuStart: TMenuItem
      Caption = '&Start'
      Checked = True
      OnClick = mnuStartClick
    end
    object mnuTray: TMenuItem
      Caption = '&Tray'
      Checked = True
      OnClick = mnuTrayClick
    end
    object mnuFull: TMenuItem
      Caption = '&Full'
      Visible = False
      OnClick = mnuFullClick
    end
    object mnuTransparent: TMenuItem
      Caption = 'Tra&nsparent'
      OnClick = mnuTransparentClick
    end
    object mnuCenter: TMenuItem
      Caption = '&Center'
      OnClick = mnuCenterClick
    end
    object N2: TMenuItem
      Caption = '-'
      Visible = False
    end
    object mnuPinnedIcons: TMenuItem
      Caption = 'Pinned Icons'
      Visible = False
      OnClick = mnuPinnedIconsClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mnuStartwithWindows: TMenuItem
      Caption = 'Start with &Windows'
      OnClick = mnuStartwithWindowsClick
    end
    object mnuAbout: TMenuItem
      Caption = '&About'
      OnClick = mnuAboutClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Exit1: TMenuItem
      Caption = 'E&xit'
      OnClick = Exit1Click
    end
  end
  object tmrUpdateTBinfo: TTimer
    Enabled = False
    OnTimer = tmrUpdateTBinfoTimer
    Left = 136
    Top = 112
  end
  object tmrOptions: TTimer
    OnTimer = tmrOptionsTimer
    Left = 184
    Top = 56
  end
  object tmrThreadWaiter: TTimer
    Enabled = False
    OnTimer = tmrThreadWaiterTimer
    Left = 312
    Top = 64
  end
  object tmrCenter: TTimer
    Enabled = False
    OnTimer = tmrCenterTimer
    Left = 64
    Top = 64
  end
  object MadExceptionHandler1: TMadExceptionHandler
    Left = 240
    Top = 56
  end
end
