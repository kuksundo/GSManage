unit UnitHiASMaterialDetailRecord;

interface

uses SysUtils, Classes, Generics.Collections,
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
    fPORNo: RawUTF8;
    fMaterialCode, //자재코드
    fMaterialName, //자재명
    fUnitPrice//자재 단가
    : RawUTF8;
    fNeedDate: TTimeLog;//소요일자
    fNeedCount: integer;//수량
    fLeadTime: integer;

    FIsUpdate: Boolean;
  public
    //True : DB Update, False: DB Add
    property IsUpdate: Boolean read FIsUpdate write FIsUpdate;
  published
    property TaskID: TID read fTaskID write fTaskID;
    property PORNo: RawUTF8 read fPORNo write fPORNo;
    property MaterialCode: RawUTF8 read fMaterialCode write fMaterialCode;
    property MaterialName: RawUTF8 read fMaterialName write fMaterialName;
    property UnitPrice: RawUTF8 read fUnitPrice write fUnitPrice;

    property NeedDate: TTimeLog read fNeedDate write fNeedDate;
    property NeedCount: integer read fNeedCount write fNeedCount;
    property LeadTime: integer read fLeadTime write fLeadTime;
  end;

  function CreateModel_HiASMaterialDetail: TSQLModel;
  procedure InitHiASMaterialDetailClient(AExeName: string; ADBFileName: string='');
  procedure DestroyHiASMaterialDetailClient();

var
  g_HiASMaterialDetailDB: TSQLRestClientURI;
  HiASMaterialDetailModel: TSQLModel;

implementation

function CreateModel_HiASMaterialDetail: TSQLModel;
begin
  result := TSQLModel.Create([TSQLMaterialDetail]);
end;

procedure InitHiASMaterialDetailClient(AExeName: string; ADBFileName: string='');
var
  LStr, LFileName, LFilePath: string;
begin
  if Assigned(g_HiASMaterialDB) then
    exit;

  if AExeName = '' then
    AExeName := Application.ExeName;

  LStr := ExtractFileExt(AExeName);
  LFileName := ExtractFileName(AExeName);
  LFilePath := ExtractFilePath(AExeName);

  if LStr = '.exe' then
  begin
    LFileName := ChangeFileExt(ExtractFileName(AExeName),'.sqlite');
    LFileName := LFileName.Replace('.sqlite', '_Material.sqlite');
    LFilePath := GetSubFolderPath(LFilePath, 'db');
  end;

  LFilePath := EnsureDirectoryExists(LFilePath);

  if ADBFileName = '' then
    LStr := LFilePath + LFileName
  else
    LStr := ADBFileName;

  HiASMaterialModel:= CreateModel_HiASMaterialDetail;

  g_HiASMaterialDB:= TSQLRestClientDB.Create(HiASMaterialModel, CreateModel_HiASMaterialDetail,
    LStr, TSQLRestServerDB);
  TSQLRestClientDB(g_HiASMaterialDB).Server.CreateMissingTables;
end;

procedure DestroyHiASMaterialDetailClient();
begin

end;

end.
