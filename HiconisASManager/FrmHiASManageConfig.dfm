object HiASConfigF: THiASConfigF
  Left = 0
  Top = 0
  Caption = 'HiASConfigF'
  ClientHeight = 449
  ClientWidth = 448
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
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 448
    Height = 408
    ActivePage = EmailTS
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #51200#51109#51068#49884
      TabVisible = False
    end
    object EmailTS: TTabSheet
      Caption = 'Email'
      ImageIndex = 3
      object Label1: TLabel
        Left = 42
        Top = 68
        Width = 112
        Height = 16
        Caption = 'My EMail Address:'
        ParentShowHint = False
        ShowHint = False
      end
      object Label2: TLabel
        Left = 36
        Top = 108
        Width = 118
        Height = 16
        Caption = 'My Email Signature:'
        ParentShowHint = False
        ShowHint = False
      end
      object Label3: TLabel
        Left = 19
        Top = 145
        Width = 135
        Height = 16
        Caption = 'My Email Recv Folder:'
      end
      object Label4: TLabel
        Left = 49
        Top = 32
        Width = 105
        Height = 16
        Caption = 'My Employee ID :'
        Visible = False
      end
      object Label5: TLabel
        Left = 40
        Top = 184
        Width = 114
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Team Name:'
      end
      object Label7: TLabel
        Left = 16
        Top = 222
        Width = 138
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Department Name:'
      end
      object Label16: TLabel
        Left = 32
        Top = 258
        Width = 122
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Company Name:'
      end
      object Edit1: TEdit
        Tag = 2
        Left = 160
        Top = 67
        Width = 225
        Height = 24
        Hint = 'Text'
        ImeName = 'Microsoft IME 2010'
        TabOrder = 0
      end
      object Edit2: TEdit
        Tag = 3
        Left = 160
        Top = 105
        Width = 225
        Height = 24
        Hint = 'Text'
        ImeName = 'Microsoft IME 2010'
        TabOrder = 1
      end
      object Edit3: TEdit
        Tag = 4
        Left = 160
        Top = 142
        Width = 225
        Height = 24
        Hint = 'Text'
        ImeName = 'Microsoft IME 2010'
        TabOrder = 2
      end
      object Edit4: TEdit
        Tag = 1
        Left = 160
        Top = 29
        Width = 225
        Height = 24
        Hint = 'Text'
        ImeName = 'Microsoft IME 2010'
        TabOrder = 3
        Visible = False
      end
      object Edit5: TEdit
        Tag = 5
        Left = 160
        Top = 181
        Width = 225
        Height = 24
        Hint = 'Text'
        ImeName = 'Microsoft IME 2010'
        TabOrder = 4
      end
      object Edit6: TEdit
        Tag = 6
        Left = 160
        Top = 219
        Width = 225
        Height = 24
        Hint = 'Text'
        ImeName = 'Microsoft IME 2010'
        TabOrder = 5
      end
      object Edit12: TEdit
        Tag = 7
        Left = 160
        Top = 255
        Width = 225
        Height = 24
        Hint = 'Text'
        ImeName = 'Microsoft IME 2010'
        TabOrder = 6
      end
    end
    object TabSheet2: TTabSheet
      Caption = #49436#47749
      ImageIndex = 4
      object Label8: TLabel
        Left = 43
        Top = 39
        Width = 119
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'My Email Signature:'
        ParentShowHint = False
        ShowHint = False
        Visible = False
      end
      object Label12: TLabel
        Left = 74
        Top = 168
        Width = 88
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = #52636#54616' '#45812#45817#51088':'
        ParentShowHint = False
        ShowHint = False
      end
      object Label13: TLabel
        Left = 73
        Top = 75
        Width = 89
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = #44396#47588' '#45812#45817#51088':'
      end
      object Label14: TLabel
        Left = 26
        Top = 228
        Width = 136
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = #54596#46300#49436#48708#49828' '#45812#45817#51088':'
      end
      object Label15: TLabel
        Left = 6
        Top = 198
        Width = 156
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = #48512#54408#50696#49328' '#45812#45817#51088':'
      end
      object Label19: TLabel
        Left = 40
        Top = 138
        Width = 122
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = #51077#44256' '#45812#45817#51088':'
      end
      object Label17: TLabel
        Left = 26
        Top = 108
        Width = 136
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = #51088#51116' '#51649#53804#51077' '#45812#45817#51088':'
      end
      object Edit7: TEdit
        Tag = 13
        Left = 168
        Top = 38
        Width = 225
        Height = 24
        Hint = 'Text'
        ImeName = 'Microsoft IME 2010'
        TabOrder = 0
        Visible = False
      end
      object Edit8: TEdit
        Tag = 14
        Left = 168
        Top = 165
        Width = 225
        Height = 24
        Hint = 'Text'
        ImeName = 'Microsoft IME 2010'
        TabOrder = 1
      end
      object Edit9: TEdit
        Tag = 11
        Left = 168
        Top = 72
        Width = 225
        Height = 24
        Hint = 'Text'
        ImeName = 'Microsoft IME 2010'
        TabOrder = 2
      end
      object Edit10: TEdit
        Tag = 16
        Left = 168
        Top = 225
        Width = 225
        Height = 24
        Hint = 'Text'
        ImeName = 'Microsoft IME 2010'
        TabOrder = 3
      end
      object Edit11: TEdit
        Tag = 15
        Left = 168
        Top = 195
        Width = 225
        Height = 24
        Hint = 'Text'
        ImeName = 'Microsoft IME 2010'
        TabOrder = 4
      end
      object Edit13: TEdit
        Tag = 13
        Left = 168
        Top = 135
        Width = 225
        Height = 24
        Hint = 'Text'
        ImeName = 'Microsoft IME 2010'
        TabOrder = 5
      end
      object Edit15: TEdit
        Tag = 12
        Left = 168
        Top = 105
        Width = 225
        Height = 24
        Hint = 'Text'
        ImeName = 'Microsoft IME 2010'
        TabOrder = 6
      end
    end
    object MQServerTS: TTabSheet
      Caption = 'MQ Server'
      ImageIndex = 3
      object MQServerEnableCheck: TAdvGroupBox
        Tag = 80
        Left = 16
        Top = 24
        Width = 396
        Height = 297
        Hint = 'TAdvGroupBox'
        CaptionPosition = cpTopCenter
        CheckBox.Visible = True
        Caption = 'MQ Server Enable'
        TabOrder = 0
        object Label9: TLabel
          Left = 41
          Top = 31
          Width = 69
          Height = 16
          Caption = 'IP Address:'
          ParentShowHint = False
          ShowHint = False
        end
        object Label10: TLabel
          Left = 52
          Top = 103
          Width = 58
          Height = 16
          Caption = 'Port Num:'
          ParentShowHint = False
          ShowHint = False
        end
        object Label21: TLabel
          Left = 51
          Top = 140
          Width = 48
          Height = 16
          Caption = 'User ID:'
        end
        object Label23: TLabel
          Left = 48
          Top = 170
          Width = 51
          Height = 16
          Caption = 'Passwd:'
        end
        object Label18: TLabel
          Left = 61
          Top = 200
          Width = 38
          Height = 16
          Caption = 'Topic:'
        end
        object Label11: TLabel
          Left = 35
          Top = 255
          Width = 99
          Height = 16
          Caption = 'Bind IP Address:'
          ParentShowHint = False
          ShowHint = False
        end
        object Label27: TLabel
          Left = 54
          Top = 71
          Width = 56
          Height = 16
          Caption = 'Protocol: '
          ParentShowHint = False
          ShowHint = False
        end
        object MQIPAddress: TJvIPAddress
          Tag = 81
          Left = 116
          Top = 31
          Width = 150
          Height = 24
          Hint = 'Text'
          Address = 0
          ParentColor = False
          TabOrder = 0
        end
        object MQPortEdit: TEdit
          Tag = 82
          Left = 116
          Top = 100
          Width = 111
          Height = 22
          Hint = 'Text'
          Alignment = taRightJustify
          ImeName = #54620#44397#50612'('#54620#44544') (MS-IME98)'
          TabOrder = 1
          Text = '61613'
        end
        object MQUserEdit: TEdit
          Tag = 83
          Left = 116
          Top = 138
          Width = 187
          Height = 22
          Hint = 'Text'
          ImeName = 'Microsoft Office IME 2007'
          TabOrder = 2
        end
        object MQPasswdEdit: TEdit
          Tag = 84
          Left = 116
          Top = 168
          Width = 187
          Height = 22
          Hint = 'Text'
          ImeName = 'Microsoft Office IME 2007'
          TabOrder = 3
        end
        object MQTopicEdit: TEdit
          Tag = 85
          Left = 116
          Top = 198
          Width = 187
          Height = 22
          Hint = 'Text'
          ImeName = 'Microsoft Office IME 2007'
          TabOrder = 4
        end
        object MQBindComboBox: TComboBox
          Left = 140
          Top = 252
          Width = 154
          Height = 24
          ImeName = 'Microsoft IME 2010'
          TabOrder = 5
        end
        object MQProtocolCombo: TComboBox
          Tag = 86
          Left = 116
          Top = 66
          Width = 153
          Height = 24
          Hint = 'Text'
          ImeName = 'Microsoft IME 2010'
          TabOrder = 6
          OnChange = MQProtocolComboChange
          OnDropDown = MQProtocolComboDropDown
        end
      end
    end
    object FileTS: TTabSheet
      Caption = 'File'
      ImageIndex = 2
      object Label6: TLabel
        Left = 36
        Top = 16
        Width = 184
        Height = 16
        Caption = 'OotLook Folder List  File Name'
        ParentShowHint = False
        ShowHint = False
      end
      object OLFolderListFilenameEdit: TJvFilenameEdit
        Tag = 6
        Left = 36
        Top = 38
        Width = 381
        Height = 24
        Hint = 'Text'
        ImeName = 'Microsoft Office IME 2007'
        TabOrder = 0
        Text = ''
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'WS Server'
      ImageIndex = 5
      object WSSocketEnableCB: TAdvGroupBox
        Tag = 90
        Left = 32
        Top = 41
        Width = 353
        Height = 121
        Hint = 'TAdvGroupBox'
        CaptionPosition = cpTopCenter
        CheckBox.Visible = True
        Caption = 'Web Socket Enable'
        TabOrder = 0
        object Label20: TLabel
          Left = 101
          Top = 58
          Width = 58
          Height = 16
          Caption = 'Port Num:'
          ParentShowHint = False
          ShowHint = False
        end
        object Label25: TLabel
          Left = 49
          Top = 87
          Width = 110
          Height = 16
          Caption = 'Transmission Key:'
          ParentShowHint = False
          ShowHint = False
        end
        object Label26: TLabel
          Left = 90
          Top = 23
          Width = 69
          Height = 16
          Caption = 'IP Address:'
          ParentShowHint = False
          ShowHint = False
        end
        object WSPortEdit: TEdit
          Tag = 92
          Left = 165
          Top = 56
          Width = 111
          Height = 22
          Hint = 'Text'
          Alignment = taRightJustify
          ImeName = #54620#44397#50612'('#54620#44544') (MS-IME98)'
          TabOrder = 0
        end
        object Edit14: TEdit
          Tag = 93
          Left = 165
          Top = 85
          Width = 173
          Height = 22
          Hint = 'Text'
          Alignment = taRightJustify
          ImeName = #54620#44397#50612'('#54620#44544') (MS-IME98)'
          TabOrder = 1
        end
        object JvIPAddress1: TJvIPAddress
          Tag = 91
          Left = 165
          Top = 22
          Width = 150
          Height = 24
          Hint = 'Text'
          Address = 0
          ParentColor = False
          TabOrder = 2
        end
      end
      object RemoteAuthEnableCB: TCheckBox
        Tag = 94
        Left = 48
        Top = 184
        Width = 177
        Height = 17
        Hint = 'Checked'
        Caption = 'Remote Auth Enable'
        TabOrder = 1
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Grid'
      ImageIndex = 6
      object LowAlarmGroup: TAdvGroupBox
        Left = 16
        Top = 16
        Width = 193
        Height = 186
        CaptionPosition = cpTopCenter
        Caption = 'Lo(Alarm) Enable'
        TabOrder = 0
        object Label22: TLabel
          Left = 13
          Top = 24
          Width = 38
          Height = 16
          Caption = 'Value:'
        end
        object Label24: TLabel
          Left = 105
          Top = 94
          Width = 73
          Height = 16
          Caption = 'Alarm Color:'
        end
        object Label31: TLabel
          Left = 101
          Top = 24
          Width = 69
          Height = 16
          Caption = 'DeadBand:'
        end
        object Label37: TLabel
          Left = 15
          Top = 68
          Width = 82
          Height = 16
          Caption = 'Delay(mSec):'
        end
        object AdvGroupBox5: TAdvGroupBox
          Left = 7
          Top = 133
          Width = 170
          Height = 45
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          CaptionPosition = cpTopCenter
          Caption = 'Sound Enable'
          TabOrder = 2
          object MinAlarmSoundEdit: TJvFilenameEdit
            Left = 3
            Top = 23
            Width = 164
            Height = 22
            ImeName = #54620#44397#50612' '#51077#47141' '#49884#49828#53596' (IME 2000)'
            TabOrder = 0
            Text = ''
          end
        end
        object MinAlarmEdit: TEdit
          Left = 13
          Top = 40
          Width = 82
          Height = 22
          ImeName = 'Microsoft Office IME 2007'
          TabOrder = 0
        end
        object MinAlarmColorSelector: TAdvOfficeColorSelector
          Left = 104
          Top = 107
          Width = 78
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Version = '1.4.7.0'
          TabOrder = 1
          AllowFloating = False
          CloseOnSelect = False
          CaptionAppearance.BorderColor = clNone
          CaptionAppearance.Color = 13198890
          CaptionAppearance.ColorTo = clNone
          CaptionAppearance.Direction = gdHorizontal
          CaptionAppearance.TextColor = clWhite
          CaptionAppearance.TextColorHot = clBlack
          CaptionAppearance.TextColorDown = clBlack
          CaptionAppearance.ButtonAppearance.ColorChecked = 16111818
          CaptionAppearance.ButtonAppearance.ColorCheckedTo = 16367008
          CaptionAppearance.ButtonAppearance.ColorDisabled = 15921906
          CaptionAppearance.ButtonAppearance.ColorDisabledTo = 15921906
          CaptionAppearance.ButtonAppearance.ColorDown = 16111818
          CaptionAppearance.ButtonAppearance.ColorDownTo = 16367008
          CaptionAppearance.ButtonAppearance.ColorHot = 16117985
          CaptionAppearance.ButtonAppearance.ColorHotTo = 16372402
          CaptionAppearance.ButtonAppearance.ColorMirrorHot = 16107693
          CaptionAppearance.ButtonAppearance.ColorMirrorHotTo = 16775412
          CaptionAppearance.ButtonAppearance.ColorMirrorDown = 16102556
          CaptionAppearance.ButtonAppearance.ColorMirrorDownTo = 16768988
          CaptionAppearance.ButtonAppearance.ColorMirrorChecked = 16102556
          CaptionAppearance.ButtonAppearance.ColorMirrorCheckedTo = 16768988
          CaptionAppearance.ButtonAppearance.ColorMirrorDisabled = 11974326
          CaptionAppearance.ButtonAppearance.ColorMirrorDisabledTo = 15921906
          DragGripAppearance.BorderColor = clGray
          DragGripAppearance.Color = clWhite
          DragGripAppearance.ColorTo = clWhite
          DragGripAppearance.ColorMirror = clSilver
          DragGripAppearance.ColorMirrorTo = clWhite
          DragGripAppearance.Gradient = ggVertical
          DragGripAppearance.GradientMirror = ggVertical
          DragGripAppearance.BorderColorHot = clBlue
          DragGripAppearance.ColorHot = 16117985
          DragGripAppearance.ColorHotTo = 16372402
          DragGripAppearance.ColorMirrorHot = 16107693
          DragGripAppearance.ColorMirrorHotTo = 16775412
          DragGripAppearance.GradientHot = ggRadial
          DragGripAppearance.GradientMirrorHot = ggRadial
          DragGripPosition = gpTop
          Appearance.ColorChecked = 16111818
          Appearance.ColorCheckedTo = 16367008
          Appearance.ColorDisabled = 15921906
          Appearance.ColorDisabledTo = 15921906
          Appearance.ColorDown = 16111818
          Appearance.ColorDownTo = 16367008
          Appearance.ColorHot = 16117985
          Appearance.ColorHotTo = 16372402
          Appearance.ColorMirrorHot = 16107693
          Appearance.ColorMirrorHotTo = 16775412
          Appearance.ColorMirrorDown = 16102556
          Appearance.ColorMirrorDownTo = 16768988
          Appearance.ColorMirrorChecked = 16102556
          Appearance.ColorMirrorCheckedTo = 16768988
          Appearance.ColorMirrorDisabled = 11974326
          Appearance.ColorMirrorDisabledTo = 15921906
          SelectedColor = clNone
          ShowRGBHint = True
          ColorDropDown = 16251129
          ColorDropDownFloating = 16374724
          SelectionAppearance.ColorChecked = 16111818
          SelectionAppearance.ColorCheckedTo = 16367008
          SelectionAppearance.ColorDisabled = 15921906
          SelectionAppearance.ColorDisabledTo = 15921906
          SelectionAppearance.ColorDown = 16111818
          SelectionAppearance.ColorDownTo = 16367008
          SelectionAppearance.ColorHot = 16117985
          SelectionAppearance.ColorHotTo = 16372402
          SelectionAppearance.ColorMirrorHot = 16107693
          SelectionAppearance.ColorMirrorHotTo = 16775412
          SelectionAppearance.ColorMirrorDown = 16102556
          SelectionAppearance.ColorMirrorDownTo = 16768988
          SelectionAppearance.ColorMirrorChecked = 16102556
          SelectionAppearance.ColorMirrorCheckedTo = 16768988
          SelectionAppearance.ColorMirrorDisabled = 11974326
          SelectionAppearance.ColorMirrorDisabledTo = 15921906
          SelectionAppearance.TextColorChecked = clBlack
          SelectionAppearance.TextColorDown = clWhite
          SelectionAppearance.TextColorHot = clWhite
          SelectionAppearance.TextColor = clBlack
          SelectionAppearance.TextColorDisabled = clGray
          SelectionAppearance.Rounded = False
          Tools = <
            item
              BackGroundColor = clBlack
              Caption = 'Automatic'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'Automatic'
              Enable = True
              ItemType = itFullWidthButton
            end
            item
              BackGroundColor = clBlack
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 13209
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 13107
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 13056
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 6697728
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clNavy
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 3486515
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 3355443
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clMaroon
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 26367
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clOlive
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clGreen
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clTeal
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clBlue
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 10053222
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clGray
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clRed
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 39423
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 52377
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 6723891
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 13421619
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 16737843
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clPurple
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 10066329
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clFuchsia
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 52479
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clYellow
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clLime
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clAqua
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 16763904
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 6697881
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clSilver
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 13408767
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 10079487
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 10092543
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 13434828
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 16777164
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 16764057
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = 16751052
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              BackGroundColor = clWhite
              CaptionAlignment = taCenter
              ImageIndex = -1
              Enable = True
            end
            item
              Caption = 'More Colors...'
              CaptionAlignment = taCenter
              ImageIndex = -1
              Hint = 'More Colors'
              Enable = True
              ItemType = itFullWidthButton
            end>
        end
        object MinAlarmSoundCB: TCheckBox
          Left = 39
          Top = 134
          Width = 14
          Height = 14
          TabOrder = 3
        end
        object MinAlarmDeadBandEdit: TEdit
          Left = 101
          Top = 43
          Width = 82
          Height = 22
          ImeName = 'Microsoft Office IME 2007'
          TabOrder = 4
        end
        object MinAlarmDelayEdit: TEdit
          Left = 101
          Top = 66
          Width = 82
          Height = 22
          ImeName = 'Microsoft Office IME 2007'
          TabOrder = 5
        end
        object MinAlarmBlinkCB: TAdvOfficeCheckBox
          Left = 10
          Top = 91
          Width = 89
          Height = 20
          TabOrder = 6
          Alignment = taLeftJustify
          Caption = 'Blink Enable'
          ReturnIsTab = False
          Version = '1.3.8.5'
        end
        object MinAlarmNeedAckCB: TAdvOfficeCheckBox
          Left = 10
          Top = 109
          Width = 88
          Height = 20
          TabOrder = 7
          Alignment = taLeftJustify
          Caption = 'Need Ack'
          ReturnIsTab = False
          Version = '1.3.8.5'
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 408
    Width = 448
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 100
      Top = 6
      Width = 75
      Height = 25
      Caption = #54869' '#51064
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 289
      Top = 6
      Width = 75
      Height = 25
      Caption = #52712' '#49548
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
end
