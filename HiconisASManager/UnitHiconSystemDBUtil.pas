unit UnitHiconSystemDBUtil;

interface

uses System.SysUtils, Vcl.Forms, Vcl.Dialogs, Registry, Windows, Data.DB, Data.Win.ADODB,
  OtlCommon, OtlComm, OtlTaskControl, OtlContainerObserver, otlTask, OtlParallel,
  OtlSync,
  mormot.db.sql.oledb, mormot.db.sql, mormot.core.base, mormot.core.variants,
  UnitChkDupIdData, UnitHiconMPMData, UnitHiconDBData;

type
  THiConSystemDB = class
  public
    //작동 안됨-20250110
    class function CheckAccessDBEngineInstalledFromADODB(): Boolean;
    class function GetSystemDBFileNameByBaseDir(ABaseDir: string): string;
    class function GetList2JsonFromDB(const AQuery: string; out ARowCount: integer; ADBFileName: string=''): RawUtf8;
    class function GetResourceList2JsonFromDB(ADBFileName: string=''): RawUtf8;
    class function GetSVRList2JsonFromDB(ADBFileName: string=''): RawUtf8;
    class function GetHistoryStationInfo2JsonFromDB(ADBFileName: string=''): RawUtf8;
    class function GetDataType2JsonAryFromDB(ADBFileName: string=''): RawUtf8;
    class function GetDataType2JsonFromDB(ADBFileName: string=''): RawUtf8;
    class function GetSystemType2JsonAryFromDB(ADBFileName: string=''): RawUtf8;
    class function GetSystemType2JsonFromDB(ADBFileName: string=''): RawUtf8;

    class function GetTagInfo2JsonByTableName_Async(AFormHandle: THandle; ATagName: string; ATableName, AFieldName: string; ADBFileName: string=''): integer;
    class function GetTagInfo2JsonAryFromMAPPINGTable(ATagName, AWhereFieldName: string; ADBFileName: string=''): RawUtf8;
    class function GetTagInfo2JsonAryFromTAGMSTTable(ATagName, AWhereFieldName: string; ADBFileName: string=''): RawUtf8;
    class function GetTagInfo2JsonAryFromINFTable(ATagName: string; ADBFileName: string=''): RawUtf8;

    class function GetTagInfo2RecFromINFTable(ATagName: string; ADBFileName: string=''): TTagInfoRec_INF;
    class function GetTagInfo2JsonFromINFTable(ATagName: string; ADBFileName: string=''): RawUtf8;
    class function GetChInfo2JsonFromChannelTable(ATagName: string; ADBFileName: string=''): RawUtf8;
    //IOC Table에서 AMPMName에 연결된 COM Card List 조회함
    //AMPMName: MPM11/FBM11
    //Result: COM011* list
    class function GetCOMCardNameListFromIOCTableByMPMName(AMPMName, ADBFileName: string): RawUtf8;

    //MPM Name으로 IP 주소 가져옴
    class function GetIPAddr2JsonFromRESTable(AResName: string; ADBFileName: string=''): RawUtf8;

    class function GetIfAccessODBCDriverInstalled(): string;
  end;

implementation

uses UnitCopyData;

{ THiConSystemDB }

class function THiConSystemDB.CheckAccessDBEngineInstalledFromADODB: Boolean;
var
  ADOConnect: TADOConnection;
begin
  Result := False;

  ADOConnect := TADOConnection.Create(nil);
  try
    try
      if FileExists('D:\ACONIS-NX\DB\system_bak.accdb') then
      begin
//        ADOConnect.ConnectionString := 'Provider=Microsoft.ACE.OLEDB.12.0;Data Source=D:\ACONIS-NX\DB\system_bak.accdb;';
        ADOConnect.ConnectionString := 'Provider=Microsoft.ACE.OLEDB.16.0;Data Source=D:\ACONIS-NX\DB\system_bak.accdb;';
        ADOConnect.LoginPrompt := False;
        ADOConnect.Connected := True;
        Result := True;
      end;
    except
      on E: Exception do
        Result := False; //Provider not installed or invalid
    end;
  finally
    ADOConnect.Free;
  end;
end;

class function THiConSystemDB.GetChInfo2JsonFromChannelTable(ATagName,
  ADBFileName: string): RawUtf8;
var
  LQuery: string;
  LDocDict: IDocDict;
  LDocList: IDocList;
  LRowCount: integer;
begin
  Result := '';

  LQuery := 'select TAG_NAME, DESCRIPTION, RESOURCE, CARD, POINT, TYPE, FUNC_NAME from INF where TAG_NAME = "' + ATagName + '"';
  Result := GetList2JsonFromDB(LQuery, LRowCount, ADBFileName);

  LDocList := DocList(Result);

  for LDocDict in LDocList do
  begin
    Result := LDocDict.Json;
    exit;
  end;
end;

class function THiConSystemDB.GetCOMCardNameListFromIOCTableByMPMName(
  AMPMName, ADBFileName: string): RawUtf8;
var
  LQuery: string;
  LRowCount: integer;
begin
//  LQuery := 'select CODE from IOC where RESOURCE = "' + AMPMName + '" and CODE Like "COM*"' ;
  LQuery := 'select CODE from IOC where RESOURCE = "' + AMPMName + '" and CODE Like "COM%"' ;
//  LQuery := 'select CODE from IOC where RESOURCE = "' + AMPMName + '"' ;
  Result := GetList2JsonFromDB(LQuery, LRowCount, ADBFileName);
end;

class function THiConSystemDB.GetDataType2JsonAryFromDB(
  ADBFileName: string): RawUtf8;
var
  LQuery: string;
  LRowCount: integer;
begin
  LQuery := 'select Value, Text, Category, ValueID from DataTypes';
  Result := GetList2JsonFromDB(LQuery, LRowCount, ADBFileName);
end;

class function THiConSystemDB.GetDataType2JsonFromDB(
  ADBFileName: string): RawUtf8;
var
  LList: IDocList;
  LDict, LDict2: IDocDict;
  i: integer;
begin
  Result := GetDataType2JsonAryFromDB(ADBFileName);

  LDict2 := DocDict('{}');
  LList := DocList(Result);

  for i := 0 to LList.Len - 1 do
  begin
    LDict := DocDict(LList.S[i]);
    LDict2.S[LDict.S['Value']] := LDict.S['Text'];
  end;

  Result := LDict2.Json;
end;

class function THiConSystemDB.GetHistoryStationInfo2JsonFromDB(
  ADBFileName: string): RawUtf8;
var
  LQuery: string;
  LDocDict: IDocDict;
  LDocList: IDocList;
  LRowCount: integer;
begin
  LQuery := 'select SVR_NAME as RES_NAME, PIP as PMPM_PIP, SIP as PMPM_SIP, DESCRIPTION from SERVER where DESCRIPTION = "HISTORY STATION"';
  Result := GetList2JsonFromDB(LQuery, LRowCount, ADBFileName);

  LDocList := DocList(Result);

  for LDocDict in LDocList do
  begin
    Result := LDocDict.Json;
    exit;
  end;
end;

class function THiConSystemDB.GetIfAccessODBCDriverInstalled: string;
var
  Reg: TRegistry;
begin
  Result := '';
  Reg := TRegistry.Create(KEY_READ);
  try
    // Specify the path to the ODBC drivers in the registry
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKeyReadOnly('SOFTWARE\ODBC\ODBCINST.INI\ODBC Drivers') then
    begin
      // Check if the Microsoft Access Driver is listed
      if Reg.ValueExists('Microsoft Access Driver (*.mdb, *.accdb)') then
      begin
        Result := '';
      end;
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

class function THiConSystemDB.GetIPAddr2JsonFromRESTable(AResName,
  ADBFileName: string): RawUtf8;
var
  LQuery: string;
  LDocDict: IDocDict;
  LDocList: IDocList;
  LRowCount: integer;
begin
  LQuery := 'select RES_NAME, CAB_ID, DESCRIPTION, PMPM_PIP, PMPM_SIP, SMPM_PIP, SMPM_SIP, SUB_POS from RESOURCE where RES_NAME = "' + AResName + '"';
  Result := GetList2JsonFromDB(LQuery, LRowCount, ADBFileName);

  LDocList := DocList(Result);

  for LDocDict in LDocList do
  begin
    Result := LDocDict.Json;
    exit;
  end;
end;

class function THiConSystemDB.GetList2JsonFromDB(const AQuery: string;
  out ARowCount: integer; ADBFileName: string): RawUtf8;
var
  LProps: TOleDBConnectionProperties;
  LConn: TSQLDBConnection;
  LQuery: TSQLDBStatement;
begin
  Result := '';
  ARowCount := 0;

  if AQuery = '' then
    exit;

  if ADBFileName = '' then
  begin
    if FileExists('D:\ACONIS-NX\DB\system_bak.accdb') then
      ADBFileName := 'D:\ACONIS-NX\DB\system_bak.accdb'
    else
    if FileExists('E:\temp\system_bak.accdb') then
      ADBFileName := 'E:\temp\system_bak.accdb';
  end;

  if not FileExists(ADBFileName) then
  begin
    ShowMessage('File not found => ' + ADBFileName);
    exit;
  end;

  LProps := TSqlDBOleDBACEConnectionProperties.Create(ADBFileName,'', '','');
  try
    LConn := LProps.NewConnection;
    try
      LConn.Connect;

      LQuery := LConn.NewStatement;
      try
        LQuery.Execute(AQuery, True);
        Result := LQuery.FetchAllAsJson(True);

        ARowCount := LQuery.TotalRowsRetrieved;

        if ARowCount = 0 then
          Result := '';

      finally
        LQuery.Free;
      end;
    finally
      LConn.Free;
    end;
  finally
    LProps.Free;
  end;
end;

class function THiConSystemDB.GetResourceList2JsonFromDB(
  ADBFileName: string): RawUtf8;
var
  LQuery: string;
  LRowCount: integer;
begin
  LQuery := 'select RES_NAME, PMPM_PIP, PMPM_SIP from RESOURCE';
  Result := GetList2JsonFromDB(LQuery, LRowCount);
end;

class function THiConSystemDB.GetSVRList2JsonFromDB(
  ADBFileName: string): RawUtf8;
var
  LQuery: string;
  LRowCount: integer;
begin
  LQuery := 'select SVR_NAME as RES_NAME, PIP as PMPM_PIP, SIP as PMPM_SIP, DESCRIPTION from SERVER';
  Result := GetList2JsonFromDB(LQuery, LRowCount);
end;

class function THiConSystemDB.GetSystemDBFileNameByBaseDir(
  ABaseDir: string): string;
begin
  if UpperCase(ABaseDir) = 'D:\' then
  begin
    Result := ABaseDir + 'ACONIS-NX\DB\system_bak.accdb'
  end
  else
  begin
    Result := ABaseDir + 'D_Drive\ACONIS-NX\DB\system_bak.accdb';
  end;
end;

class function THiConSystemDB.GetSystemType2JsonAryFromDB(
  ADBFileName: string): RawUtf8;
var
  LQuery: string;
  LRowCount: integer;
begin
  LQuery := 'select SYS_TYPE, SYS_NAME, DESCRIPTION, SHARED from SystemType';
  Result := GetList2JsonFromDB(LQuery, LRowCount, ADBFileName);
end;

class function THiConSystemDB.GetSystemType2JsonFromDB(
  ADBFileName: string): RawUtf8;
var
  LList: IDocList;
  LDict, LDict2: IDocDict;
  i: integer;
begin
  Result := GetSystemType2JsonAryFromDB(ADBFileName);

  LDict2 := DocDict('{}');
  LList := DocList(Result);

  for i := 0 to LList.Len - 1 do
  begin
    LDict := DocDict(LList.S[i]);
    LDict2.S[LDict.S['SYS_TYPE']] := LDict.S['SYS_NAME'];
  end;

  Result := LDict2.Json;
end;

class function THiConSystemDB.GetTagInfo2JsonAryFromINFTable(ATagName,
  ADBFileName: string): RawUtf8;
var
  LQuery: string;
  LDocDict: IDocDict;
  LDocList: IDocList;
  LRowCount: integer;
begin
  LQuery := 'select TAG_NAME, DESCRIPTION, RESOURCE, SLOT, DIR, TYPE, ADDR, SUB_POS from INF where TAG_NAME Like "%' + ATagName + '%"';
  Result := GetList2JsonFromDB(LQuery, LRowCount, ADBFileName);

  if Result = '' then
    exit;

  LDocList := DocList(Result);
  Result := LDocList.Json;
end;

class function THiConSystemDB.GetTagInfo2JsonAryFromMAPPINGTable(ATagName, AWhereFieldName,
  ADBFileName: string): RawUtf8;
var
  LQuery: string;
//  LDocDict: IDocDict;
//  LDocList: IDocList;
  LRowCount: integer;
begin
  LQuery := 'select TAG_NAME, DESCRIPTION, RESOURCE, RES_ID, CH_ID, DATA_TYPE, ORG_TAG, IN_OUT, INDEX_NO, FUNC_NAME, VAR_NAME, SYS_TYPE from MAPPING_TABLE where ' + AWhereFieldName + ' Like "%' + ATagName + '%"';
  Result := GetList2JsonFromDB(LQuery, LRowCount, ADBFileName);

//  if Result = '' then
//    exit;

//  LDocList := DocList(Result);
//  Result := LDocList.Json;

//  if LRowCount > 1 then
//  begin
//  end
//  else
//  begin
//    LDocDict := DocDict(Result);
//    Result := LDocDict.Json;
//  end;
end;

class function THiConSystemDB.GetTagInfo2JsonAryFromTAGMSTTable(ATagName,
  AWhereFieldName, ADBFileName: string): RawUtf8;
var
  LQuery: string;
  LRowCount: integer;
begin
  LQuery := 'select * from TAG_MST where ' + AWhereFieldName + ' Like "%' + ATagName + '%"';
  Result := GetList2JsonFromDB(LQuery, LRowCount, ADBFileName);
end;

class function THiConSystemDB.GetTagInfo2JsonByTableName_Async(AFormHandle: THandle; ATagName, ATableName,
  AFieldName, ADBFileName: string): integer;
var
  LResult: RawUtf8;
begin
  Parallel.Async(
    procedure (const task: IOmniTask)
    begin
      if ATableName = 'MAPPING_TABLE' then
      begin
        LResult := GetTagInfo2JsonAryFromMAPPINGTable(ATagName, AFieldName, ADBFileName);
      end
      else
      if ATableName = 'TAG_MST' then
      begin
        LResult := GetTagInfo2JsonAryFromTAGMSTTable(ATagName, AFieldName, ADBFileName);
      end
      else
      if ATableName = 'INF' then
      begin
        LResult := GetTagInfo2JsonAryFromINFTable(ATagName,  ADBFileName);
      end;
    end,

    Parallel.TaskConfig.OnMessage(nil).OnTerminated(
      procedure
      begin
        if LResult <> '' then
        begin
//          TGPCopyData.FFormHandle := AFormHandle;
          TGPCopyData.Log2CopyData(LResult, 1, AFormHandle);
        end;
      end
    )
  );
end;

class function THiConSystemDB.GetTagInfo2JsonFromINFTable(ATagName,
  ADBFileName: string): RawUtf8;
var
  LQuery: string;
  LDocDict: IDocDict;
  LDocList: IDocList;
  LRowCount: integer;
begin
  LQuery := 'select TAG_NAME, DESCRIPTION, RESOURCE, SLOT, DIR, TYPE, ADDR, SUB_POS from INF where TAG_NAME Like "%' + ATagName + '%"';
  Result := GetList2JsonFromDB(LQuery, LRowCount, ADBFileName);

  if Result = '' then
    exit;

  LDocList := DocList(Result);

  for LDocDict in LDocList do
  begin
    Result := LDocDict.Json;
    exit;
  end;
end;

class function THiConSystemDB.GetTagInfo2RecFromINFTable(ATagName,
  ADBFileName: string): TTagInfoRec_INF;
var
  LJson: RawUtf8;
begin
  LJson := GetTagInfo2JsonFromINFTable(ATagName);
  Result := GetTagInfoRec_INFFromJson(Utf8ToString(LJson));
end;

end.
