unit UnitCmdExecService;

interface

uses System.SysUtils, System.Classes,
  mormot.core.base, mormot.core.unicode, mormot.soa.core, mormot.rest.http.client,
  mormot.orm.core,
  UnitInterfaceHTTPManager2, UnitCommonWSInterface2,
  UnitHttpModule2;

type
  THttpCmdExecService = class(TObject)
  strict private
    FClient: TRestHttpClient;
  public
    constructor Create(const AServerURI: RawUtf8; const AServerPort: RawUtf8);
    destructor Destroy; override;
    function InitializeServices: Boolean;

    property Client: TRestHttpClient read FClient;
  end;

function MakeCommand4Server(ACommand, AParam: RawUTF8): RawUTF8;
function SendReq2Server_Http(AIpAddress, APort, ARoot: string; ACommand, AParam: RawUTF8): RawUTF8;

//function SendReqTaskInfo_Http(AIpAddress: string; ASearchRec: RawUTF8): RawUTF8;
//function SendReqTaskDetail_Http(AIpAddress: string; AIDList: RawUTF8): RawUTF8;
//function SendReqTaskEmailList_Http(AIpAddress: string; ATaskID: RawUTF8): RawUTF8;
//function SendReqTaskEmailContent_Http(AIpAddress: string; ACommand4OL: RawUTF8): RawUTF8;

implementation

uses UnitBase64Util2, CommonData2;

function MakeCommand4Server(ACommand, AParam: RawUTF8): RawUTF8;
var
  LStrList: TStringList;
  LStr: string;
begin
  LStrList := TStringList.Create;
  try
    LStrList.Add('Command=' + ACommand);
    LStrList.Add('Parameter=' + AParam);
    Result := StringToUTF8(LStrList.Text);
    Result := MakeRawUTF8ToBin64(Result);
  finally
    LStrList.Free;
  end;
end;

function SendReq2Server_Http(AIpAddress, APort, ARoot: string; ACommand, AParam: RawUTF8): RawUTF8;
var
  LService: ICommonWSService;
  LCommand: RawUTF8;
begin        //RCS_ROOT_NAME, RCS_DEFAULT_IP, RCS_PORT_NAME
  if HttpStart(ARoot, AIpAddress, APort) then
  begin
    try
      g_HTTPClient.FHTTPClient.ServiceDefine([ICommonWSService], sicShared);
//      g_HTTPClient.FHTTPClient.ServiceRegister([TypeInfo(ICommonWSService)], sicShared); //sicClientDriven

      try
        //g_HTTPClient.FHTTPClient.Services['Example'].Get(ExampleService);
//        I := g_HTTPClient.FHTTPClient.Service<ICommonWSService>;
        if not g_HTTPClient.FHTTPClient.Resolve(ICommonWSService, LService) then
          Exit; //=>
      except
        on E: Exception do
        begin
          LService := nil;
          exit;
        end;
      end;

      if LService <> nil then
      begin
        LCommand := MakeCommand4Server(ACommand, AParam);
        Result := LService.ServerExecute(LCommand);
      end;
    finally
      LService := nil;
      HttpStop;
    end;
  end;
end;

//function SendReqTaskInfo_Http(AIpAddress: string; ASearchRec: RawUTF8): RawUTF8;
//var
//  LCommand: RawUTF8;
//begin
//  LCommand := MakeCommand4InqManagerServer(CMD_REQ_TASK_LIST, ASearchRec);
//  Result := SendReq2InqManagerServer_Http(AIpAddress, LCommand);
//end;
//
//function SendReqTaskDetail_Http(AIpAddress: string; AIDList: RawUTF8): RawUTF8;
//var
//  LCommand: RawUTF8;
//begin
//  LCommand := MakeCommand4InqManagerServer(CMD_REQ_TASK_DETAIL, AIDList);
//  Result := SendReq2InqManagerServer_Http(AIpAddress, LCommand);
//end;
//
//function SendReqTaskEmailList_Http(AIpAddress: string; ATaskID: RawUTF8): RawUTF8;
//var
//  LCommand: RawUTF8;
//begin
//  LCommand := MakeCommand4InqManagerServer(CMD_REQ_TASK_EAMIL_LIST, ATaskID);
//  Result := SendReq2InqManagerServer_Http(AIpAddress, LCommand);
//end;
//
//function SendReqTaskEmailContent_Http(AIpAddress: string; ACommand4OL: RawUTF8): RawUTF8;
//var
//  LCommand: RawUTF8;
//begin
//  LCommand := MakeCommand4InqManagerServer(CMD_REQ_TASK_EAMIL_CONTENT, ACommand4OL);
//  Result := SendReq2InqManagerServer_Http(AIpAddress, LCommand);
//end;

{ THttpCmdExecService }

constructor THttpCmdExecService.Create(const AServerURI, AServerPort: RawUtf8);
const
  TIMEOUT: Cardinal = 2000;  // 2 sec
  ROOT_NAME_FILE = '';
begin
  inherited Create;
  FClient := TRestHttpClient.Create(AServerURI, AServerPort, TOrmModel.Create([], ROOT_NAME_FILE), False, '', '', TIMEOUT, TIMEOUT, TIMEOUT);
  FClient.Model.Owner := FClient;
end;

destructor THttpCmdExecService.Destroy;
begin
  FreeAndNil(FClient);

  inherited Destroy;
end;

function THttpCmdExecService.InitializeServices: Boolean;
begin
  Result := False;
  if FClient.SessionID > 0 then
  try
    // The check before registering the service with ServiceDefine() is only necessary because the
    // user can be changed and the initialization is executed again. This is normally not the case.
    Result := ((FClient.ServiceContainer.Info(ICommonWSService) <> Nil) or FClient.ServiceDefine([ICommonWSService], sicShared));
  except
  end;
end;

end.
