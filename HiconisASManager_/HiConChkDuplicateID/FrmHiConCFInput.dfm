object CFInputF: TCFInputF
  Left = 0
  Top = 0
  Caption = 'CFInputF'
  ClientHeight = 308
  ClientWidth = 398
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 61
    Top = 24
    Width = 75
    Height = 16
    Alignment = taRightJustify
    Caption = 'Local Name: '
  end
  object Label2: TLabel
    Left = 87
    Top = 54
    Width = 49
    Height = 16
    Alignment = taRightJustify
    Caption = 'Eth0 IP: '
  end
  object Label3: TLabel
    Left = 45
    Top = 84
    Width = 91
    Height = 16
    Alignment = taRightJustify
    Caption = 'Eth0. Netmask: '
  end
  object Label4: TLabel
    Left = 30
    Top = 114
    Width = 106
    Height = 16
    Alignment = taRightJustify
    Caption = 'Eth0. Gateway IP: '
  end
  object Label5: TLabel
    Left = 83
    Top = 144
    Width = 53
    Height = 16
    Alignment = taRightJustify
    Caption = 'Eth1. IP: '
  end
  object Label6: TLabel
    Left = 45
    Top = 174
    Width = 91
    Height = 16
    Alignment = taRightJustify
    Caption = 'Eth1. Netmask: '
  end
  object Label7: TLabel
    Left = 30
    Top = 204
    Width = 106
    Height = 16
    Alignment = taRightJustify
    Caption = 'Eth1. Gateway IP: '
  end
  object LocalNameEdit: TEdit
    Tag = 1
    Left = 142
    Top = 21
    Width = 203
    Height = 24
    ImeName = 'Microsoft IME 2010'
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 40
    Top = 240
    Width = 121
    Height = 39
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 1
  end
  object BitBtn2: TBitBtn
    Left = 224
    Top = 240
    Width = 121
    Height = 39
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
  end
  object Eth0IPEdit: TEdit
    Tag = 2
    Left = 142
    Top = 51
    Width = 203
    Height = 24
    ImeName = 'Microsoft IME 2010'
    TabOrder = 3
  end
  object Eth1GateWayEdit: TEdit
    Tag = 7
    Left = 142
    Top = 201
    Width = 203
    Height = 24
    ImeName = 'Microsoft IME 2010'
    TabOrder = 4
  end
  object Eth0GateWayEdit: TEdit
    Tag = 4
    Left = 142
    Top = 111
    Width = 203
    Height = 24
    ImeName = 'Microsoft IME 2010'
    TabOrder = 5
  end
  object Eth1IPEdit: TEdit
    Tag = 5
    Left = 142
    Top = 141
    Width = 203
    Height = 24
    ImeName = 'Microsoft IME 2010'
    TabOrder = 6
  end
  object Eth1NetMaskEdit: TEdit
    Tag = 6
    Left = 142
    Top = 171
    Width = 203
    Height = 24
    ImeName = 'Microsoft IME 2010'
    TabOrder = 7
  end
  object Eth0NetMaskEdit: TEdit
    Tag = 3
    Left = 142
    Top = 81
    Width = 203
    Height = 24
    ImeName = 'Microsoft IME 2010'
    TabOrder = 8
  end
  object BitBtn5: TBitBtn
    Left = 348
    Top = 51
    Width = 26
    Height = 25
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC5600DC96511FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC45D0BDD
      963BEDBD65C76312FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFC45D0DDE922CF5D675F6BF29D27C16C96817FFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC25809E3931FFCDC6EF2
      B62BE68A00EF9B00CE720CC96818FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFC15707E59F2EFEE68CF2BD38EFA71BEDA418E68F02ED9E02D0730AC968
      19FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC15605E5A540FFF3B1F7D474F5BD36F3
      B534EFA921EC9C0EE48C00F0A90ED47608C9681AFFFFFFFFFFFFFFFFFFC15505
      E5A63FFFFCCCFDE9A2F8C947F6C951F4BD3CF1B02CEEA41AE99505E18B00F0AD
      15D57708C05500FFFFFFC15708E4A541FFFEC8FFFBC8FDDE67FBD463F7CD55F5
      C547F3B635EFA824ED9F12E99300E69101F4BA23D47A0BC05500DA8A26F8BE33
      F3B83BECA01AE7A33BFFF7C7FAD261F7C84EF5BF40F2B32FF3AB1CCA6709BE51
      00BE5100BF5400C05500FFFFFFFFFFFFFFFFFFFFFFFFE8A037FFFDD9FBD769F8
      CB55F6C749F4BD39F5B427C5610BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFEAA83DFFFCD8FBDC71F9D260F7C952F6C443F8BC33C5600AFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBA83CFFFEDDFDE07AFB
      D769F9CF5CF7CA4DFCC63EC56009FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFECAA3DFFFFE0FEE380FCDC72F9D365F8CD56FDCD47C55F08FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDAB3EFFFFE3FEE789FD
      E17AFBDA6FFAD063FFD555C45E07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFEEB144FFFFFAFFF49DFFF08EFFEB83FFE676FFE767C45E06FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEA42AF1BC5AEDAC38E9
      A231E3982EDE9128DC8C25CA6713FFFFFFFFFFFFFFFFFFFFFFFF}
    TabOrder = 9
    OnClick = BitBtn5Click
  end
end
