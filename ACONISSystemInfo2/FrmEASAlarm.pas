unit FrmEASAlarm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, iniFiles, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, AdvGroupBox;

const
  ACONISSYSTEMINFO = 'd:\ACONIS-DS\INI\sysinfo.ini';
  HICONISSYSTEMINFO = 'D:\ACONIS-NX\INI\sysinfo.ini';

type
  TSetACONISF = class(TForm)
    Label1: TLabel;
    ReAlarmTimeEdit: TEdit;
    Label2: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ReAlarmExEnable: TAdvGroupBox;
    Label4: TLabel;
    Label6: TLabel;
    ExtReAlarmTimeEdit2: TEdit;
    AconisDSRB: TRadioButton;
    HiconisRB: TRadioButton;
    Label3: TLabel;
    ExtReAlarmTimeEdit: TEdit;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FACONISSystemInof : TIniFile;
    FModalResult: integer;
  public
    procedure SetIniSectionValue(AValue: integer);
  end;

var
  SetACONISF: TSetACONISF;

implementation

uses UnitIniFileUtil;

{$R *.dfm}

procedure TSetACONISF.BitBtn1Click(Sender: TObject);
begin
  FModalResult := TBitBtn(Sender).ModalResult;
  Close;
end;

procedure TSetACONISF.BitBtn2Click(Sender: TObject);
begin
  FModalResult := TBitBtn(Sender).ModalResult;
  Close;
end;

procedure TSetACONISF.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
begin
  if FModalResult <> mrOK then
    exit;

  try
    i := StrToInt(ReAlarmTimeEdit.Text);
  except
    exit;
  end;

  FACONISSystemInof.WriteInteger('EAS_SETTING_INFO', 'REALM_TIME',i);

//  if ReAlarmExEnable.CheckBox.Checked then
//  begin
    i := StrToIntDef(ExtReAlarmTimeEdit.Text, 60);
    FACONISSystemInof.WriteInteger('EAS_SETTING_INFO', 'EAS_OPT_EXT3',i);
//  end;

//  FACONISSystemInof.WriteInteger('EAS_SETTING_INFO', 'REALM_TIME_EEX',i);

  ShowMessage('Setting value is changed' + #13#10 + 'EAS_OPT_EXT3 = ' + IntToStr(i));
end;

procedure TSetACONISF.FormCreate(Sender: TObject);
var
  i,j: integer;
  b: integer;
  LStr: string;
begin
  if HiconisRB.Checked then
    LStr := HICONISSYSTEMINFO
  else
    LStr := ACONISSYSTEMINFO;

  FACONISSystemInof := TIniFile.Create(LStr);
  i := FACONISSystemInof.ReadInteger('EAS_SETTING_INFO', 'REALM_TIME', 0);
  j := FACONISSystemInof.ReadInteger('EAS_SETTING_INFO', 'EAS_OPT_EXT3', 0);
//  b := FACONISSystemInof.ReadInteger('EAS_SETTING_INFO', 'REALM_TIME_CCR', 0);
//  j := FACONISSystemInof.ReadInteger('EAS_SETTING_INFO', 'REALM_TIME_EEX', 0);
  ReAlarmTimeEdit.Text := IntToStr(i);
//  ReAlarmExEnable.CheckBox.Checked := b = 1;
  ExtReAlarmTimeEdit.Text := IntToStr(j);
end;

procedure TSetACONISF.FormDestroy(Sender: TObject);
begin
  FACONISSystemInof.Free;
end;

procedure TSetACONISF.SetIniSectionValue(AValue: integer);
begin
end;

end.
