unit FrmHiconisASManage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ImgList, Winapi.ActiveX,
  NxColumnClasses, NxColumns, NxScrollControl, NxCustomGridControl,
  NxCustomGrid, NxGrid, AdvOfficeTabSet, Vcl.StdCtrls, Vcl.ComCtrls,
  AdvGroupBox, AdvOfficeButtons, AeroButtons, JvExControls, JvLabel,
  CurvyControls, System.SyncObjs, DateUtils, Vcl.Menus, AdvEdit, AdvEdBtn, AdvToolBtn,
  Vcl.ExtCtrls, Vcl.Mask, JvExMask, JvToolEdit, JvCombobox, Vcl.Buttons,
  System.Rtti,
  OtlCommon, OtlComm, OtlTaskControl, OtlContainerObserver, otlTask, OtlParallel,

  mormot.core.base, mormot.rest.client, mormot.orm.core, mormot.rest.http.server,
  mormot.rest.server, mormot.soa.server, mormot.core.datetime, mormot.rest.memserver,
  mormot.soa.core, mormot.core.interfaces, mormot.core.os, mormot.core.text,
  mormot.rest.http.client, mormot.core.json, mormot.core.unicode, mormot.core.variants,
  mormot.core.data, mormot.orm.base, mormot.core.collections, mormot.rest.sqlite3,

  VarRecUtils, TimerPool, JHP.Util.Bit32Helper,
  CommonData2, UnitOLDataType, UnitGenericsStateMachine_pjh,//FSMClass_Dic, FSMState,
  UnitTodoCollect2, UnitElecMasterData,//FrmInqManageConfig, FrmTodoList,
  UnitHiconisMasterRecord, FrmHiconisASTaskEdit, UnitElecServiceData2, UnitMakeReport2,
  UnitHiASSubConRecord, UnitHiASMaterialRecord, UnitToDoList,
  UnitUserDataRecord2, SBPro, UnitOLEmailRecord2,//UnitIniConfigSetting2

  DragDropInternet,DropSource,DragDropFile,DragDropFormats, DragDrop, DropTarget,
  UnitHiconisASWSInterface, thundax.lib.actions_pjh,
  UnitMAPSMacro2, UnitWorker4OmniMsgQ, UnitCopyData,

  UnitOLControlWorker, UnitHiASIniConfig, FrmHiASManageConfig, UnitHiASProjectRecord,
  UnitHiconisASData, UnitOutLookDataType, UnitHiconisDI16RecallRec,
  JvComponentBase, JvCaptionButton, FormAboutDefs, EasterEgg, DragDropText, UnitOLDragDropRecord
  ;

type
  THiconisAsManageF = class(TForm)
    CurvyPanel1: TCurvyPanel;
    JvLabel2: TJvLabel;
    JvLabel5: TJvLabel;
    JvLabel6: TJvLabel;
    JvLabel1: TJvLabel;
    JvLabel3: TJvLabel;
    JvLabel4: TJvLabel;
    JvLabel8: TJvLabel;
    JvLabel9: TJvLabel;
    PeriodPanel: TCurvyPanel;
    Label4: TLabel;
    rg_period: TAdvOfficeRadioGroup;
    dt_begin: TDateTimePicker;
    dt_end: TDateTimePicker;
    ComboBox1: TComboBox;
    ClaimStatusCombo: TComboBox;
    CustomerCombo: TComboBox;
    BefAftCB: TComboBox;
    Panel1: TPanel;
    btn_Search: TAeroButton;
    btn_Close: TAeroButton;
    AeroButton1: TAeroButton;
    WorkKindCB: TComboBox;
    ClaimNoEdit: TEdit;
    MatPORNoEdit: TEdit;
    DisplayFinalCheck: TCheckBox;
    Button1: TButton;
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
    PopupMenu1: TPopupMenu;
    Mail1: TMenuItem;
    Create1: TMenuItem;
    N12: TMenuItem;
    N15: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N6: TMenuItem;
    Invoice4: TMenuItem;
    Invoice3: TMenuItem;
    InvoiceConfirm2: TMenuItem;
    N23: TMenuItem;
    ToDOList1: TMenuItem;
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
    DropEmptyTarget1: TDropEmptyTarget;
    DataFormatAdapterOutlook: TDataFormatAdapter;
    DropEmptySource1: TDropEmptySource;
    DataFormatAdapter2: TDataFormatAdapter;
    DataFormatAdapterTarget: TDataFormatAdapter;
    DataFormatAdapter1: TDataFormatAdapter;
    Timer1: TTimer;
    OpenDialog1: TOpenDialog;
    MakeCertButton: TAdvToolButton;
    ClaimPopup: TPopupMenu;
    Category1: TMenuItem;
    Location1: TMenuItem;
    CauseKind1: TMenuItem;
    CauseHW1: TMenuItem;
    CauseSW1: TMenuItem;
    CurWorkCB: TComboBox;
    JvLabel40: TJvLabel;
    File1: TMenuItem;
    CreateNewTask1: TMenuItem;
    N24: TMenuItem;
    Close1: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    ariff1: TMenuItem;
    ViewTariff1: TMenuItem;
    EditTariff1: TMenuItem;
    JvLabel7: TJvLabel;
    MaterialCodeEdit: TEdit;
    JvLabel11: TJvLabel;
    FindCondCB: TComboBox;
    N27: TMenuItem;
    ExportToExcel2: TMenuItem;
    SaveDBAs1: TMenuItem;
    ImportMaterialCodeFromExcel1: TMenuItem;
    N28: TMenuItem;
    ClaimServiceKindCB: TJvCheckedComboBox;
    CheckIfexistclaiminDBbyxls1: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    HullNoEdit: TAdvEditBtn;
    ShipNameEdit: TAdvEditBtn;
    OrderNoEdit: TAdvEditBtn;
    ImportHiconisProjectFromExcel1: TMenuItem;
    GetShipNameHullNoProjNotoClipbrd1: TMenuItem;
    ShowWarrantyExpireDate1: TMenuItem;
    BitBtn1: TBitBtn;
    ImportDIModuleRecallData1: TMenuItem;
    ShowDIRecallStatus1: TMenuItem;
    BitBtn2: TBitBtn;
    PopupMenu2: TPopupMenu;
    ShowWarrantyExpireDate2: TMenuItem;
    CreateClaimBySelected1: TMenuItem;
    N9: TMenuItem;
    BitBtn3: TBitBtn;
    PopupMenu3: TPopupMenu;
    Claim1: TMenuItem;
    JvLabel10: TJvLabel;
    BitBtn4: TBitBtn;
    ShippingNoEdit: TEdit;
    N11: TMenuItem;
    Panel2: TPanel;
    JvLabel12: TJvLabel;
    DeliveryDateEdit: TEdit;
    JvLabel13: TJvLabel;
    ExpireDateEdit: TEdit;
    JvLabel14: TJvLabel;
    ShipTypeEdit: TEdit;
    JvLabel15: TJvLabel;
    CargoSizeEdit: TEdit;
    JvLabel16: TJvLabel;
    MaterialNameEdit: TEdit;
    JvLabel17: TJvLabel;
    WorkSummaryEdit: TEdit;
    JvLabel18: TJvLabel;
    EmailDescEdit: TEdit;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    ool1: TMenuItem;
    ShowEmailListForm1: TMenuItem;
    JvCaptionButton1: TJvCaptionButton;
    FormAbout1: TFormAbout;
    Help1: TMenuItem;
    About1: TMenuItem;
    DropTextTarget1: TDropTextTarget;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
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
    procedure ClaimStatusComboDropDown(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure TaskTabChange(Sender: TObject);
    procedure HullNoEditKeyPress(Sender: TObject; var Key: Char);
    procedure ShipNameEditKeyPress(Sender: TObject; var Key: Char);
    procedure SubjectEditKeyPress(Sender: TObject; var Key: Char);
    procedure Invoice4Click(Sender: TObject);
    procedure AeroButton1Click(Sender: TObject);
    procedure GetJsonValues1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure grid_ReqKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N18Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure PICCBChange(Sender: TObject);
    procedure GetHullNoToClipboard1Click(Sender: TObject);
    procedure ToDOList1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure DropEmptyTarget1Drop(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
    procedure btn_CloseClick(Sender: TObject);
    procedure Category1Click(Sender: TObject);
    procedure Location1Click(Sender: TObject);
    procedure CauseKind1Click(Sender: TObject);
    procedure CauseHW1Click(Sender: TObject);
    procedure CauseSW1Click(Sender: TObject);
    procedure ClaimServiceKindCBDropDown(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure CreateNewTask1Click(Sender: TObject);
    procedure N26Click(Sender: TObject);
    procedure ViewTariff1Click(Sender: TObject);
    procedure EditTariff1Click(Sender: TObject);
    procedure ExportToExcel2Click(Sender: TObject);
    procedure SaveDBAs1Click(Sender: TObject);
    procedure ImportMaterialCodeFromExcel1Click(Sender: TObject);
    procedure CheckIfexistclaiminDBbyxls1Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure HullNoEditClickBtn(Sender: TObject);
    procedure OrderNoEditKeyPress(Sender: TObject; var Key: Char);
    procedure ImportHiconisProjectFromExcel1Click(Sender: TObject);
    procedure GetShipNameHullNoProjNotoClipbrd1Click(Sender: TObject);
    procedure ShowWarrantyExpireDate1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FindCondCBChange(Sender: TObject);
    procedure ImportDIModuleRecallData1Click(Sender: TObject);
    procedure ShowDIRecallStatus1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ShowWarrantyExpireDate2Click(Sender: TObject);
    procedure CreateClaimBySelected1Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Claim1Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure grid_ReqSelectCell(Sender: TObject; ACol, ARow: Integer);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure ShowEmailListForm1Click(Sender: TObject);
    procedure JvCaptionButton1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure DropTextTarget1Drop(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
  private
    FPJHTimerPool: TPJHTimerPool;
    FStopEvent    : TEvent;
    FDBMsgQueue: TOmniMessageQueue;
    FEgg: TEasternEgg;
//    FIPCMQCommandOLEmail: TOmniMessageQueue; FTaskEditConfig.IPCMQCommandOLEmail�� ��ü��
    FHiASIniConfig: THiASIniConfig;
    FHiASIniFileName: string;
    FTaskEditConfig: THiconisASTaskEditConfig;
    FTaskJson: String;
    FFileContent: RawByteString;

    //Websocket-b
    FIpAddr: string;
    FURL: string; //Server���� Client�� Config Change Notify �ϱ� ���� Call Back URL
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

    FOLCalendarQueue,
    FOLAppointmentQueue: TOmniMessageQueue;

    FOLCmdSenderHandle: THandle;//OLControlWorker�� Respond���� �����ϱ� ���� Handle
    FOLEmailListFormDisplayed, //True = FrmOLEmailList.TOLEmailListF ShowModal
    FHiASTaskEditFormDisplayed: Boolean;//True = TTaskEditF Form ShowModal
    FHiASDI16RecallDict: THiASDI16RecallDict;

    FOLEmail_DragDropText: TOLEmail_DragSourceDataFormat;

    procedure InitEnum;
    procedure OnGetStream(Sender: TFileContentsStreamOnDemandClipboardFormat;
      Index: integer; out AStream: IStream);
    procedure OnInitOutlookTimer(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);
    procedure OnWorkerResult(var Msg: TMessage); message MSG_RESULT;
    procedure OnOLEmailListFormClose(var Msg: TMessage); message MSG_OLEMAILLISTF_CLOSE;
    procedure WMCopyData(var Msg: TMessage); message WM_COPYDATA;

    procedure ProcessCommand(ARespond: string);
    //Macro���� ExecFunction���� FunctionName�� �ָ� �Ʒ��� public�� Procedure����
    //�Լ����� ã�Ƽ� ������ ��
    procedure ExecFunc(AFuncName: string);
    procedure ExecMethod(MethodName:string; const Args: array of TValue);

    function SaveCurrentTask2File(AFileName: string = '') : string;
    procedure CreateNewTask(AJson: RawUtf8='');
    procedure CreateNewTaskBySelected();

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

    //g_GSDocType ��ȯ��
    function ShowFileSelectForm(): integer;

    procedure ExecuteSearch(Key: Char);

    //TaskTab�� tag�� TSalesProcess���� ������
    //���콺�� tab ���� �� �ش� Task�� ���̱� ����
    procedure InitTaskTab;
    procedure InputValueClear;
    procedure InitTaskEnum;
    procedure InitOutlook;

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
    procedure DisplayOLMsg2Grid(const task: IOmniTaskControl;
      const msg: TOmniMessage);
    function GetWarrantyExpireDateBySelected(): TDate;
    function GetDeliveryDateBySelected(): TDate;
    function GetWarrantyPeriodBySelected(): string;

    procedure SetDefaultFindCond;
    procedure ClearFindCond;
    procedure SetInputTodayCond;
    procedure SetInputReviewCond;
    procedure SetUpdateTodayCond;

    procedure LoadHiASDIRecallDataFromFile();
  protected
    procedure ShowTaskIDFromGrid;
    procedure ShowEmailIDFromGrid;

    function GetTaskIdFromGridBySelected: TID;
    function GetDirectInputReqNoFromBySeleced: string;//���������Կ�û ��ȣ ��ȯ
    function GetEmailSubjectFromGridBySelected: string;//�̸��� ������ ��ȯ
    procedure ShowEmailListForm();
    //Result : HullNo and ClaimNo�� Grid�� �����ϸ� True
    function GetIDListNRowByHullNoNClaimNoFromGrid(AHullNo, AClaimNo: string;
      out AIdList: TIDList; out ARow: integer): Boolean;

    procedure ProcessPasteEvent(ATxt: string);
    function GetUserList: TStrings;
    function GetUserListFromFile(AFileName: string): TStrings;

    procedure SaveDB2File();
    procedure CheckIfExistClaimInDBByXls(AXlsName: string);
    procedure SendCmd4CreateMail(AMailType: integer);

    procedure AssignHull2RecFromForm(AHiASIniConfig: THiASIniConfig);

    function UpdateJsonAryIfClaimNoIsExistInDB(const AJsonAry: string): string;
    procedure OnEasterEgg(msg: string);
  public
    //������ �̵���ų ���� ����Ʈ,
    //HGS Task/Send Folder Name 2 IPC �޴��� ���� OL���� ���� ������
    FFolderListFromOL,
    FTempJsonList,
    FUserList: TStringList;//Remote���� Task��û�� Result Json������
    FToDoCollect: TpjhToDoItemCollection;
    FpjhToDoList: TpjhToDoList;
    FMyIPAddress,
    FRemoteIPAddress: string;
    //CreateConstArray�Լ��� �ݵ�� �����ڿ��� ����Ǿ�� Ŭ���� �ȿ��� ��� ������
    //Parameter�� �����ϸ� �ȵ�
//    FConstArray: TConstArray;
    FRootName,
    FPortName,
    FTransmissionKey: string;

    //Main or �ܼ� ��ȸ: Main := 0, �ܼ� ��ȸ := 1
    FProgMode: integer;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SetNetworkInfo(ARootName, APortName, AKeyName: string);
    function GetMyName(AEmail: string): string;
    procedure LoadConfigFromFile(AFileName: string = '');
    procedure LoadConfig2Form(AForm: THiASConfigF);
    procedure LoadConfigForm2Object(AForm: THiASConfigF);
    procedure SetConfig;
    procedure ApplyConfigChanged;
    procedure GetSearchCondRec(var ARec: TSearchCondRec);
//    procedure GetWhereConstArr(ASearchCondRec: TSearchCondRec; var AWhere: string);// var AConstArr: TConstArray);
    function GetIsRemote(var ARemoteAddr: string): Boolean;
    procedure FillInUserList;

    function GetTask: TOrmHiconisASTask;
    procedure DisplayTaskInfo2Grid(ASearchCondRec: TSearchCondRec; AFromRemote: Boolean = False);
    procedure DisplayTask2GridByPorNo(const APorNo: string);
    procedure DisplayTask2GridByMatPorNo(const AMatPorNo: string);
    procedure DisplayTask2GridByMaterialCode(const AMaterialCode: string);
    procedure DisplayTask2GridByMaterialName(const AMaterialName: string);
    procedure LoadTaskVar2Grid(AVar: TOrmHiconisASTask; AGrid: TNextGrid;
      ARow: integer = -1);
    procedure LoadGSTask2Grid(ATask: TOrmHiconisASTask; AGrid: TNextGrid;
      ARow: integer = -1);
    procedure grid_Req_ClearRows();
    procedure LoadFooterFromVesselListDB2FormByHullNo(const AHullNo: string);

    procedure AddFolderListFromOL(AFolder: string);

    procedure ShowTaskFormFromGrid(ARow: integer);
    procedure ShowTaskFormFromDB(ARow: integer); overload;
    procedure ShowTaskFormFromDB(AIDList: TIDList; ARow: integer); overload;
    procedure ShowEmailListFormFromData(ARow: integer);
    procedure ShowTodoListFormFromData(ARow: integer);
    procedure ShowToDoListFromCollect(AToDoCollect: TpjhToDoItemCollection);

    procedure ShowTodoListFormFromDBByGridRow(ARow: integer);
    procedure ShowToDoListFormFromList(ATaskId: TID; AToDoList: TpjhToDoList);

    procedure ShowDIRecallStatusBySelected();
    procedure ShowDiRecallStatusFromRec(ARec: THiASDI16RecallRec);

    procedure SetUserNameNIPAddressFromRegServer;

    //--> Remote Command Proess
    procedure DisplayTaskInfo2GridFromJson(AJson: RawUTF8);
    procedure ShowTaskFormFromJson(AJson: RawUTF8);

    procedure AsyncProcessCommandProc;
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

const
  WM_OLMSG_RESULT = WM_USER + 1;

var
  HiconisASManageF: THiconisASManageF;

implementation

uses ClipBrd, System.RegularExpressions,//UnitIPCModule2,
  UnitGSFileRecord2, getIp, UnitBase64Util2, UnitmORMotUtil2, UnitFolderUtil2,
  UnitHiconisASVarJsonUtil, UnitHiASToDoRecord, FrmToDoList2,
  UnitStringUtil, UnitExcelUtil, UnitClipBoardUtil, UnitOutLookUtil,

  Vcl.ogutil, UnitDragUtil, FrmOLEmailList, UnitCommonFormUtil, UnitDateUtil,
  FrmEditTariff2, UnitGSTariffRecord2, UnitComboBoxUtil,//UnitCmdExecService,
  FrmDisplayTariff2, OLMailWSCallbackInterface2, FrmFileSelect,
  UnitHiASMaterialDetailRecord, UnitImportFromXls, UnitHiASMaterialCodeRecord,
  UnitIPCMsgQUtil, UnitHiASOLUtil, UnitVesselMasterRecord2, FrmSearchVessel2,
  UnitAdvCompUtil, UnitHiASUtil, UnitArrayUtil;

{$R *.dfm}

procedure THiconisAsManageF.SubjectEditKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteSearch(Key);
end;

procedure THiconisAsManageF.CurWorkCBDropDown(Sender: TObject);
var
  i: integer;
  LpjhBit32: TpjhBit32;
begin
  CurWorkCB.Clear;
  LpjhBit32 := GetSetFromCheckCombo(ClaimServiceKindCB);

  for i := 0 to 31 do
  begin
    if LpjhBit32.Bit[i] then
    begin
      SetState2ComboByClaimServiceKind(g_ClaimServiceKind.ToType(i), CurWorkCB);
//      Break;
    end;
  end;//for
end;

procedure THiconisAsManageF.LoadConfig2Form(AForm: THiASConfigF);
begin
  FHiASIniConfig.LoadConfig2Form(AForm, FHiASIniConfig);
end;

procedure THiconisAsManageF.LoadConfigForm2Object(AForm: THiASConfigF);
begin
  FHiASIniConfig.LoadConfigForm2Object(AForm, FHiASIniConfig);
end;

procedure THiconisAsManageF.LoadConfigFromFile(AFileName: string);
begin
  if AFileName = '' then
    AFileName := FHiASIniFileName;

  FHiASIniConfig.Load(AFileName);
end;

procedure THiconisAsManageF.LoadFooterFromVesselListDB2FormByHullNo(
  const AHullNo: string);
var
  LRec: TVesselInfo4AS;
begin
  if AHullNo = '' then
    exit;

  LRec := GetVesselInfo4ASByHullNo(AHullNo);

  DeliveryDateEdit.Text := LRec.fDeliveryDate;
  ShipTypeEdit.Text := LRec.fShipType;
  CargoSizeEdit.Text := LRec.fCargoSize;

  ExpireDateEdit.Text := GetDateStrFromTimeLog(CalcWarrantyExpireDateByHullNo(AHullNo));;
end;

procedure THiconisAsManageF.LoadGSTask2Grid(ATask: TOrmHiconisASTask; AGrid: TNextGrid;
  ARow: integer);
//var
//  LStrList: TStringList;
//  LFSMState: THiconisASState;
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
    CellByName['Status', ARow].AsString := g_HiconisASState.ToString(CurrentWorkStatus);
    CellByName['Email', ARow].AsInteger := NumOfEMails;

    if NextWork > 0 then
    begin
      CellByName['NextProcess', ARow].AsString := g_HiconisASTrigger.ToString(NextWork);
    end
    else
    begin
//      LFSMState := g_HiconisASState.ToType(Ord(SalesProcessType));

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

procedure THiconisAsManageF.LoadHiASDIRecallDataFromFile;
var
  LUtf8: RawUtf8;
  LStr: string;
begin
  if FHiASIniConfig.FDIModuleRecallStatusFN = '' then
  begin
    ShowMessage('FHiASIniConfig.FDIModuleRecallStatusFN is empty');
    exit;
  end;

  LUtf8 := StringFromFile(FHiASIniConfig.FDIModuleRecallStatusFN);
  FHiASDI16RecallDict.Data.LoadFromJson(LUtf8);
end;

procedure THiconisAsManageF.LoadTaskVar2Grid(AVar: TOrmHiconisASTask; AGrid: TNextGrid;
  ARow: integer);
var
  LIds: TIDDynArray;
  LSubject: string;
  LMailCount: integer;
begin
  if not Assigned(AVar) then
    exit;

  AVar.NumOfEMails := GetEmailCountFromTaskID(AVar.ID);
//  AVar.EmailSubject := LSubject;
  AVar.TaskID := AVar.ID;

  LoadGSTask2Grid(AVar, AGrid, ARow);
end;

procedure THiconisAsManageF.Location1Click(Sender: TObject);
begin
  Location1.Tag := ShowCheckGrp4Claim(Ord(ctkLocation), Location1.Tag);
end;

procedure THiconisAsManageF.MakeCustReg(ARow: integer);
var
  LRec: Doc_Cust_Reg_Rec;
begin
  LRec := Get_Doc_Cust_Reg_Rec(ARow);
  MakeDocCustomerRegistration(LRec);
end;

procedure THiconisAsManageF.MakeInvoice(ARow: integer);
var
  LRec: Doc_Invoice_Rec;
begin
  LRec := Get_Doc_Inv_Rec(ARow);
  MakeDocInvoice(LRec);
end;

procedure THiconisAsManageF.MakeQtn(ARow: integer);
var
  LRec: Doc_Qtn_Rec;
begin
  LRec := Get_Doc_Qtn_Rec(ARow);
  MakeDocQtn(LRec);
end;

procedure THiconisAsManageF.MakeServiceOrder(ARow: integer);
var
  LRec: Doc_ServiceOrder_Rec;
begin
  LRec := Get_Doc_ServiceOrder_Rec(ARow);
  MakeDocServiceOrder(LRec);
end;

procedure THiconisAsManageF.N11Click(Sender: TObject);
begin
  SendCmd4CreateMail(TMenuItem(Sender).Tag);
end;

procedure THiconisAsManageF.N12Click(Sender: TObject);
var
  LTask: TOrmHiconisASTask;
begin
  LTask := GetTask;
  try
//    SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, LTask,
//      FSettings,
//      GetRecvEmailAddress(TMenuItem(Sender).Tag));
  finally
    FreeAndNil(LTask);
  end;
end;

procedure THiconisAsManageF.N15Click(Sender: TObject);
var
  LTask: TOrmHiconisASTask;
begin
  LTask := GetTask;
  try
//    SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, LTask,
//      FSettings,
//      GetRecvEmailAddress(TMenuItem(Sender).Tag));
  finally
    FreeAndNil(LTask);
  end;
end;

procedure THiconisAsManageF.N18Click(Sender: TObject);
var
  LTask: TOrmHiconisASTask;
begin
  LTask := GetTask;
  try
//    SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, LTask,
//      FSettings,
//      GetRecvEmailAddress(TMenuItem(Sender).Tag));
  finally
    FreeAndNil(LTask);
  end;
end;

procedure THiconisAsManageF.N20Click(Sender: TObject);
var
  LTask: TOrmHiconisASTask;
begin
  LTask := GetTask;
  try
//    SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, LTask,
//      FSettings,
//      GetRecvEmailAddress(TMenuItem(Sender).Tag));
  finally
    FreeAndNil(LTask);
  end;
end;

procedure THiconisAsManageF.N21Click(Sender: TObject);
var
  LTask: TOrmHiconisASTask;
begin
  LTask := GetTask;
  try
//    SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, LTask,
//      FSettings,
//      GetRecvEmailAddress(TMenuItem(Sender).Tag));
  finally
    FreeAndNil(LTask);
  end;
end;

procedure THiconisAsManageF.N26Click(Sender: TObject);
begin
  SetConfig;
end;

procedure THiconisAsManageF.N4Click(Sender: TObject);
var
  LRec: Doc_SubCon_Invoice_List_Rec;
  LWorksheet: OleVariant;
  LRow: integer;
begin
//  LRec := Get_Doc_SubCon_Invoice_List_Rec;
//  LWorksheet := MakeDocSubConInvoiceList;
//  MakeDocSubConInvoiceList2(LWorkSheet, LRec, LRow);
end;

procedure THiconisAsManageF.N7Click(Sender: TObject);
begin
  SendCmd4CreateMail(TMenuItem(Sender).Tag);
end;

procedure THiconisAsManageF.N8Click(Sender: TObject);
begin
  SendCmd4CreateMail(TMenuItem(Sender).Tag);
end;

procedure THiconisAsManageF.ToDOList1Click(Sender: TObject);
begin
  if grid_Req.SelectedCount = 0 then
  begin
    ShowMessage('Task�� ���� �ϼ���.');
    exit;
  end;

//  ShowTodoListFormFromData(grid_Req.SelectedRow);
  ShowTodoListFormFromDBByGridRow(grid_Req.SelectedRow);
end;

function THiconisAsManageF.UpdateJsonAryIfClaimNoIsExistInDB(
  const AJsonAry: string): string;
var
  LUtf8: RawUtf8;
  LDocList, LResultList: IDocList;
  LDocDict: IDocDict;
  LHullNo, LClaimNo, LTaskID: string;
begin
  LResultList := DocList('[]');
  LDocList := DocList('[]');
  LDocDict := DocDict('{}');

  LDocList := DocList(AJsonAry);

  for LDocDict in LDocList.Objects do
  begin
    LHullNo := LDocDict.S['HullNo'];
    LClaimNo := LDocDict.S['ClaimNo'];
    LDocDict.B['ExistInDB'] := CheckExistHullNoClaimNo(LHullNo, LClaimNo, LTaskID);
    LDocDict.S['TaskID'] := LTaskID;

    LResultList.AppendDoc(LDocDict);
  end;

  Result := LResultList.Json;
end;

procedure THiconisAsManageF.ViewTariff1Click(Sender: TObject);
var
  LDoc: variant;
begin
  LDoc := LoadGSTariff2VariantFromCompanyCodeNYear('0001056374', YearOf(now));
  DisplayTariff(LDoc);
end;

procedure THiconisAsManageF.WMCopyData(var Msg: TMessage);
var
  LMsg: string;
  LTask: TOrmHiconisASTask;
  LResult: integer;
  LHullNo, LClaimNo: string;
  LIDList: TIDList;
  LRow: integer;
begin
  LMsg := PRecToPass(PCopyDataStruct(Msg.LParam)^.lpData)^.StrMsg;
  LHullNo := StrToken(LMsg, ';');
  LClaimNo := LMsg;

  if GetIDListNRowByHullNoNClaimNoFromGrid(LHullNo, LClaimNo, LIDList, LRow) then
  begin
    ShowTaskFormFromDB(LIDList, LRow);
  end
  else
  begin
    LTask:= GetTaskFromHullNoNClaimNo(LHullNo, LClaimNo);
    try
      if LTask.IsUpdate then
      begin
        LResult := FrmHiconisASTaskEdit.DisplayTaskInfo2EditForm(LTask,nil,'', FTaskEditConfig, FHiASIniConfig);
        //Task Edit Form���� "����" ��ư�� ���� ���
        if LResult = mrOK then
        begin
          FHiASTaskEditFormDisplayed := False;
          LoadTaskVar2Grid(LTask, grid_Req);
          FTaskEditConfig.IsAllowUpdateHullNo2Grid := False;
        end;
      end;
    finally
      if Assigned(LTask) then
        FreeAndNil(LTask);
    end;
  end;
end;

procedure THiconisAsManageF.OnEasterEgg(msg: string);
begin
  FormAbout1.LicenseText.Text := THiASIniConfig.FRegAppInfoB64;
  About1Click(nil);
end;

procedure THiconisAsManageF.OnGetStream(
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

procedure THiconisAsManageF.OnInitOutlookTimer(Sender: TObject; Handle: Integer;
  Interval: Cardinal; ElapsedTime: Integer);
begin
  InitOutlook();
end;

procedure THiconisAsManageF.OnOLEmailListFormClose(var Msg: TMessage);
begin
  FOLEmailListFormDisplayed := False;
  ShowEmailListForm1.Enabled := True;
end;

procedure THiconisAsManageF.OnWorkerResult(var Msg: TMessage);
var
  LMsg  : TOmniMessage;
//  LOLRespondRec : TOLRespondRec;
begin
  while FResponseQueue.TryDequeue(LMsg) do
  begin
//    if LMsg.MsgID = Ord(olrkAddAppointment) then
//    begin
//      LOLRespondRec := LMsg.MsgData.ToRecord<TOLRespondRec>;
//      ShowMessage(LOLRespondRec.FMsg);
//    end;

    //TaskEdit Form�� ShowModal �Ǿ��� ���� IPCMQ2RespondOLEmail.Enqueue ����
    //�Ʒ� ������ ������ IPCMQ2RespondOLEmail.Enqueue ������ Q�� �����Ͱ� ����
    if FHiASTaskEditFormDisplayed or FOLEmailListFormDisplayed or
      (LMsg.MsgID = Ord(olrkAddObject)) then
      if FTaskEditConfig.IPCMQ2RespondOLEmail.Enqueue(LMsg) then
        SendMessage(FOLCmdSenderHandle, MSG_RESULT, 0, 0)
  end;
end;

procedure THiconisAsManageF.OrderNoEditKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteSearch(Key);
end;

procedure THiconisAsManageF.PICCBChange(Sender: TObject);
begin
  GetIsRemote(FRemoteIPAddress);
end;

procedure THiconisAsManageF.ProcessCommand(ARespond: string);
begin

end;

procedure THiconisAsManageF.ProcessPasteEvent(ATxt: string);
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

procedure THiconisAsManageF.Claim1Click(Sender: TObject);
begin
  ExecMacro_QryClaimMonitoringByHullNo(HullNoEdit);
end;

procedure THiconisAsManageF.ClaimServiceKindCBDropDown(Sender: TObject);
begin
//  g_ClaimServiceKind.SetType2Combo(ClaimServiceKindCB);
end;

procedure THiconisAsManageF.ClaimStatusComboDropDown(Sender: TObject);
begin
//  g_ElecProductType.SetType2Combo(ProductTypeCombo);
  g_ClaimStatus.SetType2Combo(ClaimStatusCombo);
end;

procedure THiconisAsManageF.ClearFindCond;
begin
  FindCondCB.ItemIndex := -1;
  ComboBox1.ItemIndex := -1;
  ClaimServiceKindCB.Items.Text := '';
  CustomerCombo.ItemIndex := -1;
  ClaimStatusCombo.ItemIndex := -1;
  CurWorkCB.ItemIndex := -1;
  BefAftCB.ItemIndex := -1;
  MatPORNoEdit.Text := '';
  MaterialCodeEdit.Text := '';
  OrderNoEdit.Text := '';
  ClaimNoEdit.Text := '';
  ShipNameEdit.Text := '';
  HullNoEdit.Text := '';
  DisplayFinalCheck.Checked := False;

  SetDefaultFindCond;
end;

procedure THiconisAsManageF.Close1Click(Sender: TObject);
begin
  Close;
end;

procedure THiconisAsManageF.rg_periodClick(Sender: TObject);
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

procedure THiconisAsManageF.GetJsonValues1Click(Sender: TObject);
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

function THiconisAsManageF.GetMyName(AEmail: string): string;
begin
  Result := GetMyNameNIPAddressFromEmailAddress(AEmail);
end;

procedure THiconisAsManageF.GetSearchCondRec(var ARec: TSearchCondRec);
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
    FHullNo := Trim(HullNoEdit.Text);
    FShipName := Trim(ShipNameEdit.Text);
    FCustomer := Trim(CustomerCombo.Text);
//    FProdType := ProductTypeCombo.Text;
    FClaimStatus := ClaimStatusCombo.ItemIndex;
//    FSubject := SubjectEdit.Text;
    FClaimServiceKind := GetSetFromCheckCombo(ClaimServiceKindCB);;//ClaimServiceKindCB.ItemIndex;
    FCurWork :=  g_HiconisASState.ToOrdinal(CurWorkCB.Text);
    FBefAft :=  BefAftCB.ItemIndex;
    FWorkKind :=  WorkKindCB.ItemIndex;
    FClaimNo := Trim(ClaimNoEdit.Text);
//    FQtnNo := QtnNoEdit.Text;
    FOrderNo := Trim(OrderNoEdit.Text);
    FMatPorNo := MatPorNoEdit.Text;
    FMaterialCode := Trim(MaterialCodeEdit.Text);
    FMaterialName := MaterialNameEdit.Text;

    FShippingNo := Trim(ShippingNoEdit.Text);
    FWorkSummary := WorkSummaryEdit.Text;

    FClaimCatetory := Category1.Tag;
    FClaimLocation := Location1.Tag;
    FClaimKind := CauseKind1.Tag;
    FClaimCauseHW := CauseHW1.Tag;
    FClaimCauseSW := CauseSW1.Tag;

    FIncludeClosed := DisplayFinalCheck.Checked;

//    if PICCB.ItemIndex = -1 then
//      PICCB.ItemIndex := 0;

//    if PICCB.ItemIndex <> -1 then
//      FRemoteIPAddress := PICCB.Items.ValueFromIndex[PICCB.ItemIndex]
//    else
//      FRemoteIPAddress := '';
  end;
end;

procedure THiconisAsManageF.GetShipNameHullNoProjNotoClipbrd1Click(
  Sender: TObject);
begin
  if grid_Req.SelectedRow = -1 then
    exit;

  Clipboard.AsText := grid_Req.CellsByName['ShipName',grid_Req.SelectedRow] + ' (' +
    grid_Req.CellsByName['HullNo',grid_Req.SelectedRow] + ') - ' + grid_Req.CellsByName['OrderNo',grid_Req.SelectedRow];
end;

function THiconisAsManageF.GetSqlWhereFromQueryDate(AQueryDate: TQueryDateType): string;
begin
  case AQueryDate of
//    qdtMaterialOrder: Result := 'InqRecvDate >= ? and InqRecvDate <= ? ';
    qdtClaimRecvDate: Result := 'ClaimRecvDate >= ? and ClaimRecvDate <= ? ';
    qdtClaimInputDate: Result := 'ClaimInputDate >= ? and ClaimInputDate <= ? ';
    qdtClaimReadyDate: Result := 'ClaimReadyDate >= ? and ClaimReadyDate <= ? ';
    qdtClaimClosedDate: Result := 'ClaimClosedDate >= ? and ClaimClosedDate <= ? ';
    qdtAttendScheduled: Result := 'AttendScheduled >= ? and AttendScheduled <= ? ';
    qdtWorkBeginDate: Result := 'WorkBeginDate >= ? and WorkBeginDate <= ? ';
    qdtWorkEndDate: Result := 'WorkEndDate >= ? and WorkEndDate <= ? ';
    qdtModifyDate: Result := 'ModifyDate >= ? and ModifyDate <= ? ';
  end;
end;

function THiconisAsManageF.GetTask: TOrmHiconisASTask;
var
  LTaskID: TID;
begin
  LTaskID := GetTaskIdFromGrid(grid_Req.SelectedRow);
  Result := GetLoadTask(LTaskID);
end;

function THiconisAsManageF.GetTaskIdFromGrid(ARow: integer): TID;
begin
  if Assigned(grid_Req.Row[ARow].Data) then
    Result := TIDList(grid_Req.Row[ARow].Data).fTaskId
  else
    Result := -1;
end;

function THiconisAsManageF.GetTaskIdFromGridBySelected: TID;
var
  LIdList: TIDList;
begin
  Result := -1;
  if grid_Req.Row[grid_Req.SelectedRow].Data <> nil then
  begin
    LIdList := TIDList(grid_Req.Row[grid_Req.SelectedRow].Data);
    Result := LIdList.TaskId;
  end;
end;

function THiconisAsManageF.GetUserList: TStrings;
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

function THiconisAsManageF.GetUserListFromFile(AFileName: string): TStrings;
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

function THiconisAsManageF.GetWarrantyExpireDateBySelected: TDate;
var
  LHullNo: string;
begin
  if grid_Req.SelectedRow = -1 then
    exit;

  LHullNo := grid_Req.CellsByName['HullNo',grid_Req.SelectedRow];
  Result := TimelogToDatetime(CalcWarrantyExpireDateByHullNo(LHullNo));
end;

function THiconisAsManageF.GetWarrantyPeriodBySelected: string;
var
  LHullNo: string;
begin
  if grid_Req.SelectedRow = -1 then
    exit;

  LHullNo := grid_Req.CellsByName['HullNo',grid_Req.SelectedRow];
  Result := GetWarrantyPeriodByHullNo(LHullNo);
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
//    if ASearchCondRec.FWorkKind = 0 then //�����۾�
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
//    if ASearchCondRec.FBefAft = 1 then//����
//      AWhere := AWhere + '< ?'
//    else
//    if ASearchCondRec.FBefAft = 2 then//����
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
//  //�Ϸ���� ���� ��� Task�� ������
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

function THiconisAsManageF.Get_Doc_Cust_Reg_Rec(ARow: integer): Doc_Cust_Reg_Rec;
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

function THiconisAsManageF.Get_Doc_Inv_Rec(ARow: integer): Doc_Invoice_Rec;
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

function THiconisAsManageF.Get_Doc_Qtn_Rec(ARow: integer): Doc_Qtn_Rec;
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

function THiconisAsManageF.Get_Doc_ServiceOrder_Rec(ARow: integer): Doc_ServiceOrder_Rec;
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

function THiconisAsManageF.Get_Doc_SubCon_Invoice_List_Rec: Doc_SubCon_Invoice_List_Rec;
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

procedure THiconisAsManageF.grid_ReqCellDblClick(Sender: TObject; ACol,
  ARow: Integer);
var
  LTask: TOrmHiconisASTask;
begin
  if ARow = -1 then
    Exit;

  ShowTaskFormFromDB(ARow);
end;

procedure THiconisAsManageF.grid_ReqKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and ((Key = Ord('V')) or (Key = Ord('v'))  ) then
    ProcessPasteEvent(ClipBoard.AsText);
//    ShowMessage(ClipBoard.AsText);
  FEgg.CheckKeydown(Key, Shift);
end;

procedure THiconisAsManageF.grid_ReqSelectCell(Sender: TObject; ACol,
  ARow: Integer);
begin
  if grid_Req.SelectedRow <> -1 then
    LoadFooterFromVesselListDB2FormByHullNo(grid_Req.CellsByName['HullNo', grid_Req.SelectedRow]);
end;

procedure THiconisAsManageF.grid_Req_ClearRows;
var
  i: integer;
begin
  for i := 0 to grid_req.RowCount - 1 do
    TIDList(grid_req.Row[i].Data).Free;

  grid_Req.ClearRows();
end;

procedure THiconisAsManageF.HullNoEditClickBtn(Sender: TObject);
var
  LVesselSearchParamRec: TVesselSearchParamRec;
begin
  LVesselSearchParamRec.fHullNo := HullNoEdit.Text;
  LVesselSearchParamRec.fShipName := ShipNameEdit.Text;

  if ShowSearchVesselForm(LVesselSearchParamRec) = mrOK then
  begin
    HullNoEdit.Text := LVesselSearchParamRec.fHullNo;
    ShipNameEdit.Text := LVesselSearchParamRec.fShipName;
  end;
end;

procedure THiconisAsManageF.HullNoEditKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteSearch(Key);
end;

procedure THiconisAsManageF.ImportDIModuleRecallData1Click(Sender: TObject);
var
  LJson: RawUtf8;
  LFileName: string;
begin
  if OpenDialog1.Execute then
  begin
    if FileExists(OpenDialog1.FileName) then
    begin
      ImportHiconisDIRecallFromXlsFile(OpenDialog1.FileName, FHiASDI16RecallDict);
      LJson := FHiASDI16RecallDict.Data.SaveToJson();
      LFileName := FHiASIniConfig.FDIModuleRecallStatusFN;
      FileFromString(LJson, LFileName);
      ShowMessage('Hiconis DI16 Recall Status is saved to => ' + LFileName);
    end;
  end;
end;

procedure THiconisAsManageF.ImportHiconisProjectFromExcel1Click(
  Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    if FileExists(OpenDialog1.FileName) then
    begin
      InitHiASProjectClient('');
      ImportHiconisProjectFromXlsFile(OpenDialog1.FileName);
      ShowMessage('Hiconis Project is imported completely.' + #13#10 + 'Please check the HiconisAS_Project.sqlite');
    end;
  end;
end;

procedure THiconisAsManageF.ImportMaterialCodeFromExcel1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    if FileExists(OpenDialog1.FileName) then
    begin
      ImportMaterialCodeFromXlsFile(OpenDialog1.FileName);
      ShowMessage('MaterialCode is imported completely.' + #13#10 + 'Please check the HiconisAS_MaterialCode.sqlite');
    end;
  end;
end;

procedure THiconisAsManageF.InitEnum;
var
  LStrList: TStringList;
begin
  g_HiconisASState.InitArrayRecord(R_HiconisASState);
  g_HiconisASTrigger.InitArrayRecord(R_HiconisASTrigger);
  g_ClaimServiceKind.InitArrayRecord(R_ClaimServiceKind);
  g_ClaimCategory.InitArrayRecord(R_ClaimCategory);
  g_ClaimLocation.InitArrayRecord(R_ClaimLocation);
  g_ClaimCauseKind.InitArrayRecord(R_ClaimCauseKind);
  g_ClaimCauseHW.InitArrayRecord(R_ClaimCauseHW);
  g_ClaimCauseSW.InitArrayRecord(R_ClaimCauseSW);
  g_ClaimTypeKind.InitArrayRecord(R_ClaimTypeKind);
  g_ClaimStatus.InitArrayRecord(R_ClaimStatus);
  g_HiASFindCondition.InitArrayRecord(R_HiASFindCondType);
  g_SalesProcess.InitArrayRecord(R_SalesProcess);

  g_HiASFindCondition.SetType2Combo(FindCondCB);

  LStrList := g_ClaimServiceKind.GetTypeLabels();
  try
    ClaimServiceKindCB.Items.Assign(LStrList);
  finally
    LStrList.Free;
  end;
end;

procedure THiconisAsManageF.InitNetwork;
begin
//  CreateHttpServer4WS(FPortName, FTransmissionKey, TServiceIM4WS, [IHiconisASService]);
  FIsRunRestServer := True;
  StatusBarPro1.Panels[2].Text := 'Port = ' + FPortName;
end;

procedure THiconisAsManageF.InitOutlook;
begin
  FTaskEditConfig.IPCMQCommandOLEmail.Enqueue(TOmniMessage.Create(Ord(olckInitVar), TOmniValue.CastFrom(Self.Handle)));
end;

procedure THiconisAsManageF.InitTaskEnum;
begin
  g_QueryDateType.InitArrayRecord(R_QueryDateType);
  g_ElecProductType.InitArrayRecord(R_ElecProductType);
end;

procedure THiconisAsManageF.InitTaskTab;
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

procedure THiconisAsManageF.InputValueClear;
begin
  HullNoEdit.Text := '';
  ShipNameEdit.Text := '';
  CustomerCombo.Text := '';
//  PONoEdit.Text := '';
  MatPorNoEdit.Text := '';
  MaterialCodeEdit.Text := '';
  MaterialNameEdit.Text := '';
  ClaimNoEdit.Text := '';
  WorkSummaryEdit.Text := '';
  EmailDescEdit.Text := '';
//  SubjectEdit.Text := '';
//  ClaimServiceKindCB.ItemIndex := -1;
  ClaimServiceKindCB.SetUnCheckedAll();// := -1;
  ClaimStatusCombo.ItemIndex := -1;

  OrderNoEdit.Text := '';
  ShippingNoEdit.Text := '';
  ComboBox1.ItemIndex := -1;
//  ProductTypeCombo.ItemIndex := -1;
  ClaimStatusCombo.ItemIndex := -1;

  CurWorkCB.ItemIndex := -1;
  BefAftCB.ItemIndex := -1;
//  PICCB.ItemIndex := -1;

  Category1.Tag := 0;
  Location1.Tag := 0;
  CauseKind1.Tag := 0;
  CauseHW1.Tag := 0;
  CauseSW1.Tag := 0;
end;

procedure THiconisAsManageF.Invoice4Click(Sender: TObject);
begin
  MakeInvoice(grid_Req.SelectedRow);
end;

procedure THiconisAsManageF.JvCaptionButton1Click(Sender: TObject);
begin
  if JvCaptionButton1.Down then
    JvCaptionButton1.ImageIndex := 48
  else
    JvCaptionButton1.ImageIndex := 47;

  if JvCaptionButton1.Down then
    FormStyle := fsStayOnTop
  else
    FormStyle := fsNormal;
end;

procedure THiconisAsManageF.KeyIn_CompanyCode;
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

procedure THiconisAsManageF.KeyIn_Content;
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

procedure THiconisAsManageF.KeyIn_RFQ;
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

function THiconisAsManageF.GetDeliveryDateBySelected: TDate;
var
  LHullNo: string;
begin
  if grid_Req.SelectedRow = -1 then
    exit;

  LHullNo := grid_Req.CellsByName['HullNo',grid_Req.SelectedRow];
  Result := TimelogToDatetime(GetDeliveryDateByHullNo(LHullNo));
end;

function THiconisAsManageF.GetDirectInputReqNoFromBySeleced: string;
var
  LId: TID;
  LMaterial4Project:TSQLMaterial4Project;
begin
  LId := GetTaskIdFromGridBySelected;

  LMaterial4Project := GetMaterial4ProjFromTaskID(LId);
  try
    Result := LMaterial4Project.DirectInputReqNo;
  finally
    LMaterial4Project.Free;
  end;
end;

function THiconisAsManageF.GetEmailSubjectFromGridBySelected: string;
var
  LId: TID;
  LOLEmailMsg:TSQLOLEmailMsg;
begin
  LId := GetTaskIdFromGridBySelected;

  LOLEmailMsg := GetSQLOLEmailMsgFromTaskID(LId);
  try
    Result := LOLEmailMsg.Subject;
  finally
    LOLEmailMsg.Free;
  end;
end;

procedure THiconisAsManageF.GetHullNoToClipboard1Click(Sender: TObject);
begin
  if grid_Req.SelectedRow = -1 then
    exit;

  Clipboard.AsText := grid_Req.CellsByName['HullNo',grid_Req.SelectedRow];
end;

function THiconisAsManageF.GetIDListNRowByHullNoNClaimNoFromGrid(AHullNo,
  AClaimNo: string; out AIdList: TIDList; out ARow: integer): Boolean;
var
  i: integer;
begin
  Result := False;
  AIdList := nil;

  for i := 0 to grid_Req.RowCount - 1 do
  begin
    if (grid_Req.CellsByName['HullNo', i] = AHullNo) and
      (grid_Req.CellsByName['ClaimNo', i] = AClaimNo) then
    begin
      AIdList := TIDList(grid_Req.Row[i].Data);
      ARow := i;

      Result := True;
    end;
  end;
end;

function THiconisAsManageF.GetIsRemote(var ARemoteAddr: string): Boolean;
begin
  Result := False;

//  if ARemoteAddr = '' then
//    ARemoteAddr := PICCB.Items.ValueFromIndex[PICCB.ItemIndex];

  if ARemoteAddr <> '' then
    Result := FMyIPAddress <> ARemoteAddr;

  if Result then
    StatusBarPro1.Panels[0].Text := 'Remote'
  else
    StatusBarPro1.Panels[0].Text := 'Local'
end;

procedure THiconisAsManageF.DisplayOLMsg2Grid(const task: IOmniTaskControl;
  const msg: TOmniMessage);
begin

end;

procedure THiconisAsManageF.About1Click(Sender: TObject);
begin
  FormAbout1.Show(False);
end;

procedure THiconisAsManageF.AddFolderListFromOL(AFolder: string);
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
    ShowMessage('������ Folder �̸��� ������ : ' + AFolder);
end;

procedure THiconisAsManageF.AeroButton1Click(Sender: TObject);
var
  LRow: integer;
begin
  if grid_Req.SelectedCount > 0 then
  begin
    if MessageDlg('������ Task��ToDo List ��  ��ȸ �ұ��?.' + #13#10 +
      '"No" �� �����ϸ� Grid�� ǥ�õ� ��� Task�� ���� ToDo List�� ��ȸ �մϴ�.' , mtConfirmation, [mbYes, mbNo],0) = mrNo then
      LRow := -1
    else
      LRow := grid_Req.SelectedRow;
  end
  else
    LRow := -1;

//  ShowTodoListFormFromData(LRow);
  ShowTodoListFormFromDBByGridRow(LRow);
end;

procedure THiconisAsManageF.ApplyConfigChanged;
begin
  LoadConfigFromFile;
end;

procedure THiconisAsManageF.AssignHull2RecFromForm(AHiASIniConfig: THiASIniConfig);
var
  LTaskID: TID;
begin
  AHiASIniConfig.FHullNo := grid_Req.CellsByName['HullNo',grid_Req.SelectedRow];
  AHiASIniConfig.FShipName := grid_Req.CellsByName['ShipName',grid_Req.SelectedRow];
  AHiASIniConfig.FProjNo := grid_Req.CellsByName['OrderNo',grid_Req.SelectedRow];
  AHiASIniConfig.FClaimNo := grid_Req.CellsByName['ClaimNo',grid_Req.SelectedRow];
  AHiASIniConfig.FSubject := grid_Req.CellsByName['Subject',grid_Req.SelectedRow];

//  LTaskID := TIDList(grid_Req.Row[grid_Req.SelectedRow].Data).TaskId;
//  AHiASIniConfig.FPrice := GetPriceFromDBByTaskID(LTaskID);
end;

procedure THiconisAsManageF.AsyncProcessCommandProc;
begin
  Parallel.Async(
    procedure (const task: IOmniTask)
    var
      i, LResult: integer;
      handles: array [0..1] of THandle;
      msg    : TOmniMessage;
      rec    : TOLMsgFileRecord;
      LOLRespondRec: TOLRespondRec;
      LEntryIdRecord: TEntryIdRecord;
      LOLMailRec: TOLMailRec;
      LOLObjRec: TOLObjectRec;
      LOmniValue: TOmniValue;
    begin
      handles[0] := FStopEvent.Handle;
      handles[1] := FTaskEditConfig.IPCMQCommandOLEmail.GetNewMessageEvent;

      while WaitForMultipleObjects(2, @handles, false, INFINITE) = (WAIT_OBJECT_0 + 1) do
      begin
        //FrameOLEmailList4Ole.TOutlookEmailListFr ���� OL Control ��û�� ����
        while FTaskEditConfig.IPCMQCommandOLEmail.TryDequeue(msg) do
        begin
          case TOLCommandKind(msg.MsgID) of
            olckInitVar,
            olckGetFolderList: begin
              FOLCmdSenderHandle := msg.MsgData.AsInteger;
              msg.MsgData.AsInteger := Self.Handle;
            end;
            olckAddObject: begin
              LOLObjRec := Msg.MsgData.ToRecord<TOLObjectRec>;
              //OLCommand ���� FormHandle ����
              FOLCmdSenderHandle := LOLObjRec.FSenderHandle;
              //OLWorker�κ��� ����� �ޱ� ���� FSenderHandle ����- MSG_RESULT
              LOLObjRec.FSenderHandle := Self.Handle;
              msg.MsgData := TOmniValue.FromRecord(LOLObjRec);
            end;
            olckMoveMail2Folder: begin
              LEntryIdRecord := Msg.MsgData.ToRecord<TEntryIdRecord>;
              FOLCmdSenderHandle := LEntryIdRecord.FSenderHandle;
              LEntryIdRecord.FSenderHandle := Self.Handle;
              msg.MsgData := TOmniValue.FromRecord(LEntryIdRecord);
            end;
            //FrameOLEmailList4Ole.DropEmptyTarget1Drop()���� ���� ��
            olckGetSelectedMailItemFromExplorer: begin
              LOLRespondRec := msg.MsgData.ToRecord<TOLRespondRec>;
              FOLCmdSenderHandle := LOLRespondRec.FSenderHandle;
              LOLRespondRec.FSenderHandle := Self.Handle;
              msg.MsgData := TOmniValue.FromRecord(LOLRespondRec);
            end;
            olckShowMailContents: ;
            olckShowObject: ;
            olckCreateMail: begin
              LOLMailRec := Msg.MsgData.ToRecord<TOLMailRec>;
              //OLCommand ���� FormHandle ����
              FOLCmdSenderHandle := LOLMailRec.FSenderHandle;
              //OLWorker�κ��� ����� �ޱ� ���� FSenderHandle ����- MSG_RESULT
              LOLMailRec.FSenderHandle := Self.Handle;
              msg.MsgData := TOmniValue.FromRecord(LOLMailRec);
            end;
            olcCheckExistClaimNoInDB: begin
            //FrameOLEmailList4Ole.grid_Email�� HullNo+ClaimNo�� HiconisASManageR.db3�� �����ϴ��� Check��
              LOLRespondRec := msg.MsgData.ToRecord<TOLRespondRec>;
              //OLCommand ���� FormHandle ����
              FOLCmdSenderHandle := LOLRespondRec.FSenderHandle;
              LOLRespondRec.FSenderHandle := Self.Handle;
              LOLRespondRec.FMsg := UpdateJsonAryIfClaimNoIsExistInDB(LOLRespondRec.FMsg);

              msg.MsgData := TOmniValue.FromRecord(LOLRespondRec);
            end;
          end;

          if not FCommandQueue.Enqueue(TOmniMessage.Create(msg.MsgID, msg.MsgData)) then
            raise System.SysUtils.Exception.Create('THiconisAsManageF.AsyncProcessCommandProc->Command queue is full!');

          task.Invoke(//Thread Synchronize�� ������
            procedure
            begin
            end
          );
        end;//while
      end;//while
    end,

    Parallel.TaskConfig.OnMessage(Self).OnTerminated(
      procedure
      begin
      end
    )
  );
end;

procedure THiconisAsManageF.BitBtn1Click(Sender: TObject);
begin
//  Content2Clipboard(HullNoEdit.Text);
  HullNoEdit.Text := RemoveSpace2String(HullNoEdit.Text);
  ClipboardCopyOrPaste2AdvEditBtn(HullNoEdit);
end;

procedure THiconisAsManageF.BitBtn2Click(Sender: TObject);
begin
//  Content2Clipboard(OrderNoEdit.Text);
  OrderNoEdit.Text := RemoveSpace2String(OrderNoEdit.Text);
  ClipboardCopyOrPaste2AdvEditBtn(OrderNoEdit);
end;

procedure THiconisAsManageF.BitBtn3Click(Sender: TObject);
begin
  ClipboardCopyOrPaste2AdvEditBtn(ClaimNoEdit);
end;

procedure THiconisAsManageF.BitBtn4Click(Sender: TObject);
begin
  ClipboardCopyOrPaste2AdvEditBtn(ShippingNoEdit);
end;

procedure THiconisAsManageF.BitBtn5Click(Sender: TObject);
begin
  ClipboardCopyOrPaste2AdvEditBtn(MatPORNoEdit);
end;

procedure THiconisAsManageF.BitBtn6Click(Sender: TObject);
begin
  ClipboardCopyOrPaste2AdvEditBtn(MaterialCodeEdit);
end;

procedure THiconisAsManageF.BitBtn7Click(Sender: TObject);
begin
  ClipboardCopyOrPaste2AdvEditBtn(MaterialNameEdit);
end;

procedure THiconisAsManageF.ShowToDoListFromCollect(AToDoCollect: TpjhToDoItemCollection);
begin
//  Create_ToDoList_Frm('', AToDoCollect, True,
//    nil, nil);//InsertOrUpdateToDoList2DB, DeleteToDoListFromDB);
end;

procedure THiconisAsManageF.ShowWarrantyExpireDate1Click(Sender: TObject);
begin
  ShowMessage('Delivery Date: ' + DateTimeToStr(GetDeliveryDateBySelected()) + #13#10 +
   'Warranty Expire: ' + DateTimeToStr(GetWarrantyExpireDateBySelected()) + #13#10 +
   'Warranty Period: ' + GetWarrantyPeriodBySelected());
end;

procedure THiconisAsManageF.ShowWarrantyExpireDate2Click(Sender: TObject);
var
  LHullNo: string;
begin
  LHullNo := HullNoEdit.Text;

  if LHullNo = '' then
    exit;

  ShowMessage('Delivery Date: ' + DateTimeToStr(TimelogToDatetime(GetDeliveryDateByHullNo(LHullNo))) + #13#10 +
   'Warranty Expire: ' + DateTimeToStr(TimelogToDatetime(CalcWarrantyExpireDateByHullNo(LHullNo))) + #13#10 +
   'Warranty Period: ' + GetWarrantyPeriodByHullNo(LHullNo));
end;

procedure THiconisAsManageF.StartOLControlWorker;
begin
  if not FTaskEditConfig.IsUseOLControlWorkerFromEmailList then
  begin
    FCommandQueue := TOmniMessageQueue.Create(1000);
    FResponseQueue := TOmniMessageQueue.Create(1000, false);
    FSendMsgQueue := TOmniMessageQueue.Create(1000);

    FOLControlWorker := TOLControlWorker.Create(FCommandQueue, FResponseQueue, FSendMsgQueue, Handle);

    FPJHTimerPool.AddOneShot(OnInitOutlookTimer,1000);
  end;
end;

procedure THiconisAsManageF.StopOLControlWorker;
begin
  if not FTaskEditConfig.IsUseOLControlWorkerFromEmailList then
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
end;

procedure THiconisAsManageF.ShowToDoListFormFromList(ATaskId: TID; AToDoList: TpjhToDoList);
begin
  Create_ToDoList_Frm2(ATaskId, AToDoList, FTaskEditConfig, True);
end;

procedure THiconisAsManageF.TaskTabChange(Sender: TObject);
var
  i : Integer;
  LTaskStatus, LStr: String;
begin
  with grid_Req do
  begin
    BeginUpdate;
    try
      LTaskStatus := g_SalesProcess.ToString(TaskTab.AdvOfficeTabs[TaskTab.ActiveTabIndex].Tag);
      if TaskTab.AdvOfficeTabs[TaskTab.ActiveTabIndex].Caption.Contains('���') then
      begin
        LStr := 'NextProcess';
      end
      else if TaskTab.AdvOfficeTabs[TaskTab.ActiveTabIndex].Caption.Contains('�Ϸ�') then
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

procedure THiconisAsManageF.TestRemoteTaskDetail;
begin

end;

procedure THiconisAsManageF.TestRemoteTaskList;
begin

end;

procedure THiconisAsManageF.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;

//  if FSettings.WSEnabled then
//    InitNetwork;

  FUserList.Add(GetMyName(g_MyEmailInfo.SmtpAddress)+'='+g_MyEmailInfo.SmtpAddress);
  FillInUserList;
//  PICCB.Items.Assign(FUserList);
//  PICCB.ItemIndex := -1;
end;

procedure THiconisAsManageF.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure THiconisAsManageF.btn_SearchClick(Sender: TObject);
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
//    LResult := SendReq2InqManagerServer_Http(LSearchCondRec.FRemoteIPAddress, FPortName, FRootName, CMD_REQ_TASK_LIST, LUtf8);
    LResult := MakeBase64ToUTF8(LResult);
    DisplayTaskInfo2GridFromJson(LResult);
  end
  else
    DisplayTaskInfo2Grid(LSearchCondRec, LIsRemote);
end;

procedure THiconisAsManageF.Button1Click(Sender: TObject);
begin
  InputValueClear;
end;

procedure THiconisAsManageF.Category1Click(Sender: TObject);
//var
//  LOrmHiconisASTask: TOrmHiconisASTask;
begin
  Category1.Tag := ShowCheckGrp4Claim(Ord(ctkCatetory), Category1.Tag);

//  LOrmHiconisASTask := GetTaskFromClaimCategory(Category1.Tag);
//  ShowMessage(IntToStr(LOrmHiconisASTask.ID));
end;

procedure THiconisAsManageF.CauseHW1Click(Sender: TObject);
begin
  CauseHW1.Tag := ShowCheckGrp4Claim(Ord(ctkCauseHW), CauseHW1.Tag);
end;

procedure THiconisAsManageF.CauseKind1Click(Sender: TObject);
begin
  CauseKind1.Tag := ShowCheckGrp4Claim(Ord(ctkCauseKind), CauseKind1.Tag);
end;

procedure THiconisAsManageF.CauseSW1Click(Sender: TObject);
begin
  CauseSW1.Tag := ShowCheckGrp4Claim(Ord(ctkCauseSW), CauseSW1.Tag);
end;

procedure THiconisAsManageF.CheckIfExistClaimInDBByXls(AXlsName: string);
var
  LUtf8: RawUtf8;
begin
  //IDocList.Json
  LUtf8 := GetClaimListJsonFromXls(AXlsName);

end;

procedure THiconisAsManageF.CheckIfexistclaiminDBbyxls1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    CheckIfExistClaimInDBByXls(OpenDialog1.FileName);
  end;
end;

procedure THiconisAsManageF.ComboBox1DropDown(Sender: TObject);
begin
  ComboBox1.Clear;
  g_QueryDateType.SetType2Combo(ComboBox1);
end;

constructor THiconisAsManageF.Create(AOwner: TComponent);
var
  i: integer;
  LStr: string;
begin
  inherited;

  SetCurrentDir(ExtractFilePath(Application.ExeName));
  DOC_DIR := ExtractFilePath(Application.ExeName) + '\db\files\';
  FFolderListFromOL := TStringList.Create;

  FEgg := TEasternEgg.Create('Reg', [ssCtrl], 'REGINFOAS', Self, OnEasterEgg);

  if FileExists('.\'+FOLDER_LIST_FILE_NAME) then
    FFolderListFromOL.LoadFromFile('.\'+FOLDER_LIST_FILE_NAME);

  FTempJsonList := TStringList.Create;
  FUserList := TStringList.Create;
  FToDoCollect := TpjhToDoItemCollection.Create(TpjhTodoItem);
  InitTaskTab;
  InitTaskEnum;
  ComboBox1DropDown(nil);
//  ComboBox1.ItemIndex := 1;
//  if FIniFileName = '' then
//    FIniFileName := ChangeFileExt(Application.ExeName, '.ini');

//  FSettings := TConfigSettings.create(FIniFileName);
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

procedure THiconisAsManageF.CreateClaimBySelected1Click(Sender: TObject);
begin
  CreateNewTaskBySelected();
end;

procedure THiconisAsManageF.CreateHttpServer4WS(APort,
  ATransmissionKey: string; aClient: TInterfacedClass;
  const aInterfaces: array of TGUID);
begin
//  if not Assigned(FRestServer) then
//  begin
//    // initialize a TObjectList-based database engine
//    FRestServer := TRestServerFullMemory.CreateWithOwnModel([]);
//    // register our Interface service on the server side
//    FRestServer.CreateMissingTables;
//    FServiceFactoryServer := FRestServer.ServiceDefine(aClient, aInterfaces , sicShared) as TServiceFactoryServer;  //sicClientDriven
//    FServiceFactoryServer.SetOptions([], [optExecLockedPerInterface]). // thread-safe fConnected[]
//      ByPassAuthentication := true;
//  end;
//
//  if not Assigned(FHTTPServer) then
//  begin
//    // launch the HTTP server
////    FPortName := APort;
//    FHTTPServer := TRestHttpServer.Create(APort, [FRestServer], '+' , useBidirSocket);
//    FHTTPServer.WebSocketsEnable(FRestServer, ATransmissionKey);
//    FIsServerActive := True;
//  end;
end;

procedure THiconisAsManageF.CreateNewTask(AJson: RawUtf8);
var
  LTask: TOrmHiconisASTask;
  LResult: integer;
//  LVar: variant;
begin
  LTask := TOrmHiconisASTask.Create;
  try
//    if AJson <> '' then
//      LVar := _JSON(AJson)
//    else
//      LVar := null;

    FHiASTaskEditFormDisplayed := True;
    LResult := FrmHiconisASTaskEdit.DisplayTaskInfo2EditForm(LTask, nil, AJson, FTaskEditConfig, FHiASIniConfig);
//    end
//    else
//      LResult := FrmHiconisASTaskEdit.ShowEditFormFromClaimReportVar(LTask, AJson);

  if LResult = mrOK then
  begin
    FHiASTaskEditFormDisplayed := False;

    if not LTask.IsUpdate then
      LoadTaskVar2Grid(LTask, grid_Req);
  end;
  finally
    LTask.Free;
  end;
end;

procedure THiconisAsManageF.CreateNewTask1Click(Sender: TObject);
begin
  CreateNewTask;
end;

procedure THiconisAsManageF.CreateNewTaskBySelected;
var
  LDoc: IDocDict;
  LRow: integer;
  LJson: RawUTF8;
begin
  LRow := grid_Req.SelectedRow;

  if LRow <> -1 then
  begin
    LDoc := DocDict('{}');

    LDoc.S['ShipName'] := grid_Req.CellsByName['ShipName', LRow];
    LDoc.S['HullNo'] := grid_Req.CellsByName['HullNo', LRow];
    LDoc.S['OrderNo'] := grid_Req.CellsByName['OrderNo', LRow];
//    LDoc.S['ClaimNo'] := grid_Req.CellsByName['ClaimNo', LRow];

    LJson := LDoc.Json;
    CreateNewTask(LJson);
  end;
end;

procedure THiconisAsManageF.DeleteTask1Click(Sender: TObject);
var
  LIdList: TIDList;
begin
  if grid_Req.SelectedRow = -1 then
    exit;

  if MessageDlg('������ Task�� ���� �ұ��?.' + #13#10 +
    'Task�� ���� ����� ����/����/���»�/���� �������� �Բ� ���� �˴ϴ�.' + #13#10 +
    '���� �Ŀ��� ������ �� �˴ϴ�..' , mtConfirmation, [mbYes, mbNo],0) = mrNo then
    exit;

  if grid_Req.Row[grid_Req.SelectedRow].Data <> nil then
  begin
    LIdList := TIDList(grid_Req.Row[grid_Req.SelectedRow].Data);
    DeleteTask(LIdList.TaskId);

    ShowMessage('Task ������ �Ϸ� �Ǿ����ϴ�.');

    btn_SearchClick(nil);
  end;
end;

destructor THiconisAsManageF.Destroy;
var
  i: integer;
begin
  for i := 0 to grid_Req.RowCount - 1 do
    TIDList(grid_Req.Row[i].Data).Free;

//  FSettings.Free;
  FreeAndNil(FToDoCollect);
  FFolderListFromOL.Free;
  FTempJsonList.Free;
  FUserList.Free;

  inherited;
end;

procedure THiconisAsManageF.DestroyHttpServer;
begin
//  if Assigned(FHTTPServer) then
//    FHTTPServer.Free;
//
//  if Assigned(FRestServer) then
//  begin
//    FRestServer.Free;
//  end;
//
//  if Assigned(FModel) then
//    FreeAndNil(FModel);
end;

procedure THiconisAsManageF.DisplayTask2GridByMaterialCode(
  const AMaterialCode: string);
var
  LMaterialDetail: TSQLMaterialDetail;
  LSQLGSTask: TOrmHiconisASTask;
begin
  LMaterialDetail := GetMaterialDetailByPorNoNMatCode('', AMaterialCode);
  try
    if LMaterialDetail.IsUpdate then
    begin
      LMaterialDetail.FillRewind;

      grid_Req.BeginUpdate;
      try
        grid_Req_ClearRows;

        while LMaterialDetail.FillOne do
        begin
          LSQLGSTask := GetLoadTask(LMaterialDetail.TaskID);
          try
            LoadTaskVar2Grid(LSQLGSTask, grid_Req);
          finally
            LSQLGSTask.Free;
          end;
        end;//while
      finally
        grid_Req.EndUpdate;
      end;
    end;
  finally
    LMaterialDetail.Free;
  end;
end;

procedure THiconisAsManageF.DisplayTask2GridByMaterialName(
  const AMaterialName: string);
var
  LMaterialDetail: TSQLMaterialDetail;
  LSQLGSTask: TOrmHiconisASTask;
begin
  LMaterialDetail := GetMaterialDetailByMatName(AMaterialName);
  try
    if LMaterialDetail.IsUpdate then
    begin
      LMaterialDetail.FillRewind;

      grid_Req.BeginUpdate;
      try
        grid_Req_ClearRows;

        while LMaterialDetail.FillOne do
        begin
          LSQLGSTask := GetLoadTask(LMaterialDetail.TaskID);
          try
            LoadTaskVar2Grid(LSQLGSTask, grid_Req);
          finally
            LSQLGSTask.Free;
          end;
        end;//while
      finally
        grid_Req.EndUpdate;
      end;
    end;
  finally
    LMaterialDetail.Free;
  end;
end;

procedure THiconisAsManageF.DisplayTask2GridByMatPorNo(const AMatPorNo: string);
var
  LMaterialDetail: TSQLMaterialDetail;
  LSQLGSTask: TOrmHiconisASTask;
begin
  LMaterialDetail := GetMaterialDetailFromIDNMatPorNo(0, AMatPorNo);
  try
    if LMaterialDetail.IsUpdate then
    begin
      LMaterialDetail.FillRewind;

      grid_Req.BeginUpdate;
      try
        grid_Req_ClearRows;

        while LMaterialDetail.FillOne do
        begin
          LSQLGSTask := GetLoadTask(LMaterialDetail.TaskID);
          try
            LoadTaskVar2Grid(LSQLGSTask, grid_Req);
          finally
            LSQLGSTask.Free;
          end;
        end;//while
      finally
        grid_Req.EndUpdate;
      end;
    end;
  finally
    LMaterialDetail.Free;
  end;
end;

procedure THiconisAsManageF.DisplayTask2GridByPorNo(const APorNo: string);
var
  LMaterial4Project: TSQLMaterial4Project;
  LSQLGSTask: TOrmHiconisASTask;
begin
  LMaterial4Project := GetMaterial4ProjFromTaskIDNPORNo(0, APorNo);
  try
    if LMaterial4Project.IsUpdate then
    begin
      LMaterial4Project.FillRewind;

      grid_Req.BeginUpdate;
      try
        grid_Req_ClearRows;

        while LMaterial4Project.FillOne do
        begin
          LSQLGSTask := GetLoadTask(LMaterial4Project.TaskID);
          try
            LoadTaskVar2Grid(LSQLGSTask, grid_Req);
          finally
            LSQLGSTask.Free;
          end;
        end;//while
      finally
        grid_Req.EndUpdate;
      end;
    end;
  finally
    LMaterial4Project.Free;
  end;
end;

procedure THiconisAsManageF.DisplayTaskInfo2Grid(ASearchCondRec: TSearchCondRec; AFromRemote: Boolean);
var
  ConstArray: TConstArray;
  LWhere, LWhere2, LStr: string;
  LSQLGSTask: TOrmHiconisASTask;
//  LSQLCustomer: TSQLCustomer;
  LUtf8: RawUTF8;
  LV: variant;
  LFrom, LTo: TTimeLog;
  LpjhBit32: TpjhBit32;
  i: integer;
  LIsCSKind: Boolean;
  Lary: TpjhArray<TID>;

  procedure _DisplayTask2Grid;
  var
    LHullNo: RawUtf8;
  begin
    try
      if AFromRemote then
      begin
        StatusBarPro1.Panels[0].Text := 'Remote';
        FTempJsonList.Clear;
        LUtf8 := MakeTaskList2JSONArray(LSQLGSTask);
        FTempJsonList.Text := UTF8ToString(LUtf8);
      end
      else
      begin
        StatusBarPro1.Panels[0].Text := 'Local';
        grid_Req.BeginUpdate;
        try
          grid_Req_ClearRows;

          while LSQLGSTask.FillOne do
            LoadTaskVar2Grid(LSQLGSTask, grid_Req);
        finally
          grid_Req.EndUpdate;
        end;
      end;

      LHullNo := LSQLGSTask.HullNo;
      LoadFooterFromVesselListDB2FormByHullNo(LHullNo);
    finally
      LSQLGSTask.Free;
    end;
  end;
begin
  LWhere := '';
  ConstArray := CreateConstArray([]);
  try
//    if ASearchCondRec.FPorNo <> '' then
//    begin
//      if MessageDlg('PorNo�� �˻��ϴ� ��� �ٸ� �˻� ������ ���� �˴ϴ�.' + #13#10 +
//        '�׷��� ���� �Ͻðڽ��ϱ�?' + #13#10 +
//        '"No" �� �����ϸ� PorNo ������ �����մϴ�.' , mtConfirmation, [mbYes, mbNo],0) = mrYes then
//      begin
//        DisplayTask2GridByPorNo(ASearchCondRec.FPorNo);
//        exit;
//      end;
//    end;

    if ASearchCondRec.FMatPorNo <> '' then
    begin
      if MessageDlg('MatPorNo�� �˻��ϴ� ��� �ٸ� �˻� ������ ���� �˴ϴ�.' + #13#10 +
        '�׷��� ���� �Ͻðڽ��ϱ�?' + #13#10 +
        '"No" �� �����ϸ� PorNo ������ �����մϴ�.' , mtConfirmation, [mbYes, mbNo],0) = mrYes then
      begin
        DisplayTask2GridByMatPorNo(ASearchCondRec.FMatPorNo);
        exit;
      end;
    end;

    if ASearchCondRec.FMaterialCode <> '' then
    begin
      if MessageDlg('�����ȣ�� �˻��ϴ� ��� �ٸ� �˻� ������ ���� �˴ϴ�.' + #13#10 +
        '�׷��� ���� �Ͻðڽ��ϱ�?' + #13#10 +
        '"No" �� �����ϸ� �����ȣ  ������ �����մϴ�.' , mtConfirmation, [mbYes, mbNo],0) = mrYes then
      begin
        DisplayTask2GridByMaterialCode(ASearchCondRec.FMaterialCode);
        exit;
      end;
    end;

    if ASearchCondRec.FMaterialName <> '' then
    begin
      if MessageDlg('��������� �˻��ϴ� ��� �ٸ� �˻� ������ ���� �˴ϴ�.' + #13#10 +
        '�׷��� ���� �Ͻðڽ��ϱ�?' + #13#10 +
        '"No" �� �����ϸ� ����� ������ �����մϴ�.' , mtConfirmation, [mbYes, mbNo],0) = mrYes then
      begin
        DisplayTask2GridByMaterialCode(ASearchCondRec.FMaterialCode);
        exit;
      end;
    end;

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
      if ASearchCondRec.FWorkKind = 0 then //�����۾�
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
      if ASearchCondRec.FBefAft = 1 then//����
        LWhere := LWhere + '< ?'
      else
      if ASearchCondRec.FBefAft = 2 then//����
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

//    ASearchCondRec.FCurWork := Ord(spFinal);
    //�Ϸ���� ���� ��� Task�� ������
//    AddConstArray(ConstArray, [ASearchCondRec.FCurWork]);

//    if LWhere <> '' then
//      LWhere := LWhere + ' and ';

    if ASearchCondRec.FClaimStatus > 0 then
    begin
      AddConstArray(ConstArray, [ASearchCondRec.FClaimStatus]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + ' ClaimStatus = ?';
    end
    else
    begin
      if not ASearchCondRec.FIncludeClosed then
      begin
        AddConstArray(ConstArray, [g_ClaimStatus.ToOrdinal(csClosed)]);
        if LWhere <> '' then
          LWhere := LWhere + ' and ';
        LWhere := LWhere + ' ClaimStatus <> ?'; //Closed Task ����
      end;
    end;

    if ASearchCondRec.FClaimServiceKind > 0 then
    begin
      LpjhBit32 := ASearchCondRec.FClaimServiceKind;

      for i := 0 to 31 do
      begin
        if LpjhBit32.Bit[i] then
        begin
          LIsCSKind := True;

          AddConstArray(ConstArray, [i]);//g_ClaimServiceKind

          if LWhere2 <> '' then
            LWhere2 := LWhere2 + ' or ';
          LWhere2 := LWhere2 + ' ClaimServiceKind = ?';
        end;
      end;//for

      if LWhere2 <> '' then
        LWhere2 := '(' + LWhere2 + ')';

      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + LWhere2;
    end;

    if ASearchCondRec.FClaimCatetory > 0 then
    begin
      AddConstArray(ConstArray, [ASearchCondRec.FClaimCatetory]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + ' (ClaimCategory & ?) <> 0 ';
    end;

    if ASearchCondRec.FClaimLocation > 0 then
    begin
      AddConstArray(ConstArray, [ASearchCondRec.FClaimLocation]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + ' (ClaimLocation & ?) <> 0 ';
    end;

    if ASearchCondRec.FClaimKind > 0 then
    begin
      AddConstArray(ConstArray, [ASearchCondRec.FClaimKind]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + ' (ClaimKind & ?) <> 0 ';
    end;

    if ASearchCondRec.FClaimCauseHW > 0 then
    begin
      AddConstArray(ConstArray, [ASearchCondRec.FClaimCauseHW]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + ' (ClaimCauseHW & ?) <> 0 ';
    end;

    if ASearchCondRec.FClaimCauseSW > 0 then
    begin
      AddConstArray(ConstArray, [ASearchCondRec.FClaimCauseSW]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + ' (ClaimCauseSW & ?) <> 0 ';
    end;

    if ASearchCondRec.FShippingNo <> '' then
    begin
      Lary := GetTaskIDAryFromMaterial4ProjByShippingNo(ASearchCondRec.FShippingNo);
      LWhere2 := '';

      for i := 0 to LAry.Count - 1 do
      begin
        AddConstArray(ConstArray, [LAry.ArrayData[i]]);

        if LWhere2 <> '' then
          LWhere2 := LWhere2 + ' or ';
        LWhere2 := LWhere2 + ' ID = ?';
      end;//for

      if LWhere2 <> '' then
      begin
        LWhere2 := '(' + LWhere2 + ')';

        if LWhere <> '' then
          LWhere := LWhere + ' and ';
        LWhere := LWhere + LWhere2;
      end;
    end;

    if ASearchCondRec.FWorkSummary <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ASearchCondRec.FWorkSummary+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + ' WorkSummary LIKE ? ';
    end;

    LSQLGSTask := TOrmHiconisASTask.CreateAndFillPrepare(g_ProjectDB.Orm, LWhere, ConstArray);
    _DisplayTask2Grid;
  finally
    FinalizeConstArray(ConstArray);
  end;
end;

procedure THiconisAsManageF.DisplayTaskInfo2GridFromJson(AJson: RawUTF8);
var
  LDocData: TDocVariantData;
  LVar: variant;
  i: integer;
  LSQLGSTask: TOrmHiconisASTask;
begin//AJson : [] Task �迭 ������
  LSQLGSTask := TOrmHiconisASTask.Create;
  try
    grid_Req_ClearRows;
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

procedure THiconisAsManageF.DropEmptyTarget1Drop(Sender: TObject;
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

    // OutLook���� Drag�� ��쿡�� LFileName = '' ��
    if LFileName = '' then
    begin
      // OutLook���� ÷�������� Drag ���� ���
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
    else// ������ Ž���⿡�� Drag ���� ��� LFileName�� Drag�� File Name�� ������
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

procedure THiconisAsManageF.DropTextTarget1Drop(Sender: TObject;
  ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
begin
  // Determine if we got our custom format.
  if (FOLEmail_DragDropText.HasData) then
  begin
//    FOLEmail_DragDropText.OLED;

    case FOLEmail_DragDropText.DataKind of
      1: begin
//        if ssCtrl in FOLEmail_DragDropText.OLED.FShiftState then
//        else
      end;
    end;
  end;
end;

procedure THiconisAsManageF.EditTariff1Click(Sender: TObject);
begin
  DisplayTariffEditF;
end;

procedure THiconisAsManageF.EmailButtonClick(Sender: TObject);
begin
  ShowEmailListFormFromData(grid_Req.SelectedRow);
end;

procedure THiconisAsManageF.ExecFunc(AFuncName: string);
begin
  if AFuncName <> '' then
    ExecMethod(AFuncName,[]);
end;

procedure THiconisAsManageF.ExecMethod(MethodName: string;
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

procedure THiconisAsManageF.ExecuteSearch(Key: Char);
begin
  if Key = Chr(VK_RETURN) then
    btn_SearchClick(nil);
end;

procedure THiconisAsManageF.ExportToExcel2Click(Sender: TObject);
begin
  NextGridToExcel(grid_Req);
end;

procedure THiconisAsManageF.FillInUserList;
var
  LStrList: TStrings;
begin
//  if FSettings.RemoteAuthEnabled then
//  begin
//    LStrList := GetUserListFromFile(ChangeFileExt(Application.ExeName, '.ips'));
//
//    if Assigned(LStrList) then
//    begin
//      try
//        FUserList.Assign(LStrList);
//      finally
//        LStrList.Free;
//      end;
//    end;
//  end
//  else
//    FUserList.Add(GetMyName(g_MyEmailInfo.SmtpAddress));
end;

procedure THiconisAsManageF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(FStopEvent) then
  begin
    FStopEvent.SetEvent;
    Sleep(100);
  end;
end;

procedure THiconisAsManageF.FormCreate(Sender: TObject);
var
  LPort: integer;
begin
  //SendCopyData4�Լ��� ����ϱ� ���� �ʱ�ȭ ��
  UnitCopyData.UnitCopyDataInit(Name, Handle);

  FProgMode := 0;
  SetCurrentDir(ExtractFilePath(Application.ExeName));
  (DataFormatAdapter2.DataFormat as TVirtualFileStreamDataFormat).OnGetStream := OnGetStream;

  FHiASIniFileName := ChangeFileExt(ExtractFileName(Application.ExeName), '.ini');
  FHiASIniConfig := THiASIniConfig.Create(FHiASIniFileName);
  FPJHTimerPool := TPJHTimerPool.Create(Self);
  FDBMsgQueue := TOmniMessageQueue.Create(1000);
  FTaskEditConfig.IPCMQCommandOLEmail := TOmniMessageQueue.Create(1000);
  FTaskEditConfig.IPCMQ2RespondOLEmail := TOmniMessageQueue.Create(1000);
  FTaskEditConfig.IPCMQCommandOLCalendar := FTaskEditConfig.IPCMQCommandOLEmail;
  FTaskEditConfig.IPCMQ2RespondOLCalendar := FTaskEditConfig.IPCMQ2RespondOLEmail;

  FHiASDI16RecallDict := Collections.NewKeyValue<String, THiASDI16RecallRec>;

  //FrameOLEmailList���� OLControlWorker �����ϴ� �� ����
  FTaskEditConfig.IsUseOLControlWorkerFromEmailList := False;

  if CheckOutLookInstalled then
    StartOLControlWorker()
  else
    ShowMessage('Outlook does not exists!');

  InitVesselMasterClient(GetSubFolderPath(ExtractFilePath(Application.ExeName), 'db') + 'VesselList.sqlite');

  InitEnum();
  Parallel.TaskConfig.OnMessage(WM_OLMSG_RESULT,DisplayOLMsg2Grid);
  FStopEvent := TEvent.Create;
  UnitHiconisMasterRecord.InitHiconisASClient(Application.ExeName);
  InitUserClient(Application.ExeName);
  InitClient4GSTariff(Application.ExeName);
  InitHiASMaterialCodeClient(Application.ExeName);
  InitHiASProjectClient(Application.ExeName);
  AsyncProcessCommandProc();
  rg_periodClick(nil);
  g_ExecuteFunction := ExecFunc;
  g_GSDocType.InitArrayRecord(R_GSDocType);

  LoadConfigFromFile();

  LoadHiASDIRecallDataFromFile();
end;

procedure THiconisAsManageF.FormDestroy(Sender: TObject);
begin
  FEgg.Free;
  FHiASIniConfig.Free;

  StopOLControlWorker();

  FPJHTimerPool.RemoveAll();
  FPJHTimerPool.Free;

  if FIsRunRestServer then
    DestroyHttpServer;

  if Assigned(FStopEvent) then
    FStopEvent.SetEvent;

  if Assigned(FDBMsgQueue) then
    FreeAndNil(FDBMsgQueue);

  if Assigned(FTaskEditConfig.IPCMQCommandOLEmail) then
    FreeAndNil(FTaskEditConfig.IPCMQCommandOLEmail);

  if Assigned(FTaskEditConfig.IPCMQ2RespondOLEmail) then
    FreeAndNil(FTaskEditConfig.IPCMQ2RespondOLEmail);

//  if Assigned(FTaskEditConfig.IPCMQCommandOLCalendar) then
//    FreeAndNil(FTaskEditConfig.IPCMQCommandOLCalendar);
//
//  if Assigned(FTaskEditConfig.IPCMQ2RespondOLCalendar) then
//    FreeAndNil(FTaskEditConfig.IPCMQ2RespondOLCalendar);

  if Assigned(FStopEvent) then
    FreeAndNil(FStopEvent);
end;

procedure THiconisAsManageF.ShowTaskFormFromDB(AIDList: TIDList; ARow: integer);
var
  LTask: TOrmHiconisASTask;
  LResult: integer;
begin
  LTask:= CreateOrGetLoadTask(AIDList.fTaskId);
  LTask.TaskID := LTask.ID;
  try
    FHiASTaskEditFormDisplayed := True;
    FTaskEditConfig.IsAllowUpdateHullNo2Grid := True;
    LResult := FrmHiconisASTaskEdit.DisplayTaskInfo2EditForm(LTask,nil,'', FTaskEditConfig, FHiASIniConfig);
    //Task Edit Form���� "����" ��ư�� ���� ���
    if LResult = mrOK then
    begin
      FHiASTaskEditFormDisplayed := False;
      LoadTaskVar2Grid(LTask, grid_Req, ARow);
      FTaskEditConfig.IsAllowUpdateHullNo2Grid := False;
    end;
  finally
    if Assigned(LTask) then
      FreeAndNil(LTask);
  end;
end;

procedure THiconisAsManageF.ShowTaskFormFromDB(ARow: integer);
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
//      LUtf8 := SendReq2InqManagerServer_Http(LIpAddr, FPortName, FRootName, CMD_REQ_TASK_DETAIL, LUtf8);
      LUtf8 := MakeBase64ToUTF8(LUtf8);
      ShowTaskFormFromJson(LUtf8);
    end
    else
      ShowTaskFormFromDB(LIdList,ARow);
  end;
end;

procedure THiconisAsManageF.ShowTaskFormFromGrid(ARow: integer);
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

procedure THiconisAsManageF.ShowTaskFormFromJson(AJson: RawUTF8);
var
  LV: variant;
begin
//  LV.Task, LV.Customer, LV.SubCon, LV.Material
  LV := _JSON(AJson);
  DisplayTaskInfo2EditFormFromVariant(LV, FRemoteIPAddress, FPortName, FRootName);
end;

procedure THiconisAsManageF.ShowTaskID1Click(Sender: TObject);
begin
  ShowTaskIDFromGrid;
end;

procedure THiconisAsManageF.ShowTaskIDFromGrid;
begin
  if grid_Req.SelectedRow = -1 then
    exit;

  ShowMessage(IntToStr(GetTaskIdFromGridBySelected));//LIdList.TaskId
end;

procedure THiconisAsManageF.ShowTodoListFormFromData(ARow: integer);
var
  LTask: TOrmHiconisASTask;
  LID : TID;
  i: integer;
begin
  if ARow = -1 then //Grid�� ��� Task������ TodoList ������
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

procedure THiconisAsManageF.ShowTodoListFormFromDBByGridRow(ARow: integer);
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
    FpjhToDoList := Collections.NewKeyValue<string,TpjhTodoItemRec>
  else
    FpjhToDoList.Clear;

  if ARow = -1 then //Grid�� ��� Task������ TodoList ������
  begin
    for i := 0 to grid_Req.RowCount - 1 do
    begin
      LID := GetTaskIdFromGrid(i);

      if LID = -1 then
        continue;

      _GetToDoListFromTask(LID);
    end;

    LID := -1;
  end
  else //ARow�� �ִ� Task�� Todo List�� ������
  begin
    LID := GetTaskIdFromGrid(ARow);
    _GetToDoListFromTask(LID);
  end;

  ShowToDoListFormFromList(LID, FpjhToDoList);
end;

function THiconisAsManageF.SaveCurrentTask2File(AFileName: string): string;
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

procedure THiconisAsManageF.SaveDB2File;
var
  LProjectModel: TOrmModel;
  LProjectDB: TSQLRestClientURI;
  LOrmTask: TOrmHiconisASTask;
  LUtf8: RawUtf8;
  LDBName: string;
begin
  if OpenDialog1.Execute then
  begin
    LDBName := OpenDialog1.FileName;
    LProjectModel:= CreateProjectModel;
    LProjectDB:= TSQLRestClientDB.Create(LProjectModel, CreateProjectModel,
      LDBName, TSQLRestServerDB);
    TSQLRestClientDB(LProjectDB).Server.CreateMissingTables;

    LOrmTask := TOrmHiconisASTask.CreateAndFillPrepare(g_ProjectDB.Orm, 'ID <> -1', []);
    try
//      LUtf8 := LOrmTask.GetJsonValues(true, true, soSelect);
      while LOrmTask.FillOne do
      begin
        LProjectDB.Add(LOrmTask, true);
      end;
    finally
      LOrmTask.Free;

      if Assigned(LProjectDB) then
        FreeAndNil(LProjectDB);

      if Assigned(LProjectModel) then
        FreeAndNil(LProjectModel);
    end;
  end;
end;

procedure THiconisAsManageF.SaveDBAs1Click(Sender: TObject);
begin
  SaveDB2File();
end;

procedure THiconisAsManageF.Select_DeliveryCondition;
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

procedure THiconisAsManageF.Select_EstimateType;
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

procedure THiconisAsManageF.Select_Money;
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

procedure THiconisAsManageF.Select_TermsOfPayment;
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

procedure THiconisAsManageF.SendCmd4CreateMail(AMailType: integer);
var
  LOLMailRec: TOLMailRec;
  LValue: TOmniValue;
  LMsgQ: TOmniMessageQueue;
  LMsg: string;
begin
  AssignHull2RecFromForm(FHiASIniConfig);

  if AMailType = 2 then //�����԰��û
  begin
    FHiASIniConfig.FText := GetDirectInputReqNoFromBySeleced();
    FHiASIniConfig.FSubject := GetEmailSubjectFromGridBySelected();
  end;

  LOLMailRec.Subject := GetEmailSubject(AMailType, FHiASIniConfig);
  LOLMailRec.Recipients := GetRecvEmailAddress(AMailType, FHiASIniConfig);
  LOLMailRec.To_ := GetRecvEmailAddress(AMailType, FHiASIniConfig);
  LOLMailRec.CC := GetCCEmailAddress(AMailType, FHiASIniConfig);
  LMsg := GetEmailBody(AMailType, FHiASIniConfig);
  LOLMailRec.HTMLBody := LMsg;
//  LOLMailRec.Body := GetEmailBody(AMailType, FHiASIniConfig);

  LOLMailRec.FSenderHandle := Handle;

  LValue := TOmniValue.FromRecord(LOLMailRec);
  LMsgQ := FTaskEditConfig.IPCMQCommandOLEmail;
  SendCmd2OmniMsgQ(Ord(olckCreateMail), LValue, LMsgQ);
end;

procedure THiconisAsManageF.SendReqOLEmailInfo;
begin
  SendReqOLEmailInfo_WS;
end;

procedure THiconisAsManageF.SendReqOLEmailInfo_CromisIPC;
begin

end;

procedure THiconisAsManageF.SendReqOLEmailInfo_WS;
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

function THiconisAsManageF.ServerExecuteFromClient(ACommand: RawUTF8): RawUTF8;
begin

end;

function THiconisAsManageF.SessionClosed(Sender: TRestServer;
  Session: TAuthSession; Ctxt: TRestServerURIContext): boolean;
begin

end;

function THiconisAsManageF.SessionCreate(Sender: TRestServer;
  Session: TAuthSession; Ctxt: TRestServerURIContext): boolean;
begin

end;

procedure THiconisAsManageF.SetConfig;
var
  LConfigF: THiASConfigF;
begin
  LConfigF := THiASConfigF.Create(Self);

  try
    LoadConfig2Form(LConfigF);

    if LConfigF.ShowModal = mrOK then
    begin
      LoadConfigForm2Object(LConfigF);
      FHiASIniConfig.Save();
      ApplyConfigChanged;
    end;
  finally
    LConfigF.Free;
  end;
end;

procedure THiconisAsManageF.SetDefaultFindCond;
begin

end;

procedure THiconisAsManageF.FindCondCBChange(Sender: TObject);
begin
  case THiASFindCondition(FindCondCB.ItemIndex) of
    hfcNull: SetDefaultFindCond;
    hfcInputToday: SetInputTodayCond;
    hfcInputReview: SetInputReviewCond;
    hfcUpdateToday: SetUpdateTodayCond;
  end;
end;

procedure THiconisAsManageF.SetInputReviewCond;
begin
  ComboBox1.ItemIndex := Ord(qdtClaimInputDate);
  rg_period.ItemIndex := 3;
  dt_begin.DateTime := GetNoonTimeOfTheDay(now-1);
  dt_end.DateTime := GetNoonTimeOfTheDay(now);
end;

procedure THiconisAsManageF.SetInputTodayCond;
begin
  ComboBox1.ItemIndex := Ord(qdtClaimInputDate);
  rg_period.ItemIndex := 3;
  dt_begin.DateTime := GetBeginTimeOfTheDay(now);
  dt_end.DateTime := GetEndTimeOfTheDay(now);
end;

procedure THiconisAsManageF.SetNetworkInfo(ARootName, APortName, AKeyName: string);
begin
  FRootName := ARootName;
  FPortName := APortName;
  FTransmissionKey := AkeyName;
end;

procedure THiconisAsManageF.SetUpdateTodayCond;
begin
  ComboBox1.ItemIndex := Ord(qdtModifyDate);
  rg_period.ItemIndex := 3;
  dt_begin.DateTime := GetBeginTimeOfTheDay(now);
  dt_end.DateTime := GetEndTimeOfTheDay(now);
end;

procedure THiconisAsManageF.SetUserNameNIPAddressFromRegServer;
var
  LList: string;
begin
//  LList := GetUserNameNIPListFromProductCode('','');
end;

procedure THiconisAsManageF.ShipNameEditKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteSearch(Key);
end;

procedure THiconisAsManageF.ShowDIRecallStatus1Click(Sender: TObject);
begin
  ShowDIRecallStatusBySelected();
end;

procedure THiconisAsManageF.ShowDIRecallStatusBySelected;
var
  LHullNo: string;
  LHiASDI16RecallRec: THiASDI16RecallRec;
begin
  if grid_Req.SelectedRow = -1 then
    exit;

  LHullNo := grid_Req.CellsByName['HullNo',grid_Req.SelectedRow];

  if FHiASDI16RecallDict.TryGetValue(LHullNo, LHiASDI16RecallRec) then
  begin
    ShowDiRecallStatusFromRec(LHiASDI16RecallRec);
  end
  else
    ShowMessage('DI Module Recall ��� ȣ���� �ƴմϴ�.');
end;

procedure THiconisAsManageF.ShowDiRecallStatusFromRec(ARec: THiASDI16RecallRec);
var
  LStr: string;
begin
  LStr := 'Hull No: ' + ARec.HullNo + #13#10 +
    '�ε�����: ' + ARec.VesselDeliveryDate + #13#10 +
    '���ּ���: ' + ARec.OrderQuantity + #13#10 +
    '�԰����: ' + ARec.NumOfWarehoused + #13#10 +
    '�������: ' + ARec.PartDeliveryDate2Customer;
  ShowMessage(LStr);
end;

procedure THiconisAsManageF.ShowEmailID1Click(Sender: TObject);
begin
  ShowEmailIDFromGrid;
end;

procedure THiconisAsManageF.ShowEmailIDFromGrid;
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

procedure THiconisAsManageF.ShowEmailListForm;
var
//  LViewMailListF: TOLEmailListF;
  LOLEmailSrchRec: TOLEmailSrchRec;
begin
//  LViewMailListF := TOLEmailListF.Create(nil);
  try
    FTaskEditConfig.IsAllowUpdateHullNo2Grid := False;
    LOLEmailSrchRec.FTaskEditConfig := FTaskEditConfig;

    LOLEmailSrchRec.fOwnerFormHandle := Self.Handle;
    LOLEmailSrchRec.FHiconisASManageMode := True;
    LOLEmailSrchRec.AutoMoveCBCheck := False;
    LOLEmailSrchRec.SaveToDBButtonEnable := False;
    LOLEmailSrchRec.CloseButtonEnable := False;

    FOLEmailListFormDisplayed := True;

    CreateNShowOLEmailListForm(LOLEmailSrchRec);

    ShowEmailListForm1.Enabled := False;

//    if LViewMailListF.ShowModal = mrOK then
//    begin
//    end;
  finally
//    FOLEmailListFormDisplayed := False;
//    LViewMailListF.Free;
  end;
end;

procedure THiconisAsManageF.ShowEmailListForm1Click(Sender: TObject);
begin
  ShowEmailListForm();
end;

procedure THiconisAsManageF.ShowEmailListFormFromData(ARow: integer);
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
    LOLEmailSrchRec.FTaskID := LTask.ID;
    LOLEmailSrchRec.FProjectNo := LTask.Order_No;
    LOLEmailSrchRec.FHullNo := RemoveSpace2String(LTask.HullNo);
    LOLEmailSrchRec.FClaimNo := RemoveSpace2String(LTask.ClaimNo);
    LOLEmailSrchRec.FTaskEditConfig := FTaskEditConfig;

    TTaskEditF.ShowEMailListFromTask(LTask, LOLEmailSrchRec, '', '', '');
  finally
    FreeAndNil(LTask);
  end;
end;

function THiconisAsManageF.ShowFileSelectForm: integer;
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

procedure THiconisAsManageF.ShowGSFileID1Click(Sender: TObject);
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

