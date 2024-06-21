unit UnitHiASToDoRecord;

interface

uses SysUtils, Classes, Generics.Collections,
  mormot.core.base, mormot.orm.core, mormot.rest.client, mormot.core.os,
  mormot.rest.sqlite3, mormot.orm.base, mormot.core.data, mormot.core.variants,
  mormot.core.datetime, mormot.core.json, mormot.core.collections,

  UnitHiconisMasterRecord, CommonData2, UnitTodoCollect2, UnitToDoList
  ;

type
  TSQLToDoItem = class(TSQLRecord)
  private
    fTaskID: TID;

    FToDo_Code,
    FAppointmentEntryId,
    FAppointmentStoreId,
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
    property AppointmentEntryId: string read FAppointmentEntryId write FAppointmentEntryId;
    property AppointmentStoreId: string read FAppointmentStoreId write FAppointmentStoreId;
    property EmailEntryId: string read FEmailEntryId write FEmailEntryId;
    property EmailStoreId: string read FEmailStoreId write FEmailStoreId;
    property ToDo_Code: string read FToDo_Code write FToDo_Code;
    property Plan_Code: string read FPlan_Code write FPlan_Code;
    property Subject: string read FSubject write FSubject;
    property Notes: string read FNotes write FNotes;
    property ToDoReourece: string read FToDoReourece write FToDoReourece;
    property ModId: string read FModId write FModId;
    property Category: string read FCategory write FCategory;
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

  function GetToDoItemFromTask(ATask: TOrmHiconisASTask): TSQLToDoItem;
  procedure DeleteToDoListFromTask(ATask: TOrmHiconisASTask);
  procedure DeleteToDoListFromDB(ApjhTodoItem: TpjhTodoItem; ADB: TSQLRestClientURI=nil);

  procedure InsertOrUpdateToDoList2DB(ApjhTodoItem: TpjhTodoItem; AIdAdd: Boolean; ADB: TSQLRestClientURI=nil );
  procedure LoadToDoCollectFromTask(ATask: TOrmHiconisASTask; var AToDoCollect: TpjhToDoItemCollection);
  procedure LoadToDoListFromTask(ATask: TOrmHiconisASTask; var AToDoList: TpjhToDoList);

  procedure AssignpjhTodoItemToSQLToDoItem(ApjhTodoItem: TpjhTodoItem; ASQLToDoItem: TSQLToDoItem);
  procedure AssignSQLToDoItemTopjhTodoItem(ASQLToDoItem: TSQLToDoItem; ApjhTodoItem: TpjhTodoItem);

var
  g_HiASToDoDB: TSQLRestClientURI;
  HiASToDoModel: TSQLModel;

implementation

uses UnitFolderUtil2, UnitHiconisASVarJsonUtil, UnitRttiUtil2, Forms, TodoList;

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

function GetToDoItemFromTask(ATask: TOrmHiconisASTask): TSQLToDoItem;
begin
  Result := TSQLToDoItem.CreateAndFillPrepare(g_HiASToDoDB.orm, 'TaskID = ?', [ATask.ID]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

procedure DeleteToDoListFromTask(ATask: TOrmHiconisASTask);
var
  LSQLToDoItem: TSQLToDoItem;
begin
//  LSQLToDoItem := GetToDoItemFromTask(ATask);
//  try
//    LSQLToDoItem.FillRewind;

//    while LSQLToDoItem.FillOne do
      g_HiASToDoDB.Delete(TSQLToDoItem, 'TaskID = ?', [ATask.ID]);
//  finally
//    FreeAndNil(LSQLToDoItem);
//  end;
end;

procedure InsertOrUpdateToDoList2DB(ApjhTodoItem: TpjhTodoItem; AIdAdd: Boolean; ADB: TSQLRestClientURI);
var
  LSQLToDoItem: TSQLToDoItem;
  LTaskID: TID;
begin
  if not Assigned(ADB) then
    ADB := g_HiASToDoDB;

  LTaskID := ApjhTodoItem.TaskID;
  LSQLToDoItem := TSQLToDoItem.CreateAndFillPrepare(ADB.Orm, 'TaskID = ?', [LTaskID]);

  try
    if LSQLToDoItem.FillOne then
      LSQLToDoItem.IsUpdate := True
    else
      LSQLToDoItem.IsUpdate := False;

//    if LSQLToDoItem.IsUpdate then
    AssignpjhTodoItemToSQLToDoItem(ApjhTodoItem, LSQLToDoItem);

    if AIdAdd then
      g_HiASToDoDB.Add(LSQLToDoItem, True)
    else
      g_HiASToDoDB.Update(LSQLToDoItem);
  finally
    FreeAndNil(LSQLToDoItem);
  end;
end;

procedure DeleteToDoListFromDB(ApjhTodoItem: TpjhTodoItem; ADB: TSQLRestClientURI);
var
  LSQLToDoItem: TSQLToDoItem;
  LTaskID: TID;
begin
  if not Assigned(ADB) then
    ADB := g_HiASToDoDB;

  LTaskID := ApjhTodoItem.TaskID;
  LSQLToDoItem := TSQLToDoItem.CreateAndFillPrepare(ADB.Orm, 'TaskID = ? and ToDo_Code = ?', [LTaskID, ApjhTodoItem.TodoCode]);

  try
    if LSQLToDoItem.FillOne then
    begin
      g_HiASToDoDB.Delete(TSQLToDoItem, LSQLToDoItem.ID);
    end;
  finally
    FreeAndNil(LSQLToDoItem);
  end;
end;

procedure LoadToDoCollectFromTask(ATask: TOrmHiconisASTask; var AToDoCollect: TpjhToDoItemCollection);
var
  LSQLToDoItem: TSQLToDoItem;
  LpjhToDoItem: TpjhToDoItem;
begin
//  AToDoCollect.Clear;

  LSQLToDoItem := TSQLToDoItem.CreateAndFillPrepare(g_HiASToDoDB.orm, 'TaskID = ?', [ATask.ID]);
  try
    while LSQLToDoItem.FillOne do
    begin
      LpjhToDoItem := AToDoCollect.Add;
      LSQLToDoItem.Project := ATask.HullNo;
      AssignSQLToDoItemTopjhTodoItem(LSQLToDoItem, LpjhToDoItem);
    end;
  finally
    FreeAndNil(LSQLToDoItem);
  end;
end;

procedure LoadToDoListFromTask(ATask: TOrmHiconisASTask; var AToDoList: TpjhToDoList);
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
      AToDoList.Add(LpjhTodoItemRec);
    end;
  finally
    FreeAndNil(LSQLToDoItem);
  end;
end;

procedure AssignpjhTodoItemToSQLToDoItem(ApjhTodoItem: TpjhTodoItem; ASQLToDoItem: TSQLToDoItem);
begin
  ASQLToDoItem.fTaskID := ApjhTodoItem.TaskID;

  ASQLToDoItem.Category := ApjhTodoItem.Category;
  ASQLToDoItem.Complete := ApjhTodoItem.Complete;
  ASQLToDoItem.Completion := ApjhTodoItem.Completion;
  ASQLToDoItem.CompletionDate := TimeLogFromDateTime(ApjhTodoItem.CompletionDate);
  ASQLToDoItem.CreationDate := TimeLogFromDateTime(ApjhTodoItem.CreationDate);
  ASQLToDoItem.DueDate := TimeLogFromDateTime(ApjhTodoItem.DueDate);
  ASQLToDoItem.ImageIndex := ApjhTodoItem.ImageIndex;
  ASQLToDoItem.Notes := ApjhTodoItem.Notes.Text;
  ASQLToDoItem.Priority := Ord(ApjhTodoItem.Priority);
  ASQLToDoItem.Project := ApjhTodoItem.Project;
  ASQLToDoItem.Resource := ApjhTodoItem.Resource;
  ASQLToDoItem.Status := Ord(ApjhTodoItem.Status);
  ASQLToDoItem.Subject := ApjhTodoItem.Subject;
  ASQLToDoItem.Tag := ApjhTodoItem.Tag;
  ASQLToDoItem.TotalTime := ApjhTodoItem.TotalTime;

  ASQLToDoItem.Todo_Code := ApjhTodoItem.TodoCode;
  ASQLToDoItem.Plan_Code := ApjhTodoItem.PlanCode;
  ASQLToDoItem.ModId := ApjhTodoItem.ModId;

  ASQLToDoItem.AlarmType := ApjhTodoItem.AlarmType;
  ASQLToDoItem.AlarmTime1 := TimeLogFromDateTime(ApjhTodoItem.AlarmTime);
  ASQLToDoItem.AlarmTime2 := ApjhTodoItem.AlarmTime2;
  ASQLToDoItem.AlarmFlag := ApjhTodoItem.AlarmFlag;
  ASQLToDoItem.Alarm2Msg := ApjhTodoItem.Alarm2Msg;
  ASQLToDoItem.Alarm2Note := ApjhTodoItem.Alarm2Note;
  ASQLToDoItem.Alarm2Email := ApjhTodoItem.Alarm2Email;

  ASQLToDoItem.ModDate := TimeLogFromDateTime(ApjhTodoItem.ModDate);
end;

procedure AssignSQLToDoItemTopjhTodoItem(ASQLToDoItem: TSQLToDoItem; ApjhTodoItem: TpjhTodoItem);
begin
  ApjhTodoItem.TaskID := ASQLToDoItem.fTaskID;

  ApjhTodoItem.Category := ASQLToDoItem.Category;
  ApjhTodoItem.Complete := ASQLToDoItem.Complete;
  ApjhTodoItem.Completion := ASQLToDoItem.Completion;
  ApjhTodoItem.CompletionDate := ASQLToDoItem.CompletionDate;
  ApjhTodoItem.CreationDate := ASQLToDoItem.CreationDate;
  ApjhTodoItem.DueDate := ASQLToDoItem.DueDate;
  ApjhTodoItem.ImageIndex := ASQLToDoItem.ImageIndex;
  ApjhTodoItem.Notes.Text := ASQLToDoItem.Notes;
  ApjhTodoItem.Priority := ASQLToDoItem.Priority;
  ApjhTodoItem.Project := ASQLToDoItem.Project;
  ApjhTodoItem.Resource := ASQLToDoItem.Resource;
  ApjhTodoItem.Status := ASQLToDoItem.Status;
  ApjhTodoItem.Subject := ASQLToDoItem.Subject;
  ApjhTodoItem.Tag := ASQLToDoItem.Tag;
  ApjhTodoItem.TotalTime := ASQLToDoItem.TotalTime;

  ApjhTodoItem.TodoCode := ASQLToDoItem.Todo_Code;
  ApjhTodoItem.PlanCode := ASQLToDoItem.Plan_Code;
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

initialization
finalization
  DestroyHiASToDoClient();

end.
