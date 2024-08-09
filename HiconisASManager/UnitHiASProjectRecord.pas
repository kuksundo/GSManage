unit UnitHiASProjectRecord;

interface

uses SysUtils, Classes, Generics.Collections, Forms,
  mormot.core.base, mormot.orm.core, mormot.rest.client, mormot.core.os,
  mormot.rest.sqlite3, mormot.orm.base, mormot.core.data, mormot.core.variants,
  mormot.core.datetime, mormot.core.json;

type
  TOrmHiASProject = class(TOrm)
  private
    fProjectNo, //공사번호
    fHullNo, //호선번호
    fVessel_Type, //선박유형
    fVessel_Unit,//선박화물단위
    fVessel_Qty, //선박화물용량
    fShipyard, //건조 조선소
    fShipOwener, //선주명
    fHiconisSystem, //납품된 시스템 종류-FGSS/ICMS/IAS
    fEngineKind, //주기 종류 - LNGDF/LPGDF/METHANOLDF
    fSocityClass, //선급명
    fWarrantyCond1_Code,//보증조건1 Code
    fWarrantyCond1_Name,//보증조건1 이름
    fWarrantyCond1_Period,//보증조건1 기간
    fWarrantyCond1_Period_Unit,//보증조건1 기간 단위
    fWarrantyCond1_Period_Unit_Name,//보증조건1 기간 단위 명
    fWarrantyCond2_Code,//보증조건2 Code
    fWarrantyCond2_Name,//보증조건2 이름
    fWarrantyCond2_Period,//보증조건2 기간
    fWarrantyCond2_Period_Unit,//보증조건2 기간 단위
    fWarrantyCond2_Period_Unit_Name,//보증조건2 기간 단위 명
    fAdventKind, //도래구분-선도래/
    fExtendWarrantyPeriod, //연장보증기간(월)
    fTotalWarrantyPeriod //종보증기간(월)
    : RawUTF8;

    FIsUpdate: Boolean;

    fDeliveryDate,//인도일
    fWarrantyExpireDate, //보증만료일
    fModifyDate
    :TTimeLog;
  public
    //True : DB Update, False: DB Add
    property IsUpdate: Boolean read FIsUpdate write FIsUpdate;
    property WarrantyExpireDate: TTimeLog read fWarrantyExpireDate write fWarrantyExpireDate;
  published
    property ProjectNo : RawUTF8 read fProjectNo write fProjectNo;
    property HullNo: RawUTF8 read fHullNo write fHullNo;
    property Vessel_Type: RawUTF8 read fVessel_Type write fVessel_Type;
    property Vessel_Unit: RawUTF8 read fVessel_Unit write fVessel_Unit;
    property Vessel_Qty : RawUTF8 read fVessel_Qty write fVessel_Qty;
    property Shipyard: RawUTF8 read fShipyard write fShipyard;
    property ShipOwener: RawUTF8 read fShipOwener write fShipOwener;
    property HiconisSystem: RawUTF8 read fHiconisSystem write fHiconisSystem;
    property EngineKind : RawUTF8 read fEngineKind write fEngineKind;
    property SocityClass: RawUTF8 read fSocityClass write fSocityClass;
    property WarrantyCond1_Code: RawUTF8 read fWarrantyCond1_Code write fWarrantyCond1_Code;
    property WarrantyCond1_Name: RawUTF8 read fWarrantyCond1_Name write fWarrantyCond1_Name;
    property WarrantyCond1_Period : RawUTF8 read fWarrantyCond1_Period write fWarrantyCond1_Period;
    property WarrantyCond1_Period_Unit: RawUTF8 read fWarrantyCond1_Period_Unit write fWarrantyCond1_Period_Unit;
    property WarrantyCond1_Period_Unit_Name: RawUTF8 read fWarrantyCond1_Period_Unit_Name write fWarrantyCond1_Period_Unit_Name;
    property WarrantyCond2_Code: RawUTF8 read fWarrantyCond2_Code write fWarrantyCond2_Code;
    property WarrantyCond2_Name: RawUTF8 read fWarrantyCond2_Name write fWarrantyCond2_Name;
    property WarrantyCond2_Period : RawUTF8 read fWarrantyCond2_Period write fWarrantyCond2_Period;
    property WarrantyCond2_Period_Unit: RawUTF8 read fWarrantyCond2_Period_Unit write fWarrantyCond2_Period_Unit;
    property WarrantyCond2_Period_Unit_Name: RawUTF8 read fWarrantyCond2_Period_Unit_Name write fWarrantyCond2_Period_Unit_Name;
    property AdventKind: RawUTF8 read fAdventKind write fAdventKind;
    property ExtendWarrantyPeriod: RawUTF8 read fExtendWarrantyPeriod write fExtendWarrantyPeriod;
    property TotalWarrantyPeriod: RawUTF8 read fTotalWarrantyPeriod write fTotalWarrantyPeriod;

    property DeliveryDate: TTimeLog read fDeliveryDate write fDeliveryDate;
    property ModifyDate: TTimeLog read fModifyDate write fModifyDate;
  end;

  function CreateModelHiASProject: TOrmModel;
  procedure InitHiASProjectClient(AExeName: string; ADBFileName: string='');
  procedure DestroyHiASProjectClient();

  function GetHiASProjectByProjectNo(const AProjNo: string): TOrmHiASProject;
  function GetHiASProjectByHullNo(const AHullNo: string): TOrmHiASProject;

  function CalcWarrantyExpireDateByHullNo(const AHullNo: string): TTimeLog;

  procedure AddHiASProjectFromVariant(AVar: variant);
  procedure AddOrUpdateHiASProject(AOrm: TOrmHiASProject);

var
  g_HiASProjectDB: TRestClientURI;
  HiASProjectModel: TOrmModel;

implementation

uses UnitFolderUtil2, UnitRttiUtil2, UnitDateUtil;

function CreateModelHiASProject: TOrmModel;
begin
  result := TOrmModel.Create([TOrmHiASProject]);
end;

procedure InitHiASProjectClient(AExeName: string; ADBFileName: string='');
var
  LStr, LFileName, LFilePath: string;
begin
  if Assigned(g_HiASProjectDB) then
    exit;

  if AExeName = '' then
    AExeName := Application.ExeName;

  LStr := ExtractFileExt(AExeName);
  LFileName := ExtractFileName(AExeName);
  LFilePath := ExtractFilePath(AExeName);

  if LStr = '.exe' then
  begin
    LFileName := ChangeFileExt(ExtractFileName(AExeName),'.sqlite');
    LFileName := LFileName.Replace('.sqlite', '_Project.sqlite');
    LFilePath := GetSubFolderPath(LFilePath, 'db');
  end;

  LFilePath := EnsureDirectoryExists(LFilePath);

  if ADBFileName = '' then
    LStr := LFilePath + LFileName
  else
    LStr := ADBFileName;

  HiASProjectModel:= CreateModelHiASProject;

  g_HiASProjectDB:= TSQLRestClientDB.Create(HiASProjectModel, CreateModelHiASProject,
    LStr, TSQLRestServerDB);
  TSQLRestClientDB(g_HiASProjectDB).Server.CreateMissingTables;
end;

procedure DestroyHiASProjectClient();
begin
  if Assigned(g_HiASProjectDB) then
    FreeAndNil(g_HiASProjectDB);

  if Assigned(HiASProjectModel) then
    FreeAndNil(HiASProjectModel);
end;

function GetHiASProjectByProjectNo(const AProjNo: string): TOrmHiASProject;
begin
  Result := TOrmHiASProject.CreateAndFillPrepare(g_HiASProjectDB.orm, 'ProjectNo LIKE ?', ['%'+AProjNo+'%']);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetHiASProjectByHullNo(const AHullNo: string): TOrmHiASProject;
begin
  Result := TOrmHiASProject.CreateAndFillPrepare(g_HiASProjectDB.orm, 'HullNo LIKE ?', ['%'+AHullNo+'%']);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function CalcWarrantyExpireDateByHullNo(const AHullNo: string): TTimeLog;
var
  LOrmHiASProject: TOrmHiASProject;
  LDate: TDate;
  LNumOfMonth: integer;
begin
  Result := 0;

  LOrmHiASProject := GetHiASProjectByHullNo(AHullNo);
  try
    if LOrmHiASProject.IsUpdate then
    begin
      LDate := TimeLogToDateTime(LOrmHiASProject.DeliveryDate);
      LNumOfMonth := StrToIntDef(LOrmHiASProject.fTotalWarrantyPeriod,0);
      LDate := GetExpireDateFromStartDateByMonth(LDate, LNumOfMonth);
      Result := TimeLogFromDateTime(LDate);
  //    LOrmHiASProject.WarrantyExpireDate := Result;
    end;
  finally
    LOrmHiASProject.Free;
  end;
end;

procedure AddHiASProjectFromVariant(AVar: variant);
var
  LHullNo: string;
  LOrmHiASProject: TOrmHiASProject;
begin
  LHullNo := AVar.HullNo;

  LOrmHiASProject := GetHiASProjectByHullNo(LHullNo);
  try
    LoadRecordPropertyFromVariant(LOrmHiASProject, AVar);
    AddOrUpdateHiASProject(LOrmHiASProject);
  finally
    FreeAndNil(LOrmHiASProject);
  end;
end;

procedure AddOrUpdateHiASProject(AOrm: TOrmHiASProject);
begin
  if AOrm.IsUpdate then
  begin
    g_HiASProjectDB.Update(AOrm);
  end
  else
  begin
    g_HiASProjectDB.Add(AOrm, true);
  end;
end;

initialization
finalization
  DestroyHiASProjectClient();

end.
