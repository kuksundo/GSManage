unit UnitHiASProjectRecord;

interface

uses SysUtils, Classes, Generics.Collections, Forms,
  mormot.core.base, mormot.orm.core, mormot.rest.client, mormot.core.os,
  mormot.rest.sqlite3, mormot.orm.base, mormot.core.data, mormot.core.variants,
  mormot.core.datetime, mormot.core.json;

type
  TOrmHiASProject = class(TOrm)
  private
    fProjectNo, //�����ȣ
    fHullNo, //ȣ����ȣ
    fVessel_Type, //��������
    fVessel_Unit,//����ȭ������
    fVessel_Qty, //����ȭ���뷮
    fShipyard, //���� ������
    fShipOwener, //���ָ�
    fHiconisSystem, //��ǰ�� �ý��� ����-FGSS/ICMS/IAS
    fEngineKind, //�ֱ� ���� - LNGDF/LPGDF/METHANOLDF
    fSocityClass, //���޸�
    fWarrantyCond1_Code,//��������1 Code
    fWarrantyCond1_Name,//��������1 �̸�
    fWarrantyCond1_Period,//��������1 �Ⱓ
    fWarrantyCond1_Period_Unit,//��������1 �Ⱓ ����
    fWarrantyCond1_Period_Unit_Name,//��������1 �Ⱓ ���� ��
    fWarrantyCond2_Code,//��������2 Code
    fWarrantyCond2_Name,//��������2 �̸�
    fWarrantyCond2_Period,//��������2 �Ⱓ
    fWarrantyCond2_Period_Unit,//��������2 �Ⱓ ����
    fWarrantyCond2_Period_Unit_Name,//��������2 �Ⱓ ���� ��
    fAdventKind, //��������-������/
    fExtendWarrantyPeriod, //���庸���Ⱓ(��)
    fTotalWarrantyPeriod //�������Ⱓ(��)
    : RawUTF8;

    FIsUpdate: Boolean;

    fDeliveryDate,//�ε���
    fWarrantyExpireDate, //����������
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
