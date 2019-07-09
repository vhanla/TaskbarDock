object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 201
  ClientWidth = 447
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
    Left = 256
    Top = 96
    object Start1: TMenuItem
      Caption = '&Start'
      Checked = True
      OnClick = Start1Click
    end
    object Tray1: TMenuItem
      Caption = '&Tray'
      Checked = True
      OnClick = Tray1Click
    end
    object Full1: TMenuItem
      Caption = '&Full'
      OnClick = Full1Click
    end
    object Transparent1: TMenuItem
      Caption = 'Tra&nsparent'
      Checked = True
      OnClick = Transparent1Click
    end
    object Center1: TMenuItem
      Caption = '&Center'
      OnClick = Center1Click
    end
    object N2: TMenuItem
      Caption = '-'
      Visible = False
    end
    object PinnedIcons1: TMenuItem
      Caption = 'Pinned Icons'
      Visible = False
      OnClick = PinnedIcons1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object About1: TMenuItem
      Caption = '&About'
      OnClick = About1Click
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
end
