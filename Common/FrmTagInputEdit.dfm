object TagEditF: TTagEditF
  Left = 0
  Top = 0
  Caption = 'Search Tag Info'
  ClientHeight = 215
  ClientWidth = 381
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 9
    Top = 24
    Width = 68
    Height = 16
    Alignment = taRightJustify
    Caption = 'Tag Name: '
  end
  object Label2: TLabel
    Left = 21
    Top = 126
    Width = 56
    Height = 16
    Alignment = taRightJustify
    Caption = 'Base Dir :'
  end
  object Label3: TLabel
    Left = 83
    Top = 105
    Width = 224
    Height = 16
    Caption = 'Json/Tgz : HullNo_ICMS, Online : Blank'
  end
  object InputEdit: TEdit
    Left = 83
    Top = 21
    Width = 262
    Height = 24
    ImeName = 'Microsoft IME 2010'
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 40
    Top = 159
    Width = 121
    Height = 39
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 1
  end
  object BitBtn2: TBitBtn
    Left = 224
    Top = 159
    Width = 121
    Height = 39
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
  end
  object InputEdit2: TEdit
    Left = 83
    Top = 123
    Width = 262
    Height = 24
    ImeName = 'Microsoft IME 2010'
    TabOrder = 3
  end
  object RadioGroup1: TRadioGroup
    Left = 40
    Top = 51
    Width = 305
    Height = 48
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      'From Json'
      'From Tgz'
      'From Online')
    TabOrder = 4
    OnClick = RadioGroup1Click
  end
  object BitBtn3: TBitBtn
    Left = 347
    Top = 123
    Width = 26
    Height = 25
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF667BB73370C2206DC91E69C61B67C61A65C61864C616
      63C61460C4125EC6105CC4105BC4105BC4105EC81059C15E77B6284AA180DFFF
      41BCFF43B8FF3FB4FF3BB1FF36AEFF32A9FF2EA6FF29A1FF259EFF219AFF2097
      FF209AFF229FFF063AA02447A379D3FF40B1FE41AEFC3FABFC39A7FA37A3F933
      A0F92F9CF92C99F92896F82393F81E8EF81D8DF91F92FF053CA2254CA87ED7FF
      45B7FE48B3FC44B0FC40ACFC3CA9FB39A6FA35A2FA319FFA2D9BFA2998F92594
      F92292FB2095FF063FA6254CA884DBFF4CBBFE4DB8FD4AB5FD45B1FC41AEFC3E
      AAFC3AA7FA36A4FA32A0FA2D9DFA2B99FA2998FA2499FF0642AC2554B380DDFF
      4EBFFE50BDFD4FBAFD4CB6FC46B3FC43AFFC3FABFC3DA7FB37A4FA33A1FA2D9C
      FA2396FB259BFF0642AC2554B3AAECFF61C9FE53C2FD4EBDFD4AB9FD46B5FD42
      B1FC3EAEFC3AAAFC36A6FB31A3FA36A2FB4DADFD6FC0FF1450B7295ABCBEF4FF
      95DEFF93D9FE82D3FE71C9FD69C6FD67C4FD62C0FD5FBCFD6ABFFD72C2FD7EC6
      FD7CC5FE80CBFF1452BB285DC2BDF5FF93DFFF94DCFE93DAFE91DAFE90D8FF8D
      D6FF8BD4FF87D1FF83CDFF7EC8FF76C5FF76C4FF7BCBFF1456C2285DC2C0F8FF
      97E1FF95DFFE93DFFFB4EFFFB2EDFFB0EBFFAFE9FFACE6FFA9E4FFA7E2FFA5E0
      FFA7E1FFA9E5FF1B5FCA285DC2BFFBFF99E5FF98E2FF9DE9FF4881D92B60CD2D
      6CD22D6BD12D6BD12C6AD12B6AD02D6BD02D6CD12E6DD385A9E22E6ED5D4FFFF
      A8F1FFA6EFFFB1F9FF1462D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF1866D8B6E5FAB3E8FBB2E5FCA8DEF81667D9FFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFACC8F21F6CDE
      2B72DE2B70DE206CDEA2C1F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    TabOrder = 5
    OnClick = BitBtn3Click
  end
  object JvSelectDirectory1: TJvSelectDirectory
    Left = 16
    Top = 160
  end
end
