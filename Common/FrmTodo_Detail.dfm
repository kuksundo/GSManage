object ToDoDetailF: TToDoDetailF
  Left = 0
  Top = 0
  Caption = 'To-Do Detail'
  ClientHeight = 531
  ClientWidth = 676
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 676
    Height = 57
    Align = alTop
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 583
      Top = 11
      Width = 73
      Height = 41
      Caption = #52712#49548
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 465
      Top = 10
      Width = 73
      Height = 41
      Caption = #54869#51064
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object UniqueID: TEdit
      Left = 105
      Top = 30
      Width = 330
      Height = 21
      Hint = 'Text'
      TabOrder = 2
      Visible = False
    end
    object PngBitBtn1: TPngBitBtn
      Left = 1
      Top = 1
      Width = 75
      Height = 55
      Align = alLeft
      Caption = 'Outlook '#46321#47197
      Layout = blGlyphTop
      TabOrder = 3
      OnClick = PngBitBtn1Click
      PngImage.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        61000003224944415478DAA593674C535114C7FFF7D50A94563410158B23350E
        A2082A71A37E50E3A8515C1F1045DC24E088338E0F2A468D088E68C41545418D
        0317A2C411952A01A95A2AC6890191324AA5EFF1FA3ADEBBDED6F8D52F9E9B9C
        737273CF3FE777722EC17F1AF1BB51D9E6AD13461AB6159758F32CBBC6A5FFAB
        604866D9BE6913FAA73F357DDB5BBE357E7F4060E2C1CAAC4953076F3879EEF9
        C71F399307FE4BA0F7A647152B168F8D7F78BFFAD08B2DC337926987CD47C335
        AAC4B62E1151B4AEC13D3E3AFC012F5135E1284009283B7F4DDB51E529FD629F
        82C8EE9AB066DB0FBB871492CC273FE9076B2D6EF3A148508958BF6838DA251F
        282B06E7676451A150580C0BE170A4C08CC79E10246A0444C7F601C9B855EB6C
        AA6FD25DBD5086C4F9F198611C0A4174A3A38A83DBA70444D41C812C2BD0E882
        71F7961977AE552229650CBAF60CE749F2192BBF7BE1206D9BC38D8A160583C3
        39C83E0A4B8B0723BB05C3E19651D5EAC5447D105ADD0AEA5DC0E8880E7005AB
        B1ABE0BD4052732DFCB995315A3FE3B1F25FC818D139C07BD1E2C4A2219D2079
        155CB7F2481E1A0699E51758BE94E5127B63CC792390A9D9667E6F528CD6E792
        50F845C22C43109A5D148535ED48EA1B8A3686F1A05644466C18AAEC5ED438BC
        98DB2F148DBE0E3870D32A90B9D9157CFEFA78AD93F762F97D1BCE187BB05665
        6C7FD288F333F5B0344BD86FB2237FB61E1F1BDDC87DE7C02963243E0B40DAF1
        D70219B5F3395FB42341DBCE4B48B9DB802BF3A2587314EB8A6DB898A8474583
        07392F1B9137A717DED68BC82AFF23F6AA952239CB2490C8758FF8D5B363B52A
        C983FC4F3C5206EA6077C9B8FD5D446AB40E029BFE8DCF22D6C6E950CD105EDA
        DC5836408BAF3E150A8AAA04326C7389B3F2C0649D7F70C38E7D8039233A3044
        63DE37DC5B6C40AD93A15DAE41C9AAFE7030CC941B75B8B3C400AB13885B53C4
        13C3DA87F468FA78C8A284B4E29F8C2F0A5E4AB1F3A90DB933F478D7E4425669
        0B0AE6F742659D88136FED383D5D8F67CD0AF69C3581745F70C9044D481F2AFB
        148570208A12E880B20DE2FCFBC716C9AB7008E2147803F7042A9979B59AE3C4
        F6EFE47FBFF36F94FB704F1C4DAC7C0000000049454E44AE426082}
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 57
    Width = 676
    Height = 32
    Align = alTop
    TabOrder = 1
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 32
      Height = 30
      Align = alLeft
      TabOrder = 0
      object Label1: TLabel
        Left = 2
        Top = 10
        Width = 26
        Height = 13
        Caption = #51228#47785':'
      end
    end
    object Panel5: TPanel
      Left = 33
      Top = 1
      Width = 642
      Height = 30
      Align = alClient
      TabOrder = 1
      object Subject: TEdit
        Left = 1
        Top = 1
        Width = 640
        Height = 28
        Hint = 'Text'
        Align = alClient
        ImeName = 'Microsoft IME 2010'
        TabOrder = 0
        ExplicitHeight = 21
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 89
    Width = 676
    Height = 442
    Align = alClient
    TabOrder = 2
    object Notes: TMemo
      Left = 1
      Top = 89
      Width = 674
      Height = 352
      Hint = 'Text'
      Align = alClient
      ImeName = 'Microsoft IME 2010'
      TabOrder = 0
    end
    object Panel6: TPanel
      Left = 1
      Top = 1
      Width = 674
      Height = 88
      Align = alTop
      TabOrder = 1
      object Label2: TLabel
        Left = 16
        Top = 19
        Width = 48
        Height = 13
        Caption = #49884#51089#49884#44036':'
      end
      object Label3: TLabel
        Left = 16
        Top = 52
        Width = 48
        Height = 13
        Caption = #51333#47308#49884#44036':'
      end
      object Label4: TLabel
        Left = 368
        Top = 20
        Width = 48
        Height = 13
        Caption = #48120#47532#50508#47548':'
      end
      object Label5: TLabel
        Left = 368
        Top = 53
        Width = 48
        Height = 13
        Caption = #50508#47548#48169#48277':'
      end
      object BeginDate: TDateTimePicker
        Left = 74
        Top = 15
        Width = 175
        Height = 25
        Hint = 'Date'
        Date = 42132.710435775470000000
        Time = 42132.710435775470000000
        DateFormat = dfLong
        ImeName = 'Microsoft IME 2010'
        TabOrder = 0
      end
      object BeginTime: TDateTimePicker
        Left = 255
        Top = 15
        Width = 90
        Height = 25
        Hint = 'Time'
        Date = 41527.000000000000000000
        Format = 'tt h:mm'
        Time = 41527.000000000000000000
        DateFormat = dfLong
        ImeName = 'Microsoft IME 2010'
        Kind = dtkTime
        TabOrder = 1
      end
      object EndDate: TDateTimePicker
        Left = 74
        Top = 46
        Width = 175
        Height = 25
        Hint = 'Date'
        Date = 42132.710435775470000000
        Time = 42132.710435775470000000
        DateFormat = dfLong
        ImeName = 'Microsoft IME 2010'
        TabOrder = 2
      end
      object EndTime: TDateTimePicker
        Left = 255
        Top = 46
        Width = 90
        Height = 25
        Hint = 'Time'
        Date = 41527.710435775470000000
        Format = 'tt h:mm'
        Time = 41527.710435775470000000
        DateFormat = dfLong
        ImeName = 'Microsoft IME 2010'
        Kind = dtkTime
        TabOrder = 3
      end
      object AlarmType: TComboBox
        Left = 426
        Top = 16
        Width = 145
        Height = 21
        Hint = 'ItemIndex'
        ImeName = 'Microsoft IME 2010'
        TabOrder = 4
        Items.Strings = (
          ''
          '0'#48516
          '5'#48516
          '10'#48516
          '15'#48516
          '30'#48516
          '1'#49884#44036
          '2'#49884#44036
          '3'#49884#44036
          '4'#49884#44036
          '5'#49884#44036
          '6'#49884#44036
          '7'#49884#44036
          '8'#49884#44036
          '9'#49884#44036
          '10'#49884#44036
          '11'#49884#44036
          '18'#49884#44036
          '1'#51068
          '2'#51068
          '3'#51068
          '4'#51068
          '1'#51452
          '2'#51452)
      end
      object Button1: TButton
        Left = 582
        Top = 14
        Width = 75
        Height = 25
        Caption = #46104#54400#51060
        TabOrder = 5
        Visible = False
        OnClick = Button1Click
      end
      object Alarm2Msg: TCheckBox
        Left = 432
        Top = 51
        Width = 46
        Height = 17
        Hint = 'Checked'
        Caption = #47928#51088
        TabOrder = 6
      end
      object Alarm2Note: TCheckBox
        Left = 480
        Top = 51
        Width = 46
        Height = 17
        Hint = 'Checked'
        Caption = #51901#51648
        TabOrder = 7
      end
      object Alarm2Email: TCheckBox
        Left = 530
        Top = 51
        Width = 58
        Height = 17
        Hint = 'Checked'
        Caption = #51060#47700#51068
        TabOrder = 8
      end
      object Alarm2Popup: TCheckBox
        Left = 594
        Top = 51
        Width = 58
        Height = 17
        Hint = 'Checked'
        Caption = #54045#50629#52285
        TabOrder = 9
      end
    end
  end
end
