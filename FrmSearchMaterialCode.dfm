object SearchMatCodeF: TSearchMatCodeF
  Left = 0
  Top = 0
  Caption = #51088#51116#53076#46300' '#44160#49353
  ClientHeight = 605
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 792
    Height = 41
    Align = alTop
    TabOrder = 0
    object JvLabel5: TJvLabel
      AlignWithMargins = True
      Left = 14
      Top = 9
      Width = 80
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Caption = #51088#51116#48264#54840
      Color = 14671839
      FrameColor = clGrayText
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = [fsBold]
      Layout = tlCenter
      ParentColor = False
      ParentFont = False
      RoundedFrame = 3
      Transparent = True
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -13
      HotTrackFont.Name = #47569#51008' '#44256#46357
      HotTrackFont.Style = []
    end
    object JvLabel6: TJvLabel
      AlignWithMargins = True
      Left = 219
      Top = 12
      Width = 80
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Caption = #51088#51116#47749
      Color = 14671839
      FrameColor = clGrayText
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = [fsBold]
      Layout = tlCenter
      ParentColor = False
      ParentFont = False
      RoundedFrame = 3
      Transparent = True
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -13
      HotTrackFont.Name = #47569#51008' '#44256#46357
      HotTrackFont.Style = []
    end
    object SearchButton: TButton
      Left = 738
      Top = 1
      Width = 53
      Height = 39
      Align = alRight
      Caption = 'Search'
      TabOrder = 0
      OnClick = SearchButtonClick
    end
    object MatCodeEdit: TEdit
      Left = 98
      Top = 11
      Width = 112
      Height = 21
      CharCase = ecUpperCase
      ImeName = 'Microsoft IME 2010'
      TabOrder = 1
      OnKeyPress = MatCodeEditKeyPress
    end
    object MatNameEdit: TEdit
      Left = 302
      Top = 12
      Width = 199
      Height = 21
      CharCase = ecUpperCase
      ImeName = 'Microsoft IME 2010'
      TabOrder = 2
      OnKeyPress = MatNameEditKeyPress
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 564
    Width = 792
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 168
      Top = 6
      Width = 75
      Height = 32
      Caption = 'OK'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 651
      Top = 6
      Width = 75
      Height = 32
      Cancel = True
      Caption = 'Cancel'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      ModalResult = 2
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object MatCodeGrid: TNextGrid
    Left = 0
    Top = 41
    Width = 792
    Height = 523
    Touch.InteractiveGestures = [igPan, igPressAndTap]
    Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
    Align = alClient
    AppearanceOptions = [ao3DGridLines, aoAlphaBlendedSelection, aoBoldTextSelection, aoHideSelection]
    Caption = ''
    HeaderSize = 23
    HighlightedTextColor = clHotLight
    Options = [goGrid, goHeader, goSelectFullRow]
    RowSize = 18
    TabOrder = 2
    TabStop = True
    OnCellDblClick = MatCodeGridCellDblClick
    object NxIncrementColumn1: TNxIncrementColumn
      Alignment = taCenter
      DefaultWidth = 30
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = []
      Header.Caption = 'No'
      Header.Alignment = taCenter
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      ParentFont = False
      Position = 0
      SortType = stAlphabetic
      Width = 30
    end
    object TaskID: TNxTextColumn
      Alignment = taCenter
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = []
      Header.Caption = 'TaskID'
      Header.Alignment = taCenter
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      ParentFont = False
      Position = 1
      SortType = stAlphabetic
    end
    object PORNo: TNxTextColumn
      Alignment = taCenter
      DefaultWidth = 150
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = []
      Header.Caption = 'PORNo'
      Header.Alignment = taCenter
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      ParentFont = False
      Position = 2
      SortType = stAlphabetic
      Width = 150
    end
    object MaterialCode: TNxTextColumn
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = #51088#51116#53076#46300
      Header.Alignment = taCenter
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      ParentFont = False
      Position = 3
      SortType = stAlphabetic
    end
    object MaterialName: TNxTextColumn
      Alignment = taCenter
      DefaultWidth = 110
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = #51088#51116#47749
      Header.Alignment = taCenter
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      ParentFont = False
      Position = 4
      SortType = stAlphabetic
      Width = 110
    end
    object UnitPrice: TNxTextColumn
      Alignment = taCenter
      DefaultWidth = 100
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = []
      Header.Caption = 'Unit Price'
      Header.Alignment = taCenter
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      ParentFont = False
      Position = 5
      SortType = stAlphabetic
      Width = 100
    end
    object CreateDate: TNxDateColumn
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = #51088#51116#49373#49457#51068
      Header.Alignment = taCenter
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      ParentFont = False
      Position = 6
      SortType = stDate
      Width = 200
      NoneCaption = 'None'
      TodayCaption = 'Today'
    end
    object NeedDate: TNxDateColumn
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = #49548#50836#51068#51088
      Header.Alignment = taCenter
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      ParentFont = False
      Position = 7
      SortType = stDate
      NoneCaption = 'None'
      TodayCaption = 'Today'
    end
    object NeedCount: TNxTextColumn
      Alignment = taCenter
      DefaultWidth = 200
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #47569#51008' '#44256#46357
      Font.Style = []
      Header.Caption = #54596#50836#49688#47049
      Header.Alignment = taCenter
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      ParentFont = False
      Position = 8
      SortType = stAlphabetic
      Width = 200
    end
    object LeadTime: TNxTextColumn
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = #49548#50836#51068#49688
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      ParentFont = False
      Position = 9
      SortType = stAlphabetic
    end
  end
end
