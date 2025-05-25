unit UnitHiconSystemDBUtil;

interface

uses System.SysUtils, Vcl.Forms, Vcl.Dialogs, Registry, Windows, Classes,
  Data.DB, Data.Win.ADODB,
  OtlCommon, OtlComm, OtlTaskControl, OtlContainerObserver, otlTask, OtlParallel,
  OtlSync,
  mormot.db.sql.oledb, mormot.db.sql, mormot.core.base, mormot.core.variants,
  mormot.core.unicode,
  UnitChkDupIdData, UnitHiconMPMData, UnitHiconDBData;

const
  DEFAULT_SYS_BAK_DB_NAME = 'D:\ACONIS-NX\DB\system_bak.accdb';

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

    //Result : Compname;10.1.1.1 반환함
    class function CheckComputerNameNIPAddrFromDB(const ADBFileName: string=''): string;
    class function GetServerNameNIPAddrFromDB(const ADBFileName: string=''): string;

    class function GetTagInfo2JsonByTableName_Async(AFormHandle: THandle; ATagName: string; ATableName, AFieldName: string; ADBFileName: string=''): integer;
    class function GetTagInfo2JsonAryFromTableName(ATagName, AWhereFieldName, ATableName: string; out ARowCount: integer; ADBFileName: string=''): RawUtf8;
    class function GetTagInfo2JsonAryFromMAPPINGTable(ATagName, AWhereFieldName: string; out ARowCount: integer; ADBFileName: string=''): RawUtf8;
    class function GetTagInfo2JsonAryFromTAGMSTTable(ATagName, AWhereFieldName: string; out ARowCount: integer; ADBFileName: string=''): RawUtf8;
    class function GetTagInfo2JsonAryFromINFTable(ATagName: string; out ARowCount: integer; ADBFileName: string=''): RawUtf8;

    class function GetTagDescNChIDByTagNameFromMAPPINGTable(ATagName: string; out ADesc, AChId: string; ADBFileName: string=''): Boolean;
    class function GetOrgTagNameFromMAPPINGTable(ATagName: string; ADBFileName: string=''): RawUtf8;
    //MAPPINGTable에서 조회한 결과값(JsonAry)에서 ARow 행의 TAG_NAME을 반환함
    class function GetTagNameFromJsonAryOfMAPPINGTable(const AJsonAry: RawUtf8; const ARow: integer=0): RawUtf8;
    //MAPPING_TABLE->ORG_TAG 중에 VAR_NAME이 공란이 아닌 Tag List를 반환 함
    class function GetVar2JsonAryByOrgTagFromMAPPINGTable(ATagName: string; out ARowCount: integer; ADBFileName: string=''): RawUtf8;
    //MAPPING_TABLE->VAR_NAME이 TAG_NAME과 같은 Tag List를 반환 함
    class function GetVar2JsonAryByVarNameFromMAPPINGTable(ATagName: string; out ARowCount: integer; ADBFileName: string=''): RawUtf8;

    class function GetOrgTagNameFromCONNECTIONTable(ATagName: string; ADBFileName: string=''): RawUtf8;
    class function GetVar2JsonAryByOrgTagFromConnectionTable(ATagName: string; out ARowCount: integer; ADBFileName: string=''): RawUtf8;

    class function GetFBInfo2JsonAryByFBNameFromFUNCTIONTable(AFBName: string; out ARowCount: integer; ADBFileName: string=''): RawUtf8;
    class function GetFBInfo2JsonAryByFBNameFromFUNCTIONTable_Async(AFormHandle: THandle; AFBName: string; ADBFileName: string=''): RawUtf8;
    //AWhere 조건에 만족하는 FB Info를 JsonAry로 반환 함
    class function GetFBInfo2JsonAryByWhereCondFromFUNCTIONTable(AFBName, AWhere: string; out ARowCount: integer; ADBFileName: string=''): RawUtf8;

    class function GetFBInfo2JsonAryByFBNameFromMAPPINGTable(AFBName: string; out ARowCount: integer; ADBFileName: string=''): RawUtf8;

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

    //ARootDrice : Backup Disk를 Subst로 대체할 Drive 문자
    //AHullNo_ICMS\D_Drive 를 Binding 해줌
    class function SetDDriveByHullNoUsingSubstOnVM(const AHullNo: string; const ARootDrive: string = 'D:\'): string;
  end;

implementation

uses UnitCopyData, UnitSQLUtil, UnitProcessUtil, UnitSystemUtil, UnitLanUtil,
  UnitJsonUtil, UnitHiconOWSUtil;

{ THiConSystemDB }

class function THiConSystemDB.CheckAccessDBEngineInstalledFromADODB: Boolean;
var
  ADOConnect: TADOConnection;
begin
  Result := False;

  ADOConnect := TADOConnection.Create(nil);
  try
    try
      if FileExists(DEFAULT_SYS_BAK_DB_NAME) then
      begin
//        ADOConnect.ConnectionString := 'Provider=Microsoft.ACE.OLEDB.12.0;Data Source=D:\ACONIS-NX\DB\system_bak.accdb;';
        ADOConnect.ConnectionString := 'Provider=Microsoft.ACE.OLEDB.16.0;Data Source=' + DEFAULT_SYS_BAK_DB_NAME + ';'; //D:\ACONIS-NX\DB\system_bak.accdb
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

class function THiConSystemDB.CheckComputerNameNIPAddrFromDB(
  const ADBFileName: string): string;
var
  LSvrList: RawUtf8;
begin
  LSvrList := GetSVRList2JsonFromDB(ADBFileName);
  TGPCopyData.Log2CopyData(LSvrList, 1, msgHandle4CopyData);
  Result := THiConOWS.CheckComputerNameNIPAddrFromSVRList(LSvrList);
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

class function THiConSystemDB.GetFBInfo2JsonAryByFBNameFromFUNCTIONTable(AFBName: string;
  out ARowCount: integer; ADBFileName: string): RawUtf8;
var
  LQuery, LWhereCond: string;
//  LRowCount: integer;
begin
  if AFBName = '' then
    LQuery := 'select * from FUNCTION'
  else
  begin
    LWhereCond := GetSQLWhereConditionByFieldName(AFBName);
    LQuery := 'select * from FUNCTION where FUNC_NAME ' + LWhereCond + ' order by INDEX_NO';// = "' + AFBName +
  end;

  Result := GetList2JsonFromDB(LQuery, ARowCount, ADBFileName);
end;

class function THiConSystemDB.GetFBInfo2JsonAryByFBNameFromFUNCTIONTable_Async(
  AFormHandle: THandle; AFBName, ADBFileName: string): RawUtf8;
var
  LResult: RawUtf8;
  LRowCount: integer;
begin
  Parallel.Async(
    procedure (const task: IOmniTask)
    begin
      LResult := GetFBInfo2JsonAryByFBNameFromFUNCTIONTable(AFBName, LRowCount, ADBFileName);
    end,

    Parallel.TaskConfig.OnMessage(nil).OnTerminated(
      procedure
      begin
        if LResult <> '' then
        begin
//          TGPCopyData.FFormHandle := AFormHandle;
          TGPCopyData.Log2CopyData(LResult, 2, AFormHandle, LRowCount);
        end;
      end
    )
  );
end;

class function THiConSystemDB.GetFBInfo2JsonAryByFBNameFromMAPPINGTable(
  AFBName: string; out ARowCount: integer; ADBFileName: string): RawUtf8;
var
  LQuery, LWhereCond: string;
begin
  LWhereCond := GetSQLWhereConditionByFieldName(AFBName);
  LQuery := 'select *, TAG_NAME as FIELD_NAME from MAPPING_TABLE where ORG_TAG ' + LWhereCond + ' order by TAG_NAME';// = "' + AFBName + INDEX_NO and

  Result := GetList2JsonFromDB(LQuery, ARowCount, ADBFileName);
end;

class function THiConSystemDB.GetFBInfo2JsonAryByWhereCondFromFUNCTIONTable(
  AFBName, AWhere: string; out ARowCount: integer;
  ADBFileName: string): RawUtf8;
var
  LQuery: string;
begin
  LQuery := 'select * from FUNCTION where ' + AWhere;
  Result := GetList2JsonFromDB(LQuery, ARowCount, ADBFileName);
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
    if FileExists(DEFAULT_SYS_BAK_DB_NAME) then
      ADBFileName := DEFAULT_SYS_BAK_DB_NAME
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

class function THiConSystemDB.GetOrgTagNameFromCONNECTIONTable(ATagName,
  ADBFileName: string): RawUtf8;
var
  LQuery, LWhereCond: string;
  LRowCount: integer;
  LResult: RawUtf8;
begin
  Result := '';
  LWhereCond := GetSQLWhereConditionByFieldName(ATagName);
  LQuery := 'select TOP 1 ORG_TAG from CONNECTION where TAG_NAME ' + LWhereCond;// limit 1';
  LResult := GetList2JsonFromDB(LQuery, LRowCount, ADBFileName);
  Result := GetFieldValueFromJsonAry(LResult, 'ORG_TAG');
end;

class function THiConSystemDB.GetOrgTagNameFromMAPPINGTable(ATagName,
  ADBFileName: string): RawUtf8;
var
  LQuery, LWhereCond: string;
  LRowCount: integer;
  LResult: RawUtf8;
begin
  Result := '';
  LWhereCond := GetSQLWhereConditionByFieldName(ATagName);
  LQuery := 'select TOP 1 ORG_TAG from MAPPING_TABLE where TAG_NAME ' + LWhereCond;// limit 1';
  LResult := GetList2JsonFromDB(LQuery, LRowCount, ADBFileName);
  Result := GetFieldValueFromJsonAry(LResult, 'ORG_TAG');
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

class function THiConSystemDB.GetServerNameNIPAddrFromDB(
  const ADBFileName: string): string;
var
  LSvrList: RawUtf8;
begin
  LSvrList := GetSVRList2JsonFromDB(ADBFileName);
  Result := THiConOWS.GetServerNameNIPAddrFromSVRList(LSvrList, '', '');
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

class function THiConSystemDB.GetTagDescNChIDByTagNameFromMAPPINGTable(
  ATagName: string; out ADesc, AChId: string; ADBFileName: string): Boolean;
var
  LQuery, LWhereCond: string;
  LRowCount: integer;
  LResult: RawUtf8;
begin
  Result := False;
  LWhereCond := GetSQLWhereConditionByFieldName(ATagName);
  LQuery := 'select TOP 1 DESCRIPTION, CH_ID from MAPPING_TABLE where TAG_NAME ' + LWhereCond;// limit 1';
  LResult := GetList2JsonFromDB(LQuery, LRowCount, ADBFileName);
  ADesc := GetFieldValueFromJsonAry(LResult, 'DESCRIPTION');
  AChId := GetFieldValueFromJsonAry(LResult, 'CH_ID');
  Result := True;
end;

class function THiConSystemDB.GetTagInfo2JsonAryFromINFTable(ATagName: string;
  out ARowCount: integer; ADBFileName: string): RawUtf8;
var
  LQuery, LWhereCond: string;
  LDocDict: IDocDict;
  LDocList: IDocList;
  LRowCount: integer;
begin
  LWhereCond := GetSQLWhereConditionByFieldName(ATagName);
  LQuery := 'select TAG_NAME, DESCRIPTION, RESOURCE, SLOT, DIR, TYPE, ADDR, SUB_POS from INF where TAG_NAME ' + LWhereCond;//Like "%' + ATagName + '%"';
  Result := GetList2JsonFromDB(LQuery, LRowCount, ADBFileName);

  if Result = '' then
    exit;

  LDocList := DocList(Result);
  Result := LDocList.Json;
end;

class function THiConSystemDB.GetTagInfo2JsonAryFromMAPPINGTable(ATagName, AWhereFieldName: string;
  out ARowCount: integer; ADBFileName: string): RawUtf8;
var
  LQuery,
  LWhereCond: string;
//  LRowCount: integer;
begin
  LWhereCond := GetSQLWhereConditionByFieldName(ATagName);
  LQuery := 'select TAG_NAME, DESCRIPTION, RESOURCE, RES_ID, CH_ID, DATA_TYPE, ORG_TAG, IN_OUT, INDEX_NO, FUNC_NAME, VAR_NAME, SYS_TYPE from MAPPING_TABLE where ' + AWhereFieldName + LWhereCond;//' Like "%' + ATagName + '%"';
  Result := GetList2JsonFromDB(LQuery, ARowCount, ADBFileName);
end;

class function THiConSystemDB.GetTagInfo2JsonAryFromTableName(ATagName,
  AWhereFieldName, ATableName: string; out ARowCount: integer;
  ADBFileName: string): RawUtf8;
var
  LQuery, LWhereCond: string;
begin
  LWhereCond := GetSQLWhereConditionByFieldName(ATagName);
  LQuery := 'select * from ' + ATableName + ' where ' + AWhereFieldName + LWhereCond;//' Like "%' + ATagName + '%"';
  Result := GetList2JsonFromDB(LQuery, ARowCount, ADBFileName);
end;

class function THiConSystemDB.GetTagInfo2JsonAryFromTAGMSTTable(ATagName,
  AWhereFieldName: string; out ARowCount: integer; ADBFileName: string): RawUtf8;
var
  LQuery, LWhereCond: string;
//  LRowCount: integer;
begin
  LWhereCond := GetSQLWhereConditionByFieldName(ATagName);
  LQuery := 'select * from TAG_MST where ' + AWhereFieldName + LWhereCond;//' Like "%' + ATagName + '%"';
  Result := GetList2JsonFromDB(LQuery, ARowCount, ADBFileName);
end;

class function THiConSystemDB.GetTagInfo2JsonByTableName_Async(AFormHandle: THandle; ATagName, ATableName,
  AFieldName, ADBFileName: string): integer;
var
  LResult: RawUtf8;
  LRowCount: integer;
begin
  Parallel.Async(
    procedure (const task: IOmniTask)
    begin
      if ATableName = 'MAPPING_TABLE' then
      begin
        LResult := GetTagInfo2JsonAryFromMAPPINGTable(ATagName, AFieldName, LRowCount, ADBFileName);
      end
      else
      if ATableName = 'TAG_MST' then
      begin
        LResult := GetTagInfo2JsonAryFromTAGMSTTable(ATagName, AFieldName, LRowCount, ADBFileName);
      end
      else
      if ATableName = 'INF' then
      begin
        LResult := GetTagInfo2JsonAryFromINFTable(ATagName, LRowCount, ADBFileName);
      end
      else
      begin
        LResult := GetTagInfo2JsonAryFromTableName(ATagName, AFieldName, ATableName, LRowCount, ADBFileName);
      end;
    end,

    Parallel.TaskConfig.OnMessage(nil).OnTerminated(
      procedure
      begin
//        if LResult <> '' then
//        begin
//          TGPCopyData.FFormHandle := AFormHandle;
          TGPCopyData.Log2CopyData(LResult, 1, AFormHandle, LRowCount);
//        end;
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

class function THiConSystemDB.GetTagNameFromJsonAryOfMAPPINGTable(
  const AJsonAry: RawUtf8; const ARow: integer): RawUtf8;
var
  LDocDict: IDocDict;
  LDocList: IDocList;
begin
  Result := '';
  LDocList := DocList(AJsonAry);

  if LDocList.Len > ARow then
  begin
    LDocDict := DocDict(LDocList.S[ARow]);
    Result := LDocDict.S['TAG_NAME'];
  end;
end;

class function THiConSystemDB.GetVar2JsonAryByOrgTagFromConnectionTable(
  ATagName: string; out ARowCount: integer; ADBFileName: string): RawUtf8;
var
  LQuery, LWhereCond: string;
  LResult: RawUtf8;
begin
//  LQuery := 'select distinct TAG_NAME, DESCRIPTION, RESOURCE, RES_ID, CH_ID, DATA_TYPE, ORG_TAG, IN_OUT, INDEX_NO, FUNC_NAME, VAR_NAME, SYS_TYPE from MAPPING_TABLE where VAR_NAME = "' + ATagName + '"'; // + '" and VAR_NAME <> "" and VAR_NAME IS NOT NULL';
  LWhereCond := GetSQLWhereConditionByFieldName(ATagName);
  LQuery := 'select * from [CONNECTION] where ORG_TAG ' + LWhereCond + ' order by TAG_NAME, T00'; //group by TAG_NAME
  Result := GetList2JsonFromDB(LQuery, ARowCount, ADBFileName);
end;

class function THiConSystemDB.GetVar2JsonAryByOrgTagFromMAPPINGTable(ATagName: string;
  out ARowCount: integer; ADBFileName: string): RawUtf8;
var
  LQuery, LWhereCond: string;
  LResult: RawUtf8;
begin
  Result := '';
//  ATagName := System.SysUtils.Trim(ATagName);
  LResult := GetOrgTagNameFromMAPPINGTable(ATagName, ADBFileName);

  //조회 데이터가 없으면 % 구문을 이용해 재검색함
  if LResult = '' then
  begin
    if Pos('%', ATagName) = 0 then
    begin
      ATagName := '%' + ATagName + '%';
      LResult := GetOrgTagNameFromMAPPINGTable(ATagName, ADBFileName);
    end;
  end;

  if LResult <> '' then
  begin
    LQuery := 'select TAG_NAME, DESCRIPTION, RESOURCE, RES_ID, CH_ID, DATA_TYPE, ORG_TAG, IN_OUT, INDEX_NO, FUNC_NAME, VAR_NAME, SYS_TYPE from MAPPING_TABLE where ORG_TAG = "' + LResult+ '"'; // + '" and VAR_NAME <> "" and VAR_NAME IS NOT NULL';
    Result := GetList2JsonFromDB(LQuery, ARowCount, ADBFileName);
  end;
end;

class function THiConSystemDB.GetVar2JsonAryByVarNameFromMAPPINGTable(
  ATagName: string; out ARowCount: integer; ADBFileName: string): RawUtf8;
var
  LQuery, LWhereCond: string;
  LResult: RawUtf8;
begin
  LQuery := 'select TAG_NAME, DESCRIPTION, RESOURCE, RES_ID, CH_ID, DATA_TYPE, ORG_TAG, IN_OUT, INDEX_NO, FUNC_NAME, VAR_NAME, SYS_TYPE from MAPPING_TABLE where VAR_NAME = "' + ATagName + '"'; // + '" and VAR_NAME <> "" and VAR_NAME IS NOT NULL';
  Result := GetList2JsonFromDB(LQuery, ARowCount, ADBFileName);
end;

class function THiConSystemDB.SetDDriveByHullNoUsingSubstOnVM(const AHullNo,
  ARootDrive: string): string;
var
  LCommand, LMappedDir: string;
  LOutput: TStringList;
begin
  Result := '';

  LOutput := TStringList.Create;
  try
    LCommand := 'subst';

    if GetConsoleOutput2(LCommand, LOutput, LOutput) then
    begin
      LCommand := LOutput.Text;

      if Pos(ARootDrive + ':', LCommand) > 0 then
      begin
        LCommand := 'subst ' + ARootDrive + ': /d';
        ExecNewProcess(LCommand, True);
      end;

      LOutput.Clear;
      LMappedDir := '"\\vmware-host\Shared Folders\HiCONIS\' + AHullNo + '_ICMS\D_Drive"';
      LCommand := 'subst ' + ARootDrive + ': ' + LMappedDir;
      GetConsoleOutput2(LCommand, LOutput, LOutput);
      Result := LOutput.Text;

      if Result = '' then
        Result := ARootDrive + ':\ is mapped to ' + LMappedDir;
    end;
  finally
    LOutput.Free;
  end;

//  ExecNewProcess(LCommand, True);
end;

end.
