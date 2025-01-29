unit UnitHiConFuncCodeOrm;

interface

uses SysUtils, Classes, Generics.Collections, Forms,
  mormot.core.base, mormot.orm.core, mormot.rest.client, mormot.core.os,
  mormot.rest.sqlite3, mormot.orm.base, mormot.core.data, mormot.core.variants,
  mormot.core.datetime, mormot.core.collections, mormot.core.json;

type
  TOrmHiconFuncCode = class(TOrm)
  private
    FFuncCode,  //01,02...
    FDataType,  //DI, DO, AI
    FDesc,
    FGrpModule_CB,
    FGrpModule_SbMotor1,
    FGrpModule_SbMotor2,
    FGrpModule_VFD,
    FGrpModule_MotorFr,
    FGrpModule_ValveC,
    FGrpModule_ValveD,
    FGrpModule_ValveT,
//    FGrpModule_CS,
    FGeneralModule_Measdh,
    FGeneralModule_Measav,
    FSignalType //N.O./N.C.
    : RawUtf8;
    FIsUpdate: Boolean;
    FUpdateDate
    : TTimeLog;
  public
    //True : DB Update, False: DB Add
    property IsUpdate: Boolean read FIsUpdate write FIsUpdate;
  published
    property FuncCode: RawUtf8 read FFuncCode write FFuncCode;
    property DataType: RawUtf8 read FDataType write FDataType;
    property Desc: RawUtf8 read FDesc write FDesc;
    property GrpModule_CB: RawUtf8 read FGrpModule_CB write FGrpModule_CB;
    property GrpModule_SbMotor1: RawUtf8 read FGrpModule_SbMotor1 write FGrpModule_SbMotor1;
    property GrpModule_SbMotor2: RawUtf8 read FGrpModule_SbMotor2 write FGrpModule_SbMotor2;
    property GrpModule_VFD: RawUtf8 read FGrpModule_VFD write FGrpModule_VFD;
    property GrpModule_MotorFr: RawUtf8 read FGrpModule_MotorFr write FGrpModule_MotorFr;
    property GrpModule_ValveC: RawUtf8 read FGrpModule_ValveC write FGrpModule_ValveC;
    property GrpModule_ValveD: RawUtf8 read FGrpModule_ValveD write FGrpModule_ValveD;
    property GrpModule_ValveT: RawUtf8 read FGrpModule_ValveT write FGrpModule_ValveT;
//    property GrpModule_CS: RawUtf8 read FGrpModule_CS write FGrpModule_CS;
    property GeneralModule_Measdh: RawUtf8 read FGeneralModule_Measdh write FGeneralModule_Measdh;
    property GeneralModule_Measav: RawUtf8 read FGeneralModule_Measav write FGeneralModule_Measav;
    property SignalType: RawUtf8 read FSignalType write FSignalType;

    property UpdateDate: TTimeLog read FUpdateDate write FUpdateDate;
  end;

function CreateModelHiconFuncCode: TOrmModel;
procedure InitHiconFuncCodeClient(AExeName: string; ADBFileName: string='');
procedure DestroyHiconFuncCodeClient();

function GetOrmHiconFuncCodeByCode(const ACode: RawUtf8): TOrmHiconFuncCode;
function GetSignalTypeByCode(const ACode: RawUtf8): RawUtf8;

procedure AddOrUpdateHiconFuncCode(AOrm: TOrmHiconFuncCode);
function AddOrUpdateHiconFuncCodeFromVariant(AFuncCode: RawUtf8; ADoc: variant; AIsOnlyAdd: Boolean): integer;

var
  g_HiconFuncCodeDB: TRestClientURI;
  HiconFuncCodeModel: TOrmModel;

implementation

uses UnitFolderUtil2, UnitRttiUtil2, UnitDateUtil;

function CreateModelHiconFuncCode: TOrmModel;
begin
  result := TOrmModel.Create([TOrmHiconFuncCode]);
end;

procedure InitHiconFuncCodeClient(AExeName: string; ADBFileName: string='');
var
  LStr, LFileName, LFilePath: string;
begin
  if Assigned(g_HiconFuncCodeDB) then
    exit;

  if AExeName = '' then
    AExeName := Application.ExeName;

  LStr := ExtractFileExt(AExeName);
  LFileName := ExtractFileName(AExeName);
  LFilePath := ExtractFilePath(AExeName);

  if LStr = '.exe' then
  begin
    LFileName := ChangeFileExt(ExtractFileName(AExeName),'.sqlite');
    LFileName := LFileName.Replace('.sqlite', '_FuncCode.sqlite');
    LFilePath := GetSubFolderPath(LFilePath, 'db');
  end;

  LFilePath := EnsureDirectoryExists(LFilePath);

  if ADBFileName = '' then
    LStr := LFilePath + LFileName
  else
    LStr := ADBFileName;

  HiconFuncCodeModel:= CreateModelHiconFuncCode;

  g_HiconFuncCodeDB:= TSQLRestClientDB.Create(HiconFuncCodeModel, CreateModelHiconFuncCode,
    LStr, TSQLRestServerDB);
  TSQLRestClientDB(g_HiconFuncCodeDB).Server.CreateMissingTables;
end;

procedure DestroyHiconFuncCodeClient();
begin
  if Assigned(g_HiconFuncCodeDB) then
    FreeAndNil(g_HiconFuncCodeDB);

  if Assigned(HiconFuncCodeModel) then
    FreeAndNil(HiconFuncCodeModel);
end;

function GetOrmHiconFuncCodeByCode(const ACode: RawUtf8): TOrmHiconFuncCode;
begin
  Result := TOrmHiconFuncCode.CreateAndFillPrepare(g_HiconFuncCodeDB.orm, 'FuncCode = ?', [ACode]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetSignalTypeByCode(const ACode: RawUtf8): RawUtf8;
var
  LOrm: TOrmHiconFuncCode;
begin
  Result := '';

  LOrm := GetOrmHiconFuncCodeByCode(ACode);
  try
    if LOrm.IsUpdate then
    begin
      Result := LOrm.SignalType;
    end;
  finally
    LOrm.Free;
  end;
end;

procedure AddOrUpdateHiconFuncCode(AOrm: TOrmHiconFuncCode);
begin
  if AOrm.IsUpdate then
  begin
    g_HiconFuncCodeDB.Update(AOrm);
  end
  else
  begin
    g_HiconFuncCodeDB.Add(AOrm, true);
  end;
end;

function AddOrUpdateHiconFuncCodeFromVariant(AFuncCode: RawUtf8; ADoc: variant; AIsOnlyAdd: Boolean): integer;
var
  LOrm: TOrmHiconFuncCode;
begin
  LOrm := GetOrmHiconFuncCodeByCode(AFuncCode);
  try
    LoadRecordPropertyFromVariant(LOrm, ADoc);
    AddOrUpdateHiconFuncCode(LOrm);
  finally
    LOrm.Free;
  end;

end;

end.
