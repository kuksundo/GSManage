unit DomTodoTypes2;

interface

uses
  System.Classes,
  mormot.core.base, mormot.core.data, mormot.core.json, mormot.orm.base,
  TodoList;

type
  TOutLookID = type RawUTF8;
  TNotes = type RawUTF8;
  TProjectNo = type RawUTF8;
  TDueDate = type TDateTime;

  TSearchRec4ToDo = record
    FIsNewAdd: Boolean;
    FSubject: string;
    FProjectNo: TProjectNo;
    FProjectName: string;
    FCompletion: TCompletion;
    FDueDate: TDateTime;
    FPriority: TTodoPriority;
    FStatus: TTodoStatus;
    FCompletionDate: TDateTime;

  end;

  TTodoAppointment = class(TSynPersistent)
  private
    FEntryId,
    FStoreId : TOutLookID;
  protected
    procedure AssignTo(Source: TSynPersistent); override;
  published
    property EntryId: TOutLookID read FEntryId write FEntryId;
    property StoreId: TOutLookID read FStoreId write FStoreId;
  end;

  TTodoEmail = class(TSynPersistent)
  private
    FEntryId,
    FStoreId : TOutLookID;
  protected
    procedure AssignTo(Source: TSynPersistent); override;
  published
    property EntryId: TOutLookID read FEntryId write FEntryId;
    property StoreId: TOutLookID read FStoreId write FStoreId;
  end;

  TpjhToDoItem = class(TSynAutoCreateFields)
  private
//    FLock: IAutoLocker;

    FProjectNo: TProjectNo;
    FProjectName: string;

    fAppointment : TTodoAppointment;
    fEmail: TTodoEmail;

    FImageIndex: Integer;
    FNotes: TNotes;
    FTag: Integer;
    FTotalTime: double;
    FSubject: string;
    FCompletion: TCompletion;
    FDueDate: TDateTime;
    FPriority: TTodoPriority;
    FStatus: TTodoStatus;
    FOnChange: TNotifyEvent;
    FComplete: Boolean;
    FCreationDate: TDateTime;
    FCompletionDate: TDateTime;
    FResource: string;
    FCategory: string;

    FTodoCode,
    FTaskCode,
    FPlanCode,
    FModId: string;

    FAlarmType,
    FAlarmTime2, //AlarmType이 2인 경우(분)
    FAlarmFlag
    : integer;
    FAlarm2Msg,
    FAlarm2Note,
    FAlarm2Email: Boolean;

    FAlarmTime1, //AlarmType이 1인 경우 시각
    FModDate: TDateTime;

    FAlarmTime: TDateTime; //Alarm을 발생 시켜야할 시각
  protected
    procedure AssignTo(Source: TSynPersistent); override;
  public
    procedure AssignTodoAppointment(aTodoAppointment: TTodoAppointment);
    procedure AssignTodoEmail(aTodoEmail: TTodoEmail);
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property ProjectNo: TProjectNo read FProjectNo write FProjectNo;
    property ProjectName: string read FProjectName write FProjectName;
    property Appointment: TTodoAppointment read fAppointment;
    property Email: TTodoEmail read fEmail;
    property ImageIndex: Integer read FImageIndex write FImageIndex;
    property Notes: TNotes read FNotes write FNotes;
    property Tag: Integer read FTag write FTag;
    property TotalTime: double read FTotalTime write FTotalTime;
    property Subject: string read FSubject write FSubject;
    property Completion: TCompletion read FCompletion write FCompletion;
    property DueDate: TDateTime read FDueDate write FDueDate;
    property Priority: TTodoPriority read FPriority write FPriority;
    property Status: TTodoStatus read FStatus write FStatus;
    property Complete: Boolean read FComplete write FComplete;
    property CreationDate: TDateTime read FCreationDate write FCreationDate;
    property CompletionDate: TDateTime read FCompletionDate write FCompletionDate;
    property Resource: string read FResource write FResource;
    property Category: string read FCategory write FCategory;
    property TodoCode: string read FTodoCode write FTodoCode;
    property TaskCode: string read FTaskCode write FTaskCode;
    property PlanCode: string read FPlanCode write FPlanCode;
    property ModId: string read FModId write FModId;

    property AlarmType: integer read FAlarmType write FAlarmType;
    property AlarmTime2: integer read FAlarmTime2 write FAlarmTime2;
    property AlarmFlag: integer read FAlarmFlag write FAlarmFlag;
    property Alarm2Msg: integer read FAlarm2Msg write FAlarm2Msg;
    property Alarm2Note: integer read FAlarm2Note write FAlarm2Note;
    property Alarm2Email: integer read FAlarm2Email write FAlarm2Email;

    property AlarmTime1: TDateTime read FAlarmTime1 write FAlarmTime1;
    property ModDate: TDateTime read FModDate write FModDate;

    property AlarmTime: TDateTime read FAlarmTime write FAlarmTime;
  end;

  TToDoItemObjArray = array of TpjhToDoItem;

implementation

{ TTodoAppointment }

procedure TTodoAppointment.AssignTo(Source: TSynPersistent);
begin
  inherited;

end;

{ TpjhToDoItem }

procedure TpjhToDoItem.AssignTo(Source: TSynPersistent);
begin
  inherited;

end;

procedure TpjhToDoItem.AssignTodoAppointment(aTodoAppointment: TTodoAppointment);
begin

end;

procedure TpjhToDoItem.AssignTodoEmail(aTodoEmail: TTodoEmail);
begin

end;

{ TTodoEmail }

procedure TTodoEmail.AssignTo(Source: TSynPersistent);
begin

end;

initialization
  TJSONSerializer.RegisterObjArrayForJSON([
    TypeInfo(TToDoItemObjArray), TpjhToDoItem
  ]);

end.
