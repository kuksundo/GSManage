unit FrmTodo_Detail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, DateUtils, TodoList, DomTodoTypes2, PngBitBtn, OtlCommon, OtlComm,
  UnitOLEmailRecord2, UnitOutLookDataType, UnitWorker4OmniMsgQ;

type
  ALARM_INTERVAL = (aiNone, ai0Min,ai5Min,ai10Min,ai15Min,ai30Min,
                ai1Hour,ai2Hour,ai3Hour,ai4Hour,ai5Hour,ai6Hour,ai7Hour,ai8Hour,
                ai9Hour,ai10Hour,ai11Hour,ai18Hour,ai1Day,ai2Day,ai3Day,
                ai4Day,ai1Week,ai2Week);

  TToDoDetailF = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Label1: TLabel;
    Subject: TEdit;
    Notes: TMemo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel6: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    BeginDate: TDateTimePicker;
    BeginTime: TDateTimePicker;
    EndDate: TDateTimePicker;
    EndTime: TDateTimePicker;
    AlarmType: TComboBox;
    Button1: TButton;
    Alarm2Msg: TCheckBox;
    Alarm2Note: TCheckBox;
    Alarm2Email: TCheckBox;
    Alarm2Popup: TCheckBox;
    UniqueID: TEdit;
    PngBitBtn1: TPngBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PngBitBtn1Click(Sender: TObject);
  private
    procedure OnWorkerResult(var Msg: TMessage); message MSG_RESULT;
    procedure ProcessRespondFromWorker(AMsgId: integer; ARec: TOLRespondRec);
  public
    FTaskEditConfig: THiconisASTaskEditConfig;

    procedure LoadTodoItemFromForm(ApjhTodoItem: TpjhTodoItem);

    function GetTodoItem2JsonFromForm: string;
    procedure SetTodoItemFromJson2Form(AJson: string);
    procedure ReqRegisterTodoItem2OL();
    procedure SendCmd2WorkerThrd(const ACmd: TOLCommandKind; const AValue: TOmniValue);
  end;

  function GetAlarmInterval(AInterval: integer): longint;
  function GetAlarmFlagIndex(AAlarmMinute: integer): integer;
var
  ToDoDetailF: TToDoDetailF;

implementation

uses UnitDateUtil, UnitRttiUtil2, UnitIPCMsgQUtil;

{$R *.dfm}

procedure TToDoDetailF.BitBtn1Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TToDoDetailF.BitBtn2Click(Sender: TObject);
begin
//  ModalResult := mrOK;
end;

procedure TToDoDetailF.Button1Click(Sender: TObject);
var
  myHour, myMin, mySec, myMilli : Word;
  myYear, myMonth, myDay : Word;
  Ldt: TDateTime;
  LMin: integer;
begin
  DecodeDate(BeginDate.Date,myYear, myMonth, myDay);
  DecodeTime(BeginTime.Time, myHour, myMin, mySec, myMilli);
  Ldt := EncodeDateTime(myYear, myMonth, myDay, myHour, myMin, mySec, myMilli);
  LMin := GetAlarmInterval(AlarmType.ItemIndex);
  Ldt := DateTimeMinusInteger(Ldt, LMin, 2, '-');
  EndDate.date := Ldt;
  DecodeTime(Ldt, myHour, myMin, mySec, myMilli);
  EndTime.Time := EncodeTime(myHour, myMin, mySec, myMilli);
end;

procedure TToDoDetailF.FormCreate(Sender: TObject);
begin
  BeginDate.DateTime := now;
  BeginTime.DateTime := now;
  EndDate.DateTime := now;
  EndTime.DateTime := now;
end;

function TToDoDetailF.GetTodoItem2JsonFromForm: string;
begin
  //Form에 있는 {Component Name = Value} 형식의 Json으로 반홤
  //각 Component Hint = Value가 있는 Field 명을 입력해야 함(예: Text/Checked/ItemIndex)
  Result := GetCompNameValue2JsonFromForm(Self);
end;

procedure TToDoDetailF.LoadTodoItemFromForm(ApjhTodoItem: TpjhTodoItem);
var
  myHour, myMin, mySec, myMilli : Word;
  myYear, myMonth, myDay : Word;
begin
  with ApjhTodoItem do
  begin
    Subject := Self.Subject.Text;
    Category := Self.AlarmType.Text;

    DecodeDate(BeginDate.Date,myYear, myMonth, myDay);
    DecodeTime(BeginTime.Time, myHour, myMin, mySec, myMilli);
    CreationDate := EncodeDateTime(myYear, myMonth, myDay, myHour, myMin, mySec, myMilli);

    DecodeDate(EndDate.Date,myYear, myMonth, myDay);
    DecodeTime(EndTime.Time, myHour, myMin, mySec, myMilli);
    DueDate := EncodeDateTime(myYear, myMonth, myDay, myHour, myMin, mySec, myMilli);

    Notes := Self.Notes.Lines.Text;

    AlarmType := 2;
    AlarmTime2 := GetAlarmInterval(Self.AlarmType.ItemIndex);
    Alarm2Msg := Self.Alarm2Msg.Checked;
    Alarm2Note := Self.Alarm2Note.Checked;
    Alarm2Popup := Self.Alarm2Popup.Checked;
  end;
end;

procedure TToDoDetailF.OnWorkerResult(var Msg: TMessage);
var
  LMsg  : TOmniMessage;
  LOLRespondRec: TOLRespondRec;
begin
  //HiconisASManage에서 전달 받음
  while FTaskEditConfig.IPCMQ2RespondOLCalendar.TryDequeue(LMsg) do
  begin
    LOLRespondRec := LMsg.MsgData.ToRecord<TOLRespondRec>;
    ProcessRespondFromWorker(LMsg.MsgID, LOLRespondRec);
  end;//while
end;

procedure TToDoDetailF.PngBitBtn1Click(Sender: TObject);
begin
  ReqRegisterTodoItem2OL();
end;

procedure TToDoDetailF.ProcessRespondFromWorker(AMsgId: integer;
  ARec: TOLRespondRec);
begin
  ShowMessage('');
end;

procedure TToDoDetailF.ReqRegisterTodoItem2OL;
var
  LOLAppointmentRec: TOLAppointmentRec;
  LValue: TOmniValue;
begin
  LOLAppointmentRec.Subject := Subject.Text;
  LOLAppointmentRec.Start := DateOf(BeginDate.Date) + TimeOf(BeginTime.Time);
  LOLAppointmentRec.End_ := DateOf(EndDate.Date) + TimeOf(EndDate.Time);
  LOLAppointmentRec.Body := Notes.Text;
  LOLAppointmentRec.CreationTime := now;
//  LOLAppointmentRec.Duration := now;

  LOLAppointmentRec.FSenderHandle := Handle;
  LValue := TOmniValue.FromRecord(LOLAppointmentRec);

  SendCmd2WorkerThrd(olckAddAppointment, LValue);
end;

procedure TToDoDetailF.SendCmd2WorkerThrd(const ACmd: TOLCommandKind;
  const AValue: TOmniValue);
var
  LMsgQ: TOmniMessageQueue;
begin
  LMsgQ := FTaskEditConfig.IPCMQCommandOLCalendar;

  SendCmd2OmniMsgQ(Ord(ACmd), AValue, LMsgQ);
end;

procedure TToDoDetailF.SetTodoItemFromJson2Form(AJson: string);
begin
  SetCompNameValueFromJson2Form(Self, AJson);
end;

//분단위 숫자 반환
function GetAlarmInterval(AInterval: integer): longint;
begin
  case ALARM_INTERVAL(AInterval) of
    aiNone: Result := -1;
    ai0Min: Result := 0;
    ai5Min: Result := 5;
    ai10Min: Result := 10;
    ai15Min: Result := 15;
    ai30Min: Result := 30;
    ai1Hour: Result := 60;
    ai2Hour: Result := 120;
    ai3Hour: Result := 180;
    ai4Hour: Result := 240;
    ai5Hour: Result := 300;
    ai6Hour: Result := 360;
    ai7Hour: Result := 420;
    ai8Hour: Result := 480;
    ai9Hour: Result := 540;
    ai10Hour: Result := 600;
    ai11Hour: Result := 660;
    ai18Hour: Result := 1080;
    ai1Day: Result := 1440;
    ai2Day: Result := 2880;
    ai3Day: Result := 4320;
    ai4Day: Result := 5760;
    ai1Week: Result := 10080;
    ai2Week: Result := 20160;
  end;
end;

function GetAlarmFlagIndex(AAlarmMinute: integer): integer;
begin
  case AAlarmMinute of
    -1 : Result := ord(aiNone);
    0: Result := ord(ai0Min);
    5: Result := ord(ai5Min);
    10: Result := ord(ai10Min);
    15: Result := ord(ai15Min);
    30: Result := ord(ai30Min);
    60: Result := ord(ai1Hour);
    120: Result := ord(ai2Hour);
    180: Result := ord(ai3Hour);
    240: Result := ord(ai4Hour);
    300: Result := ord(ai5Hour);
    360: Result := ord(ai6Hour);
    420: Result := ord(ai7Hour);
    480: Result := ord(ai8Hour);
    540: Result := ord(ai9Hour);
    600: Result := ord(ai10Hour);
    660: Result := ord(ai11Hour);
    1080: Result := ord(ai18Hour);
    1440: Result := ord(ai1Day);
    2880: Result := ord(ai2Day);
    4320: Result := ord(ai3Day);
    5760: Result := ord(ai4Day);
    10080: Result := ord(ai1Week);
    20160: Result := ord(ai2Week);
  end;
end;

end.
