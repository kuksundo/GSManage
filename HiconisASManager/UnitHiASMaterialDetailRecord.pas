unit UnitHiASMaterialDetailRecord;

interface

uses SysUtils, Classes, Generics.Collections, Forms,
  mormot.core.base, mormot.orm.core, mormot.rest.client, mormot.core.os,
  mormot.rest.sqlite3, mormot.orm.base, mormot.core.data, mormot.core.variants,






  //���������
  TSQLMaterialDetail = class(TSQLRecord)
  private
    fTaskID: TID;
    fPORNo: RawUTF8;
    fMaterialCode, //�����ڵ�
    fMaterialName, //�����
    fUnitPrice//���� �ܰ�
    : RawUTF8;
    fNeedDate, //�ҿ�����
    FCreateDate//���������
    : TTimeLog;
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










  procedure DestroyHiASMaterialDetailClient();




  procedure AddOrUpdateMaterialDetail(AOrm: TSQLMaterialDetail);


var
  g_HiASMaterialDetailDB: TSQLRestClientURI;
  HiASMaterialDetailModel: TSQLModel;



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


    FreeAndNil(g_HiASMaterialDetailDB);

  if Assigned(HiASMaterialDetailModel) then





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

function GetMaterialDetailByPorNoNMatCode(const APorNo, AMatCode: string): TSQLMaterialDetail;
begin
  if APorNo = '' then
    Result := TSQLMaterialDetail.CreateAndFillPrepare(g_HiASMaterialDetailDB.orm, 'MaterialCode = ?', [AMatCode])
  else
    Result := TSQLMaterialDetail.CreateAndFillPrepare(g_HiASMaterialDetailDB.orm, 'PORNo = ? and MaterialCode = ?', [APorNo, AMatCode]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;




  begin
    g_HiASMaterialDetailDB.Update(AOrm);
  end
  else
  begin
    g_HiASMaterialDetailDB.Add(AOrm, true);
  end;
end;





