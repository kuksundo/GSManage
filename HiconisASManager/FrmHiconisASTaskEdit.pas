unit FrmHiconisASTaskEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, ShellApi, Rtti,
  JvExControls, JvLabel, NxColumnClasses, NxColumns, NxScrollControl, ActiveX,
  NxCustomGridControl, NxCustomGrid, NxGrid, AeroButtons, CurvyControls,
  Vcl.ImgList, AdvGlowButton, Vcl.ExtCtrls, Vcl.Menus, Vcl.Mask, JvExMask,
  AdvEdit, AdvEdBtn, JvToolEdit, JvBaseEdits, Clipbrd, Generics.Collections,
  pjhComboBox, AdvToolBtn, Vcl.Buttons,
  DragDrop, DropTarget, DropSource, DragDropFile,
  mormot.core.base, mormot.core.variants, mormot.core.buffers, mormot.core.unicode,
  mormot.core.data, mormot.orm.base, mormot.core.os, mormot.core.text,
  mormot.core.datetime, mormot.core.rtti, mormot.core.collections,

  OtlCommon, OtlComm, OtlTaskControl, OtlContainerObserver, otlTask, OtlParallel,

  CommonData2, UnitMakeReport2, UnitGenericsStateMachine_pjh,//FSMClass_Dic, FSMState, UnitTodoCollect2,
  UnitHiconisMasterRecord,  UnitGSFileRecord2, FrmSubCompanyEdit2, FrmOLEmailList,//FrmEmailListView2
  FrmFileSelect, UnitGSFileData2, UnitOLDataType, UnitElecServiceData2, UnitOLEmailRecord2,
  UnitHiASSubConRecord, UnitHiASMaterialRecord, UnitHiASToDoRecord, UnitToDoList,
  UnitHiASMaterialDetailRecord, FrmASMaterialDetailEdit, FrmASMaterialEdit,
  UnitMacroListClass2, UnitHiconisASData, UnitHiASIniConfig, UnitOutLookDataType
  ;

type
  THiconisASStateMachine = TStateMachine<THiconisASState, THiconisASTrigger>;

  TTaskEditF = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    CustomerAddressMemo: TMemo;
    CurvyPanel1: TCurvyPanel;
    btn_Close: TAeroButton;
    AeroButton1: TAeroButton;
    SelectMailBtn: TAeroButton;
    CancelMailSelectBtn: TAeroButton;
    ImageList16x16: TImageList;
    AeroButton4: TAeroButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    Quotation1: TMenuItem;
    PO1: TMenuItem;
    Invoice1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    TabSheet3: TTabSheet;
    JvLabel13: TJvLabel;
    Panel3: TPanel;
    Panel2: TPanel;
    AdvGlowButton6: TAdvGlowButton;
    AdvGlowButton5: TAdvGlowButton;
    fileGrid: TNextGrid;
    NxIncrementColumn3: TNxIncrementColumn;
    FileName: TNxTextColumn;
    FileSize: TNxTextColumn;
    FilePath: TNxTextColumn;
    DocType: TNxTextColumn;
    JvLabel12: TJvLabel;
    TabSheet4: TTabSheet;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    JvLabel20: TJvLabel;
    JvLabel21: TJvLabel;
    CustCompanyCodeEdit: TEdit;
    JvLabel22: TJvLabel;
    CustManagerEdit: TEdit;
    JvLabel24: TJvLabel;
    CustEmailEdit: TEdit;
    TabSheet5: TTabSheet;
    CustAgentMemo: TMemo;
    JvLabel34: TJvLabel;
    JvLabel36: TJvLabel;
    WorkBeginPicker: TDateTimePicker;
    JvLabel37: TJvLabel;
    WorkEndPicker: TDateTimePicker;
    Label2: TLabel;
    JvLabel38: TJvLabel;
    EtcContentMemo: TMemo;
    JvLabel39: TJvLabel;
    CurWorkCB: TComboBox;
    JvLabel40: TJvLabel;
    JvLabel41: TJvLabel;
    CustCompanyTypeCB: TComboBox;
    JvLabel44: TJvLabel;
    CustPhonNumEdit: TEdit;
    JvLabel45: TJvLabel;
    CustFaxEdit: TEdit;
    CustPositionEdit: TEdit;
    JvLabel47: TJvLabel;
    DropEmptyTarget1: TDropEmptyTarget;
    DataFormatAdapterTarget: TDataFormatAdapter;
    DataFormatAdapter1: TDataFormatAdapter;
    Imglist16x16: TImageList;
    ServiceOrder1: TMenuItem;
    oCustomer1: TMenuItem;
    Korean1: TMenuItem;
    English1: TMenuItem;
    Korean2: TMenuItem;
    English2: TMenuItem;
    Korean3: TMenuItem;
    N14: TMenuItem;
    Commercial1: TMenuItem;
    N15: TMenuItem;
    JvLabel51: TJvLabel;
    CurWorkFinishPicker: TDateTimePicker;
    DataFormatAdapter2: TDataFormatAdapter;
    DropEmptySource1: TDropEmptySource;
    JvLabel55: TJvLabel;
    NationEdit: TEdit;
    TabSheet6: TTabSheet;
    JvLabel56: TJvLabel;
    SalesReqPicker: TDateTimePicker;
    JvLabel58: TJvLabel;
    ShippingDatePicker: TDateTimePicker;
    JvLabel59: TJvLabel;
    JvLabel60: TJvLabel;
    ExchangeRateEdit: TEdit;
    JvLabel61: TJvLabel;
    CurrencyKindCB: TComboBox;
    N16: TMenuItem;
    SalesPriceEdit: TJvCalcEdit;
    JvLabel62: TJvLabel;
    NextWorkCB: TComboBox;
    Button1: TButton;
    Button2: TButton;
    CustomerNameCB: TComboBoxInc;
    Button3: TButton;
    MAPS1: TMenuItem;
    INQInput1: TMenuItem;
    Mail1: TMenuItem;
    Reply1: TMenuItem;
    N17: TMenuItem;
    JvLabel63: TJvLabel;
    DeliveryConditionCB: TComboBox;
    JvLabel64: TJvLabel;
    EstimateTypeCB: TComboBox;
    JvLabel65: TJvLabel;
    TermsPaymentCB: TComboBox;
    JvLabel66: TJvLabel;
    BaseProjectNoEdit: TEdit;
    JvLabel67: TJvLabel;
    ChargeInPersonIdEdit: TEdit;
    Create1: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    PO2: TMenuItem;
    Invoice2: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    SubConTS: TTabSheet;
    Panel1: TPanel;
    AeroButton2: TAeroButton;
    AeroButton3: TAeroButton;
    SubConGrid: TNextGrid;
    NxIncrementColumn1: TNxIncrementColumn;
    OfficePhone: TNxTextColumn;
    MobilePhone: TNxTextColumn;
    EMail: TNxTextColumn;
    Splitter1: TSplitter;
    CompanyCode: TNxTextColumn;
    ServicePO: TNxTextColumn;
    ManagerName: TNxTextColumn;
    Position: TNxTextColumn;
    CompanyAddress: TNxTextColumn;
    Nation: TNxTextColumn;
    CompanyTypes: TNxTextColumn;
    TaskID: TNxTextColumn;
    FirstName: TNxTextColumn;
    Surname: TNxTextColumn;
    SECount: TNxTextColumn;
    SubConPrice: TNxTextColumn;
    CompanyName: TNxTextColumn;
    RowID: TNxTextColumn;
    InvoiceItems: TNxMemoColumn;
    UniqueSubConID: TNxTextColumn;
    InvoiceFiles: TNxMemoColumn;
    SubConInvoiceNo: TNxTextColumn;
    Action: TNxTextColumn;
    DataFormatAdapter3: TDataFormatAdapter;
    PopupMenu2: TPopupMenu;
    SaveCompanyinfoashgs1: TMenuItem;
    SaveDialog1: TSaveDialog;
    ManagerDepartmentEdit: TEdit;
    BusinessAreas: TNxTextColumn;
    ElecProductDetailTypes: TNxTextColumn;
    ShipProductTypes: TNxTextColumn;
    Engine2SProductTypes: TNxTextColumn;
    Engine4SProductTypes: TNxTextColumn;
    ElecProductTypes: TNxTextColumn;
    PopupMenu3: TPopupMenu;
    Saveas1: TMenuItem;
    CurvyPanel2: TCurvyPanel;
    JvLabel15: TJvLabel;
    ServiceChargeCB: TComboBox;
    JvLabel14: TJvLabel;
    Panel4: TPanel;
    JvLabel1: TJvLabel;
    ProductTypeCB: TComboBox;
    JvLabel7: TJvLabel;
    JvLabel6: TJvLabel;
    ClaimNoEdit: TEdit;
    JvLabel5: TJvLabel;
    PONoEdit: TEdit;
    Panel5: TPanel;
    JvLabel3: TJvLabel;
    HullNoEdit: TAdvEditBtn;
    JvLabel4: TJvLabel;
    ShipNameEdit: TEdit;
    JvLabel31: TJvLabel;
    WorkSummaryEdit: TEdit;
    JvLabel49: TJvLabel;
    ShipOwnerEdit: TEdit;
    JvLabel30: TJvLabel;
    NationPortEdit: TEdit;
    JvLabel2: TJvLabel;
    AttendSchedulePicker: TDateTimePicker;
    JvLabel10: TJvLabel;
    ClaimRecvPicker: TDateTimePicker;
    JvLabel50: TJvLabel;
    ClaimInputPicker: TDateTimePicker;
    JvLabel9: TJvLabel;
    ClaimReadyPicker: TDateTimePicker;
    JvLabel8: TJvLabel;
    ClaimClosedPicker: TDateTimePicker;
    JvLabel11: TJvLabel;
    JvLabel16: TJvLabel;
    ClaimReasonMemo: TMemo;
    ImportanceCB: TComboBox;
    Panel6: TPanel;
    AeroButton5: TAeroButton;
    DeleteMaterialBtn: TAeroButton;
    SalesProcTypeCB: TComboBox;
    ClaimServiceKindCB: TComboBox;
    CompanyName2: TNxTextColumn;
    JvLabel17: TJvLabel;
    ClaimStatusCombo: TComboBox;
    MaterialGrid: TNextGrid;
    PORNo: TNxTextColumn;
    MaterialName: TNxTextColumn;
    LeadTime: TNxTextColumn;
    NeedCount: TNxTextColumn;
    UnitPrice: TNxTextColumn;
    NeedDate: TNxDateColumn;
    NxTextColumn5: TNxTextColumn;
    AeroButton7: TAeroButton;
    MaterialCode: TNxTextColumn;
    JvLabel18: TJvLabel;
    PORNoEdit: TEdit;
    ClaimPopup: TPopupMenu;
    Category1: TMenuItem;
    Location1: TMenuItem;
    CauseKind1: TMenuItem;
    CauseHW1: TMenuItem;
    CauseSW1: TMenuItem;
    MakeCertButton: TAdvToolButton;
    MaterialPopup: TPopupMenu;
    DeleteMaterial1: TMenuItem;
    CreateDate: TNxDateColumn;
    AeroButton6: TAeroButton;
    AeroButton8: TAeroButton;
    Button4: TButton;
    OrderNoEdit: TAdvEditBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    IsReclaim: TNxCheckBoxColumn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    PopupMenu4: TPopupMenu;
    Claim1: TMenuItem;
    N25: TMenuItem;
    HullNoClaimNo1: TMenuItem;
    PopupMenu5: TPopupMenu;
    N26: TMenuItem;
    PlateNo: TNxTextColumn;
    ID: TNxTextColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AeroButton1Click(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure SelectMailBtnClick(Sender: TObject);
    procedure CancelMailSelectBtnClick(Sender: TObject);
    procedure fileGridCellDblClick(Sender: TObject; ACol, ARow: Integer);
    procedure AdvGlowButton5Click(Sender: TObject);
    procedure AeroButton4Click(Sender: TObject);
    procedure CurWorkCBDropDown(Sender: TObject);
    procedure ProductTypeCBDropDown(Sender: TObject);
    procedure SalesProcTypeCBDropDown(Sender: TObject);
    procedure AdvGlowButton6Click(Sender: TObject);
    procedure DropEmptyTarget1Drop(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
    procedure DropEmptyTarget1Drop2(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
    procedure oCustomer1Click(Sender: TObject);
    procedure English2Click(Sender: TObject);
    procedure ServiceOrder1Click(Sender: TObject);
    procedure fileGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N3Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure INQInput1Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure AeroButton2Click(Sender: TObject);
    procedure SubConGridCellDblClick(Sender: TObject; ACol, ARow: Integer);
    procedure AeroButton3Click(Sender: TObject);
    procedure SubConGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SaveCompanyinfoashgs1Click(Sender: TObject);
    procedure JvLabel5Click(Sender: TObject);
    procedure HullNoEditClickBtn(Sender: TObject);
    procedure Saveas1Click(Sender: TObject);
    procedure CurWorkCBChange(Sender: TObject);
    procedure ServiceChargeCBDropDown(Sender: TObject);
    procedure NextWorkCBDropDown(Sender: TObject);
    procedure AeroButton5Click(Sender: TObject);
    procedure DeleteMaterialBtnClick(Sender: TObject);
    procedure ClaimServiceKindCBChange(Sender: TObject);
    procedure NextGrid1CellDblClick(Sender: TObject; ACol, ARow: Integer);
    procedure AeroButton7Click(Sender: TObject);
    procedure Category1Click(Sender: TObject);
    procedure Location1Click(Sender: TObject);
    procedure CauseKind1Click(Sender: TObject);
    procedure CauseHW1Click(Sender: TObject);
    procedure CauseSW1Click(Sender: TObject);
    procedure DeleteMaterial1Click(Sender: TObject);
    procedure AeroButton8Click(Sender: TObject);
    procedure AeroButton8MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AeroButton6MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button4Click(Sender: TObject);
    procedure OrderNoEditClickBtn(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Claim1Click(Sender: TObject);
    procedure HullNoClaimNo1Click(Sender: TObject);
    procedure N26Click(Sender: TObject);
  private
    FTaskJson,
    FMatDeliveryInfoJson //자재 배송 정보 저장(Json)
    : String;
    FpjhToDoList: TpjhToDoList;

    procedure InitEnum;
    procedure InitCB;
    procedure InitCurWorkCB();
    procedure InitNextWorkCB();
    function GetFileFromDropDataFormat(AFormat: TVirtualFileStreamDataFormat): TFileStream;

    function Get_Doc_Qtn_Rec: Doc_Qtn_Rec;
    function Get_Doc_Inv_Rec: Doc_Invoice_Rec;
    function Get_Doc_ServiceOrder_Rec(AIdx: integer = 0): Doc_ServiceOrder_Rec;
    function Get_Doc_Cust_Reg_Rec: Doc_Cust_Reg_Rec;

    function GetQTN_InqContent: string;

    function CheckDocCompanySelection(ASOR: Doc_ServiceOrder_Rec): boolean;

    procedure OnGetStream(Sender: TFileContentsStreamOnDemandClipboardFormat;
      Index: integer; out AStream: IStream);
    procedure OnGetStream2(Sender: TFileContentsStreamOnDemandClipboardFormat;
      Index: integer; out AStream: IStream);
    function SaveCurrentTaskAndSelectedSubCon2File(ASubConID: TID) : string;
    function MakeCompanyInfoFromGrid2JSON : string;

    procedure SQLGSFileRec2Grid(ARec: TSQLGSFileRec; AGrid: TNextGrid);
    procedure SQLGSFileCopy(ASrc: TSQLGSFile; out ADest: TSQLGSFile);

    procedure SaveCustomer2MasterCustomer(AMCustomer: TSQLMasterCustomer);
    procedure SaveCustEdit2MasterCustomer;

    procedure SubContractorAdd;
    procedure MaterialEdit();
    procedure MaterialDetailEdit(const ARow: integer=-1);
    function GetNextSalesProcess2String(ASalesProcess: string): string;
    procedure AddOrUpdateMaterial2GridFromVar(ADoc: Variant; const ARow: integer);
    procedure AddOrUpdateMaterialDetail2GridFromVar(ADoc: Variant; const ARow: integer);

    procedure LoadMaterialDetailVar2Grid(AVar: variant; ARow: integer=-1);
    procedure LoadMaterialDetailVarFromGrid(var AVar: variant; const ARow: integer=-1);
    procedure LoadMaterialDetailOrm2Form(AMaterialDetail: TSQLMaterialDetail);
    procedure LoadMaterialDetailOrmFromForm(AMaterialDetail: TSQLMaterialDetail);

    function GetPorNoFromJson(const AJson: string): string;
    procedure ExecMacro_ClaimRegister();
  public
    FTask,
    FEmailDisplayTask: TOrmHiconisASTask;
    FTaskEditConfig: THiconisASTaskEditConfig;
    FSQLGSFiles: TSQLGSFile;
    FFSMState: THiconisASStateMachine;
    FOLMessagesFromDrop,
    //현재 Task의 작업순서 List
    FSalesProcessList: TStringList;
    FFileContent: RawByteString;
//    FToDoCollect: TpjhToDoItemCollection;
    FToDoList: TpjhToDoList;
    FRemoteIPAddress: string;
    FHiASIniConfig: THiASIniConfig;

    class procedure ShowEMailListFromTask(ATask: TOrmHiconisASTask; AOLEmailSrchRec: TOLEmailSrchRec; ARemoteIPAddress, APort, ARoot: string);
    class procedure LoadEmailListFromTask(ATask: TOrmHiconisASTask; AForm: TOLEmailListF);
    procedure ShowDTIForm;
    procedure SPType2Combo(ACombo: TComboBox; AFSMState: THiconisASStateMachine=nil);
    //Drag하여 파일 추가한 경우 AFileName <> ''
    //Drag를 윈도우 탐색기에서 하면 AFromOutLook=Fase,
    //Outlook 첨부 파일에서 하면 AFromOutLook=True임
    procedure ShowFileSelectF(AFileName: string = ''; AFromOutLook: Boolean = False);
    procedure ShowFileSelectF2(AFileName: string = ''; AFromOutLook: Boolean = False);

    procedure LoadCustomerFromCompanycode(ACompanyCode: string);
//    procedure LoadCustomer2

    procedure LoadTaskOrm2Form(AVar: TOrmHiconisASTask; AForm: TTaskEditF);
    procedure LoadTaskForm2TaskOrm(AForm: TTaskEditF; out AVar: TOrmHiconisASTask);
    procedure LoadTaskForm2Variant(AForm: TTaskEditF; out AVar: Variant);
    procedure LoadTaskFormFromVariant(AForm: TTaskEditF; const AVar: Variant);

    procedure LoadMaterialGrid2Variant(AGrid: TNextGrid; out AVar: Variant);
    procedure LoadMaterialGridFromVariant(AGrid: TNextGrid; const AVar: Variant);
    procedure LoadMatGridRow2MaterialDetailOrm(AGrid: TNextGrid; ARow: integer; AOrm: TSQLMaterialDetail);

    procedure LoadTaskEditForm2Grid(AEditForm: TTaskEditF; AGrid: TNextGrid;
      ARow: integer);
    procedure LoadGrid2TaskEditForm(AGrid: TNextGrid; ARow: integer;
      AEditForm: TTaskEditF);

    procedure ShowSubConEditFormFromSubConGrid(ARow: integer);

    procedure LoadGSFiles2Form(AGSFile: TSQLGSFile; AForm: TTaskEditF);
    procedure LoadGSFile2Form(AGSFile: TSQLGSFile; AForm: TTaskEditF);
    procedure LoadTaskForm2GSFiles(AForm: TTaskEditF; out AGSFile: TSQLGSFile);
    procedure LoadCustomer2Form(ACustomer: TSQLCustomer; AForm: TTaskEditF);
    procedure LoadTaskForm2Customer(AForm: TTaskEditF; ACustomer: TSQLCustomer;
      ATaskID: TID = 0);
    procedure LoadTaskForm2MasterCustomer(AForm: TTaskEditF; var ACustomer: TSQLMasterCustomer;
      ATaskID: TID);
    procedure LoadSubCon2Form(ASubCon: TSQLSubCon; AForm: TTaskEditF; ARow: integer = -1);
    procedure LoadSubConList2Form(ASubConList: TObjectList<TSQLSubCon>; AForm: TTaskEditF);
    //InvoiceManager로 부터 Drag-Drop하여 ADoc을 입력 받음
    procedure LoadSubConFromVariant2Form(ADoc: variant; ADocIsFromInvoiceManage: Boolean;
      ADocIsFromRemote: Boolean = false);
    procedure SaveSubConFromForm(AForm: TTaskEditF; ATaskID: TID = 0);
    procedure LoadSubConGrid2Var(ARow: integer; var ADoc: variant);

    procedure LoadMaterial4Project2Form(AMaterial: TSQLMaterial4Project; AForm: TASMaterialF);
    procedure LoadTaskForm2Material4Project(AForm: TTaskEditF;
      AMaterial: TSQLMaterial4Project; ARow: integer);
    procedure LoadTaskForm2MaterialDetailNSave2DB(AForm: TTaskEditF; ATaskID: TID = 0);
    procedure LoadTaskForm2Material4ProjectNSave2DB(ATaskID: TID);

    procedure LoadMaterial2Form(AMaterial: TSQLMaterial4Project; AForm: TTaskEditF);
    procedure LoadTaskForm2Material(AForm: TTaskEditF;
      AMaterial: TSQLMaterial4Project; ARow: integer);
    procedure LoadTaskForm2MaterialNSave2DB(AForm: TTaskEditF; ATaskID: TID = 0);

    //HiconisASTask를 DB에 저장 할려면 반드시 HullNo/ProjectNo/ClaimNo가 있어야 함
    function CheckTaskDBKeyFromForm(): Boolean;

    procedure SendCmd4CreateMail(AMailType: integer);
    procedure SetHiASIniConfig(var AHiASIniConfig: THiASIniConfig);
  end;

  function ProcessTaskJson(AJson: String): Boolean;
  function DisplayTaskInfo2EditForm(var ATask: TOrmHiconisASTask;
      ASQLEmailMsg: TSQLOLEmailMsg; AJson: RawUtf8; ATaskEditConfig: THiconisASTaskEditConfig;
      var AHiASIniConfig: THiASIniConfig): integer;
  function DisplayTaskInfo2EditFormFromVariant(ADoc: variant;
    ARemoteIPAddress, APort, ARoot: string): Boolean;

  //Manager Form에서 Claim Report.xls를 Drop 했을때 실행
  function ShowEditFormFromClaimReportVar(ATask: TOrmHiconisASTask; AJson: RawUtf8): integer;

var
//  TaskEditF: TTaskEditF;
  g_RemoteIPAddress: string;

implementation

uses FrmHiconisASManage, DragDropInternet, DragDropFormats,
  UnitHiconisASVarJsonUtil, UnitNextGridUtil2, UnitEnumHelper2,
  FrmSearchCustomer2, UnitDragUtil, UnitStringUtil,//UnitIPCModule2, FrmTodoList,
  DateUtils, UnitBase64Util2, FrmSearchVessel2, UnitRttiUtil2,//UnitCmdExecService,
  UnitElecMasterData, UnitOutlookUtil2, UnitStateMachineUtil, UnitCommonFormUtil,
  UnitKeyBdUtil, UnitHiASUtil, UnitHiASOLUtil, UnitIPCMsgQUtil,
  FrmToDoList2, UnitVesselMasterRecord2, UnitClipBoardUtil, UnitAdvCompUtil;

{$R *.dfm}

function ProcessTaskJson(AJson: String): Boolean;
var
  LDoc: variant;
  LTask: TOrmHiconisASTask;
  LTaskEditConfig: THiconisASTaskEditConfig;
  LUTF8: RawUTF8;
  LRaw: RawByteString;
  LHullNo, LPONO, LOrderNo: string;
  LIsFromInvoiceManage: Boolean;
begin
  TDocVariant.New(LDoc);
  LRaw := Base64ToBin(StringToUTF8(AJson));
  LRaw := SynLZDecompress(LRaw);
  LUTF8 := LRaw;
  LDoc := _JSON(LUTF8);

  try
    Result := LDoc.TaskJsonDragSign = TASK_JSON_DRAG_SIGNATURE;
  except
  end;

  if not Result then
  begin
    //InvoiceManage.exe에서 만들어진 *.hgs 파일인 경우
    try
      Result := LDoc.InvoiceTaskJsonDragSign = INVOICETASK_JSON_DRAG_SIGNATURE;
    except
    end;
  end;

  if Result then
  begin
    LIsFromInvoiceManage := LDoc.InvoiceTaskJsonDragSign = INVOICETASK_JSON_DRAG_SIGNATURE;

    LHullNo := LDoc.Task.HullNo;

    try
      LOrderNo := LDoc.Task.Order_No;
    except
      LOrderNo := '';
    end;

    if LOrderNo = '' then
    begin
      try
        LPONO := LDoc.Task.PO_No;
      except
        LPONO := '';
      end;

      LTask := GetTaskFromHullNoNPONo(LHullNo, LPONO);
    end
    else
    begin
     LTask :=  GetTaskFromHullNoNOrderNo(LHullNo, LOrderNo);
    end;

    try
//      FrmHiconisASTaskEdit.DisplayTaskInfo2EditForm(LTask, nil, LDoc, LTaskEditConfig,FrmHiconisASTaskEdit.FHiASIniConfig);
    finally
      FreeAndNil(LTask);
    end;
  end
  else
    ShowMessage('Signature is not correct');
end;

function DisplayTaskInfo2EditForm(var ATask: TOrmHiconisASTask;
  ASQLEmailMsg: TSQLOLEmailMsg; AJson: RawUtf8; ATaskEditConfig: THiconisASTaskEditConfig;
  var AHiASIniConfig: THiASIniConfig): integer;
var
  LTaskEditF: TTaskEditF;
  LCustomer: TSQLCustomer;
//  LSubCon: TSQLSubCon;
  LMat4Proj: TSQLMaterial4Project;
  LMatDetail: TSQLMaterialDetail;
  LTask: TOrmHiconisASTask;
  LFiles: TSQLGSFile;
//  LTaskIds: TIDDynArray;
  LSubConList: TObjectList<TSQLSubCon>;
  i: integer;
  LID: TID;
  LVar: variant;
  LDoc: IDocDict;
begin
  Result := -1;
  LVar := null;

  LTaskEditF := TTaskEditF.Create(nil);
  try
    with LTaskEditF do
    begin
      RecordCopy(FTaskEditConfig, ATaskEditConfig, TypeInfo(THiconisASTaskEditConfig));
      SetHiASIniConfig(AHiASIniConfig);

      FTask := ATask;

      if FTask.IsUpdate then
      begin
        Caption := Caption + ' (Update)';

        if AJson = '' then
          LVar := null
        else
          LVar := _JSON(AJson);

        LoadTaskOrm2Form(FTask, LTaskEditF);
        LCustomer := GetCustomerFromTask(FTask);

        if (not ATaskEditConfig.IsDocFromInvoiceManage) and (LVar <> null) then
          LoadCustomerFromVariant(LCustomer, LVar.Customer);

        LoadCustomer2Form(LCustomer, LTaskEditF);

        LSubConList := TObjectList<TSQLSubCon>.Create;
        try
          GetSubConFromTaskIDWithInvoiceItems(FTask.ID, LSubConList);
          LoadSubConList2Form(LSubConList, LTaskEditF);

          if LVar <> null then
          begin
            //ADocIsFromInvoiceManage = True인 경우 ADoc.InvoiceItem가 존재함
            //InqManager에서 생성한 *.hgs 인 경우임 : ADoc.SubCon이 복수개([] 배열 형식임)
            LoadSubConFromVariant2Form(LVar, ATaskEditConfig.IsDocFromInvoiceManage)//LoadSubConFromVariant(LSubCon, ADoc, ADocIsFromInvoiceManage)
          end;
        finally
  //        LSubConList.Clear;
          LSubConList.Free;
        end;

        //배송정보
        LMat4Proj := GetMaterial4ProjFromTaskID(FTask.ID);

        try
          if (not ATaskEditConfig.IsDocFromInvoiceManage) and (LVar <> null) then
            LoadMaterial4ProjectFromVariant(LMat4Proj, LVar.Material4Project);

          if LMat4Proj.IsUpdate then
          begin
            FMatDeliveryInfoJson := Utf8ToString(LMat4Proj.GetJsonValues(true, true, soSelect));
            PORNoEdit.Text := GetPorNoFromJson(FMatDeliveryInfoJson);

            //자재리스트
            LMatDetail := GetMaterialDetailFromTask(FTask);
            try
              LoadMaterialDetailOrm2Form(LMatDetail);
            finally
              LMatDetail.Free;
            end;
          end;
        finally
          LMat4Proj.Free;
        end;

        LTaskEditF.SelectMailBtn.Enabled := Assigned(ASQLEmailMsg);
        LTaskEditF.CancelMailSelectBtn.Enabled := Assigned(ASQLEmailMsg);
      end
      else
      begin
        LCustomer := TSQLCustomer.Create;

        ServiceChargeCB.ItemIndex := g_ASServiceChargeType.ToOrdinal(assctFree);
        ImportanceCB.ItemIndex := g_ClaimImportanceKind.ToOrdinal(cikC);
        ClaimStatusCombo.ItemIndex := g_ClaimStatus.ToOrdinal(csOpen);

        if AJson <> '' then
        begin
          LDoc := DocDict(AJson);

          if LDoc.Exists('ClaimNo') then
            ClaimNoEdit.Text := LDoc['ClaimNo'];

          if LDoc.Exists('HullNo') then
            HullNoEdit.Text := LDoc['HullNo'];

          if LDoc.Exists('ShipName') then
            ShipNameEdit.Text := LDoc['ShipName'];

          if LDoc.Exists('OrderNo') then
            OrderNoEdit.Text := LDoc['OrderNo'];

          if LDoc.Exists('Subject') then
            WorkSummaryEdit.Text := LDoc['Subject'];

          if LDoc.Exists('Cause') then
            ClaimReasonMemo.Text := LDoc['Cause'];

          if LDoc.Exists('AgentDetail') then
            CustAgentMemo.Text := LDoc['AgentDetail'];
        end;

        ClaimRecvPicker.Date := Date;
        ClaimInputPicker.Date := Date;
        AttendSchedulePicker.Date := 0;
        ClaimReadyPicker.Date := 0;
        ClaimClosedPicker.Date := 0;
        CurWorkFinishPicker.Date := Date;
        WorkBeginPicker.Date := Date;
        WorkEndPicker.Date := Date;

        Caption := Caption + ' (New)';
      end;

      //InvoiceManage로부터 오는 Json은 Task와 Customer에 대한 변경 내용이 없음
      if (not ATaskEditConfig.IsDocFromInvoiceManage) and (LVar <> null) then
        LoadTaskFromVariant(FTask, LVar.Task);

      while True do
      begin
        Result := LTaskEditF.ShowModal;

        //"저장" 버튼을 누른 경우
        if Result = mrOK then
        begin
          if not CheckTaskDBKeyFromForm then
          begin
            ShowMessage('HullNo/ProjectNo/ClaimNo 정보가 없습니다.');
            Continue
          end;

          //Task Create 인 경우
          if not FTask.IsUpdate then
          begin
            //ClaimNo가 이미 존재하면 건너뜀
            if CheckExistHullNoClaimNo(LTaskEditF.HullNoEdit.Text,
                                      LTaskEditF.OrderNoEdit.Text,
                                      LTaskEditF.ClaimNoEdit.Text) then
            begin
              ShowMessage('동일한 ClaimNo가 이미 존재 합니다.');
              continue;
            end;
          end;

          LoadTaskForm2TaskOrm(LTaskEditF, FTask);

          //IPC를 통해서  Email을 수신한 경우
          if Assigned(ASQLEmailMsg) then
          begin
            //대표 메일을 선택한 경우
            if Assigned(LTaskEditF.FTask) then
            begin
              LTask := LTaskEditF.FTask;
            end;

            g_ProjectDB.Add(ASQLEmailMsg, true);

            if not LTask.IsUpdate then
            begin
              LID := g_ProjectDB.Add(LTask, true);
              ShowMessage('Task 및 Email Add 완료');
            end;

  //          LTask.EmailMsg.ManyAdd(g_ProjectDB.Orm, LTask.ID, ASQLEmailMsg.ID, True)
          end
          else
          begin
            AddOrUpdateTask(FTask);
          end;

          if not Assigned(FSQLGSFiles) then
            FSQLGSFiles := TSQLGSFile.Create;

          if High(LTaskEditF.FSQLGSFiles.Files) >= 0 then
          begin
            g_FileDB.Delete(TSQLGSFile, LTaskEditF.FSQLGSFiles.ID);
            LTaskEditF.FSQLGSFiles.TaskID := FTask.ID;
            g_FileDB.Add(LTaskEditF.FSQLGSFiles, true);
          end
          else
            g_FileDB.Delete(TSQLGSFile, LTaskEditF.FSQLGSFiles.ID);

          //고객정보 탭 정보 Load -> LCustomer
          LoadTaskForm2Customer(LTaskEditF, LCustomer, FTask.ID);
          AddOrUpdateCustomer(LCustomer);
          //협력사 탭 정보 Load and Save To DB
          SaveSubConFromForm(LTaskEditF, FTask.ID);
          //자재정보 탭 Load -> LMat4Proj
          LoadTaskForm2MaterialDetailNSave2DB(LTaskEditF, FTask.ID);
          LoadTaskForm2Material4ProjectNSave2DB(FTask.ID);
        end;//mrOK

        Break;
      end;//while
    end;//with
  finally
    //대표 메일을 선택한 경우
//    if Assigned(LTaskEditF.FTask) then
//      ATask := nil;

    FreeAndNil(LCustomer);
//    FreeAndNil(LSubCon);
//    FreeAndNil(LMat4Proj);
    FreeAndNil(LTaskEditF);
  end;
end;

function DisplayTaskInfo2EditFormFromVariant(ADoc: variant;
  ARemoteIPAddress, APort, ARoot: string): Boolean;
var
  LTask: TOrmHiconisASTask;
  LCustomer: TSQLCustomer;
//  LGSFile: TSQLGSFile;
  LSubCon: TSQLSubCon;
  LMat4Proj: TSQLMaterial4Project;
  LTaskEditF: TTaskEditF;
  LDocData: TDocVariantData;
  LVar, LDoc, LDoc2: variant;
  LUtf8: RawUTF8;
  i: integer;
  LDynUtf8: TRawUTF8DynArray;
  LDynArr: TDynArray;
begin
  LTaskEditF := TTaskEditF.Create(nil);
  try
    with LTaskEditF do
    begin
      if ARemoteIPAddress = '' then
      begin

      end
      else
      begin
        FRemoteIPAddress := ARemoteIPAddress;
      end;

      LTask := TOrmHiconisASTask.Create;
      LCustomer := TSQLCustomer.Create;
      LSubCon := TSQLSubCon.Create;
      LMat4Proj := TSQLMaterial4Project.Create;
      try
        LoadTaskFromVariant(LTask, ADoc.Task);
        LoadTaskOrm2Form(LTask, LTaskEditF);

        if not Assigned(FSQLGSFiles) then
          FSQLGSFiles := GetGSFilesFromID(-1)
        else
          FSQLGSFiles.DynArray('Files').Clear;

        LoadGSFileFromVariant(FSQLGSFiles, ADoc.GSFile);
        FSQLGSFiles.TaskID := LTask.TaskID;
        LoadGSFile2Form(FSQLGSFiles, LTaskEditF);
        LoadCustomerFromVariant(LCustomer, ADoc.Customer);
        LoadCustomer2Form(LCustomer, LTaskEditF);
        //ADoc.SubCon = [] 형식의 배열 임
        LDocData.InitJSON(ADoc.SubCon);

        for i := 0 to LDocData.Count - 1 do
        begin
          LVar := _JSON(LDocData.Value[i]);
          LoadSubConFromVariant2Form(LVar, False, True);
        end;

        LoadMaterial4ProjectFromVariant(LMat4Proj, ADoc.Material);
//        LoadMaterial4Project2Form(LMat4Proj, LTaskEditF);

        if ShowModal = mrOK then
        begin
          TDocVariant.New(LDoc);
          TDocVariant.New(LDoc2);
          //LTaskEditF 내용을 LTask 옮김
          LoadTaskForm2TaskOrm(LTaskEditF, LTask);
          LUtf8 := LTask.GetJSONValues(true, true, soSelect);
          LDoc.Task := _JSON(LUtf8);//Escape(\)가 제거됨
          LDoc.Task.RowID := LTask.TaskID;
          FSQLGSFiles.TaskID := LTask.TaskID;

          if High(LTaskEditF.FSQLGSFiles.Files) >= 0 then
          begin
            LUtf8 := MakeGSFile2JSON(LTaskEditF.FSQLGSFiles);
            LDoc.GSFile := _JSON(LUtf8);
          end
          else
            LDoc.GSFile := _JSON('{"TaskID":' + IntToStr(FSQLGSFiles.TaskID) + ',"Files":[]}');

          LoadTaskForm2Customer(LTaskEditF, LCustomer, LTask.TaskID);
          LUtf8 := LCustomer.GetJSONValues(true, true, soSelect);
          LDoc.Customer := _JSON(LUtf8);

          LDynArr.Init(TypeInfo(TRawUTF8DynArray), LDynUtf8);
          for i := 0 to SubConGrid.RowCount - 1 do
          begin
//            if SubConGrid.Row[i].Visible then
//            begin
              LDoc2 := _JSON('{}');
              LoadSubConGrid2Var(i,LDoc2);
              LDoc2.TaskID := LTask.TaskID;
              LUtf8 := LDoc2;
              LDynArr.Add(LUtf8);
//            end;
          end;
          LUtf8 := LDynArr.SaveToJSON;
          LDoc.SubCon := _JSON(LUtf8);

//          LoadTaskForm2Material4Project(LTaskEditF, LMat4Proj);
          LUtf8 := LMat4Proj.GetJSONValues(true, true, soSelect);
          LDoc.Material := _JSON(LUtf8);
          LUtf8 := LDoc;
//          SendReq2Server_Http(ARemoteIPAddress, APort, ARoot, CMD_EXECUTE_SAVE_TASK_DETAIL, LUtf8);
        end;
      finally
        FreeAndNil(LMat4Proj);
        FreeAndNil(LSubCon);
        FreeAndNil(LCustomer);
        FreeAndNil(LTask);
      end;
    end;
  finally
    FreeAndNil(LTaskEditF);
  end;
end;

function ShowEditFormFromClaimReportVar(ATask: TOrmHiconisASTask; AJson: RawUtf8): integer;
var
  LTaskEditF: TTaskEditF;
  LDoc: IDocDict;
  LTask: TOrmHiconisASTask;
  LCustomer: TSQLCustomer;
  LMat4Proj: TSQLMaterial4Project;
  LFiles: TSQLGSFile;
  LSubConList: TObjectList<TSQLSubCon>;
begin
  //신규 생성시 TaskId가 정해지지 않았음
  LTaskEditF := TTaskEditF.Create(nil);
//  LTask := ATask;
  LFiles := TSQLGSFile.Create;
  try
    LDoc := DocDict(AJson);

    with LTaskEditF do
    begin
      ClaimNoEdit.Text := LDoc['ClaimNo'];
      HullNoEdit.Text := LDoc['HullNo'];
      ShipNameEdit.Text := LDoc['ShipName'];
      WorkSummaryEdit.Text := LDoc['Subject'];
      ClaimReasonMemo.Text := LDoc['Cause'];
      CustAgentMemo.Text := LDoc['AgentDetail'];

      LCustomer := GetCustomerFromTask(ATask);

      if not Assigned(FSQLGSFiles) then
        FSQLGSFiles := GetGSFilesFromID(-1)
      else
        FSQLGSFiles.DynArray('Files').Clear;

//      LoadCustomer2Form(LCustomer, LTaskEditF);
//
//      LSubConList := TObjectList<TSQLSubCon>.Create;
//      try
//        GetSubConFromTaskIDWithInvoiceItems(LTask.ID, LSubConList);
//        LoadSubConList2Form(LSubConList, LTaskEditF);
//      finally
//        LSubConList.Free;
//      end;
//
//      LMat4Proj := GetMaterial4ProjFromTask(LTask); //복수개가 반환됨
//      try
//        if LMat4Proj.IsUpdate then
//        begin
//          LMat4Proj.FillRewind;
//
//          while LMat4Proj.FillOne do
//          begin
//            LoadMaterial4Project2Form(LMat4Proj, LTaskEditF);
//          end;//while
//        end;
//      finally
//        LMat4Proj.Free;
//      end;

      Result := ShowModal();

      //"저장" 버튼을 누른 경우
      if Result = mrOK then
      begin
        if not CheckTaskDBKeyFromForm then
        begin
          ShowMessage('HullNo/ProjectNo/ClaimNo 정보가 없습니다.');
          exit;
        end;

        //기존에 존재하는 클레임인지 Check
        LTask := GetTaskFromHullNoNOrderNoNClaimNo(HullNoEdit.Text, OrderNoEdit.Text, ClaimNoEdit.Text);
        try
          if LTask.IsUpdate then
          begin
            ATask.IsUpdate := True;
            ShowMessage('클레임이 이미 존재 합니다.' + #13#10 + 'ClaimNo : ' + ClaimNoEdit.Text);
            exit;
          end;
        finally
          LTask.Free;
        end;

        LoadTaskForm2TaskOrm(LTaskEditF, ATask);
        AddOrUpdateTask(ATask);

        if High(FSQLGSFiles.Files) >= 0 then
        begin
          g_FileDB.Delete(TSQLGSFile, FSQLGSFiles.ID);
          FSQLGSFiles.TaskID := ATask.ID;
          g_FileDB.Add(FSQLGSFiles, true);
        end
        else
          g_FileDB.Delete(TSQLGSFile, FSQLGSFiles.ID);

        //고객정보 탭 정보 Load -> LCustomer
        LoadTaskForm2Customer(LTaskEditF, LCustomer, ATask.ID);
        AddOrUpdateCustomer(LCustomer);
        //협력사 탭 정보 Load and Save To DB
        SaveSubConFromForm(LTaskEditF, ATask.ID);
        //자재정보 탭 Load -> LMat4Proj
        LoadTaskForm2MaterialDetailNSave2DB(LTaskEditF, ATask.ID);
      end;
    end;//with

  finally
    LCustomer.Free;
    LFiles.Free;
    LTaskEditF.Free;
  end;

end;

procedure TTaskEditF.AddOrUpdateMaterial2GridFromVar(ADoc: Variant;
  const ARow: integer);
var
  LIsAdd: Boolean;
begin
  LIsAdd := ARow = -1;
  GetListFromVariant2NextGrid(MaterialGrid, ADoc, LIsAdd);
end;

procedure TTaskEditF.AddOrUpdateMaterialDetail2GridFromVar(ADoc: Variant;
  const ARow: integer);
var
  LIsAdd: Boolean;
begin
  LIsAdd := ARow = -1;
  GetListFromVariant2NextGrid(MaterialGrid, ADoc, LIsAdd);
end;

procedure TTaskEditF.AdvGlowButton5Click(Sender: TObject);
var
  li : integer;
begin
  with fileGrid do
  begin
    if SelectedRow > -1 then
    begin
      if not(CellByName['FileName',SelectedRow].AsString = '') then
      begin
        if Assigned(FSQLGSFiles) then
          FSQLGSFiles.DynArray('Files').Delete(SelectedRow);
        DeleteRow(SelectedRow);
      end;
    end;

    SelectedRow := -1;
  end;
end;

procedure TTaskEditF.AdvGlowButton6Click(Sender: TObject);
begin
  ShowFileSelectF;
end;

procedure TTaskEditF.AeroButton1Click(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TTaskEditF.AeroButton2Click(Sender: TObject);
begin
  SubContractorAdd;
end;

procedure TTaskEditF.AeroButton3Click(Sender: TObject);
var
  LRow: integer;
begin
  LRow := SubConGrid.SelectedRow;

  if LRow = -1 then
    exit;

  if MessageDlg('Aru you sure delete the selected item?.', mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    SubConGrid.BeginUpdate;
    try
      SubConGrid.CellByName['Action', LRow].AsInteger := 2; //Delete Action
      SubConGrid.Row[LRow].Visible := False;
    finally
      SubConGrid.EndUpdate;
    end;
  end;
end;

procedure TTaskEditF.AeroButton4Click(Sender: TObject);
var
  LOLEmailSrchRec: TOLEmailSrchRec;
begin
  LOLEmailSrchRec.FTaskID := FEmailDisplayTask.TaskID;
  LOLEmailSrchRec.FProjectNo := FEmailDisplayTask.Order_No;
  LOLEmailSrchRec.FHullNo := FEmailDisplayTask.HullNo;
  LOLEmailSrchRec.FClaimNo := FEmailDisplayTask.ClaimNo;
  LOLEmailSrchRec.FTaskEditConfig := FTaskEditConfig;

  ShowEMailListFromTask(FEmailDisplayTask, LOLEmailSrchRec, FRemoteIPAddress,
    HiconisASManageF.FPortName, HiconisASManageF.FRootName);
end;

procedure TTaskEditF.AeroButton5Click(Sender: TObject);
begin
  MaterialDetailEdit();
end;

procedure TTaskEditF.AeroButton6MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ExecMacro_ClaimRegister();
end;

procedure TTaskEditF.DeleteMaterial1Click(Sender: TObject);
begin
  DeleteMaterialBtnClick(nil);
end;

procedure TTaskEditF.DeleteMaterialBtnClick(Sender: TObject);
var
  LRow: integer;
begin
  LRow := MaterialGrid.SelectedRow;

  if LRow = -1 then
  begin
    ShowMessage('Select Item');
    exit;
  end;

  if MessageDlg('Aru you sure delete the selected item?.', mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    MaterialGrid.BeginUpdate;
    try
      MaterialGrid.Row[LRow].Visible := False;
    finally
      MaterialGrid.EndUpdate;
    end;
  end;
end;

procedure TTaskEditF.AeroButton7Click(Sender: TObject);
begin
  MaterialEdit();
end;

procedure TTaskEditF.AeroButton8Click(Sender: TObject);
var
  LRoot: TMacroManagements;
  LMacroM: TMacroManagement;
  LPath: string;
  LIdx: integer;
begin
  SetCurrentDir(ExtractFilePath(Application.ExeName));
//  LPath := 'E:\pjh\Dev\Lang\Delphi\Project\RPA\MacroManage\mcr\';
  LPath := '.\mcr\';
  LRoot := TMacroManagements.Create;
  try
    LIdx := LRoot.AddMacro2RootFromJsonFile(LPath + 'Mouse-Move-Claim등록-공사번호.mcr');
    LMacroM := LRoot.FMacroManageList.Items[LIdx];

    if OrderNoEdit.Text <> '' then
    begin
      LMacroM.AddTypeMsgMacro2ActItemList(OrderNoEdit.Text);
      LMacroM.AddWaitMacro2ActItemList(2000);
      LMacroM.ExecuteActItemList();
    end;

    LIdx := LRoot.AddMacro2RootFromJsonFile(LPath + 'Mouse-Move-Claim등록-ClaimNo.mcr');
    LMacroM := LRoot.FMacroManageList.Items[LIdx];

    if ClaimNoEdit.Text <> '' then
    begin
      LMacroM.AddTypeMsgMacro2ActItemList(ClaimNoEdit.Text);
      LMacroM.AddWaitMacro2ActItemList(2000);
      LMacroM.ExecuteActItemList();
    end;

    LIdx := LRoot.AddMacro2RootFromJsonFile(LPath + 'Mouse-Move-Claim등록-Subject.mcr');
    LMacroM := LRoot.FMacroManageList.Items[LIdx];

    if WorkSummaryEdit.Text <> '' then
    begin
      LMacroM.AddTypeMsgMacro2ActItemList(WorkSummaryEdit.Text);
      LMacroM.AddWaitMacro2ActItemList(2000);
      LMacroM.ExecuteActItemList();
    end;

    LIdx := LRoot.AddMacro2RootFromJsonFile(LPath + 'Mouse-Move-Claim등록-사유.mcr');
    LMacroM := LRoot.FMacroManageList.Items[LIdx];

    if ClaimReasonMemo.Text <> '' then
    begin
      LMacroM.AddTypeMsgMacro2ActItemList(ClaimReasonMemo.Text);
      LMacroM.AddWaitMacro2ActItemList(2000);
      LMacroM.ExecuteActItemList();
    end;

    LIdx := LRoot.AddMacro2RootFromJsonFile(LPath + 'Select-Claim등록-중요도.mcr');
    LMacroM := LRoot.FMacroManageList.Items[LIdx];
    LMacroM.ExecuteActItemList();
    LMacroM.AddWaitMacro2ActItemList(2000);

    //아래 실행 전에 d:\temp\ttt에 이메일 파일이 한개만 존재 해야 함
    LIdx := LRoot.AddMacro2RootFromJsonFile(LPath + '파일첨부-Claim등록-첨부파일.mcr');
    LMacroM := LRoot.FMacroManageList.Items[LIdx];
    LMacroM.ExecuteActItemList();
  finally
    ShowMessage('Claim 등록 입력 완료!');
    LRoot.Free;
  end;
end;

procedure TTaskEditF.AeroButton8MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  AeroButton8Click(nil);
end;

procedure TTaskEditF.BitBtn1Click(Sender: TObject);
begin
//  Content2Clipboard(HullNoEdit.Text);
  ClipboardCopyOrPaste2AdvEditBtn(HullNoEdit);
end;

procedure TTaskEditF.BitBtn2Click(Sender: TObject);
begin
//  Content2Clipboard(OrderNoEdit.Text);
  ClipboardCopyOrPaste2AdvEditBtn(OrderNoEdit);
end;

procedure TTaskEditF.BitBtn3Click(Sender: TObject);
begin
  ClipboardCopyOrPaste2AdvEditBtn(ClaimNoEdit);
end;

procedure TTaskEditF.BitBtn4Click(Sender: TObject);
begin
  ClipboardCopyOrPaste2AdvEditBtn(ShipNameEdit);
end;

procedure TTaskEditF.SalesProcTypeCBDropDown(Sender: TObject);
begin
  g_SalesProcessType.SetType2Combo(SalesProcTypeCB);
end;

procedure TTaskEditF.Saveas1Click(Sender: TObject);
var
  LFileName: string;
  LRow: integer;
begin
  LRow := fileGrid.SelectedRow;

  if LRow = -1 then
    exit;

  if Assigned(FSQLGSFiles) then
  begin
    if SaveDialog1.Execute then
    begin
      LFileName := SaveDialog1.FileName;
      FileFromString(FSQLGSFiles.Files[LRow].fData,LFileName,True);
    end;
  end;
end;

procedure TTaskEditF.SaveCompanyinfoashgs1Click(Sender: TObject);
var
  LJSON,
  LFileName: string;
begin
  LJSON := MakeCompanyInfoFromGrid2JSON;

  if LJSON <> '' then
  begin
    LFileName := SubConGrid.CellsByName['CompanyName',SubConGrid.SelectedRow];
    SaveDialog1.FileName := ChangeFileExt(LFileName, '.hgsreg');

    if SaveDialog1.Execute then
    begin
      LFileName := SaveDialog1.FileName;
      FileFromString(LJSON, LFileName, True);
    end;
  end;
end;

function TTaskEditF.SaveCurrentTaskAndSelectedSubCon2File(ASubConID: TID): string;
var
  LTask: TOrmHiconisASTask;
  LFileName, LStr: string;
begin
  Result := '';
  LTask := GetLoadTask(FEmailDisplayTask.ID);
  try
    if LTask.IsUpdate then
    begin
      FTaskJson := MakeTaskInfoEmailAttached(LTask, LFileName, ASubConID);
      Result := LFileName;
    end;
  finally
    LTask.Free;
  end;
end;

procedure TTaskEditF.SaveCustEdit2MasterCustomer;
var
  LCustomer: TSQLMasterCustomer;
begin
  LCustomer := GetMasterCustomerFromCompanyCodeNName(CustCompanyCodeEdit.Text, CustomerNameCB.Text);
  try
    SaveCustomer2MasterCustomer(LCustomer);
  finally
    FreeAndNil(LCustomer);
  end;
end;

procedure TTaskEditF.SaveCustomer2MasterCustomer(
  AMCustomer: TSQLMasterCustomer);
begin
  LoadTaskForm2MasterCustomer(Self, AMCustomer, Self.FTask.ID);

  if AMCustomer.IsUpdate then
  begin
    if MessageDlg('고객 정보가 이미 MasterDB에 존재합니다.' + #13#10 + '새로운 정보로 Update 하시겠습니까?', mtConfirmation, [mbYes, mbNo],0) = mrYes then
    begin
      g_CustomerCompanyDB.Update(AMCustomer);
    end;
  end
  else
  begin
    g_CustomerCompanyDB.Add(AMCustomer, true);
  end;
end;

procedure TTaskEditF.SelectMailBtnClick(Sender: TObject);
begin
  ShowDTIForm;
end;

procedure TTaskEditF.SendCmd4CreateMail(AMailType: integer);
var
  LOLMailRec: TOLMailRec;
  LValue: TOmniValue;
  LMsgQ: TOmniMessageQueue;
  LMsg: string;
begin
  case AMailType of
    5: ; //방선 가능 검토 요청 메일
  end;

  FHiASIniConfig.FHullNo := HullNoEdit.Text;
  FHiASIniConfig.FShipName := ShipNameEdit.Text;
  FHiASIniConfig.FClaimNo := ClaimNoEdit.Text;
  FHiASIniConfig.FAgentDetail := CustAgentMemo.Text;

  if FHiASIniConfig.FAgentDetail = '' then
    FHiASIniConfig.FAgentDetail := 'To Be Updated';

  if FHiASIniConfig.FComissionCompany = '' then
    FHiASIniConfig.FComissionCompany := 'To Be Updated';

  FHiASIniConfig.FServiceDate := DateToStr(AttendSchedulePicker.Date);
  FHiASIniConfig.FPlace := NationPortEdit.Text;

  LOLMailRec.Subject := WorkSummaryEdit.Text;
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

procedure TTaskEditF.ServiceChargeCBDropDown(Sender: TObject);
begin
  g_ASServiceChargeType.SetType2Combo(ServiceChargeCB);
end;

procedure TTaskEditF.ServiceOrder1Click(Sender: TObject);
var
  LRec: Doc_ServiceOrder_Rec;
begin
  LRec := Get_Doc_ServiceOrder_Rec;
  MakeDocServiceOrder(LRec);
end;

procedure TTaskEditF.SetHiASIniConfig(var AHiASIniConfig: THiASIniConfig);
begin
  FHiASIniConfig := AHiASIniConfig;
end;

procedure TTaskEditF.CancelMailSelectBtnClick(Sender: TObject);
begin
  if Assigned(FTask) then
    FreeAndNil(FTask);
end;

procedure TTaskEditF.Category1Click(Sender: TObject);
begin
  Category1.Tag := ShowCheckGrp4Claim(Ord(ctkCatetory), Category1.Tag);
end;

procedure TTaskEditF.CauseHW1Click(Sender: TObject);
begin
  CauseHW1.Tag := ShowCheckGrp4Claim(Ord(ctkCauseHW), CauseHW1.Tag);
end;

procedure TTaskEditF.CauseKind1Click(Sender: TObject);
begin
  CauseKind1.Tag := ShowCheckGrp4Claim(Ord(ctkCauseKind), CauseKind1.Tag);
end;

procedure TTaskEditF.CauseSW1Click(Sender: TObject);
begin
  CauseSW1.Tag := ShowCheckGrp4Claim(Ord(ctkCauseSW), CauseSW1.Tag);
end;

function TTaskEditF.CheckDocCompanySelection(ASOR: Doc_ServiceOrder_Rec):Boolean;
begin
  Result := True;

  if ASOR.FSubConName = '' then
  begin
    ShowMessage('협력사가 지정되지 않았습니다!');
    PageControl1.TabIndex := 3;
    Result := False;
  end;
end;

function TTaskEditF.CheckTaskDBKeyFromForm: Boolean;
begin
  Result := (ClaimNoEdit.Text <> '') and (OrderNoEdit.Text <> '') and (HullNoEdit.Text <> '');
end;

procedure TTaskEditF.Claim1Click(Sender: TObject);
begin
  ExecMacro_QryClaimMonitoringByHullNo(HullNoEdit);
end;

procedure TTaskEditF.ClaimServiceKindCBChange(Sender: TObject);
begin
  InitCurWorkCB();
end;

procedure TTaskEditF.CurWorkCBChange(Sender: TObject);
begin
  InitNextWorkCB();
end;

procedure TTaskEditF.CurWorkCBDropDown(Sender: TObject);
begin
//  CurWorkCB.Clear;
//  SalesProcessType2Combo(CurWorkCB);
//  SPType2Combo(CurWorkCB);
end;

procedure TTaskEditF.DropEmptyTarget1Drop(Sender: TObject;
  ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
var
  i: integer;
  LFileName: string;
  LFromOutlook: Boolean;
  LTargetStream: TStream;
begin
  LFileName := '';
  // 윈도우 탐색기에서 Drag 했을 경우
  if (DataFormatAdapter1.DataFormat <> nil) then
  begin
    LFileName := (DataFormatAdapter1.DataFormat as TFileDataFormat).Files.Text;

    if LFileName <> '' then
    begin
      FFileContent := StringFromFile(LFileName);
//      LFromOutlook := False;
    end;
  end;

  // OutLook에서 첨부파일을 Drag 했을 경우
  if (TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat).FileNames.Count > 0) then
  begin
    LFileName := TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat).FileNames[0];
    LTargetStream := GetStreamFromDropDataFormat(TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat));
    try
      if not Assigned(LTargetStream) then
        ShowMessage('Not Assigned');

      FFileContent := StreamToRawByteString(LTargetStream);
      LFromOutlook := True;
    finally
      if Assigned(LTargetStream) then
        LTargetStream.Free;
    end;
  end;

  if LFileName <> '' then
  begin
    LFileName.Replace('"','');
    ShowFileSelectF(LFileName, LFromOutlook);
  end;
end;

procedure TTaskEditF.DropEmptyTarget1Drop2(Sender: TObject;
  ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
var
  i: integer;
  LFileName: string;
  LFromOutlook: Boolean;
  LTargetStream: TStream;
begin
  LFileName := '';
  // 윈도우 탐색기에서 Drag 했을 경우
  if TFileDataFormat(DataFormatAdapter1.DataFormat).Files.Count > 0 then
    LFileName := (DataFormatAdapter1.DataFormat as TFileDataFormat).Files.Text;

  // OutLook에서 첨부파일을 Drag 했을 경우
  if (TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat).FileNames.Count > 0) then
  begin
    LFileName := TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat).FileNames.Text;
    LFromOutlook := True;
  end;

  if LFileName <> '' then
  begin
    LFileName.Replace('"','');
    ShowFileSelectF2(LFileName, LFromOutlook);
  end;
end;

procedure TTaskEditF.English2Click(Sender: TObject);
var
  LRec: Doc_Invoice_Rec;
begin
  LRec := Get_Doc_Inv_Rec;
  MakeDocInvoice(LRec);
end;

procedure TTaskEditF.ExecMacro_ClaimRegister;
var
  LRoot: TMacroManagements;
  LMacroM: TMacroManagement;
  LPath, LMacroName: string;
  LIdx: integer;
begin
  SetCurrentDir(ExtractFilePath(Application.ExeName));
  LPath := '.\mcr\';
  LRoot := TMacroManagements.Create;
  try
    case g_ClaimServiceKind.ToType(ClaimServiceKindCB.ItemIndex) of
      cskPartSupply: LMacroName := 'Select-Claim관리-Service-부품공급.mcr';
      cskPartSupplyNSE: LMacroName := 'Select-Claim관리-Service-부품공급_SE.mcr';
      cskSEOnboard: LMacroName := 'Select-Claim관리-Service-SE방선.mcr';
      cskTechInfo: LMacroName := 'Select-Claim관리-Service-기술정보제공.mcr';
    end;

    if LMacroName = '' then
    begin
      ShowMessage('SERVICE를 선택하세요.');
      exit;
    end;

    LIdx := LRoot.AddMacro2RootFromJsonFile(LPath + LMacroName);
    LMacroM := LRoot.FMacroManageList.Items[LIdx];
    LMacroM.ExecuteActItemList();
    LMacroM.AddWaitMacro2ActItemList(2000);

    LIdx := LRoot.AddMacro2RootFromJsonFile(LPath + 'Select-Claim관리-책임처.mcr');
    LMacroM := LRoot.FMacroManageList.Items[LIdx];
    LMacroM.ExecuteActItemList();
    LMacroM.AddWaitMacro2ActItemList(2000);

    LIdx := LRoot.AddMacro2RootFromJsonFile(LPath + 'Mouse-Move-Claim관리-조치결과.mcr');
    LMacroM := LRoot.FMacroManageList.Items[LIdx];

    if EtcContentMemo.Text <> '' then
      LMacroM.AddTypeMsgMacro2ActItemList(EtcContentMemo.Text);

    LMacroM.AddWaitMacro2ActItemList(2000);
    LMacroM.ExecuteActItemList();
  finally
    ShowMessage('Claim 관리 입력 완료!');
    LRoot.Free;
  end;
end;

procedure TTaskEditF.btn_CloseClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TTaskEditF.Button1Click(Sender: TObject);
begin
  if (CustomerNameCB.Text = '') or (CustCompanyCodeEdit.Text = '') then
  begin
    ShowMessage('회사이름 과 업체코드는 필수 입력 항목 입니다.');
    exit;
  end;

  if MessageDlg('Are you sure save to MasterCustomerDB?', mtConfirmation, [mbYes, mbNo],0) = mrYes then
    SaveCustEdit2MasterCustomer;
end;

procedure TTaskEditF.Button2Click(Sender: TObject);
var
  LSearchCustomerF: TSearchCustomerF;
begin
  LSearchCustomerF := TSearchCustomerF.Create(nil);
  try
    with LSearchCustomerF do
    begin
      FCompanyType := [ctNull];

      if ShowModal = mrOk then
      begin
        if NextGrid1.SelectedRow <> -1 then
        begin
          CustomerNameCB.Text := NextGrid1.CellByName['CompanyName', NextGrid1.SelectedRow].AsString;
          CustCompanyCodeEdit.Text := NextGrid1.CellByName['CompanyCode', NextGrid1.SelectedRow].AsString;
          CustCompanyTypeCB.Text := NextGrid1.CellByName['CompanyTypes', NextGrid1.SelectedRow].AsString;
          CustManagerEdit.Text := NextGrid1.CellByName['ManagerName', NextGrid1.SelectedRow].AsString;
          CustPositionEdit.Text := NextGrid1.CellByName['Position', NextGrid1.SelectedRow].AsString;
          CustEmailEdit.Text := NextGrid1.CellByName['EMail', NextGrid1.SelectedRow].AsString;
          NationEdit.Text := NextGrid1.CellByName['Nation', NextGrid1.SelectedRow].AsString;
          CustPhonNumEdit.Text := NextGrid1.CellByName['Officeno', NextGrid1.SelectedRow].AsString;
          CustFaxEdit.Text := NextGrid1.CellByName['Mobileno', NextGrid1.SelectedRow].AsString;
          CustomerAddressMemo.Text := NextGrid1.CellByName['CompanyAddress', NextGrid1.SelectedRow].AsString;
        end;
      end;
    end;
  finally
    LSearchCustomerF.Free;
  end;
end;

procedure TTaskEditF.Button3Click(Sender: TObject);
begin
  if not Assigned(FpjhToDoList) then
    FpjhToDoList := Collections.NewKeyValue<string,TpjhTodoItemRec>
  else
    FpjhToDoList.Clear;

  GetToDoListFromDBByTask(FTask, FpjhToDoList);

  Create_ToDoList_Frm2(FTask.ID, FpjhToDoList, FTaskEditConfig, True);

//  FToDoCollect.Clear;
//  //TaskID 별로 ToDoList를 Select하여 FToDoCollect에 저장함
//  LoadToDoCollectFromTask(FEmailDisplayTask, FToDoCollect);
//
//  Create_ToDoList_Frm(IntToStr(FEmailDisplayTask.ID), FToDoCollect, False,
//    InsertOrUpdateToDoList2DB, DeleteToDoListFromDB);
end;

procedure TTaskEditF.Button4Click(Sender: TObject);
var
  LStr: string;
begin
  LStr := FormatDateTime('- yyyy.mm.dd: ', CurWorkFinishPicker.Date) + CurWorkCB.Text;//g_HiconisASState.ToString(CurWorkCB.ItemIndex);
  EtcContentMemo.Lines.Add(LStr);
end;

procedure TTaskEditF.fileGridCellDblClick(Sender: TObject; ACol, ARow: Integer);
var
  LFileName: string;
begin
  if ARow = -1 then
    exit;

  if Assigned(FSQLGSFiles) then
  begin
    LFileName := 'C:\Temp\'+FSQLGSFiles.Files[ARow].fFilename;

    if FileExists(LFileName) then
      DeleteFile(LFileName);

    FileFromString(FSQLGSFiles.Files[ARow].fData,
      LFileName,True);

    ShellExecute(handle,'open', PChar(LFileName),nil,nil,SW_NORMAL);
  end;
end;

procedure TTaskEditF.fileGridMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i: integer;
begin
  if (FileGrid.SelectedCount > 0) and
    (DragDetectPlus(FileGrid.Handle, Point(X,Y))) then
  begin
    TVirtualFileStreamDataFormat(DataFormatAdapter2.DataFormat).FileNames.Clear;

    for i := 0 to FileGrid.RowCount - 1 do
    begin
      if (FileGrid.Row[i].Selected) then
      begin
        TVirtualFileStreamDataFormat(DataFormatAdapter2.DataFormat).
          FileNames.Add(FileGrid.CellByName['FileName',i].AsString);
//        break;
      end;
    end;

    DropEmptySource1.Execute;
  end;
end;

procedure TTaskEditF.FormCreate(Sender: TObject);
begin
  FTask := nil;
  FSQLGSFiles := nil;
  FFSMState := nil;
  g_RemoteIPAddress := '';
  InitEnum;
  InitCB;
  (DataFormatAdapter2.DataFormat as TVirtualFileStreamDataFormat).OnGetStream := OnGetStream;
  (DataFormatAdapter3.DataFormat as TVirtualFileStreamDataFormat).OnGetStream := OnGetStream2;
//  FToDoCollect := TpjhToDoItemCollection.Create(TpjhTodoItem);
  FOLMessagesFromDrop := TStringList.Create;
  FSalesProcessList := TStringList.Create;

  PageControl1.ActivePageIndex := 0;
end;

procedure TTaskEditF.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to FOLMessagesFromDrop.Count - 1 do
  begin
    TInterfaceList(FOLMessagesFromDrop.Objects[i]).Free;
  end;

  FOLMessagesFromDrop.Free;
  FSalesProcessList.Free;

//  if Assigned(FTask) then
//    FreeAndNil(FTask);

//  if Assigned(FToDoCollect) then
//  begin
//    FToDoCollect.Clear;
//    FreeAndNil(FToDoCollect);
//  end;

  if Assigned(FSQLGSFiles) then
    FSQLGSFiles.Free;
end;

function TTaskEditF.GetFileFromDropDataFormat(
  AFormat: TVirtualFileStreamDataFormat):TFileStream;
var
  LStream, LTargetAdapter: IStream;
  LTargetStream: TFileStream;
  LInt1, LInt2: LargeInt;
  FileName: string;
begin
  LStream := TVirtualFileStreamDataFormat(AFormat).FileContentsClipboardFormat.GetStream(0);
  if (LStream <> nil) then
  begin
    Filename := TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat).FileNames[0];
    try
      LTargetStream := TFileStream.Create(Filename, fmCreate);
      try
        LTargetAdapter := TStreamAdapter.Create(LTargetStream, soOwned);
      except
        LTargetStream.Free;
        raise;
      end;
      LStream.CopyTo(LTargetAdapter, High(Int64), LInt1, LInt2);
    finally
      LTargetAdapter := nil;
    end;
  end;
end;

function TTaskEditF.GetNextSalesProcess2String(ASalesProcess: string): string;
var
  LSalesProcess: TSalesProcess;
begin
  Result := '';

  if ASalesProcess <> '' then
  begin
    LSalesProcess := g_SalesProcess.ToType(ASalesProcess);
    Result := g_SalesProcess.ToString(LSalesProcess);
  end;
end;

function TTaskEditF.GetPorNoFromJson(const AJson: string): string;
var
  LVar: Variant;
begin
  LVar := TDocVariant.NewJson(StringToUtf8(AJson));
  Result := LVar.PORNo;
end;

function TTaskEditF.GetQTN_InqContent: string;
begin
  Result := GetQTNContent(FEmailDisplayTask);
end;

function TTaskEditF.Get_Doc_Cust_Reg_Rec: Doc_Cust_Reg_Rec;
begin
  Result.FCompanyName := CustomerNameCB.Text;
  Result.FCountry := NationEdit.Text;
  Result.FCompanyAddress := CustomerAddressMemo.Text;
  Result.FTelNo := CustPhonNumEdit.Text;
  Result.FFaxNo := CustFaxEdit.Text;
  Result.FEMailAddress := CustEmailEdit.Text;
end;

function TTaskEditF.Get_Doc_Inv_Rec: Doc_Invoice_Rec;
begin
  Result.FCustomerInfo := CustomerAddressMemo.Text;
  Result.FCustomerInfo := Result.FCustomerInfo.Replace(#13, '');
//  Result.FCustomerInfo.Replace(#10, '');
  Result.FInvNo := OrderNoEdit.Text;
//  Result.FInvDate := FormatDateTime('dd.mmm.yyyy', now);
  Result.FHullNo := HullNoEdit.Text;
  Result.FShipName := ShipNameEdit.Text;
  Result.FSubject := WorkSummaryEdit.Text;
//  Result.FProduceType := ProductTypeCB.Text;
  Result.FPONo := PONoEdit.Text;
  Result.FInvoiceItemList := nil;
end;

function TTaskEditF.Get_Doc_Qtn_Rec: Doc_Qtn_Rec;
var
  LQTN: string;
begin
  Result.FCustomerInfo := CustomerAddressMemo.Text;
  Result.FCustomerInfo := Result.FCustomerInfo.Replace(#13, '');

//  LQTN := QTNNoEdit.Text;
//  if QTNNoEdit.Text = '' then
//    LQTN := HullNoEdit.Text + '-' + IntToStr(Random(9));

  Result.FQtnNo := LQTN;
  Result.FQtnDate := FormatDateTime('dd.mmm.yyyy', now);
  Result.FHullNo := HullNoEdit.Text;
  Result.FShipName := ShipNameEdit.Text;
  Result.FSubject := WorkSummaryEdit.Text;
//  Result.FProduceType := ProductTypeCB.Text;
  Result.FPONo := PONoEdit.Text;
  Result.FValidateDate := FormatDateTime('mmm.dd.yyyy', now+30);
end;

function TTaskEditF.Get_Doc_ServiceOrder_Rec(AIdx: integer): Doc_ServiceOrder_Rec;
var
  LPeriod:string;
  LDays: integer;
begin
  if SubConGrid.RowCount = 0 then
  begin
    ShowMessage('협력사가 없습니다.');
    exit;
  end;

  Result.FSubConName := SubConGrid.CellsByName['CompanyName', AIdx];
  Result.FSubConManager := SubConGrid.CellsByName['ManagerName', AIdx];
  Result.FSubConPhonNo := SubConGrid.CellsByName['OfficePhone', AIdx];
  Result.FSubConEmail := SubConGrid.CellsByName['EMail', AIdx];
  Result.FEngineerNo := SubConGrid.CellsByName['SECount', AIdx];
  Result.FSubConPrice := SubConGrid.CellsByName['SubConPrice', AIdx];
  Result.FHullNo := HullNoEdit.Text;
  Result.FShipName := ShipNameEdit.Text;
  Result.FSubject := WorkSummaryEdit.Text;
  Result.FShipOwner := ShipOwnerEdit.Text;
//  Result.FWorkDesc := WorkSummaryEdit.Text;
  Result.FProduceType := ProductTypeCB.Text;
//  if ServicePOEdit.Text = '' then
//    Result.FPONo2SubCon := OrderNOEdit.Text
//  else
    Result.FPONo2SubCon := SubConGrid.CellsByName['ServicePO', AIdx];
  Result.FOrderDate := FormatDateTime('dd.mmm.yyyy', now);
  Result.FWorkSch := '1.Place : ' + NationPortEdit.Text;
  LPeriod := FormatDateTime('yyyy.mm.dd', WorkBeginPicker.Date);
  LPeriod := LPeriod + ' ~ ' + FormatDateTime('yyyy.mm.dd',WorkEndPicker.Date);
  Result.FWorkPeriod := LPeriod;
  LDays := DaysBetween(WorkEndPicker.Date, WorkEndPicker.Date);

  if LDays = 0 then
    Result.FWorkDays := '1'
  else
    Result.FWorkDays := IntToStr(LDays+1);

  Result.FWorkSch := Result.FWorkSch + #13#10 + '2.Period : ' + LPeriod;
  Result.FLocalAgent := CustAgentMemo.Text;
  Result.FLocalAgent := Result.FLocalAgent.Replace(#13,'');

  Result.FProjCode := OrderNoEdit.Text;
  Result.FCustomer := CustomerNameCB.Text;
  Result.FNationPort := NationPortEdit.Text;
  Result.FWorkSummary := WorkSummaryEdit.Text;
  Result.FManagerDepartment := ManagerDepartmentEdit.Text;
end;

procedure TTaskEditF.HullNoClaimNo1Click(Sender: TObject);
begin
  Clipboard.AsText := HullNoEdit.Text + '-' + ClaimNoEdit.Text;
end;

procedure TTaskEditF.HullNoEditClickBtn(Sender: TObject);
var
  LVesselSearchParamRec: TVesselSearchParamRec;
begin
  LVesselSearchParamRec.fHullNo := RemoveSpaceBetweenStrings(HullNoEdit.Text);
  LVesselSearchParamRec.fShipName := ShipNameEdit.Text;

  if ShowSearchVesselForm(LVesselSearchParamRec) = mrOK then
  begin
    HullNoEdit.Text := LVesselSearchParamRec.fHullNo;
    ShipNameEdit.Text := LVesselSearchParamRec.fShipName;
  end;
end;

procedure TTaskEditF.InitCB;
begin
  g_ElecProductType.SetType2Combo(ProductTypeCB);
  g_SalesProcessType.SetType2Combo(SalesProcTypeCB);
  CompanyType2Combo(CustCompanyTypeCB);
  g_ClaimImportanceKind.SetType2Combo(ImportanceCB);
  g_ClaimServiceKind.SetType2Combo(ClaimServiceKindCB);
  g_ClaimStatus.SetType2Combo(ClaimStatusCombo);

//  InitCurWorkCB();
//  InitNextWorkCB();
end;

procedure TTaskEditF.InitCurWorkCB;
begin
  case g_ClaimServiceKind.ToType(ClaimServiceKindCB.ItemIndex) of
    cskPartSupply: TFSMHelper<THiconisASState,THiconisASTrigger>.GetAllStates2ComboUsingEnumHelper(g_FSM_Mat, g_HiconisASState, CurWorkCB);
    cskPartSupplyNSE: TFSMHelper<THiconisASState,THiconisASTrigger>.GetAllStates2ComboUsingEnumHelper(g_FSM_SE_Mat, g_HiconisASState, CurWorkCB);
    cskSEOnboard: TFSMHelper<THiconisASState,THiconisASTrigger>.GetAllStates2ComboUsingEnumHelper(g_FSM_SE, g_HiconisASState, CurWorkCB);
    cskTechInfo: TFSMHelper<THiconisASState,THiconisASTrigger>.GetAllStates2ComboUsingEnumHelper(g_FSM_TechInfo, g_HiconisASState, CurWorkCB);
    cskOverDue: ;
  end;

  if CurWorkCB.ItemIndex = -1 then
  begin
    CurWorkCB.ItemIndex := 1;
    CurWorkCB.OnChange(nil);
  end;
end;

procedure TTaskEditF.InitEnum;
begin
  g_ElecProductType.InitArrayRecord(R_ElecProductType);
  g_SalesProcessType.InitArrayRecord(R_SalesProcessType);
  g_GSDocType.InitArrayRecord(R_GSDocType);
  g_ASServiceChargeType.InitArrayRecord(R_ASServiceChargeType);
  g_ClaimImportanceKind.InitArrayRecord(R_ClaimImportanceKind);
  g_ClaimServiceKind.InitArrayRecord(R_ClaimServiceKind);
  g_DeliveryKind.InitArrayRecord(R_DeliveryKind);
  g_FreeOrCharge.InitArrayRecord(R_FreeOrCharge);
  g_ClaimStatus.InitArrayRecord(R_ClaimStatus);
  g_ProcessDirection.InitArrayRecord(R_ProcessDirection);
  g_ContainData4Mail.InitArrayRecord(R_ContainData4Mail);
end;

procedure TTaskEditF.InitNextWorkCB;
var
  LState: THiconisASState;
begin
  LState := g_HiconisASState.ToType(CurWorkCB.Text);

  if LState = hassNull then
    exit;

  case g_ClaimServiceKind.ToType(ClaimServiceKindCB.ItemIndex) of
    cskPartSupply: begin
      TFSMHelper<THiconisASState,THiconisASTrigger>.GetTriggers2ComboByStateUsingEnumHelper(g_FSM_Mat, LState, g_HiconisASTrigger, NextWorkCB);
    end;
    cskPartSupplyNSE: begin
      TFSMHelper<THiconisASState,THiconisASTrigger>.GetTriggers2ComboByStateUsingEnumHelper(g_FSM_SE_Mat, LState, g_HiconisASTrigger, NextWorkCB);
    end;
    cskSEOnboard: begin
      TFSMHelper<THiconisASState,THiconisASTrigger>.GetTriggers2ComboByStateUsingEnumHelper(g_FSM_SE, LState, g_HiconisASTrigger, NextWorkCB);
    end;
    cskTechInfo: begin
      TFSMHelper<THiconisASState,THiconisASTrigger>.GetTriggers2ComboByStateUsingEnumHelper(g_FSM_TechInfo, LState, g_HiconisASTrigger, NextWorkCB);
    end;
    cskOverDue: ;
  end;

  if NextWorkCB.ItemIndex = -1 then
  begin
    NextWorkCB.ItemIndex := 0;

    if EtcContentMemo.Text = '' then
      EtcContentMemo.Lines.Add('- 장주호 CI 검토');
  end;
end;

procedure TTaskEditF.INQInput1Click(Sender: TObject);
var
  LStr: string;
begin
  LStr := GetQTN_InqContent;
  Content2Clipboard(LStr);
end;

procedure TTaskEditF.JvLabel5Click(Sender: TObject);
begin
//  FrmHiconisASManage.HiconisASManageF.TestRemoteTaskEmailList(FEmailDisplayTask);
end;

procedure TTaskEditF.LoadCustomer2Form(ACustomer: TSQLCustomer;
  AForm: TTaskEditF);
begin
  with AForm do
  begin
    CustomerNameCB.Text := ACustomer.CompanyName;
    CustCompanyCodeEdit.Text := ACustomer.CompanyCode;
    CustCompanyTypeCB.ItemIndex := GetFirstCompanyTypeIndex(ACustomer.CompanyTypes);
    CustManagerEdit.Text := ACustomer.ManagerName;
    CustEmailEdit.Text := ACustomer.EMail;
    CustomerAddressMemo.Text := ACustomer.CompanyAddress;
    CustAgentMemo.Text := ACustomer.AgentInfo;
    CustPhonNumEdit.Text := ACustomer.OfficePhone;
    CustFaxEdit.Text := ACustomer.MobilePhone;
    CustPositionEdit.Text := ACustomer.Position;
    NationEdit.Text := ACustomer.Nation;
  end;
end;

procedure TTaskEditF.LoadCustomerFromCompanycode(ACompanyCode: string);
var
  LMasterCustomer: TSQLMasterCustomer;
begin
  if ACompanyCode = '' then
    exit;

  LMasterCustomer := GetMasterCustomerFromCompanyCodeNName(ACompanyCode, '');
  try
    if LMasterCustomer.IsUpdate then
    begin

    end;
  finally
    FreeAndNil(LMasterCustomer);
  end;
end;

class procedure TTaskEditF.LoadEmailListFromTask(ATask: TOrmHiconisASTask;
  AForm: TOLEmailListF);
//var
//  LOLEmailSrchRec: TOLEmailSrchRec;
//  LIds: TIDDynArray;
begin
//폼 생성 후 2초후에 FFolderListFromOL가 채워 지므로 아래 함수는 값이 0임
//  AForm.OLEmailListFr.FillInMoveFolderCB;

//  LOLEmailSrchRec.FHullNo := ATask.HullNo;
//  LOLEmailSrchRec.FProjectNo := ATask.Order_No;
//  LOLEmailSrchRec.FClaimNo := ATask.ClaimNo;

  AForm.OLEmailListFr.ShowEmailListFromSrchRec();
//  ATask.EmailMsg.DestGet(g_ProjectDB.Orm, ATask.ID, LIds);
//  ShowEmailListFromIDs(AForm.OLEmailListFr.grid_Mail, LIds);
//  LFolderPath := AForm.grid_Mail.CellByName['FolderPath',].AsString;
//  AForm.OLEmailListFr.SetMoveFolderCBByFolderPath();//(AForm.MoveFolderCB, AForm.grid_Mail);
  AForm.OLEmailListFr.SubFolderNameEdit.Text := ATask.HullNo + '\' + ATask.ClaimNo;
end;

procedure TTaskEditF.LoadGrid2TaskEditForm(AGrid: TNextGrid; ARow: integer;
  AEditForm: TTaskEditF);
var
  LStr: string;
begin
  with AEditForm, AGrid do
  begin
    HullNoEdit.Text := CellByName['HullNo', ARow].AsString;
    ShipNameEdit.Text :=  CellByName['ShipName', ARow].AsString;
    ProductTypeCB.Text := CellByName['ProdType', ARow].AsString;
    PONoEdit.Text := CellByName['PONo', ARow].AsString;
//    QTNNoEdit.Text := CellByName['QtnNo', ARow].AsString;
    OrderNoEdit.Text := CellByName['OrderNo', ARow].AsString;

    CustomerNameCB.Text := CellByName['CustomerName', ARow].AsString;
    CustomerAddressMemo.Text := CellByName['CustomerAddress', ARow].AsString;

//    QTNInputPicker.Date := CellByName['QtnInputDate', ARow].AsDateTime;
//    OrderInputPicker.Date := CellByName['OrderInputDate', ARow].AsDateTime;
//    InqRecvPicker.Date := CellByName['RecvDate', ARow].AsDateTime;
//    InvoiceIssuePicker.Date := CellByName['InvoiceInputDate', ARow].AsDateTime;

    LStr := CellByName['ClaimServiceKind', ARow].AsString;
    ClaimServiceKindCB.ItemIndex := g_ClaimServiceKind.ToOrdinal(LStr);
    ClaimStatusCombo.ItemIndex := g_ClaimStatus.ToOrdinal(CellByName['ClaimStatus', ARow].AsString);
    LStr := CellByName['Importance', ARow].AsString;
    ImportanceCB.ItemIndex := g_ClaimImportanceKind.ToOrdinal(LStr);

    ClaimRecvPicker.Date := CellByName['ClaimRecvDate', ARow].AsDateTime;
    ClaimInputPicker.Date := CellByName['ClaimInputDate', ARow].AsDateTime;
    ClaimReadyPicker.Date := CellByName['ClaimReadyDate', ARow].AsDateTime;
    ClaimClosedPicker.Date := CellByName['ClaimClosedDate', ARow].AsDateTime;
  end;
end;

procedure TTaskEditF.LoadGSFiles2Form(AGSFile: TSQLGSFile; AForm: TTaskEditF);
begin
  with AForm do
  begin
    try
      FileGrid.BeginUpdate;
      FileGrid.ClearRows;

      if AGSFile.IsUpdate then
        AGSFile.FillRewind;

      while AGSFile.FillOne do
      begin
        LoadGSFile2Form(AGSFile, AForm);
      end;
    finally
      FileGrid.EndUpdate;
    end;
  end;
end;

procedure TTaskEditF.LoadGSFile2Form(AGSFile: TSQLGSFile; AForm: TTaskEditF);
var
//  LSQLGSFileRec: TSQLGSFileRec;
  LRow: integer;
begin
  for LRow := Low(AGSFile.Files) to High(AGSFile.Files) do
  begin
    SQLGSFileRec2Grid(AGSFile.Files[LRow], AForm.FileGrid);
  end;
end;

procedure TTaskEditF.LoadMaterial2Form(AMaterial: TSQLMaterial4Project;
  AForm: TTaskEditF);
begin

end;

procedure TTaskEditF.LoadMaterial4Project2Form(AMaterial: TSQLMaterial4Project;
  AForm: TASMaterialF);
var
  LUtf8: RawUTF8;
  LVar: variant;
begin
  LUtf8 := AMaterial.GetJsonValues(true, true, soSelect);
  SetCompNameValueFromJson2Form(AForm, Utf8ToString(LUtf8));

//  with AForm do
//  begin
//    LRow := MaterialGrid.AddRow();
//
//    MaterialGrid.CellsByName['PORNo', LRow] := AMaterial.PORNo;
//    MaterialGrid.CellsByName['MaterialName', LRow] := AMaterial.MaterialName;
//    MaterialGrid.CellByName['PORIssueDate', LRow].AsDateTime := TimeLogToDateTime(AMaterial.PORIssueDate);
////    MaterialGrid.CellsByName['LeadTime', LRow] := IntToStr(AMaterial.LeadTime);
//    MaterialGrid.CellsByName['FreeOrCharge', LRow] := g_FreeOrCharge.ToString(AMaterial.FreeOrCharge);
//    MaterialGrid.CellsByName['SupplyCount', LRow] := IntToStr(AMaterial.SupplyCount);
////    MaterialGrid.CellsByName['UnitPrice', LRow] := AMaterial.UnitPrice;
//    MaterialGrid.CellsByName['PriceAmount', LRow] := IntToStr(AMaterial.PriceAmount);
//    MaterialGrid.CellByName['ReqDeliveryDate', LRow].AsDateTime := TimeLogToDateTime(AMaterial.ReqDeliveryDate);
//    MaterialGrid.CellByName['ReqArriveDate', LRow].AsDateTime := TimeLogToDateTime(AMaterial.ReqArriveDate);
//    MaterialGrid.CellsByName['DeliveryKind', LRow] := g_DeliveryKind.ToString(AMaterial.DeliveryKind);
//    MaterialGrid.CellsByName['StoreAddress', LRow] := AMaterial.StoreAddress;
//    MaterialGrid.CellsByName['PortName', LRow] := AMaterial.PortName;
//    MaterialGrid.CellsByName['ShippingNo', LRow] := AMaterial.ShippingNo;
//    MaterialGrid.CellsByName['DeliveryCharge', LRow] := AMaterial.DeliveryCharge;
//    MaterialGrid.CellsByName['DeliveryCompany', LRow] := AMaterial.DeliveryCompany;
//    MaterialGrid.CellsByName['AirWayBill', LRow] := AMaterial.AirWayBill;
//    MaterialGrid.CellsByName['TermOfDelivery', LRow] := AMaterial.TermOfDelivery;
//    MaterialGrid.CellsByName['NetWeight', LRow] := AMaterial.NetWeight;
//    MaterialGrid.CellsByName['GrossWeight', LRow] := AMaterial.GrossWeight;
//    MaterialGrid.CellsByName['Measurement', LRow] := AMaterial.Measurement;
//    MaterialGrid.CellsByName['CBM', LRow] := AMaterial.CBM;
//    MaterialGrid.CellsByName['AirWayBill', LRow] := AMaterial.AirWayBill;
//    MaterialGrid.CellsByName['NumOfPkg', LRow] := AMaterial.NumOfPkg;
//    MaterialGrid.CellsByName['DeliveryAddress', LRow] := AMaterial.DeliveryAddress;
//  end;
end;

procedure TTaskEditF.LoadMaterialDetailOrm2Form(
  AMaterialDetail: TSQLMaterialDetail);
var
  LUtf8: RawUtf8;
  LVar: variant;
begin
  LUtf8 :=AMaterialDetail.FillTable.GetJsonValues(True);
//  LUtf8 := AMaterialDetail.GetJsonValues(true, true, soSelect);
  LVar := _JSON(LUtf8);
  LoadMaterialDetailVar2Grid(LVar);
end;

procedure TTaskEditF.LoadMaterialDetailOrmFromForm(
  AMaterialDetail: TSQLMaterialDetail);
var
  LVar: variant;
begin
  TDocVariant.New(LVar);
  LoadMaterialDetailVarFromGrid(LVar);
  LoadRecordPropertyFromVariant(AMaterialDetail, LVar);
end;

procedure TTaskEditF.LoadMaterialDetailVar2Grid(AVar: variant; ARow: integer);
begin
  if ARow = -1 then
  begin
    if TDocVariantData(AVar).IsArray then
      AddNextGridRowsFromVariant2(MaterialGrid, AVar)
    else
      AddNextGridRowFromVariant(MaterialGrid, AVar, True);
  end
  else
    SetNxGridRowFromVar(MaterialGrid, ARow, AVar);
end;

procedure TTaskEditF.LoadMaterialDetailVarFromGrid(var AVar: variant;
  const ARow: integer);
begin
  if ARow = -1 then
    AVar := NextGrid2Variant(MaterialGrid)
  else
    AVar := GetNxGridRow2Variant(MaterialGrid, ARow);
end;

procedure TTaskEditF.LoadMaterialGrid2Variant(AGrid: TNextGrid;
  out AVar: Variant);
begin
  AVar := NextGrid2Variant(MaterialGrid);
end;

procedure TTaskEditF.LoadMaterialGridFromVariant(AGrid: TNextGrid;
  const AVar: Variant);
begin
  AddNextGridRowsFromVariant2(AGrid, AVar);
end;

procedure TTaskEditF.LoadMatGridRow2MaterialDetailOrm(AGrid: TNextGrid;
  ARow: integer; AOrm: TSQLMaterialDetail);
var
  LVar: variant;
begin
  LVar := GetNxGridRow2Variant(AGrid, ARow);
  LoadRecordPropertyFromVariant(AOrm, LVar);
end;

procedure TTaskEditF.LoadSubCon2Form(ASubCon: TSQLSubCon; AForm: TTaskEditF; ARow: integer);
var
  LRow: integer;
  LIDList: TIDList4Invoice;
  LDoc: TDocVariantData;

  procedure AssignGridFromSubCon;
  begin
    SubConGrid.CellsByName['CompanyName', LRow] := ASubCon.CompanyName;
    SubConGrid.CellsByName['CompanyCode', LRow] := ASubCon.CompanyCode;
    SubConGrid.CellsByName['ManagerName', LRow] := ASubCon.ManagerName;
    SubConGrid.CellsByName['EMail', LRow] := ASubCon.EMail;
    SubConGrid.CellsByName['CompanyAddress', LRow] := ASubCon.CompanyAddress;
    SubConGrid.CellsByName['Nation', LRow] := ASubCon.Nation;
    SubConGrid.CellsByName['OfficePhone', LRow] := ASubCon.OfficePhone;
    SubConGrid.CellsByName['MobilePhone', LRow] := ASubCon.MobilePhone;
    SubConGrid.CellsByName['Position', LRow] := ASubCon.Position;
    SubConGrid.CellsByName['ServicePO', LRow] := ASubCon.ServicePO;
    SubConGrid.CellByName['TaskID', LRow].AsInteger := ASubCon.TaskID;
    SubConGrid.CellByName['RowID', LRow].AsInteger := ASubCon.ID;
    SubConGrid.CellsByName['UniqueSubConID', LRow] := ASubCon.UniqueSubConID;
    SubConGrid.CellByName['BusinessAreas', LRow].AsInteger := TBusinessArea_SetToInt(ASubCon.BusinessAreas);
//    SubConGrid.CellByName['ShipProductTypes', ARow].AsInteger := ASubCon.ShipProductTypes;
//    SubConGrid.CellByName['Engine2SProductTypes', ARow].AsInteger := ASubCon.Engine2SProductTypes;
//    SubConGrid.CellsByName['Engine4SProductTypes', ARow] := ASubCon.Engine4SProductTypes;
//    SubConGrid.CellsByName['ElecProductTypes', ARow] := ASubCon.ElecProductTypes;
    SubConGrid.CellByName['ElecProductDetailTypes', LRow].AsInteger := TElecProductDetailType_SetToInt(ASubCon.ElecProductDetailTypes);
    LDoc.InitJSON(ASubCon.InvoiceItems);
    SubConGrid.CellsByName['InvoiceItems', LRow] := LDoc.ToJSON;
    LDoc.InitJSON(ASubCon.InvoiceFiles);
    SubConGrid.CellsByName['InvoiceFiles', LRow] := LDoc.ToJSON;
  end;
begin
  with AForm do
  begin
    SubConGrid.BeginUpdate;
    try
      if ASubCon.IsUpdate then
      begin
        ASubCon.FillRewind;

        while ASubCon.FillOne do
        begin
          if ARow <> -1 then
            LRow := ARow
          else
            LRow := SubConGrid.AddRow();

          AssignGridFromSubCon;
        end;
      end
      else
      begin
        if ARow <> -1 then
          LRow := ARow
        else
          LRow := SubConGrid.AddRow();

        AssignGridFromSubCon;
      end;
    finally
      SubConGrid.EndUpdate();
    end;
  end;
end;

procedure TTaskEditF.LoadSubConGrid2Var(ARow: integer; var ADoc: variant);
var
  LVar: Variant;
  LStr: string;
begin
  LStr := SubConGrid.CellsByName['Action', ARow];
  ADoc.Action := StrToIntDef(LStr, 0);

  ADoc.CompanyName := SubConGrid.CellsByName['CompanyName', ARow];
  ADoc.CompanyName2 := SubConGrid.CellsByName['CompanyName2', ARow];
  ADoc.OfficePhone := SubConGrid.CellsByName['OfficePhone', ARow];
  ADoc.MobilePhone := SubConGrid.CellsByName['MobilePhone', ARow];
  ADoc.EMail := SubConGrid.CellsByName['EMail', ARow];
  ADoc.CompanyCode := SubConGrid.CellsByName['CompanyCode', ARow];
  ADoc.ServicePO := SubConGrid.CellsByName['ServicePO', ARow];
  ADoc.ManagerName := SubConGrid.CellsByName['ManagerName', ARow];
  ADoc.Position := SubConGrid.CellsByName['Position', ARow];
  ADoc.CompanyAddress := SubConGrid.CellsByName['CompanyAddress', ARow];
  ADoc.Nation := SubConGrid.CellsByName['Nation', ARow];
  ADoc.CompanyTypes := TCompanyType_SetToInt(
    String2TCompanyType_Set(SubConGrid.CellsByName['CompanyTypes', ARow]));
  ADoc.FirstName := SubConGrid.CellsByName['FirstName', ARow];
  ADoc.Surname := SubConGrid.CellsByName['Surname', ARow];
  ADoc.SECount := SubConGrid.CellsByName['SECount', ARow];
  ADoc.SubConPrice := SubConGrid.CellsByName['SubConPrice', ARow];
  ADoc.TaskID := SubConGrid.CellsByName['TaskID', ARow];
  ADoc.SubConID := SubConGrid.CellsByName['RowID', ARow];
  ADoc.UniqueSubConID := SubConGrid.CellsByName['UniqueSubConID', ARow];
  ADoc.SubConInvoiceNo := SubConGrid.CellsByName['SubConInvoiceNo', ARow];
  ADoc.BusinessAreas := SubConGrid.CellsByName['BusinessAreas', ARow];
  ADoc.ShipProductTypes := SubConGrid.CellsByName['ShipProductTypes', ARow];
  ADoc.Engine2SProductTypes := SubConGrid.CellsByName['Engine2SProductTypes', ARow];
  ADoc.Engine4SProductTypes := SubConGrid.CellsByName['Engine4SProductTypes', ARow];
  ADoc.ElecProductTypes := SubConGrid.CellsByName['ElecProductTypes', ARow];
  ADoc.ElecProductDetailTypes := SubConGrid.CellsByName['ElecProductDetailTypes', ARow];
  LVar := _JSON(SubConGrid.CellsByName['InvoiceItems', ARow]);
//  ADoc.ItemID := LVar.ItemID;
  ADoc.InvoiceItems := LVar;
  LVar := _JSON(SubConGrid.CellsByName['InvoiceFiles', ARow]);
  ADoc.InvoiceFiles := LVar;
end;

procedure TTaskEditF.LoadSubConList2Form(ASubConList: TObjectList<TSQLSubCon>;
  AForm: TTaskEditF);
var
  i: integer;
  LSubCon: TSQLSubCon;
begin
  for i := 0 to ASubConList.Count - 1 do
  begin
    LSubCon := ASubConList.Items[i];
    LoadSubCon2Form(LSubCon, AForm);
  end;
end;

procedure TTaskEditF.LoadSubConFromVariant2Form(ADoc: variant;
  ADocIsFromInvoiceManage: Boolean; ADocIsFromRemote: Boolean);
var//ADocIsFromInvoiceManage = True인 경우에는 SubCon이 한개이고 False인 경우에는 복수개임(ADoc.SubCon이 [] 배열 형식임)
  LRawUtf8, LSubConCompanyCode: RawUTF8;
  LSQLSubCon: TSQLSubCon;
  LDoc, LDoc2: TDocVariantData;
  LVar: variant;
  i, LRow: integer;

  procedure LoadSubCon2Form_;
  var
    Li: integer;
  begin
    LRow := -1;

    for Li := 0 to SubConGrid.RowCount - 1 do
    begin
      if (SubConGrid.CellsByName['UniqueSubConID', Li] = LSQLSubCon.UniqueSubConID) and
        (SubConGrid.CellsByName['CompanyCode', Li] = LSQLSubCon.CompanyCode) then
      begin
        LRow := Li;
        break;
      end;
    end;

    LoadSubCon2Form(LSQLSubCon, Self, LRow);
  end;
begin
  if ADoc = null then
    exit;

  if ADocIsFromRemote then
    LSQLSubCon := CreateSubConFromVariant2(ADoc)
  else
    LSQLSubCon := CreateSubConFromVariant(ADoc);

  try
    if ADocIsFromRemote then
    begin
      LoadSubCon2Form_;
    end
    else
    if ADocIsFromInvoiceManage then
    begin
//      LDoc.InitJSON(ADoc);
      LoadSubCon2Form_;
    end
    else
    begin
      LDoc.InitJSON(ADoc.SubCon);
      for i := 0 to LDoc.Count - 1 do
      begin
        LVar := _JSON(LDoc.Value[i]);
        LoadSubCon2Form_;
      end;
    end;
  finally
    LSQLSubCon.Free;
  end;
end;

procedure TTaskEditF.LoadTaskEditForm2Grid(AEditForm: TTaskEditF;
  AGrid: TNextGrid; ARow: integer);
begin
  with AEditForm, AGrid do
  begin
    CellByName['HullNo', ARow].AsString := HullNoEdit.Text;
    CellByName['ShipName', ARow].AsString := ShipNameEdit.Text;
    CellByName['ProdType', ARow].AsString := ProductTypeCB.Text;
    CellByName['PONo', ARow].AsString := PONoEdit.Text;
    CellByName['ClaimNo', ARow].AsString := ClaimNoEdit.Text;
    CellByName['OrderNo', ARow].AsString := OrderNoEdit.Text;
    CellByName['CustomerName', ARow].AsString := CustomerNameCB.Text;
    CellByName['CustomerAddress', ARow].AsString := CustomerAddressMemo.Text;

    CellByName['ClaimServiceKind', ARow].AsString := g_ClaimServiceKind.ToString(ClaimServiceKindCB.ItemIndex);
    CellByName['Importance', ARow].AsString := g_ClaimImportanceKind.ToString(ImportanceCB.ItemIndex);
    CellByName['ClaimStatus', ARow].AsString := g_ClaimStatus.ToString(ClaimStatusCombo.ItemIndex);

    CellByName['ClaimRecvDate', ARow].AsDateTime := ClaimRecvPicker.Date;
    CellByName['ClaimInputDate', ARow].AsDateTime := ClaimInputPicker.Date;
    CellByName['ClaimReadyDate', ARow].AsDateTime := ClaimReadyPicker.Date;
    CellByName['ClaimClosedDate', ARow].AsDateTime := ClaimClosedPicker.Date;
  end;
end;

procedure TTaskEditF.LoadTaskForm2Customer(AForm: TTaskEditF;
  ACustomer: TSQLCustomer; ATaskID: TID);
begin
  with AForm do
  begin
    ACustomer.TaskID := ATaskID;
    ACustomer.CompanyName := CustomerNameCB.Text;
    ACustomer.CompanyCode := CustCompanyCodeEdit.Text;
    ACustomer.CompanyTypes := ACustomer.CompanyTypes + IntToTCompanyType_Set(CustCompanyTypeCB.ItemIndex);
    ACustomer.ManagerName := CustManagerEdit.Text;
    ACustomer.Position := CustPositionEdit.Text;
    ACustomer.OfficePhone := CustPhonNumEdit.Text;
    ACustomer.MobilePhone := CustFaxEdit.Text;

    ACustomer.EMail := CustEmailEdit.Text;
    ACustomer.CompanyAddress := CustomerAddressMemo.Text;
    ACustomer.AgentInfo := CustAgentMemo.Text;
    ACustomer.Nation := NationEdit.Text;
  end;
end;

procedure TTaskEditF.LoadTaskForm2GSFiles(AForm: TTaskEditF;
  out AGSFile: TSQLGSFile);
begin

end;

procedure TTaskEditF.LoadTaskForm2MasterCustomer(AForm: TTaskEditF;
  var ACustomer: TSQLMasterCustomer; ATaskID: TID);
begin
  with AForm do
  begin
//    ACustomer.TaskID := ATaskID;
    ACustomer.CompanyName := CustomerNameCB.Text;
    ACustomer.CompanyCode := CustCompanyCodeEdit.Text;
    if CustCompanyTypeCB.ItemIndex <> -1 then
      ACustomer.CompanyTypes := ACustomer.CompanyTypes + IntToTCompanyType_Set(CustCompanyTypeCB.ItemIndex);
    ACustomer.ManagerName := CustManagerEdit.Text;
    ACustomer.Position := CustPositionEdit.Text;
    ACustomer.OfficePhone := CustPhonNumEdit.Text;
    ACustomer.MobilePhone := CustFaxEdit.Text;

    ACustomer.EMail := CustEmailEdit.Text;
    ACustomer.CompanyAddress := CustomerAddressMemo.Text;
//    CustAgentMemo.Text := ACustomer.AgentInfo;
    ACustomer.Nation := NationEdit.Text;
  end;
end;

procedure TTaskEditF.LoadTaskForm2Material(AForm: TTaskEditF;
  AMaterial: TSQLMaterial4Project; ARow: integer);
begin

end;

procedure TTaskEditF.LoadTaskForm2Material4Project(AForm: TTaskEditF;
  AMaterial: TSQLMaterial4Project; ARow: integer);
begin
  with AForm do
  begin
//    while AMaterial.FillOne do
//    begin
      AMaterial.PORNo := MaterialGrid.CellsByName['PORNo', ARow];
      AMaterial.MaterialName := MaterialGrid.CellsByName['MaterialName', ARow];
      AMaterial.PORIssueDate := TimeLogFromDateTime(MaterialGrid.CellByName['PORIssueDate', ARow].AsDateTime);
//      AMaterial.LeadTime := StrToIntDef(MaterialGrid.CellsByName['LeadTime', ARow], 0);
      AMaterial.FreeOrCharge := g_FreeOrCharge.ToOrdinal(MaterialGrid.CellsByName['FreeOrCharge', ARow]);
      AMaterial.SupplyCount := StrToIntDef(MaterialGrid.CellsByName['SupplyCount', ARow], 0);
//      AMaterial.UnitPrice := MaterialGrid.CellsByName['UnitPrice', ARow];
      AMaterial.PriceAmount := StrToIntDef(MaterialGrid.CellsByName['PriceAmount', ARow],0);
      AMaterial.ReqDeliveryDate := TimeLogFromDateTime(MaterialGrid.CellByName['ReqDeliveryDate', ARow].AsDateTime);
      AMaterial.ReqArriveDate := TimeLogFromDateTime(MaterialGrid.CellByName['ReqArriveDate', ARow].AsDateTime);
      AMaterial.DeliveryKind := g_DeliveryKind.ToOrdinal(MaterialGrid.CellsByName['DeliveryKind', ARow]);
      AMaterial.StoreAddress := MaterialGrid.CellsByName['StoreAddress', ARow];
      AMaterial.PortName := MaterialGrid.CellsByName['PortName', ARow];
      AMaterial.ShippingNo := MaterialGrid.CellsByName['ShippingNo', ARow];
      AMaterial.DeliveryCharge := MaterialGrid.CellsByName['DeliveryCharge', ARow];
      AMaterial.DeliveryCompany := MaterialGrid.CellsByName['DeliveryCompany', ARow];
      AMaterial.AirWayBill := MaterialGrid.CellsByName['AirWayBill', ARow];
      AMaterial.TermOfDelivery := MaterialGrid.CellsByName['TermOfDelivery', ARow];
      AMaterial.NetWeight := MaterialGrid.CellsByName['NetWeight', ARow];
      AMaterial.GrossWeight := MaterialGrid.CellsByName['GrossWeight', ARow];
      AMaterial.Measurement := MaterialGrid.CellsByName['Measurement', ARow];
      AMaterial.CBM := MaterialGrid.CellsByName['CBM', ARow];
      AMaterial.AirWayBill := MaterialGrid.CellsByName['AirWayBill', ARow];
      AMaterial.NumOfPkg := MaterialGrid.CellsByName['NumOfPkg', ARow];
      AMaterial.DeliveryAddress := MaterialGrid.CellsByName['DeliveryAddress', ARow];
//    end;
  end;
end;

procedure TTaskEditF.LoadTaskForm2Material4ProjectNSave2DB(ATaskID: TID);//AOrm: TSQLMaterial4Project);
var
  LVar: variant;
  LMaterial: TSQLMaterial4Project;
begin
  LMaterial := GetMaterial4ProjFromTaskID(ATaskID);
  try
    LVar := _JSON(FMatDeliveryInfoJson);
    LoadRecordPropertyFromVariant(LMaterial, LVar);

    if LMaterial.IsUpdate then
    begin
      if LMaterial.TaskID = 0 then
        LMaterial.TaskID := ATaskID;
    end
    else
      LMaterial.TaskID := ATaskID;

    AddOrUpdateMaterial4Project(LMaterial);
  finally
    LMaterial.Free;
  end;
end;

procedure TTaskEditF.LoadTaskForm2MaterialDetailNSave2DB(AForm: TTaskEditF;
  ATaskID: TID);
var
  LRow: integer;
//  LPorNo, LMatCode: string;
  LStr: string;
  LID: TID;
  LMatDetail: TSQLMaterialDetail;
begin
  with AForm.MaterialGrid do
  begin
    //Grid에서 POR No 가져와서 DB 조회함
    for LRow := 0 to RowCount - 1 do
    begin
      LStr := CellsByName['ID', LRow];
      LID := StrToInt64Def(LStr, 0);
//      LPorNo := CellsByName['PORNo', LRow];
//      LMatCode := CellsByName['MaterialCode', LRow];

//      LMatDetail := GetMaterialDetailByPorNoNMatCode(LPorNo, LMatCode);
      LMatDetail := GetMaterialDetailFromID(LID);
      try
        if Row[LRow].Visible then
        begin
          LoadMatGridRow2MaterialDetailOrm(AForm.MaterialGrid, LRow, LMatDetail);

          if LMatDetail.IsUpdate then
          begin
          end
          else
          begin
          end;

          LMatDetail.TaskID := ATaskID;
          AddOrUpdateMaterialDetail(LMatDetail);
        end
        else//Visuble = False면 삭제한 Item임
        begin
          g_HiASMaterialDetailDB.Delete(TSQLMaterialDetail, LMatDetail.ID);
        end;
      finally
        LMatDetail.Free;
      end;
    end;//for
  end;//with
end;

procedure TTaskEditF.LoadTaskForm2MaterialNSave2DB(AForm: TTaskEditF;
  ATaskID: TID);
begin

end;

procedure TTaskEditF.SaveSubConFromForm(AForm: TTaskEditF; ATaskID: TID);
var
  LRow, i: integer;
  LSubConID: TID;
  LSubCon: TSQLSubCon;
  LItemList: TObjectList<TSQLSubConInvoiceItem>;
  LFileList: TObjectList<TSQLSubConInvoiceFile>;
  LDocSubCon, LDocItem, LDocFile: variant;
  LAction: integer;
  LStr: string;

  procedure LoadSubConFromGrid;
  begin
    LSubCon.TaskID := ATaskID;
    LSubCon.CompanyName := SubConGrid.CellsByName['CompanyName', i];
    LSubCon.CompanyCode := SubConGrid.CellsByName['CompanyCode', i];
    LSubCon.ManagerName := SubConGrid.CellsByName['ManagerName', i];
    LSubCon.EMail := SubConGrid.CellsByName['EMail', i];
    LSubCon.CompanyAddress := SubConGrid.CellsByName['CompanyAddress', i];
    LSubCon.OfficePhone := SubConGrid.CellsByName['OfficePhone', i];
    LSubCon.MobilePhone := SubConGrid.CellsByName['MobilePhone', i];
    LSubCon.Position := SubConGrid.CellsByName['Position', i];
    LSubCon.Nation := SubConGrid.CellsByName['Nation', i];
    LSubCon.ServicePO := SubConGrid.CellsByName['ServicePO', i];
    LSubCon.SubConInvoiceNo := SubConGrid.CellsByName['SubConInvoiceNo', i];
    LSubCon.UniqueSubConID := SubConGrid.CellsByName['UniqueSubConID', i];
    LSubCon.BusinessAreas := IntToTBusinessArea_Set(SubConGrid.CellByName['BusinessAreas', i].AsInteger);
//    LSubCon.ShipProductTypes := SubConGrid.CellsByName['ShipProductTypes', i];
//    LSubCon.Engine2SProductTypes := SubConGrid.CellsByName['Engine2SProductTypes', i];
//    LSubCon.Engine4SProductTypes := SubConGrid.CellsByName['Engine4SProductTypes', i];
//    LSubCon.ElecProductTypes := SubConGrid.CellsByName['ElecProductTypes', i];
    LSubCon.ElecProductDetailTypes := IntToTElecProductDetailType_Set(SubConGrid.CellByName['ElecProductDetailTypes', i].AsInteger);

    if LSubCon.UniqueSubConID = '' then
    begin
      LStr := NewGUID;
      LStr := StringReplace(LStr, '{', '', [rfReplaceAll]);
      LStr := StringReplace(LStr, '}', '', [rfReplaceAll]);

      LSubCon.UniqueSubConID := LStr;
    end;

    AddOrUpdateSubCon(LSubCon);

    if not LSubCon.IsUpdate then
    begin
      LSubCon.IsUpdate := True;

//      LSubCon.SubConID := LSubCon.ID;
      AddOrUpdateSubCon(LSubCon);
    end;

    LDocItem := _JSON(SubConGrid.CellsByName['InvoiceItems', i]);
    LDocFile := _JSON(SubConGrid.CellsByName['InvoiceFiles', i]);

    if (LAction = 0) or (LAction = 3) then
      DeleteSubConInvoiceItemNFileFromUniqueSubConID(LSubCon.UniqueSubConID);

    LoadSubConInvoiceItemListFromVariant(LDocItem, LItemList);
    SaveSubConInvoiceItemList2DB(LItemList);
    LoadSubConInvoiceFileListFromVariantWithSQLSubConInvoiceFile(LDocFile, LFileList);
    SaveSubConInvoiceFileList2DB(LFileList);
  end;
begin
  LItemList := TObjectList<TSQLSubConInvoiceItem>.Create;
  LFileList := TObjectList<TSQLSubConInvoiceFile>.Create;
  TDocVariant.New(LDocSubCon);
  try
    with AForm.SubConGrid do
    begin
      //Grid에서 SubConID 가져와서 DB 조회함
      for LRow := 0 to RowCount - 1 do
      begin
        //SubConID를 RowID로 대체함
        LSubConID := StrToIntDef(CellsByName['RowID', LRow],0);
        LSubCon := GetSubConFromTaskIDNSubConID(ATaskID, LSubConID);
        try
          if Row[LRow].Visible then
          begin
            LoadSubConGrid2Var(LRow, LDocSubCon);
            LoadSubConFromVariant(LSubCon, LDocSubCon, False);

            if LSubCon.IsUpdate then
            begin
            end
            else
            begin
              LSubCon.TaskID := ATaskID;
            end;

            AddOrUpdateSubCon(LSubCon);
          end
          else//Visuble = False면 삭제한 Item임
          begin
            g_HiASSubConDB.Delete(TSQLSubCon, LSubCon.ID);
          end;
        finally
          LSubCon.Free;
        end;
      end;//for
    end;//with

//      for i := 0 to SubConGrid.RowCount - 1 do
//      begin
//        //Action이 없을 경우 Add or Update함
//        LAction := StrToIntDef(SubConGrid.CellsByName['Action', i],0);
//
//        case LAction of
//          0: begin
////            LSubConID := StrToIntDef(SubConGrid.CellsByName['RowID', i], -1);
////            LSubCon := GetSubConFromSubConID(LSubConID);
//            LUniqueSubConID := SubConGrid.CellsByName['UniqueSubConID', i];
//            LSubCon := GetSubConFromUniqueSubConID(LUniqueSubConID);
//            try
//              LoadSubConFromGrid;
//            finally
//              LSubCon.Free;
//            end;
//          end;
//          1: begin //Add
//            LSubCon := TSQLSubCon.Create;
//            try
//              LoadSubConFromGrid;
//            finally
//              LSubCon.Free;
//            end;
//          end;
//          2: begin //Delete
////            LSubConID := StrToIntDef(SubConGrid.CellsByName['RowID', i], -1);
////            LSubCon := GetSubConFromSubConID(LSubConID);
//            LUniqueSubConID := SubConGrid.CellsByName['UniqueSubConID', i];
//            LSubCon := GetSubConFromUniqueSubConID(LUniqueSubConID);
//            try
//              if LSubCon.IsUpdate then
//              begin
//                DeleteSubConFromSubConID(LSubCon.ID);
//                DeleteSubConInvoiceItemNFileFromUniqueSubConID(LUniqueSubConID);
//              end;
//            finally
//              LSubCon.Free;
//            end;
//          end;
//          3: begin //Update
////            LSubConID := StrToIntDef(SubConGrid.CellsByName['RowID', i], -1);
////            LSubCon := GetSubConFromSubConID(LSubConID);
//            LUniqueSubConID := SubConGrid.CellsByName['UniqueSubConID', i];
//            LSubCon := GetSubConFromUniqueSubConID(LUniqueSubConID);
//            try
//              if LSubCon.IsUpdate then
//                LoadSubConFromGrid;
//            finally
//              LSubCon.Free;
//            end;
//          end;
//        end;
//      end;
//    end;
  finally
    LFileList.Clear;
    LFileList.Free;
    LItemList.Clear;
    LItemList.Free;
  end;
end;

procedure TTaskEditF.LoadTaskForm2TaskOrm(AForm: TTaskEditF; out AVar: TOrmHiconisASTask);
var
//  LSubConsArr: TRawUtf8DynArray;
  i: integer;
begin
  with AForm do
  begin
    AVar.HullNo := HullNoEdit.Text;
    AVar.ShipName := ShipNameEdit.Text;
//    AVar.ReqCustomer := CustomerNameEdit.Text;
    AVar.PO_No := PONoEdit.Text;
//    AVar.QTN_No := QTNNoEdit.Text;
    AVar.Order_No := OrderNoEdit.Text;
    AVar.ProductType := ProductTypeCB.Text;
    Avar.WorkSummary := WorkSummaryEdit.Text;
//    AVar.SubConPrice := SubConPriceEdit.Text;
    Avar.NationPort := NationPortEdit.Text;
    Avar.EtcContent := EtcContentMemo.Text;
    AVar.CurrentWorkStatus := g_HiconisASState.ToOrdinal(CurWorkCB.Text);
    AVar.NextWork := g_HiconisASTrigger.ToOrdinal(NextWorkCB.Text);
    AVar.SalesProcessType := g_SalesProcessType.ToType(SalesProcTypeCB.ItemIndex);
    AVar.ShipOwner := ShipOwnerEdit.Text;
//    AVar.CompanyType := TCompanyType(CustCompanyTypeCB.ItemIndex);
    AVar.SEList := '';//SEEdit.Text;
//    AVar.SECount := StrToIntDef(SECountEdit.Text,0);
    AVar.SalesPrice := SalesPriceEdit.Text;
    AVar.ExchangeRate := ExchangeRateEdit.Text;
//    AVar.ShippingNo := ShippingNoEdit.Text;
    AVar.CurrencyKind := CurrencyKindCB.ItemIndex;

    AVar.BaseProjectNo := BaseProjectNoEdit.Text;
    AVar.DeliveryCondition := DeliveryConditionCB.ItemIndex;
    AVar.EstimateType := EstimateTypeCB.ItemIndex;
    AVar.TermsOfPayment := TermsPaymentCB.ItemIndex;

//    AVar.QTNInputDate := TimeLogFromDateTime(QTNInputPicker.Date);
//    AVar.OrderInputDate := TimeLogFromDateTime(OrderInputPicker.Date);
//    AVar.InvoiceIssueDate := TimeLogFromDateTime(InvoiceIssuePicker.Date);
//    Avar.QTNIssueDate := TimeLogFromDateTime(QtnIssuePicker.Date);
//    AVar.InqRecvDate := TimeLogFromDateTime(InqRecvPicker.Date);
    Avar.AttendScheduled := TimeLogFromDateTime(AttendSchedulePicker.Date);
    Avar.WorkBeginDate := TimeLogFromDateTime(WorkBeginPicker.Date);
    Avar.WorkEndDate := TimeLogFromDateTime(WorkEndPicker.Date);
    AVar.CurWorkFinishDate := TimeLogFromDateTime(CurWorkFinishPicker.Date);
//    AVar.SRRecvDate := TimeLogFromDateTime(SRRecvDatePicker.Date);
//    AVar.SubConInvoiceIssueDate := TimeLogFromDateTime(SubConInvoiceIssuePicker.Date);
    AVar.SalesReqDate := TimeLogFromDateTime(SalesReqPicker.Date);
    AVar.ShippingDate := TimeLogFromDateTime(ShippingDatePicker.Date);

    AVar.ASServiceChargeType := ServiceChargeCB.ItemIndex;
    Avar.ClaimNo := ClaimNoEdit.Text;
    Avar.ClaimReason := ClaimReasonMemo.Text;
    Avar.Importance := ImportanceCB.ItemIndex;
    Avar.ClaimServiceKind := ClaimServiceKindCB.ItemIndex;
    Avar.ClaimStatus := ClaimStatusCombo.ItemIndex;
    AVar.ClaimCategory := Category1.Tag;
    AVar.ClaimLocation := Location1.Tag;
    AVar.ClaimCauseKind := CauseKind1.Tag;
    AVar.ClaimCauseHW := CauseHW1.Tag;
    AVar.ClaimCauseSW := CauseSW1.Tag;
    Avar.ClaimRecvDate := TimeLogFromDateTime(ClaimRecvPicker.Date);
    Avar.ClaimInputDate := TimeLogFromDateTime(ClaimInputPicker.Date);
    Avar.ClaimReadyDate := TimeLogFromDateTime(ClaimReadyPicker.Date);
    Avar.ClaimClosedDate := TimeLogFromDateTime(ClaimClosedPicker.Date);

    AVar.ModifyDate := TimeLogFromDateTime(now);
  end;
end;

procedure TTaskEditF.LoadTaskForm2Variant(AForm: TTaskEditF; out AVar: Variant);
var
  LJson: string;
begin
  LJson := GetCompNameValue2JsonFromForm(AForm);

  AVar := _JSON(StringToUtf8(LJson));
end;

procedure TTaskEditF.LoadTaskFormFromVariant(AForm: TTaskEditF;
  const AVar: Variant);
var
  LJson: string;
begin
  LJson := VariantToString(AVar);
  SetCompNameValueFromJson2Form(AForm, LJson);
end;

procedure TTaskEditF.LoadTaskOrm2Form(AVar: TOrmHiconisASTask; AForm: TTaskEditF);
var
//  LCurrentState: THiconisASState;
  LStr: string;
begin
  with AForm do
  begin
    if AVar.UniqueTaskID = '' then
    begin
      LStr := NewGUID;
      LStr := StringReplace(LStr, '{', '', [rfReplaceAll]);
      LStr := StringReplace(LStr, '}', '', [rfReplaceAll]);

      AVar.UniqueTaskID := LStr;
    end;

    FEmailDisplayTask := AVar;
    FEmailDisplayTask.TaskID := AVar.TaskID;

    HullNoEdit.Text := AVar.HullNo;
    ShipNameEdit.Text := AVar.ShipName;
//    CustomerNameEdit.Text := AVar.ReqCustomer;
//    QTNNoEdit.Text := AVar.QTN_No;
//    SubConPriceEdit.Text := AVar.SubConPrice;
//    SEEdit.Text := AVar.SEList;
//    SECountEdit.Text := IntToStr(AVar.SECount);
//    SRRecvDatePicker.Date := TimeLogToDateTime(AVar.SRRecvDate);
//    SubConInvoiceIssuePicker.Date := TimeLogToDateTime(AVar.SubConInvoiceIssueDate);
    PONoEdit.Text := AVar.PO_No;
    OrderNoEdit.Text := AVar.Order_No;
    ProductTypeCB.ItemIndex := g_ElecProductType.ToOrdinal(AVar.ProductType);
    WorkSummaryEdit.Text := Avar.WorkSummary;

    NationPortEdit.Text := Avar.NationPort;
    EtcContentMemo.Text := Avar.EtcContent;
    SalesProcTypeCB.ItemIndex := Ord(AVar.SalesProcessType);
    ShipOwnerEdit.Text := AVar.ShipOwner;
    SalesPriceEdit.Text := AVar.SalesPrice;
    ExchangeRateEdit.Text := AVar.ExchangeRate;
//    ShippingNoEdit.Text := AVar.ShippingNo;
    CurrencyKindCB.ItemIndex := AVar.CurrencyKind;
    BaseProjectNoEdit.Text := AVar.BaseProjectNo;
    DeliveryConditionCB.ItemIndex := AVar.DeliveryCondition;
    EstimateTypeCB.ItemIndex := AVar.EstimateType;
    TermsPaymentCB.ItemIndex := AVar.TermsOfPayment;
    ChargeInPersonIdEdit.Text := AVar.ChargeInPersonId;
//    CompanyTypeCB.ItemIndex := Ord(AVar.CompanyType);
//    ManagerDepartmentEdit.Text :=

//    LCurrentState := g_HiconisASState.ToType(AVar.CurrentWorkStatus);//Ord(AVar.SalesProcessType)

    if Assigned(FSalesProcessList) then
      FreeAndNil(FSalesProcessList);

//    CurWorkCB.Items.Assign(FSalesProcessList);
//    CurWorkCB.ItemIndex := FSalesProcessList.IndexOf(g_SalesProcess.ToString(
//      AVar.CurrentWorkStatus));
//    NextWorkCB.ItemIndex := FSalesProcessList.IndexOf(g_SalesProcess.ToString(
//      AVar.NextWork));
//    end;
//    FillNextWorkCB(CurWorkCB.ItemIndex);

//    QTNInputPicker.Date := TimeLogToDateTime(AVar.QTNInputDate);
//    OrderInputPicker.Date := TimeLogToDateTime(AVar.OrderInputDate);
//    InvoiceIssuePicker.Date := TimeLogToDateTime(AVar.InvoiceIssueDate);
//    QtnIssuePicker.Date := TimeLogToDateTime(Avar.QTNIssueDate);
//    InqRecvPicker.Date := TimeLogToDateTime(AVar.InqRecvDate);
    AttendSchedulePicker.Date := TimeLogToDateTime(Avar.AttendScheduled);
    WorkBeginPicker.Date := TimeLogToDateTime(Avar.WorkBeginDate);
    WorkEndPicker.Date := TimeLogToDateTime(Avar.WorkEndDate);
    CurWorkFinishPicker.Date := TimeLogToDateTime(AVar.CurWorkFinishDate);
    SalesReqPicker.Date := TimeLogToDateTime(AVar.SalesReqDate);
    ShippingDatePicker.Date := TimeLogToDateTime(AVar.ShippingDate);

    ServiceChargeCB.ItemIndex := AVar.ASServiceChargeType;
    ClaimNoEdit.Text := Avar.ClaimNo;
    ClaimReasonMemo.Text := Avar.ClaimReason;
    ImportanceCB.ItemIndex := Avar.Importance;
    ClaimStatusCombo.ItemIndex := Avar.ClaimStatus;

    ClaimServiceKindCB.ItemIndex := Avar.ClaimServiceKind;
    InitCurWorkCB();
    //ClaimServiceKindCB OnChange 이벤트에 CurWorkCB Fill-In 됨
    //때문에 ClaimServiceKindCB 변경 이후에 CurWorkCB를 선택해야 함
    CurWorkCB.ItemIndex := CurWorkCB.Items.IndexOf(g_HiconisASState.ToString(AVar.CurrentWorkStatus));
    InitNextWorkCB();
    //CurWorkCB OnChange 이벤트에 NextWorkCB Fill-In 됨
    //때문에 CurWorkCB 변경 이후에 NextWorkCB 선택해야 함
    NextWorkCB.ItemIndex := NextWorkCB.Items.IndexOf(g_HiconisASTrigger.ToString(AVar.NextWork));

    Category1.Tag := AVar.ClaimCategory;
    Location1.Tag := AVar.ClaimLocation;
    CauseKind1.Tag := AVar.ClaimCauseKind;
    CauseHW1.Tag := AVar.ClaimCauseHW;
    CauseSW1.Tag := AVar.ClaimCauseSW;
    ClaimRecvPicker.Date := TimeLogToDateTime(Avar.ClaimRecvDate);
    ClaimInputPicker.Date := TimeLogToDateTime(Avar.ClaimInputDate);
    ClaimReadyPicker.Date := TimeLogToDateTime(Avar.ClaimReadyDate);
    ClaimClosedPicker.Date := TimeLogToDateTime(Avar.ClaimClosedDate);

    FSQLGSFiles := GetFilesFromTask(AVar);
    LoadGSFiles2Form(FSQLGSFiles, AForm);
  end;
end;

procedure TTaskEditF.Location1Click(Sender: TObject);
begin
  Location1.Tag := ShowCheckGrp4Claim(Ord(ctkLocation), Location1.Tag);
end;

function TTaskEditF.MakeCompanyInfoFromGrid2JSON: string;
var
  LVar: variant;
  LRaw: RawByteString;
  LUtf8: RawUTF8;
  LRow: integer;
begin
  LRow := SubConGrid.SelectedRow;

  if LRow = -1 then
    exit;

  TDocVariant.New(LVar);

  LVar.CompanyName := SubConGrid.CellsByName['CompanyName', LRow];
  LVar.CompanyCode := SubConGrid.CellsByName['CompanyCode', LRow];
  LVar.CompanyAddress := SubConGrid.CellsByName['CompanyAddress', LRow];
  LVar.CompanyType := SubConGrid.CellsByName['CompanyType', LRow];
  LVar.Nation := SubConGrid.CellsByName['Nation', LRow];
  LVar.EMail := SubConGrid.CellsByName['EMail', LRow];

  LUtf8 := LVar;
  LRaw := LUtf8;
  LRaw := SynLZCompress(LRaw);
  LUtf8 := BinToBase64(LRaw);
  Result := UTF8ToString(LUtf8);
end;

procedure TTaskEditF.MaterialDetailEdit(const ARow: integer);
var
  LVar: variant;
begin
  if PORNoEdit.Text = '' then
  begin
    ShowMessage('POR No가 공란입니다.' + #13#10 + '"배송정보" 버튼을 이용하여 POR No를 먼저 생성하세요.');
    exit;
  end;

  if ARow = -1 then //Add
  begin
    TDocVariant.New(LVar);
    LVar.MaterialCode := '';
  end
  else
  begin
    LVar := GetNxGridRow2Variant(MaterialGrid, ARow);
  end;

  LVar.PORNo := PORNoEdit.Text;

  //"저장" 버튼을 누르면 True
  if DisplayMaterialDetail2EditForm(LVar) = mrOK then
    LoadMaterialDetailVar2Grid(LVar, ARow);
//    AddOrUpdateMaterial2GridFromVar(LDoc, ARow);
end;

procedure TTaskEditF.MaterialEdit();
var
  LDoc: variant;
begin
  if FMatDeliveryInfoJson = '' then //Add
  begin
    TDocVariant.New(LDoc);
    LDoc.PorNo := '';
  end
  else
  begin
    LDoc := _JSON(StringToUtf8(FMatDeliveryInfoJson));
  end;

  LDoc.TaskID := FTask.ID;
  //"저장" 버튼을 누르면 True
  if DisplayMaterial2EditForm(LDoc, FHiASIniConfig) then
  begin
    FMatDeliveryInfoJson := Utf8ToString(LDoc);
    PORNoEdit.Text := GetPorNoFromJson(FMatDeliveryInfoJson);
  end;
//    AddOrUpdateMaterial2GridFromVar(LDoc, ARow);
//  if DisplayMaterial2EditForm(LDoc) then
//    AddOrUpdateMaterial2GridFromVar(LDoc, ARow);
end;

procedure TTaskEditF.N18Click(Sender: TObject);
begin
//  SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, FEmailDisplayTask,
//    HiconisASManageF.TDTF.FSettings,
//    HiconisASManageF.TDTF.GetRecvEmailAddress(TMenuItem(Sender).Tag));
end;

procedure TTaskEditF.N19Click(Sender: TObject);
begin
//  SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, FEmailDisplayTask,
//    HiconisASManageF.TDTF.FSettings,
//    HiconisASManageF.TDTF.GetRecvEmailAddress(TMenuItem(Sender).Tag));
end;

procedure TTaskEditF.N20Click(Sender: TObject);
begin
//  SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, FEmailDisplayTask,
//    HiconisASManageF.TDTF.FSettings,
//    HiconisASManageF.TDTF.GetRecvEmailAddress(TMenuItem(Sender).Tag));
end;

procedure TTaskEditF.N21Click(Sender: TObject);
begin
//  SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, FEmailDisplayTask,
//    HiconisASManageF.TDTF.FSettings,
//    HiconisASManageF.TDTF.GetRecvEmailAddress(TMenuItem(Sender).Tag));
end;

procedure TTaskEditF.N22Click(Sender: TObject);
begin
//  SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, FEmailDisplayTask,
//    HiconisASManageF.TDTF.FSettings,
//    HiconisASManageF.TDTF.GetRecvEmailAddress(TMenuItem(Sender).Tag));
end;

procedure TTaskEditF.N23Click(Sender: TObject);
var
  LRec: Doc_ServiceOrder_Rec;
begin
  LRec := Get_Doc_ServiceOrder_Rec;

  if CheckDocCompanySelection(LRec) then
    MakeDocCompanySelection(LRec,TMenuItem(Sender).Tag);
end;

procedure TTaskEditF.N24Click(Sender: TObject);
var
  LRec: Doc_ServiceOrder_Rec;
begin
  LRec := Get_Doc_ServiceOrder_Rec;

  if CheckDocCompanySelection(LRec) then
    MakeDocCompanySelection(LRec,TMenuItem(Sender).Tag);
end;

procedure TTaskEditF.N26Click(Sender: TObject);
begin
  SendCmd4CreateMail(TMenuItem(Sender).Tag);
end;

procedure TTaskEditF.N3Click(Sender: TObject);
var
  LRec: Doc_ServiceOrder_Rec;
begin
  LRec := Get_Doc_ServiceOrder_Rec;
  MakeDocConfirmComplete(LRec);
end;

procedure TTaskEditF.N8Click(Sender: TObject);
var
  LRec: Doc_Cust_Reg_Rec;
begin
  LRec := Get_Doc_Cust_Reg_Rec;
  MakeDocCustomerRegistration(LRec);
end;

procedure TTaskEditF.NextGrid1CellDblClick(Sender: TObject; ACol,
  ARow: Integer);
var
  LVar: variant;
begin
  TDocVariant.New(LVar);
  LoadMaterialDetailVarFromGrid(LVar, ARow);

  //"적용" 버튼을 누른 경우 True
  if DisplayMaterialDetail2EditForm(LVar) = mrOK then
    LoadMaterialDetailVar2Grid(LVar, ARow);
end;

procedure TTaskEditF.NextWorkCBDropDown(Sender: TObject);
begin
//  if CurWorkCB.Items.Count = 0 then
//    FillNextWorkCB(CurWorkCB.ItemIndex);
end;

procedure TTaskEditF.oCustomer1Click(Sender: TObject);
var
  LRec: Doc_Qtn_Rec;
begin
  LRec := Get_Doc_Qtn_Rec;
  MakeDocQtn(LRec);
end;

procedure TTaskEditF.OnGetStream(
  Sender: TFileContentsStreamOnDemandClipboardFormat; Index: integer;
  out AStream: IStream);
var
  Stream: TMemoryStream;
  Data: AnsiString;
  i: integer;
  SelIndex: integer;
  Found: boolean;
begin
  // This event handler is called by TFileContentsStreamOnDemandClipboardFormat
  // when the drop target requests data from the drop source (that's us).
  Stream := TMemoryStream.Create;
  try
    AStream := nil;
    // Find the listview item which corresponds to the requested data item.
    SelIndex := 0;
    Found := False;

    for i := 0 to FileGrid.RowCount-1 do
    begin
      if (FileGrid.Row[i].Selected) then
      begin
        if (SelIndex = Index) then
        begin
          if Assigned(FSQLGSFiles) then
          begin
            Data := FSQLGSFiles.Files[i].fData;
            Found := True;
            break;
          end;
        end;
        inc(SelIndex);
      end;
    end;

    if (not Found) then
      exit;

    // ...Write the file contents to a regular stream...
    Stream.Write(PAnsiChar(Data)^, Length(Data));

    (*
    ** Stream.Position must be equal to Stream.Size or the Windows clipboard
    ** will fail to read from the stream. This requirement is completely
    ** undocumented.
    *)
    // Stream.Position := 0;

    // ...and return the stream back to the target as an IStream. Note that the
    // target is responsible for deleting the stream (via reference counting).
    AStream := TFixedStreamAdapter.Create(Stream, soOwned);
  except
    Stream.Free;
    raise;
  end;
end;

procedure TTaskEditF.OnGetStream2(
  Sender: TFileContentsStreamOnDemandClipboardFormat; Index: integer;
  out AStream: IStream);
var
  LStream: TStringStream;
begin
  LStream := TStringStream.Create;
  try
    LStream.WriteString(FTaskJson);
    AStream := nil;
    AStream := TFixedStreamAdapter.Create(LStream, soOwned);
  except
    raise;
  end;
end;

procedure TTaskEditF.OrderNoEditClickBtn(Sender: TObject);
begin
  OrderNoEdit.Text := GetOrderNoFromHullNo(HullNoEdit.Text);
end;

procedure TTaskEditF.ProductTypeCBDropDown(Sender: TObject);
begin
  g_ElecProductType.SetType2Combo(ProductTypeCB);
end;

procedure TTaskEditF.ShowDTIForm;
//var
//  LDisplayTaskInfoF: TDisplayTaskInfoF;
//  LIdList: TIDList;
//  LRow: integer;
//  LGrid: TNextGrid;
begin
//  if MessageDlg('대표메일을 선택하면 현재 화면에 입력한 내용은 저장 되지 않고' + #13#10 +
//                '대표메일의 내용으로 대체 됩니다.' + #13#10 + '그래도 계속 하시겠습니까?'
//                , mtConfirmation, [mbYes, mbNo], 0)= mrNo then
//  begin
//    exit;
//  end;
//
//  LDisplayTaskInfoF := TDisplayTaskInfoF.Create(nil);
//  try
//    if LDisplayTaskInfoF.ShowModal = mrOK then
//    begin
//      LRow := LDisplayTaskInfoF.FSelectedRow;
//
//      if LRow <> -1 then
//      begin
//        LGrid := LDisplayTaskInfoF.TDisplayTaskF1.grid_Req;
//        if LGrid.Row[LRow].Data <> nil then
//        begin
//          if Assigned(FTask) then
//            FTask.Free;
//
//          FTask := nil;
//          LIdList := TIDList(LGrid.Row[LRow].Data);
//          FTask := CreateOrGetLoadTask(LIdList.fTaskId);
//        end;
//      end;
//    end;
//  finally
//    LDisplayTaskInfoF.Free;
//  end;
end;

class procedure TTaskEditF.ShowEMailListFromTask(ATask: TOrmHiconisASTask;
  AOLEmailSrchRec: TOLEmailSrchRec;
  ARemoteIPAddress, APort, ARoot: string);
var
  LViewMailListF: TOLEmailListF;
  LUtf8: RawUTF8;
begin
  LViewMailListF := TOLEmailListF.Create(nil);
  try
    begin
      LViewMailListF.OLEmailListFr.InitVarFromOwner(AOLEmailSrchRec);

      if ARemoteIPAddress = '' then
        LoadEmailListFromTask(ATask, LViewMailListF)
      else
      begin
        LViewMailListF.OLEmailListFr.FRemoteIPAddress := ARemoteIPAddress;
        LUtf8 := IntToStr(ATask.TaskID);
//        LUtf8 := SendReq2Server_Http(ARemoteIPAddress, APort, ARoot,
//          CMD_REQ_TASK_EAMIL_LIST, LUtf8);
        LUtf8 := MakeBase64ToUTF8(LUtf8);
//        ShowEmailListFromJson(LViewMailListF.OLEmailListFr.grid_Mail, LUtf8);
      end;

      if LViewMailListF.ShowModal = mrOK then
      begin
      end;
    end;
  finally
    LViewMailListF.Free;
  end;
end;

procedure TTaskEditF.ShowFileSelectF(AFileName: string;
  AFromOutLook: Boolean);
var
  li,le : integer;
  lfilename : String;
  lExt : String;
  lSize : int64;
  LFileSelectF: TFileSelectF;
  LSQLGSFileRec: TSQLGSFileRec;
  LDoc: RawByteString;
  i: integer;
begin
  LFileSelectF := TFileSelectF.Create(nil);
  try
    //Drag 했을 경우 AFileName <> ''이고
    //Task Edit 화면에서 추가 버튼을 눌렀을 경우 AFileName = ''임
    if AFileName <> '' then
      LFileSelectF.JvFilenameEdit1.FileName := AFileName;

    g_GSDocType.SetType2Combo(LFileSelectF.DocTypeCombo);

    if LFileSelectF.ShowModal = mrOK then
    begin
      if LFileSelectF.JvFilenameEdit1.FileName = '' then
        exit;

      lfilename := ExtractFileName(LFileSelectF.JvFilenameEdit1.FileName);

      with fileGrid do
      begin
        BeginUpdate;
        try
          if AFileName <> '' then
            LDoc := FFileContent
          else
            LDoc := StringFromFile(LFileSelectF.JvFilenameEdit1.FileName);

          LSQLGSFileRec.fData := LDoc;
          LSQLGSFileRec.fGSDocType := g_GSDocType.ToOrdinal(LFileSelectF.DocTypeCombo.Text);
          LSQLGSFileRec.fFilename := lfilename;
          lsize := Length(LDoc);

          if not Assigned(FSQLGSFiles) then
            FSQLGSFiles := TSQLGSFile.Create;

          i := FSQLGSFiles.DynArray('Files').Add(LSQLGSFileRec);
          AddRow;
          CellByName['FileName',RowCount-1].AsString := lfilename;
          CellByName['FileSize',RowCount-1].AsString := IntToStr(lsize);
          CellByName['FilePath',RowCount-1].AsString := LFileSelectF.JvFilenameEdit1.FileName;
          CellByName['DocType',RowCount-1].AsString := LFileSelectF.DocTypeCombo.Text;
        finally
          EndUpdate;
        end;
      end;
    end;
  finally
    LFileSelectF.Free;
  end;
end;

procedure TTaskEditF.ShowFileSelectF2(AFileName: string; AFromOutLook: Boolean);
var
  li,LRow : integer;
  lfilename : String;
  lExt : String;
  lSize : int64;
  LFileSelectF: TFileSelectF;
  LSQLGSFileRec: TSQLGSFileRec;
  LDoc: RawByteString;
  i: integer;
  LFileNameList: TStringList;
  LTargetStream: TStream;
begin
  LFileSelectF := TFileSelectF.Create(nil);
  LFileNameList := TStringList.Create;
  try
    //Drag 했을 경우 AFileName <> ''이고
    //Task Edit 화면에서 추가 버튼을 눌렀을 경우 AFileName = ''임
    if AFileName <> '' then
    begin
      LFileNameList.Text := AFileName;
      LFileSelectF.JvFilenameEdit1.FileName := AFileName;
    end;

    g_GSDocType.SetType2Combo(LFileSelectF.DocTypeCombo);

    if LFileSelectF.ShowModal = mrOK then
    begin
      if LFileSelectF.JvFilenameEdit1.FileName = '' then
        exit;

      with fileGrid do
      begin
        BeginUpdate;
        try
          for li := 0 to LFileNameList.Count - 1 do
          begin
            LFileName := LFileNameList.Strings[li];

            if AFromOutLook then
            begin
              LTargetStream := GetStreamFromDropDataFormat2(TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat),li);
              try
                if not Assigned(LTargetStream) then
                  ShowMessage('Not Assigned');

                LDoc := StreamToRawByteString(LTargetStream);
              finally
                if Assigned(LTargetStream) then
                  LTargetStream.Free;
              end;
            end
            else
              LDoc := StringFromFile(LFileName);

            LFileName := ExtractFileName(LFileName);

            LSQLGSFileRec.fData := LDoc;
            LSQLGSFileRec.fGSDocType := g_GSDocType.ToOrdinal(LFileSelectF.DocTypeCombo.Text);
            LSQLGSFileRec.fFilename := LFileName;
            lsize := Length(LDoc);

            if not Assigned(FSQLGSFiles) then
              FSQLGSFiles := TSQLGSFile.Create;

            i := FSQLGSFiles.DynArray('Files').Add(LSQLGSFileRec);
            LRow := AddRow;
            CellByName['FileName',LRow].AsString := LFileName;
            CellByName['FileSize',LRow].AsString := IntToStr(lsize);
            CellByName['FilePath',LRow].AsString := ExtractFilePath(LFileName);
            CellByName['DocType',LRow].AsString := LFileSelectF.DocTypeCombo.Text;
          end;

        finally
          EndUpdate;
        end;
      end;
    end;
  finally
    LFileNameList.Free;
    LFileSelectF.Free;
  end;
end;

procedure TTaskEditF.ShowSubConEditFormFromSubConGrid(ARow: integer);
//---ShowSubConEditFormFromSubConGrid()함수 실행 시점
//1. TaskEditForm에서 SubConGrid를 더블 클릭시
var 
  LSubCompanyEditF: TSubCompanyEditF;
  LSubConID, LItemID: TID;
  LDoc: Variant;
  LSubCon: TSQLSubCon;
begin
  LSubCompanyEditF := TSubCompanyEditF.Create(nil);
  try
    TDocVariant.New(LDoc);
    LoadSubConGrid2Var(ARow,LDoc);
    LSubCompanyEditF.LoadEditFormFromVar(LDoc);

    if LSubCompanyEditF.ShowModal = mrOK then
    begin
      LSubCon := TSQLSubCon.Create;
      try
        LSubCon.TaskID := StrToIntDef(LDoc.TaskID, 0);
//        LSubCon.SubConID := StrToIntDef(LDoc.SubConID, 0);
        LSubCon.UniqueSubConID := LDoc.UniqueSubConID;
        LSubCompanyEditF.LoadEditForm2SQLSubCon(LSubCon);
        LoadSubCon2Form(LSubCon, Self, ARow);
        SubConGrid.CellByName['Action', ARow].AsInteger := 3; //Update Action
      finally
        LSubCon.Free;
      end;
//      LSubConID := StrToIntDef(LDoc.SubConID,0);
//      LSubCon := GetSubConFromSubConID(LSubConID);
//      LSubCompanyEditF.LoadEditForm2SQLSubCon(LSubCon);
//
//      //InvoiceItem은 저장하지 않음(Read-Only), InvoiceItem 편집은 InvoiceManager에서만 가능함
//      AddOrUpdateSubCon(LSubCon);
    end;
  finally
    LSubCompanyEditF.Free;
  end;
end;

procedure TTaskEditF.SPType2Combo(ACombo: TComboBox; AFSMState: THiconisASStateMachine);
var
  LIntArr: TIntegerArray;
  i: integer;
begin
//  AFSMState := FFSMState;
//
//  LIntArr := AFSMState.GetOutputs;

  for i := Low(LIntArr) to High(LIntArr) do
    ACombo.Items.Add(g_SalesProcess.ToString(LIntArr[i]));
end;

procedure TTaskEditF.SQLGSFileCopy(ASrc: TSQLGSFile; out ADest: TSQLGSFile);
var
  LRow: integer;
  LSQLGSFileRec: TSQLGSFileRec;
begin
  while ASrc.FillOne do
  begin
    for LRow := Low(ASrc.Files) to High(ASrc.Files) do
    begin
      LSQLGSFileRec.fFilename := ASrc.Files[LRow].fFilename;
      LSQLGSFileRec.fGSDocType := ASrc.Files[LRow].fGSDocType;
      LSQLGSFileRec.fData := ASrc.Files[LRow].fData;

      ADest.DynArray('Files').Add(LSQLGSFileRec);
    end;
  end;
end;

procedure TTaskEditF.SQLGSFileRec2Grid(ARec: TSQLGSFileRec; AGrid: TNextGrid);
var
  LRow: integer;
begin
  LRow := AGrid.AddRow();
  AGrid.CellByName['FileName', LRow].AsString := ARec.fFilename;
  AGrid.CellByName['DocType', LRow].AsString := g_GSDocType.ToString(ARec.fGSDocType);
end;

procedure TTaskEditF.SubConGridCellDblClick(Sender: TObject; ACol,
  ARow: Integer);
begin
  if ARow = -1 then
    Exit;

  ShowSubConEditFormFromSubConGrid(ARow);
end;

procedure TTaskEditF.SubConGridMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i: integer;
  LSubConID: TID;
  LFileName: string;
begin
  if not PtInRect(SubConGrid.GetRowRect(SubConGrid.SelectedRow), Point(X,Y)) then
    exit;

  if (DragDetectPlus(SubConGrid.Handle, Point(X,Y))) then
  begin
    if SubConGrid.SelectedRow = -1 then
      exit;

    LSubConID := StrToIntDef(SubConGrid.CellsByName['RowID', SubConGrid.SelectedRow],-1);
    TVirtualFileStreamDataFormat(DataFormatAdapter3.DataFormat).FileNames.Clear;
    LFileName := SaveCurrentTaskAndSelectedSubCon2File(LSubConID);

    if LFileName <> '' then
      //파일 이름에 공란이 들어가면 OnGetStream 함수를 안 탐
      TVirtualFileStreamDataFormat(DataFormatAdapter3.DataFormat).
            FileNames.Add(LFileName);

    DropEmptySource1.Execute;
  end;
end;

procedure TTaskEditF.SubContractorAdd;
var
  LRow: integer;
  LStr: string;
  LSubCon: TSQLSubCon;
//  LSubConID: TID;
  LSubCompanyEditF: TSubCompanyEditF;
begin
  LSubCompanyEditF := TSubCompanyEditF.Create(nil);
  try
    if LSubCompanyEditF.ShowModal = mrOK then //Save Button 눌렀을때
    begin
      LSubCon := TSQLSubCon.Create;
      try
        if LSubCon.UniqueSubConID = '' then
        begin
          LStr := NewGUID;
          LStr := StringReplace(LStr, '{', '', [rfReplaceAll]);
          LStr := StringReplace(LStr, '}', '', [rfReplaceAll]);

          LSubCon.UniqueSubConID := LStr;
        end;

        LSubCompanyEditF.LoadEditForm2SQLSubCon(LSubCon);
        LSubCon.TaskID := FEmailDisplayTask.ID;
//        LSubCon := GetSubConFromSubConID(LSubConID);
        LoadSubCon2Form(LSubCon, Self);
        LRow := SubConGrid.LastAddedRow;
        SubConGrid.CellByName['Action', LRow].AsInteger := 1; //Add Action
      finally
        LSubCon.Free;
      end;
    end;
  finally
    LSubCompanyEditF.Free;
  end;
end;

end.
