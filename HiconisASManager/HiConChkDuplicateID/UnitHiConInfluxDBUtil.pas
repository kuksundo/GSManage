unit UnitHiConInfluxDBUtil;

interface

uses SysUtils, Classes, Inifiles,
  OtlCommon, OtlComm, OtlTaskControl, OtlContainerObserver, otlTask, OtlParallel,
  OtlSync,
  mormot.core.base, mormot.core.os, mormot.core.text,
  mormot.core.collections, mormot.core.variants, mormot.core.json,
  mormot.net.client, mormot.core.unicode, mormot.net.server,

  PngBitBtn, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdIOHandler,
  IdGlobal, IdHTTP;

const
  INFLUX_LOG_DB_NAME = 'logging';
  INFLUX_PORTNO = '8086';
  INFLUX_POLICY_NAME = 'autogen';
  DEFAULT_INFLUXDB_CONF_NAME = 'c:\Program Files\InfluxData\influxdb\influxdb-1.8.10-1\influxdb.conf';

type
  TInfluxRetentionPolicyRec = packed record
    name,
    duration,
    shardGroupDuration,
    replicaN,
    default:string;
  end;

  TInfluxQueryResult = packed record
    statement_id: integer;
  end;

function SendHttpGetRequest2InfluxDB(AUrlGet, AQuery: string): string;
function SendHttpPostRequest2InfluxDB(AUrl: string; AParams: TStringList): string;
function GetRetentionPoliciesFromInfluxDB(AIpAddr: string; APort: string=INFLUX_PORTNO;
  ADbName: string=INFLUX_LOG_DB_NAME): TInfluxRetentionPolicyRec;
function GetRetentionPolicies2JsonFromInfluxDB(AIpAddr: string; APort: string=INFLUX_PORTNO;
  ADbName: string=INFLUX_LOG_DB_NAME): string;

function SetRetentionPolicies4OWSFromInfluxDB(AIpAddr, ADuration, AShardDuration: string; APort: string=INFLUX_PORTNO;
  ADbName: string=INFLUX_LOG_DB_NAME; APolicyName: string=INFLUX_POLICY_NAME): string;
function GetResultRecOfSetRetentPolicy(AResult: string): TInfluxQueryResult;

//OWS는 'D:\' Historian Computer는 'E:\' 인지 Check함
function VerifyLogParamFromConf(AValue: string; AConfFileName: string=''): string;
function ModifyLogParamFromConf(AOldValue, ANewValue: string; AConfFileName: string=''): string;

implementation

uses UnitStringUtil;

function SendHttpGetRequest2InfluxDB(AUrlGet, AQuery: string): string;
var
  LHttp: TIdHttp;
  LFullUrl, LFN: string;
  LStream: TMemoryStream;
begin
  Result := '';

  LHttp := TIdHttp.Create(nil);
  try
    LFullUrl := AUrlGet + AQuery;

    Result := LHttp.Get(LFullUrl);
  finally
    LHttp.Free;
  end;
end;

function SendHttpPostRequest2InfluxDB(AUrl: string; AParams: TStringList): string;
var
  LHttp: TIdHttp;
  LFN: string;
  LStream: TMemoryStream;
begin
  Result := '';

  LHttp := TIdHttp.Create(nil);
  try
    Result := LHttp.Post(AUrl, AParams);
  finally
    LHttp.Free;
  end;
end;

function GetRetentionPoliciesFromInfluxDB(AIpAddr: string; APort, ADbName: string): TInfluxRetentionPolicyRec;
var
  LStr: string;
begin
  LStr := GetRetentionPolicies2JsonFromInfluxDB(AIpAddr);
  RecordLoadJson(Result, LStr, TypeInfo(TInfluxRetentionPolicyRec));
end;

function GetRetentionPolicies2JsonFromInfluxDB(AIpAddr: string; APort, ADbName: string): string;
var
  LUrl, LQuery, LGetResult, LStr: string;
  LDict: IDocDict;
  LList, LColList, LValueList: IDocList;
  LDoc: variant;
  i: integer;
begin
  LUrl := 'http://' + AIpAddr + ':' + APort;
//  LQuery := '/query?&pretty=true&db=' + ADbName + '&q=show%20retention%20policies%20on%20"' + APolicyName + '"';
  LQuery := '/query?&pretty=true&db=' + ADbName + '&q=show%20retention%20policies';
  LGetResult := SendHttpGetRequest2InfluxDB(LUrl, LQuery);

  if LGetResult <> '' then
  begin
    TDocVariant.New(LDoc);
    TDocVariantData(LDoc).Value['IPAddr'] := AIpAddr;
    TDocVariantData(LDoc).Value['DBName'] := ADbName;


    LDict := DocDict(LGetResult);

    LStr := LDict.S['results'];
    LList := DocList(LStr);

    LStr := LList[0].series;
    LList := DocList(LStr);

    LStr := LList[0].columns;
    LColList := DocList(LStr);//["name", "duration", "shardGroupDuration", "replicaN", "default"]

    LStr := LList[0].values;
    LValueList := DocList(LStr);//[["autogen", "0s",  "168h0m0s", 1, true]]

    LStr := LValueList[0];
    LValueList := DocList(LStr);//["autogen", "0s",  "168h0m0s", 1, true]

    for i := 0 to LColList.Len - 1 do
    begin
      TDocVariantData(LDoc).Value[LColList[i]] := LValueList[i];
    end;

    Result := LDoc;
  end;
end;

function SetRetentionPolicies4OWSFromInfluxDB(AIpAddr, ADuration, AShardDuration: string;
  APort: string=INFLUX_PORTNO; ADbName: string=INFLUX_LOG_DB_NAME;
  APolicyName: string=INFLUX_POLICY_NAME): string;
var
  LUrl, LQuery, LStr: string;
  LParams: TStringList;
begin
  Result := '';

  LParams := TStringList.Create;
  try
    LUrl := 'http://' + AIpAddr + ':' + APort + '/query?db=' + ADbName;

//    LQuery := '/write?&db=' + ADbName + '&rp=' + APolicyName;
  //   + '&q=alter%20retention%20policy%20"' + APolicyName +
  //    '"%20on%20"' + ADbName + '"%20duration%2010d';
  //  LQuery := LQuery + '&u=username&p=passwd';

    LQuery := 'ALTER RETENTION POLICY "' + APolicyName + '" ON "' + ADbName + '" DURATION ' +
      ADuration + ' SHARD DURATION ' + AShardDuration;

    LParams.Add('q=' + LQuery);

    Result := SendHttpPostRequest2InfluxDB(LUrl, LParams);
  finally
    LParams.Free;
  end;
end;

function GetResultRecOfSetRetentPolicy(AResult: string): TInfluxQueryResult;
var//{"results":[{"statement_id":0}]}
  LDict: IDocDict;
  LList: IDocList;
  LStr: string;
begin
  LDict := DocDict(AResult);

  LStr := LDict.S['results'];
  LList := DocList(LStr);

  Result.statement_id := LList[0].statement_id;
end;

function VerifyLogParamFromConf(AValue: string; AConfFileName: string): string;
var
  IniFile: TIniFile;
  LValueText: string;
begin
  Result := '';

  if AConfFileName = '' then
  begin
//    if FileExists(DEFAULT_INFLUXDB_CONF_NAME) then
//      AConfFileName := DEFAULT_INFLUXDB_CONF_NAME
//    else
    if FileExists('c:\temp\influxdb.conf') then
      AConfFileName := 'c:\temp\influxdb.conf';
  end;

  if AConfFileName = '' then
    exit;

  AValue := UpperCase(AValue);

  IniFile := TIniFile.Create(AConfFileName);
  try
    LValueText := IniFile.ReadString('meta', 'dir', '');

    if Pos(AValue, UpperCase(LValueText)) = 0 then//'D:\'
      Result := Result + '[meta]->dir value has no "' + AValue + '"' + #13#10;

    LValueText := IniFile.ReadString('data', 'dir', '');

    if Pos(AValue, UpperCase(LValueText)) = 0 then //'D:\'
      Result := Result + '[data]->dir value has no "' + AValue + '"' + #13#10;

    LValueText := IniFile.ReadString('data', 'wal-dir', '');

    if Pos(AValue, UpperCase(LValueText)) = 0 then //'D:\'
      Result := Result + '[data]->wal-dir value has no "' + AValue + '"';

    if Result = '' then
      Result := AConfFileName + '(dir value) is ' + AValue;
  finally
    IniFile.Free;
  end;
end;

function ModifyLogParamFromConf(AOldValue, ANewValue: string; AConfFileName: string=''): string;
var
  IniFile: TIniFile;
  LValueText, LOldValue, LValue: string;
begin
  Result := '';

  if AConfFileName = '' then
  begin
//    if FileExists(DEFAULT_INFLUXDB_CONF_NAME) then
//      AConfFileName := DEFAULT_INFLUXDB_CONF_NAME
//    else
    if FileExists('c:\temp\influxdb.conf') then
      AConfFileName := 'c:\temp\influxdb.conf';
  end;

  if AConfFileName = '' then
    exit;

  AOldValue := LowerCase(AOldValue);
  ANewValue := UpperCase(ANewValue);

  IniFile := TIniFile.Create(AConfFileName);
  try
    LValueText := LowerCase(IniFile.ReadString('meta', 'dir', ''));
    LOldValue := AOldValue;

    while LOldValue <> '' do
    begin
      LValue := StrToken(LOldValue, ';');

      if Pos(LValue, LValueText) > 0 then//'D:'
      begin
        LValueText := StringReplace(LValueText, LValue, ANewValue, [rfReplaceAll]);
        IniFile.WriteString('meta', 'dir', LValueText);
        Result := Result + '[meta]->dir value (' + LValue + ') is modified to "' + ANewValue + '"' + #13#10;
      end;
    end;

    LValueText := LowerCase(IniFile.ReadString('data', 'dir', ''));
    LOldValue := AOldValue;

    while LOldValue <> '' do
    begin
      LValue := StrToken(LOldValue, ';');

      if Pos(LValue, LValueText) > 0 then
      begin
        LValueText := StringReplace(LValueText, LValue, ANewValue, [rfReplaceAll]);
        IniFile.WriteString('data', 'dir', LValueText);
        Result := Result + '[data]->dir value (' + LValue + ') is modified to "' + ANewValue + '"' + #13#10;
      end;
    end;

    LValueText := LowerCase(IniFile.ReadString('data', 'wal-dir', ''));
    LOldValue := AOldValue;

    while LOldValue <> '' do
    begin
      LValue := StrToken(LOldValue, ';');

      if Pos(LValue, LValueText) > 0 then
      begin
        LValueText := StringReplace(LValueText, LValue, ANewValue, [rfReplaceAll]);
        IniFile.WriteString('data', 'wal-dir', LValueText);
        Result := Result + '[data]->wal-dir value (' + LValue + ') is modified to "' + ANewValue + '"' + #13#10;
      end;
    end;
  finally
    IniFile.Free;
  end;
end;

end.
