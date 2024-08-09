unit UnitHiASToDoRecord;

interface

uses SysUtils, Classes, Generics.Collections,
  mormot.core.base, mormot.orm.core, mormot.rest.client, mormot.core.os,
  mormot.rest.sqlite3, mormot.orm.base, mormot.core.data, mormot.core.variants,
  mormot.core.datetime, mormot.core.json, mormot.core.collections,

  UnitHiconisMasterRecord, CommonData2, UnitToDoList
  ;

type
  TToDoSearchRec = record
    From, FTo: TDateTime;
    QueryDate: TTodoQueryDateType;

    TaskID: TID;
    HullNo,
    ShipName,
    OrderNo,
    ClaimNo,
    Subject
    : RawUtf8;

    CreationDate,
    DueDate,
    CompletionDate,
    ModDate,
    AlarmTime1 //알람 발생 시각
    : TTimeLog;
  end;

  TSQLToDoItem = class(TSQLRecord)
  private
    fTaskID: TID;
    fOLObjectKind: integer; //TOLObjectKind
    FUniqueID, //ToDo 생성 시에 RowID를 알기 어렵기 때문에 UniqueID를 대신 사용하여 CRUD를 수행함
    FEntryId,
    FStoreId,
    FEmailEntryId,
    FEmailStoreId,
    FPlan_Code,
    FSubject,
    FNotes,
    FToDoReourece,
    FModId,
    FCategory,
    FProject,
    FResource: string;

    FCreationDate,
    FDueDate,
    FCompletionDate,
    FModDate,
    FAlarmTime1 //알람 발생 시각
    : TTimeLog;

    FImageIndex,
    FTag,
    FCompletion,
    FStatus,
    FPriority,
    FAlarmTime2,
    FAlarmFlag,
    FAlarmType
    : integer;
    FAlarm2Msg,
    FAlarm2Note,
    FAlarm2Email,
    FAlarm2Popup
    : Boolean;

    FTotalTime: double;

    FComplete,
    FIsUpdate: Boolean;
  public
    property IsUpdate: Boolean read FIsUpdate write FIsUpdate;
  published
    property TaskID: TID read fTaskID write fTaskID;
    property EntryId: string read FEntryId write FEntryId;
    property StoreId: string read FStoreId write FStoreId;
    property EmailEntryId: string read FEmailEntryId write FEmailEntryId;
    property EmailStoreId: string read FEmailStoreId write FEmailStoreId;
    property UniqueID: string read FUniqueID write FUniqueID;
    property Plan_Code: string read FPlan_Code write FPlan_Code;
    property Subject: string read FSubject write FSubject;
    property Notes: string read FNotes write FNotes;
    property ToDoReourece: string read FToDoReourece write FToDoReourece;
    property ModId: string read FModId write FModId;
    property Categories: string read FCategory write FCategory;
    property Project: string read FProject write FProject;
    property Resource: string read FResource write FResource;

    property CreationDate: TTimeLog read FCreationDate write FCreationDate;
    property DueDate: TTimeLog read FDueDate write FDueDate;
    property CompletionDate: TTimeLog read FCompletionDate write FCompletionDate;
    property ModDate: TTimeLog read FModDate write FModDate;
    property AlarmTime1: TTimeLog read FAlarmTime1 write FAlarmTime1;
    property AlarmTime2: integer read FAlarmTime2 write FAlarmTime2;

    property ImageIndex: Integer read FImageIndex write FImageIndex;
    property Tag: Integer read FTag write FTag;
    property Completion: integer read FCompletion write FCompletion;
    property Complete: Boolean read FComplete write FComplete;
    property Status: integer read FStatus write FStatus;
    property Priority: integer read FPriority write FPriority;
    property TotalTime: double read FTotalTime write FTotalTime;
    property AlarmType: integer read FAlarmType write FAlarmType;
    property AlarmFlag: integer read FAlarmFlag write FAlarmFlag;
    property Alarm2Msg: Boolean read FAlarm2Msg write FAlarm2Msg;
    property Alarm2Note: Boolean read FAlarm2Note write FAlarm2Note;
    property Alarm2Email: Boolean read FAlarm2Email write FAlarm2Email;
    property Alarm2Popup: Boolean read FAlarm2Popup write FAlarm2Popup;
  end;

  function CreateModel_HiASToDo: TSQLModel;
  procedure InitHiASToDoClient(AExeName: string; ADBFileName: string='');
  procedure DestroyHiASToDoClient();

  //TaskID 모든 TodoItem을 Get
  function GetOrmToDoListFromDBByTask(ATask: TOrmHiconisASTask): TSQLToDoItem;
  //한개의 Item만 Get
  function GetOrmToDoItemFromDBByTodoItemRec(ApjhTodoItem: TpjhTodoItemRec): TSQLToDoItem;
  //TaskID 모든 TodoItem을 Get
  //AIsAdd : True = TPjhToDoList에 Add함
  //         False = TPjhToDoList를 Clear 후 Add 함
  procedure GetToDoListFromDBByTask(ATask: TOrmHiconisASTask; var AToDoList: TpjhToDoList);
  //TaskID 모든 TodoItem을 Delete
  procedure DeleteToDoListFromTask(ATask: TOrmHiconisASTask);
  //한개의 Item만 Delete
  procedure DeleteToDoItemFromDB(ApjhTodoItem: TpjhTodoItemRec; ADB: TSQLRestClientURI=nil);
  function DeleteToDoRecFromDBByUniqueID(AUniqueID: string; ADB: TSQLRestClientURI=nil): Boolean;

  procedure AddOrUpdateToDoItemRec2DB(ApjhTodoItemRec: TpjhTodoItemRec; ADB: TSQLRestClientURI=nil );
  procedure AddOrUpdateToDoItem2DBByJson(AJson: RawUtf8; ADB: TSQLRestClientURI=nil );
  procedure AddToDoListFromTask(ATask: TOrmHiconisASTask; var AToDoList: TpjhToDoList);

  procedure AssignpjhTodoItemToSQLToDoItem(ApjhTodoItem: TpjhTodoItemRec; ASQLToDoItem: TSQLToDoItem);
  procedure AssignSQLToDoItemTopjhTodoItem(ASQLToDoItem: TSQLToDoItem; ApjhTodoItem: TpjhTodoItemRec);

  function GetTodoListOrmFromSearchRec(ASearchRec: TToDoSearchRec): TSQLToDoItem;

var
  g_HiASToDoDB: TSQLRestClientURI;
  HiASToDoModel: TSQLModel;

implementation

uses UnitFolderUtil2, UnitHiconisASVarJsonUtil, UnitRttiUtil2, Forms, TodoList,
  VarRecUtils;

function CreateModel_HiASToDo: TSQLModel;
begin
  result := TSQLModel.Create([TSQLToDoItem]);
end;

procedure InitHiASToDoClient(AExeName: string; ADBFileName: string='');
var
  LStr, LFileName, LFilePath: string;
begin
  if Assigned(g_HiASToDoDB) then
    exit;

  if AExeName = '' then
    AExeName := Application.ExeName;

  LStr := ExtractFileExt(AExeName);
  LFileName := ExtractFileName(AExeName);
  LFilePath := ExtractFilePath(AExeName);

  if LStr = '.exe' then
  begin
    LFileName := ChangeFileExt(ExtractFileName(AExeName),'.sqlite');
    LFileName := LFileName.Replace('.sqlite', '_ToDo.sqlite');
    LFilePath := GetSubFolderPath(LFilePath, 'db');
  end;

  LFilePath := EnsureDirectoryExists(LFilePath);

  if ADBFileName = '' then
    LStr := LFilePath + LFileName
  else
    LStr := ADBFileName;

  HiASToDoModel:= CreateModel_HiASToDo;

  g_HiASToDoDB:= TSQLRestClientDB.Create(HiASToDoModel, CreateModel_HiASToDo,
    LStr, TSQLRestServerDB);
  TSQLRestClientDB(g_HiASToDoDB).Server.CreateMissingTables;
end;

procedure DestroyHiASToDoClient();
begin
  if Assigned(g_HiASToDoDB) then
    FreeAndNil(g_HiASToDoDB);

  if Assigned(HiASToDoModel) then
    FreeAndNil(HiASToDoModel);
end;

function GetOrmToDoListFromDBByTask(ATask: TOrmHiconisASTask): TSQLToDoItem;
begin
  Result := TSQLToDoItem.CreateAndFillPrepare(g_HiASToDoDB.orm, 'TaskID = ?', [ATask.ID]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetOrmToDoItemFromDBByTodoItemRec(ApjhTodoItem: TpjhTodoItemRec): TSQLToDoItem;
begin
  Result := TSQLToDoItem.CreateAndFillPrepare(g_HiASToDoDB.orm,
    'TaskID = ? and UniqueID = ?',
    [ApjhTodoItem.TaskID, ApjhTodoItem.UniqueID]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

procedure GetToDoListFromDBByTask(ATask: TOrmHiconisASTask; var AToDoList: TpjhToDoList);
var
  LSQLToDoItem: TSQLToDoItem;
  LpjhTodoItem: TpjhTodoItemRec;
  LDoc: variant;
  LJson: string;
begin
//  TDocVariant.New(LDoc);
  LSQLToDoItem := TSQLToDoItem.CreateAndFillPrepare(g_HiASToDoDB.orm, 'TaskID = ?', [ATask.ID]);
  try
    while LSQLToDoItem.FillOne do
    begin
//      LoadRecordPropertyToVariant(LSQLToDoItem, LDoc, False, False, True);
//      LoadRecordFieldFromVariant(LpjhTodoItem, TypeInfo(TpjhTodoItemRec), LDoc);
      LDoc := TDocVariant.NewJson(LSQLToDoItem.GetJsonValues(True, True, ooSelect));
      LJson := Utf8ToString(LDoc);
      TRecordHlpr<TpjhTodoItemRec>.FromJson(LJson, LpjhTodoItem);
      AToDoList.Add(LSQLToDoItem.UniqueID, LpjhTodoItem);
    end;
  finally
    LSQLToDoItem.Free;
  end;
end;

procedure DeleteToDoListFromTask(ATask: TOrmHiconisASTask);
var
  LSQLToDoItem: TSQLToDoItem;
begin
//  LSQLToDoItem := GetOrmToDoListFromDBByTask(ATask);
//  try
//    LSQLToDoItem.FillRewind;

//    while LSQLToDoItem.FillOne do
      g_HiASToDoDB.Delete(TSQLToDoItem, 'TaskID = ?', [ATask.ID]);
//  finally
//    FreeAndNil(LSQLToDoItem);
//  end;
end;

procedure AddOrUpdateToDoItemRec2DB(ApjhTodoItemRec: TpjhTodoItemRec; ADB: TSQLRestClientURI);
var
  LSQLToDoItem: TSQLToDoItem;
begin
  if not Assigned(ADB) then
    ADB := g_HiASToDoDB;

  LSQLToDoItem := TSQLToDoItem.CreateAndFillPrepare(ADB.Orm, 'TaskID = ? and UniqueID = ?', [ApjhTodoItemRec.TaskID, ApjhTodoItemRec.UniqueID]);

  try
    if LSQLToDoItem.FillOne then
      LSQLToDoItem.IsUpdate := True
    else
      LSQLToDoItem.IsUpdate := False;

//    if LSQLToDoItem.IsUpdate then
    AssignpjhTodoItemToSQLToDoItem(ApjhTodoItemRec, LSQLToDoItem);

    if LSQLToDoItem.IsUpdate then
      g_HiASToDoDB.Update(LSQLToDoItem)
    else
      g_HiASToDoDB.Add(LSQLToDoItem, True);
  finally
    FreeAndNil(LSQLToDoItem);
  end;
end;

procedure AddOrUpdateToDoItem2DBByJson(AJson: RawUtf8; ADB: TSQLRestClientURI=nil );
var
  LSQLToDoItem: TSQLToDoItem;
  LRec: TpjhTodoItemRec;
  LDoc: variant;
begin
  if not Assigned(ADB) then
    ADB := g_HiASToDoDB;

  RecordLoadJson(LRec, AJson, TypeInfo(TpjhTodoItemRec));

  LSQLToDoItem := TSQLToDoItem.CreateAndFillPrepare(ADB.Orm, 'TaskID = ? and UniqueID = ?', [LRec.TaskID, LRec.UniqueID]);

  try
    if LSQLToDoItem.FillOne then
      LSQLToDoItem.IsUpdate := True
    else
      LSQLToDoItem.IsUpdate := False;

    LDoc := _JSON(AJson);
    LoadRecordPropertyFromVariant(LSQLToDoItem, LDoc);

    if LSQLToDoItem.IsUpdate then
      g_HiASToDoDB.Update(LSQLToDoItem)
    else
      g_HiASToDoDB.Add(LSQLToDoItem, True);
  finally
    FreeAndNil(LSQLToDoItem);
  end;
end;

procedure DeleteToDoItemFromDB(ApjhTodoItem: TpjhTodoItemRec; ADB: TSQLRestClientURI);
var
  LSQLToDoItem: TSQLToDoItem;
begin
  if not Assigned(ADB) then
    ADB := g_HiASToDoDB;

  g_HiASToDoDB.Delete(TSQLToDoItem, 'TaskID = ? and UniqueID = ?', [ApjhTodoItem.TaskID, ApjhTodoItem.UniqueID]);
end;

function DeleteToDoRecFromDBByUniqueID(AUniqueID: string; ADB: TSQLRestClientURI=nil):Boolean;
var
  LSQLToDoItem: TSQLToDoItem;
begin
  if not Assigned(ADB) then
    ADB := g_HiASToDoDB;

  Result := g_HiASToDoDB.Delete(TSQLToDoItem, 'UniqueID = ?', [AUniqueID]);
end;

procedure AddToDoListFromTask(ATask: TOrmHiconisASTask; var AToDoList: TpjhToDoList);
var
  LSQLToDoItem: TSQLToDoItem;
  LUtf8: RawUtf8;
  LpjhTodoItemRec: TpjhTodoItemRec;
begin
  LSQLToDoItem := TSQLToDoItem.CreateAndFillPrepare(g_HiASToDoDB.orm, 'TaskID = ?', [ATask.ID]);
  try
    while LSQLToDoItem.FillOne do
    begin
      LUtf8 := LSQLToDoItem.GetJSONValues(False, True, ooSelect);
      RecordLoadJson(LpjhTodoItemRec, LUtf8, TypeInfo(TpjhTodoItemRec));
      AToDoList.Add(LSQLToDoItem.UniqueID, LpjhTodoItemRec);
    end;
  finally
    FreeAndNil(LSQLToDoItem);
  end;
end;

procedure AssignpjhTodoItemToSQLToDoItem(ApjhTodoItem: TpjhTodoItemRec; ASQLToDoItem: TSQLToDoItem);
var
  LDoc: variant;
begin
  TDocVariant.New(LDoc);
  LDoc := TRecordHlpr<TpjhTodoItemRec>.ToVariant(ApjhTodoItem);
  LoadRecordPropertyFromVariant(ASQLTodoItem, LDoc);

//  ASQLToDoItem.fTaskID := ApjhTodoItem.TaskID;
//
//  ASQLToDoItem.Category := ApjhTodoItem.Category;
//  ASQLToDoItem.Complete := ApjhTodoItem.Complete;
//  ASQLToDoItem.Completion := ApjhTodoItem.Completion;
//  ASQLToDoItem.CompletionDate := TimeLogFromDateTime(ApjhTodoItem.CompletionDate);
//  ASQLToDoItem.CreationDate := TimeLogFromDateTime(ApjhTodoItem.CreationDate);
//  ASQLToDoItem.DueDate := TimeLogFromDateTime(ApjhTodoItem.DueDate);
//  ASQLToDoItem.ImageIndex := ApjhTodoItem.ImageIndex;
//  ASQLToDoItem.Notes := ApjhTodoItem.Notes;
//  ASQLToDoItem.Priority := Ord(ApjhTodoItem.Priority);
//  ASQLToDoItem.Project := ApjhTodoItem.Project;
//  ASQLToDoItem.Resource := ApjhTodoItem.Resource;
//  ASQLToDoItem.Status := Ord(ApjhTodoItem.Status);
//  ASQLToDoItem.Subject := ApjhTodoItem.Subject;
//  ASQLToDoItem.Tag := ApjhTodoItem.Tag;
//  ASQLToDoItem.TotalTime := ApjhTodoItem.TotalTime;
//
//  ASQLToDoItem.UniqueID := ApjhTodoItem.UniqueID;
//  ASQLToDoItem.Plan_Code := ApjhTodoItem.PlanCode;
//  ASQLToDoItem.ModId := ApjhTodoItem.ModId;
//
//  ASQLToDoItem.AlarmType := ApjhTodoItem.AlarmType;
//  ASQLToDoItem.AlarmTime1 := TimeLogFromDateTime(ApjhTodoItem.AlarmTime);
//  ASQLToDoItem.AlarmTime2 := ApjhTodoItem.AlarmTime2;
//  ASQLToDoItem.AlarmFlag := ApjhTodoItem.AlarmFlag;
//  ASQLToDoItem.Alarm2Msg := ApjhTodoItem.Alarm2Msg;
//  ASQLToDoItem.Alarm2Note := ApjhTodoItem.Alarm2Note;
//  ASQLToDoItem.Alarm2Email := ApjhTodoItem.Alarm2Email;
//
//  ASQLToDoItem.ModDate := TimeLogFromDateTime(ApjhTodoItem.ModDate);
end;

procedure AssignSQLToDoItemTopjhTodoItem(ASQLToDoItem: TSQLToDoItem; ApjhTodoItem: TpjhTodoItemRec);
begin
  ApjhTodoItem.TaskID := ASQLToDoItem.fTaskID;

  ApjhTodoItem.Categories := ASQLToDoItem.Categories;
  ApjhTodoItem.Complete := ASQLToDoItem.Complete;
  ApjhTodoItem.Completion := ASQLToDoItem.Completion;
  ApjhTodoItem.CompletionDate := ASQLToDoItem.CompletionDate;
  ApjhTodoItem.CreationDate := ASQLToDoItem.CreationDate;
  ApjhTodoItem.DueDate := ASQLToDoItem.DueDate;
  ApjhTodoItem.ImageIndex := ASQLToDoItem.ImageIndex;
  ApjhTodoItem.Notes := ASQLToDoItem.Notes;
  ApjhTodoItem.Priority := ASQLToDoItem.Priority;
  ApjhTodoItem.Project := ASQLToDoItem.Project;
  ApjhTodoItem.Resource := ASQLToDoItem.Resource;
  ApjhTodoItem.Status := ASQLToDoItem.Status;
  ApjhTodoItem.Subject := ASQLToDoItem.Subject;
  ApjhTodoItem.Tag := ASQLToDoItem.Tag;
  ApjhTodoItem.TotalTime := ASQLToDoItem.TotalTime;

  ApjhTodoItem.UniqueID := ASQLToDoItem.UniqueID;
  ApjhTodoItem.Plan_Code := ASQLToDoItem.Plan_Code;
  ApjhTodoItem.ModId := ASQLToDoItem.ModId;

  ApjhTodoItem.AlarmType := ASQLToDoItem.AlarmType;
  ApjhTodoItem.AlarmTime1 := ASQLToDoItem.AlarmTime1;
  ApjhTodoItem.AlarmTime2 := ASQLToDoItem.AlarmTime2;
  ApjhTodoItem.AlarmFlag := ASQLToDoItem.AlarmFlag;
  ApjhTodoItem.Alarm2Msg := ASQLToDoItem.Alarm2Msg;
  ApjhTodoItem.Alarm2Note := ASQLToDoItem.Alarm2Note;
  ApjhTodoItem.Alarm2Email := ASQLToDoItem.Alarm2Email;

  ApjhTodoItem.ModDate := ASQLToDoItem.ModDate;
end;

function GetTodoListOrmFromSearchRec(ASearchRec: TToDoSearchRec): TSQLToDoItem;
var
  ConstArray: TConstArray;
  LWhere, LTempWhere, LStr: string;
  LIsNeedTaskId: Boolean;
  LOrmHiconisASTask: TOrmHiconisASTask;
begin
  LOrmHiconisASTask := nil;
  LWhere := '';
  ConstArray := CreateConstArray([]);
  try
    if ASearchRec.HullNo <> '' then
    begin
//      AddConstArray(ConstArrayTemp, ['%'+ASearchRec.HullNo+'%']);
      if LTempWhere <> '' then
        LTempWhere := LTempWhere + ' and ';
      LTempWhere := LTempWhere + 'HullNo LIKE ? ';

      LIsNeedTaskId := True;
    end;

    if ASearchRec.OrderNo <> '' then
    begin
//      AddConstArray(ConstArrayTemp, ['%'+ASearchRec.OrderNo+'%']);
      if LTempWhere <> '' then
        LTempWhere := LTempWhere + ' and ';
      LTempWhere := LTempWhere + 'Order_No LIKE ? ';

      LIsNeedTaskId := True;
    end;

    if ASearchRec.ClaimNo <> '' then
    begin
//      AddConstArray(ConstArrayTemp, ['%'+ASearchRec.ClaimNo+'%']);
      if LTempWhere <> '' then
        LTempWhere := LTempWhere + ' and ';
      LTempWhere := LTempWhere + 'ClaimNo LIKE ? ';

      LIsNeedTaskId := True;
    end;

    if ASearchRec.ShipName <> '' then
    begin
//      AddConstArray(ConstArrayTemp, ['%'+ASearchRec.ShipName+'%']);
      if LTempWhere <> '' then
        LTempWhere := LTempWhere + ' and ';
      LTempWhere := LTempWhere + 'ShipName LIKE ? ';

      LIsNeedTaskId := True;
    end;

    if LIsNeedTaskId then
    begin
      LOrmHiconisASTask := GetTaskFromHullNoNOrderNoNClaimNoNShipName(
        ASearchRec.HullNo, ASearchRec.OrderNo, ASearchRec.ClaimNo, ASearchRec.ShipName
        );

      ASearchRec.TaskID := LOrmHiconisASTask.ID;
    end;

    if ASearchRec.TaskID > 0 then
    begin
      AddConstArray(ConstArray, [ASearchRec.TaskID]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'TaskID = ? ';
    end;

    if ASearchRec.CreationDate > 0 then
    begin
      AddConstArray(ConstArray, [ASearchRec.CreationDate]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'CreationDate = ? ';
    end;

    if ASearchRec.DueDate > 0 then
    begin
      AddConstArray(ConstArray, [ASearchRec.DueDate]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'DueDate = ? ';
    end;

    if ASearchRec.CompletionDate > 0 then
    begin
      AddConstArray(ConstArray, [ASearchRec.CompletionDate]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'CompletionDate = ? ';
    end;

    if ASearchRec.ModDate > 0 then
    begin
      AddConstArray(ConstArray, [ASearchRec.ModDate]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'ModDate = ? ';
    end;

    if ASearchRec.AlarmTime1 > 0 then
    begin
      AddConstArray(ConstArray, [ASearchRec.AlarmTime1]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'AlarmTime1 = ? ';
    end;

    if LWhere = '' then
    begin
      AddConstArray(ConstArray, [-1]);
      LWhere := 'ID <> ? ';
    end;

//    if ASearchRec.fOrderBy <> '' then
//      LWhere := LWhere + ' ' + ASearchRec.fOrderBy;

    Result := TSQLToDoItem.CreateAndFillPrepare(g_HiASToDoDB.Orm, Lwhere, ConstArray);

    if Result.FillOne then
    begin
      Result.IsUpdate := True;
    end
    else
    begin
      Result.IsUpdate := False;
    end
  finally
    if Assigned(LOrmHiconisASTask) then
      LOrmHiconisASTask.Free;

    FinalizeConstArray(ConstArray);
  end;
end;

initialization
finalization
  DestroyHiASToDoClient();

end.
