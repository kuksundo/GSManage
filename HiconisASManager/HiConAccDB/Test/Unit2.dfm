object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 445
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 57
    Align = alTop
    TabOrder = 0
    object Button1: TButton
      Left = 16
      Top = 13
      Width = 89
      Height = 33
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object NextGrid1: TNextGrid
    Left = 0
    Top = 57
    Width = 635
    Height = 388
    Touch.InteractiveGestures = [igPan, igPressAndTap]
    Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
    Align = alClient
    Caption = ''
    TabOrder = 1
    TabStop = True
    ExplicitLeft = 32
    ExplicitTop = 80
    ExplicitWidth = 250
    ExplicitHeight = 150
  end
end
