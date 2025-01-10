unit UnitHiConReportWorkItemOrm;

interface

uses SysUtils, Classes, Generics.Collections, Forms,
  mormot.core.base, mormot.orm.core, mormot.rest.client, mormot.core.os,
  mormot.rest.sqlite3, mormot.orm.base, mormot.core.data, mormot.core.variants,
  mormot.core.datetime, mormot.core.collections, mormot.core.json;

type
  TOrmHiconReportDetail = class(TOrm)
  private
    fReportKey4Item, //Report KeyID
    fWorkItemKey     //WorkItem KeyID
    : TTimeLog;
    fWorkDetail,//업무상세
    fWorkDetailRemark//업무상세추가
    : RawUTF8;

    fWorkCode //WorkCode(g_HiRptWorkCode)
    : integer;

    fWorkHours //업무시간
    : Double;

    FIsUpdate: Boolean;

    fWorkItemBeginTime,//업무 시작 시간
    fWorkItemEndTime,//업무 종료 시간
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
    property WorkHours: Double read fWorkHours write fWorkHours;

    property WorkItemBeginTime: TTimeLog read fWorkItemBeginTime write fWorkItemBeginTime;
    property WorkItemEndTime: TTimeLog read fWorkItemEndTime write fWorkItemEndTime;
    property ModifyDate_Item: TTimeLog read fModifyDate_Item write fModifyDate_Item;
  end;

  function CreateModelHiconReportDetail: TOrmModel;
  procedure InitHiconReportDetailClient(AExeName: string; ADBFileName: string='');
  procedure DestroyHiconReportDetailClient();

  function GetHiconReportDetailByReportKey(const AKeyID: string): TOrmHiconReportDetail; overload;
  function GetHiconReportDetailByReportKey(const AKeyID: TTimeLog): TOrmHiconReportDetail; overload;
  function GetHiconReportDetailByItemKey(const AKeyID: TTimeLog): TOrmHiconReportDetail;
  function GetHiconReportDetailByReportNItemKey(const AReportKey, AItemKey: TTimeLog): TOrmHiconReportDetail; overload;
  function GetHiconReportDetailByReportNItemKey(const AReportKey, AItemKey: string): TOrmHiconReportDetail; overload;
  function GetHiRptDetailJsonAryByReportKey(const AKeyID: TTimeLog): RawUtf8;
  function GetRptKeyJsonAryByWorkCode(const AWorkCode: integer): RawUtf8;

  procedure AddHiconReportDetailFromVariant(AVar: variant; AOnlyAdd: Boolean);
  procedure AddHiconReportDetailFromVarAry(AJsonAry: variant; AOnlyAdd: Boolean=False);
  procedure AddOrUpdateHiconReportDetail(AOrm: TOrmHiconReportDetail; AOnlyAdd: Boolean=false);
  function AddOrUpdateHiconReportDetailFromJsonAryByKeyId(const AJsonAry: string; const ADoUpdate: Boolean): Integer;

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
begin
  if Assigned(g_HiconReportDetailDB) then
    FreeAndNil(g_HiconReportDetailDB);

  if Assigned(HiconReportDetailModel) then
    FreeAndNil(HiconReportDetailModel);
end;

function GetHiconReportDetailByReportKey(const AKeyID: string): TOrmHiconReportDetail;
var
  LKeyId: TTimeLog;
begin
  LKeyId := StrToInt64(AKeyID);
  Result := GetHiconReportDetailByReportKey(LKeyId);
end;

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

function GetHiconReportDetailByReportNItemKey(const AReportKey, AItemKey: TTimeLog): TOrmHiconReportDetail;
begin
  Result := TOrmHiconReportDetail.CreateAndFillPrepare(g_HiconReportDetailDB.orm,
    'ReportKey4Item = ? AND WorkItemKey = ?', [AReportKey, AItemKey]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetHiconReportDetailByReportNItemKey(const AReportKey, AItemKey: string): TOrmHiconReportDetail; overload;
var
  LRptKey, LItemKey: TTimeLog;
begin
  LRptKey := StrToInt64(AReportKey);
  LItemKey := StrToInt64(AItemKey);

  Result := GetHiconReportDetailByReportNItemKey(LRptKey, LItemKey);
end;

function GetHiRptDetailJsonAryByReportKey(const AKeyID: TTimeLog): RawUtf8;
var
  LOrmHiconReportDetail: TOrmHiconReportDetail;
  LDocList: IList<TOrmHiconReportDetail>;
  LUtf8: RawUtf8;
begin
  LOrmHiconReportDetail := TOrmHiconReportDetail.CreateAndFillPrepare(g_HiconReportDetailDB.orm, 'ReportKey4Item = ?', [AKeyID]);
  try
    LDocList := LOrmHiconReportDetail.FillTable.ToIList<TOrmHiconReportDetail>;
    LUtf8 := LDocList.Data.SaveToJson();
    Result := LUtf8
  finally
    LOrmHiconReportDetail.Free;
  end;
end;

function GetRptKeyJsonAryByWorkCode(const AWorkCode: integer): RawUtf8;
var
  LOrmHiconReportDetail: TOrmHiconReportDetail;
  LDocList: IList<TOrmHiconReportDetail>;
  LUtf8: RawUtf8;
begin
  LOrmHiconReportDetail := TOrmHiconReportDetail.CreateAndFillPrepare(g_HiconReportDetailDB.orm, 'WorkCode = ?', [AWorkCode]);
  try
    LDocList := LOrmHiconReportDetail.FillTable.ToIList<TOrmHiconReportDetail>;
    LUtf8 := LDocList.Data.SaveToJson();
    Result := LUtf8;
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

function AddOrUpdateHiconReportDetailFromJsonAryByKeyId(const AJsonAry: string;
  const ADoUpdate: Boolean): Integer;
var
  LOrm: TOrmHiconReportDetail;
  LRptKey, LItemKey: int64;
  LDict: IDocDict;
  LDocList: IDocList;
  LAryUtf8: RawUtf8;
  LVar: variant;
begin
  Result := 0;

  TDocVariant.New(LVar);

  LAryUtf8 := AJsonAry;
  LDocList := DocList(LAryUtf8);

  for LVar in LDocList do
  begin
    LRptKey := LVar.ReportKey4Item;
    LItemKey := LVar.WorkItemKey;

    LOrm := GetHiconReportDetailByReportNItemKey(LRptKey, LItemKey);
    try
      if LOrm.IsUpdate then
      begin
        if ADoUpdate then
        begin
          AddHiconReportDetailFromVariant(LVar, False);
          Inc(Result);
        end;
      end
      else
      begin
        AddHiconReportDetailFromVariant(LVar, True);
        Inc(Result);
      end;
    finally
      LOrm.Free;
    end;
  end;//for
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
  DestroyHiconReportDetailClient();

end.
