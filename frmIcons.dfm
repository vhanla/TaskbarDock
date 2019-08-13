object frameIcons: TframeIcons
  Left = 0
  Top = 0
  Width = 538
  Height = 378
  TabOrder = 0
  DesignSize = (
    538
    378)
  object imgOriginal: TImage
    Left = 194
    Top = 88
    Width = 105
    Height = 105
  end
  object UText3: TUText
    AlignWithMargins = True
    Left = 0
    Top = 20
    Width = 538
    Height = 28
    Margins.Left = 0
    Margins.Top = 20
    Margins.Right = 0
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Customize Pinned Icons'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TextKind = tkHeading
    ExplicitWidth = 206
  end
  object imgNormal: TImage
    Left = 305
    Top = 88
    Width = 105
    Height = 105
  end
  object imgAlt: TImage
    Left = 416
    Top = 88
    Width = 105
    Height = 105
  end
  object UText1: TUText
    Left = 194
    Top = 56
    Width = 74
    Height = 17
    Caption = 'Original icon'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object UText2: TUText
    Left = 305
    Top = 56
    Width = 54
    Height = 17
    Caption = 'New Icon'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object UText4: TUText
    Left = 416
    Top = 56
    Width = 99
    Height = 17
    Caption = 'Light Theme Icon'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object UScrollBox2: TUScrollBox
    Left = 3
    Top = 56
    Width = 185
    Height = 257
    BorderStyle = bsNone
    DoubleBuffered = True
    Color = 15132390
    ParentColor = False
    ParentDoubleBuffered = False
    TabOrder = 0
    MaxScrollCount = 6
    object ListBox1: TListBox
      Left = 3
      Top = 3
      Width = 179
      Height = 238
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object UButton5: TUButton
    Left = 370
    Top = 312
    Width = 135
    Height = 30
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
    Text = 'Apply'
    Anchors = [akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TabStop = True
    OnClick = UButton5Click
  end
  object UButton1: TUButton
    Left = 305
    Top = 208
    Width = 105
    Height = 30
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
    Text = 'Search icon'
    Anchors = [akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    TabStop = True
    OnClick = UButton1Click
  end
  object UButton2: TUButton
    Left = 416
    Top = 208
    Width = 105
    Height = 30
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
    Text = 'Search icon'
    Anchors = [akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    TabStop = True
    OnClick = UButton2Click
  end
  object UButton3: TUButton
    Left = 194
    Top = 208
    Width = 105
    Height = 30
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
    Text = 'Restore'
    Anchors = [akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    TabStop = True
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 40
    Top = 328
  end
end
