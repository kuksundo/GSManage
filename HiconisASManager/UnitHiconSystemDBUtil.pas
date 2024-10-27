unit UnitHiconSystemDBUtil;

interface

uses System.SysUtils, Vcl.Forms, Vcl.Dialogs, Registry, Windows,
  mormot.db.sql.oledb, mormot.db.sql, mormot.core.base, mormot.core.variants,
  UnitChkDupIdData, UnitHiconMPMData;

type
  THiConSystemDB = class
  public
    class function GetList2JsonFromDB(AQuery: string; ADBFileName: string=''): RawUtf8;
    class function GetResourceList2JsonFromDB(ADBFileName: string=''): RawUtf8;
    class function GetSVRList2JsonFromDB(ADBFileName: string=''): RawUtf8;
    class function GetHistoryStationInfo2JsonFromDB(ADBFileName: string=''): RawUtf8;
    class function GetTagInfo2JsonFromINFTable(ATagName: string; ADBFileName: string=''): RawUtf8;
    class function GetTagInfo2RecFromINFTable(ATagName: string; ADBFileName: string=''): TTagInfoRec_INF;
    class function GetChInfo2JsonFromChannelTable(ATagName: string; ADBFileName: string=''): RawUtf8;

    //MPM Name으로 IP 주소 가져옴
    class function GetIPAddr2JsonFromRESTable(AResName: string; ADBFileName: string=''): RawUtf8;

    class function GetIfAccessODBCDriverInstalled(): string;
  end;

implementation

{ THiConSystemDB }

class function THiConSystemDB.GetChInfo2JsonFromChannelTable(ATagName,
  ADBFileName: string): RawUtf8;
var
  LQuery: string;
  LDocDict: IDocDict;
  LDocList: IDocList;
begin
  Result := '';

  LQuery := 'select TAG_NAME, DESCRIPTION, RESOURCE, CARD, POINT, TYPE, FUNC_NAME from INF where TAG_NAME = "' + ATagName + '"';
  Result := GetList2JsonFromDB(LQuery, ADBFileName);

  LDocList := DocList(Result);

  for LDocDict in LDocList do
  begin
    Result := LDocDict.Json;
    exit;
  end;
end;

class function THiConSystemDB.GetHistoryStationInfo2JsonFromDB(
  ADBFileName: string): RawUtf8;
var
  LQuery: string;
  LDocDict: IDocDict;
  LDocList: IDocList;
begin
  LQuery := 'select SVR_NAME as RES_NAME, PIP as PMPM_PIP, SIP as PMPM_SIP, DESCRIPTION from SERVER where DESCRIPTION = "HISTORY STATION"';
  Result := GetList2JsonFromDB(LQuery, ADBFileName);

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
begin
  LQuery := 'select RES_NAME, CAB_ID, DESCRIPTION, PMPM_PIP, PMPM_SIP, SMPM_PIP, SMPM_SIP, SUB_POS from RESOURCE where RES_NAME = "' + AResName + '"';
  Result := GetList2JsonFromDB(LQuery, ADBFileName);

  LDocList := DocList(Result);

  for LDocDict in LDocList do
  begin
    Result := LDocDict.Json;
    exit;
  end;
end;

class function THiConSystemDB.GetList2JsonFromDB(AQuery, ADBFileName: string): RawUtf8;
var
  LProps: TOleDBConnectionProperties;
  LConn: TSQLDBConnection;
  LQuery: TSQLDBStatement;
begin
  Result := '';

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
begin
  LQuery := 'select RES_NAME, PMPM_PIP, PMPM_SIP from RESOURCE';
  Result := GetList2JsonFromDB(LQuery);
end;

class function THiConSystemDB.GetSVRList2JsonFromDB(
  ADBFileName: string): RawUtf8;
var
  LQuery: string;
begin
  LQuery := 'select SVR_NAME as RES_NAME, PIP as PMPM_PIP, SIP as PMPM_SIP, DESCRIPTION from SERVER';
  Result := GetList2JsonFromDB(LQuery);
end;

class function THiConSystemDB.GetTagInfo2JsonFromINFTable(ATagName,
  ADBFileName: string): RawUtf8;
var
  LQuery: string;
  LDocDict: IDocDict;
  LDocList: IDocList;
begin
  LQuery := 'select TAG_NAME, DESCRIPTION, RESOURCE, SLOT, DIR, TYPE, ADDR, SUB_POS from INF where TAG_NAME = "' + ATagName + '"';
  Result := GetList2JsonFromDB(LQuery, ADBFileName);

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
