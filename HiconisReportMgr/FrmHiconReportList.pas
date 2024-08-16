unit FrmHiconReportList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, DropSource, DragDrop,
  DropTarget, Vcl.Menus, Vcl.ImgList, SBPro, NxColumnClasses, NxColumns,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid, AdvOfficeTabSet,
  Vcl.Buttons, AdvEdit, AdvEdBtn, Vcl.Mask, JvExMask, JvToolEdit, JvCombobox,
  Vcl.StdCtrls, AeroButtons, Vcl.ComCtrls, AdvGroupBox, AdvOfficeButtons,
  AdvToolBtn, JvExControls, JvLabel, CurvyControls;

type
  TForm2 = class(TForm)
    CurvyPanel1: TCurvyPanel;
    JvLabel2: TJvLabel;
    JvLabel5: TJvLabel;
    JvLabel6: TJvLabel;
    JvLabel1: TJvLabel;
    JvLabel3: TJvLabel;
    JvLabel4: TJvLabel;
    JvLabel8: TJvLabel;
    JvLabel9: TJvLabel;
    JvLabel40: TJvLabel;
    JvLabel7: TJvLabel;
    JvLabel11: TJvLabel;
    PeriodPanel: TCurvyPanel;
    Label4: TLabel;
    rg_period: TAdvOfficeRadioGroup;
    dt_begin: TDateTimePicker;
    dt_end: TDateTimePicker;
    ComboBox1: TComboBox;
    WorkCodeCB: TComboBox;
    CustomerCombo: TComboBox;
    Panel1: TPanel;
    btn_Search: TAeroButton;
    btn_Close: TAeroButton;
    AeroButton1: TAeroButton;
    AuthorEdit: TEdit;
    PORNoEdit: TEdit;
    DisplayFinalCheck: TCheckBox;
    Button1: TButton;
    MaterialCodeEdit: TEdit;
    FindCondCB: TComboBox;
    ReportKindCB: TJvCheckedComboBox;
    HullNoEdit: TAdvEditBtn;
    ShipNameEdit: TAdvEditBtn;
    OrderNoEdit: TAdvEditBtn;
    BitBtn1: TBitBtn;
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
    ClaimStatus: TNxTextColumn;
    Email: TNxButtonColumn;
    ReqCustomer: TNxTextColumn;
    ProdType: TNxTextColumn;
    RecvDate: TNxDateColumn;
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
    StatusBarPro1: TStatusBarPro;
    imagelist24x24: TImageList;
    ImageList16x16: TImageList;
    PopupMenu1: TPopupMenu;
    Mail1: TMenuItem;
    Create1: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
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
    GetShipNameHullNoProjNotoClipbrd1: TMenuItem;
    N1: TMenuItem;
    DeleteTask1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N10: TMenuItem;
    ShowWarrantyExpireDate1: TMenuItem;
    ShowDIRecallStatus1: TMenuItem;
    ShowTaskID1: TMenuItem;
    ShowEmailID1: TMenuItem;
    ShowGSFileID1: TMenuItem;
    GetJsonValues1: TMenuItem;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    CreateNewTask1: TMenuItem;
    N24: TMenuItem;
    ExportToExcel2: TMenuItem;
    SaveDBAs1: TMenuItem;
    N27: TMenuItem;
    ImportMaterialCodeFromExcel1: TMenuItem;
    ImportHiconisProjectFromExcel1: TMenuItem;
    ImportDIModuleRecallData1: TMenuItem;
    CheckIfexistclaiminDBbyxls1: TMenuItem;
    N28: TMenuItem;
    Close1: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Invoice1: TMenuItem;
    Invoice2: TMenuItem;
    InvoiceConfirm1: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    N5: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    ariff1: TMenuItem;
    ViewTariff1: TMenuItem;
    EditTariff1: TMenuItem;
    ImageList32x32: TImageList;
    DropEmptyTarget1: TDropEmptyTarget;
    DataFormatAdapterOutlook: TDataFormatAdapter;
    DropEmptySource1: TDropEmptySource;
    DataFormatAdapter2: TDataFormatAdapter;
    DataFormatAdapterTarget: TDataFormatAdapter;
    DataFormatAdapter1: TDataFormatAdapter;
    Timer1: TTimer;
    OpenDialog1: TOpenDialog;
    ClaimPopup: TPopupMenu;
    Category1: TMenuItem;
    Location1: TMenuItem;
    CauseKind1: TMenuItem;
    CauseHW1: TMenuItem;
    CauseSW1: TMenuItem;
    JvLabel10: TJvLabel;
    CheckBoxGrp: TAdvOfficeCheckGroup;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

end.
