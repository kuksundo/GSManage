unit UnitHiconOWSUtil;

interface

uses System.SysUtils, Vcl.Forms, Vcl.Dialogs, Registry, Windows;

type
  THiConOWS = class
  public
    class function CheckAdminAutoLogin(): Boolean;
    class function GetOWSAdminPasswd(): string;
    class function CheckDefaultHiconisFolderExist(): Boolean;
    class function CheckAccessDBEngineInstalledFromRegistry(): Boolean;
    //AccessDB Engine용 File
    class function CheckMsoFileNotExistFromRegistry(): Boolean;
    class function CheckMariaDBInstalledFromService(): Boolean;
    class function GetMariaDBRootPasswd(): string;
  end;

implementation

uses UnitSystemUtil, UnitServiceUtil;

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
  //HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\AutoAdminLogon = '1' 여부 확인
  Result := IsWindowsAdminAutoLoginEnabled();
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

class function THiConOWS.GetMariaDBRootPasswd: string;
begin
  Result := 'aconis';
end;

class function THiConOWS.GetOWSAdminPasswd: string;
begin
  Result := 'hhiaconis';
end;

end.
