object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 249
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  inline IniTreeListFr: TIniTreeListFr
    Left = 0
    Top = 0
    Width = 443
    Height = 249
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 24
    ExplicitTop = 8
    inherited Panel2: TPanel
      Width = 443
      inherited SearchEdit: TEdit
        Width = 416
      end
      inherited Panel3: TPanel
        Width = 441
      end
      inherited BitBtn1: TBitBtn
        Left = 417
      end
    end
    inherited TreeList1: TTreeList
      Width = 443
      Height = 188
      ExplicitTop = 77
    end
  end
  object Panel1: TPanel
    Left = 443
    Top = 0
    Width = 185
    Height = 249
    Align = alRight
    TabOrder = 1
    ExplicitLeft = 448
    ExplicitTop = 48
    ExplicitHeight = 41
    object Button1: TButton
      Left = 6
      Top = 14
      Width = 163
      Height = 41
      Caption = 'Read Log Param From .Conf'
      TabOrder = 0
    end
  end
end
