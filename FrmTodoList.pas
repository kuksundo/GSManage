unit FrmTodoList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, TodoList, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.StdCtrls, FrmTodo_Detail, Vcl.Menus, DateUtils,
  mormot.core.base, mormot.core.data, mormot.core.variants, mormot.core.datetime,
  UnitTodoCollect2,  UnitIPCModule2;

type
  TToDoListF = class(TForm)
    Panel1: TPanel;
    TodoList1: TTodoList;
    Button1: TButton;
    BitBtn1: TBitBtn;
    Button3: TButton;
    PopupMenu1: TPopupMenu;
    Edit1: TMenuItem;
    AddtoOutlookAppointment1: TMenuItem;
    SetComplete1: TMenuItem;
    ResetComplete1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure TodoList1DblClick(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AddtoOutlookAppointment1Click(Sender: TObject);
    procedure SetComplete1Click(Sender: TObject);
    procedure ResetComplete1Click(Sender: TObject);
  private
    FDeleteToDoListFromDB: TDeleteToDoListFromDB;
    FInsertOrUpdateToDoList2DB: TInsertOrUpdateToDoList2DB;

    procedure SetDeleteToDoListFromDB(AProc:TDeleteToDoListFromDB);
    procedure SetInsertOrUpdateToDoList2DB(AProc:TInsertOrUpdateToDoList2DB);

    procedure EditToDoList(AToDoList: TToDoList; AIsEdit: Boolean = False);
    procedure DeleteToDoItem;
    procedure AddToDoItem;
    procedure LoadToDoList2Detail(AToDoItem: TToDoItem; AToDoDetailF: TToDoDetailF);
//    procedure SaveToDoItem2Collect;
    procedure LoadToDoItemFromCollect(AIndex: integer; AIsAdd: Boolean);
    procedure SaveToDoItemFromDetailF(AIndex: integer; AToDoDetailF: TToDoDetailF);
    procedure SaveCompleteTodoItem(AIndex: integer; AComplete: Boolean = true);
  public
    FPlanNo,
    FTaskNo: string;
    FToDoCollect: TpjhToDoItemCollection;

    procedure Get_ToDoList(APlanNo: string);
    function GetJsonArrFromToDoSelected: string;
    function GetAppointmentFromToDoListDetail(AToDoItem: TToDoItem): variant;

    procedure SetResetCompleteTodoItem(ASet:Boolean=True);

    property DeleteToDoListFromDB: TDeleteToDoListFromDB read FDeleteToDoListFromDB write SetDeleteToDoListFromDB;
    property InsertOrUpdateToDoList2DB: TInsertOrUpdateToDoList2DB read FInsertOrUpdateToDoList2DB write SetInsertOrUpdateToDoList2DB;
  end;

  //ATaskId = TaskID
  //AIsDisplayComplete: True = 완료된(Complete = True) 것도 표시
  function Create_ToDoList_Frm(ATaskId: string; var AToDoCollect: TpjhToDoItemCollection;
    AIsDisplayComplete: Boolean = False;
    AInsertOrUpdateToDoList2DB: TInsertOrUpdateToDoList2DB = nil;
    ADeleteToDoListFromDB: TDeleteToDoListFromDB = nil) : Boolean;

var
  ToDoListF: TToDoListF;

implementation

{$R *.dfm}

function Create_ToDoList_Frm(ATaskId: string;
  var AToDoCollect: TpjhToDoItemCollection; AIsDisplayComplete: Boolean;
  AInsertOrUpdateToDoList2DB: TInsertOrUpdateToDoList2DB;
  ADeleteToDoListFromDB: TDeleteToDoListFromDB): Boolean;
var
  i: integer;
  LToDoListF: TToDoListF;
begin
  LToDoListF := TToDoListF.Create(nil);
  try
    with LToDoListF do
    begin
      if Assigned(AInsertOrUpdateToDoList2DB) then
        InsertOrUpdateToDoList2DB := AInsertOrUpdateToDoList2DB;

      if Assigned(ADeleteToDoListFromDB) then
        DeleteToDoListFromDB := ADeleteToDoListFromDB;

      FTaskNo := ATaskId;

      if AToDoCollect.Count > 0 then
        FPlanNo := AToDoCollect.Items[0].Project;

      FToDoCollect.Assign(AToDoCollect);
      FToDoCollect.Sort(2); //CreationDate로 정렬

      for i := 0 to FToDoCollect.Count - 1 do
      begin
//        if (ATaskId <> '') and (FToDoCollect.Items[i].TaskCode <> ATaskId) then
//          Continue;

        if not AIsDisplayComplete then
          if FToDoCollect.Items[i].Complete then
            continue;

        with TodoList1.Items.Add do
        begin
          Subject := FToDoCollect.Items[i].Subject;
          Notes.Text := FToDoCollect.Items[i].Notes.Text;
          Completion := FToDoCollect.Items[i].Completion;
          DueDate := FToDoCollect.Items[i].DueDate;
          CreationDate := FToDoCollect.Items[i].CreationDate;
          Priority := TTodoPriority(FToDoCollect.Items[i].Priority);
          Resource := FToDoCollect.Items[i].Resource;
          Category := FToDoCollect.Items[i].Category;
          Project :=  FToDoCollect.Items[i].Project;
          Tag := i;
        end;
      end;

      if ShowModal = mrOK then
        AToDoCollect.Assign(FToDoCollect);
    end;
  finally
    FreeAndNil(LToDoListF);
  end;
end;

procedure TToDoListF.AddToDoItem;
begin
  with FToDoCollect.Add do
  begin
    Subject := '새 일정';
    Notes.Text := '일정 상세';
//    Completion := Random(100);
    DueDate := TimeLogFromDateTIme(Now + 60);
    CreationDate := TimeLogFromDateTIme(Now);
    Priority := Ord(tpNormal);
    Resource := 'Unassigned';

//    LoadToDoItemFromCollect(Index);
  end;
end;

procedure TToDoListF.AddtoOutlookAppointment1Click(Sender: TObject);
begin
//  ShowMessage(GetJsonArrFromToDoSelected);
{$IFDEF USE_MORMOT_WS}
  SendReqAddAppointment_WS(GetJsonArrFromToDoSelected);
{$ENDIF}
end;

procedure TToDoListF.Button1Click(Sender: TObject);
begin
  EditToDoList(ToDoList1);
end;

procedure TToDoListF.Button3Click(Sender: TObject);
begin
  DeleteToDoItem;
end;

procedure TToDoListF.DeleteToDoItem;
var
  LToDoItem: TpjhToDoItem;
begin
  if Assigned(TodoList1.Selected) then
  begin
    if MessageDlg('선택한 항목을 삭제 하시겠습니까?', mtConfirmation, [mbYes, mbNo],
      0) = mrYes then
    begin
      if Assigned(FDeleteToDoListFromDB) then
      begin
        LToDoItem := FToDoCollect.Items[TodoList1.Selected.Tag];
        FDeleteToDoListFromDB(LToDoItem);
      end;

      FToDoCollect.Delete(TodoList1.Selected.Tag);
      TodoList1.Items.Delete(TodoList1.Selected.Index);
    end;
  end;
end;

procedure TToDoListF.Edit1Click(Sender: TObject);
begin
  if Assigned(TodoList1.Selected) then
    EditToDoList(TodoList1);
end;

procedure TToDoListF.EditToDoList(AToDoList: TToDoList; AIsEdit: Boolean);
var
  LToDoDetailF: TToDoDetailF;
  LIdx: integer;
begin
  LToDoDetailF := TToDoDetailF.Create(Self);
  try
    if AIsEdit then
      LoadToDoList2Detail(AToDoList.Selected, LToDoDetailF);

    if LToDoDetailF.ShowModal = mrOK then
    begin
      if AIsEdit then
        LIdx := AToDoList.Selected.Tag
      else
        LIdx := -1;

      SaveToDoItemFromDetailF(LIdx, LToDoDetailF);
    end;
  finally
    FreeAndNil(LToDoDetailF);
  end;//try
end;

procedure TToDoListF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FToDoCollect.Clear;
  FreeAndNil(FToDoCollect);
end;

procedure TToDoListF.FormCreate(Sender: TObject);
begin
  FToDoCollect := TpjhToDoItemCollection.Create(TpjhTodoItem);
end;

function TToDoListF.GetJsonArrFromToDoSelected: string;
var
  Docs: TVariantDynArray;
  DocsDA: TDynArray;
  LCount: integer;
  i: integer;
begin
  DocsDA.Init(TypeInfo(TVariantDynArray), Docs, @LCount);
  LCount := 0;

  for i := 0 to TodoList1.Items.Count - 1 do
    if TodoList1.ItemSelected[i] then
      Inc(LCount);

  SetLength(Docs,LCount);
  LCount := 0;

  for i := 0 to TodoList1.Items.Count - 1 do
  begin
    if TodoList1.ItemSelected[i] then
    begin
      TDocVariant.New(Docs[LCount]);
      Docs[LCount] := GetAppointmentFromToDoListDetail(TodoList1.Items.Items[i]);
      Inc(LCount);
    end;
  end;

  Result := Utf8ToString(DocsDA.SaveToJson);
end;

function TToDoListF.GetAppointmentFromToDoListDetail(
  AToDoItem: TToDoItem): variant;
var
  Lidx: integer;
  myHour, myMin, mySec, myMilli : Word;
begin
  TDocVariant.New(Result);
  Lidx := AToDoItem.Tag;

  with FToDoCollect.Items[Lidx] do
  begin
    Result.Subject := Subject;
    Result.Start := TimeLogFromDateTime(CreationDate);
//    DecodeTime(CreationDate, myHour, myMin, mySec, myMilli);
//    Result.Time_Begin := EncodeTime(myHour, myMin, mySec, myMilli);
    Result.End_ := TimeLogFromDateTime(DueDate);
//    DecodeTime(DueDate, myHour, myMin, mySec, myMilli);
//    Result.Time_End := EncodeTime(myHour, myMin, mySec, myMilli);
    Result.Body := Notes.Text;
//    Result.AlarmCombo := GetAlarmComboIndex(AlarmTime2);
//    Result.Alarm2Msg := Alarm2Msg = 1;
//    Result.Alarm2Note := Alarm2Note = 1;
  end;
end;

procedure TToDoListF.Get_ToDoList(APlanNo: string);
begin

end;

procedure TToDoListF.LoadToDoItemFromCollect(AIndex: integer; AIsAdd: Boolean);
var
  LTodoItem: TTodoItem;
begin
  if AIsAdd then
    LTodoItem := ToDoList1.Items.Add
  else
    LTodoItem := ToDoList1.Items.Items[AIndex];

  FToDoCollect.Items[AIndex].AssignTo(LTodoItem);
  LTodoItem.Tag := AIndex;
end;

procedure TToDoListF.LoadToDoList2Detail(AToDoItem: TToDoItem; AToDoDetailF: TToDoDetailF);
var
  Lidx: integer;
  myHour, myMin, mySec, myMilli : Word;
begin
  Lidx := AToDoItem.Tag;

  with FToDoCollect.Items[Lidx] do
  begin
    AToDoDetailF.Subject.Text := Subject;
    AToDoDetailF.BeginDate.Date := CreationDate;
    DecodeTime(CreationDate, myHour, myMin, mySec, myMilli);
    AToDoDetailF.BeginTime.Time := EncodeTime(myHour, myMin, mySec, myMilli);
    AToDoDetailF.EndDate.date := DueDate;
    DecodeTime(DueDate, myHour, myMin, mySec, myMilli);
    AToDoDetailF.EndTime.Time := EncodeTime(myHour, myMin, mySec, myMilli);
    AToDoDetailF.Notes.Lines.Assign(Notes);
    AToDoDetailF.AlarmType.ItemIndex := GetAlarmFlagIndex(AlarmTime2);
    AToDoDetailF.Alarm2Msg.Checked := Alarm2Msg;
    AToDoDetailF.Alarm2Note.Checked := Alarm2Note;
  end;
end;

procedure TToDoListF.ResetComplete1Click(Sender: TObject);
begin
  SetResetCompleteTodoItem(False);
end;

procedure TToDoListF.SaveCompleteTodoItem(AIndex: integer; AComplete: Boolean);
var
  LToDoItem: TpjhTodoItem;
begin
  if AIndex = -1 then
    exit;

  LToDoItem := FToDoCollect.Items[AIndex];
  LToDoItem.Complete := AComplete;

  if Assigned(InsertOrUpdateToDoList2DB) then
    InsertOrUpdateToDoList2DB(LToDoItem, False);
end;

procedure TToDoListF.SaveToDoItemFromDetailF(AIndex: integer;
  AToDoDetailF: TToDoDetailF);
var
  myHour, myMin, mySec, myMilli : Word;
  myYear, myMonth, myDay : Word;
  LToDoItem: TpjhTodoItem;
  LIsAdd: Boolean;
begin
  LIsAdd := AIndex = -1;

  if LIsAdd then
    LToDoItem := FToDoCollect.Add
  else
    LToDoItem := FToDoCollect.Items[AIndex];

  with LToDoItem do
  begin
    Subject := AToDoDetailF.Subject.Text;
    Category := AToDoDetailF.AlarmType.Text;

    DecodeDate(AToDoDetailF.BeginDate.Date,myYear, myMonth, myDay);
    DecodeTime(AToDoDetailF.BeginTime.Time, myHour, myMin, mySec, myMilli);
    CreationDate := TimeLogFromDateTime(EncodeDateTime(myYear, myMonth, myDay, myHour, myMin, mySec, myMilli));

    DecodeDate(AToDoDetailF.EndDate.Date,myYear, myMonth, myDay);
    DecodeTime(AToDoDetailF.EndTime.Time, myHour, myMin, mySec, myMilli);
    DueDate := TimeLogFromDateTime(EncodeDateTime(myYear, myMonth, myDay, myHour, myMin, mySec, myMilli));

    Notes.Assign(AToDoDetailF.Notes.Lines);

    AlarmType := 2;
    AlarmTime2 := GetAlarmInterval(AToDoDetailF.AlarmType.ItemIndex);
    Alarm2Msg := AToDoDetailF.Alarm2Msg.Checked;
    Alarm2Note := AToDoDetailF.Alarm2Note.Checked;
    Moddate := TimeLogFromDateTime(now);

    if LIsAdd then
    begin
      TodoCode := FormatDateTime('yyyymmddhhmmsszzz', now);
      PlanCode := FPlanNo;
      Project := FPlanNo;
      ModId := '';//DM1.FUserInfo.UserID;
    end;
  end;

  LoadToDoItemFromCollect(LToDoItem.Index, LIsAdd);

  if Assigned(InsertOrUpdateToDoList2DB) then
    InsertOrUpdateToDoList2DB(LToDoItem, LIsAdd);
end;

procedure TToDoListF.SetComplete1Click(Sender: TObject);
begin
  SetResetCompleteTodoItem;
end;

procedure TToDoListF.SetResetCompleteTodoItem(ASet:Boolean);
begin
  SaveCompleteTodoItem(TodoList1.Selected.Tag, ASet);
end;

procedure TToDoListF.SetDeleteToDoListFromDB(AProc: TDeleteToDoListFromDB);
begin
  if Assigned(AProc) then
    FDeleteToDoListFromDB := AProc;
end;

procedure TToDoListF.SetInsertOrUpdateToDoList2DB(
  AProc: TInsertOrUpdateToDoList2DB);
begin
  if Assigned(AProc) then
    FInsertOrUpdateToDoList2DB := AProc;
end;

procedure TToDoListF.TodoList1DblClick(Sender: TObject);
begin
  if Assigned(TodoList1.Selected) then
    EditToDoList(TodoList1, True);
end;

end.
