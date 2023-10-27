object SCRReportF: TSCRReportF
  Left = 0
  Top = 0
  Caption = 'SCRReportF'
  ClientHeight = 544
  ClientWidth = 879
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object NextGrid1: TNextGrid
    Left = 8
    Top = 8
    Width = 849
    Height = 385
    Touch.InteractiveGestures = [igPan, igPressAndTap]
    Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
    Caption = ''
    PopupMenu = PopupMenu1
    TabOrder = 0
    TabStop = True
    OnMouseDown = NextGrid1MouseDown
    OnMouseMove = NextGrid1MouseMove
    object TagId: TNxIncrementColumn
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
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
    end
    object TagName: TNxTextColumn
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Tag Name'
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
    object TagDesc: TNxTextColumn
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Tag Desc'
      Header.Alignment = taCenter
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      ParentFont = False
      Position = 2
      SortType = stAlphabetic
    end
    object SCRTYpe: TNxTextColumn
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'SCR Type'
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
    object ParamKind: TNxTextColumn
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Param Kind'
      Header.Alignment = taCenter
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      ParentFont = False
      Position = 4
      SortType = stAlphabetic
    end
    object SCRComponent: TNxTextColumn
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'SCR Component'
      Header.Alignment = taCenter
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      ParentFont = False
      Position = 5
      SortType = stAlphabetic
    end
    object ValueBitNo: TNxTextColumn
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'BitNo'
      Header.Alignment = taCenter
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      ParentFont = False
      Position = 6
      SortType = stAlphabetic
    end
    object ParamValue: TNxTextColumn
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Param Value'
      Header.Alignment = taCenter
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      ParentFont = False
      Position = 7
      SortType = stAlphabetic
    end
    object ValueType: TNxTextColumn
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Value Type'
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      ParentFont = False
      Position = 8
      SortType = stAlphabetic
    end
  end
  object Button1: TButton
    Left = 32
    Top = 432
    Width = 73
    Height = 33
    Caption = 'Add row'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 111
    Top = 399
    Width = 130
    Height = 33
    Caption = 'Create SCR App Setting'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 247
    Top = 399
    Width = 130
    Height = 33
    Caption = 'Free SCR App Setting'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 111
    Top = 438
    Width = 130
    Height = 33
    Caption = 'Create SCR GE Setting'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 111
    Top = 477
    Width = 130
    Height = 33
    Caption = 'Create SCR ME Setting'
    TabOrder = 5
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 247
    Top = 438
    Width = 130
    Height = 33
    Caption = 'Free SCR GE Setting'
    TabOrder = 6
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 247
    Top = 477
    Width = 130
    Height = 33
    Caption = 'Free SCR ME Setting'
    TabOrder = 7
    OnClick = Button7Click
  end
  object MainMenu1: TMainMenu
    Left = 16
    Top = 232
    object ools1: TMenuItem
      Caption = 'Tools'
      object LoadBaseInfoXls2Grid1: TMenuItem
        Caption = 'Load Base Info Xls 2 Grid'
        Hint = 'Xls '#54028#51068#47196#48512#53552' Receit File Field '#51221#48372#47484' '#51069#50612' '#46308#51076
        OnClick = LoadBaseInfoXls2Grid1Click
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 56
    Top = 232
    object Save2DB1: TMenuItem
      Caption = 'Save Grid 2 DB'
    end
    object Save2JsonFile1: TMenuItem
      Caption = 'Save Grid 2 Json File'
      OnClick = Save2JsonFile1Click
    end
    object LoadFromJsonFile2Grid1: TMenuItem
      Caption = 'Load From Json File 2 Grid'
      OnClick = LoadFromJsonFile2Grid1Click
    end
    object LoadFromJsonFile2Aryt1: TMenuItem
      Caption = 'Load From Json File 2 Object'
      OnClick = LoadFromJsonFile2Aryt1Click
    end
    object LaodFromObj2Grid1: TMenuItem
      Caption = 'Laod From Obj 2 Grid'
      OnClick = LaodFromObj2Grid1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object GenerateObjectCodeFromGrid1: TMenuItem
      Caption = 'Generate Obj Code From Grid'
      Hint = 'Class Field '#48143' Property Code '#47484' c:\temp\'#50640' '#51088#46041' '#49373#49457'  From Grid'
      OnClick = GenerateObjectCodeFromGrid1Click
    end
    object AssigntagfromObject1: TMenuItem
      Caption = 'Assign Compoonent tag from Object'
    end
    object GenerateDFM4updatetag1: TMenuItem
      Caption = 'Generate DFM 4 updated tag'
    end
  end
  object SCRParamSource1: TDropTextSource
    DragTypes = [dtCopy]
    Left = 96
    Top = 232
  end
end
