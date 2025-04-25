unit UnitHGSSerialRecord2;

interface

uses Classes,
  mormot.orm.core, mormot.core.datetime, mormot.core.base, mormot.core.os,
  mormot.rest.sqlite3,
  UnitRegAppUtil, UnitHMSSignatureOrm;

type
  TSQLHGSSerialRecord = class(TSQLRecord)
  private
    fIssuedYear,
    fProductType,
    fCategory,
    fLastSerialNo
    : integer;

    FDBIsInUse //동시에 두개의 프로그램에서 접근하는 것 방지함
    :Boolean;

    fUpdateDate: TTimeLog;
  public
    FIsUpdate: Boolean;
    property IsUpdate: Boolean read FIsUpdate write FIsUpdate;
  published
    property IssuedYear: integer read fIssuedYear write fIssuedYear;
    property ProductType: integer read fProductType write fProductType;
    property Category: integer read fCategory write fCategory;
    property LastSerialNo: integer read fLastSerialNo write fLastSerialNo;
    property UpdateDate: TTimeLog read fUpdateDate write fUpdateDate;
  end;

procedure InitHGSSerialClient(AHGSCertSerialDBName: string = '');
procedure InitHMSSerialOrm(AExeName: string; ADBFileName: string='');
function CreateHGSSerialModel: TSQLModel;
procedure DestroyHGSSerial;

function GetHGSSerialFromProductType(const AIssuedYear, AProductType: integer; ACategory : integer = 0): TSQLHGSSerialRecord;
function GetNextHGSSerialFromProductType(const AIssuedYear, AProductType: integer; ACategory : integer = 0): integer;
procedure AddOrUpdateHGSSerial(ASQLHGSSerialRecord: TSQLHGSSerialRecord);
procedure AddOrUpdateNextHGSSerial(const AIssuedYear, AProductType, ACategory : integer; ALastSerialNo: integer);

var
  g_HGSSerialDB: TRestClientDB;
  HGSSerialModel: TSQLModel;

implementation

uses SysUtils, Forms, VarRecUtils, Vcl.Dialogs, UnitStringUtil,
  UnitFolderUtil2, UnitRttiUtil2;

procedure InitHGSSerialClient(AHGSCertSerialDBName: string = '');
var
  LStr: string;
begin
  if AHGSCertSerialDBName = '' then
    AHGSCertSerialDBName := ChangeFileExt(ExtractFilePath(Application.ExeName),'.sqlite');

  LStr := GetSubFolderPath(ExtractFilePath(Application.ExeName), 'db');
  LStr := LStr + AHGSCertSerialDBName;
  HGSSerialModel:= CreateHGSSerialModel;
  g_HGSSerialDB:= TSQLRestClientDB.Create(HGSSerialModel, CreateHGSSerialModel,
    LStr, TSQLRestServerDB);
  TSQLRestClientDB(g_HGSSerialDB).Server.CreateMissingTables;
end;

procedure InitHMSSerialOrm(AExeName: string; ADBFileName: string);
var
  LStr, LFileName, LFilePath: string;
begin
  if Assigned(g_HGSSerialDB) then
    exit;

  if AExeName = '' then
    AExeName := Application.ExeName;

  LStr := ExtractFileExt(AExeName);
  LFileName := ExtractFileName(AExeName);
  LFilePath := ExtractFilePath(AExeName);

  if LStr = '.exe' then
  begin
    LFileName := ChangeFileExt(ExtractFileName(AExeName),'.sqlite');
    LFileName := LFileName.Replace('.sqlite', '_SerialNo.sqlite');
    LFilePath := GetSubFolderPath(LFilePath, 'db');
  end;

  LFilePath := EnsureDirectoryExists(LFilePath);

  if ADBFileName = '' then
    LStr := LFilePath + LFileName
  else
    LStr := ADBFileName;

  HGSSerialModel:= CreateHGSSerialModel;

  g_HGSSerialDB:= TSQLRestClientDB.Create(HGSSerialModel, CreateHGSSerialModel,
    LStr, TSQLRestServerDB);
  TSQLRestClientDB(g_HGSSerialDB).Server.CreateMissingTables;
end;

function CreateHGSSerialModel: TSQLModel;
begin
  result := TSQLModel.Create([TSQLHGSSerialRecord, TOrmHMSSignature]);
end;

procedure DestroyHGSSerial;
begin
  if Assigned(HGSSerialModel) then
    FreeAndNil(HGSSerialModel);

  if Assigned(g_HGSSerialDB) then
    FreeAndNil(g_HGSSerialDB);
end;

function GetHGSSerialFromProductType(const AIssuedYear, AProductType: integer;
  ACategory : integer = 0): TSQLHGSSerialRecord;
var
  LSQL: string;
  LIsCategory: Boolean;
begin
  if (AProductType = 0) or (AIssuedYear = 0) then
  begin
    Result := TSQLHGSSerialRecord.Create;
    Result.IsUpdate := False;
  end
  else
  begin
    LIsCategory := False;
    LSQL := 'IssuedYear = ? and ProductType = ?';

    if ACategory <> 0 then
    begin
      LSQL := LSQL + ' and Category = ?';
      LIsCategory := True;
    end;

    if LIsCategory then
      Result := TSQLHGSSerialRecord.CreateAndFillPrepare(g_HGSSerialDB.Orm,
        LSQL, [AIssuedYear, AProductType, ACategory])
    else
      Result := TSQLHGSSerialRecord.CreateAndFillPrepare(g_HGSSerialDB.Orm,
        LSQL, [AIssuedYear, AProductType]);

    if Result.FillOne then
      Result.IsUpdate := True
    else
      Result.IsUpdate := False;
  end;
end;

function GetNextHGSSerialFromProductType(const AIssuedYear, AProductType: integer; ACategory : integer = 0): integer;
var
  LSQLHGSSerialRecord: TSQLHGSSerialRecord;
begin
  LSQLHGSSerialRecord := GetHGSSerialFromProductType(AIssuedYear, AProductType, ACategory);
  try
    Result := LSQLHGSSerialRecord.LastSerialNo;
    Inc(Result);
  finally
    LSQLHGSSerialRecord.Free;
  end;
end;

procedure AddOrUpdateHGSSerial(ASQLHGSSerialRecord: TSQLHGSSerialRecord);
begin
  if ASQLHGSSerialRecord.IsUpdate then
  begin
    g_HGSSerialDB.Update(ASQLHGSSerialRecord);
  end
  else
  begin
    g_HGSSerialDB.Add(ASQLHGSSerialRecord, true);
  end;
end;

procedure AddOrUpdateNextHGSSerial(const AIssuedYear, AProductType, ACategory : integer;
  ALastSerialNo: integer);
var
  LSQLHGSSerialRecord: TSQLHGSSerialRecord;
begin
  LSQLHGSSerialRecord := GetHGSSerialFromProductType(AIssuedYear, AProductType, ACategory);
  try
    if not LSQLHGSSerialRecord.IsUpdate then
    begin
      LSQLHGSSerialRecord.IssuedYear := AIssuedYear;
      LSQLHGSSerialRecord.ProductType := AProductType;
      LSQLHGSSerialRecord.Category := ACategory;
    end;

    if LSQLHGSSerialRecord.fLastSerialNo < ALastSerialNo then
      LSQLHGSSerialRecord.LastSerialNo := ALastSerialNo;

    AddOrUpdateHGSSerial(LSQLHGSSerialRecord);
  finally
    LSQLHGSSerialRecord.Free;
  end;
end;

initialization

finalization
  DestroyHGSSerial;

end.
