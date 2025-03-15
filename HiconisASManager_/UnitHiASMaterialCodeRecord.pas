unit UnitHiASMaterialCodeRecord;

interface

uses SysUtils, Classes, Generics.Collections, Forms,
  mormot.core.base, mormot.orm.core, mormot.rest.client, mormot.core.os,
  mormot.rest.sqlite3, mormot.orm.base, mormot.core.data, mormot.core.variants,
  mormot.core.datetime, mormot.core.json;

type
  TOrmMaterialCode = class(TOrm)
  private
    fProductNo, //품목번호
    fMaterialCode, //자재코드
    fMaterialName, //자재명
    fDrawingNo,//도면번호
    fSupplierName, //공급업체명
    fOrderPrice//구매단가
    : RawUTF8;

    fMaterialKind,
    fMaterialCategory //TClaimCauseHW
    : integer;
    FIsUpdate: Boolean;
  public
    //True : DB Update, False: DB Add
    property IsUpdate: Boolean read FIsUpdate write FIsUpdate;
  published
    property ProductNo : RawUTF8 read fProductNo write fProductNo;
    property MaterialCode: RawUTF8 read fMaterialCode write fMaterialCode;
    property MaterialName: RawUTF8 read fMaterialName write fMaterialName;
    property DrawingNo: RawUTF8 read fDrawingNo write fDrawingNo;
    property SupplierName: RawUTF8 read fSupplierName write fSupplierName;
    property OrderPrice: RawUTF8 read fOrderPrice write fOrderPrice;
    property MaterialKind: integer read fMaterialKind write fMaterialKind;
    property MaterialCategory: integer read fMaterialCategory write fMaterialCategory;
  end;

  function CreateModelHiASMaterialCode: TOrmModel;
  procedure InitHiASMaterialCodeClient(AExeName: string; ADBFileName: string='');
  procedure DestroyHiASMaterialCodeClient();

  function GetMaterialCodeByCode(const AMatCode, AMatName: string): TOrmMaterialCode;
  function GetOrderPriceByCode(const AMatCode, AMatName: string): string;
  function GetMaterialCodeByCauseHW(const AClaimCauseHW: integer): TOrmMaterialCode;

  procedure AddMaterialCodeFromVariant(AVar: variant);
  procedure AddOrUpdateMaterialCode(AOrm: TOrmMaterialCode);

var
  g_HiASMaterialCodeDB: TRestClientURI;
  HiASMaterialCodeModel: TOrmModel;

implementation

uses UnitFolderUtil2, UnitRttiUtil2;

function CreateModelHiASMaterialCode: TOrmModel;
begin
  result := TOrmModel.Create([TOrmMaterialCode]);
end;

procedure InitHiASMaterialCodeClient(AExeName: string; ADBFileName: string='');
var
  LStr, LFileName, LFilePath: string;
begin
  if Assigned(g_HiASMaterialCodeDB) then
    exit;

  if AExeName = '' then
    AExeName := Application.ExeName;

  LStr := ExtractFileExt(AExeName);
  LFileName := ExtractFileName(AExeName);
  LFilePath := ExtractFilePath(AExeName);

  if LStr = '.exe' then
  begin
    LFileName := ChangeFileExt(ExtractFileName(AExeName),'.sqlite');
    LFileName := LFileName.Replace('.sqlite', '_MaterialCode.sqlite');
    LFilePath := GetSubFolderPath(LFilePath, 'db');
  end;

  LFilePath := EnsureDirectoryExists(LFilePath);

  if ADBFileName = '' then
    LStr := LFilePath + LFileName
  else
    LStr := ADBFileName;

  HiASMaterialCodeModel:= CreateModelHiASMaterialCode;

  g_HiASMaterialCodeDB:= TSQLRestClientDB.Create(HiASMaterialCodeModel, CreateModelHiASMaterialCode,
    LStr, TSQLRestServerDB);
  TSQLRestClientDB(g_HiASMaterialCodeDB).Server.CreateMissingTables;
end;

procedure DestroyHiASMaterialCodeClient();
begin
  if Assigned(g_HiASMaterialCodeDB) then
    FreeAndNil(g_HiASMaterialCodeDB);

  if Assigned(HiASMaterialCodeModel) then
    FreeAndNil(HiASMaterialCodeModel);
end;

function GetMaterialCodeByCode(const AMatCode, AMatName: string): TOrmMaterialCode;
begin
  if AMatCode = '' then
    Result := TOrmMaterialCode.CreateAndFillPrepare(g_HiASMaterialCodeDB.orm, 'MaterialName LIKE ?', ['%'+AMatName+'%'])
  else
    Result := TOrmMaterialCode.CreateAndFillPrepare(g_HiASMaterialCodeDB.orm, 'MaterialCode = ? and MaterialName LIKE ?', [AMatCode, '%'+AMatName+'%']);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetOrderPriceByCode(const AMatCode, AMatName: string): string;
var
  LOrm: TOrmMaterialCode;
begin
  Result := '';

  if AMatCode = '' then
    LOrm := TOrmMaterialCode.CreateAndFillPrepare(g_HiASMaterialCodeDB.orm, 'MaterialName LIKE ?', ['%'+AMatName+'%'])
  else
    LOrm := TOrmMaterialCode.CreateAndFillPrepare(g_HiASMaterialCodeDB.orm, 'MaterialCode = ? and MaterialName LIKE ?', [AMatCode, '%'+AMatName+'%']);

  try
    if LOrm.FillOne then
      Result := LOrm.OrderPrice;
  finally
    LOrm.Free;
  end;
end;

function GetMaterialCodeByCauseHW(const AClaimCauseHW: integer): TOrmMaterialCode;
begin
  if AClaimCauseHW = -1 then
    exit;

    Result := TOrmMaterialCode.CreateAndFillPrepare(g_HiASMaterialCodeDB.orm, 'MaterialKind = ?', [AClaimCauseHW]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

procedure AddMaterialCodeFromVariant(AVar: variant);
var
  LCode, LName: string;
  LOrmMaterialCode: TOrmMaterialCode;
begin
  LCode := AVar.MaterialCode;
  LName := AVar.MaterialName;

  LOrmMaterialCode := GetMaterialCodeByCode(LCode, LName);
  try
    LoadRecordPropertyFromVariant(LOrmMaterialCode, AVar);
    AddOrUpdateMaterialCode(LOrmMaterialCode);
  finally
    FreeAndNil(LOrmMaterialCode);
  end;
end;

procedure AddOrUpdateMaterialCode(AOrm: TOrmMaterialCode);
begin
  if AOrm.IsUpdate then
  begin
    g_HiASMaterialCodeDB.Update(AOrm);
  end
  else
  begin
    g_HiASMaterialCodeDB.Add(AOrm, true);
  end;
end;

initialization
finalization
  DestroyHiASMaterialCodeClient();

end.
