unit FrmHiconisASTaskEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, ShellApi, Rtti,
  JvExControls, JvLabel, NxColumnClasses, NxColumns, NxScrollControl, ActiveX,
  NxCustomGridControl, NxCustomGrid, NxGrid, AeroButtons, CurvyControls,
  Vcl.ImgList, AdvGlowButton, Vcl.ExtCtrls, Vcl.Menus, Vcl.Mask, JvExMask,
  AdvEdit, AdvEdBtn, JvToolEdit, JvBaseEdits, Clipbrd, Generics.Collections,
  pjhComboBox,
  DragDrop, DropTarget, DropSource, DragDropFile,
  mormot.core.base, mormot.core.variants, mormot.core.buffers, mormot.core.unicode,
  mormot.core.data, mormot.orm.base, mormot.core.os, mormot.core.text,
  mormot.core.datetime,

  CommonData2, UnitMakeReport2, UnitGenericsStateMachine_pjh,//FSMClass_Dic, FSMState, UnitTodoCollect2,
  UnitHiconisMasterRecord,  UnitGSFileRecord2, FrmSubCompanyEdit2, FrmOLControl,//FrmEmailListView2
  FrmFileSelect, UnitGSFileData2, UnitOLDataType, UnitElecServiceData2, UnitOLEmailRecord2,
  UnitHiASSubConRecord, UnitHiASMaterialRecord, UnitHiASToDoRecord, UnitToDoList
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
    OrderNoEdit: TEdit;
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
    MaterialGrid: TNextGrid;
    PORNo: TNxTextColumn;
    MaterialName: TNxTextColumn;
    LeadTime: TNxTextColumn;
    FreeOrCharge: TNxTextColumn;
    SupplyCount: TNxTextColumn;
    UnitPrice: TNxTextColumn;
    ReqDeliveryDate: TNxDateColumn;
    ReqArriveDate: TNxDateColumn;
    DeliveryKind: TNxTextColumn;
    StoreAddress: TNxTextColumn;
    PortName: TNxTextColumn;
    ShippingNo: TNxTextColumn;
    DeliveryCharge: TNxTextColumn;
    TermOfDelivery: TNxTextColumn;
    NetWeight: TNxTextColumn;
    GrossWeight: TNxTextColumn;
    Measurement: TNxTextColumn;
    CBM: TNxTextColumn;
    NumOfPkg: TNxTextColumn;
    DeliveryAddress: TNxTextColumn;
    Panel6: TPanel;
    AeroButton5: TAeroButton;
    AeroButton6: TAeroButton;
    PriceAmount: TNxTextColumn;
    DeliveryCompany: TNxTextColumn;
    AirWayBill: TNxTextColumn;
    SalesProcTypeCB: TComboBox;
    ClaimServiceKindCB: TComboBox;
    CompanyName2: TNxTextColumn;
    PORIssueDate: TNxDateColumn;
    JvLabel17: TJvLabel;
    ClaimStatusCombo: TComboBox;
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
    procedure MaterialGridCellDblClick(Sender: TObject; ACol, ARow: Integer);
    procedure AeroButton5Click(Sender: TObject);
    procedure AeroButton6Click(Sender: TObject);
  private
    FTaskJson: String;

    procedure InitEnum;
    procedure InitCB;
    function GetFileFromDropDataFormat(AFormat: TVirtualFileStreamDataFormat): TFileStream;

    function Get_Doc_Qtn_Rec: Doc_Qtn_Rec;
    function Get_Doc_Inv_Rec: Doc_Invoice_Rec;
    function Get_Doc_ServiceOrder_Rec(AIdx: integer = 0): Doc_ServiceOrder_Rec;
    function Get_Doc_Cust_Reg_Rec: Doc_Cust_Reg_Rec;

    //MAPS->QUOTATION관리->INQ.내용에 들어갈 내용을 Clipboard로 복사함
    procedure Content2Clipboard(AContent: string);
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
    procedure MaterialEdit(const ARow: integer=-1);
    function GetNextSalesProcess2String(ASalesProcess: string): string;
    procedure AddOrUpdateMaterial2GridFromVar(ADoc: Variant; const ARow: integer);
    procedure AddOrUpdateMaterialDetail2GridFromVar(ADoc: Variant; const ARow: integer);

    procedure FillNextWorkCB(const AState: integer);

  public
    FTask,
    FEmailDisplayTask: TOrmHiconisASTask;
    FSQLGSFiles: TSQLGSFile;
//    FFSMState: TFSMState;
    FFSMState: THiconisASStateMachine;
    FOLMessagesFromDrop,
    //현재 Task의 작업순서 List
    FSalesProcessList: TStringList;
    FFileContent: RawByteString;
//    FToDoCollect: TpjhToDoItemCollection;
    FToDoList: TpjhToDoList;
    FRemoteIPAddress: string;

    class procedure ShowEMailListFromTask(ATask: TOrmHiconisASTask; ARemoteIPAddress, APort, ARoot: string);
    class procedure LoadEmailListFromTask(ATask: TOrmHiconisASTask; AForm: TOLControlF);
    procedure ShowDTIForm;
    procedure SPType2Combo(ACombo: TComboBox; AFSMState: THiconisASStateMachine=nil);
    //Drag하여 파일 추가한 경우 AFileName <> ''
    //Drag를 윈도우 탐색기에서 하면 AFromOutLook=Fase,
    //Outlook 첨부 파일에서 하면 AFromOutLook=True임
    procedure ShowFileSelectF(AFileName: string = ''; AFromOutLook: Boolean = False);
    procedure ShowFileSelectF2(AFileName: string = ''; AFromOutLook: Boolean = False);

    procedure LoadCustomerFromCompanycode(ACompanyCode: string);
//    procedure LoadCustomer2

    procedure LoadTaskVar2Form(AVar: TOrmHiconisASTask; AForm: TTaskEditF; AFSMClass: THiconisASStateMachine);
    procedure LoadTaskForm2SQLGSTask(AForm: TTaskEditF; out AVar: TOrmHiconisASTask);
    procedure LoadTaskEditForm2Grid(AEditForm: TTaskEditF; AGrid: TNextGrid;
      ARow: integer);
    procedure LoadGrid2TaskEditForm(AGrid: TNextGrid; ARow: integer;
      AEditForm: TTaskEditF);

    procedure ShowSubConEditFormFromSubConGrid(ARow: integer);
    procedure ShowSearchVesselForm;

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

    procedure LoadMaterial4Project2Form(AMaterial: TSQLMaterial4Project; AForm: TTaskEditF);
    procedure LoadTaskForm2Material4Project(AForm: TTaskEditF;
      AMaterial: TSQLMaterial4Project; ARow: integer);
    procedure LoadTaskForm2Material4ProjectNSave2DB(AForm: TTaskEditF; ATaskID: TID = 0);

    procedure LoadMaterial2Form(AMaterial: TSQLMaterial4Project; AForm: TTaskEditF);
    procedure LoadTaskForm2Material(AForm: TTaskEditF;
      AMaterial: TSQLMaterial4Project; ARow: integer);
    procedure LoadTaskForm2MaterialNSave2DB(AForm: TTaskEditF; ATaskID: TID = 0);

    //HiconisASTask를 DB에 저장 할려면 반드시 HullNo/ProjectNo/ClaimNo가 있어야 함
    function CheckTaskDBKeyFromForm(): Boolean;
  end;

  function ProcessTaskJson(AJson: String): Boolean;
  function DisplayTaskInfo2EditForm(var ATask: TOrmHiconisASTask;
      ASQLEmailMsg: TSQLEmailMsg; ADoc: variant; ADocIsFromInvoiceManage: Boolean = False): integer;
  function DisplayTaskInfo2EditFormFromVariant(ADoc: variant;
    ARemoteIPAddress, APort, ARoot: string): Boolean;

  //Manager Form에서 Claim Report.xls를 Drop 했을때 실행
  function ShowEditFormFromClaimReportVar(ATask: TOrmHiconisASTask; AJson: RawUtf8): integer;

var
//  TaskEditF: TTaskEditF;
  g_RemoteIPAddress: string;

implementation

uses FrmHiconisASManage, FrmDisplayTaskInfo2, DragDropInternet, DragDropFormats,
  UnitHiconisASVarJsonUtil, UnitNextGridUtil2, FrmASMaterialEdit,
  UnitIPCModule2, FrmTodoList, FrmSearchCustomer2, UnitDragUtil, UnitStringUtil,
  DateUtils, UnitCmdExecService, UnitBase64Util2, FrmSearchVessel2,
  UnitElecMasterData, UnitOutlookUtil2;

{$R *.dfm}

function ProcessTaskJson(AJson: String): Boolean;
var
  LDoc: variant;
  LTask: TOrmHiconisASTask;
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
    {$IFDEF GAMANAGER}
      FrmHiconisASTaskEdit.DisplayTaskInfo2EditForm(LTask, nil, LDoc, LIsFromInvoiceManage);
    {$ELSE}
      TaskForm.DisplayTaskInfo2EditForm(LTask, nil, LDoc, LIsFromInvoiceManage);
    {$ENDIF}
    finally
      FreeAndNil(LTask);
    end;
  end
  else
    ShowMessage('Signature is not correct');
end;

function DisplayTaskInfo2EditForm(var ATask: TOrmHiconisASTask;
  ASQLEmailMsg: TSQLEmailMsg; ADoc: variant; ADocIsFromInvoiceManage: Boolean): integer;
var
  LTaskEditF: TTaskEditF;
  LCustomer: TSQLCustomer;
//  LSubCon: TSQLSubCon;
  LMat4Proj: TSQLMaterial4Project;
  LTask, LTask2: TOrmHiconisASTask;
  LFiles: TSQLGSFile;
//  LTaskIds: TIDDynArray;
  LSubConList: TObjectList<TSQLSubCon>;
  i: integer;
  LID: TID;
begin
  Result := -1;

  LTaskEditF := TTaskEditF.Create(nil);
  try
    with LTaskEditF do
    begin
      LTask := ATask;

      if LTask.IsUpdate then
        Caption := Caption + ' (Update)'
      else
        Caption := Caption + ' (New)';

      //InvoiceManage로부터 오는 Json은 Task와 Customer에 대한 변경 내용이 없음
      if (not ADocIsFromInvoiceManage) and (ADoc <> null) then
        LoadTaskFromVariant(LTask, ADoc.Task);

      LoadTaskVar2Form(LTask, LTaskEditF, g_FSMClass);
      LCustomer := GetCustomerFromTask(LTask);

      if (not ADocIsFromInvoiceManage) and (ADoc <> null) then
        LoadCustomerFromVariant(LCustomer, ADoc.Customer);

      LoadCustomer2Form(LCustomer, LTaskEditF);

      LSubConList := TObjectList<TSQLSubCon>.Create;
      try
        GetSubConFromTaskIDWithInvoiceItems(LTask.ID, LSubConList);
        LoadSubConList2Form(LSubConList, LTaskEditF);

        if ADoc <> null then
        begin
          //ADocIsFromInvoiceManage = True인 경우 ADoc.InvoiceItem가 존재함
          //InqManager에서 생성한 *.hgs 인 경우임 : ADoc.SubCon이 복수개([] 배열 형식임)
          LoadSubConFromVariant2Form(ADoc, ADocIsFromInvoiceManage)//LoadSubConFromVariant(LSubCon, ADoc, ADocIsFromInvoiceManage)
        end;
      finally
//        LSubConList.Clear;
        LSubConList.Free;
      end;

      LMat4Proj := GetMaterial4ProjFromTask(LTask); //복수개가 반환됨

      try
        if (not ADocIsFromInvoiceManage) and (ADoc <> null) then
          LoadMaterial4ProjectFromVariant(LMat4Proj, ADoc.Material4Project);

        if LMat4Proj.IsUpdate then
        begin
          LMat4Proj.FillRewind;

          while LMat4Proj.FillOne do
          begin
            LoadMaterial4Project2Form(LMat4Proj, LTaskEditF);
          end;//while
        end;
      finally
        LMat4Proj.Free;
      end;

      LTaskEditF.SelectMailBtn.Enabled := Assigned(ASQLEmailMsg);
      LTaskEditF.CancelMailSelectBtn.Enabled := Assigned(ASQLEmailMsg);

      Result := LTaskEditF.ShowModal;

      //"저장" 버튼을 누른 경우
      if Result = mrOK then
      begin
        if not CheckTaskDBKeyFromForm then
        begin
          ShowMessage('HullNo/ProjectNo/ClaimNo 정보가 없습니다.');
          exit;
        end;

        LoadTaskForm2SQLGSTask(LTaskEditF, LTask);

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
          AddOrUpdateTask(LTask);
        end;

        if High(LTaskEditF.FSQLGSFiles.Files) >= 0 then
        begin
          g_FileDB.Delete(TSQLGSFile, LTaskEditF.FSQLGSFiles.ID);
          LTaskEditF.FSQLGSFiles.TaskID := LTask.ID;
          g_FileDB.Add(LTaskEditF.FSQLGSFiles, true);
        end
        else
          g_FileDB.Delete(TSQLGSFile, LTaskEditF.FSQLGSFiles.ID);

        //고객정보 탭 정보 Load -> LCustomer
        LoadTaskForm2Customer(LTaskEditF, LCustomer, LTask.ID);
        AddOrUpdateCustomer(LCustomer);
        //협력사 탭 정보 Load and Save To DB
        SaveSubConFromForm(LTaskEditF, LTask.ID);
        //자재정보 탭 Load -> LMat4Proj
        LoadTaskForm2Material4ProjectNSave2DB(LTaskEditF, LTask.ID);
      end;//mrOK
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
        LoadTaskVar2Form(LTask, LTaskEditF, g_FSMClass);

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
        LoadMaterial4Project2Form(LMat4Proj, LTaskEditF);

        if ShowModal = mrOK then
        begin
          TDocVariant.New(LDoc);
          TDocVariant.New(LDoc2);
          //LTaskEditF 내용을 LTask 옮김
          LoadTaskForm2SQLGSTask(LTaskEditF, LTask);
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
          SendReq2Server_Http(ARemoteIPAddress, APort, ARoot, CMD_EXECUTE_SAVE_TASK_DETAIL, LUtf8);
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

        LoadTaskForm2SQLGSTask(LTaskEditF, ATask);
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
        LoadTaskForm2Material4ProjectNSave2DB(LTaskEditF, ATask.ID);
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
begin
  ShowEMailListFromTask(FEmailDisplayTask, FRemoteIPAddress, HiconisASManageF.TDTF.FPortName, HiconisASManageF.TDTF.FRootName);
end;

procedure TTaskEditF.AeroButton5Click(Sender: TObject);
begin
  MaterialEdit();
end;

procedure TTaskEditF.AeroButton6Click(Sender: TObject);
var
  LRow: integer;
begin
  LRow := MaterialGrid.SelectedRow;

  if LRow = -1 then
    exit;

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

procedure TTaskEditF.CancelMailSelectBtnClick(Sender: TObject);
begin
  if Assigned(FTask) then
    FreeAndNil(FTask);
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

procedure TTaskEditF.Content2Clipboard(AContent: string);
begin
  Clipboard.AsText := AContent;
end;

procedure TTaskEditF.CurWorkCBChange(Sender: TObject);
begin
  NextWorkCB.Text := GetNextSalesProcess2String(CurWorkCB.Text);
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
//  FToDoCollect.Clear;
//  //TaskID 별로 ToDoList를 Select하여 FToDoCollect에 저장함
//  LoadToDoCollectFromTask(FEmailDisplayTask, FToDoCollect);
//
//  Create_ToDoList_Frm(IntToStr(FEmailDisplayTask.ID), FToDoCollect, False,
//    InsertOrUpdateToDoList2DB, DeleteToDoListFromDB);
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

procedure TTaskEditF.FillNextWorkCB(const AState: integer);
var
  LStrList: TStringList;
begin
  try
    LStrList := GetStateOrTriggers2Strings(AState);
    NextWorkCB.Items.Assign(LStrList);
  finally
    LStrList.Free;
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

  if Assigned(FTask) then
    FreeAndNil(FTask);

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

procedure TTaskEditF.HullNoEditClickBtn(Sender: TObject);
begin
  ShowSearchVesselForm;
end;

procedure TTaskEditF.InitCB;
begin
  g_ElecProductType.SetType2Combo(ProductTypeCB);
  g_SalesProcessType.SetType2Combo(SalesProcTypeCB);
  CompanyType2Combo(CustCompanyTypeCB);
  g_ClaimImportanceKind.SetType2Combo(ImportanceCB);
  g_ClaimServiceKind.SetType2Combo(ClaimServiceKindCB);
  g_ClaimStatus.SetType2Combo(ClaimStatusCombo);
end;

procedure TTaskEditF.InitEnum;
begin
  g_ElecProductType.InitArrayRecord(R_ElecProductType);
  g_SalesProcessType.InitArrayRecord(R_SalesProcessType);
  g_GSDocType.InitArrayRecord(R_GSDocType);
  g_ASServiceChargeType.InitArrayRecord(R_ASServiceChargeType);
  g_ClaimServiceKind.InitArrayRecord(R_ClaimServiceKind);
  g_HiconisASState.InitArrayRecord(R_HiconisASState);
  g_HiconisASTrigger.InitArrayRecord(R_HiconisASTrigger);
  g_ClaimImportanceKind.InitArrayRecord(R_ClaimImportanceKind);
  g_ClaimServiceKind.InitArrayRecord(R_ClaimServiceKind);
  g_DeliveryKind.InitArrayRecord(R_DeliveryKind);
  g_FreeOrCharge.InitArrayRecord(R_FreeOrCharge);
  g_ClaimStatus.InitArrayRecord(R_ClaimStatus);
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
  FrmHiconisASManage.HiconisASManageF.TestRemoteTaskEmailList(FEmailDisplayTask);
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
  AForm: TOLControlF);
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
  AForm: TTaskEditF);
var
  LRow: integer;
begin
  with AForm do
  begin
    LRow := MaterialGrid.AddRow();

    MaterialGrid.CellsByName['PORNo', LRow] := AMaterial.PORNo;
    MaterialGrid.CellsByName['MaterialName', LRow] := AMaterial.MaterialName;
    MaterialGrid.CellByName['PORIssueDate', LRow].AsDateTime := TimeLogToDateTime(AMaterial.PORIssueDate);
//    MaterialGrid.CellsByName['LeadTime', LRow] := IntToStr(AMaterial.LeadTime);
    MaterialGrid.CellsByName['FreeOrCharge', LRow] := g_FreeOrCharge.ToString(AMaterial.FreeOrCharge);
    MaterialGrid.CellsByName['SupplyCount', LRow] := IntToStr(AMaterial.SupplyCount);
//    MaterialGrid.CellsByName['UnitPrice', LRow] := AMaterial.UnitPrice;
    MaterialGrid.CellsByName['PriceAmount', LRow] := IntToStr(AMaterial.PriceAmount);
    MaterialGrid.CellByName['ReqDeliveryDate', LRow].AsDateTime := TimeLogToDateTime(AMaterial.ReqDeliveryDate);
    MaterialGrid.CellByName['ReqArriveDate', LRow].AsDateTime := TimeLogToDateTime(AMaterial.ReqArriveDate);
    MaterialGrid.CellsByName['DeliveryKind', LRow] := g_DeliveryKind.ToString(AMaterial.DeliveryKind);
    MaterialGrid.CellsByName['StoreAddress', LRow] := AMaterial.StoreAddress;
    MaterialGrid.CellsByName['PortName', LRow] := AMaterial.PortName;
    MaterialGrid.CellsByName['ShippingNo', LRow] := AMaterial.ShippingNo;
    MaterialGrid.CellsByName['DeliveryCharge', LRow] := AMaterial.DeliveryCharge;
    MaterialGrid.CellsByName['DeliveryCompany', LRow] := AMaterial.DeliveryCompany;
    MaterialGrid.CellsByName['AirWayBill', LRow] := AMaterial.AirWayBill;
    MaterialGrid.CellsByName['TermOfDelivery', LRow] := AMaterial.TermOfDelivery;
    MaterialGrid.CellsByName['NetWeight', LRow] := AMaterial.NetWeight;
    MaterialGrid.CellsByName['GrossWeight', LRow] := AMaterial.GrossWeight;
    MaterialGrid.CellsByName['Measurement', LRow] := AMaterial.Measurement;
    MaterialGrid.CellsByName['CBM', LRow] := AMaterial.CBM;
    MaterialGrid.CellsByName['AirWayBill', LRow] := AMaterial.AirWayBill;
    MaterialGrid.CellsByName['NumOfPkg', LRow] := AMaterial.NumOfPkg;
    MaterialGrid.CellsByName['DeliveryAddress', LRow] := AMaterial.DeliveryAddress;
  end;
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

procedure TTaskEditF.LoadTaskForm2Material4ProjectNSave2DB(AForm: TTaskEditF;
  ATaskID: TID);
var
  LRow: integer;
  LPorNo: string;
  LMat4Proj: TSQLMaterial4Project;
begin
  with AForm.MaterialGrid do
  begin
    //Grid에서 POR No 가져와서 DB 조회함
    for LRow := 0 to RowCount - 1 do
    begin
      LPorNo := CellsByName['PORNo', LRow];
      LMat4Proj := GetMaterial4ProjFromTaskIDNPORNo(ATaskID, LPorNo);
      try
        if Row[LRow].Visible then
        begin
          LoadTaskForm2Material4Project(AForm, LMat4Proj, LRow);

          if LMat4Proj.IsUpdate then
          begin
          end
          else
          begin
            LMat4Proj.TaskID := ATaskID;
          end;

          AddOrUpdateMaterial4Project(LMat4Proj);
        end
        else//Visuble = False면 삭제한 Item임
        begin
          g_HiASMaterialDB.Delete(TSQLMaterial4Project, LMat4Proj.ID);
        end;
      finally
        LMat4Proj.Free;
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

procedure TTaskEditF.LoadTaskForm2SQLGSTask(AForm: TTaskEditF; out AVar: TOrmHiconisASTask);
var
//  LSubConsArr: TRawUtf8DynArray;
  i: integer;
begin
  with AForm do
  begin
//    for i := 0 to SubConGrid.RowCount - 1 do
//    begin
//
//    end;
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
    AVar.CurrentWorkStatus := CurWorkCB.ItemIndex;
    AVar.NextWork := NextWorkCB.ItemIndex;
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
    Avar.ClaimRecvDate := TimeLogFromDateTime(ClaimRecvPicker.Date);
    Avar.ClaimInputDate := TimeLogFromDateTime(ClaimInputPicker.Date);
    Avar.ClaimReadyDate := TimeLogFromDateTime(ClaimReadyPicker.Date);
    Avar.ClaimClosedDate := TimeLogFromDateTime(ClaimClosedPicker.Date);
  end;
end;

procedure TTaskEditF.LoadTaskVar2Form(AVar: TOrmHiconisASTask; AForm: TTaskEditF; AFSMClass: THiconisASStateMachine);
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

    //현재 State의 Trigger List : TTriggerHolder List를 저장함
//    FSalesProcessList := GetStateOrTriggers2Strings(Ord(LCurrentState));

    //StateMachine에 등록 된 모든 State List를 저장함
    FSalesProcessList := GetStateOrTriggers2Strings();

    CurWorkCB.Items.Assign(FSalesProcessList);
    CurWorkCB.ItemIndex := AVar.CurrentWorkStatus;
//    CurWorkCB.ItemIndex := FSalesProcessList.IndexOf(g_SalesProcess.ToString(
//      AVar.CurrentWorkStatus));
//    NextWorkCB.ItemIndex := FSalesProcessList.IndexOf(g_SalesProcess.ToString(
//      AVar.NextWork));
//    end;
    FillNextWorkCB(CurWorkCB.ItemIndex);
    NextWorkCB.ItemIndex := AVar.NextWork;

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
    ClaimServiceKindCB.ItemIndex := Avar.ClaimServiceKind;
    ClaimStatusCombo.ItemIndex := Avar.ClaimStatus;

    ClaimRecvPicker.Date := TimeLogToDateTime(Avar.ClaimRecvDate);
    ClaimInputPicker.Date := TimeLogToDateTime(Avar.ClaimInputDate);
    ClaimReadyPicker.Date := TimeLogToDateTime(Avar.ClaimReadyDate);
    ClaimClosedPicker.Date := TimeLogToDateTime(Avar.ClaimClosedDate);

    FSQLGSFiles := GetFilesFromTask(AVar);
    LoadGSFiles2Form(FSQLGSFiles, AForm);
  end;
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

procedure TTaskEditF.MaterialEdit(const ARow: integer);
var
  LDoc: variant;
begin
  if ARow = -1 then //Add
  begin
    TDocVariant.New(LDoc);
    LDoc.PorNo := '';
  end
  else
  begin
    LDoc := GetNxGridRow2Variant(MaterialGrid, ARow);
  end;

  //"저장" 버튼을 누르면 True
  if LoadMaterialDetailVar2Form(LDoc) then
    AddOrUpdateMaterial2GridFromVar(LDoc, ARow);
//  if DisplayMaterial2EditForm(LDoc) then
//    AddOrUpdateMaterial2GridFromVar(LDoc, ARow);
end;

procedure TTaskEditF.MaterialGridCellDblClick(Sender: TObject; ACol,
  ARow: Integer);
begin
  MaterialEdit(ARow);
end;

procedure TTaskEditF.N18Click(Sender: TObject);
begin
  SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, FEmailDisplayTask,
    HiconisASManageF.TDTF.FSettings,
    HiconisASManageF.TDTF.GetRecvEmailAddress(TMenuItem(Sender).Tag));
end;

procedure TTaskEditF.N19Click(Sender: TObject);
begin
  SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, FEmailDisplayTask,
    HiconisASManageF.TDTF.FSettings,
    HiconisASManageF.TDTF.GetRecvEmailAddress(TMenuItem(Sender).Tag));
end;

procedure TTaskEditF.N20Click(Sender: TObject);
begin
  SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, FEmailDisplayTask,
    HiconisASManageF.TDTF.FSettings,
    HiconisASManageF.TDTF.GetRecvEmailAddress(TMenuItem(Sender).Tag));
end;

procedure TTaskEditF.N21Click(Sender: TObject);
begin
  SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, FEmailDisplayTask,
    HiconisASManageF.TDTF.FSettings,
    HiconisASManageF.TDTF.GetRecvEmailAddress(TMenuItem(Sender).Tag));
end;

procedure TTaskEditF.N22Click(Sender: TObject);
begin
  SendCmd2IPC4CreateMail(nil, 0, TMenuItem(Sender).Tag, FEmailDisplayTask,
    HiconisASManageF.TDTF.FSettings,
    HiconisASManageF.TDTF.GetRecvEmailAddress(TMenuItem(Sender).Tag));
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

procedure TTaskEditF.NextWorkCBDropDown(Sender: TObject);
begin
//  if CurWorkCB.Items.Count = 0 then
    FillNextWorkCB(CurWorkCB.ItemIndex);
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

procedure TTaskEditF.ProductTypeCBDropDown(Sender: TObject);
begin
  g_ElecProductType.SetType2Combo(ProductTypeCB);
end;

procedure TTaskEditF.ShowDTIForm;
var
  LDisplayTaskInfoF: TDisplayTaskInfoF;
  LIdList: TIDList;
  LRow: integer;
  LGrid: TNextGrid;
begin
  if MessageDlg('대표메일을 선택하면 현재 화면에 입력한 내용은 저장 되지 않고' + #13#10 +
                '대표메일의 내용으로 대체 됩니다.' + #13#10 + '그래도 계속 하시겠습니까?'
                , mtConfirmation, [mbYes, mbNo], 0)= mrNo then
  begin
    exit;
  end;

  LDisplayTaskInfoF := TDisplayTaskInfoF.Create(nil);
  try
    if LDisplayTaskInfoF.ShowModal = mrOK then
    begin
      LRow := LDisplayTaskInfoF.FSelectedRow;

      if LRow <> -1 then
      begin
        LGrid := LDisplayTaskInfoF.TDisplayTaskF1.grid_Req;
        if LGrid.Row[LRow].Data <> nil then
        begin
          if Assigned(FTask) then
            FTask.Free;

          FTask := nil;
          LIdList := TIDList(LGrid.Row[LRow].Data);
          FTask := CreateOrGetLoadTask(LIdList.fTaskId);
        end;
      end;
    end;
  finally
    LDisplayTaskInfoF.Free;
  end;
end;

class procedure TTaskEditF.ShowEMailListFromTask(ATask: TOrmHiconisASTask; ARemoteIPAddress, APort, ARoot: string);
var
  LViewMailListF: TOLControlF;
  LOLEmailSrchRec: TOLEmailSrchRec;
  LUtf8: RawUTF8;
begin
  LViewMailListF := TOLControlF.Create(nil);
  try
    begin
      LOLEmailSrchRec.FTaskID := ATask.TaskID;
      LOLEmailSrchRec.FProjectNo := ATask.Order_No;
      LOLEmailSrchRec.FHullNo := ATask.HullNo;
      LOLEmailSrchRec.FClaimNo := ATask.ClaimNo;

      LViewMailListF.OLEmailListFr.SetOLEmailSrchRec(LOLEmailSrchRec);
//      LViewMailListF.FTask := ATask;
//      LViewMailListF.SetMoveFolderIndex; //모든 StoredID가 동일하여 효과 없음
      if ARemoteIPAddress = '' then
        LoadEmailListFromTask(ATask, LViewMailListF)
      else
      begin
        LViewMailListF.OLEmailListFr.FRemoteIPAddress := ARemoteIPAddress;
        LUtf8 := IntToStr(ATask.TaskID);
        LUtf8 := SendReq2Server_Http(ARemoteIPAddress, APort, ARoot,
          CMD_REQ_TASK_EAMIL_LIST, LUtf8);
        LUtf8 := MakeBase64ToUTF8(LUtf8);
        ShowEmailListFromJson(LViewMailListF.OLEmailListFr.grid_Mail, LUtf8);
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

procedure TTaskEditF.ShowSearchVesselForm;
var
  LSearchVesselF: TSearchVesselF;
begin
  LSearchVesselF := TSearchVesselF.Create(nil);
  try
    if LSearchVesselF.ShowModal = mrOK then
    begin
      if LSearchVesselF.VesselListGrid.SelectedRow <> -1 then
      begin
        HullNoEdit.Text := LSearchVesselF.VesselListGrid.CellsByName['HullNo',LSearchVesselF.VesselListGrid.SelectedRow];
        ShipNameEdit.Text := LSearchVesselF.VesselListGrid.CellsByName['ShipName',LSearchVesselF.VesselListGrid.SelectedRow];
//        ShipNameEdit.Text := LSearchVesselF.VesselListGrid.CellsByName['ImoNo',LSearchVesselF.VesselListGrid.SelectedRow];
      end;
    end;
  finally
    LSearchVesselF.Free;
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
