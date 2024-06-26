unit UnitHiASMaterialDetailRecord;

interface

uses SysUtils, Classes, Generics.Collections, Forms,
  mormot.core.base, mormot.orm.core, mormot.rest.client, mormot.core.os,
  mormot.rest.sqlite3, mormot.orm.base, mormot.core.data, mormot.core.variants,
  mormot.core.datetime, mormot.core.json,

  UnitHiconisMasterRecord, CommonData2
  ;

type
  //���������
  TSQLMaterialDetail = class(TSQLRecord)
  private
    fTaskID: TID;
    fPORNo: RawUTF8;
    fMaterialCode, //�����ڵ�
    fMaterialName, //�����
    fUnitPrice//���� �ܰ�
    : RawUTF8;
    fNeedDate: TTimeLog;//�ҿ�����
    fNeedCount: integer;//����
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

  function GetMaterialDetailFromTask(ATask: TOrmHiconisASTask): TSQLMaterialDetail;


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
    LFileName := LFileName.Replace('.sqlite', '_Material.sqlite');
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


end.
