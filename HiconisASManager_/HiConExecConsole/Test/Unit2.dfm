object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 631
  ClientWidth = 575
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 105
    Height = 41
    Caption = 'Console command'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 119
    Top = 8
    Width = 105
    Height = 41
    Caption = 'Telnet'
    TabOrder = 1
    OnClick = Button2Click
  end
  object LogMemo: TMemo
    Left = 0
    Top = 398
    Width = 575
    Height = 233
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 189
    ExplicitWidth = 421
  end
  object ConsoleMemo: TMemo
    Left = 0
    Top = 55
    Width = 575
    Height = 343
    Align = alBottom
    TabOrder = 3
  end
  object Button3: TButton
    Left = 230
    Top = 8
    Width = 105
    Height = 41
    Caption = 'TCPClient'
    TabOrder = 4
    OnClick = Button3Click
  end
  object IdTCPClient1: TIdTCPClient
    ConnectTimeout = 0
    Port = 0
    ReadTimeout = -1
    Left = 352
    Top = 16
  end
end
