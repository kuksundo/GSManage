unit UnitHiConMPMFileUtil;

interface

uses
  SysUtils, StrUtils, Classes,
  mormot.core.base, mormot.core.os, mormot.core.unicode,
  UnitElfReader;

type
  THiConMPMFile = class
  public
    class function GetVersionFromBackup(AFileName: string): string;
    class function GetElfHeaderFromBackup(AFileName: string): TElfHeader;
    class function GetElf32HeaderFromBackup(AFileName: string): TElf32Header;
    class function GetElf64HeaderFromBackup(AFileName: string): TElf64Header;

    class function GetIfCfgEth2StrByIpAddr(const AIpAddr: string; out ADevName: string): string;
    class function CreateNSaveIfCfgEthFileByIpAddr(const AIpAddr, AIfCfgFileNameFullPath: string): Boolean;
  end;

implementation

uses UnitStringUtil;

{ THiConMPMFile }

class function THiConMPMFile.CreateNSaveIfCfgEthFileByIpAddr(const AIpAddr,
  AIfCfgFileNameFullPath: string): Boolean;
var
  LUtf8: RawUtf8;
  LDevName: string;
begin
  Result := False;
  LUtf8 := StringToUtf8(GetIfCfgEth2StrByIpAddr(AIpAddr, LDevName));
  Result := FileFromString(LUtf8, AIfCfgFileNameFullPath);
end;

class function THiConMPMFile.GetElf32HeaderFromBackup(
  AFileName: string): TElf32Header;
begin
  Result := ReadElf32Header(AFileName);
end;

class function THiConMPMFile.GetElf64HeaderFromBackup(
  AFileName: string): TElf64Header;
begin
  Result := ReadElf64Header(AFileName);
end;

class function THiConMPMFile.GetElfHeaderFromBackup(
  AFileName: string): TElfHeader;
begin
  Result := ReadElfFileInfo(AFileName);
end;

class function THiConMPMFile.GetIfCfgEth2StrByIpAddr(const AIpAddr: string; out ADevName: string): string;
var
  LStr, LIp: string;
begin
  LIp := AIpAddr;
  LStr := StrToken(LIp, '.');

  if LStr = '10' then
    ADevName := 'eth0'
  else
    ADevName := 'eth1';

  Result := 'DEVICE=' + ADevName;

  LStr := LStr + '.' + StrToken(LIp, '.');

  Result := Result + #10 + 'BOOTPROTO=static' + #10;
  Result := Result + 'IPADDR=' + AIpAddr + #10;
  Result := Result + 'NETMASK=255.255.0.0' + #10;
  Result := Result + 'BROADCAST=' + LStr + '.255.255' + #10;
  Result := Result + 'ONBOOT=yes' + #10;
  Result := Result + 'GATEWAY=' + ADevName + #10;
end;

class function THiConMPMFile.GetVersionFromBackup(AFileName: string): string;
var
  LElfHeader: TElfHeader;
begin
  LElfHeader := GetElfHeaderFromBackup(AFileName);
  Result := IntToStr(LElfHeader.ClassType)
end;

end.
