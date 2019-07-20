object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 403
  ClientWidth = 751
  Color = clWhite
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  StyleElements = []
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object UCaptionBar1: TUCaptionBar
    Left = 0
    Top = 0
    Width = 751
    Height = 32
    ThemeManager = UThemeManager1
    Align = alTop
    Caption = 'UCaptionBar1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    object UButton1: TUButton
      Left = 704
      Top = 0
      Width = 47
      Height = 32
      CustomBorderColors.None = 15921906
      CustomBorderColors.Hover = 15132390
      CustomBorderColors.Press = 13421772
      CustomBorderColors.Disabled = 15921906
      CustomBorderColors.Focused = 15921906
      CustomBackColors.None = 15921906
      CustomBackColors.Hover = 15132390
      CustomBackColors.Press = 13421772
      CustomBackColors.Disabled = 15921906
      CustomBackColors.Focused = 15921906
      CustomTextColors.Disabled = clGray
      Text = #57610
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe MDL2 Assets'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = True
      OnClick = UButton1Click
    end
    object UButton2: TUButton
      Left = 672
      Top = 0
      Width = 32
      Height = 32
      CustomBorderColors.None = 15921906
      CustomBorderColors.Hover = 15132390
      CustomBorderColors.Press = 13421772
      CustomBorderColors.Disabled = 15921906
      CustomBorderColors.Focused = 15921906
      CustomBackColors.None = 15921906
      CustomBackColors.Hover = 15132390
      CustomBackColors.Press = 13421772
      CustomBackColors.Disabled = 15921906
      CustomBackColors.Focused = 15921906
      CustomTextColors.Disabled = clGray
      Text = #59193
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe MDL2 Assets'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TabStop = True
    end
    object UButton3: TUButton
      Left = 624
      Top = 0
      Width = 48
      Height = 32
      CustomBorderColors.None = 15921906
      CustomBorderColors.Hover = 15132390
      CustomBorderColors.Press = 13421772
      CustomBorderColors.Disabled = 15921906
      CustomBorderColors.Focused = 15921906
      CustomBackColors.None = 15921906
      CustomBackColors.Hover = 15132390
      CustomBackColors.Press = 13421772
      CustomBackColors.Disabled = 15921906
      CustomBackColors.Focused = 15921906
      CustomTextColors.Disabled = clGray
      Text = #59192
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe MDL2 Assets'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      TabStop = True
    end
    object UButton4: TUButton
      Left = 0
      Top = 0
      Width = 45
      Height = 32
      CustomBorderColors.None = 15921906
      CustomBorderColors.Hover = 15132390
      CustomBorderColors.Press = 13421772
      CustomBorderColors.Disabled = 15921906
      CustomBorderColors.Focused = 15921906
      CustomBackColors.None = 15921906
      CustomBackColors.Hover = 15132390
      CustomBackColors.Press = 13421772
      CustomBackColors.Disabled = 15921906
      CustomBackColors.Focused = 15921906
      CustomTextColors.Disabled = clGray
      Text = #57510
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe MDL2 Assets'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      TabStop = True
    end
  end
  object UPanel1: TUPanel
    Left = 0
    Top = 32
    Width = 45
    Height = 371
    ThemeManager = UThemeManager1
    CustomTextColor = clBlack
    CustomBackColor = 15132390
    Align = alLeft
    BevelOuter = bvNone
    FullRepaint = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    object USymbolButton1: TUSymbolButton
      Left = 0
      Top = 0
      Width = 45
      Height = 40
      ThemeManager = UThemeManager1
      SymbolFont.Charset = DEFAULT_CHARSET
      SymbolFont.Color = clWindowText
      SymbolFont.Height = -16
      SymbolFont.Name = 'Segoe MDL2 Assets'
      SymbolFont.Style = []
      TextFont.Charset = DEFAULT_CHARSET
      TextFont.Color = clWindowText
      TextFont.Height = -13
      TextFont.Name = 'Segoe UI'
      TextFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      SymbolChar = #59136
      Text = '   Menu'
      Detail = 'Detail'
      ShowDetail = False
      Align = alTop
      TabOrder = 0
      TabStop = True
      OnClick = USymbolButton1Click
    end
    object USymbolButton2: TUSymbolButton
      Left = 0
      Top = 40
      Width = 45
      Height = 40
      ThemeManager = UThemeManager1
      SymbolFont.Charset = DEFAULT_CHARSET
      SymbolFont.Color = clWindowText
      SymbolFont.Height = -16
      SymbolFont.Name = 'Segoe MDL2 Assets'
      SymbolFont.Style = []
      TextFont.Charset = DEFAULT_CHARSET
      TextFont.Color = clWindowText
      TextFont.Height = -13
      TextFont.Name = 'Segoe UI'
      TextFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      SymbolChar = #57621
      Text = '   Settings'
      Detail = 'Detail'
      ShowDetail = False
      Align = alTop
      TabOrder = 1
      TabStop = True
    end
  end
  object UScrollBox1: TUScrollBox
    Left = 566
    Top = 32
    Width = 185
    Height = 371
    Align = alRight
    BorderStyle = bsNone
    DoubleBuffered = True
    Color = 15132390
    ParentColor = False
    ParentDoubleBuffered = False
    TabOrder = 2
    ThemeManager = UThemeManager1
  end
  object TrayIcon1: TTrayIcon
    PopupMenu = PopupMenu1
    Visible = True
    OnDblClick = TrayIcon1DblClick
    Left = 208
    Top = 344
  end
  object PopupMenu1: TPopupMenu
    Left = 280
    Top = 240
    object mnuStart: TMenuItem
      Caption = 'Show &Start button'
      Checked = True
      OnClick = mnuStartClick
    end
    object mnuTray: TMenuItem
      Caption = 'Show &Tray area'
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
    object mnuCenterRelative: TMenuItem
      Caption = 'Center &Relative'
      OnClick = mnuCenterRelativeClick
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
    Left = 272
    Top = 344
  end
  object tmrOptions: TTimer
    OnTimer = tmrOptionsTimer
    Left = 72
    Top = 344
  end
  object tmrThreadWaiter: TTimer
    Enabled = False
    OnTimer = tmrThreadWaiterTimer
    Left = 136
    Top = 344
  end
  object tmrCenter: TTimer
    Enabled = False
    OnTimer = tmrCenterTimer
    Left = 16
    Top = 344
  end
  object MadExceptionHandler1: TMadExceptionHandler
    Left = 368
    Top = 344
  end
  object UThemeManager1: TUThemeManager
    Left = 368
    Top = 208
  end
  object UContextMenu1: TUContextMenu
    Items = <
      item
        Text = 'Text'
        Detail = 'Detail'
        SymbolChar = #57345
      end
      item
        Text = 'Text'
        Detail = 'Detail'
        SymbolChar = #57345
      end>
    Left = 232
    Top = 152
    object About1: TMenuItem
      Caption = '&About'
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Exit2: TMenuItem
      Caption = 'E&xit'
      OnClick = Exit2Click
    end
  end
end
