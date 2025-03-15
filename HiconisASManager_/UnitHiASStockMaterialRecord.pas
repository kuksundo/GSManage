unit UnitHiASStockMaterialRecord;

interface

uses SysUtils, Classes, Generics.Collections, Forms,
  mormot.core.base, mormot.orm.core, mormot.rest.client, mormot.core.os,
  mormot.rest.sqlite3, mormot.orm.base, mormot.core.data, mormot.core.variants,
  mormot.core.datetime, mormot.core.json;

type
  //Stock 자재정보
  TOrmStockMaterial = class(TOrm)
  private
    fPlateNo,
    fOriginalHullNo,
    fOriginalClaimNo,
    fTargetHullNo,
    fTargetClaimNo,
    fMaterialCode, //자재코드
    fMaterialName, //자재명
    fSerialNo,
    fUnitPrice//자재 단가
    : RawUTF8;
    FCreateDate//자재생성일
    : TTimeLog;
    fDivertQty: integer;//전용 수량

    FIsReclaim, //Re-Claim 자재인 경우 True
    FIsPOR, //POR 자재인 경우 True
    FIsUpdate: Boolean;
  public
    //True : DB Update, False: DB Add
    property IsUpdate: Boolean read FIsUpdate write FIsUpdate;
  published
    property PlateNo: RawUTF8 read fPlateNo write fPlateNo;
    property OriginalHullNo: RawUTF8 read fOriginalHullNo write fOriginalHullNo;
    property OriginalClaimNo: RawUTF8 read fOriginalClaimNo write fOriginalClaimNo;
    property TargetHullNo: RawUTF8 read fTargetHullNo write fTargetHullNo;
    property TargetClaimNo: RawUTF8 read fTargetClaimNo write fTargetClaimNo;
    property MaterialCode: RawUTF8 read fMaterialCode write fMaterialCode;
    property MaterialName: RawUTF8 read fMaterialName write fMaterialName;
    property SerialNo: RawUTF8 read fSerialNo write fSerialNo;
    property UnitPrice: RawUTF8 read fUnitPrice write fUnitPrice;

    property DivertQty: integer read fDivertQty write fDivertQty;

    property IsReclaim: Boolean read FIsReclaim write FIsReclaim;
    property IsPOR: Boolean read FIsPOR write FIsPOR;
    property CreateDate: TTimeLog read FCreateDate write FCreateDate;
  end;

function CreateModel_HiASStockMaterial: TSQLModel;
procedure InitHiASStockMaterialClient(AExeName: string; ADBFileName: string='');
procedure DestroyHiASStockMaterialClient();

function GetStockMaterialByPlateNo(APlateNo: RawUTF8): TOrmStockMaterial;
function GetStockMaterialByOriginalHullNoNClaimNo(AOriginalHullNo: RawUTF8; AOriginalClaimNo: RawUTF8=''): TOrmStockMaterial;
function GetStockMaterialByTargetHullNoNClaimNo(ATargetHullNo: RawUTF8; ATargetClaimNo: RawUTF8=''): TOrmStockMaterial;

var
  g_HiASStockMaterialDB: TSQLRestClientURI;
  HiASStockMaterialModel: TSQLModel;

implementation

uses UnitFolderUtil2;

function CreateModel_HiASStockMaterial: TSQLModel;
begin
  result := TSQLModel.Create([TOrmStockMaterial]);
end;

procedure InitHiASStockMaterialClient(AExeName: string; ADBFileName: string='');
var
  LStr, LFileName, LFilePath: string;
begin
  if Assigned(g_HiASStockMaterialDB) then
    exit;

  if AExeName = '' then
    AExeName := Application.ExeName;

  LStr := ExtractFileExt(AExeName);
  LFileName := ExtractFileName(AExeName);
  LFilePath := ExtractFilePath(AExeName);

  if LStr = '.exe' then
  begin
    LFileName := ChangeFileExt(ExtractFileName(AExeName),'.sqlite');
    LFileName := LFileName.Replace('.sqlite', '_StockMaterial.sqlite');
    LFilePath := GetSubFolderPath(LFilePath, 'db');
  end;

  LFilePath := EnsureDirectoryExists(LFilePath);

  if ADBFileName = '' then
    LStr := LFilePath + LFileName
  else
    LStr := ADBFileName;

  HiASStockMaterialModel:= CreateModel_HiASStockMaterial;

  g_HiASStockMaterialDB:= TSQLRestClientDB.Create(HiASStockMaterialModel, CreateModel_HiASStockMaterial,
    LStr, TSQLRestServerDB);
  TSQLRestClientDB(g_HiASStockMaterialDB).Server.CreateMissingTables;
end;

procedure DestroyHiASStockMaterialClient();
begin
  if Assigned(g_HiASStockMaterialDB) then
    FreeAndNil(g_HiASStockMaterialDB);

  if Assigned(HiASStockMaterialModel) then
    FreeAndNil(HiASStockMaterialModel);
end;

function GetStockMaterialByPlateNo(APlateNo: RawUTF8): TOrmStockMaterial;
begin
  Result := TOrmStockMaterial.CreateAndFillPrepare(g_HiASStockMaterialDB.orm, 'PlateNo = ?', [APlateNo]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetStockMaterialByOriginalHullNoNClaimNo(AOriginalHullNo: RawUTF8; AOriginalClaimNo: RawUTF8=''): TOrmStockMaterial;
begin
  if AOriginalClaimNo = '' then
    Result := TOrmStockMaterial.CreateAndFillPrepare(g_HiASStockMaterialDB.orm, 'OriginalHullNo = ?', [AOriginalHullNo])
  else
    Result := TOrmStockMaterial.CreateAndFillPrepare(g_HiASStockMaterialDB.orm, 'OriginalHullNo = ? AND OriginalClaimNo = ?', [AOriginalHullNo, AOriginalClaimNo]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetStockMaterialByTargetHullNoNClaimNo(ATargetHullNo: RawUTF8; ATargetClaimNo: RawUTF8=''): TOrmStockMaterial;
begin
  if ATargetClaimNo = '' then
    Result := TOrmStockMaterial.CreateAndFillPrepare(g_HiASStockMaterialDB.orm, 'TargetHullNo = ?', [ATargetHullNo])
  else
    Result := TOrmStockMaterial.CreateAndFillPrepare(g_HiASStockMaterialDB.orm, 'TargetHullNo = ? AND TargetClaimNo = ?', [ATargetHullNo, ATargetClaimNo]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

end.
