unit FrmHiconReportList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.ImgList,
  SBPro, NxColumnClasses, NxColumns,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid, AdvOfficeTabSet,
  Vcl.Buttons, AdvEdit, AdvEdBtn, Vcl.Mask, JvExMask, JvToolEdit, JvCombobox,
  Vcl.StdCtrls, AeroButtons, Vcl.ComCtrls, AdvGroupBox, AdvOfficeButtons,
  AdvToolBtn, JvExControls, JvLabel, CurvyControls,

  DragDropInternet,DropSource,DragDropFile,DragDropFormats, DragDrop, DropTarget,

  mormot.core.base, mormot.rest.client, mormot.orm.core, mormot.rest.http.server,
  mormot.rest.server, mormot.soa.server, mormot.core.datetime, mormot.rest.memserver,
  mormot.soa.core, mormot.core.interfaces, mormot.core.os, mormot.core.text,
  mormot.rest.http.client, mormot.core.json, mormot.core.unicode, mormot.core.variants,
  mormot.core.data, mormot.orm.base, mormot.core.collections, mormot.rest.sqlite3,

  VarRecUtils, UnitHiConReportMgrData, UnitHiConReportListOrm, UnitHiConReportWorkItemOrm;

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
    AuthorNameEdit: TEdit;
    ClassSocietyEdit: TEdit;
    Button1: TButton;
    FindCondCB: TComboBox;
    HullNoEdit: TAdvEditBtn;
    ShipNameEdit: TAdvEditBtn;
    ProjNoEdit: TAdvEditBtn;
    BitBtn1: TBitBtn;
    TaskTab: TAdvOfficeTabSet;
    HiRptListGrid: TNextGrid;
    NxIncrementColumn1: TNxIncrementColumn;
    StatusBarPro1: TStatusBarPro;
    imagelist24x24: TImageList;
    ImageList16x16: TImageList;
    PopupMenu1: TPopupMenu;
    N23: TMenuItem;
    ToDOList1: TMenuItem;
    N22: TMenuItem;
    GetShipNameHullNoProjNotoClipbrd1: TMenuItem;
    DeleteTask1: TMenuItem;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    CreateNewTask1: TMenuItem;
    N24: TMenuItem;
    ExportToExcel2: TMenuItem;
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
    DropEmptySource1: TDropEmptySource;
    DataFormatAdapter2: TDataFormatAdapter;
    DataFormatAdapterTarget: TDataFormatAdapter;
    DataFormatAdapter1: TDataFormatAdapter;
    Timer1: TTimer;
    OpenDialog1: TOpenDialog;
    JvLabel10: TJvLabel;
    ReportKindCombo: TComboBox;
    DataFormatAdapterOutlook1: TDataFormatAdapter;
    ModifyItemCheckCombo: TJvCheckedComboBox;
    N9: TMenuItem;
    SaveastoDFM1: TMenuItem;

    RowID:TnxNumberColumn;
    ProjectNo:TnxTextColumn;
    HullNo:TnxTextColumn;
    ShipName:TnxTextColumn;
    ShipOwner:TnxTextColumn;
    ClassSociety:TnxTextColumn;
    ReportSubject:TnxTextColumn;
    ReportAuthorID:TnxTextColumn;
    ReportAuthorName:TnxTextColumn;
    CurrentWorkDesc:TnxTextColumn;
    NextWorkDesc:TnxTextColumn;
    ReportKind:TnxNumberColumn;
    ModifyItems:TnxNumberColumn;
    WorkBeginTime:TnxNumberColumn;
    WorkEndTime:TnxNumberColumn;
    ReportMakeDate:TnxNumberColumn;
    ModifyDate:TnxNumberColumn;
    ReportKey: TNxNumberColumn;
    JvLabel12: TJvLabel;
    ReportAuthorIDEdit: TEdit;
    Print1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    OwnerComment: TNxTextColumn;

    procedure btn_SearchClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure AeroButton1Click(Sender: TObject);
    procedure HiRptListGridCellDblClick(Sender: TObject; ACol, ARow: Integer);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure HullNoEditClickBtn(Sender: TObject);
    procedure SaveastoDFM1Click(Sender: TObject);
    procedure DeleteTask1Click(Sender: TObject);
    procedure CreateNewTask1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
  private
    procedure InitVar();
    procedure InitEnum();

//    procedure OnGetStream(Sender: TFileContentsStreamOnDemandClipboardFormat;
//      Index: integer; out AStream: IStream);

    procedure GetSearchCondRec(var ARec: THiRptMgrSearchCondRec);
    procedure DisplayReportList2GridByConstArray(AWhere: string; const AAry: TConstArray);
    function GetSqlWhereFromQueryDate(AQueryDate: THiRptMgrQueryDateType): string;
  protected
    procedure ClearFindCondForm();
    procedure HiRptEdit(const ARow: integer=-1);
    procedure LoadReportListFromJson2Grid(AJson: RawUtf8; ARow: integer);
    procedure LoadReportVar2Grid(AVar: variant; ARow: integer=-1);
    procedure LoadReportVarFromGrid(var AVar: variant; const ARow: integer=-1);
    function GetWorkItemJsonFromSelectedRow(): RawUtf8;

    procedure DeleteReportFromSelectedGrid();
    procedure DeleteReportByReportKey(const ARptKey: TTimeLog);
    procedure DeleteReportListByReportKey(const ARptKey: TTimeLog);
    procedure DeleteWorkItemByReportKey(const ARptKey: TTimeLog);
  public
    procedure DisplayReportList2Grid(const ARec: THiRptMgrSearchCondRec);
    procedure MakeReportBySelected();
  end;

var
  HiConReportListF: THiConReportListF;

implementation

uses UnitComboBoxUtil, UnitCheckGrpAdvUtil, JHP.Util.Bit32Helper, UnitNextGridUtil2,
  UnitStringUtil, UnitVesselMasterRecord2, UnitClipBoardUtil, UnitExcelUtil,
  FrmHiconReportEdit, FrmSearchVessel2, UnitDFMUtil, UnitHiConReportMakeUtil;

{$R *.dfm}

procedure THiConReportListF.AeroButton1Click(Sender: TObject);
begin
  HiRptEdit();
end;

procedure THiConReportListF.BitBtn1Click(Sender: TObject);
begin
  Content2Clipboard(HullNoEdit.Text);
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
  AuthorNameEdit.Text := '';
  HullNoEdit.Text := '';
  ShipNameEdit.Text := '';
  ClassSocietyEdit.Text := '';
  ReportAuthorIDEdit.Text := '';

  ReportKindCombo.ItemIndex := -1;
  WorkCodeCB.ItemIndex := -1;

  ModifyItemCheckCombo.SetUnCheckedAll();// := -1;
end;

procedure THiConReportListF.Close1Click(Sender: TObject);
begin
  Close;
end;

procedure THiConReportListF.CreateNewTask1Click(Sender: TObject);
begin
  HiRptEdit();
end;

procedure THiConReportListF.DeleteReportByReportKey(const ARptKey: TTimeLog);
begin
  DeleteReportListByReportKey(ARptKey);
  DeleteWorkItemByReportKey(ARptKey);
end;

procedure THiConReportListF.DeleteReportFromSelectedGrid;
var
  LRptKey: TTimeLog;
begin
  if HiRptListGrid.SelectedRow = -1 then
    exit;

  if MessageDlg('선택한 Report를 삭제 할까요?.' + #13#10 +
    '삭제 후에는 복원이 안 됩니다..' , mtConfirmation, [mbYes, mbNo],0) = mrNo then
    exit;

  LRptKey := StrToInt64Def(HiRptListGrid.CellsByName['ReportKey', HiRptListGrid.SelectedRow],0);
  DeleteReportByReportKey(LRptKey);

  ShowMessage('Reoprt 삭제가 완료 되었습니다.');

  btn_SearchClick(nil);
end;

procedure THiConReportListF.DeleteReportListByReportKey(
  const ARptKey: TTimeLog);
begin
  DeleteHiconReportListByKey(ARptKey);
end;

procedure THiConReportListF.DeleteTask1Click(Sender: TObject);
begin
  DeleteReportFromSelectedGrid();
end;

procedure THiConReportListF.DeleteWorkItemByReportKey(const ARptKey: TTimeLog);
begin
  DeleteHiconReportDetailByRptKey(ARptKey);
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

  if LWhere = '' then
  begin
    LWhere := 'ID <> ?';
    AddConstArray(ConstArray, [0]);
  end;

    DisplayReportList2GridByConstArray(LWhere, ConstArray);
  finally
    FinalizeConstArray(ConstArray);
  end;
end;

procedure THiConReportListF.DisplayReportList2GridByConstArray(AWhere: string;
  const AAry: TConstArray);
var
  LOrmHiconReportList: TOrmHiconReportList;
  LUtf8: RawUtf8;
  LDocList: IList<TOrmHiconReportList>;
begin
  LOrmHiconReportList := TOrmHiconReportList.CreateAndFillPrepare(g_HiconReportListDB.Orm, AWhere, AAry);
  try
    HiRptListGrid.BeginUpdate;
    try
//      LUtf8 := LOrmHiconReportList.GetJsonValues(true, true, soSelect);
      LDocList := LOrmHiconReportList.FillTable.ToIList<TOrmHiconReportList>;
      LUtf8 := LDocList.Data.SaveToJson();
      AddNextGridRowsFromJsonAry(HiRptListGrid, LUtf8, HiRptListGrid.Columns.Count = 0);
//      AddNextGridRowsFromJsonAry(HiRptListGrid, LUtf8, True);
    finally
      HiRptListGrid.EndUpdate;
    end;

  finally
    FreeAndNil(LOrmHiconReportList);
  end;
end;

procedure THiConReportListF.FormCreate(Sender: TObject);
begin
  InitVar();
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

    FReportAuthorID := ReportAuthorIDEdit.Text;
    FReportAuthorName := AuthorNameEdit.Text;

    FReportKind := ReportKindCombo.ItemIndex;
    FWorkCode := WorkCodeCB.ItemIndex;
    FReportKind := ReportKindCombo.ItemIndex;

    FModifyItems :=  GetSetFromCheckCombo(ModifyItemCheckCombo);
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

function THiConReportListF.GetWorkItemJsonFromSelectedRow: RawUtf8;
var
  LKeyId: TTimeLog;
  LOrmHiconReportDetail: TOrmHiconReportDetail;
  LDocList: IList<TOrmHiconReportDetail>;
begin
  if HiRptListGrid.SelectedRow = -1 then
    LKeyId := 0
  else
    LKeyId := StrToInt64Def(HiRptListGrid.CellByName['ReportKey', HiRptListGrid.SelectedRow].AsString, 0);

  LOrmHiconReportDetail := GetHiconReportDetailByReportKey(LKeyId);
  try
    LDocList := LOrmHiconReportDetail.FillTable.ToIList<TOrmHiconReportDetail>;
    Result := LDocList.Data.SaveToJson();
  finally
    LOrmHiconReportDetail.Free;
  end;
end;

procedure THiConReportListF.HiRptEdit(const ARow: integer);
var
  LVar: variant;
  LRptUtf8, LWorkItemUtf8: RawUtf8;
  LOrmHiconReportList: TOrmHiconReportList;
begin
  TDocVariant.New(LVar);

  if ARow = -1 then //Add
  begin
    LOrmHiconReportList := TOrmHiconReportList.Create;
    try
      LOrmHiconReportList.ReportKey := TimeLogFromDateTime(now);
      LOrmHiconReportList.ReportMakeDate := TimeLogFromDateTime(now);
      LOrmHiconReportList.ModifyDate := TimeLogFromDateTime(now);
//      LOrmHiconReportList.WorkBeginTime := TimeLogFromDateTime(now);
//      LOrmHiconReportList.WorkEndTime := TimeLogFromDateTime(now);

      LRptUtf8 := LOrmHiconReportList.GetJsonValues(true, true, soSelect);
      LWorkItemUtf8 := '';
    finally
      LOrmHiconReportList.Free;
    end;
  end
  else
  begin
//    LoadReportVarFromGrid(LVar, ARow);
    LRptUtf8 := GetJsonFromSelectedRow(HiRptListGrid);
    //Grid의 ReportMakeDate를 KeyId로 사용하여 TOrmHiconReportDetail DB 에서 가져옴
    LWorkItemUtf8 := GetWorkItemJsonFromSelectedRow();
  end;

  //"저장" 버튼을 누르면 True
  if DisplayHiRptEditForm(LRptUtf8, LWorkItemUtf8) = mrOK then
    LoadReportListFromJson2Grid(LRptUtf8, ARow);
end;

procedure THiConReportListF.HiRptListGridCellDblClick(Sender: TObject; ACol,
  ARow: Integer);
begin
  HiRptEdit(ARow);
end;

procedure THiConReportListF.HullNoEditClickBtn(Sender: TObject);
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

procedure THiConReportListF.InitEnum;
begin
  g_HiRptMgrQueryDateType.InitArrayRecord(R_HiRptMgrQueryDateType);
  g_HiRptWorkCode.InitArrayRecord(R_HiRptWorkCode);
  g_HiRptKind.InitArrayRecord(R_HiRptKind);
  g_HiRptModifiedItem.InitArrayRecord(R_HiRptModifiedItem);

  g_HiRptKind.SetType2Combo(ReportKindCombo);
  g_HiRptModifiedItem.SetType2List(ModifyItemCheckCombo.Items);
end;

procedure THiConReportListF.InitVar;
begin
  InitHiconReportListClient('');
  InitHiconReportDetailClient('');

  InitEnum();

  DOC_DIR := ExtractFilePath(Application.ExeName) + 'db\files\';
//  (DataFormatAdapter2.DataFormat as TVirtualFileStreamDataFormat).OnGetStream := OnGetStream;
end;

procedure THiConReportListF.LoadReportListFromJson2Grid(AJson: RawUtf8;
  ARow: integer);
var
  LVar: variant;
begin
  LVar := _JSON(AJson);
  LoadReportVar2Grid(LVar, ARow);
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

procedure THiConReportListF.MakeReportBySelected;
var
  LRptKey: TTimeLog;
  LJson: string;
  LOrmHiconReportList: TOrmHiconReportList;
  LHiconReportRec: THiconReportRec;
  LVar: variant;
  LDocList: IList<TOrmHiconReportDetail>;
begin
  if HiRptListGrid.SelectedRow = -1 then
  begin
    ShowMessage('출력 할 Reoprt 를 선택하세요.');
    exit;
  end;

  LRptKey := StrToInt64Def(HiRptListGrid.CellsByName['ReportKey', HiRptListGrid.SelectedRow],0);

  try
    LOrmHiconReportList := GetHiconReportListByKeyID(LRptKey);
    LHiconReportRec.FReportListJson := LOrmHiconReportList.GetJsonValues(true, true, soSelect);

    Lvar := GetHiRptDetailJsonAryByReportKey(LRptKey);
    LHiconReportRec.FReportDetailJsonAry := UTF8ToString(Lvar);
  finally
    LOrmHiconReportList.Free;
  end;

  MakeCommissionReportTotal(LHiconReportRec);
end;

procedure THiConReportListF.N7Click(Sender: TObject);
begin
  NextGridToExcel(HiRptListGrid);
end;

procedure THiConReportListF.N8Click(Sender: TObject);
begin
  MakeReportBySelected();
end;

procedure THiConReportListF.SaveastoDFM1Click(Sender: TObject);
begin
  SaveToDFM2('c:\temp\'+ ChangeFileExt(ExtractFileName(Application.ExeName), '.txt'), Self);
end;

//procedure THiConReportListF.OnGetStream(
//  Sender: TFileContentsStreamOnDemandClipboardFormat; Index: integer;
//  out AStream: IStream);
//begin
//
//end;

end.
