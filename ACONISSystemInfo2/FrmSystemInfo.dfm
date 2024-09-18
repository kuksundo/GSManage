object AconisSysInfoF: TAconisSysInfoF
  Left = 0
  Top = 0
  Caption = 'AconisSysInfoF'
  ClientHeight = 570
  ClientWidth = 548
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 424
    Top = 21
    Width = 105
    Height = 41
    Caption = 'Load From ini'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 424
    Top = 228
    Width = 89
    Height = 41
    Caption = 'Save To ini'
    TabOrder = 1
  end
  inline IniTreeListFr1: TIniTreeListFr
    Left = 0
    Top = 0
    Width = 386
    Height = 570
    Align = alLeft
    TabOrder = 2
    ExplicitHeight = 570
    inherited TreeList1: TTreeList
      Height = 509
      ExplicitHeight = 509
    end
  end
  object Button3: TButton
    Left = 424
    Top = 68
    Width = 105
    Height = 41
    Caption = 'Load Json From Xls'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 424
    Top = 275
    Width = 89
    Height = 41
    Caption = 'Save To Json'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 424
    Top = 115
    Width = 89
    Height = 41
    Caption = 'Load From Json'
    TabOrder = 5
    OnClick = Button3Click
  end
  object OpenDialog1: TOpenDialog
    Left = 408
    Top = 168
  end
  object SaveDialog1: TSaveDialog
    Left = 448
    Top = 168
  end
end
