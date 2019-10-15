object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 403
  ClientWidth = 751
  Color = clWhite
  Ctl3D = False
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  GlassFrame.SheetOfGlass = True
  OldCreateOrder = False
  StyleElements = []
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object UScrollBox1: TUScrollBox
    Left = 45
    Top = 32
    Width = 706
    Height = 371
    Align = alClient
    BorderStyle = bsNone
    DoubleBuffered = True
    Color = clWhite
    ParentColor = False
    ParentDoubleBuffered = False
    TabOrder = 2
    MaxScrollCount = 6
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 706
      Height = 371
      ActivePage = tbsSettings
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 0
      object tbsSettings: TTabSheet
        Caption = 'tbsSettings'
        TabVisible = False
        OnShow = tbsSettingsShow
        DesignSize = (
          698
          361)
        object UText1: TUText
          AlignWithMargins = True
          Left = 0
          Top = 20
          Width = 698
          Height = 28
          Margins.Left = 0
          Margins.Top = 20
          Margins.Right = 0
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Settings'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -20
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TextKind = tkHeading
          ExplicitWidth = 71
        end
        object ListBox1: TListBox
          Left = 400
          Top = 56
          Width = 281
          Height = 194
          Anchors = [akLeft, akTop, akRight]
          ItemHeight = 13
          TabOrder = 0
        end
        object Button1: TButton
          Left = 328
          Top = 256
          Width = 353
          Height = 25
          Caption = 'List Taskbar Elements'
          TabOrder = 1
          OnClick = Button1Click
        end
        object chkStart: TEsSwitch
          Left = 18
          Top = 66
          Width = 135
          Height = 20
          TextOn = 'Show Start Button'
          TextOff = 'Show Start Button'
          ShowCaption = True
          TabOrder = 2
          OnClick = chkStartClick
        end
        object chkTray: TEsSwitch
          Left = 18
          Top = 92
          Width = 124
          Height = 20
          TextOn = 'Show Tray Area'
          TextOff = 'Show Tray Area'
          ShowCaption = True
          TabOrder = 3
          OnClick = chkTrayClick
        end
        object chkTransparent: TEsSwitch
          Left = 18
          Top = 118
          Width = 147
          Height = 20
          TextOn = 'Taskbar Transparent'
          TextOff = 'Taskbar Transparent'
          ShowCaption = True
          TabOrder = 4
          OnClick = chkTransparentClick
        end
        object chkCenter: TEsSwitch
          Left = 18
          Top = 144
          Width = 121
          Height = 20
          TextOn = 'Center Taskbar'
          TextOff = 'Center Taskbar'
          ShowCaption = True
          TabOrder = 5
          OnClick = chkCenterClick
        end
        object chkCenterRelative: TEsSwitch
          Left = 18
          Top = 170
          Width = 212
          Height = 20
          TextOn = 'Center Taskbar relative to its area'
          TextOff = 'Center Taskbar relative to its area'
          ShowCaption = True
          TabOrder = 6
          OnClick = chkCenterRelativeClick
        end
        object chkAutoStart: TEsSwitch
          Left = 18
          Top = 274
          Width = 140
          Height = 20
          TextOn = 'Start with Windows'
          TextOff = 'Start with Windows'
          ShowCaption = True
          TabOrder = 7
          OnClick = chkAutoStartClick
        end
        object chkSkinEnabled: TEsSwitch
          Left = 18
          Top = 196
          Width = 131
          Height = 20
          TextOn = 'Experimental Skin'
          TextOff = 'Experimental Skin'
          ShowCaption = True
          TabOrder = 8
        end
        object chkSmall: TEsSwitch
          Left = 18
          Top = 222
          Width = 100
          Height = 20
          TextOn = 'Small Icons'
          TextOff = 'Small Icons'
          ShowCaption = True
          TabOrder = 9
          OnClick = chkSmallClick
        end
        object chkAnimation: TEsSwitch
          Left = 18
          Top = 248
          Width = 186
          Height = 20
          TextOn = 'Taskbar Thumbnail Animation'
          TextOff = 'Taskbar Thumbnail Animation'
          ShowCaption = True
          TabOrder = 10
          OnClick = chkAnimationClick
        end
      end
      object tbsAbout: TTabSheet
        Caption = 'tbsAbout'
        ImageIndex = 1
        TabVisible = False
        object headingAbout: TUText
          AlignWithMargins = True
          Left = 0
          Top = 20
          Width = 698
          Height = 28
          Margins.Left = 0
          Margins.Top = 20
          Margins.Right = 0
          Margins.Bottom = 5
          Align = alTop
          Caption = 'About'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -20
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TextKind = tkHeading
          ExplicitWidth = 55
        end
        object desAppVersion: TUText
          AlignWithMargins = True
          Left = 0
          Top = 117
          Width = 698
          Height = 15
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 5
          Align = alTop
          Caption = 'App version: 0.1b'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6710886
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          WordWrap = True
          TextKind = tkDescription
          ExplicitWidth = 91
        end
        object desFlashVersion: TUText
          AlignWithMargins = True
          Left = 0
          Top = 184
          Width = 698
          Height = 15
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Author: Victor Alberto Gil <vhanla>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6710886
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          WordWrap = True
          TextKind = tkDescription
          ExplicitWidth = 187
        end
        object desChromiumVersion: TUText
          AlignWithMargins = True
          Left = 0
          Top = 164
          Width = 698
          Height = 15
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Source: https://github.com/vhanla/taskbardock'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 6710886
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          WordWrap = True
          TextKind = tkDescription
          ExplicitWidth = 253
        end
        object linkEmbarcadero: TUHyperLink
          AlignWithMargins = True
          Left = 0
          Top = 137
          Width = 698
          Height = 17
          Cursor = crHandPoint
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 10
          Align = alTop
          Caption = 'https://codigobit.net/TaskbarDock'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 14051691
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          CustomTextColors.None = 14120960
          CustomTextColors.Hover = clGray
          CustomTextColors.Press = clMedGray
          CustomTextColors.Disabled = clMedGray
          CustomTextColors.Focused = 14120960
          URL = 'https://embarcadero.com/'
          ExplicitWidth = 198
        end
        object btnCheckUpdate: TUButton
          AlignWithMargins = True
          Left = 0
          Top = 58
          Width = 698
          Height = 30
          Margins.Left = 0
          Margins.Top = 5
          Margins.Right = 0
          Margins.Bottom = 10
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
          Text = 'Check for update'
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TabStop = True
          OnClick = btnCheckUpdateClick
        end
        object pbDownload: TUProgressBar
          Left = 0
          Top = 98
          Width = 698
          Height = 19
          Value = 0
          Orientation = oHorizontal
          CustomFillColor = 2469894
          CustomBackColor = 15132390
          Align = alTop
        end
      end
      object tbsDocks: TTabSheet
        Caption = 'tbsDocks'
        ImageIndex = 2
        TabVisible = False
        object UText2: TUText
          AlignWithMargins = True
          Left = 0
          Top = 20
          Width = 698
          Height = 28
          Margins.Left = 0
          Margins.Top = 20
          Margins.Right = 0
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Docks'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -20
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TextKind = tkHeading
          ExplicitWidth = 53
        end
      end
      object tbsPinnedIcons: TTabSheet
        Caption = 'tbsPinnedIcons'
        ImageIndex = 3
        TabVisible = False
        inline frameIcons1: TframeIcons
          Left = 0
          Top = 0
          Width = 698
          Height = 361
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 698
          ExplicitHeight = 361
          inherited UText3: TUText
            Width = 698
          end
          inherited pnlIconOriginal: TPanel
            inherited imgOriginal: TEsImageControl
              ExplicitLeft = 1
              ExplicitTop = 1
              ExplicitWidth = 94
              ExplicitHeight = 94
            end
          end
          inherited pnlIconNew: TPanel
            inherited imgNew: TEsImageControl
              ExplicitLeft = 1
              ExplicitTop = 1
              ExplicitWidth = 94
              ExplicitHeight = 94
            end
          end
          inherited pnlIconLight: TPanel
            inherited imgLight: TEsImageControl
              ExplicitLeft = 1
              ExplicitTop = 1
              ExplicitWidth = 94
              ExplicitHeight = 94
            end
          end
          inherited Panel1: TPanel
            inherited UButton1: TUButton
              ThemeManager = nil
              Anchors = [akLeft, akTop, akRight]
            end
            inherited UButton2: TUButton
              ThemeManager = nil
              Anchors = [akLeft, akTop, akRight]
            end
            inherited UButton3: TUButton
              ThemeManager = nil
            end
            inherited UButton5: TUButton
              ThemeManager = nil
            end
          end
        end
      end
      object tbsMore: TTabSheet
        Caption = 'tbsMore'
        ImageIndex = 4
        TabVisible = False
      end
      object tbsSkins: TTabSheet
        Caption = 'tbsSkins'
        ImageIndex = 5
        TabVisible = False
        inline frmSkin1: TfrmSkin
          Left = 0
          Top = 0
          Width = 698
          Height = 355
          Align = alTop
          TabOrder = 0
          ExplicitWidth = 698
          inherited UText3: TUText
            Width = 698
          end
        end
      end
    end
  end
  object UCaptionBar1: TUCaptionBar
    Left = 0
    Top = 0
    Width = 751
    Height = 32
    ThemeManager = UThemeManager1
    Align = alTop
    BevelOuter = bvNone
    Caption = 'TaskbarDock'
    Color = 15921906
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 1
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
      OnClick = UButton2Click
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
      OnClick = UButton3Click
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
    DoubleBuffered = True
    FullRepaint = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 0
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
      TextFont.Style = [fsBold]
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
      Top = 291
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
      Align = alBottom
      TabOrder = 1
      TabStop = True
      OnClick = USymbolButton2Click
    end
    object USymbolButton3: TUSymbolButton
      Left = 0
      Top = 331
      Width = 45
      Height = 40
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
      SymbolChar = #59718
      Text = '   About'
      Detail = 'Detail'
      ShowDetail = False
      Align = alBottom
      TabOrder = 2
      TabStop = True
      OnClick = USymbolButton3Click
    end
    object USymbolButton4: TUSymbolButton
      Left = 0
      Top = 40
      Width = 45
      Height = 40
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
      SymbolChar = #59249
      Text = '   Customize Icons'
      Detail = 'Detail'
      ShowDetail = False
      Align = alTop
      TabOrder = 3
      TabStop = True
      OnClick = USymbolButton4Click
    end
    object USymbolButton5: TUSymbolButton
      Left = 0
      Top = 80
      Width = 45
      Height = 40
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
      SymbolChar = #62022
      Text = '   Docks'
      Detail = 'Detail'
      ShowDetail = False
      Align = alTop
      TabOrder = 4
      TabStop = True
      OnClick = USymbolButton5Click
    end
    object USymbolButton6: TUSymbolButton
      Left = 0
      Top = 160
      Width = 45
      Height = 40
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
      SymbolChar = #59154
      Text = '   Misc'
      Detail = 'Detail'
      ShowDetail = False
      Align = alTop
      TabOrder = 5
      TabStop = True
    end
    object USymbolButton7: TUSymbolButton
      Left = 0
      Top = 120
      Width = 45
      Height = 40
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
      SymbolChar = #60524
      Text = '   Theme'
      Detail = 'Detail'
      ShowDetail = False
      Align = alTop
      TabOrder = 6
      TabStop = True
      OnClick = USymbolButton7Click
    end
  end
  object TrayIcon1: TTrayIcon
    PopupMenu = PopupMenu1
    Visible = True
    OnDblClick = TrayIcon1DblClick
    Left = 304
    Top = 352
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 304
    Top = 272
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
    object mnuSmall: TMenuItem
      Caption = 'Small Icons'
      OnClick = mnuSmallClick
    end
    object N2: TMenuItem
      Caption = '-'
      Visible = False
    end
    object mnuPinnedIcons: TMenuItem
      Caption = 'Pinned Icons'
      Visible = False
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
    Left = 384
    Top = 352
  end
  object tmrOptions: TTimer
    Interval = 250
    OnTimer = tmrOptionsTimer
    Left = 152
    Top = 352
  end
  object tmrThreadWaiter: TTimer
    Enabled = False
    OnTimer = tmrThreadWaiterTimer
    Left = 232
    Top = 352
  end
  object tmrCenter: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrCenterTimer
    Left = 80
    Top = 352
  end
  object MadExceptionHandler1: TMadExceptionHandler
    Left = 496
    Top = 352
  end
  object UThemeManager1: TUThemeManager
    Left = 680
    Top = 352
  end
end
