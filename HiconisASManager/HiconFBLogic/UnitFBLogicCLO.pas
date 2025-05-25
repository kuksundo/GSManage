unit UnitFBLogicCLO;

interface

{GpCommandLine은 상속이 안되므로 복사하여 사용할 것}
uses classes, SysUtils, GpCommandLineParser;

type
  TCLO4FBLogic = class //CommandLineOption
    FProdCode64,
    FAppSigInfo64,
    FTagName,
    FDBName
    : string;
    FExitApp,
    FDeleteAppSigInfo,
    FCreateAppSigInfoFile: Boolean;
  public
    class var FRegAppInfoB64: string;
    class function CommandLineParse(var AFBLogicCLO: TCLO4FBLogic;
      var AErrMsg: string): boolean;

    [CLPLongName('tn'), CLPDescription('tagname'), CLPDefault('')]
    property TagName: string read FTagName write FTagName;
    [CLPLongName('db'), CLPDescription('Full path DB Name'), CLPDefault('D:\ACONIS-NX\DB\system_bak.accdb')]
    property DBName: string read FDBName write FDBName;

    [CLPLongName('pc'), CLPDescription('Product Code Base64'), CLPDefault('')]
    property ProdCode64: string read FProdCode64 write FProdCode64;
    [CLPLongName('ai'), CLPDescription('AppSigInfo Base64'), CLPDefault('')]
    property AppSigInfo64: string read FAppSigInfo64 write FAppSigInfo64;
    [CLPLongName('da'), CLPDescription('Delete AppSigInfo')]
    property DeleteAppSigInfo: Boolean read FDeleteAppSigInfo write FDeleteAppSigInfo;
    [CLPLongName('caf'), CLPDescription('Create AppSigInfo File')]
    property CreateAppSigInfoFile: Boolean read FCreateAppSigInfoFile write FCreateAppSigInfoFile;
    [CLPLongName('ea'), CLPDescription('Exit App')]
    property ExitApp: Boolean read FExitApp write FExitApp;
  end;

implementation

{ TCLO4FBLogic }

class function TCLO4FBLogic.CommandLineParse(var AFBLogicCLO: TCLO4FBLogic;
  var AErrMsg: string): boolean;
var
  LStr: string;
begin
  AErrMsg := '';
  AFBLogicCLO := TCLO4FBLogic.Create;
  try
//      CommandLineParser.Options := [opIgnoreUnknownSwitches];
    Result := CommandLineParser.Parse(AFBLogicCLO);
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
