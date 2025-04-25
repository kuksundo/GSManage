unit UnitHiASMaterialDetailRecord;

interface

uses SysUtils, Classes, Generics.Collections, Forms,
  mormot.core.base, mormot.orm.core, mormot.rest.client, mormot.core.os,
  mormot.rest.sqlite3, mormot.orm.base, mormot.core.data, mormot.core.variants,
  mormot.core.datetime, mormot.core.json,

  UnitHiconisMasterRecord, CommonData2
  ;

type
  //자재상세정보
  TSQLMaterialDetail = class(TSQLRecord)
  private
    fTaskID: TID;
    fProjPORNo: RawUTF8; //공사 PORNo
    fMatPORNo: RawUTF8;  // 자재별 PORNo
    fMaterialCode, //자재코드
    fMaterialName, //자재명
    fPlateNo, //자재명
    fUnitPrice,//자재 단가
    fFaultyPartName //고장 부품 이름(DI0xxxx)
    : RawUTF8;
    fNeedDate, //소요일자
    FCreateDate//자재생성일
    : TTimeLog;
    fNeedCount: integer;//수량
    fCurQty: integer;//현재 보유 수량
    fLeadTime: integer;

    FIsReclaim, //Re-Claim 자재인 경우 True
    FIsPOR, //POR 자재인 경우 True
    FIsUpdate: Boolean;
  public
    //True : DB Update, False: DB Add
    property IsUpdate: Boolean read FIsUpdate write FIsUpdate;
  published
    property TaskID: TID read fTaskID write fTaskID;
    property PORNo: RawUTF8 read fProjPORNo write fProjPORNo;
    property MatPORNo: RawUTF8 read fMatPORNo write fMatPORNo;
    property MaterialCode: RawUTF8 read fMaterialCode write fMaterialCode;
    property MaterialName: RawUTF8 read fMaterialName write fMaterialName;
    property PlateNo: RawUTF8 read fPlateNo write fPlateNo;
    property UnitPrice: RawUTF8 read fUnitPrice write fUnitPrice;
    property FaultyPartName: RawUTF8 read fFaultyPartName write fFaultyPartName;

    property CreateDate: TTimeLog read FCreateDate write FCreateDate;
    property NeedDate: TTimeLog read fNeedDate write fNeedDate;
    property NeedCount: integer read fNeedCount write fNeedCount;
    property CurQty: integer read fCurQty write fCurQty;
    property LeadTime: integer read fLeadTime write fLeadTime;

    property IsReclaim: Boolean read FIsReclaim write FIsReclaim;
    property IsPOR: Boolean read FIsPOR write FIsPOR;
  end;

  function CreateModel_HiASMaterialDetail: TSQLModel;
  procedure InitHiASMaterialDetailClient(AExeName: string; ADBFileName: string='');
  procedure DestroyHiASMaterialDetailClient();

  function GetMaterialDetailFromTask(ATask: TOrmHiconisASTask): TSQLMaterialDetail;
  function GetMaterialDetailFromTaskID(ATaskID: TID): TSQLMaterialDetail;
  function GetMaterialDetailFromID(AID: TID): TSQLMaterialDetail;
  function GetMaterialDetailFromTaskByReclaim(ATask: TOrmHiconisASTask): TSQLMaterialDetail;
  function GetMaterialDetailByPorNoNMatCode(const APorNo, AMatCode: string): TSQLMaterialDetail;
  function GetMaterialDetailByMatName(const AMatName: string): TSQLMaterialDetail;
  function GetMaterialDetailByPlateNo(const APlateNo: string): TSQLMaterialDetail;
  function GetMaterialDetailFromIDNMatPorNo(const ATaskID: TID; const AMatPorNo: string): TSQLMaterialDetail;

  procedure AddOrUpdateMaterialDetail(AOrm: TSQLMaterialDetail);


var
  g_HiASMaterialDetailDB: TSQLRestClientURI;
  HiASMaterialDetailModel: TSQLModel;

implementation

uses UnitHiASMaterialRecord, UnitFolderUtil2;

function CreateModel_HiASMaterialDetail: TSQLModel;
begin
  result := TSQLModel.Create([TSQLMaterialDetail]);
end;

procedure InitHiASMaterialDetailClient(AExeName: string; ADBFileName: string='');
var
  LStr, LFileName, LFilePath: string;
begin
  if Assigned(g_HiASMaterialDetailDB) then
    exit;

  if AExeName = '' then
    AExeName := Application.ExeName;

  LStr := ExtractFileExt(AExeName);
  LFileName := ExtractFileName(AExeName);
  LFilePath := ExtractFilePath(AExeName);

  if LStr = '.exe' then
  begin
    LFileName := ChangeFileExt(ExtractFileName(AExeName),'.sqlite');
    LFileName := LFileName.Replace('.sqlite', '_MaterialDetail.sqlite');
    LFilePath := GetSubFolderPath(LFilePath, 'db');
  end;

  LFilePath := EnsureDirectoryExists(LFilePath);

  if ADBFileName = '' then
    LStr := LFilePath + LFileName
  else
    LStr := ADBFileName;

  HiASMaterialDetailModel:= CreateModel_HiASMaterialDetail;

  g_HiASMaterialDetailDB:= TSQLRestClientDB.Create(HiASMaterialDetailModel, CreateModel_HiASMaterialDetail,
    LStr, TSQLRestServerDB);
  TSQLRestClientDB(g_HiASMaterialDetailDB).Server.CreateMissingTables;
end;

procedure DestroyHiASMaterialDetailClient();
begin
  if Assigned(g_HiASMaterialDetailDB) then
    FreeAndNil(g_HiASMaterialDetailDB);

  if Assigned(HiASMaterialDetailModel) then
    FreeAndNil(HiASMaterialDetailModel);
end;

function GetMaterialDetailFromTask(ATask: TOrmHiconisASTask): TSQLMaterialDetail;
var
  LMaterial4Project: TSQLMaterial4Project;
begin
  LMaterial4Project := GetMaterial4ProjFromTask(ATask);
  try
    LMaterial4Project.FillRewind;

    if LMaterial4Project.FillOne then
    begin
      Result := TSQLMaterialDetail.CreateAndFillPrepare(g_HiASMaterialDetailDB.orm, 'TaskID = ? and PORNo = ?', [ATask.ID, LMaterial4Project.PORNo]);

      if Result.FillOne then
        Result.IsUpdate := True
      else
        Result.IsUpdate := False;
    end
    else
      Result := TSQLMaterialDetail.Create;
  finally
    LMaterial4Project.Free;
  end;
end;

function GetMaterialDetailFromTaskID(ATaskID: TID): TSQLMaterialDetail;
begin
  Result := TSQLMaterialDetail.CreateAndFillPrepare(g_HiASMaterialDetailDB.orm, 'TaskID = ?', [ATaskID]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetMaterialDetailFromID(AID: TID): TSQLMaterialDetail;
begin
  Result := TSQLMaterialDetail.CreateAndFillPrepare(g_HiASMaterialDetailDB.orm, 'ID = ?', [AID]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetMaterialDetailFromTaskByReclaim(ATask: TOrmHiconisASTask): TSQLMaterialDetail;
var
  LMaterial4Project: TSQLMaterial4Project;
begin
  LMaterial4Project := GetMaterial4ProjFromTask(ATask);
  try
    LMaterial4Project.FillRewind;

    if LMaterial4Project.FillOne then
    begin
      Result := TSQLMaterialDetail.CreateAndFillPrepare(g_HiASMaterialDetailDB.orm, 'TaskID = ? and PORNo = ? and IsReclaim = ?', [ATask.ID, LMaterial4Project.PORNo, 1]);

      if Result.FillOne then
        Result.IsUpdate := True
      else
        Result.IsUpdate := False;
    end
    else
      Result := TSQLMaterialDetail.Create;
  finally
    LMaterial4Project.Free;
  end;
end;

function GetMaterialDetailByPorNoNMatCode(const APorNo, AMatCode: string): TSQLMaterialDetail;
begin
  if APorNo = '' then
    Result := TSQLMaterialDetail.CreateAndFillPrepare(g_HiASMaterialDetailDB.orm, 'MaterialCode like ?', ['%'+AMatCode+'%'])
  else
    Result := TSQLMaterialDetail.CreateAndFillPrepare(g_HiASMaterialDetailDB.orm, 'PORNo = ? and MaterialCode = ?', [APorNo, AMatCode]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetMaterialDetailByMatName(const AMatName: string): TSQLMaterialDetail;
begin
  Result := TSQLMaterialDetail.CreateAndFillPrepare(g_HiASMaterialDetailDB.orm, 'MaterialName like ?', ['%'+AMatName+'%']);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetMaterialDetailByPlateNo(const APlateNo: string): TSQLMaterialDetail;
begin
  Result := TSQLMaterialDetail.CreateAndFillPrepare(g_HiASMaterialDetailDB.orm, 'PlateNo like ?', ['%'+APlateNo+'%']);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetMaterialDetailFromIDNMatPorNo(const ATaskID: TID; const AMatPorNo: string): TSQLMaterialDetail;
begin
  if ATaskID = 0 then
    Result := TSQLMaterialDetail.CreateAndFillPrepare(g_HiASMaterialDetailDB.orm, 'MatPorNo = ?', [AMatPorNo])
  else
    Result := TSQLMaterialDetail.CreateAndFillPrepare(g_HiASMaterialDetailDB.orm, 'TaskID = ? AND MatPorNo = ?', [ATaskID, AMatPorNo]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

procedure AddOrUpdateMaterialDetail(AOrm: TSQLMaterialDetail);
begin
  if AOrm.IsUpdate then
  begin
    g_HiASMaterialDetailDB.Update(AOrm);
  end
  else
  begin
    g_HiASMaterialDetailDB.Add(AOrm, true);
  end;
end;

initialization
finalization
  DestroyHiASMaterialDetailClient();

end.
