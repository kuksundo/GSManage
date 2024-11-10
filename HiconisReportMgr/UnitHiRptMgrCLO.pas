unit UnitHiRptMgrCLO;

interface
{GpCommandLine�� ����� �ȵǹǷ� �����Ͽ� ����� ��}
uses classes, SysUtils, GpCommandLineParser, Generics.Legacy,
  mormot.core.base;

type
{ /DelRegistry /rip:"10.1.1.1" /SkipReg /DecKind=123 /Masterpw:"xxxx"}
{Masterpw �� Reg Server�� RegcodeEdit ȭ�鿡�� MasterPasswd Label�� ��Ŭ���Ͽ� Popup���� Ŭ������ �����Ͽ� ����}
  TCLO4HiRptMgr = class
    FRCSIPAddress, //Reg Code Server IP Address
    FRCSPort, //Reg Code Server Port No
    FMasterPwd, //Master Pwd ()
    FAppSigInfoBase64 //TAppSigInfoRec Json base64
    : string;

    FSkipRegCheck, //Reg check skip�� ���ؼ��� Master Passwd�� ������ �־�� ��
    FDeleteRegInfo
    : Boolean;

    FDecryptKind4SkipRegCheck, //Skip Reg Check �� ��ȣ�� Decrypt�ϴ� ��� ����
    FBuildExpireDays,
    FExpireExecCount
    : integer;

    FBuildDate,
    FExpireDate
    : TTimeLog;
  public
    class function CommandLineParse(var AWatchCLO: TCLO4HiRptMgr;
      var AErrMsg: string): boolean;

    [CLPLongName('rip'), CLPDescription('/rip:"xx.xx.xx.xx"'), CLPDefault('')]
    property RCSIPAddress: string read FRCSIPAddress write FRCSIPAddress;
    [CLPLongName('rport'), CLPDescription('Reg Code Server Port No'), CLPDefault('')]
    property RCSPort: string read FRCSPort write FRCSPort;
    [CLPLongName('Masterpw'), CLPDescription('Master Pwd'), CLPDefault('')]
    property MasterPwd: string read FMasterPwd write FMasterPwd;
    [CLPLongName('DelRegistry'), CLPDescription('Delete Reginfo from registry')]
    property DeleteRegInfo: boolean read FDeleteRegInfo write FDeleteRegInfo;
    [CLPLongName('SkipReg'), CLPDescription('Skip Reginfo check')]
    property SkipRegCheck: Boolean read FSkipRegCheck write FSkipRegCheck;
    [CLPName('DecKind'), CLPDescription('Decrypt Method for master passwd of Skip Reg Check'), CLPDefault('0')]
    property DecryptKind4SkipRegCheck: integer read FDecryptKind4SkipRegCheck write FDecryptKind4SkipRegCheck;
    [CLPName('bed'), CLPDescription('Build Expire Days'), CLPDefault('0')]
    property BuildExpireDays: integer read FBuildExpireDays write FBuildExpireDays;
    [CLPName('bec'), CLPDescription('Expire Exec Count'), CLPDefault('0')]
    property ExpireExecCount: integer read FExpireExecCount write FExpireExecCount;
    [CLPName('bd'), CLPDescription('Build Date'), CLPDefault('0')]
    property BuildDate: TTimeLog read FBuildDate write FBuildDate;
    [CLPName('ed'), CLPDescription('Expire Date'), CLPDefault('0')]
    property ExpireDate: TTimeLog read FExpireDate write FExpireDate;
    [CLPLongName('asi'), CLPDescription('AppSigInfoBase64'), CLPDefault('')]
    property AppSigInfoBase64: string read FAppSigInfoBase64 write FAppSigInfoBase64;
  end;

implementation

{ TCommandLineOption4CertManage }

class function TCLO4HiRptMgr.CommandLineParse(
  var AWatchCLO: TCLO4HiRptMgr; var AErrMsg: string): boolean;
var
  LStr: string;
begin
  AErrMsg := '';
  AWatchCLO := TCLO4HiRptMgr.Create;
  try
//      CommandLineParser.Options := [opIgnoreUnknownSwitches];
    Result := CommandLineParser.Parse(AWatchCLO);
  except
    on E: ECLPConfigurationError do begin
      AErrMsg := '*** Configuration error ***' + #13#10 +
        Format('%s, position = %d, name = %s',
          [E.ErrorInfo.Text, E.ErrorInfo.Position, E.ErrorInfo.SwitchName]);
      Exit;
    end;
  end;

  if not Result then
  begin
    AErrMsg := Format('%s, position = %d, name = %s',
      [CommandLineParser.ErrorInfo.Text, CommandLineParser.ErrorInfo.Position,
       CommandLineParser.ErrorInfo.SwitchName]) + #13#10;
    for LStr in CommandLineParser.Usage do
      AErrMsg := AErrMSg + LStr + #13#10;
  end
  else
  begin
  end;
end;

end.
