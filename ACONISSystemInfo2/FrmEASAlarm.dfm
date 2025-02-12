object SetACONISF: TSetACONISF
  Left = 0
  Top = 0
  Caption = 'Set ACONIS System'
  ClientHeight = 225
  ClientWidth = 455
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 40
    Top = 24
    Width = 130
    Height = 16
    Caption = 'EAS ReAlarm Time : '
  end
  object Label2: TLabel
    Left = 247
    Top = 24
    Width = 23
    Height = 16
    Caption = 'Sec'
  end
  object Label3: TLabel
    Left = 29
    Top = 54
    Width = 141
    Height = 16
    Caption = 'Extend EAS ReAlarm: '
  end
  object Label5: TLabel
    Left = 247
    Top = 54
    Width = 23
    Height = 16
    Caption = 'Sec'
  end
  object ReAlarmTimeEdit: TEdit
    Left = 168
    Top = 21
    Width = 73
    Height = 24
    Alignment = taCenter
    ImeName = 'Microsoft IME 2010'
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 158
    Width = 455
    Height = 67
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 88
      Top = 16
      Width = 97
      Height = 41
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 264
      Top = 16
      Width = 97
      Height = 41
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
  object ReAlarmExEnable: TAdvGroupBox
    Left = 0
    Top = 81
    Width = 455
    Height = 77
    CaptionPosition = cpTopCenter
    CheckBox.Visible = True
    Align = alBottom
    Caption = 'Use ReAlarm Extension'
    TabOrder = 2
    Visible = False
    object Label4: TLabel
      Left = 16
      Top = 31
      Width = 314
      Height = 16
      Caption = 'Extended Re-Alarm Time-out when duty-Acked :'
      ParentShowHint = False
      ShowHint = False
    end
    object Label6: TLabel
      Left = 409
      Top = 32
      Width = 23
      Height = 16
      Caption = 'Sec'
    end
    object ExtReAlarmTimeEdit2: TEdit
      Left = 331
      Top = 29
      Width = 75
      Height = 22
      Alignment = taCenter
      ImeName = #54620#44397#50612'('#54620#44544') (MS-IME98)'
      TabOrder = 0
    end
  end
  object AconisDSRB: TRadioButton
    Left = 319
    Top = 8
    Width = 113
    Height = 17
    Caption = 'ACONIS-DS'
    TabOrder = 3
  end
  object HiconisRB: TRadioButton
    Left = 319
    Top = 31
    Width = 113
    Height = 17
    Caption = 'HiCONIS'
    Checked = True
    TabOrder = 4
    TabStop = True
  end
  object ExtReAlarmTimeEdit: TEdit
    Left = 168
    Top = 51
    Width = 73
    Height = 24
    Alignment = taCenter
    ImeName = 'Microsoft IME 2010'
    TabOrder = 5
  end
end
