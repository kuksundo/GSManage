unit UnitHiconOWSUtil;

interface

uses System.SysUtils, Vcl.Forms, Vcl.Dialogs, Registry, Windows, Classes,
  UnitHiconMariaDBUtil;

type
  THiConOWS = class
  public
    class function CheckAdminAutoLogin(): Boolean;
    class function GetOWSAdminPasswd(): string;
    class function GetOWSEncryptedAdminPasswd(): string;
    class function CheckDefaultHiconisFolderExist(): Boolean;
    class function CheckAccessDBEngineInstalledFromRegistry(): Boolean;
    //AccessDB Engine�� File
    class function CheckMsoFileNotExistFromRegistry(): Boolean;
    class function CheckMariaDBInstalledFromService(): Boolean;
    class function GetMariaDBRootPasswd(): string;
    class function GetMariaDBEncryptedRootPasswd(): string;
    class function CheckDataBaseExistOnMariaDByName(const AHostIp, APort, ADataBaseName: string;
      AUserId: string=''; AEncryptedPasswd: string=''; AHiconDB: THiConMariaDB=nil): Boolean;
    class function GetODBCDSNListFromRegistry(const AIsODBC32bit: Boolean=true; const AIsSystemDSN: Boolean=true): TStringList;
    class function CheckODBCDSNExistFromRegistryByName(const ADSN: string; const AIsODBC32bit: Boolean=true; const AIsSystemDSN: Boolean=true): Boolean;
  end;

implementation

uses UnitSystemUtil, UnitServiceUtil, UnitCryptUtil3;

{ THiConOWS }

class function THiConOWS.CheckAccessDBEngineInstalledFromRegistry: Boolean;
var
  Reg: TRegistry;
begin
  Result := False;
  Reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    // Check for 64-bit Access DB Engine
    if Reg.OpenKeyReadOnly('SOFTWARE\Microsoft\Office\16.0\Access Connectivity Engine\Engines') then
      Exit(True);

    // Check for 32-bit Access DB Engine on a 64-bit system
    if Reg.OpenKeyReadOnly('SOFTWARE\WOW6432NodeMicrosoft\Office\16.0\Access Connectivity Engine\Engines') then
      Exit(True);

    // Check for older versions (adjust version number if needed);
    if Reg.OpenKeyReadOnly('SOFTWARE\Microsoft\Office\14.0\Access Connectivity Engine\Engines') or
        Reg.OpenKeyReadOnly('SOFTWARE\WOW6432NodeMicrosoft\Office\14.0\Access Connectivity Engine\Engines') then
      Exit(True);
  finally
    Reg.Free;
  end;
end;

class function THiConOWS.CheckAdminAutoLogin: Boolean;
begin
  //HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\AutoAdminLogon = '1' ���� Ȯ��
  Result := IsWindowsAdminAutoLoginEnabled();
end;

class function THiConOWS.CheckDataBaseExistOnMariaDByName(const AHostIp, APort,
  ADataBaseName: string; AUserId, AEncryptedPasswd: string; AHiconDB: THiConMariaDB): Boolean;
var
  LHiConMariaDB: THiConMariaDB;
  LLocalCreated: Boolean;
begin
  LLocalCreated := False;
  Result := False;

  if AUserId = '' then
    AUserId := 'root';

  if AEncryptedPasswd = '' then
    AEncryptedPasswd := GetMariaDBEncryptedRootPasswd();

  if Assigned(AHiconDB) then
    LHiConMariaDB := AHiconDB
  else
  begin
    LHiConMariaDB := THiConMariaDB.Create;
    LLocalCreated := True;
  end;

  LHiConMariaDB.CreateDB(AHostIp, APort, 'mysql', AUserId, AEncryptedPasswd);
  Result := LHiConMariaDB.CheckDataBaseExistByName(ADataBaseName);

  if LLocalCreated then
  begin
    LHiConMariaDB.DestroyDB();
    FreeAndNil(LHiConMariaDB);
  end;
end;

class function THiConOWS.CheckDefaultHiconisFolderExist: Boolean;
begin
  Result := DirectoryExists('D:\ACONIS-NX');
end;

class function THiConOWS.CheckMariaDBInstalledFromService: Boolean;
begin
  Result := IsServiceInstalledByName('MariaDB') or IsServiceInstalledByName('MySQL');
end;

class function THiConOWS.CheckMsoFileNotExistFromRegistry: Boolean;
var
  Reg: TRegistry;
begin
  Result := False;
  Reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    // Check for 64-bit Access DB Engine
    if Reg.OpenKeyReadOnly('SOFTWARE\Microsoft\Office\14.0\Common\FilesPaths') then
    begin
      // Check if mso.dll is exist
      if not Reg.ValueExists('mso.dll') then
      begin
        Result := True;
      end;
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

class function THiConOWS.CheckODBCDSNExistFromRegistryByName(const ADSN: string;
  const AIsODBC32bit, AIsSystemDSN: Boolean): Boolean;
var
  LList: TStringList;
  LStr, LStr2: string;
begin
  Result := False;
  LList := GetODBCDSNListFromRegistry(AIsODBC32bit, AIsSystemDSN);
  try
    for LStr in LList do
    begin
      LStr2 := UpperCase(LStr);

      if LStr2 = UpperCase(ADSN) then
      begin
        Result := True;
        Break;
      end;
    end;
  finally
    LList.Free;
  end;
end;

class function THiConOWS.GetMariaDBEncryptedRootPasswd: string;
begin
  //Encrypt : MakeEncrypNBase64String
  //DeCrypt : MakeUnBase64NDecryptString
  Result := 'pkZRgQCmRlGBdmViY2Zkc29BWi9KWTJiRjZWZ2FJdz09'; //"aconis"
end;

class function THiConOWS.GetMariaDBRootPasswd: string;
begin
  Result := MakeUnBase64NDecryptString(GetMariaDBEncryptedRootPasswd()); //"aconis"
end;

class function THiConOWS.GetODBCDSNListFromRegistry(const AIsODBC32bit, AIsSystemDSN: Boolean): TStringList;
var
  Reg: TRegistry;
  LRegPath: string;
begin
  Result := TStringList.Create;

  Reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    if AIsSystemDSN then
      Reg.RootKey := HKEY_LOCAL_MACHINE
    else
      Reg.RootKey := HKEY_CURRENT_USER;

    if AIsODBC32bit then
      LRegPath := 'SOFTWARE\Wow6432Node\ODBC\ODBCINST.INI\'
    else
      LRegPath := 'SOFTWARE\ODBC\ODBCINST.INI\';

    if Reg.OpenKeyReadOnly(LRegPath) then
    begin
      Reg.GetKeyNames(Result);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;


end;

class function THiConOWS.GetOWSAdminPasswd: string;
begin
  Result := MakeUnBase64NDecryptString(GetOWSEncryptedAdminPasswd()); //"aconis"
end;

class function THiConOWS.GetOWSEncryptedAdminPasswd: string;
begin
  //Encrypt : MakeEncrypNBase64String
  //DeCrypt : MakeUnBase64NDecryptString
  Result := 'kRA9igCRED2KdE8zYWN0RTBaZnl3Ym12STVGVVhMZz09'; //"hhiaconis"
end;

end.
