unit UnitHiConReportWorkItemOrm;

interface

uses SysUtils, Classes, Generics.Collections, Forms,
  mormot.core.base, mormot.orm.core, mormot.rest.client, mormot.core.os,
  mormot.rest.sqlite3, mormot.orm.base, mormot.core.data, mormot.core.variants,


type
  TOrmHiconReportDetail = class(TOrm)
  private
    fReportKey4Item, //Report KeyID
    fWorkItemKey     //WorkItem KeyID
    : TTimeLog;
    fWorkDetail,//������
    fWorkDetailRemark//�������߰�
    : RawUTF8;

    fWorkCode, //WorkCode(g_HiRptWorkCode)
    fWorkHours //�����ð�
    : integer;

    FIsUpdate: Boolean;

    fWorkItemBeginTime,//���� ���� �ð�
    fWorkItemEndTime,//���� ���� �ð�
    fModifyDate_Item
    :TTimeLog;
  public
    //True : DB Update, False: DB Add
    property IsUpdate: Boolean read FIsUpdate write FIsUpdate;
  published
    property ReportKey4Item: TTimeLog read fReportKey4Item write fReportKey4Item;
    property WorkItemKey : TTimeLog read fWorkItemKey write fWorkItemKey;
    property WorkDetail: RawUTF8 read fWorkDetail write fWorkDetail;
    property WorkDetailRemark: RawUTF8 read fWorkDetailRemark write fWorkDetailRemark;

    property WorkCode : integer read fWorkCode write fWorkCode;
    property WorkHours: integer read fWorkHours write fWorkHours;

    property WorkItemBeginTime: TTimeLog read fWorkItemBeginTime write fWorkItemBeginTime;
    property WorkItemEndTime: TTimeLog read fWorkItemEndTime write fWorkItemEndTime;





  procedure DestroyHiconReportDetailClient();






  procedure AddHiconReportDetailFromVarAry(AJsonAry: variant; AOnlyAdd: Boolean=False);
  procedure AddOrUpdateHiconReportDetail(AOrm: TOrmHiconReportDetail; AOnlyAdd: Boolean=false);

  procedure DeleteHiconReportDetailByRptKey(const AKeyID: TTimeLog);
  procedure DeleteHiconReportDetailByItemKey(const AKeyID: TTimeLog);

var
  g_HiconReportDetailDB: TRestClientURI;
  HiconReportDetailModel: TOrmModel;

implementation

uses UnitFolderUtil2, UnitRttiUtil2, UnitDateUtil;

function CreateModelHiconReportDetail: TOrmModel;
begin
  result := TOrmModel.Create([TOrmHiconReportDetail]);
end;

procedure InitHiconReportDetailClient(AExeName: string; ADBFileName: string='');
var
  LStr, LFileName, LFilePath: string;
begin
  if Assigned(g_HiconReportDetailDB) then
    exit;

  if AExeName = '' then
    AExeName := Application.ExeName;

  LStr := ExtractFileExt(AExeName);
  LFileName := ExtractFileName(AExeName);
  LFilePath := ExtractFilePath(AExeName);

  if LStr = '.exe' then
  begin
    LFileName := ChangeFileExt(ExtractFileName(AExeName),'.sqlite');
    LFileName := LFileName.Replace('.sqlite', '_WorkItem.sqlite');
    LFilePath := GetSubFolderPath(LFilePath, 'db');
  end;

  LFilePath := EnsureDirectoryExists(LFilePath);

  if ADBFileName = '' then
    LStr := LFilePath + LFileName
  else
    LStr := ADBFileName;

  HiconReportDetailModel:= CreateModelHiconReportDetail;

  g_HiconReportDetailDB:= TSQLRestClientDB.Create(HiconReportDetailModel, CreateModelHiconReportDetail,
    LStr, TSQLRestServerDB);
  TSQLRestClientDB(g_HiconReportDetailDB).Server.CreateMissingTables;
end;

procedure DestroyHiconReportDetailClient();

  if Assigned(g_HiconReportDetailDB) then
    FreeAndNil(g_HiconReportDetailDB);

  if Assigned(HiconReportDetailModel) then



function GetHiconReportDetailByReportKey(const AKeyID: TTimeLog): TOrmHiconReportDetail;
begin
  Result := TOrmHiconReportDetail.CreateAndFillPrepare(g_HiconReportDetailDB.orm, 'ReportKey4Item = ?', [AKeyID]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetHiconReportDetailByItemKey(const AKeyID: TTimeLog): TOrmHiconReportDetail;
begin
  Result := TOrmHiconReportDetail.CreateAndFillPrepare(g_HiconReportDetailDB.orm, 'WorkItemKey = ?', [AKeyID]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetHiRptDetailJsonAryByReportKey(const AKeyID: TTimeLog): variant;
var
  LOrmHiconReportDetail: TOrmHiconReportDetail;
  LDocList: IList<TOrmHiconReportDetail>;
  LUtf8: RawUtf8;
begin
  LOrmHiconReportDetail := TOrmHiconReportDetail.CreateAndFillPrepare(g_HiconReportDetailDB.orm, 'ReportKey4Item = ?', [AKeyID]);
  try
    LDocList := LOrmHiconReportDetail.FillTable.ToIList<TOrmHiconReportDetail>;
    LUtf8 := LDocList.Data.SaveToJson();
    Result := _JSON(LUtf8);
  finally
    LOrmHiconReportDetail.Free;
  end;
end;

procedure AddHiconReportDetailFromVariant(AVar: variant; AOnlyAdd: Boolean);
var
  LKeyID: TTimeLog;
  LOrmHiconReportDetail: TOrmHiconReportDetail;
begin
  if AOnlyAdd then
    LOrmHiconReportDetail := TOrmHiconReportDetail.Create
  else
  begin
    LKeyID := AVar.WorkItemKey;
    LOrmHiconReportDetail := GetHiconReportDetailByItemKey(LKeyID);
  end;

  try
    LoadRecordPropertyFromVariant(LOrmHiconReportDetail, AVar);
    AddOrUpdateHiconReportDetail(LOrmHiconReportDetail, AOnlyAdd);
  finally
    FreeAndNil(LOrmHiconReportDetail);
  end;
end;

procedure AddHiconReportDetailFromVarAry(AJsonAry: variant; AOnlyAdd: Boolean);
var
  LDocList: IDocList;
  LAryUtf8: RawUtf8;
  LVar: variant;
begin
  LAryUtf8 := AJsonAry;
  LDocList := DocList(LAryUtf8);

  for LVar in LDocList do
  begin
    AddHiconReportDetailFromVariant(LVar, AOnlyAdd);
  end;//for
end;

procedure AddOrUpdateHiconReportDetail(AOrm: TOrmHiconReportDetail; AOnlyAdd: Boolean);
begin
  if AOnlyAdd then
    g_HiconReportDetailDB.Add(AOrm, true)
  else
  if AOrm.IsUpdate then
  begin
    g_HiconReportDetailDB.Update(AOrm);
  end
  else
  begin
    g_HiconReportDetailDB.Add(AOrm, true);
  end;
end;

procedure DeleteHiconReportDetailByRptKey(const AKeyID: TTimeLog);
begin
  g_HiconReportDetailDB.Delete(TOrmHiconReportDetail, 'ReportKey4Item = ?', [AKeyID]);
end;

procedure DeleteHiconReportDetailByItemKey(const AKeyID: TTimeLog);
begin
  g_HiconReportDetailDB.Delete(TOrmHiconReportDetail, 'WorkItemKey = ?', [AKeyID]);
end;

initialization
finalization


end.