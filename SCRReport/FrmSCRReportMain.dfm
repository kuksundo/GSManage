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
    Top = 24
    Width = 849
    Height = 369
    Touch.InteractiveGestures = [igPan, igPressAndTap]
    Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
    Caption = ''
    PopupMenu = PopupMenu1
    TabOrder = 0
    TabStop = True
    OnMouseDown = NextGrid1MouseDown
    OnMouseMove = NextGrid1MouseMove
    object NxIncrementColumn1: TNxIncrementColumn
      Header.Caption = 'No'
      Header.Alignment = taCenter
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Position = 0
      SortType = stAlphabetic
    end
    object NxTextColumn1: TNxTextColumn
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Position = 1
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
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 56
    Top = 232
    object Save2DB1: TMenuItem
      Caption = 'Save 2 DB'
    end
    object GenerateObjectCodeFromGrid1: TMenuItem
      Caption = 'Generate Object Code From Grid'
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
