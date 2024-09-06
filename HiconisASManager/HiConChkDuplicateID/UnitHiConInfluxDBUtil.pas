unit UnitHiConInfluxDBUtil;

interface

uses  Classes,
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

implementation

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

end.
