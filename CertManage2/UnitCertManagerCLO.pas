unit UnitCertManagerCLO;

interface
{GpCommandLine�� ����� �ȵǹǷ� �����Ͽ� ����� ��}
uses classes, SysUtils, GpCommandLineParser, Generics.Legacy;

type
{ /DelRegistry /rip:"10.1.1.1" /SkipReg /DecKind=123 /Masterpw:"xxxx"}
{Masterpw �� Reg Server�� RegcodeEdit ȭ�鿡�� MasterPasswd Label�� ��Ŭ���Ͽ� Popup���� Ŭ������ �����Ͽ� ����}
  TCommandLineOption4CertManage = class
    FRCSIPAddress, //Reg Code Server IP Address
    FRCSPort, //Reg Code Server Port No
    FMasterPwd //Master Pwd ()
    : string;

    FSkipRegCheck, //Reg check skip�� ���ؼ��� Master Passwd�� ������ �־�� ��
    FDeleteRegInfo
    : Boolean;

    FDecryptKind4SkipRegCheck //Skip Reg Check �� ��ȣ�� Decrypt�ϴ� ��� ����
    : integer;
  public
    class function CommandLineParse(var AWatchCLO: TCommandLineOption4CertManage;
      var AErrMsg: string): boolean;

    [CLPLongName('rip'), CLPDescription('/rip:"xx.xx.xx.xx"'), CLPDefault('127.0.0.1')]
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
  end;

implementation

{ TCommandLineOption4CertManage }

class function TCommandLineOption4CertManage.CommandLineParse(
  var AWatchCLO: TCommandLineOption4CertManage; var AErrMsg: string): boolean;
var
  LStr: string;
begin
  AErrMsg := '';
  AWatchCLO := TCommandLineOption4CertManage.Create;
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
