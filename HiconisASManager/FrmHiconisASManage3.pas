unit FrmHiconisASManage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ImgList,
  NxColumnClasses, NxColumns, NxScrollControl, NxCustomGridControl,
  NxCustomGrid, NxGrid, AdvOfficeTabSet, Vcl.StdCtrls, Vcl.ComCtrls,
  AdvGroupBox, AdvOfficeButtons, AeroButtons, JvExControls, JvLabel,
  CurvyControls, System.SyncObjs, DateUtils, Vcl.Menus,
  OtlCommon, OtlComm, OtlTaskControl, OtlContainerObserver, otlTask, OtlParallel,
  mormot.core.base, mormot.core.datetime, mormot.core.data, mormot.core.variants,
  mormot.orm.base, mormot.core.text, mormot.core.unicode, mormot.core.json, mormot.core.collections,
  VarRecUtils,
  CommonData2, UnitOLDataType, UnitGenericsStateMachine_pjh,//FSMClass_Dic, FSMState,
  Vcl.ExtCtrls, FrmTodoList, UnitTodoCollect2, FrmInqManageConfig, UnitElecMasterData,
  {$IFDEF GAMANAGER}
  UnitHiconisMasterRecord, FrmHiconisASTaskEdit, UnitElecServiceData2, UnitMakeReport2,
  UnitHiASSubConRecord, UnitHiASMaterialRecord, UnitToDoList,
  {$ELSE}
  UElecDataRecord, TaskForm, UnitElecServiceData, UnitMakeReport, UnitElecServiceData2,
  {$ENDIF}
  UnitIniConfigSetting2, UnitUserDataRecord2, SBPro, UnitOLEmailRecord2,
  DropSource, DragDrop, DropTarget;

type
  THiconisAsManageF1 = class(TForm)
    CurvyPanel1: TCurvyPanel;
    JvLabel2: TJvLabel;
    JvLabel5: TJvLabel;
    JvLabel6: TJvLabel;
    JvLabel1: TJvLabel;
    JvLabel3: TJvLabel;
    JvLabel7: TJvLabel;
    JvLabel4: TJvLabel;
    JvLabel8: TJvLabel;
    JvLabel9: TJvLabel;
    JvLabel10: TJvLabel;
    PeriodPanel: TCurvyPanel;
    Label4: TLabel;
    rg_period: TAdvOfficeRadioGroup;
    dt_begin: TDateTimePicker;
    dt_end: TDateTimePicker;
    ComboBox1: TComboBox;
    ProductTypeCombo: TComboBox;
    CustomerCombo: TComboBox;
    SubjectEdit: TEdit;
    HullNoEdit: TEdit;
    ShipNameEdit: TEdit;
    BefAftCB: TComboBox;
    CurWorkCB: TComboBox;
    Panel1: TPanel;
    btn_Search: TAeroButton;
    btn_Close: TAeroButton;
    AeroButton1: TAeroButton;
    WorkKindCB: TComboBox;
    ClaimNoEdit: TEdit;
    OrderNoEdit: TEdit;
    PONoEdit: TEdit;
    DisplayFinalCheck: TCheckBox;
    Button1: TButton;
    PICCB: TComboBox;
    TaskTab: TAdvOfficeTabSet;
    grid_Req: TNextGrid;
    NxIncrementColumn1: TNxIncrementColumn;
    OrderNo: TNxTextColumn;
    HullNo: TNxTextColumn;
    ShipName: TNxTextColumn;
    ClaimNo: TNxTextColumn;
    Subject: TNxTextColumn;
    Status: TNxTextColumn;
    NextProcess: TNxTextColumn;
    ClaimServiceKind: TNxTextColumn;
    ReqCustomer: TNxTextColumn;
    ProdType: TNxTextColumn;
    RecvDate: TNxDateColumn;
    Email: TNxButtonColumn;
    EMailID: TNxTextColumn;
    PONo: TNxTextColumn;
    QtnNo: TNxTextColumn;
    CustomerName: TNxTextColumn;
    QtnInputDate: TNxDateColumn;
    OrderInputDate: TNxDateColumn;
    InvoiceInputDate: TNxDateColumn;
    CustomerAddress: TNxMemoColumn;
    ClaimRecvDate: TNxTextColumn;
    ClaimInputDate: TNxTextColumn;
    ClaimReadyDate: TNxTextColumn;
    ClaimClosedDate: TNxTextColumn;
    Importance: TNxTextColumn;
    ClaimStatus: TNxTextColumn;
    StatusBarPro1: TStatusBarPro;
    imagelist24x24: TImageList;
    ImageList16x16: TImageList;
    PopupMenu1: TPopupMenu;
    Mail1: TMenuItem;
    Create1: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N6: TMenuItem;
    Invoice4: TMenuItem;
    Invoice3: TMenuItem;
    InvoiceConfirm2: TMenuItem;
    N9: TMenuItem;
    N8: TMenuItem;
    N7: TMenuItem;
    N23: TMenuItem;
    oDOList1: TMenuItem;
    N22: TMenuItem;
    GetHullNoToClipboard1: TMenuItem;
    N1: TMenuItem;
    DeleteTask1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N10: TMenuItem;
    ShowTaskID1: TMenuItem;
    ShowEmailID1: TMenuItem;
    ShowGSFileID1: TMenuItem;
    GetJsonValues1: TMenuItem;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Invoice1: TMenuItem;
    Invoice2: TMenuItem;
    InvoiceConfirm1: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    N5: TMenuItem;
    ImageList32x32: TImageList;
    DropEmptyTarget1: TDropEmptyTarget;
    DataFormatAdapterOutlook: TDataFormatAdapter;
    DropEmptySource1: TDropEmptySource;
    DataFormatAdapter2: TDataFormatAdapter;
    DataFormatAdapterTarget: TDataFormatAdapter;
    DataFormatAdapter1: TDataFormatAdapter;
    Timer1: TTimer;
    OpenDialog1: TOpenDialog;

    procedure btn_SearchClick(Sender: TObject);
    procedure ComboBox1DropDown(Sender: TObject);
    procedure rg_periodClick(Sender: TObject);
    procedure grid_ReqCellDblClick(Sender: TObject; ACol, ARow: Integer);
    procedure EmailButtonClick(Sender: TObject);
    procedure ShowTaskID1Click(Sender: TObject);
    procedure ShowEmailID1Click(Sender: TObject);
    procedure DeleteTask1Click(Sender: TObject);
    procedure ShowGSFileID1Click(Sender: TObject);
    procedure CurWorkCBDropDown(Sender: TObject);
    procedure ProductTypeComboDropDown(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure TaskTabChange(Sender: TObject);
    procedure HullNoEditKeyPress(Sender: TObject; var Key: Char);
    procedure ShipNameEditKeyPress(Sender: TObject; var Key: Char);
    procedure SubjectEditKeyPress(Sender: TObject; var Key: Char);
    procedure Invoice4Click(Sender: TObject);
    procedure AeroButton1Click(Sender: TObject);
    procedure GetJsonValues1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure grid_ReqKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N19Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure PICCBChange(Sender: TObject);
    procedure GetHullNoToClipboard1Click(Sender: TObject);
    procedure oDOList1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure DropEmptyTarget1Drop(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    FStopEvent    : TEvent;
    FDBMsgQueue: TOmniMessageQueue;
    FIPCMQFromOL: TOmniMessageQueue;
    FWorker4OLMsg: TWorker4OLMsg;
    FTaskEditConfig: THiconisASTaskEditConfig;
    FTaskJson: String;
    FFileContent: RawByteString;

    //Websocket-b
    FModel: TSQLModel;
    FHTTPServer: TRestHttpServer;
    FRestServer: TRestServer;
    FServiceFactoryServer: TServiceFactoryServer;

    FIpAddr: string;
    FURL: string; //Server에서 Client에 Config Change Notify 하기 위한 Call Back URL
    FIsServerActive,
    FIsPJHPC,
    FIsRunRestServer: Boolean;

    FUserEmail,
    FUserName: string;
//    FCommModes: TCommModes;
    //Websocket-e

    FOLControlWorker: TOLControlWorker;
    FCommandQueue    : TOmniMessageQueue;
    FResponseQueue   : TOmniMessageQueue;
    FSendMsgQueue    : TOmniMessageQueue;

    FOLEmailQueue,
    FOLCalendarQueue,
    FOLAppointmentQueue: TOmniMessageQueue;

    procedure OnGetStream(Sender: TFileContentsStreamOnDemandClipboardFormat;
      Index: integer; out AStream: IStream);

    procedure ProcessCommand(ARespond: string);
    //Macro에서 ExecFunction으로 FunctionName을 주면 아래의 public란 Procedure에서
    //함수명을 찾아서 실행해 줌
    procedure ExecFunc(AFuncName: string);
    procedure ExecMethod(MethodName:string; const Args: array of TValue);

    function SaveCurrentTask2File(AFileName: string = '') : string;
    procedure CreateNewTask(AJson: RawUtf8='');

    //Websocket-b
    procedure CreateHttpServer4WS(APort, ATransmissionKey: string;
      aClient: TInterfacedClass; const aInterfaces: array of TGUID);
    procedure DestroyHttpServer;
    function SessionCreate(Sender: TRestServer; Session: TAuthSession;
                  Ctxt: TRestServerURIContext): boolean;
    function SessionClosed(Sender: TRestServer; Session: TAuthSession;
                  Ctxt: TRestServerURIContext): boolean;
    procedure InitNetwork;
    function ServerExecuteFromClient(ACommand: RawUTF8): RawUTF8;
    //Websocket-e

    procedure StartOLControlWorker;
    procedure StopOLControlWorker;

    procedure TestRemoteTaskList;
    procedure TestRemoteTaskDetail;

    //g_GSDocType 반환함
    function ShowFileSelectForm(): integer;

    procedure ExecuteSearch(Key: Char);

    //TaskTab의 tag에 TSalesProcess값을 지정함
    //마우스로 tab 선택 시 해당 Task만 보이기 위함
    procedure InitTaskTab;
    procedure InputValueClear;
    procedure InitTaskEnum;

    function GetSqlWhereFromQueryDate(AQueryDate: TQueryDateType): string;
    function GetTaskIdFromGrid(ARow: integer): TID;

    function Get_Doc_SubCon_Invoice_List_Rec: Doc_SubCon_Invoice_List_Rec;

    function Get_Doc_Qtn_Rec(ARow: integer): Doc_Qtn_Rec;
    function Get_Doc_Inv_Rec(ARow: integer): Doc_Invoice_Rec;
    function Get_Doc_ServiceOrder_Rec(ARow: integer): Doc_ServiceOrder_Rec;
    function Get_Doc_Cust_Reg_Rec(ARow: integer): Doc_Cust_Reg_Rec;

    procedure MakeQtn(ARow: integer);
    procedure MakeInvoice(ARow: integer);
    procedure MakeServiceOrder(ARow: integer);
    procedure MakeCustReg(ARow: integer);
    function CheckRegistration: Boolean;
    procedure DisplayOLMsg2Grid(const task: IOmniTaskControl;
      const msg: TOmniMessage);
  protected
    procedure ShowTaskIDFromGrid;
    procedure ShowEmailIDFromGrid;

    procedure ProcessPasteEvent(ATxt: string);
    function GetUserList: TStrings;
    function GetUserListFromFile(AFileName: string): TStrings;
  public
    //메일을 이동시킬 폴더 리스트,
    //HGS Task/Send Folder Name 2 IPC 메뉴에 의해 OL으로 부터 수신함
    FFolderListFromOL,
    FTempJsonList,
    FUserList: TStringList;//Remote에서 Task요청시 Result Json저장함
    FToDoCollect: TpjhToDoItemCollection;
    FpjhToDoList: TpjhToDoList;
    FSettings : TConfigSettings;
    FIniFileName,
    FMyIPAddress,
    FRemoteIPAddress: string;
    //CreateConstArray함수가 반드시 생성자에서 실행되어야 클래스 안에서 사용 가능함
    //Parameter로 전달하면 안됨
//    FConstArray: TConstArray;
    FRootName,
    FPortName,
    FTransmissionKey: string;

    //Main or 단순 조회: Main := 0, 단순 조회 := 1
    FProgMode: integer;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SetNetworkInfo(ARootName, APortName, AKeyName: string);
    function GetMyName(AEmail: string): string;
    procedure LoadConfigFromFile(AFileName: string = '');
    procedure LoadConfig2Form(AForm: TConfigF);
    procedure LoadConfigForm2Object(AForm: TConfigF);
    procedure SetConfig;
    procedure ApplyConfigChanged;
    function GetRecvEmailAddress(AMailType: integer): string;
    procedure GetSearchCondRec(var ARec: TSearchCondRec);
//    procedure GetWhereConstArr(ASearchCondRec: TSearchCondRec; var AWhere: string);// var AConstArr: TConstArray);
    function GetIsRemote(var ARemoteAddr: string): Boolean;
    procedure FillInUserList;

    function GetTask: TOrmHiconisASTask;
    procedure DisplayTaskInfo2EditForm(const ATaskID: integer); overload;
    procedure DisplayTaskInfo2Grid(ASearchCondRec: TSearchCondRec; AFromRemote: Boolean = False);
    procedure LoadTaskVar2Grid(AVar: TOrmHiconisASTask; AGrid: TNextGrid;
      ARow: integer = -1);
    procedure LoadGSTask2Grid(ATask: TOrmHiconisASTask; AGrid: TNextGrid;
      ARow: integer = -1);

    procedure AddFolderListFromOL(AFolder: string);

    procedure ShowTaskFormFromGrid(ARow: integer);
    procedure ShowTaskFormFromDB(ARow: integer); overload;
    procedure ShowTaskFormFromDB(AIDList: TIDList; ARow: integer); overload;
    procedure ShowEmailListFormFromData(ARow: integer);
    procedure ShowTodoListFormFromData(ARow: integer);
    procedure ShowToDoListFromCollect(AToDoCollect: TpjhToDoItemCollection);

    procedure ShowTodoListFormFromDBByGridRow(ARow: integer);
    procedure ShowToDoListFormFromList(ATaskId: TID; AToDoList: TpjhToDoList);

    procedure SetUserNameNIPAddressFromRegServer;

    //--> Remote Command Proess
    procedure DisplayTaskInfo2GridFromJson(AJson: RawUTF8);
    procedure ShowTaskFormFromJson(AJson: RawUTF8);

    procedure AsynDisplayOLMsg2Grid;//(AStopEvent: TEvent; AIPCMQFromOL: TOmniMessageQueue);
    procedure SendReqOLEmailInfo;
    procedure SendReqOLEmailInfo_CromisIPC;
    procedure SendReqOLEmailInfo_WS;

    procedure KeyIn_CompanyCode;
    procedure KeyIn_RFQ;
    procedure Select_Money;
    procedure KeyIn_Content;
    procedure Select_DeliveryCondition;
    procedure Select_EstimateType;
    procedure Select_TermsOfPayment;
  end;

implementation

uses System.Rtti, UnitIPCModule2, ClipBrd, System.RegularExpressions,
  UnitGSFileRecord2, getIp, UnitBase64Util2,
  {$IFDEF GAMANAGER}
  UnitHiconisASVarJsonUtil, UnitHiASToDoRecord, FrmToDoList2,
  {$ELSE}
  UnitVariantJsonUtil,
  {$ENDIF}
  UnitHttpModule4InqManageServer2, UnitStringUtil,

  System.DateUtils, OtlParallel, Clipbrd, UnitIPCModule2,
  Vcl.ogutil, UnitDragUtil, UnitHiconisASVarJsonUtil, FrmOLEmailList,//FrmEmailListView2,
  UnitBase64Util2, UnitCmdExecService, FrmEditTariff2, UnitGSTariffRecord2,
  FrmDisplayTariff2, OLMailWSCallbackInterface2, FrmFileSelect, UnitMakeReport2,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Winapi.ActiveX, Vcl.ExtCtrls, Vcl.Menus,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, NxColumnClasses, NxColumns,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid, AdvOfficeTabSet,
  Vcl.StdCtrls, Vcl.ComCtrls, AdvGroupBox, AdvOfficeButtons, AeroButtons,
  JvExControls, JvLabel, CurvyControls, Vcl.ImgList, System.SyncObjs,
  OtlCommon, OtlComm, OtlTaskControl, OtlContainerObserver, otlTask,
  mormot.core.base, mormot.rest.client, mormot.orm.core, mormot.rest.http.server,
  mormot.rest.server, mormot.soa.server, mormot.core.datetime, mormot.rest.memserver,
  mormot.soa.core, mormot.core.interfaces, mormot.core.os, mormot.core.text,
  mormot.rest.http.client, mormot.core.json, mormot.core.unicode, mormot.core.variants,
  CommonData2, FrmHiconisASTaskEdit, UnitHiconisMasterRecord, System.Rtti,
  DragDropInternet,DropSource,DragDropFile,DragDropFormats, DragDrop, DropTarget,
  VarRecUtils,
  UnitHiconisASWSInterface, UnitOLDataType, thundax.lib.actions_pjh,
  UnitMAPSMacro2, UnitUserDataRecord2, UnitElecServiceData2,
  FrameDisplayTaskInfo2, UnitOLControlWorker, UnitWorker4OmniMsgQ;

{$R *.dfm}

procedure THiconisAsManageF1.SubjectEditKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteSearch(Key);
end;

procedure THiconisAsManageF1.CurWorkCBDropDown(Sender: TObject);
begin
  g_SalesProcess.SetType2Combo(CurWorkCB);
end;

procedure THiconisAsManageF1.LoadConfig2Form(AForm: TConfigF);
begin
  FSettings.LoadConfig2Form(AForm, FSettings);
end;

procedure THiconisAsManageF1.LoadConfigForm2Object(AForm: TConfigF);
begin
  FSettings.LoadConfigForm2Object(AForm, FSettings);
end;

procedure THiconisAsManageF1.LoadConfigFromFile(AFileName: string);
begin
  FSettings.Load(AFileName);

  if FSettings.MQServerIP = '' then
    FSettings.MQServerIP := '127.0.0.1';
end;

procedure THiconisAsManageF1.LoadGSTask2Grid(ATask: TOrmHiconisASTask; AGrid: TNextGrid;
  ARow: integer);
var
  LStrList: TStringList;
  LFSMState: THiconisASState;
begin
  if ARow = -1 then
  begin
    ARow := AGrid.AddRow;
    AGrid.Row[ARow].Data := TIDList.Create;
    TIDList(AGrid.Row[ARow].Data).TaskId := ATask.TaskID;
  end;

  with ATask, AGrid do
  begin
    CellByName['HullNo', ARow].AsString := HullNo;
    CellByName['ShipName', ARow].AsString := ShipName;

    if WorkSummary <> '' then
      CellByName['Subject', ARow].AsString := WorkSummary
    else
      CellByName['Subject', ARow].AsString := EmailSubject;

    CellByName['ProdType', ARow].AsString := ProductType;
//    CellByName['PONo', ARow].AsString := PO_No;
//    CellByName['QtnNo', ARow].AsString := QTN_No;
    CellByName['OrderNo', ARow].AsString := Order_No;
    CellByName['ReqCustomer', ARow].AsString := ShipOwner;
    CellByName['Status', ARow].AsString := g_SalesProcess.ToString(CurrentWorkStatus);
    CellByName['Email', ARow].AsInteger := NumOfEMails;

    if NextWork > 0 then
    begin
      CellByName['NextProcess', ARow].AsString := g_SalesProcess.ToString(NextWork);
    end
    else
    begin
      LFSMState := g_HiconisASState.ToType(Ord(SalesProcessType));

//      if Assigned(LFSMState) then
//      begin
//        LStrList := TStringList.Create;
//        try
//          SalesProcess2List(LStrList, LFSMState);
//          CellByName['NextProcess', ARow].AsString := g_SalesProcess.ToString(
//            LFSMState.GetOutput(CurrentWorkStatus));
//        finally
//          LStrList.Free;
//        end;
//      end;
    end;

//      CellByName['CustomerName', ARow].AsString := ReqCustomer;
//      CellByName['CustomerAddress', ARow].AsString := CustomerAddress;

//    CellByName['QtnInputDate', ARow].AsDateTime := TimeLogToDateTime(QTNInputDate);
//    CellByName['OrderInputDate', ARow].AsDateTime := TimeLogToDateTime(OrderInputDate);
    CellByName['RecvDate', ARow].AsDateTime := TimeLogToDateTime(InqRecvDate);
    CellByName['InvoiceInputDate', ARow].AsDateTime := TimeLogToDateTime(InvoiceIssueDate);
    CellByName['ClaimNo', ARow].AsString := ClaimNo;
    CellByName['ClaimServiceKind', ARow].AsString := g_ClaimServiceKind.ToString(ClaimServiceKind);
    CellByName['ClaimRecvDate', ARow].AsDateTime := TimeLogToDateTime(ClaimRecvDate);
    CellByName['ClaimInputDate', ARow].AsDateTime := TimeLogToDateTime(ClaimInputDate);
    CellByName['ClaimReadyDate', ARow].AsDateTime := TimeLogToDateTime(ClaimReadyDate);
    CellByName['ClaimClosedDate', ARow].AsDateTime := TimeLogToDateTime(ClaimClosedDate);
    TIDList(Row[ARow].Data).EmailId := EmailID;
  end;
end;

procedure THiconisAsManageF1.LoadTaskVar2Grid(AVar: TOrmHiconisASTask; AGrid: TNextGrid;
  ARow: integer);
var
  LIds: TIDDynArray;
  LSubject: string;
  LMailCount: integer;
begin
  if not Assigned(AVar) then
    exit;

  AVar.NumOfEMails := GetEmailCountFromTaskID(AVar.TaskID);
//  AVar.EmailSubject := LSubject;
  AVar.TaskID := AVar.ID;

  LoadGSTask2Grid(AVar, AGrid, ARow);
end;

procedure THiconisAsManageF1.MakeCustReg(ARow: integer);
var
  LRec: Doc_Cust_Reg_Rec;
begin
  LRec := Get_Doc_Cust_Reg_Rec(ARow);
  MakeDocCustomerRegistration(LRec);
end;

procedure THiconisAsManageF1.MakeInvoice(ARow: integer);
var
  LRec: Doc_Invoice_Rec;
begin
  LRec := Get_Doc_Inv_Rec(ARow);
  MakeDocInvoice(LRec);
end;

procedure THiconisAsManageF1.MakeQtn(ARow: integer);
var
  LRec: Doc_Qtn_Rec;
begin
  LRec := Get_Doc_Qtn_Rec(ARow);
  MakeDocQtn(LRec);
end;

procedure THiconisAsManageF1.MakeServiceOrder(ARow: integer);
var
  LRec: Doc_ServiceOrder_Rec;
begin
  LRec := Get_Doc_ServiceOrder_Rec(ARow);
  MakeDocServiceOrder(LRec);
end;

procedure THiconisAsManageF1.N11Click(Sender: TObject);
var
  LTask: TOrmHiconisASTask;
begin
  LTask := GetTask;
  try
    SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, LTask,
      FSettings,
      GetRecvEmailAddress(TMenuItem(Sender).Tag));
  finally
    FreeAndNil(LTask);
  end;
end;

procedure THiconisAsManageF1.N12Click(Sender: TObject);
var
  LTask: TOrmHiconisASTask;
begin
  LTask := GetTask;
  try
    SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, LTask,
      FSettings,
      GetRecvEmailAddress(TMenuItem(Sender).Tag));
  finally
    FreeAndNil(LTask);
  end;
end;

procedure THiconisAsManageF1.N13Click(Sender: TObject);
var
  LTask: TOrmHiconisASTask;
begin
  LTask := GetTask;
  try
      SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, LTask,
      FSettings,
      GetRecvEmailAddress(TMenuItem(Sender).Tag));
  finally
    FreeAndNil(LTask);
  end;
end;

procedure THiconisAsManageF1.N14Click(Sender: TObject);
var
  LTask: TOrmHiconisASTask;
begin
  LTask := GetTask;
  try
      SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, LTask,
      FSettings,
      GetRecvEmailAddress(TMenuItem(Sender).Tag));
  finally
    FreeAndNil(LTask);
  end;
end;

procedure THiconisAsManageF1.N15Click(Sender: TObject);
var
  LTask: TOrmHiconisASTask;
begin
  LTask := GetTask;
  try
    SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, LTask,
      FSettings,
      GetRecvEmailAddress(TMenuItem(Sender).Tag));
  finally
    FreeAndNil(LTask);
  end;
end;

procedure THiconisAsManageF1.N16Click(Sender: TObject);
var
  LTask: TOrmHiconisASTask;
begin
  LTask := GetTask;
  try
    SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, LTask,
      FSettings,
      GetRecvEmailAddress(TMenuItem(Sender).Tag));
  finally
    FreeAndNil(LTask);
  end;
end;

procedure THiconisAsManageF1.N18Click(Sender: TObject);
var
  LTask: TOrmHiconisASTask;
begin
  LTask := GetTask;
  try
    SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, LTask,
      FSettings,
      GetRecvEmailAddress(TMenuItem(Sender).Tag));
  finally
    FreeAndNil(LTask);
  end;
end;

procedure THiconisAsManageF1.N19Click(Sender: TObject);
var
  LTask: TOrmHiconisASTask;
begin
  LTask := GetTask;
  try
    SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, LTask,
      FSettings,
      GetRecvEmailAddress(TMenuItem(Sender).Tag));
  finally
    FreeAndNil(LTask);
  end;
end;

procedure THiconisAsManageF1.N20Click(Sender: TObject);
var
  LTask: TOrmHiconisASTask;
begin
  LTask := GetTask;
  try
    SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, LTask,
      FSettings,
      GetRecvEmailAddress(TMenuItem(Sender).Tag));
  finally
    FreeAndNil(LTask);
  end;
end;

procedure THiconisAsManageF1.N21Click(Sender: TObject);
var
  LTask: TOrmHiconisASTask;
begin
  LTask := GetTask;
  try
    SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, LTask,
      FSettings,
      GetRecvEmailAddress(TMenuItem(Sender).Tag));
  finally
    FreeAndNil(LTask);
  end;
end;

procedure THiconisAsManageF1.N4Click(Sender: TObject);
var
  LRec: Doc_SubCon_Invoice_List_Rec;
  LWorksheet: OleVariant;
  LRow: integer;
begin
//  LRec := Get_Doc_SubCon_Invoice_List_Rec;
//  LWorksheet := MakeDocSubConInvoiceList;
//  MakeDocSubConInvoiceList2(LWorkSheet, LRec, LRow);
end;

procedure THiconisAsManageF1.oDOList1Click(Sender: TObject);
begin
  if grid_Req.SelectedCount = 0 then
  begin
    ShowMessage('Task를 선택 하세요.');
    exit;
  end;

//  ShowTodoListFormFromData(grid_Req.SelectedRow);
  ShowTodoListFormFromDBByGridRow(grid_Req.SelectedRow);
end;

procedure THiconisAsManageF1.OnGetStream(
  Sender: TFileContentsStreamOnDemandClipboardFormat; Index: integer;
  out AStream: IStream);
var
  LStream: TStringStream;
begin
  LStream := TStringStream.Create;
  try
//    LStr := Utf8ToString(AnsiToUTF8(FTaskJson));
    LStream.WriteString(FTaskJson);
    AStream := nil;
    AStream := TFixedStreamAdapter.Create(LStream, soOwned);
  except
    raise;
  end;
end;

procedure THiconisAsManageF1.PICCBChange(Sender: TObject);
begin
  GetIsRemote(FRemoteIPAddress);
end;

procedure THiconisAsManageF1.ProcessCommand(ARespond: string);
begin

end;

procedure THiconisAsManageF1.ProcessPasteEvent(ATxt: string);
var
  LStr: string;
  LRegexpr: TRegEx;
  LMatch: TMatch;
  LGroup: TGroup;
begin
  LStr := System.SysUtils.Trim(ATxt);

  LRegexpr := TRegEx.Create(REGEX_HULLNO_PATTERN, [roIgnoreCase]);
  LMatch := LRegexpr.Match(LStr);

  if LMatch.Success then
  begin
    InputValueClear;
    HullNoEdit.Text := LStr;
  end
  else
  begin
    LRegexpr := TRegEx.Create(REGEX_ORDERNO_PATTERN, [roIgnoreCase]);
    LMatch := LRegexpr.Match(LStr);

    if LMatch.Success then
    begin
      InputValueClear;
      OrderNoEdit.Text := LStr;
    end
    else
    begin
      LRegexpr := TRegEx.Create(REGEX_SHIPNAME_PATTERN, [roIgnoreCase]);
      LMatch := LRegexpr.Match(LStr);

      if LMatch.Success then
      begin
        InputValueClear;
        ShipNameEdit.Text := LStr;
      end;
    end;
  end;
end;

procedure THiconisAsManageF1.ProductTypeComboDropDown(Sender: TObject);
begin
  g_ElecProductType.SetType2Combo(ProductTypeCombo);
end;

procedure THiconisAsManageF1.rg_periodClick(Sender: TObject);
begin
  dt_begin.Enabled := False;
  dt_end.Enabled := False;
  case rg_period.ItemIndex of
    0:
      begin
        dt_begin.Date := Now;
        dt_end.Date := Now;
      end;
    1:
      begin
        dt_begin.Date := StartOfTheWeek(Now);
        dt_end.Date := EndOfTheWeek(Now);
      end;
    2:
      begin
        dt_begin.Date := StartOfTheMonth(Now);
        dt_end.Date := EndOfTheMonth(Now);
      end;
    3:
      begin
        dt_begin.Enabled := True;
        dt_end.Enabled := True;
      end;
  end;
end;

procedure THiconisAsManageF1.GetJsonValues1Click(Sender: TObject);
var
  LTask: TOrmHiconisASTask;
  LUtf8: RawUTF8;
  LDynArr: TDynArray;
  LCount: integer;
  LCustomer: TSQLCustomer;
  LSubCon: TSQLSubCon;
  LMat4Proj: TSQLMaterial4Project;
  LV,LV2,LV3: variant;
begin
  TDocVariant.New(LV);

  LTask := GetTask;
  try
    LUtf8 := LTask.GetJSONValues(true, true, soSelect);
    LV.Task := _JSON(LUtf8);

    LCustomer := GetCustomerFromTask(LTask);
    LUtf8 := LCustomer.GetJSONValues(true, true, soSelect);
    LV.Customer := _JSON(LUtf8);;

    LSubCon := GetSubConFromTask(LTask);
    LUtf8 := LSubCon.GetJSONValues(true, true, soSelect);
    LV.SubCon := _JSON(LUtf8);;

    LMat4Proj := GetMaterial4ProjFromTask(LTask);
    LUtf8 := LMat4Proj.GetJSONValues(true, true, soSelect);
    LV.Mat4Proj := _JSON(LUtf8);

    LUtf8 := VariantSaveJSON(LV);

    TDocVariant.New(LV3);
    LV3 := _JSON(LUtf8);

    TDocVariant.New(LV2);
    LV2 := _JSON(LV3.Task);
//    ShowMessage(LV2.ShipName);
//    Memo1.Text := Utf8ToString(LV3.Task);
  finally
    FreeAndNil(LCustomer);
    FreeAndNil(LSubCon);
    FreeAndNil(LMat4Proj);
    LTask.Free;
  end;
end;

function THiconisAsManageF1.GetMyName(AEmail: string): string;
begin
  Result := GetMyNameNIPAddressFromEmailAddress(AEmail);
end;

function THiconisAsManageF1.GetRecvEmailAddress(AMailType: integer): string;
begin
  case AMailType of
    1: Result := '';//Invoice 송부
    2: Result := FSettings.SalesDirectorEmailAddr;// SALES_DIRECTOR_EMAIL_ADDR;//매출처리요청
    3: Result := FSettings.MaterialInputEmailAddr;// MATERIAL_INPUT_EMAIL_ADDR;//자재직투입요청
    4: Result := FSettings.ForeignInputEmailAddr;// FOREIGN_INPUT_EMAIL_ADDR;//해외고객업체등록
    5: Result := FSettings.ElecHullRegEmailAddr;// ELEC_HULL_REG_EMAIL_ADDR;//전전비표준공사 생성 요청
    6: Result := PO_REQ_EMAIL_ADDR; //PO 요청
    7: Result := FSettings.ShippingReqEmailAddr;// SHIPPING_REQ_EMAIL_ADDR; //출하 요청
    8: Result := FSettings.FieldServiceReqEmailAddr;// FIELDSERVICE_REQ_EMAIL_ADDR; //필드서비스팀 요청
  end;
end;

procedure THiconisAsManageF1.GetSearchCondRec(var ARec: TSearchCondRec);
var
  LQueryDateType: TQueryDateType;
begin
  if ComboBox1.ItemIndex = -1 then
    LQueryDateType := qdtNull
  else
    LQueryDateType := g_QueryDateType.ToType(ComboBox1.ItemIndex);

  with ARec do
  begin
    FFrom := dt_Begin.Date;
    FTo := dt_end.Date;
    FQueryDate := LQueryDateType;
    FHullNo := HullNoEdit.Text;
    FShipName := ShipNameEdit.Text;
    FCustomer := CustomerCombo.Text;
    FProdType := ProductTypeCombo.Text;
    FSubject := SubjectEdit.Text;
    FCurWork :=  CurWorkCB.ItemIndex;
    FBefAft :=  BefAftCB.ItemIndex;
    FWorkKind :=  WorkKindCB.ItemIndex;
    FClaimNo := ClaimNoEdit.Text;
//    FQtnNo := QtnNoEdit.Text;
    FOrderNo := OrderNoEdit.Text;
    FPoNo := PONoEdit.Text;

//    if PICCB.ItemIndex = -1 then
//      PICCB.ItemIndex := 0;

    if PICCB.ItemIndex <> -1 then
      FRemoteIPAddress := PICCB.Items.ValueFromIndex[PICCB.ItemIndex]
    else
      FRemoteIPAddress := '';
  end;
end;

function THiconisAsManageF1.GetSqlWhereFromQueryDate(AQueryDate: TQueryDateType): string;
begin
  case AQueryDate of
    qdtInqRecv: Result := 'InqRecvDate >= ? and InqRecvDate <= ? ';
    qdtInvoiceIssue: Result := 'InvoiceIssueDate >= ? and InvoiceIssueDate <= ? ';
    qdtQTNInput: Result := 'QTNInputDate >= ? and QTNInputDate <= ? ';
    qdtOrderInput: Result := 'OrderInputDate >= ? and OrderInputDate <= ? ';
  end;
end;

function THiconisAsManageF1.GetTask: TOrmHiconisASTask;
var
  LTaskID: TID;
begin
  LTaskID := GetTaskIdFromGrid(grid_Req.SelectedRow);
  Result := GetLoadTask(LTaskID);
end;

function THiconisAsManageF1.GetTaskIdFromGrid(ARow: integer): TID;
begin
  if Assigned(grid_Req.Row[ARow].Data) then
    Result := TIDList(grid_Req.Row[ARow].Data).fTaskId
  else
    Result := -1;
end;

function THiconisAsManageF1.GetUserList: TStrings;
var
  LSQLUserDetail: TSQLUserDetail;
begin
  Result := TStringList.Create;
  LSQLUserDetail := GetUserDetails;

  try
    while LSQLUserDetail.FillOne do
    begin
      Result.Add(LSQLUserDetail.UserName + '=' + LSQLUserDetail.PCIPAddress);
    end;
  finally
    LSQLUserDetail.Free;
  end;
end;

function THiconisAsManageF1.GetUserListFromFile(AFileName: string): TStrings;
var
  LStr: string;
  LUtf8: RawUTF8;
begin
  if not FileExists(AFileName) then
  begin
    ShowMessage(AFileName + 'is not exists');
    Result := nil;
    exit;
  end;

  Result := TStringList.Create;
  Result.LoadFromFile(AFileName);
  LStr := Result.Text;
  System.Delete(LStr, Length(LStr)-1, 2);
  LUtf8 := StringToUTF8(LStr);
  LStr := MakeBase64ToString(LUtf8);
  Result.Text := LStr;
end;

//procedure TDisplayTaskF.GetWhereConstArr(ASearchCondRec: TSearchCondRec;
//  var AWhere: string);// var AConstArr: TConstArray);
//var
//  LFrom, LTo: TTimeLog;
//begin
//  if ASearchCondRec.FQueryDate <> qdtNull then
//  begin
//    if ASearchCondRec.FFrom <= ASearchCondRec.FTo then
//    begin
//      LFrom := TimeLogFromDateTime(ASearchCondRec.FFrom);
//      LTo := TimeLogFromDateTime(ASearchCondRec.FTo);
//
//      if ASearchCondRec.FQueryDate <> qdtNull then
//      begin
//        AddConstArray(FConstArray, [LFrom, LTo]);
//        AWhere := GetSqlWhereFromQueryDate(ASearchCondRec.FQueryDate);
//      end;
//    end;
//  end;
//
//  if ASearchCondRec.FHullNo <> '' then
//  begin
//    AddConstArray(FConstArray, ['%'+ASearchCondRec.FHullNo+'%']);
//    if AWhere <> '' then
//      AWhere := AWhere + ' and ';
//    AWhere := AWhere + 'HullNo LIKE ? ';
//  end;
//
//  if ASearchCondRec.FShipName <> '' then
//  begin
//    AddConstArray(FConstArray, ['%'+ASearchCondRec.FShipName+'%']);
//    if AWhere <> '' then
//      AWhere := AWhere + ' and ';
//    AWhere := AWhere + ' ShipName LIKE ? ';
//  end;
//
//  if ASearchCondRec.FCustomer <> '' then
//  begin
////      LSQLCustomer := TSQLCustomer.CreateAndFillPrepare(g_MasterDB,'CompanyName LIKE ?',['%'+ACustomer+'%']);
////      LStr := '';
////      try
////        while LSQLCustomer.FillOne do
////        begin
////          AddConstArray(ConstArray, [LSQLCustomer.TaskID]);
////
////          if LStr <> '' then
////            LStr := LStr + ' or ';
////
////          LStr := LStr + ' ID = ? ';
////        end;
////      finally
////        if LStr <> '' then
////        begin
////          if LWhere <> '' then
////            LWhere := LWhere + ' and ';
////          LWhere :=  LWhere + '( ' + LStr + ')';
////        end;
////
////        FreeAndNil(LSQLCustomer);
////      end;
//    AddConstArray(FConstArray, ['%'+ASearchCondRec.FCustomer+'%']);
//    if AWhere <> '' then
//      AWhere := AWhere + ' and ';
//    AWhere := AWhere + ' ShipOwner LIKE ? ';
//  end;
//
//  if ASearchCondRec.FSubject <> '' then
//  begin
//    AddConstArray(FConstArray, ['%'+ASearchCondRec.FSubject+'%']);
//    if AWhere <> '' then
//      AWhere := AWhere + ' and ';
//    AWhere := AWhere + ' WorkSummary LIKE ? ';
//  end;
//
//  if ASearchCondRec.FProdType <> '' then
//  begin
//    AddConstArray(FConstArray, [ASearchCondRec.FProdType]);
//    if AWhere <> '' then
//      AWhere := AWhere + ' and ';
//    AWhere := AWhere + ' ProductType = ? ';
//  end;
//
//  if ASearchCondRec.FCurWork > 0 then
//  begin
//    if ASearchCondRec.FWorkKind = 0 then //현재작업
//    begin
//      AddConstArray(FConstArray, [ASearchCondRec.FCurWork]);
//    end
//    else if ASearchCondRec.FWorkKind = 1 then
//    begin
//      AddConstArray(FConstArray, [ASearchCondRec.FCurWork-1]);
//    end;
//
//    if AWhere <> '' then
//      AWhere := AWhere + ' and ';
//    AWhere := AWhere + ' CurrentWorkStatus ';
//
//    if (ASearchCondRec.FBefAft = -1) or (ASearchCondRec.FBefAft = 0) then
//      AWhere := AWhere + '= ?'
//    else
//    if ASearchCondRec.FBefAft = 1 then//이전
//      AWhere := AWhere + '< ?'
//    else
//    if ASearchCondRec.FBefAft = 2 then//이후
//      AWhere := AWhere + '> ?';
//  end;
//
//  if ASearchCondRec.FQtnNo <> '' then
//  begin
//    AddConstArray(FConstArray, ['%'+ASearchCondRec.FQtnNo+'%']);
//    if AWhere <> '' then
//      AWhere := AWhere + ' and ';
//    AWhere := AWhere + ' QTN_No LIKE ? ';
//  end;
//
//  if ASearchCondRec.FOrderNo <> '' then
//  begin
//    AddConstArray(FConstArray, ['%'+ASearchCondRec.FOrderNo+'%']);
//    if AWhere <> '' then
//      AWhere := AWhere + ' and ';
//    AWhere := AWhere + ' Order_No LIKE ? ';
//  end;
//
//  if ASearchCondRec.FPoNo <> '' then
//  begin
//    AddConstArray(FConstArray, ['%'+ASearchCondRec.FPoNo+'%']);
//    if AWhere <> '' then
//      AWhere := AWhere + ' and ';
//    AWhere := AWhere + ' PO_No LIKE ? ';
//  end;
//
//  ASearchCondRec.FCurWork := Ord(spFinal);
//  //완료되지 않은 모든 Task를 보여줌
//  AddConstArray(FConstArray, [ASearchCondRec.FCurWork]);
//
//  if AWhere <> '' then
//    AWhere := AWhere + ' and ';
//
//  if not DisplayFinalCheck.Checked then
//  begin
//    AWhere := AWhere + 'CurrentWorkStatus <> ?';
//  end
//  else
//  begin
//    AWhere := AWhere + 'CurrentWorkStatus <= ?';
//  end;
//end;

function THiconisAsManageF1.Get_Doc_Cust_Reg_Rec(ARow: integer): Doc_Cust_Reg_Rec;
var
  LTask: TOrmHiconisASTask;
  LIdList: TIDList;
  LCustomer: TSQLCustomer;
begin
  if grid_Req.Row[ARow].Data <> nil then
  begin
    LIdList := TIDList(grid_Req.Row[ARow].Data);

    LTask:= CreateOrGetLoadTask(LIdList.fTaskId);
    try
      LCustomer := GetCustomerFromTask(LTask);

      Result.FCompanyName := LCustomer.CompanyName;
      Result.FCountry := LTask.NationPort;
      Result.FCompanyAddress := LCustomer.CompanyAddress;
      Result.FTelNo := LCustomer.OfficePhone;
      Result.FFaxNo := LCustomer.MobilePhone;
      Result.FEMailAddress := LCustomer.EMail;
    finally
      if Assigned(LTask) then
        FreeAndNil(LTask);
      if Assigned(LCustomer) then
        FreeAndNil(LCustomer);
    end;
  end;
end;

function THiconisAsManageF1.Get_Doc_Inv_Rec(ARow: integer): Doc_Invoice_Rec;
var
  LTask: TOrmHiconisASTask;
  LIdList: TIDList;
  LCustomer: TSQLCustomer;
begin
  if grid_Req.Row[ARow].Data <> nil then
  begin
    LIdList := TIDList(grid_Req.Row[ARow].Data);

    LTask:= CreateOrGetLoadTask(LIdList.fTaskId);
    try
      LCustomer := GetCustomerFromTask(LTask);
      Result.FCustomerInfo := LCustomer.CompanyAddress;

      Result.FCustomerInfo := Result.FCustomerInfo.Replace(#13, '');
      Result.FInvNo := LTask.Order_No;
      Result.FHullNo := LTask.HullNo;
      Result.FShipName := LTask.ShipName;
      Result.FSubject := LTask.WorkSummary;
      Result.FPONo := LTask.PO_No;
    finally
      if Assigned(LTask) then
        FreeAndNil(LTask);
      if Assigned(LCustomer) then
        FreeAndNil(LCustomer);
    end;
  end;
end;

function THiconisAsManageF1.Get_Doc_Qtn_Rec(ARow: integer): Doc_Qtn_Rec;
var
  LQTN: string;
  LTask: TOrmHiconisASTask;
  LIdList: TIDList;
  LCustomer: TSQLCustomer;
begin
  if grid_Req.Row[ARow].Data <> nil then
  begin
    LIdList := TIDList(grid_Req.Row[ARow].Data);

    LTask:= CreateOrGetLoadTask(LIdList.fTaskId);
    try
      LCustomer := GetCustomerFromTask(LTask);
      Result.FCustomerInfo := LCustomer.CompanyAddress;

      Result.FCustomerInfo := Result.FCustomerInfo.Replace(#13, '');

      LQTN := LTask.QTN_No;
      if LQTN = '' then
        LQTN := LTask.HullNo + '-' + IntToStr(Random(9));

      Result.FQtnNo := LQTN;
      Result.FQtnDate := FormatDateTime('dd.mmm.yyyy', now);
      Result.FHullNo := LTask.HullNo;
      Result.FShipName := LTask.ShipName;
      Result.FSubject := LTask.WorkSummary;
      Result.FPONo := LTask.PO_No;
      Result.FValidateDate := FormatDateTime('mmm.dd.yyyy', now+30);
    finally
      if Assigned(LTask) then
        FreeAndNil(LTask);
      if Assigned(LCustomer) then
        FreeAndNil(LCustomer);
    end;
  end;
end;

function THiconisAsManageF1.Get_Doc_ServiceOrder_Rec(ARow: integer): Doc_ServiceOrder_Rec;
var
  LPeriod:string;
  LTask: TOrmHiconisASTask;
  LIdList: TIDList;
  LSQLSubCon: TSQLSubCon;
  LSQLCustomer: TSQLCustomer;
begin
  if grid_Req.Row[ARow].Data <> nil then
  begin
    LIdList := TIDList(grid_Req.Row[ARow].Data);

    LTask:= CreateOrGetLoadTask(LIdList.fTaskId);
    try
      LSQLSubCon := GetSubConFromTask(LTask);
      Result.FSubConName := LSQLSubCon.CompanyName;
      Result.FSubConManager := LSQLSubCon.ManagerName;
      Result.FSubConPhonNo := LSQLSubCon.MobilePhone;
      Result.FSubConEmail := LSQLSubCon.EMail;

      LSQLCustomer:= GetCustomerFromTask(LTask);
      Result.FLocalAgent := LSQLCustomer.AgentInfo;
      Result.FCustomer := LSQLCustomer.CompanyName;

      Result.FHullNo := LTask.HullNo;
      Result.FShipName := LTask.ShipName;
      Result.FSubject := LTask.WorkSummary;
      Result.FPONo2SubCon := LTask.PO_No;
      Result.FOrderDate := FormatDateTime('dd.mmm.yyyy', now);
      Result.FWorkSch := '1.Place : ' + LTask.NationPort;
      LPeriod := FormatDateTime('yyyy.mm.dd',LTask.WorkBeginDate);
      LPeriod := LPeriod + ' ~ ' + FormatDateTime('yyyy.mm.dd',LTask.WorkEndDate);
      Result.FWorkPeriod := LPeriod;
      Result.FWorkSch := Result.FWorkSch + #13#10 + '2.Period : ' + LTask.NationPort;
      Result.FEngineerNo := IntToStr(LTask.SECount);
      Result.FLocalAgent := Result.FLocalAgent.Replace(#13,'');

      Result.FProjCode := LTask.Order_No;
      Result.FNationPort := LTask.NationPort;
      Result.FWorkSummary := LTask.WorkSummary;
      Result.FSubConPrice := '';//LTask.SubConPrice;
    finally
      if Assigned(LTask) then
        FreeAndNil(LTask);

      if Assigned(LSQLSubCon) then
        FreeAndNil(LSQLSubCon);

      if Assigned(LSQLCustomer) then
        FreeAndNil(LSQLCustomer);
    end;
  end;
end;

function THiconisAsManageF1.Get_Doc_SubCon_Invoice_List_Rec: Doc_SubCon_Invoice_List_Rec;
begin
//  Result.FProjectCode := OrderNoEdit.Text;
//  Result.FHullNo := HullNoEdit.Text;
////  Result.FClaimNo := OrderNoEdit.Text;
//  Result.FPONo := PONoEdit.Text;
//  Result.FPOIssueDate := FormatDateTime('YYYY.MM.DD',QTNInputPicker.Date);
//  Result.FSubConName := SubCompanyEdit.Text;
//  Result.FWorkFinishDate := FormatDateTime('YYYY.MM.DD',WorkEndPicker.Date);
//  Result.FInvoiceIssueDate := FormatDateTime('YYYY.MM.DD',InvoiceIssuePicker.Date);
end;

procedure THiconisAsManageF1.grid_ReqCellDblClick(Sender: TObject; ACol,
  ARow: Integer);
var
  LTask: TOrmHiconisASTask;
begin
  if ARow = -1 then
    Exit;

  ShowTaskFormFromDB(ARow);
end;

procedure THiconisAsManageF1.grid_ReqKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and ((Key = Ord('V')) or (Key = Ord('v'))  ) then
    ProcessPasteEvent(ClipBoard.AsText);
//    ShowMessage(ClipBoard.AsText);
end;

procedure THiconisAsManageF1.HullNoEditKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteSearch(Key);
end;

procedure THiconisAsManageF1.InitNetwork;
begin
  CreateHttpServer4WS(FPortName, FTransmissionKey, TServiceIM4WS, [IHiconisASService]);
  FIsRunRestServer := True;
  StatusBarPro1.Panels[2].Text := 'Port = ' + FPortName;
end;

procedure THiconisAsManageF1.InitTaskEnum;
begin
  g_QueryDateType.InitArrayRecord(R_QueryDateType);
  g_ElecProductType.InitArrayRecord(R_ElecProductType);
end;

procedure THiconisAsManageF1.InitTaskTab;
var
  i: integer;
  LStr: string;
  LStatus: TSalesProcess;
begin
  for i := 0 to TaskTab.AdvOfficeTabs.Count - 1 do
  begin
    LStr := TaskTab.AdvOfficeTabs[i].Name;
    LStatus := TRttiEnumerationType.GetValue<TSalesProcess>(LStr);
    TaskTab.AdvOfficeTabs[i].Tag := Ord(LStatus);
  end;
end;

procedure THiconisAsManageF1.InputValueClear;
begin
  HullNoEdit.Text := '';
  ShipNameEdit.Text := '';
  CustomerCombo.Text := '';
  PONoEdit.Text := '';
  ClaimNoEdit.Text := '';
  SubjectEdit.Text := '';
  OrderNoEdit.Text := '';
  ComboBox1.ItemIndex := -1;
  ProductTypeCombo.ItemIndex := -1;
  CurWorkCB.ItemIndex := -1;
  BefAftCB.ItemIndex := -1;
  PICCB.ItemIndex := -1;
end;

procedure THiconisAsManageF1.Invoice4Click(Sender: TObject);
begin
  MakeInvoice(grid_Req.SelectedRow);
end;

procedure THiconisAsManageF1.KeyIn_CompanyCode;
var
  LCode: string;
  LTask: TOrmHiconisASTask;
begin
  LTask := GetTask;
  try
    LCode := GetCompanyCode(LTask);
    Key_Input_CompanyCode(LCode);
  finally
    LTask.Free;
  end;
end;

procedure THiconisAsManageF1.KeyIn_Content;
var
  LContent: string;
  LTask: TOrmHiconisASTask;
begin
  LTask := GetTask;
  try
    LContent := GetQTNContent(LTask);
    QTN_Key_Input_Content(LContent);
  finally
    LTask.Free;
  end;
end;

procedure THiconisAsManageF1.KeyIn_RFQ;
var
  LPONo: string;
  LTask: TOrmHiconisASTask;
begin
  LTask := GetTask;
  try
    LPONo := UTF8ToString(LTask.PO_No);
    Key_Input_RFQ(LPONo);
  finally
    LTask.Free;
  end;
end;

procedure THiconisAsManageF1.GetHullNoToClipboard1Click(Sender: TObject);
begin
  if grid_Req.SelectedRow = -1 then
    exit;

  Clipboard.AsText := grid_Req.CellsByName['ShipName',grid_Req.SelectedRow] + ' (' +
    grid_Req.CellsByName['HullNo',grid_Req.SelectedRow] + ') - ' + grid_Req.CellsByName['OrderNo',grid_Req.SelectedRow];
end;

function THiconisAsManageF1.GetIsRemote(var ARemoteAddr: string): Boolean;
begin
  Result := False;

  if ARemoteAddr = '' then
    ARemoteAddr := PICCB.Items.ValueFromIndex[PICCB.ItemIndex];

  if ARemoteAddr <> '' then
    Result := FMyIPAddress <> ARemoteAddr;

  if Result then
    StatusBarPro1.Panels[0].Text := 'Remote'
  else
    StatusBarPro1.Panels[0].Text := 'Local'
end;

procedure THiconisAsManageF1.DisplayOLMsg2Grid(const task: IOmniTaskControl;
  const msg: TOmniMessage);
begin

end;

procedure THiconisAsManageF1.DisplayTaskInfo2EditForm(const ATaskID: integer);
var
  LTask: TOrmHiconisASTask;
  LTaskEditConfig: THiconisASTaskEditConfig;
begin
  LTask:= CreateOrGetLoadTask(ATaskID);
  try
  {$IFDEF GAMANAGER}
    FrmHiconisASTaskEdit.DisplayTaskInfo2EditForm(LTask,nil,null, LTaskEditConfig);
  {$ELSE}
    TaskForm.DisplayTaskInfo2EditForm(LTask,nil,null);
  {$ENDIF}
  finally
    FreeAndNil(LTask);
  end;
end;

procedure THiconisAsManageF1.AddFolderListFromOL(AFolder: string);
begin
  if FFolderListFromOL.IndexOf(AFolder) = -1  then
  begin
    FFolderListFromOL.Add(AFolder);
    SetCurrentDir(ExtractFilePath(Application.ExeName));

    if FileExists('.\'+FOLDER_LIST_FILE_NAME) then
      DeleteFile('.\'+FOLDER_LIST_FILE_NAME);

    FFolderListFromOL.SaveToFile('.\'+FOLDER_LIST_FILE_NAME);
  end
  else
    ShowMessage('동일한 Folder 이름이 존재함 : ' + AFolder);
end;

procedure THiconisAsManageF1.AeroButton1Click(Sender: TObject);
var
  LRow: integer;
begin
  if grid_Req.SelectedCount > 0 then
  begin
    if MessageDlg('선택한 Task의ToDo List 만  조회 할까요?.' + #13#10 +
      '"No" 를 선택하면 Grid에 표시된 모든 Task에 대한 ToDo List를 조회 합니다.' , mtConfirmation, [mbYes, mbNo],0) = mrNo then
      LRow := -1
    else
      LRow := grid_Req.SelectedRow;
  end
  else
    LRow := -1;

//  ShowTodoListFormFromData(LRow);
  ShowTodoListFormFromDBByGridRow(LRow);
end;

procedure THiconisAsManageF1.ApplyConfigChanged;
begin
  LoadConfigFromFile;
end;

procedure THiconisAsManageF1.AsynDisplayOLMsg2Grid;
var
  LEmailMsg,
  LEmailMsg2: TSQLEmailMsg;
  LTask,
  LTask2: TOrmHiconisASTask;
begin
  Parallel.Async(
    procedure (const task: IOmniTask)
    var
      i, LResult: integer;
      handles: array [0..1] of THandle;
      msg    : TOmniMessage;
      rec    : TOLMsgFileRecord;
      LID: TID;
      LTaskIds: TIDDynArray;
      LIsAddTask,  //True=신규 Task 등록
      LIsProcessJson: Boolean; //Task정보를 Json파일로 받음
      LStr: string;
    begin
      try
//        g_MyEmailInfo := SendReqOLEmailAccountInfo_WS;
      except
      end;

      handles[0] := FStopEvent.Handle;
      handles[1] := FIPCMQFromOL.GetNewMessageEvent;
      LEmailMsg := TSQLEmailMsg.Create;

      while WaitForMultipleObjects(2, @handles, false, INFINITE) = (WAIT_OBJECT_0 + 1) do
      begin
        while FIPCMQFromOL.TryDequeue(msg) do
        begin
          LTask := TOrmHiconisASTask.Create;
          try
            rec := msg.MsgData.ToRecord<TOLMsgFileRecord>;

            if msg.MsgID = Ord(dkmqMailFromOL) then
            begin
              LIsProcessJson := False;

              if (rec.FEntryID <> '') and (rec.FStoreID <> '') then
              begin
                LEmailMsg := TSQLEmailMsg.CreateAndFillPrepare(g_ProjectDB.Orm,
                  'EntryID = ? AND StoreID = ?', [rec.FEntryID,rec.FStoreID]);

                //데이터가 없으면
  //              if LEmailMsg.ID = 0 then
                if not LEmailMsg.FillOne then
                begin
                  LEmailMsg.Sender := rec.FSender;
                  LEmailMsg.Receiver := rec.FReceiver;
                  LEmailMsg.CarbonCopy := rec.FCarbonCopy;
                  LEmailMsg.BlindCC := rec.FBlindCC;
                  LEmailMsg.EntryID := rec.FEntryId;
                  LEmailMsg.StoreID := rec.FStoreId;
                  LEmailMsg.Subject := rec.FSubject;
                  LEmailMsg.SavedOLFolderPath := rec.FSavedOLFolderPath;
                  LEmailMsg.RecvDate := TimeLogFromDateTime(rec.FReceiveDate);

                  LEmailMsg2 := TSQLEmailMsg.Create(g_ProjectDB.Orm,
                    'Subject = ?', [rec.FSubject]);

                  if LEmailMsg2.FillOne then //동일한 제목의 메일이 존재하면
                  begin
                    LIsAddTask := False;
//                    LTask.EmailMsg.SourceGet(g_ProjectDB.Orm, LEmailMsg2.ID, LTaskIds);

                    try
                      for i:= low(LTaskIds) to high(LTaskIds) do
                      begin
                        LTask2 := CreateOrGetLoadTask(LTaskIds[i]);
                        break;
                      end;
                    finally
                      if LTask2.ID <> 0 then
                      begin
//                        LTask2.EmailMsg.ManyAdd(g_ProjectDB.Orm, LTask2.ID, LEMailMsg.ID, True);
                        FreeAndNil(LTask2);
                      end;
                    end;

                    LEmailMsg.ParentID := LEmailMsg2.EntryID+';'+LEmailMsg2.StoreID;
                    LID := g_ProjectDB.Add(LEmailMsg, true);
                  end
                  else
                  begin //제목이 존재하지 않으면 Task도 새로 등록 해야 함
  //                  LIsAddTask := True;
                    LTask.InqRecvDate := TimeLogFromDateTime(rec.FReceiveDate);
                    LTask.ChargeInPersonId := rec.FUserEmail;
                    LResult := FrmHiconisASTaskEdit.DisplayTaskInfo2EditForm(LTask,LEmailMsg,null, FTaskEditConfig);
    //                g_ProjectDB.Add(LTask, true);
    //                LTask.EmailMsg.ManyAdd(g_ProjectDB.Orm, LTask.ID, LEmailMsg.ID, true);
                  end;
                end;
              end;
            end
            else
            if msg.MsgID = Ord(dkmqFolderFromOL) then
            begin
              //task.Invoke함수에서 Grid에 Task 추가하는 것을 방지함
              LIsAddTask := False;
              LIsProcessJson := False;
              TDTF.AddFolderListFromOL(rec.FEntryId + '=' + rec.FStoreId);
            end
            else
            if msg.MsgID = Ord(dkmqFileFromDrag) then
            begin
              LStr := rec.FSubject;
              LIsProcessJson := True;
              LIsAddTask := False;
            end;

            task.Invoke(//Thread Synchronize와 동일함
              procedure
              begin
                //동일한 제목의 메일이 존재하지 않으면 Grid에 추가
                if LIsAddTask then
                begin
                  if Assigned(LTask) then
                  begin
                    TDTF.LoadTaskVar2Grid(LTask, TDTF.grid_Req);
                    FreeAndNil(LTask);
                  end;
                end;

                if LIsProcessJson then
                begin
                  ProcessTaskJson(LStr);
                end;
              end
            );
          finally
            if (not LIsAddTask) and Assigned(LTask) then
              FreeAndNil(LTask);
          end;
        end;//while
      end;//while
    end,

    Parallel.TaskConfig.OnMessage(Self).OnTerminated(
      procedure
      begin
        FreeAndNil(LEmailMsg);
      end
    )
  );
end;

procedure THiconisAsManageF1.ShowToDoListFromCollect(AToDoCollect: TpjhToDoItemCollection);
begin
  Create_ToDoList_Frm('', AToDoCollect, True,
    nil, nil);//InsertOrUpdateToDoList2DB, DeleteToDoListFromDB);
end;

procedure THiconisAsManageF1.StartOLControlWorker;
begin
  FCommandQueue := TOmniMessageQueue.Create(1000);
  FResponseQueue := TOmniMessageQueue.Create(1000, false);
  FSendMsgQueue := TOmniMessageQueue.Create(1000);

  FOLControlWorker := TOLControlWorker.Create(FCommandQueue, FResponseQueue, FSendMsgQueue, Handle);
end;

procedure THiconisAsManageF1.StopOLControlWorker;
begin
  if Assigned(FOLControlWorker) then
  begin
    TWorker(FOLControlWorker).Stop;
    FOLControlWorker.WaitFor;
    FreeAndNil(FOLControlWorker);
  end;

  FCommandQueue.Free;
  FResponseQueue.Free;
  FSendMsgQueue.Free;
end;

procedure THiconisAsManageF1.ShowToDoListFormFromList(ATaskId: TID; AToDoList: TpjhToDoList);
begin
  Create_ToDoList_Frm2(ATaskId, AToDoList, True);
end;

procedure THiconisAsManageF1.TaskTabChange(Sender: TObject);
var
  i : Integer;
  LTaskStatus, LStr: String;
begin
  with grid_Req do
  begin
    BeginUpdate;
    try
      LTaskStatus := g_SalesProcess.ToString(TaskTab.AdvOfficeTabs[TaskTab.ActiveTabIndex].Tag);
      if TaskTab.AdvOfficeTabs[TaskTab.ActiveTabIndex].Caption.Contains('대기') then
      begin
        LStr := 'NextProcess';
      end
      else if TaskTab.AdvOfficeTabs[TaskTab.ActiveTabIndex].Caption.Contains('완료') then
      begin
        LStr := 'Status';
      end;

      for i := 0 to RowCount-1 do
      begin
        if TaskTab.ActiveTabIndex = 0 then
          RowVisible[i] := True
        else
        begin
          if CellByName[LStr,i].AsString = LTaskStatus then
            RowVisible[i] := True
          else
            RowVisible[i] := False;
        end;
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure THiconisAsManageF1.TestRemoteTaskDetail;
begin

end;

procedure THiconisAsManageF1.TestRemoteTaskList;
begin

end;

procedure THiconisAsManageF1.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;

//  if TDTF.FSettings.WSEnabled then
//    InitNetwork;

  FUserList.Add(GetMyName(g_MyEmailInfo.SmtpAddress)+'='+g_MyEmailInfo.SmtpAddress);
  FillInUserList;
  PICCB.Items.Assign(FUserList);
  PICCB.ItemIndex := -1;
end;

procedure THiconisAsManageF1.btn_SearchClick(Sender: TObject);
var
  LSearchCondRec: TSearchCondRec;
  LIsRemote: Boolean;
  LUtf8, LResult: RawUTF8;
begin
  GetSearchCondRec(LSearchCondRec);
  LIsRemote := GetIsRemote(LSearchCondRec.FRemoteIPAddress);

  if LIsRemote then
  begin
    LUtf8 := RecordSaveJson(LSearchCondRec, TypeInfo(TSearchCondRec));
    LResult := SendReq2InqManagerServer_Http(LSearchCondRec.FRemoteIPAddress, FPortName, FRootName, CMD_REQ_TASK_LIST, LUtf8);
    LResult := MakeBase64ToUTF8(LResult);
    DisplayTaskInfo2GridFromJson(LResult);
  end
  else
    DisplayTaskInfo2Grid(LSearchCondRec, LIsRemote);
end;

procedure THiconisAsManageF1.Button1Click(Sender: TObject);
begin
  InputValueClear;
end;

function THiconisAsManageF1.CheckRegistration: Boolean;
begin

end;

procedure THiconisAsManageF1.ComboBox1DropDown(Sender: TObject);
begin
  ComboBox1.Clear;
  g_QueryDateType.SetType2Combo(ComboBox1);
end;

constructor THiconisAsManageF1.Create(AOwner: TComponent);
var
  i: integer;
  LStr: string;
begin
  inherited;

  SetCurrentDir(ExtractFilePath(Application.ExeName));
  DOC_DIR := ExtractFilePath(Application.ExeName) + '양식\';
  FFolderListFromOL := TStringList.Create;
  if FileExists('.\'+FOLDER_LIST_FILE_NAME) then
    FFolderListFromOL.LoadFromFile('.\'+FOLDER_LIST_FILE_NAME);
  FTempJsonList := TStringList.Create;
  FUserList := TStringList.Create;
  FToDoCollect := TpjhToDoItemCollection.Create(TpjhTodoItem);
  InitTaskTab;
  InitTaskEnum;
  ComboBox1DropDown(nil);
//  ComboBox1.ItemIndex := 1;
  if FIniFileName = '' then
    FIniFileName := ChangeFileExt(Application.ExeName, '.ini');

  FSettings := TConfigSettings.create(FIniFileName);
  GetLocalIP(-1, FUserList);
  for i := 0 to FUserList.Count - 1 do
  begin
    LStr := FUserList.Strings[i];
    LStr := strToken(LStr, '.');

    if LStr = '10' then
    begin
      FMyIPAddress := FUserList.Strings[i];
      FUserList.Clear;
      Break;
    end;

  end;

  StatusBarPro1.Panels[1].Text := 'IP = ' + FMyIPAddress;
end;

procedure THiconisAsManageF1.CreateHttpServer4WS(APort,
  ATransmissionKey: string; aClient: TInterfacedClass;
  const aInterfaces: array of TGUID);
begin
  if not Assigned(FRestServer) then
  begin
    // initialize a TObjectList-based database engine
    FRestServer := TRestServerFullMemory.CreateWithOwnModel([]);
    // register our Interface service on the server side
    FRestServer.CreateMissingTables;
    FServiceFactoryServer := FRestServer.ServiceDefine(aClient, aInterfaces , sicShared) as TServiceFactoryServer;  //sicClientDriven
    FServiceFactoryServer.SetOptions([], [optExecLockedPerInterface]). // thread-safe fConnected[]
      ByPassAuthentication := true;
  end;

  if not Assigned(FHTTPServer) then
  begin
    // launch the HTTP server
//    FPortName := APort;
    FHTTPServer := TRestHttpServer.Create(APort, [FRestServer], '+' , useBidirSocket);
    FHTTPServer.WebSocketsEnable(FRestServer, ATransmissionKey);
    FIsServerActive := True;
  end;
end;

procedure THiconisAsManageF1.CreateNewTask(AJson: RawUtf8);
var
  LTask: TOrmHiconisASTask;
  LResult: integer;
begin
  LTask := TOrmHiconisASTask.Create;
  try
    if AJson = '' then
      LResult := FrmHiconisASTaskEdit.DisplayTaskInfo2EditForm(LTask, nil, null, FTaskEditConfig)
    else
      LResult := FrmHiconisASTaskEdit.ShowEditFormFromClaimReportVar(LTask, AJson);

  if LResult = mrOK then
    if not LTask.IsUpdate then
      LoadTaskVar2Grid(LTask, grid_Req);
  finally
    LTask.Free;
  end;
end;

procedure THiconisAsManageF1.DeleteTask1Click(Sender: TObject);
var
  LIdList: TIDList;
begin
  if grid_Req.SelectedRow = -1 then
    exit;

  if MessageDlg('선택한 Task를 삭제 할까요?.' + #13#10 +
    'Task에 연결 저장된 파일/자재/협력사/고객사 정보등이 함께 삭제 됩니다.' + #13#10 +
    '삭제 후에는 복원이 안 됩니다..' , mtConfirmation, [mbYes, mbNo],0) = mrNo then
    exit;

  if grid_Req.Row[grid_Req.SelectedRow].Data <> nil then
  begin
    LIdList := TIDList(grid_Req.Row[grid_Req.SelectedRow].Data);
    DeleteTask(LIdList.TaskId);

    ShowMessage('Task 삭제가 완료 되었습니다.');

    btn_SearchClick(nil);
  end;
end;

destructor THiconisAsManageF1.Destroy;
var
  i: integer;
begin
  for i := 0 to grid_Req.RowCount - 1 do
    TIDList(grid_Req.Row[i].Data).Free;

  FSettings.Free;
  FreeAndNil(FToDoCollect);
  FFolderListFromOL.Free;
  FTempJsonList.Free;
  FUserList.Free;

  inherited;
end;

procedure THiconisAsManageF1.DestroyHttpServer;
begin
  if Assigned(FHTTPServer) then
    FHTTPServer.Free;

  if Assigned(FRestServer) then
  begin
    FRestServer.Free;
  end;

  if Assigned(FModel) then
    FreeAndNil(FModel);
end;

procedure THiconisAsManageF1.DisplayTaskInfo2Grid(ASearchCondRec: TSearchCondRec; AFromRemote: Boolean);
var
  ConstArray: TConstArray;
  LWhere, LStr: string;
  LSQLGSTask: TOrmHiconisASTask;
  LSQLCustomer: TSQLCustomer;
  LUtf8: RawUTF8;
  LV: variant;
  LFrom, LTo: TTimeLog;
begin
  LWhere := '';
  ConstArray := CreateConstArray([]);
  try
//    GetWhereConstArr(ASearchCondRec, LWhere);//, ConstArray);
    if ASearchCondRec.FQueryDate <> qdtNull then
    begin
      if ASearchCondRec.FFrom <= ASearchCondRec.FTo then
      begin
        LFrom := TimeLogFromDateTime(ASearchCondRec.FFrom);
        LTo := TimeLogFromDateTime(ASearchCondRec.FTo);

        if ASearchCondRec.FQueryDate <> qdtNull then
        begin
          AddConstArray(ConstArray, [LFrom, LTo]);
          LWhere := GetSqlWhereFromQueryDate(ASearchCondRec.FQueryDate);
        end;
      end;
    end;

    if ASearchCondRec.FHullNo <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ASearchCondRec.FHullNo+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'HullNo LIKE ? ';
    end;

    if ASearchCondRec.FShipName <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ASearchCondRec.FShipName+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + ' ShipName LIKE ? ';
    end;

    if ASearchCondRec.FCustomer <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ASearchCondRec.FCustomer+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + ' ShipOwner LIKE ? ';
    end;

    if ASearchCondRec.FSubject <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ASearchCondRec.FSubject+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + ' WorkSummary LIKE ? ';
    end;

    if ASearchCondRec.FProdType <> '' then
    begin
      AddConstArray(ConstArray, [ASearchCondRec.FProdType]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + ' ProductType = ? ';
    end;

    if ASearchCondRec.FClaimNo <> '' then
    begin
      AddConstArray(ConstArray, [ASearchCondRec.FClaimNo]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + ' ClaimNo = ? ';
    end;

    if ASearchCondRec.FCurWork > 0 then
    begin
      if ASearchCondRec.FWorkKind = 0 then //현재작업
      begin
        AddConstArray(ConstArray, [ASearchCondRec.FCurWork]);
      end
      else if ASearchCondRec.FWorkKind = 1 then
      begin
        AddConstArray(ConstArray, [ASearchCondRec.FCurWork-1]);
      end;

      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + ' CurrentWorkStatus ';

      if (ASearchCondRec.FBefAft = -1) or (ASearchCondRec.FBefAft = 0) then
        LWhere := LWhere + '= ?'
      else
      if ASearchCondRec.FBefAft = 1 then//이전
        LWhere := LWhere + '< ?'
      else
      if ASearchCondRec.FBefAft = 2 then//이후
        LWhere := LWhere + '> ?';
    end;

    if ASearchCondRec.FQtnNo <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ASearchCondRec.FQtnNo+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + ' QTN_No LIKE ? ';
    end;

    if ASearchCondRec.FOrderNo <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ASearchCondRec.FOrderNo+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + ' Order_No LIKE ? ';
    end;

    if ASearchCondRec.FPoNo <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ASearchCondRec.FPoNo+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + ' PO_No LIKE ? ';
    end;

    ASearchCondRec.FCurWork := Ord(spFinal);
    //완료되지 않은 모든 Task를 보여줌
    AddConstArray(ConstArray, [ASearchCondRec.FCurWork]);

    if LWhere <> '' then
      LWhere := LWhere + ' and ';

    if not DisplayFinalCheck.Checked then
    begin
      LWhere := LWhere + 'CurrentWorkStatus <> ?';
    end
    else
    begin
      LWhere := LWhere + 'CurrentWorkStatus <= ?';
    end;

    LSQLGSTask := TOrmHiconisASTask.CreateAndFillPrepare(g_ProjectDB.Orm, LWhere, ConstArray);

    try
      if AFromRemote then
      begin
        StatusBarPro1.Panels[0].Text := 'Remote';
        FTempJsonList.Clear;
        LUtf8 := MakeTaskList2JSONArray(LSQLGSTask);
        FTempJsonList.Text := UTF8ToString(LUtf8);
//        LStr := FTempJsonList.Text;
//        System.Delete(LStr, Length(LStr)-1,2);
//        LUtf8 := StringToUTF8(LStr);
//        LUtf8 := MakeBase64ToUTF8(LUtf8);
      end
      else
      begin
        StatusBarPro1.Panels[0].Text := 'Local';
        grid_Req.ClearRows;

        while LSQLGSTask.FillOne do
        begin
          grid_Req.BeginUpdate;
          try
            LoadTaskVar2Grid(LSQLGSTask, grid_Req);
          finally
            grid_Req.EndUpdate;
          end;
        end;
      end;
    finally
      LSQLGSTask.Free;
    end;
  finally
    FinalizeConstArray(ConstArray);
  end;
end;

procedure THiconisAsManageF1.DisplayTaskInfo2GridFromJson(AJson: RawUTF8);
var
  LDocData: TDocVariantData;
  LVar: variant;
  i: integer;
  LSQLGSTask: TOrmHiconisASTask;
begin//AJson : [] Task 배열 형식임
  LSQLGSTask := TOrmHiconisASTask.Create;
  try
    grid_Req.ClearRows;
    LDocData.InitJSON(AJson);

    for i := 0 to LDocData.Count - 1 do
    begin
      LVar := _JSON(LDocData.Value[i]);
      LoadTaskFromVariant(LSQLGSTask, LVar);
      LSQLGSTask.NumOfEMails := LVar.NumOfEMails;
      LSQLGSTask.EmailSubject := LVar.EmailSubject;
      LoadGSTask2Grid(LSQLGSTask, grid_Req);
    end;
  finally
    LSQLGSTask.Free;
  end;
end;

procedure THiconisAsManageF1.DropEmptyTarget1Drop(Sender: TObject;
  ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
var
  LTargetStream: TStream;
  LRawByte: RawByteString;
  LFromOutlook: Boolean;
  LFileName, LFileExt: string;
  LJson: RawUtf8;
  LDocType: integer;
begin
  LFileName := '';
  LFromOutlook := False;
  if (DataFormatAdapter1.DataFormat <> nil) then
  begin
    LFileName := (DataFormatAdapter1.DataFormat as TFileDataFormat).Files.Text;

    // OutLook에서 Drag한 경우에는 LFileName = '' 임
    if LFileName = '' then
    begin
      // OutLook에서 첨부파일을 Drag 했을 경우
      if (TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat).FileNames.Count > 0) then
      begin
        LFileName := TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat).FileNames[0];
        LFileExt := ExtractFileExt(LFileName);

        if UpperCase(LFileExt) = '.XLSX' then
        begin
          LTargetStream := GetStreamFromDropDataFormat(TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat));
          try
            if not Assigned(LTargetStream) then
              ShowMessage('Not Assigned');

            LRawByte := StreamToRawByteString(LTargetStream);
            LFromOutlook := True;
          finally
            if Assigned(LTargetStream) then
              LTargetStream.Free;
          end;
        end;
      end;
    end
    else// 윈도우 탐색기에서 Drag 했을 경우 LFileName에 Drag한 File Name이 존재함
    begin
      LFileExt := ExtractFileExt(LFileName);

      if LFileExt = '.xlsx' then
      begin
        LRawByte := StringFromFile(LFileName);
      end;
    end;
  end;

  if LFileName <> '' then
  begin
    LDocType := ShowFileSelectForm();

    if g_GSDocType.ToType(LDocType) = dtClaimReport then
    begin
      if LFromOutlook then
      begin
        LJson := GetClaimInfoJsonFromXlsString(LRawByte);
      end
      else
        LJson := GetClaimInfoJsonFromReport_Xls(LFileName);

      CreateNewTask(LJson);
    end;
  end;
end;

procedure THiconisAsManageF1.EmailButtonClick(Sender: TObject);
begin
  ShowEmailListFormFromData(grid_Req.SelectedRow);
end;

procedure THiconisAsManageF1.ExecFunc(AFuncName: string);
begin
  if AFuncName <> '' then
    ExecMethod(AFuncName,[]);
end;

procedure THiconisAsManageF1.ExecMethod(MethodName: string;
  const Args: array of TValue);
var
  R : TRttiContext;
  T : TRttiType;
  M : TRttiMethod;
begin
  T := R.GetType(Self.ClassType);

  for M in t.GetMethods do
  begin
    if (m.Parent = t) and (m.Name = MethodName)then
    begin
      M.Invoke(Self,Args);
      break;
    end;
  end;
end;

procedure THiconisAsManageF1.ExecuteSearch(Key: Char);
begin
  if Key = Chr(VK_RETURN) then
    btn_SearchClick(nil);
end;

procedure THiconisAsManageF1.FillInUserList;
var
  LStrList: TStrings;
begin
  if FSettings.RemoteAuthEnabled then
  begin
    LStrList := GetUserListFromFile(ChangeFileExt(Application.ExeName, '.ips'));

    if Assigned(LStrList) then
    begin
      try
        FUserList.Assign(LStrList);
      finally
        LStrList.Free;
      end;
    end;
  end
  else
    FUserList.Add(GetMyName(g_MyEmailInfo.SmtpAddress));
end;

procedure THiconisAsManageF1.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(FStopEvent) then
  begin
    FStopEvent.SetEvent;
    Sleep(100);
  end;
end;

procedure THiconisAsManageF1.FormCreate(Sender: TObject);
var
  LPort: integer;
begin
  FProgMode := 0;
  SetCurrentDir(ExtractFilePath(Application.ExeName));
  (DataFormatAdapter2.DataFormat as TVirtualFileStreamDataFormat).OnGetStream := OnGetStream;
  FDBMsgQueue := TOmniMessageQueue.Create(1000);
  FIPCMQFromOL := TOmniMessageQueue.Create(1000);
  FTaskEditConfig.IsUseOLControlWorker := False;
  StartOLControlWorker();

  Parallel.TaskConfig.OnMessage(WM_OLMSG_RESULT,DisplayOLMsg2Grid);
  FStopEvent := TEvent.Create;
  UnitHiconisMasterRecord.InitHiconisASClient(Application.ExeName);
  InitUserClient(Application.ExeName);
  InitClient4GSTariff(Application.ExeName);
  AsynDisplayOLMsg2Grid();
  TDTF.rg_periodClick(nil);
  g_ExecuteFunction := ExecFunc;
  g_GSDocType.InitArrayRecord(R_GSDocType);

  LoadConfigFromFile;

end;

procedure THiconisAsManageF1.FormDestroy(Sender: TObject);
begin
  StopOLControlWorker();

  if FIsRunRestServer then
    DestroyHttpServer;

  if Assigned(FStopEvent) then
    FStopEvent.SetEvent;

  if Assigned(FDBMsgQueue) then
    FreeAndNil(FDBMsgQueue);

  if Assigned(FIPCMQFromOL) then
    FreeAndNil(FIPCMQFromOL);
//  FreeAndNil(FIPCServer);
  if Assigned(FStopEvent) then
    FreeAndNil(FStopEvent);
end;

procedure THiconisAsManageF1.ShowTaskFormFromDB(AIDList: TIDList; ARow: integer);
var
  LTask: TOrmHiconisASTask;
  LTaskEditConfig: THiconisASTaskEditConfig;
  LResult: integer;
begin
  LTask:= CreateOrGetLoadTask(AIDList.fTaskId);
  LTask.TaskID := LTask.ID;
  try
  {$IFDEF GAMANAGER}
    LResult := FrmHiconisASTaskEdit.DisplayTaskInfo2EditForm(LTask,nil,null, LTaskEditConfig);
  {$ELSE}
    TaskForm.DisplayTaskInfo2EditForm(LTask,nil,null);
  {$ENDIF}
    //Task Edit Form에서 "저장" 버튼을 누른 경우
    if LResult = mrOK then
      LoadTaskVar2Grid(LTask, grid_Req, ARow);
  finally
    if Assigned(LTask) then
      FreeAndNil(LTask);
  end;
end;

procedure THiconisAsManageF1.ShowTaskFormFromDB(ARow: integer);
var
  LIdList: TIDList;
  LIsRemote: Boolean;
  LUtf8: RawUTF8;
  LIpAddr: string;
begin
  if grid_Req.Row[ARow].Data <> nil then
  begin
    LIdList := TIDList(grid_Req.Row[ARow].Data);
    LIsRemote := GetIsRemote(LIpAddr);

    if LIsRemote then
    begin
      LUtf8 := ObjectToJson(LIdList);
      LUtf8 := SendReq2InqManagerServer_Http(LIpAddr, FPortName, FRootName, CMD_REQ_TASK_DETAIL, LUtf8);
      LUtf8 := MakeBase64ToUTF8(LUtf8);
      ShowTaskFormFromJson(LUtf8);
    end
    else
      ShowTaskFormFromDB(LIdList,ARow);
  end;
end;

procedure THiconisAsManageF1.ShowTaskFormFromGrid(ARow: integer);
var
  LTaskEditF: TTaskEditF;
begin
  LTaskEditF := TTaskEditF.Create(nil);
  try
    with LTaskEditF do
    begin
      LoadGrid2TaskEditForm(grid_Req, ARow, LTaskEditF);

      if LTaskEditF.ShowModal = mrOK then
      begin
        LoadTaskEditForm2Grid(LTaskEditF, grid_Req, ARow);
      end;
    end;
  finally
    LTaskEditF.Free;
  end;
end;

procedure THiconisAsManageF1.ShowTaskFormFromJson(AJson: RawUTF8);
var
  LV: variant;
begin
//  LV.Task, LV.Customer, LV.SubCon, LV.Material
  LV := _JSON(AJson);
  DisplayTaskInfo2EditFormFromVariant(LV, FRemoteIPAddress, FPortName, FRootName);
end;

procedure THiconisAsManageF1.ShowTaskID1Click(Sender: TObject);
begin
  ShowTaskIDFromGrid;
end;

procedure THiconisAsManageF1.ShowTaskIDFromGrid;
var
  LIdList: TIDList;
begin
  if grid_Req.SelectedRow = -1 then
    exit;

  if grid_Req.Row[grid_Req.SelectedRow].Data <> nil then
  begin
    LIdList := TIDList(grid_Req.Row[grid_Req.SelectedRow].Data);
    ShowMessage(IntToStr(LIdList.TaskId));
  end;
end;

procedure THiconisAsManageF1.ShowTodoListFormFromData(ARow: integer);
var
  LTask: TOrmHiconisASTask;
  LID : TID;
  i: integer;
begin
  if ARow = -1 then //Grid의 모든 Task에대한 TodoList 가져옴
  begin
    FToDoCollect.Clear;

    for i := 0 to grid_Req.RowCount - 1 do
    begin
      LID := GetTaskIdFromGrid(i);

      if LID = -1 then
        continue;

      LTask := CreateOrGetLoadTask(LID);
      try
//        LoadToDoCollectFromTask(LTask, FToDoCollect);
      finally
        FreeAndNil(LTask);
      end;
    end;
  end
  else
  begin
    LID := GetTaskIdFromGrid(ARow);

    if LID = -1 then
      exit;

    LTask := CreateOrGetLoadTask(LID);
    try
//      LoadToDoCollectFromTask(LTask, FToDoCollect);
    finally
      FreeAndNil(LTask);
    end;
  end;

  FToDoCollect.Sort(1);
  ShowToDoListFromCollect(FToDoCollect);
end;

procedure THiconisAsManageF1.ShowTodoListFormFromDBByGridRow(ARow: integer);
var
  LTask: TOrmHiconisASTask;
  LID : TID;
  i: integer;

  procedure _GetToDoListFromTask(AId: TID);
  begin
    LTask := CreateOrGetLoadTask(LID);
    try
      GetToDoListFromDBByTask(LTask, FpjhToDoList);
    finally
      FreeAndNil(LTask);
    end;
  end;
begin
  if not Assigned(FpjhToDoList) then
    FpjhToDoList := Collections.NewList<TpjhTodoItemRec>
  else
    FpjhToDoList.Clear;

  if ARow = -1 then //Grid의 모든 Task에대한 TodoList 가져옴
  begin
    for i := 0 to grid_Req.RowCount - 1 do
    begin
      LID := GetTaskIdFromGrid(i);

      if LID = -1 then
        continue;

      _GetToDoListFromTask(LID);
    end;
  end
  else //ARow에 있는 Task의 Todo List만 보여줌
  begin
    LID := GetTaskIdFromGrid(ARow);
    _GetToDoListFromTask(LID);
  end;

  ShowToDoListFormFromList(LID, FpjhToDoList);
end;

function THiconisAsManageF1.SaveCurrentTask2File(AFileName: string): string;
var
  LTask: TOrmHiconisASTask;
  LFileName, LStr: string;
begin
  Result := '';
  LTask := GetTask;
  try
    if LTask.IsUpdate then
    begin
      FTaskJson := MakeTaskInfoEmailAttached(LTask, LFileName);
      if AFileName = '' then
      begin
        AFileName := LFileName;
      end;

      Result := AFileName;
    end;
  finally
    LTask.Free;
  end;
end;

procedure THiconisAsManageF1.Select_DeliveryCondition;
var
  LDeliveryCondition: integer;
  LTask: TOrmHiconisASTask;
begin
  LTask := GetTask;
  try
    LDeliveryCondition := LTask.DeliveryCondition;
    Sel_DeliveryCondition(LDeliveryCondition);
  finally
    LTask.Free;
  end;
end;

procedure THiconisAsManageF1.Select_EstimateType;
var
  LEstimateType: integer;
  LTask: TOrmHiconisASTask;
begin
  LTask := GetTask;
  try
    LEstimateType := LTask.EstimateType;
    Sel_EstimateType(LEstimateType);
  finally
    LTask.Free;
  end;
end;

procedure THiconisAsManageF1.Select_Money;
var
  LCurrencyKind: integer;
  LTask: TOrmHiconisASTask;
begin
  LTask := GetTask;
  try
    LCurrencyKind := LTask.CurrencyKind;
    Sel_CurrencyKind(LCurrencyKind);
  finally
    LTask.Free;
  end;
end;

procedure THiconisAsManageF1.Select_TermsOfPayment;
var
  LTermsOfPayment: integer;
  LTask: TOrmHiconisASTask;
begin
  LTask := GetTask;
  try
    LTermsOfPayment := LTask.TermsOfPayment;
    Sel_TermsOfPayment(LTermsOfPayment);
  finally
    LTask.Free;
  end;
end;

procedure THiconisAsManageF1.SendReqOLEmailInfo;
begin
  SendReqOLEmailInfo_WS;
end;

procedure THiconisAsManageF1.SendReqOLEmailInfo_CromisIPC;
begin

end;

procedure THiconisAsManageF1.SendReqOLEmailInfo_WS;
var
  Client: TRestHttpClientWebsockets;
  LCommand, LRespond: string;
  Service: IOLMailService;
  callback: IOLMailCallback;
  LStrList: TStringList;
begin
{$IFDEF USE_MORMOT_WS}
  Client := GetClientWS;
  try
    if not Client.Services.Resolve(IOLMailService,Service) then
      raise EServiceException.Create('Service IOLMailService unavailable');

    callback := TOLMailCallback.Create(Client,IOLMailCallback) as IOLMailCallback;
    try
//      Service.Join(workName,callback);
      LStrList := TStringList.Create;
      try
        LStrList.Add('ServerName='+IPC_SERVER_NAME_4_OUTLOOK);
        LStrList.Add('Command='+CMD_REQ_MAILINFO_SEND);
        LCommand := LStrList.Text;
        LRespond := Service.GetOLEmailInfo(LCommand);
        ProcessCommand(LRespond);
      finally
        LStrList.Free;
      end;
    finally
      callback := nil;
      Service := nil; // release the service local instance BEFORE Client.Free
    end;
  finally
    Client.Free;
  end;
{$ENDIF}
end;

function THiconisAsManageF1.ServerExecuteFromClient(ACommand: RawUTF8): RawUTF8;
begin

end;

function THiconisAsManageF1.SessionClosed(Sender: TRestServer;
  Session: TAuthSession; Ctxt: TRestServerURIContext): boolean;
begin

end;

function THiconisAsManageF1.SessionCreate(Sender: TRestServer;
  Session: TAuthSession; Ctxt: TRestServerURIContext): boolean;
begin

end;

procedure THiconisAsManageF1.SetConfig;
var
  LConfigF: TConfigF;
  LParamFileName: string;
begin
  LConfigF := TConfigF.Create(Self);

  try
    LParamFileName := FSettings.ParamFileName;
    LoadConfig2Form(LConfigF);

    if LConfigF.ShowModal = mrOK then
    begin
      LoadConfigForm2Object(LConfigF);
      FSettings.Save();

//      FParamFileNameChanged := (LParamFileName <> FSettings.ParamFileName) and
//        (FileExists(FSettings.ParamFileName));
//      ApplyUI;
      ApplyConfigChanged;
    end;
  finally
    LConfigF.Free;
  end;
end;

procedure THiconisAsManageF1.SetNetworkInfo(ARootName, APortName, AKeyName: string);
begin
  FRootName := ARootName;
  FPortName := APortName;
  FTransmissionKey := AkeyName;
end;

procedure THiconisAsManageF1.SetUserNameNIPAddressFromRegServer;
var
  LList: string;
begin
//  LList := GetUserNameNIPListFromProductCode('','');
end;

procedure THiconisAsManageF1.ShipNameEditKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteSearch(Key);
end;

procedure THiconisAsManageF1.ShowEmailID1Click(Sender: TObject);
begin
  ShowEmailIDFromGrid;
end;

procedure THiconisAsManageF1.ShowEmailIDFromGrid;
var
  LIdList: TIDList;
begin
  if grid_Req.SelectedRow = -1 then
    exit;

  if grid_Req.Row[grid_Req.SelectedRow].Data <> nil then
  begin
    LIdList := TIDList(grid_Req.Row[grid_Req.SelectedRow].Data);
    ShowMessage(IntToStr(LIdList.EmailId));
  end;
end;

procedure THiconisAsManageF1.ShowEmailListFormFromData(ARow: integer);
var
  LTask: TOrmHiconisASTask;
  LID : TID;
  LOLEmailSrchRec: TOLEmailSrchRec;
begin
  LID := GetTaskIdFromGrid(ARow);

  if LID = -1 then
    exit;

  LTask := CreateOrGetLoadTask(LID);
  try
    LOLEmailSrchRec.FTaskID := LTask.TaskID;
    LOLEmailSrchRec.FProjectNo := LTask.Order_No;
    LOLEmailSrchRec.FHullNo := LTask.HullNo;
    LOLEmailSrchRec.FClaimNo := LTask.ClaimNo;
    LOLEmailSrchRec.IsUseOLControlWorker := LTask.IsUseOLControlWorker;

    TTaskEditF.ShowEMailListFromTask(LTask, '', '', '');
  finally
    FreeAndNil(LTask);
  end;
end;

function THiconisAsManageF1.ShowFileSelectForm: integer;
var
  LFileSelectF: TFileSelectF;
begin
  LFileSelectF := TFileSelectF.Create(nil);
  try
    with LFileSelectF do
    begin
      JvFilenameEdit1.Visible := False;
      Label2.Visible := False;

      g_GSDocType.SetType2Combo(LFileSelectF.DocTypeCombo);

      if ShowModal = mrOK then
      begin
        Result := LFileSelectF.DocTypeCombo.ItemIndex;
      end;
    end;
  finally
    LFileSelectF.Free;
  end;
end;

procedure THiconisAsManageF1.ShowGSFileID1Click(Sender: TObject);
var
  LSQLGSFile: TSQLGSFile;
  LIdList: TIDList;
  LTask: TOrmHiconisASTask;
  LStr: string;
begin
  if grid_Req.SelectedRow = -1 then
    exit;

  if grid_Req.Row[grid_Req.SelectedRow].Data <> nil then
  begin
    LIdList := TIDList(grid_Req.Row[grid_Req.SelectedRow].Data);
    LTask := GetLoadTask(LIdList.TaskId);
    LSQLGSFile := GetFilesFromTask(LTask);
    try
      while LSQLGSFile.FillOne do
      begin
        LStr := 'Task = ' + IntToStr(LTask.ID) + #13#10;
        LStr := LStr + 'GSFile = ' + IntToStr(LSQLGSFile.ID);
      end;
      ShowMessage(LStr);
    finally
      FreeAndNil(LSQLGSFile);
    end;
  end;
end;

end.

