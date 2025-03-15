unit UnitHiConMPMFileUtil;

interface

uses
  SysUtils, StrUtils, Classes,
  UnitElfReader;

type
  THiConMPMFile = class
  public
    class function GetVersionFromBackup(AFileName: string): string;
    class function GetElfHeaderFromBackup(AFileName: string): TElfHeader;
    class function GetElf32HeaderFromBackup(AFileName: string): TElf32Header;
    class function GetElf64HeaderFromBackup(AFileName: string): TElf64Header;
  end;

implementation

{ THiConMPMFile }

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

class function THiConMPMFile.GetVersionFromBackup(AFileName: string): string;
var
  LElfHeader: TElfHeader;
begin
  LElfHeader := GetElfHeaderFromBackup(AFileName);
  Result := IntToStr(LElfHeader.ClassType)
end;

end.
