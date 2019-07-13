object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Taskbar Pinned Icons Customizer'
  ClientHeight = 292
  ClientWidth = 525
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    525
    292)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 127
    Top = 8
    Width = 393
    Height = 13
    Caption = 
      'This will only list non UWP pinned  icons, excluding localized i' +
      'cons like File Explorer.'
  end
  object Button1: TButton
    Left = 442
    Top = 259
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Apply'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 121
    Height = 292
    Align = alLeft
    ItemHeight = 13
    TabOrder = 1
  end
  object Button2: TButton
    Left = 127
    Top = 259
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&Refresh'
    TabOrder = 2
    OnClick = Button2Click
  end
end
