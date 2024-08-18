unit FrmHiconReportList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, DropSource, DragDrop,
  DropTarget, Vcl.Menus, Vcl.ImgList, SBPro, NxColumnClasses, NxColumns,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid, AdvOfficeTabSet,
  Vcl.Buttons, AdvEdit, AdvEdBtn, Vcl.Mask, JvExMask, JvToolEdit, JvCombobox,
  Vcl.StdCtrls, AeroButtons, Vcl.ComCtrls, AdvGroupBox, AdvOfficeButtons,
  AdvToolBtn, JvExControls, JvLabel, CurvyControls,

  mormot.core.base, mormot.rest.client, mormot.orm.core, mormot.rest.http.server,
  mormot.rest.server, mormot.soa.server, mormot.core.datetime, mormot.rest.memserver,
  mormot.soa.core, mormot.core.interfaces, mormot.core.os, mormot.core.text,
  mormot.rest.http.client, mormot.core.json, mormot.core.unicode, mormot.core.variants,
  mormot.core.data, mormot.orm.base, mormot.core.collections, mormot.rest.sqlite3,

  VarRecUtils, UnitHiConReportMgrData, UnitHiConReportListOrm;

type
  THiConReportListF = class(TForm)
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
    ShipOwnerCombo: TComboBox;
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
    HullNoEdit: TAdvEditBtn;
    ShipNameEdit: TAdvEditBtn;
    ProjNoEdit: TAdvEditBtn;
    BitBtn1: TBitBtn;
    TaskTab: TAdvOfficeTabSet;
    HiRptListGrid: TNextGrid;
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
    ModifyItemGrp: TAdvOfficeCheckGroup;
    ReportKindCombo: TComboBox;
    procedure btn_SearchClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure AeroButton1Click(Sender: TObject);
    procedure HiRptListGridCellDblClick(Sender: TObject; ACol, ARow: Integer);
  private
    procedure GetSearchCondRec(var ARec: THiRptMgrSearchCondRec);
    procedure DisplayReportList2GridByConstArray(const LWhere: string; const AAry: TConstArray);
    function GetSqlWhereFromQueryDate(AQueryDate: THiRptMgrQueryDateType): string;
  protected
    procedure ClearFindCondForm();
    procedure HiRptEdit(const ARow: integer=-1);
    procedure LoadReportVar2Grid(AVar: variant; ARow: integer=-1);
    procedure LoadReportVarFromGrid(var AVar: variant; const ARow: integer=-1);
  public
    procedure DisplayReportList2Grid(const ARec: THiRptMgrSearchCondRec);
  end;

var
  HiConReportListF: THiConReportListF;

implementation

uses UnitComboBoxUtil, UnitCheckGrpAdvUtil, JHP.Util.Bit32Helper, UnitNextGridUtil2,
  FrmHiconReportEdit;

{$R *.dfm}

procedure THiConReportListF.AeroButton1Click(Sender: TObject);
begin
  HiRptEdit();
end;

procedure THiConReportListF.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure THiConReportListF.btn_SearchClick(Sender: TObject);
var
  LSearchCondRec: THiRptMgrSearchCondRec;
  LIsRemote: Boolean;
  LUtf8, LResult: RawUTF8;
begin
  GetSearchCondRec(LSearchCondRec);
  DisplayReportList2Grid(LSearchCondRec);
end;

procedure THiConReportListF.Button1Click(Sender: TObject);
begin
  ClearFindCondForm();
end;

procedure THiConReportListF.ClearFindCondForm;
begin
  HullNoEdit.Text := '';
  ShipNameEdit.Text := '';
  ProjNoEdit.Text := '';
  AuthorEdit.Text := '';
  HullNoEdit.Text := '';
  ShipNameEdit.Text := '';

end;

procedure THiConReportListF.DisplayReportList2Grid(const ARec: THiRptMgrSearchCondRec);
var
  ConstArray: TConstArray;
  LWhere, LWhere2: string;
  LFrom, LTo: TTimeLog;
  LpjhBit32: TpjhBit32;
  i: integer;
begin
  LWhere := '';
  LWhere2 := '';

  ConstArray := CreateConstArray([]);
  try
    if ARec.FQueryDate <> hrmqdtNull then
    begin
      if ARec.FFrom <= ARec.FTo then
      begin
        LFrom := TimeLogFromDateTime(ARec.FFrom);
        LTo := TimeLogFromDateTime(ARec.FTo);

        AddConstArray(ConstArray, [LFrom, LTo]);
        LWhere := GetSqlWhereFromQueryDate(ARec.FQueryDate);
      end;
    end;

    if ARec.FProjNo <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ARec.FProjNo+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'ProjectNo LIKE ? ';
    end;

    if ARec.FHullNo <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ARec.FHullNo+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'HullNo LIKE ? ';
    end;

    if ARec.FShipName <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ARec.FShipName+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + ' ShipName LIKE ? ';
    end;

    if ARec.FShipOwner <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ARec.FShipOwner+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + ' ShipOwner LIKE ? ';
    end;

    if ARec.FClassSociety <> '' then
    begin
      AddConstArray(ConstArray, [ARec.FClassSociety]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + ' ClassSociety = ? ';
    end;

    if ARec.FReportAuthorID <> '' then
    begin
      AddConstArray(ConstArray, [ARec.FReportAuthorID]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + ' ReportAuthorID = ? ';
    end;

    if ARec.FReportAuthorName <> '' then
    begin
      AddConstArray(ConstArray, [ARec.FReportAuthorName]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + ' ReportAuthorName = ? ';
    end;

    if ARec.FReportKind > 0 then
    begin
      AddConstArray(ConstArray, [ARec.FReportKind]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + ' ReportKind = ? ';
    end;

    if ARec.FModifyItems > 0 then
    begin
      LpjhBit32 := ARec.FModifyItems;

      for i := 0 to 31 do
      begin
        if LpjhBit32.Bit[i] then
        begin
          AddConstArray(ConstArray, [i]);//g_HiRptModifiedItem

          if LWhere2 <> '' then
            LWhere2 := LWhere2 + ' or ';
          LWhere2 := LWhere2 + ' ModifyItems = ?';
        end;
      end;//for

      if LWhere2 <> '' then
        LWhere2 := '(' + LWhere2 + ')';

      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + LWhere2;
    end;

//    if ARec.FWorkCode > 0 then
//    begin
//      LpjhBit32 := ARec.FWorkCode;
//
//      for i := 0 to 31 do
//      begin
//        if LpjhBit32.Bit[i] then
//        begin
//          AddConstArray(ConstArray, [i]);//g_HiRptWorkCode
//
//          if LWhere2 <> '' then
//            LWhere2 := LWhere2 + ' or ';
//          LWhere2 := LWhere2 + ' WorkCode = ?';
//        end;
//      end;//for
//
//      if LWhere2 <> '' then
//        LWhere2 := '(' + LWhere2 + ')';
//
//      if LWhere <> '' then
//        LWhere := LWhere + ' and ';
//      LWhere := LWhere + LWhere2;
//    end;

    DisplayReportList2GridByConstArray(LWhere, ConstArray);
  finally
    FinalizeConstArray(ConstArray);
  end;
end;

procedure THiConReportListF.DisplayReportList2GridByConstArray(const LWhere: string;
  const AAry: TConstArray);
var
  LOrmHiconReportList: TOrmHiconReportList;
  LUtf8: RawUtf8;
begin
  LOrmHiconReportList := TOrmHiconReportList.CreateAndFillPrepare(g_HiconReportListDB.Orm, LWhere, AAry);
  try
    HiRptListGrid.BeginUpdate;
    try
      LUtf8 := LOrmHiconReportList.GetJsonValues(true, true, soSelect);
      AddNextGridRowsFromJsonAry(HiRptListGrid, LUtf8);
    finally
      HiRptListGrid.EndUpdate;
    end;

  finally
    FreeAndNil(LOrmHiconReportList);
  end;
end;

procedure THiConReportListF.GetSearchCondRec(var ARec: THiRptMgrSearchCondRec);
var
  LQueryDateType: THiRptMgrQueryDateType;
begin
  if ComboBox1.ItemIndex = -1 then
    LQueryDateType := hrmqdtNull
  else
    LQueryDateType := g_HiRptMgrQueryDateType.ToType(ComboBox1.ItemIndex);

  with ARec do
  begin
    FFrom := dt_Begin.Date;
    FTo := dt_end.Date;
    FQueryDate := LQueryDateType;
    FHullNo := HullNoEdit.Text;
    FShipName := ShipNameEdit.Text;
    FShipOwner := ShipOwnerCombo.Text;
    FProjNo := ProjNoEdit.Text;

    FReportKind := ReportKindCombo.ItemIndex;
    FWorkCode := WorkCodeCB.ItemIndex;
    FReportKind := ReportKindCombo.ItemIndex;

    FModifyItems :=  GetSetsFromCheckGrp(ModifyItemGrp);

    FIncludeClosed := DisplayFinalCheck.Checked;
  end;//with
end;

function THiConReportListF.GetSqlWhereFromQueryDate(
  AQueryDate: THiRptMgrQueryDateType): string;
begin
//  case AQueryDate of
//    qdtWorkBeginDate: Result := 'WorkBeginDate >= ? and WorkBeginDate <= ? ';
//    qdtWorkEndDate: Result := 'WorkEndDate >= ? and WorkEndDate <= ? ';
//  end;
end;

procedure THiConReportListF.HiRptEdit(const ARow: integer);
var
  LVar: variant;
begin
  TDocVariant.New(LVar);

  if ARow = -1 then //Add
  begin
  end
  else
  begin
    LoadReportVarFromGrid(LVar, ARow);
  end;

  //"저장" 버튼을 누르면 True
  if DisplayHiRptEditForm(LVar) = mrOK then
    LoadReportVar2Grid(LVar, ARow);
end;

procedure THiConReportListF.HiRptListGridCellDblClick(Sender: TObject; ACol,
  ARow: Integer);
begin
  HiRptEdit(ARow);
end;

procedure THiConReportListF.LoadReportVar2Grid(AVar: variant; ARow: integer);
begin
  if ARow = -1 then
  begin
    if TDocVariantData(AVar).IsArray then
      AddNextGridRowsFromVariant2(HiRptListGrid, AVar)
    else
      AddNextGridRowFromVariant(HiRptListGrid, AVar, True);
  end
  else
    SetNxGridRowFromVar(HiRptListGrid, ARow, AVar);
end;

procedure THiConReportListF.LoadReportVarFromGrid(var AVar: variant;
  const ARow: integer);
begin
  if ARow = -1 then
    AVar := NextGrid2Variant(HiRptListGrid)
  else
    AVar := GetNxGridRow2Variant(HiRptListGrid, ARow);
end;

end.
