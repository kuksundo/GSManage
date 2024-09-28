unit UnitHiconSystemDBUtil;

interface

uses System.SysUtils, Vcl.Forms, Vcl.Dialogs, Registry, Windows,
  mormot.db.sql.oledb, mormot.db.sql, mormot.core.base,
  UnitChkDupIdData;

type
  THiConSystemDB = class
  public
    class function GetList2JsonFromDB(AQuery: string; ADBFileName: string=''): RawUtf8;
    class function GetResourceList2JsonFromDB(ADBFileName: string=''): RawUtf8;
    class function GetSVRList2JsonFromDB(ADBFileName: string=''): RawUtf8;
    class function GetIfAccessODBCDriverInstalled(): string;
  end;

implementation

{ THiConSystemDB }

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
    ADBFileName := 'E:\temp\system_bak.accdb';
//    ADBFileName := 'D:\ACONIS-NX\DB\system_bak.accdb';

  if not FileExists(ADBFileName) then
  begin
    ShowMessage('File not found => ' + ADBFileName);
    exit;
  end;

  LProps := TSqlDBOleDBACEConnectionProperties.Create(ADBFileName,'', '','');//'e:\temp\system_bak.accdb'
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
  LQuery := 'select SVR_NAME as RES_NAME, PIP as PMPM_PIP, SIP as PMPM_SIP from SERVER';
  Result := GetList2JsonFromDB(LQuery);
end;

end.
