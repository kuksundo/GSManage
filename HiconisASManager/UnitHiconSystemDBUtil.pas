unit UnitHiconSystemDBUtil;

interface

uses System.SysUtils, Vcl.Forms, Vcl.Dialogs,
  mormot.db.sql.oledb, mormot.db.sql, mormot.core.base,
  UnitChkDupIdData;

type
  THiConSystemDB = class
  public
    class function GetResourceList2JsonFromDB(ADBFileName: string=''): RawUtf8;
    class function GetSVRList2JsonFromDB(ADBFileName: string=''): RawUtf8;
  end;

implementation

{ THiConSystemDB }

class function THiConSystemDB.GetResourceList2JsonFromDB(
  ADBFileName: string): RawUtf8;
var
  LProps: TOleDBConnectionProperties;
  LConn: TSQLDBConnection;
  LQuery: TSQLDBStatement;
begin
  Result := '';

  if ADBFileName = '' then
    ADBFileName := 'D:\ACONIS-NX\DB\system_bak.accdb';
//    ADBFileName := 'E:\temp\system_bak.accdb';

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
        LQuery.Execute('select RES_NAME, PMPM_PIP, PMPM_SIP from RESOURCE', True);
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

class function THiConSystemDB.GetSVRList2JsonFromDB(
  ADBFileName: string): RawUtf8;
var
  LProps: TOleDBConnectionProperties;
  LConn: TSQLDBConnection;
  LQuery: TSQLDBStatement;
begin
  Result := '';

  if ADBFileName = '' then
    ADBFileName := 'D:\ACONIS-NX\DB\system_bak.accdb';

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
        LQuery.Execute('select SVR_NAME, DESCRIPTION, PIP, SIP from SERVER', True);
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

end.
