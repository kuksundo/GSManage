unit FrmHiASManageConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  AdvOfficeButtons, AdvGlowButton, AdvOfficeSelectors, AdvGroupBox, Vcl.Mask,
  JvExMask, JvToolEdit, JvExControls, JvComCtrls, Vcl.ComCtrls, BaseGrid,
  UnitMQData;

type
  THiASConfigF = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    EmailTS: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label16: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit12: TEdit;
    TabSheet2: TTabSheet;
    Label8: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label19: TLabel;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit13: TEdit;
    MQServerTS: TTabSheet;
    FileTS: TTabSheet;
    Label6: TLabel;
    OLFolderListFilenameEdit: TJvFilenameEdit;
    TabSheet3: TTabSheet;
    WSSocketEnableCB: TAdvGroupBox;
    Label20: TLabel;
    Label25: TLabel;
    WSPortEdit: TEdit;
    Edit14: TEdit;
    RemoteAuthEnableCB: TCheckBox;
    TabSheet4: TTabSheet;
    LowAlarmGroup: TAdvGroupBox;
    Label22: TLabel;
    Label24: TLabel;
    Label31: TLabel;
    Label37: TLabel;
    AdvGroupBox5: TAdvGroupBox;
    MinAlarmSoundEdit: TJvFilenameEdit;
    MinAlarmEdit: TEdit;
    MinAlarmColorSelector: TAdvOfficeColorSelector;
    MinAlarmSoundCB: TCheckBox;
    MinAlarmDeadBandEdit: TEdit;
    MinAlarmDelayEdit: TEdit;
    MinAlarmBlinkCB: TAdvOfficeCheckBox;
    MinAlarmNeedAckCB: TAdvOfficeCheckBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label26: TLabel;
    JvIPAddress1: TJvIPAddress;
    MQServerEnableCheck: TAdvGroupBox;
    Label9: TLabel;
    MQIPAddress: TJvIPAddress;
    Label10: TLabel;
    MQPortEdit: TEdit;
    Label21: TLabel;
    MQUserEdit: TEdit;
    Label23: TLabel;
    MQPasswdEdit: TEdit;
    Label18: TLabel;
    MQTopicEdit: TEdit;
    Label11: TLabel;
    MQBindComboBox: TComboBox;
    Label27: TLabel;
    MQProtocolCombo: TComboBox;
    procedure MQProtocolComboDropDown(Sender: TObject);
    procedure MQProtocolComboChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HiASConfigF: THiASConfigF;

implementation

{$R *.dfm}

procedure THiASConfigF.MQProtocolComboChange(Sender: TObject);
begin
  if g_MQProtocol.ToType(MQProtocolCombo.ItemIndex) = rmqpSTOMP then
    if MQPortEdit.Text = '' then
      MQPortEdit.Text := '61613';
end;

procedure THiASConfigF.MQProtocolComboDropDown(Sender: TObject);
begin
  g_MQProtocol.SetType2Combo(MQProtocolCombo);
end;

end.
