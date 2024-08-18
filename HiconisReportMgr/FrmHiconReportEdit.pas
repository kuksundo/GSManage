unit FrmHiconReportEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DropSource, DragDrop, DropTarget,
  Vcl.Menus, Vcl.ImgList, Vcl.Buttons, AdvEdit, AdvEdBtn, CurvyControls,
  pjhComboBox, NxColumnClasses, Vcl.StdCtrls, AeroButtons, Vcl.ExtCtrls,
  NxColumns, NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid,
  AdvGlowButton, Vcl.ComCtrls, AdvToolBtn, JvExControls, JvLabel,

  mormot.core.base, mormot.core.variants, mormot.core.buffers, mormot.core.unicode,
  mormot.core.data, mormot.orm.base, mormot.core.os, mormot.core.text,
  mormot.core.datetime, mormot.core.rtti, mormot.core.collections,

  UnitHiConReportListOrm, AdvGroupBox, AdvOfficeButtons
  ;

type
  THiConReportEditF = class(TForm)
    PageControl1: TPageControl;
    TabSheet5: TTabSheet;
    JvLabel36: TJvLabel;
    JvLabel37: TJvLabel;
    Label2: TLabel;
    JvLabel38: TJvLabel;
    JvLabel40: TJvLabel;
    JvLabel16: TJvLabel;
    JvLabel17: TJvLabel;
    WorkBeginTime: TDateTimePicker;
    WorkEndTime: TDateTimePicker;
    NextWorkDesc: TMemo;
    Button3: TButton;
    CurrentWorkDesc: TMemo;
    ClaimServiceKindCB: TComboBox;
    ClaimStatusCombo: TComboBox;
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
    SubConTS: TTabSheet;
    Splitter1: TSplitter;
    Panel1: TPanel;
    AeroButton2: TAeroButton;
    AeroButton3: TAeroButton;
    WorkItemGrid: TNextGrid;
    NxIncrementColumn1: TNxIncrementColumn;
    CompanyName: TNxTextColumn;
    OfficePhone: TNxTextColumn;
    MobilePhone: TNxTextColumn;
    EMail: TNxTextColumn;
    CompanyCode: TNxTextColumn;
    ServicePO: TNxTextColumn;
    ManagerName: TNxTextColumn;
    Position: TNxTextColumn;
    CompanyAddress: TNxTextColumn;
    Nation: TNxTextColumn;
    CompanyTypes: TNxTextColumn;
    TaskID: TNxTextColumn;
    RowID: TNxTextColumn;
    FirstName: TNxTextColumn;
    Surname: TNxTextColumn;
    SECount: TNxTextColumn;
    SubConPrice: TNxTextColumn;
    InvoiceItems: TNxMemoColumn;
    InvoiceFiles: TNxMemoColumn;
    UniqueSubConID: TNxTextColumn;
    SubConInvoiceNo: TNxTextColumn;
    BusinessAreas: TNxTextColumn;
    ShipProductTypes: TNxTextColumn;
    Engine2SProductTypes: TNxTextColumn;
    Engine4SProductTypes: TNxTextColumn;
    ElecProductTypes: TNxTextColumn;
    ElecProductDetailTypes: TNxTextColumn;
    Action: TNxTextColumn;
    CompanyName2: TNxTextColumn;
    TabSheet4: TTabSheet;
    Panel6: TPanel;
    JvLabel18: TJvLabel;
    AeroButton5: TAeroButton;
    DeleteMaterialBtn: TAeroButton;
    AeroButton7: TAeroButton;
    PORNoEdit: TEdit;
    MaterialGrid: TNextGrid;
    PORNo: TNxTextColumn;
    MaterialCode: TNxTextColumn;
    MaterialName: TNxTextColumn;
    LeadTime: TNxTextColumn;
    NeedCount: TNxTextColumn;
    UnitPrice: TNxTextColumn;
    NeedDate: TNxDateColumn;
    CreateDate: TNxDateColumn;
    NxTextColumn5: TNxTextColumn;
    TabSheet1: TTabSheet;
    JvLabel12: TJvLabel;
    JvLabel20: TJvLabel;
    JvLabel21: TJvLabel;
    JvLabel22: TJvLabel;
    JvLabel24: TJvLabel;
    JvLabel34: TJvLabel;
    JvLabel41: TJvLabel;
    JvLabel44: TJvLabel;
    JvLabel45: TJvLabel;
    JvLabel47: TJvLabel;
    JvLabel55: TJvLabel;
    CustomerAddressMemo: TMemo;
    CustCompanyCodeEdit: TEdit;
    CustManagerEdit: TEdit;
    CustEmailEdit: TEdit;
    CustAgentMemo: TMemo;
    CustCompanyTypeCB: TComboBox;
    CustPhonNumEdit: TEdit;
    CustFaxEdit: TEdit;
    CustPositionEdit: TEdit;
    NationEdit: TEdit;
    Button1: TButton;
    Button2: TButton;
    CustomerNameCB: TComboBoxInc;
    CurvyPanel1: TCurvyPanel;
    btn_Close: TAeroButton;
    AeroButton1: TAeroButton;
    CurvyPanel2: TCurvyPanel;
    JvLabel15: TJvLabel;
    JvLabel14: TJvLabel;
    ServiceChargeCB: TComboBox;
    SalesProcTypeCB: TComboBox;
    Panel4: TPanel;
    JvLabel1: TJvLabel;
    JvLabel7: TJvLabel;
    JvLabel6: TJvLabel;
    JvLabel3: TJvLabel;
    JvLabel4: TJvLabel;
    ReportKind: TComboBox;
    ShipOwner: TEdit;
    HullNo: TAdvEditBtn;
    ShipName: TEdit;
    ProjectNo: TAdvEditBtn;
    BitBtn1: TBitBtn;
    Panel5: TPanel;
    JvLabel31: TJvLabel;
    JvLabel49: TJvLabel;
    JvLabel30: TJvLabel;
    JvLabel2: TJvLabel;
    JvLabel10: TJvLabel;
    JvLabel50: TJvLabel;
    JvLabel9: TJvLabel;
    JvLabel8: TJvLabel;
    JvLabel11: TJvLabel;
    ReportSubject: TEdit;
    ReportAuthorID: TEdit;
    ReportAuthorName: TEdit;
    AttendSchedulePicker: TDateTimePicker;
    ReportMakeDate: TDateTimePicker;
    ClaimInputPicker: TDateTimePicker;
    ClaimReadyPicker: TDateTimePicker;
    ClaimClosedPicker: TDateTimePicker;
    ImportanceCB: TComboBox;
    ImageList16x16: TImageList;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    Quotation1: TMenuItem;
    oCustomer1: TMenuItem;
    Korean1: TMenuItem;
    PO1: TMenuItem;
    English1: TMenuItem;
    Korean2: TMenuItem;
    ServiceOrder1: TMenuItem;
    Invoice1: TMenuItem;
    English2: TMenuItem;
    Korean3: TMenuItem;
    N14: TMenuItem;
    Commercial1: TMenuItem;
    N2: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N15: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N16: TMenuItem;
    MAPS1: TMenuItem;
    INQInput1: TMenuItem;
    Mail1: TMenuItem;
    Reply1: TMenuItem;
    N17: TMenuItem;
    PO2: TMenuItem;
    Invoice2: TMenuItem;
    Create1: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    DropEmptyTarget1: TDropEmptyTarget;
    DataFormatAdapterTarget: TDataFormatAdapter;
    DataFormatAdapter1: TDataFormatAdapter;
    Imglist16x16: TImageList;
    DataFormatAdapter2: TDataFormatAdapter;
    DropEmptySource1: TDropEmptySource;
    DataFormatAdapter3: TDataFormatAdapter;
    PopupMenu2: TPopupMenu;
    SaveCompanyinfoashgs1: TMenuItem;
    SaveDialog1: TSaveDialog;
    PopupMenu3: TPopupMenu;
    Saveas1: TMenuItem;
    ClaimPopup: TPopupMenu;
    Category1: TMenuItem;
    Location1: TMenuItem;
    CauseKind1: TMenuItem;
    CauseHW1: TMenuItem;
    CauseSW1: TMenuItem;
    MaterialPopup: TPopupMenu;
    DeleteMaterial1: TMenuItem;
    ClassSociety: TEdit;
    JvLabel5: TJvLabel;
    JvLabel19: TJvLabel;
    ModifyItemGrp: TAdvOfficeCheckGroup;
    procedure AeroButton2Click(Sender: TObject);
    procedure WorkItemGridCellDblClick(Sender: TObject; ACol, ARow: Integer);
  private
    procedure ReportWorkItemEdit(const ARow: integer=-1);
    procedure LoadWorkItemVar2Grid(AVar: variant; ARow: integer=-1);
    procedure LoadWorkItemVarFromGrid(var AVar: variant; const ARow: integer=-1);
  public
    { Public declarations }
  end;

  function DisplayHiRptEditForm(var AHiRptOrm: TOrmHiconReportList;
      AJson: RawUtf8; AHiRptEditConfig: string): integer;

var
  HiConReportEditF: THiConReportEditF;

implementation

uses UnitNextGridUtil2, FrmHiReportWorkItemEdit;

{$R *.dfm}

function DisplayHiRptEditForm(var AHiRptOrm: TOrmHiconReportList;
    AJson: RawUtf8; AHiRptEditConfig: string): integer;
begin

end;

procedure THiConReportEditF.AeroButton2Click(Sender: TObject);
begin
  ReportWorkItemEdit();
end;

procedure THiConReportEditF.LoadWorkItemVar2Grid(AVar: variant; ARow: integer);
begin
  if ARow = -1 then
  begin
    if TDocVariantData(AVar).IsArray then
      AddNextGridRowsFromVariant2(WorkItemGrid, AVar)
    else
      AddNextGridRowFromVariant(WorkItemGrid, AVar, True);
  end
  else
    SetNxGridRowFromVar(WorkItemGrid, ARow, AVar);
end;

procedure THiConReportEditF.LoadWorkItemVarFromGrid(var AVar: variant;
  const ARow: integer);
begin
  if ARow = -1 then
    AVar := NextGrid2Variant(WorkItemGrid)
  else
    AVar := GetNxGridRow2Variant(WorkItemGrid, ARow);
end;

procedure THiConReportEditF.ReportWorkItemEdit(const ARow: integer);
var
  LVar: variant;
begin
  TDocVariant.New(LVar);

  if ARow = -1 then //Add
  begin
  end
  else
  begin
    LoadWorkItemVarFromGrid(LVar, ARow);
  end;

  //"저장" 버튼을 누르면 True
  if DisplayRptWorkItemEditForm(LVar) = mrOK then
    LoadWorkItemVar2Grid(LVar, ARow);
end;

procedure THiConReportEditF.WorkItemGridCellDblClick(Sender: TObject; ACol,
  ARow: Integer);
begin
  ReportWorkItemEdit(ARow);
end;

end.
