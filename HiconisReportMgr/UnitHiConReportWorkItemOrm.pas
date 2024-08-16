unit UnitHiConReportWorkItemOrm;

interface

uses SysUtils, Classes, Generics.Collections, Forms,
  mormot.core.base, mormot.orm.core, mormot.rest.client, mormot.core.os,
  mormot.rest.sqlite3, mormot.orm.base, mormot.core.data, mormot.core.variants,
  mormot.core.datetime, mormot.core.json;

type
  TOrmHiconReportDetail = class(TOrm)
  private
    fKeyID, //unique id(GUID)
    fWorkCode, //WorkCode
    fWorkDetail,//업무상세
    fWorkDetailRemark//업무상세추가
    : RawUTF8;

    fWorkHours //업무시간
    : integer;

    FIsUpdate: Boolean;

    fWorkBeginTime,//업무 시작 시간
    fWorkEndTime,//업무 종료 시간
    fModifyDate
    :TTimeLog;
  public
    //True : DB Update, False: DB Add
    property IsUpdate: Boolean read FIsUpdate write FIsUpdate;
  published
    property KeyID : RawUTF8 read fKeyID write fKeyID;
    property WorkCode : RawUTF8 read fWorkCode write fWorkCode;
    property WorkDetail: RawUTF8 read fWorkDetail write fWorkDetail;
    property WorkDetailRemark: RawUTF8 read fWorkDetailRemark write fWorkDetailRemark;

    property WorkHours: integer read fWorkHours write fWorkHours;

    property WorkBeginTime: TTimeLog read fWorkBeginTime write fWorkBeginTime;
    property WorkEndTime: TTimeLog read fWorkEndTime write fWorkEndTime;
    property ModifyDate: TTimeLog read fModifyDate write fModifyDate;
  end;

  function CreateModelHiconReportDetail: TOrmModel;
  procedure InitHiconReportDetailClient(AExeName: string; ADBFileName: string='');
  procedure DestroyHiconReportDetailClient();

  function GetHiconReportDetailByKeyID(const AKeyID: string): TOrmHiconReportDetail;

  procedure AddHiconReportDetailFromVariant(AVar: variant);
  procedure AddOrUpdateHiconReportDetail(AOrm: TOrmHiconReportDetail);

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
    LFileName := LFileName.Replace('.sqlite', '_Project.sqlite');
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

function GetHiconReportDetailByKeyID(const AKeyID: string): TOrmHiconReportDetail;
begin
  Result := TOrmHiconReportDetail.CreateAndFillPrepare(g_HiconReportDetailDB.orm, 'KeyID = ?', [AKeyID]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

procedure AddHiconReportDetailFromVariant(AVar: variant);
var
  LKeyID: string;
  LOrmHiconReportDetail: TOrmHiconReportDetail;
begin
  LKeyID := AVar.KeyID;

  LOrmHiconReportDetail := GetHiconReportDetailByKeyID(LKeyID);
  try
    LoadRecordPropertyFromVariant(LOrmHiconReportDetail, AVar);
    AddOrUpdateHiconReportDetail(LOrmHiconReportDetail);
  finally
    FreeAndNil(LOrmHiconReportDetail);
  end;
end;

procedure AddOrUpdateHiconReportDetail(AOrm: TOrmHiconReportDetail);
begin
  if AOrm.IsUpdate then
  begin
    g_HiconReportDetailDB.Update(AOrm);
  end
  else
  begin
    g_HiconReportDetailDB.Add(AOrm, true);
  end;
end;

initialization
finalization
  DestroyHiconReportDetailClient();

end.
