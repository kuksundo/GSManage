unit UnitHiConChgRegItemOrm;

interface

uses SysUtils, Classes, Generics.Collections, Forms,
  mormot.core.base, mormot.orm.core, mormot.rest.client, mormot.core.os,
  mormot.rest.sqlite3, mormot.orm.base, mormot.core.data, mormot.core.variants,


type
  TOrmHiChgRegItem = class(TOrm)
  private
    fReportKey: TTimeLog;
    fChgRegRptNo,
    fTitle,
    fSystemName,
    fDocRef,
    fChapter,
    fInitiaedDuring,
    fReqSrc,
    fModification,
    fModDetail,
    fPlan_Engineer,
    fPlan_ClosePIC,
    fPlan_Finish,
    fEstimatedWorkHour,
    fImportance,
    fOpen_PIC,
    fTest_PIC,
    fClose_PIC
    : RawUTF8;

    fRegDate,
    fOpen_Date,
    fTest_Date,
    fCLose_Date,
    fModifyDate
    : TTimeLog;

    FIsUpdate
    :Boolean;
  public
    //True : DB Update, False: DB Add
    property IsUpdate: Boolean read FIsUpdate write FIsUpdate;
  published
    property ReportKey4ChgReg : TTimeLog read fReportKey write fReportKey;
    property ChgRegRptNo: RawUTF8 read fChgRegRptNo write fChgRegRptNo;
    property Title: RawUTF8 read fTitle write fTitle;
    property SystemName: RawUTF8 read fSystemName write fSystemName;
    property DocRef: RawUTF8 read fDocRef write fDocRef;
    property Chapter: RawUTF8 read fChapter write fChapter;
    property InitiaedDuring: RawUTF8 read fInitiaedDuring write fInitiaedDuring;
    property ReqSrc: RawUTF8 read fReqSrc write fReqSrc;
    property Modification: RawUTF8 read fModification write fModification;
    property ModDetail: RawUTF8 read fModDetail write fModDetail;
    property Plan_Engineer: RawUTF8 read fPlan_Engineer write fPlan_Engineer;
    property Plan_ClosePIC: RawUTF8 read fPlan_ClosePIC write fPlan_ClosePIC;
    property Plan_Finish: RawUTF8 read fPlan_Finish write fPlan_Finish;
    property EstimatedWorkHour: RawUTF8 read fEstimatedWorkHour write fEstimatedWorkHour;
    property Importance: RawUTF8 read fImportance write fImportance;
    property Open_PIC: RawUTF8 read fOpen_PIC write fOpen_PIC;
    property Test_PIC: RawUTF8 read fTest_PIC write fTest_PIC;
    property Close_PIC: RawUTF8 read fClose_PIC write fClose_PIC;

    property RegDate: TTimeLog read fRegDate write fRegDate;
    property Open_Date: TTimeLog read fOpen_Date write fOpen_Date;
    property Test_Date: TTimeLog read fTest_Date write fTest_Date;
    property CLose_Date: TTimeLog read fCLose_Date write fCLose_Date;
    property ModifyDate_ChgReg: TTimeLog read fModifyDate write fModifyDate;
  end;

  function CreateModelHiChgRegItem: TOrmModel;
  procedure InitHiChgRegItemClient(AExeName: string; ADBFileName: string='');
  procedure DestroyHiChgRegItemlClient();

  function GetHiChgRegItemByReportKey(const AKeyID: string): TOrmHiChgRegItem; overload;
  function GetHiChgRegItemByReportKey(const AKeyID: TTimeLog): TOrmHiChgRegItem; overload;


  function GetHiChgRegItemByReportNHcrNo(const AReportKey, AHcrNo: string): TOrmHiChgRegItem; overload;




  procedure AddOrUpdateHiChgRegItem(AOrm: TOrmHiChgRegItem; AOnlyAdd: Boolean=false);
  function AddOrUpdateHiChgRegItemFromJsonAryByKeyId(const AJsonAry: string; const ADoUpdate: Boolean): Integer;

  procedure DeleteHiChgRegItemByRptKey(const AKeyID: TTimeLog);
  procedure DeleteHiChgRegItemByHcrNo(const AHcrNo: string);


  g_HiChgRegItemDB: TRestClientURI;
  HiChgRegItemModel: TOrmModel;

implementation

uses UnitFolderUtil2, UnitRttiUtil2;

function CreateModelHiChgRegItem: TOrmModel;
begin
  result := TOrmModel.Create([TOrmHiChgRegItem]);
end;

procedure InitHiChgRegItemClient(AExeName: string; ADBFileName: string='');
var
  LStr, LFileName, LFilePath: string;
begin
  if Assigned(g_HiChgRegItemDB) then
    exit;

  if AExeName = '' then
    AExeName := Application.ExeName;

  LStr := ExtractFileExt(AExeName);
  LFileName := ExtractFileName(AExeName);
  LFilePath := ExtractFilePath(AExeName);

  if LStr = '.exe' then
  begin
    LFileName := ChangeFileExt(ExtractFileName(AExeName),'.sqlite');
    LFileName := LFileName.Replace('.sqlite', '_ChgRegItem.sqlite');
    LFilePath := GetSubFolderPath(LFilePath, 'db');
  end;

  LFilePath := EnsureDirectoryExists(LFilePath);

  if ADBFileName = '' then
    LStr := LFilePath + LFileName
  else
    LStr := ADBFileName;

  HiChgRegItemModel:= CreateModelHiChgRegItem;

  g_HiChgRegItemDB:= TSQLRestClientDB.Create(HiChgRegItemModel, CreateModelHiChgRegItem,
    LStr, TSQLRestServerDB);
  TSQLRestClientDB(g_HiChgRegItemDB).Server.CreateMissingTables;
end;

procedure DestroyHiChgRegItemlClient();


    FreeAndNil(g_HiChgRegItemDB);

  if Assigned(HiChgRegItemModel) then



function GetHiChgRegItemByReportKey(const AKeyID: string): TOrmHiChgRegItem; overload;
var
  LKeyId: TTimeLog;
begin
  LKeyId := StrToInt64(AKeyID);
  Result := GetHiChgRegItemByReportKey(LKeyId);
end;

function GetHiChgRegItemByReportKey(const AKeyID: TTimeLog): TOrmHiChgRegItem; overload;



  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;



  Result := TOrmHiChgRegItem.CreateAndFillPrepare(g_HiChgRegItemDB.orm, 'HcrNo = ?', [AHcrNo]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetHiChgRegItemByReportNHcrNo(const AReportKey: TTimeLog; AHcrNo: string): TOrmHiChgRegItem; overload;
begin
  Result := TOrmHiChgRegItem.CreateAndFillPrepare(g_HiChgRegItemDB.orm,
    'ReportKey4ChgReg = ? AND HcrNo = ?', [AReportKey, AHcrNo]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetHiChgRegItemByReportNHcrNo(const AReportKey, AHcrNo: string): TOrmHiChgRegItem; overload;

  LRptKey, LItemKey: TTimeLog;
begin
  LRptKey := StrToInt64(AReportKey);

  Result := GetHiChgRegItemByReportNHcrNo(LRptKey, AHcrNo);
end;

function GetHiChgRegItemJsonAryByReportKey(const AKeyID: TTimeLog): variant;
var
  LOrmHiChgRegItem: TOrmHiChgRegItem;
  LDocList: IList<TOrmHiChgRegItem>;
  LUtf8: RawUtf8;
begin
  LOrmHiChgRegItem := TOrmHiChgRegItem.CreateAndFillPrepare(g_HiChgRegItemDB.orm, 'ReportKey4ChgReg = ?', [AKeyID]);
  try
    LDocList := LOrmHiChgRegItem.FillTable.ToIList<TOrmHiChgRegItem>;
    LUtf8 := LDocList.Data.SaveToJson();
    Result := _JSON(LUtf8);
  finally
    LOrmHiChgRegItem.Free;
  end;
end;

procedure AddHiChgRegItemFromVariant(AVar: variant; AOnlyAdd: Boolean);
var
  LHcrNo: string;
  LOrmHiChgRegItem: TOrmHiChgRegItem;
begin
  if AOnlyAdd then
    LOrmHiChgRegItem := TOrmHiChgRegItem.Create
  else
  begin
    LHcrNo := AVar.HcrNo;
    LOrmHiChgRegItem := GetHiChgRegItemByHcrNo(LHcrNo);
  end;

  try
    LoadRecordPropertyFromVariant(LOrmHiChgRegItem, AVar);
    AddOrUpdateHiChgRegItem(LOrmHiChgRegItem, AOnlyAdd);
  finally
    FreeAndNil(LOrmHiChgRegItem);
  end;
end;

procedure AddHiChgRegItemFromVarAry(AJsonAry: variant; AOnlyAdd: Boolean=False);
var
  LDocList: IDocList;
  LAryUtf8: RawUtf8;
  LVar: variant;
begin
  LAryUtf8 := AJsonAry;
  LDocList := DocList(LAryUtf8);

  for LVar in LDocList do
  begin
    AddHiChgRegItemFromVariant(LVar, AOnlyAdd);
  end;//for
end;

procedure AddOrUpdateHiChgRegItem(AOrm: TOrmHiChgRegItem; AOnlyAdd: Boolean=false);
begin
  if AOnlyAdd then
    g_HiChgRegItemDB.Add(AOrm, true)
  else
  if AOrm.IsUpdate then
  begin
    g_HiChgRegItemDB.Update(AOrm);
  end
  else
  begin
    g_HiChgRegItemDB.Add(AOrm, true);
  end;
end;

function AddOrUpdateHiChgRegItemFromJsonAryByKeyId(const AJsonAry: string; const ADoUpdate: Boolean): Integer;
var
  LOrm: TOrmHiChgRegItem;
  LRptKey: int64;
  LHcrNo: string;
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
    LRptKey := LVar.ReportKey4ChgReg;
    LHcrNo := LVar.HcrNo;

    LOrm := GetHiChgRegItemByReportNHcrNo(LRptKey, LHcrNo);
    try
      if LOrm.IsUpdate then
      begin
        if ADoUpdate then
        begin
          AddHiChgRegItemFromVariant(LVar, False);
          Inc(Result);
        end;
      end
      else
      begin
        AddHiChgRegItemFromVariant(LVar, True);
        Inc(Result);
      end;
    finally
      LOrm.Free;
    end;
  end;//for
end;

procedure DeleteHiChgRegItemByRptKey(const AKeyID: TTimeLog);
begin
  g_HiChgRegItemDB.Delete(TOrmHiChgRegItem, 'ReportKey4ChgReg = ?', [AKeyID]);
end;

procedure DeleteHiChgRegItemByHcrNo(const AHcrNo: string);
begin
  g_HiChgRegItemDB.Delete(TOrmHiChgRegItem, 'HcrNo = ?', [AHcrNo]);
end;

initialization
finalization


end.