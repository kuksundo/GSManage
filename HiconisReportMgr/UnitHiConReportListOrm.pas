unit UnitHiConReportListOrm;

interface

uses SysUtils, Classes, Generics.Collections, Forms,
  mormot.core.base, mormot.orm.core, mormot.rest.client, mormot.core.os,
  mormot.rest.sqlite3, mormot.orm.base, mormot.core.data, mormot.core.variants,
  mormot.core.datetime, mormot.core.json;

type
  TOrmHiconReportList = class(TOrm)
  private
    fKeyID, //unique id(GUID)
    fProjectNo, //공사번호
    fHullNo, //호선번호
    fVesselType, //선종
    fShipOwner, //선주
    fClassSociety, //선급
    fReportAuthorID, //보고서 작성자 ID
    fReportAuthorName, //보고서 작성자 이름
    fCurrentWorkDesc,//당일(주) 진행 업무
    fNextWorkDesc//다음(주) 진행 업무
    : RawUTF8;

    fReportKind, //보고서 종류
    fModifyItems //변경사항 집합
    : integer;

    FIsUpdate: Boolean;

    fReportMakeDate,//보고서 작성 일자
    fModifyDate
    :TTimeLog;
  public
    //True : DB Update, False: DB Add
    property IsUpdate: Boolean read FIsUpdate write FIsUpdate;
  published
    property KeyID : RawUTF8 read fKeyID write fKeyID;
    property ProjectNo : RawUTF8 read fProjectNo write fProjectNo;
    property HullNo: RawUTF8 read fHullNo write fHullNo;
    property ShipOwner: RawUTF8 read fShipOwner write fShipOwner;
    property ClassSociety: RawUTF8 read fClassSociety write fClassSociety;
    property ReportAuthorID: RawUTF8 read fReportAuthorID write fReportAuthorID;
    property ReportAuthorName: RawUTF8 read fReportAuthorName write fReportAuthorName;
    property CurrentWorkDesc : RawUTF8 read fCurrentWorkDesc write fCurrentWorkDesc;
    property NextWorkDesc: RawUTF8 read fNextWorkDesc write fNextWorkDesc;

    property ReportKind: integer read fReportKind write fReportKind;
    property ModifyItems: integer read fModifyItems write fModifyItems;

    property ReportMakeDate: TTimeLog read fReportMakeDate write fReportMakeDate;
    property ModifyDate: TTimeLog read fModifyDate write fModifyDate;
  end;

  function CreateModelHiconReportList: TOrmModel;
  procedure InitHiconReportListClient(AExeName: string; ADBFileName: string='');
  procedure DestroyHiconReportListClient();

  function GetHiconReportListByKeyID(const AKeyID: string): TOrmHiconReportList;
  function GetHiconReportListByProjectNo(const AProjNo: string): TOrmHiconReportList;
  function GetHiconReportListByHullNo(const AHullNo: string): TOrmHiconReportList;
  function GetHiReportListByHullNoNMakeDate(const AHullNo: string; AReportMakeDate: TTimeLog): TOrmHiconReportList;
  function GetHiconReportListByReportKind(AReportKind: integer; AHullNo: string=''): TOrmHiconReportList;

  procedure AddHiconReportListFromVariant(AVar: variant);
  procedure AddOrUpdateHiconReportList(AOrm: TOrmHiconReportList);

var
  g_HiconReportListDB: TRestClientURI;
  HiconReportListModel: TOrmModel;

implementation

uses UnitFolderUtil2, UnitRttiUtil2, UnitDateUtil;

function CreateModelHiconReportList: TOrmModel;
begin
  result := TOrmModel.Create([TOrmHiconReportList]);
end;

procedure InitHiconReportListClient(AExeName: string; ADBFileName: string='');
var
  LStr, LFileName, LFilePath: string;
begin
  if Assigned(g_HiconReportListDB) then
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

  HiconReportListModel:= CreateModelHiconReportList;

  g_HiconReportListDB:= TSQLRestClientDB.Create(HiconReportListModel, CreateModelHiconReportList,
    LStr, TSQLRestServerDB);
  TSQLRestClientDB(g_HiconReportListDB).Server.CreateMissingTables;
end;

procedure DestroyHiconReportListClient();
begin
  if Assigned(g_HiconReportListDB) then
    FreeAndNil(g_HiconReportListDB);

  if Assigned(HiconReportListModel) then
    FreeAndNil(HiconReportListModel);
end;

function GetHiconReportListByKeyID(const AKeyID: string): TOrmHiconReportList;
begin
  Result := TOrmHiconReportList.CreateAndFillPrepare(g_HiconReportListDB.orm, 'KeyID = ?', [AKeyID]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetHiconReportListByProjectNo(const AProjNo: string): TOrmHiconReportList;
begin
  Result := TOrmHiconReportList.CreateAndFillPrepare(g_HiconReportListDB.orm, 'ProjectNo LIKE ?', ['%'+AProjNo+'%']);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetHiconReportListByHullNo(const AHullNo: string): TOrmHiconReportList;
begin
  Result := TOrmHiconReportList.CreateAndFillPrepare(g_HiconReportListDB.orm, 'HullNo LIKE ?', ['%'+AHullNo+'%']);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetHiReportListByHullNoNMakeDate(const AHullNo: string;
  AReportMakeDate: TTimeLog): TOrmHiconReportList;
begin
  Result := TOrmHiconReportList.CreateAndFillPrepare(g_HiconReportListDB.orm,
    'HullNo = ? AND ReportMakeDate = ?', [AHullNo, AReportMakeDate]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetHiconReportListByReportKind(AReportKind: integer; AHullNo: string=''): TOrmHiconReportList;
begin
  if AHullNo = '' then
    Result := TOrmHiconReportList.CreateAndFillPrepare(g_HiconReportListDB.orm,
      'ReportKind = ?', [AReportKind])
  else
    Result := TOrmHiconReportList.CreateAndFillPrepare(g_HiconReportListDB.orm,
      'HullNo = ? AND ReportMakeDate = ?', [AReportKind, AHullNo]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

procedure AddHiconReportListFromVariant(AVar: variant);
var
  LKeyID: string;
  LOrmHiconReportList: TOrmHiconReportList;
begin
  LKeyID := AVar.KeyID;

  LOrmHiconReportList := GetHiconReportListByKeyID(LKeyID);
  try
    LoadRecordPropertyFromVariant(LOrmHiconReportList, AVar);
    AddOrUpdateHiconReportList(LOrmHiconReportList);
  finally
    FreeAndNil(LOrmHiconReportList);
  end;
end;

procedure AddOrUpdateHiconReportList(AOrm: TOrmHiconReportList);
begin
  if AOrm.IsUpdate then
  begin
    g_HiconReportListDB.Update(AOrm);
  end
  else
  begin
    g_HiconReportListDB.Add(AOrm, true);
  end;
end;

initialization
finalization
  DestroyHiconReportListClient();

end.
