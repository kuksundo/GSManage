unit FrmHiconReportList;
(*
HiCONIS Report Manager 1.0.0

Description:
Change log:
 Version 1.0.0 (23 April 2025):
  - First version by GP.
*)

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.ImgList,
  SBPro, NxColumnClasses, NxColumns, Winapi.Activex,
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

  GpCommandLineParser,

  VarRecUtils, UnitHiConReportMgrData, UnitHiConReportMgR, UnitJHPFileRecord,
  UnitHiConReportListOrm, UnitHiConReportWorkItemOrm, UnitHiConChgRegItemOrm, UnitHMSSignatureOrm,
  UnitHiConRptDM, UnitHiRptMgrCLO, UnitRegAppUtil;

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
    Panel2: TPanel;
    Panel1: TPanel;
    btn_Search: TAeroButton;
    btn_Close: TAeroButton;
    Btn_New: TAeroButton;
    Panel3: TPanel;
    Btn_Export: TAeroButton;
    Btn_Clear: TAeroButton;
    btn_Save2DB: TAeroButton;
    ExportSelectedToZip1: TMenuItem;
    ShowImportReportList1: TMenuItem;
    N14: TMenuItem;
    LoadFromReportFile1: TMenuItem;
    ShipType: TNxTextColumn;
    N15: TMenuItem;
    N16: TMenuItem;
    A1: TMenuItem;
    A2: TMenuItem;
    B11: TMenuItem;
    B21: TMenuItem;
    B31: TMenuItem;
    B41: TMenuItem;
    C11: TMenuItem;
    C21: TMenuItem;
    D1: TMenuItem;
    N17: TMenuItem;
    ShowChangeRegisterList1: TMenuItem;
    N18: TMenuItem;
    ShipBuilder: TNxTextColumn;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_SearchClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure Btn_NewClick(Sender: TObject);
    procedure HiRptListGridCellDblClick(Sender: TObject; ACol, ARow: Integer);
    procedure BitBtn1Click(Sender: TObject);
    procedure HullNoEditClickBtn(Sender: TObject);
    procedure SaveastoDFM1Click(Sender: TObject);
    procedure DeleteTask1Click(Sender: TObject);
    procedure CreateNewTask1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure ExportSelectedToZip1Click(Sender: TObject);
    procedure DropEmptyTarget1Drop(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
    procedure Btn_ClearClick(Sender: TObject);
    procedure btn_Save2DBClick(Sender: TObject);
    procedure ShowImportReportList1Click(Sender: TObject);
    procedure LoadFromReportFile1Click(Sender: TObject);
    procedure Btn_ExportClick(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure A2Click(Sender: TObject);
    procedure B11Click(Sender: TObject);
    procedure B21Click(Sender: TObject);
    procedure B31Click(Sender: TObject);
    procedure B41Click(Sender: TObject);
    procedure C11Click(Sender: TObject);
    procedure C21Click(Sender: TObject);
    procedure D1Click(Sender: TObject);
    procedure ShowChangeRegisterList1Click(Sender: TObject);
    procedure HiRptListGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FAppSigInfoJson,
    FAppFilePath: string;
    FCLO4HiRptMgr: TCLO4HiRptMgr;
    FJHPFileDB4HiRpt: TRestClientDB;
    FJHPFileDB4HiRptModel: TOrmModel;

    //보고서 리스트 내,외부 저장용
    FRptDocDict: IDocDict; //{Report: [], WorkItem: []}
    FRptDocList: IDocList; //[{Report: [], WorkItem: []},...]

    procedure InitVar();
    procedure DestroyVar();
    procedure InitEnum();

    procedure ClearRptDocDict();
    procedure ClearRptDocList();
    procedure SetEnable4SaveDBBtn();

    function CommandLineParse(var AErrMsg: string): boolean;
    procedure InitCLO();
    procedure OnGetStream(Sender: TFileContentsStreamOnDemandClipboardFormat;
      Index: integer; out AStream: IStream);

    procedure GetSearchCondRec(var ARec: THiRptMgrSearchCondRec);
    procedure DisplayReportList2GridByConstArray(AWhere: string; const AAry: TConstArray);
    function GetSqlWhereFromQueryDate(AQueryDate: THiRptMgrQueryDateType): string;
  protected
    procedure ClearFindCondForm();
    procedure HiRptEdit(const ARow: integer=-1);
    procedure LoadReportListFromJsonAry2Grid(AJson: RawUtf8);
    procedure LoadReportFromJson2Grid(AJson: RawUtf8; ARow: integer=-1);
    procedure LoadReportVar2Grid(AVar: variant; ARow: integer=-1);
    procedure LoadReportVarFromGrid(var AVar: variant; const ARow: integer=-1);

    function CheckRptDocDictExist: Boolean;
    function GetReportJsonFromDocDictByKeyId(const AKeyId: string): RawUtf8;
    procedure LoadReportListFromDocDict2Grid();
    procedure LoadReportListFromDocList2Grid();
    procedure LoadReportListFromRawByteString(const ARaw: RawByteString);

    function GetRowIdxFromGridByKeyId(const AKeyId: string): integer;
    function GetWorkItemJsonAryFromDocDictBySelectedRow(): RawUtf8;
    function GetWorkItemJsonAryFromDocDictByKeyId(const AKeyId: string): RawUtf8;
    //Resuult: DB에 저장한 Report 건수
    function SaveRptDocDict2DB(): integer;
    //ADoUpdate = False : DB에 없는 Report만 추가함
    //            True : DB에 있는 Report만 갱신함
    function AddOrUpdateRptDocDict2DB(const ADoUpdate: Boolean=False): integer;
    function AddOrUpdateRptList2DBFromDocDict(const ADoUpdate: Boolean): integer;
    function AddOrUpdateWorkItem2DBFromDocDict(const ADoUpdate: Boolean): integer;

    function GetWorkItemJsonFromOrmBySelectedRow(): RawUtf8;
    function GetWorkItemJsonFromOrmByRowIdx(const AIdx: integer): RawUtf8;
    function GetWorkItemJsonFromOrmByReportKey(const AKeyId: TTimeLog): RawUtf8;
    function GetWorkItemJsonAryFromOrmBySelectedRows(): RawUtf8;
    function GetWorkItemDocListFromOrmBySelectedRows(): IDocList;
    procedure ReplaceWorkItemList2RptDocDict(const AKeyId: string; const AJsonAry: RawUtf8);

    //Result: [[FileList],[]...] = 2차원 배열임
    function GetAttachFileJsonAryFromOrmBySelectedRows(const AIsIncludeDiskFile: Boolean=True): RawUtf8;
    //Result: [{FileList},{}...] = 1차원 배열임
    function GetAttachFileJsonAryFromOrmByRowIdx(const AIdx: integer; AIsIncludeDiskFile: Boolean=True): RawUtf8;
    function GetAttachFileJsonAryFromOrmByReportKey(const AKeyId: TTimeLog; AIsIncludeDiskFile: Boolean=True): RawUtf8;
    function GetAttachFileDocListFromOrmByReportKey(const AKeyId: TTimeLog; AIsIncludeDiskFile: Boolean=True): IDocList;

    function GetHiconReportRecFromDBByKeyId(const AKeyId: string): THiconReportRec;

    procedure LoadReportList2GridFromFile();
    procedure MakeZipFileFromSelected(AIsIncludeAttachFile: Boolean=False);
    procedure MakeZipFileFromString(const AContent: string; AFileName: string='');
    function GetHiRptList2JsonAryFromSelected(AIsIncludeAttachFile: Boolean=False; AIsIncludeChgRegRpt: Boolean=False): RawUtf8;

    procedure DeleteReportFromSelectedGrid();
    procedure DeleteReportByReportKey(const ARptKey: TTimeLog);
    procedure DeleteReportListByReportKey(const ARptKey: TTimeLog);
    procedure DeleteWorkItemByReportKey(const ARptKey: TTimeLog);

    procedure CreateLockFile();
    function CheckIfLockFileExist(): Boolean;
    procedure DeleteLockFile();
  public
    procedure DisplayReportList2Grid(const ARec: THiRptMgrSearchCondRec);
    procedure MakeReportBySelected(const ACommissionRptKind: integer; AWorkCode: string='');
  end;

var
  HiConReportListF: THiConReportListF;

implementation

uses UnitComboBoxUtil, UnitCheckGrpAdvUtil, JHP.Util.Bit32Helper, UnitNextGridUtil2,
  UnitStringUtil, UnitVesselMasterRecord2, UnitClipBoardUtil, UnitExcelUtil,
  UnitDragUtil, UnitBase64Util2, //UnitSynZip2, //UnitCompressUtil,
  FrmHiconReportEdit, FrmSearchVessel2, FrmHiChgRegList,
  UnitDFMUtil, UnitHiConReportMakeUtil, UnitHGSSerialRecord2, UnitFileInfoUtil;

{$R *.dfm}

procedure THiConReportListF.A1Click(Sender: TObject);
begin
  MakeReportBySelected(Ord(hcrkSummaryByCode), TMenuItem(Sender).Hint);
end;

procedure THiConReportListF.A2Click(Sender: TObject);
begin
  MakeReportBySelected(Ord(hcrkSummaryByCode), TMenuItem(Sender).Hint);
end;

function THiConReportListF.AddOrUpdateRptDocDict2DB(
  const ADoUpdate: Boolean): integer;
begin
  Result := 0;

  AddOrUpdateRptList2DBFromDocDict(ADoUpdate);
  AddOrUpdateWorkItem2DBFromDocDict(ADoUpdate);
end;

function THiConReportListF.AddOrUpdateRptList2DBFromDocDict(
  const ADoUpdate: Boolean): integer;
var
  LJsonAry: string;
  LList: IDocList;
  LDict: IDocDict;
  LJson: string;
begin
  Result := 0;

  if FRptDocDict.Len > 0 then
  begin
    LJsonAry := FRptDocDict.S[KN_REPORT];//array 임: []
    LList := DocList(LJsonAry);

    for LDict in LList do
    begin
      LJson := LDict.Json;

      if AddOrUpdateHiconReportListFromJsonByKeyId(LJson, ADoUpdate) then
        Inc(Result);
    end;//for
  end;
end;

function THiConReportListF.AddOrUpdateWorkItem2DBFromDocDict(
  const ADoUpdate: Boolean): integer;
var
  LJsonAry, LJsonAry2: string;
  LList, LList2: IDocList;
  LDict: IDocDict;
  LCount: integer;
begin
  Result := 0;

  if FRptDocDict.Len > 0 then
  begin
    LJsonAry := FRptDocDict.S[KN_WORKITEM];//array of array 임: [[],[]...]
    LList := DocList(LJsonAry);

    for LList2 in LList do
    begin
      LCount := 0;
      LJsonAry2 := LList2.Json;
      LCount := AddOrUpdateHiconReportDetailFromJsonAryByKeyId(LJsonAry2, ADoUpdate);
      Result := Result + LCount;
    end;
  end;
end;

procedure THiConReportListF.Btn_ExportClick(Sender: TObject);
begin
  NextGridToExcel(HiRptListGrid, '', '', True);
end;

procedure THiConReportListF.Btn_NewClick(Sender: TObject);
begin
  HiRptEdit();
end;

procedure THiConReportListF.Btn_ClearClick(Sender: TObject);
begin
  ClearFindCondForm();
  HiRptListGrid.ClearRows();
  ClearRptDocDict();
end;

procedure THiConReportListF.B11Click(Sender: TObject);
begin
  MakeReportBySelected(Ord(hcrkSummaryByCode), TMenuItem(Sender).Hint);
end;

procedure THiConReportListF.B21Click(Sender: TObject);
begin
  MakeReportBySelected(Ord(hcrkSummaryByCode), TMenuItem(Sender).Hint);
end;

procedure THiConReportListF.B31Click(Sender: TObject);
begin
  MakeReportBySelected(Ord(hcrkSummaryByCode), TMenuItem(Sender).Hint);
end;

procedure THiConReportListF.B41Click(Sender: TObject);
begin
  MakeReportBySelected(Ord(hcrkSummaryByCode), TMenuItem(Sender).Hint);
end;

procedure THiConReportListF.BitBtn1Click(Sender: TObject);
begin
  Content2Clipboard(HullNoEdit.Text);
end;

procedure THiConReportListF.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure THiConReportListF.btn_Save2DBClick(Sender: TObject);
begin
  SaveRptDocDict2DB();
end;

procedure THiConReportListF.btn_SearchClick(Sender: TObject);
var
  LSearchCondRec: THiRptMgrSearchCondRec;
begin
  if CheckRptDocDictExist() then
    exit;

  GetSearchCondRec(LSearchCondRec);
  DisplayReportList2Grid(LSearchCondRec);
end;

procedure THiConReportListF.Button1Click(Sender: TObject);
begin
  ClearFindCondForm();
end;

function THiConReportListF.GetAttachFileDocListFromOrmByReportKey(
  const AKeyId: TTimeLog; AIsIncludeDiskFile: Boolean): IDocList;
var
  LJson: RawUtf8;
begin
  Result := DocList('[]');

  LJson := GetFiles2JsonAryFromOrmByID(AKeyId, FJHPFileDB4HiRpt, AIsIncludeDiskFile);
  Result.Append(_JSON(LJson));
end;

function THiConReportListF.GetAttachFileJsonAryFromOrmByReportKey(
  const AKeyId: TTimeLog; AIsIncludeDiskFile: Boolean): RawUtf8;
begin
  Result := GetFiles2JsonAryFromOrmByID(AKeyId, FJHPFileDB4HiRpt, AIsIncludeDiskFile);
end;

function THiConReportListF.GetAttachFileJsonAryFromOrmByRowIdx(
  const AIdx: integer; AIsIncludeDiskFile: Boolean): RawUtf8;
var
  LKeyId: TTimeLog;
begin
  Result := '';

  if AIdx = -1 then
    exit;

  if AIdx >= HiRptListGrid.RowCount then
    exit;

  LKeyId := StrToInt64Def(HiRptListGrid.CellByName['ReportKey', AIdx].AsString, 0);
  Result := GetAttachFileJsonAryFromOrmByReportKey(LKeyId, AIsIncludeDiskFile);
end;

function THiConReportListF.GetAttachFileJsonAryFromOrmBySelectedRows(
  const AIsIncludeDiskFile: Boolean): RawUtf8;
var
  i: integer;
  LJsonAry: RawUtf8;
  LList: IDocList;
begin
  Result := '';
  LList := DocList('[]');

  for i := 0 to HiRptListGrid.RowCount - 1 do
  begin
    if HiRptListGrid.Row[i].Selected then
    begin
      LJsonAry := GetAttachFileJsonAryFromOrmByRowIdx(i, AIsIncludeDiskFile);
      LList.Append(LJsonAry);
    end;
  end;//for

  Result := LList.Json;
end;

function THiConReportListF.GetHiconReportRecFromDBByKeyId(
  const AKeyId: string): THiconReportRec;
var
  LRptKey: TTimeLog;
  LOrmHiconReportList: TOrmHiconReportList;
  LUtf8: RawUtf8;
begin
  Result := Default(THiconReportRec);

  LRptKey := StrToInt64Def(AKeyId,0);
  LOrmHiconReportList := GetHiconReportListByKeyID(LRptKey);
  try
    Result.FReportListJson := LOrmHiconReportList.GetJsonValues(true, true, soSelect);

    LUtf8 := GetHiRptDetailJsonAryByReportKey(LRptKey);
    Result.FReportDetailJsonAry := UTF8ToString(LUtf8);
  finally
    LOrmHiconReportList.Free;
  end;
end;

function THiConReportListF.GetHiRptList2JsonAryFromSelected(
  AIsIncludeAttachFile, AIsIncludeChgRegRpt: Boolean): RawUtf8;
var
  LDocList, LDocList2: IDocList;
  LVar: variant;
  LUtf8: RawUtf8;
  LKeyId: TTimeLog;
  i, LCount: integer;
begin
  Result := '';
  LDocList := DocList('[]');

  for i := 0 to HiRptListGrid.RowCount - 1 do
  begin
    FRptDocDict.Clear;

    if HiRptListGrid.Row[i].Selected then
    begin
      LVar := GetNxGridRow2Variant(HiRptListGrid, i);
      LUtf8 := LVar;
      //{'Report': {}, 'WorkItem': [{},{}...], 'Files': [{},{}...]}
      FRptDocDict.S[KN_REPORT] := LUtf8;//'Report'

      LKeyId := StrToInt64Def(HiRptListGrid.CellByName['ReportKey', i].AsString, 0);

      LUtf8 := GetWorkItemJsonFromOrmByReportKey(LKeyId);
      FRptDocDict.S[KN_WORKITEM] := LUtf8;//'WorkItem': [] = json array임

      if AIsIncludeAttachFile then
      begin
        LCount := GetFileCountFromTaskID(LKeyId, FJHPFileDB4HiRpt);

        if LCount > 0 then
        begin
          LUtf8 := GetFiles2JsonAryFromOrmByID(LKeyId, FJHPFileDB4HiRpt);
          FRptDocDict.S[KN_REPORT_FILES] := LUtf8;//'Report_Files': [] = json array임
        end;
      end
      else
        FRptDocDict.S[KN_REPORT_FILES] := '[]';

      if AIsIncludeChgRegRpt then
      begin
        LCount := GetHiChgRegItemCountByReportKey(LKeyId);

        if LCount > 0 then
        begin

        end;
      end
      else
        FRptDocDict.S[KN_CHGREGRPT] := '[]';

      LDocList.Append(FRptDocDict.Json);
    end;
  end;

  Result := LDocList.Json;
end;

function THiConReportListF.GetReportJsonFromDocDictByKeyId(
  const AKeyId: string): RawUtf8;
var
  LJsonAry: string;
  LList: IDocList;
  LDict: IDocDict;
begin
  Result := '';

  if FRptDocDict.Len > 0 then
  begin
    LJsonAry := FRptDocDict.S[KN_REPORT];//array 임: []
    LList := DocList(LJsonAry);

    for LDict in LList do
    begin
      if LDict.S['ReportKey'] = AKeyId then
      begin
        Result := LDict.Json;
        Break;
      end;
    end;//for
  end;
end;

function THiConReportListF.GetRowIdxFromGridByKeyId(
  const AKeyId: string): integer;
var
  i: integer;
begin
  Result := -1;

  for i := 0 to HiRptListGrid.RowCount - 1 do
  begin
    if HiRptListGrid.CellsByName['ReportKey',i] = AKeyId then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function THiConReportListF.GetWorkItemJsonAryFromDocDictByKeyId(
  const AKeyId: string): RawUtf8;
var
  LJsonAry: string;
  LList, LList2: IDocList;
  LDict: IDocDict;
begin
  if FRptDocDict.Len > 0 then
  begin
    LJsonAry := FRptDocDict.S[KN_WORKITEM];//array of array 임: [[],[]...]
    LList := DocList(LJsonAry);

    for LList2 in LList do
    begin
      for LDict in LList2 do
      begin
        if LDict.S['ReportKey4Item'] = AKeyId then
        begin
          Result := LList2.Json;
          Break;
        end;
      end;
    end;
  end;
end;

function THiConReportListF.GetWorkItemJsonAryFromDocDictBySelectedRow: RawUtf8;
var
  LKeyId, LJsonAry: string;
  LList, LList2: IDocList;
  LDict: IDocDict;
begin
  Result := '';

  if HiRptListGrid.SelectedRow = -1 then
    exit;

  LKeyId := HiRptListGrid.CellsByName['ReportKey', HiRptListGrid.SelectedRow];
  Result := GetWorkItemJsonAryFromDocDictByKeyId(LKeyId);
end;

procedure THiConReportListF.C11Click(Sender: TObject);
begin
  MakeReportBySelected(Ord(hcrkSummaryByCode), TMenuItem(Sender).Hint);
end;

procedure THiConReportListF.C21Click(Sender: TObject);
begin
  MakeReportBySelected(Ord(hcrkSummaryByCode), TMenuItem(Sender).Hint);
end;

function THiConReportListF.CheckIfLockFileExist: Boolean;
begin
  Result := FileExists(FAppFilePath + HICON_RPT_LOCK_FILE_NAME);
end;

function THiConReportListF.CheckRptDocDictExist: Boolean;
begin
  if FRptDocDict.Len > 0 then
  begin
//    ShowMessage('FRptDocDict에데이터가 존재합니다.');
    ShowMessage('추가한 Report가 DB에 저장되지 않았습니다.');
  end;
end;

procedure THiConReportListF.ClearFindCondForm;
begin
  HullNoEdit.Text := '';
  ShipNameEdit.Text := '';
  ProjNoEdit.Text := '';
  AuthorNameEdit.Text := '';
  ClassSocietyEdit.Text := '';
  ReportAuthorIDEdit.Text := '';

  ReportKindCombo.ItemIndex := -1;
  WorkCodeCB.ItemIndex := -1;

  ModifyItemCheckCombo.SetUnCheckedAll();// := -1;
end;

procedure THiConReportListF.ClearRptDocDict;
begin
  FRptDocDict.Clear;
  SetEnable4SaveDBBtn();
end;

procedure THiConReportListF.ClearRptDocList;
begin
  FRptDocList.Clear;
  SetEnable4SaveDBBtn();
end;

procedure THiConReportListF.Close1Click(Sender: TObject);
begin
  Close;
end;

function THiConReportListF.CommandLineParse(var AErrMsg: string): boolean;
var
  LStr: string;
begin
  AErrMsg := '';
  FCLO4HiRptMgr := TCLO4HiRptMgr.Create();
  try
//      CommandLineParser.Options := [opIgnoreUnknownSwitches];
    Result := CommandLineParser.Parse(FCLO4HiRptMgr);
  except
    on E: ECLPConfigurationError do begin
      AErrMsg := '*** Configuration error ***' + #13#10 +
        Format('%s, position = %d, name = %s',
          [E.ErrorInfo.Text, E.ErrorInfo.Position, E.ErrorInfo.SwitchName]);
      Exit;
    end;
  end;

  if not Result then
  begin
    AErrMsg := Format('%s, position = %d, name = %s',
      [CommandLineParser.ErrorInfo.Text, CommandLineParser.ErrorInfo.Position,
       CommandLineParser.ErrorInfo.SwitchName]) + #13#10;
    for LStr in CommandLineParser.Usage do
      AErrMsg := AErrMSg + LStr + #13#10;
  end
  else
  begin
  end;
end;

procedure THiConReportListF.CreateLockFile;
begin
  FileFromString('', FAppFilePath + HICON_RPT_LOCK_FILE_NAME);
end;

procedure THiConReportListF.CreateNewTask1Click(Sender: TObject);
begin
  HiRptEdit();
end;

procedure THiConReportListF.D1Click(Sender: TObject);
begin
  MakeReportBySelected(Ord(hcrkSummaryByCode), TMenuItem(Sender).Hint);
end;

procedure THiConReportListF.DeleteLockFile;
begin
  DeleteFile(FAppFilePath + HICON_RPT_LOCK_FILE_NAME);
end;

procedure THiConReportListF.DeleteReportByReportKey(const ARptKey: TTimeLog);
begin
  DeleteReportListByReportKey(ARptKey);
  DeleteWorkItemByReportKey(ARptKey);
  DeleteJHPFilesFromDBByTaskID(ARptKey, FJHPFileDB4HiRpt);

  TChgRegListF.DeleteHCRReportByReportKey(ARptKey);
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
  DeleteHiconReportListFromDBByKey(ARptKey);

  if MessageDlg('선택한 Report와 연결된 Change Register Report도 삭제 할까요?.' + #13#10 +
    '삭제 후에는 복원이 안 됩니다..' , mtConfirmation, [mbYes, mbNo],0) = mrNo then
    exit;

  TChgRegListF.DeleteHCRReportByReportKey(ARptKey);
end;

procedure THiConReportListF.DeleteTask1Click(Sender: TObject);
begin
  DeleteReportFromSelectedGrid();
end;

procedure THiConReportListF.DeleteWorkItemByReportKey(const ARptKey: TTimeLog);
begin
  DeleteHiconReportDetailByRptKey(ARptKey);
end;

procedure THiConReportListF.DestroyVar;
begin
  FJHPFileDB4HiRptModel.Free;
  FJHPFileDB4HiRpt.Free;
  FCLO4HiRptMgr.Free;

  DeleteLockFile();
end;

procedure THiConReportListF.DisplayReportList2Grid(const ARec: THiRptMgrSearchCondRec);
var
  ConstArray: TConstArray;
  LWhere, LWhere2: string;
  LFrom, LTo: TTimeLog;
  LpjhBit32: TpjhBit32;
  i: integer;
  LVar: variant;
  LList: IDocList;
  LDict: IDocDict;
  LJson: RawUtf8;
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
//      LpjhBit32 := ARec.FModifyItems;

//      for i := 0 to 31 do
//      begin
//        if LpjhBit32.Bit[i] then
//        begin
          AddConstArray(ConstArray, [ARec.FModifyItems]);//g_HiRptModifiedItem

          if LWhere2 <> '' then
            LWhere2 := LWhere2 + ' or ';
          LWhere2 := LWhere2 + ' ModifyItems & ' + IntToStr(ARec.FModifyItems) + ' = ?';
//        end;
//      end;//for

      if LWhere2 <> '' then
        LWhere2 := '(' + LWhere2 + ')';

      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + LWhere2;
    end;

    if ARec.FWorkCode > 0 then
    begin
      LWhere2 := '';

      LVar := GetRptKeyJsonAryByWorkCode(ARec.FWorkCode);
      LJson := LVar;

      if LJson = '[]' then
      begin
        LWhere2 := ' ReportKey = 1';
      end
      else
      begin
        LList := DocList(LJson);

        for LDict in LList do
        begin
          AddConstArray(ConstArray, [LDict.I['ReportKey4Item']]);

          if LWhere2 <> '' then
            LWhere2 := LWhere2 + ' or ';
          LWhere2 := LWhere2 + ' ReportKey = ?';
        end;

        if LWhere2 <> '' then
          LWhere2 := '(' + LWhere2 + ')';
      end;

      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + LWhere2;
    end;

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
      HiRptListGrid.ClearRows();
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

procedure THiConReportListF.DropEmptyTarget1Drop(Sender: TObject;
  ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
var
  LTargetStream: TStream;
  LRawByte: RawByteString;
  LFromOutlook: Boolean;
  LFileName, LFileExt: string;
  LJson: RawUtf8;
  LDocType, i: integer;
  LUnicodeStrings: TUnicodeStrings;
  LStrings: TStrings;
begin
  LFileName := '';
  LRawByte := '';
  LFromOutlook := False;
  if (DataFormatAdapter1.DataFormat <> nil) then
  begin
    LUnicodeStrings := (DataFormatAdapter1.DataFormat as TFileDataFormat).Files;
    LFileName := LUnicodeStrings.Text;

    // OutLook에서 Drag한 경우에는 LFileName = '' 임
    if LFileName = '' then
    begin
      LStrings := TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat).FileNames;
      // OutLook에서 첨부파일을 Drag 했을 경우
//      if LStrings.Count > 0) then
      for i := 0 to LStrings.Count - 1 do
      begin
        LFileName := LStrings[i];
        LFileExt := ExtractFileExt(LFileName);

        if LowerCase(LFileExt) = HIRPT_FILE_EXT then
        begin
          LTargetStream := GetStreamFromDropDataFormat2(TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat), i);
          try
            if not Assigned(LTargetStream) then
              ShowMessage('Not Assigned');

            LRawByte := StreamToRawByteString(LTargetStream);
            LFromOutlook := True;

            if LRawByte <> '' then
            begin
              LoadReportListFromRawByteString(LRawByte);
          //    ShowMessage(FRptDocDict.S[KN_REPORT]);
            end;
          finally
            if Assigned(LTargetStream) then
              LTargetStream.Free;
          end;
        end;
      end;//for
    end
    else// 윈도우 탐색기에서 Drag 했을 경우 LFileName에 Drag한 File Name이 존재함
    begin
      for i := 0 to LUnicodeStrings.Count - 1 do
      begin
        LFileName := LUnicodeStrings.Strings[i];
        LFileExt := ExtractFileExt(LFileName);

        if LowerCase(LFileExt) = HIRPT_FILE_EXT then
        begin
          if FileExists(LFileName) then
            LRawByte := StringFromFile(LFileName)
          else
            LRawByte := '';
        end;

        if LRawByte <> '' then
        begin
          LoadReportListFromRawByteString(LRawByte);
      //    ShowMessage(FRptDocDict.S[KN_REPORT]);
        end;
      end;//for
    end;
  end;
end;

procedure THiConReportListF.ExportSelectedToZip1Click(Sender: TObject);
begin
  MakeZipFileFromSelected();
//  GetHiRptList2JsonAryFromSelected();
end;

procedure THiConReportListF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DestroyVar();
end;

procedure THiConReportListF.FormCreate(Sender: TObject);
begin
  FAppFilePath := ExtractFilePath(Application.ExeName);

  if CheckIfLockFileExist() then
  begin
    ShowMessage('DB is in use!');
    Halt(0);
  end
  else
    CreateLockFile();

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
    FClassSociety := ClassSocietyEdit.Text;

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

function THiConReportListF.GetWorkItemDocListFromOrmBySelectedRows: IDocList;
var
  i: integer;
  LJson: RawUtf8;
begin
  Result := DocList('[]');

  for i := 0 to HiRptListGrid.RowCount - 1 do
  begin
    if HiRptListGrid.Row[i].Selected then
    begin
      LJson := GetWorkItemJsonFromOrmByRowIdx(i);
      Result.Append(_JSON(LJson));
    end;
  end;
end;

function THiConReportListF.GetWorkItemJsonFromOrmByReportKey(
  const AKeyId: TTimeLog): RawUtf8;
var
  LOrmHiconReportDetail: TOrmHiconReportDetail;
  LDocList: IList<TOrmHiconReportDetail>;
begin
  LOrmHiconReportDetail := GetHiconReportDetailByReportKey(AKeyId);
  try
    LDocList := LOrmHiconReportDetail.FillTable.ToIList<TOrmHiconReportDetail>;
    Result := LDocList.Data.SaveToJson();
  finally
    LOrmHiconReportDetail.Free;
  end;
end;

function THiConReportListF.GetWorkItemJsonFromOrmByRowIdx(
  const AIdx: integer): RawUtf8;
var
  LKeyId: TTimeLog;
begin
  if AIdx = -1 then
    LKeyId := 0
  else
    LKeyId := StrToInt64Def(HiRptListGrid.CellByName['ReportKey', AIdx].AsString, 0);

  Result := GetWorkItemJsonFromOrmByReportKey(LKeyId);
end;

function THiConReportListF.GetWorkItemJsonFromOrmBySelectedRow: RawUtf8;
begin
  if HiRptListGrid.SelectedRow = -1 then
    exit;

  Result := GetWorkItemJsonFromOrmByRowIdx(HiRptListGrid.SelectedRow);
end;

function THiConReportListF.GetWorkItemJsonAryFromOrmBySelectedRows: RawUtf8;
var
  i: integer;
  LDocList: IDocList;
  LJson: RawUtf8;
begin
  LDocList := GetWorkItemDocListFromOrmBySelectedRows();
  Result := LDocList.Json;
end;

procedure THiConReportListF.HiRptEdit(const ARow: integer);
var
  LFromDocDict: Boolean;
  LVar: variant;
  LRptUtf8, LWorkItemUtf8: RawUtf8;
  LOrmHiconReportList: TOrmHiconReportList;
  LKeyId: string;
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
    LRptUtf8 := GetJsonFromSelectedRow(HiRptListGrid);

    //WorkItem은 FRptDocDict를 먼저 탐색함
    LWorkItemUtf8 := GetWorkItemJsonAryFromDocDictBySelectedRow();
    //FRptDocDict에 WorkItem이 없으면
    //Grid의 ReportMakeDate를 KeyId로 사용하여 TOrmHiconReportDetail DB 에서 가져옴
    if LWorkItemUtf8 = '' then
      LWorkItemUtf8 := GetWorkItemJsonFromOrmBySelectedRow();
  end;

  LFromDocDict := FRptDocDict.Len > 0;

  //"저장" 버튼을 누르면 True
  if DisplayHiRptEditForm(LRptUtf8, LWorkItemUtf8, LFromDocDict, FJHPFileDB4HiRpt, FJHPFileDB4HiRptModel) = mrOK then
  begin
    LoadReportFromJson2Grid(LRptUtf8, ARow);

    if LFromDocDict then
    begin
      LKeyId := HiRptListGrid.CellsByName['ReportKey', HiRptListGrid.SelectedRow];
      ReplaceWorkItemList2RptDocDict(LKeyId, LWorkItemUtf8);
    end;
  end;
end;

procedure THiConReportListF.HiRptListGridCellDblClick(Sender: TObject; ACol,
  ARow: Integer);
begin
  HiRptEdit(ARow);
end;

procedure THiConReportListF.HiRptListGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  LFileName: string;
begin
//  if (DragDetectPlus(TWinControl(Sender).Handle, Point(X,Y))) then
  if (HiRptListGrid.SelectedCount > 0) and (DragDetectPlus(TWinControl(Sender))) then
  begin
    if HiRptListGrid.SelectedRow = -1 then
      exit;

    TVirtualFileStreamDataFormat(DataFormatAdapter2.DataFormat).FileNames.Clear;
    LFileName := IntToStr(TimeLogFromDateTime(now)) + HIRPT_FILE_EXT;
    TVirtualFileStreamDataFormat(DataFormatAdapter2.DataFormat).FileNames.Add(LFileName);

    DropEmptySource1.Execute;
  end;
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

procedure THiConReportListF.InitCLO;
begin
  FCLO4HiRptMgr.BuildDate := TimeLogFromDateTime(now);
  FCLO4HiRptMgr.ExpireDate := TimeLogFromDateTime(now+1);
  FCLO4HiRptMgr.BuildExpireDays := 1;
  FCLO4HiRptMgr.ExpireExecCount := 1;
end;

procedure THiConReportListF.InitEnum;
begin
  g_HiRptMgrQueryDateType.InitArrayRecord(R_HiRptMgrQueryDateType);
  g_HiRptWorkCode.InitArrayRecord(R_HiRptWorkCode);
  g_HiRptKind.InitArrayRecord(R_HiRptKind);
  g_HiRptKind2.InitArrayRecord(R_HiRptKind2);
  g_HiRptSystemKind.InitArrayRecord(R_HiRptSystemKind);
  g_HiRptModifiedItem.InitArrayRecord(R_HiRptModifiedItem);

  g_HiRptKind.SetType2Combo(ReportKindCombo);
  g_HiRptWorkCode.SetType2Combo(WorkCodeCB);
  g_HiRptModifiedItem.SetType2List(ModifyItemCheckCombo.Items);
end;

procedure THiConReportListF.InitVar;
var
  LStr: string;
begin
  CommandLineParse(LStr);
  InitCLO();

  InitHiconReportListClient('');
  InitHiconReportDetailClient('');
  InitHiChgRegItemClient('');
  FJHPFileDB4HiRpt := InitJHPFileClient2('', FJHPFileDB4HiRptModel);
  //UnitHiConReportMgR.CheckRegByAppSigUsingOrm()에서 InitHMSSerialOrm() 실행함

  InitEnum();

  FRptDocDict := DocDict('{}');
  FRptDocList := DocList('[]');

  DOC_DIR := ExtractFilePath(Application.ExeName) + 'db\files\';

  (DataFormatAdapter2.DataFormat as TVirtualFileStreamDataFormat).OnGetStream := OnGetStream;
end;

procedure THiConReportListF.LoadFromReportFile1Click(Sender: TObject);
begin
  LoadReportList2GridFromFile();
end;

procedure THiConReportListF.LoadReportFromJson2Grid(AJson: RawUtf8;
  ARow: integer);
var
  LVar: variant;
begin
  LVar := _JSON(AJson);
  LoadReportVar2Grid(LVar, ARow);
end;

procedure THiConReportListF.LoadReportList2GridFromFile;
var
  LRaw: RawByteString;
begin
  OpenDialog1.InitialDir := 'c:\temp';
  OpenDialog1.Filter := 'Report Files|*.hirpt|All Files|*.*';

  if OpenDialog1.Execute then
  begin
    LRaw := StringFromFile(OpenDialog1.FileName);
    LoadReportListFromRawByteString(LRaw);
  end;
end;

procedure THiConReportListF.LoadReportListFromDocDict2Grid;
begin
  if HiRptListGrid.RowCount > 0 then
    HiRptListGrid.ClearRows;

  LoadReportListFromJsonAry2Grid(FRptDocDict.S[KN_REPORT]);
end;

procedure THiConReportListF.LoadReportListFromDocList2Grid;
var
//  LList: IDocList;
  LDict: IDocDict;
  LUtf8: RawUtf8;
  LRow: integer;
  i: integer;
begin
  if HiRptListGrid.RowCount > 0 then
    HiRptListGrid.ClearRows;

  for i := 0 to FRptDocList.Len - 1 do
  begin
    LUtf8 := FRptDocList.Item[i];
    LDict := DocDict(LUtf8);

    LoadReportFromJson2Grid(LDict.S[KN_REPORT]);
  end;
end;

procedure THiConReportListF.LoadReportListFromJsonAry2Grid(AJson: RawUtf8);
var
  LList: IDocList;
  LDict: IDocDict;
  LUtf8: RawUtf8;
  LRow: integer;
  i: integer;
begin
  LList := DocList(AJson);

  for i := 0 to LList.Len - 1 do
  begin
    LUtf8 := LList.Item[i];
    LDict := DocDict(LUtf8);
    LRow := GetRowIdxFromGridByKeyId(LDict.S['ReportKey']);
    LUtf8 := LDict.Json;

    LoadReportFromJson2Grid(LUtf8, LRow);
  end;
end;

procedure THiConReportListF.LoadReportListFromRawByteString(
  const ARaw: RawByteString);
var
  LContent: string;
begin
  ClearRptDocList();

  LContent := MakeBase64ToString(ARaw);

  FRptDocList := DocList(StringToUtf8(LContent));

  LoadReportListFromDocList2Grid();

  SetEnable4SaveDBBtn();
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

procedure THiConReportListF.MakeReportBySelected(const ACommissionRptKind: integer;
  AWorkCode: string);
var
  LRptKey,
  LJson, LSheetName: string;
  LHiconReportRec: THiconReportRec;
  LDocList: IDocList;
  LDocDict: IDocDict;
  i: integer;
begin
  if HiRptListGrid.SelectedRow = -1 then
  begin
    ShowMessage('출력 할 Reoprt 를 선택하세요.');
    exit;
  end;

  LDocList := DocList('[]');
  LDocDict := DocDict('{}');

  for i := HiRptListGrid.RowCount - 1 downto 0 do
  begin
    if HiRptListGrid.Row[i].Selected then
    begin
      LRptKey := HiRptListGrid.CellsByName['ReportKey', i];
      LSheetName := HiRptListGrid.CellsByName['WorkBeginTime', i];
      LSheetName := FormatDateTime('yyyy-mm-dd', TimeLogToDateTime(StrToInt64(LSheetName))) + '(' + IntToStr(i) + ')';
      LHiconReportRec := GetHiconReportRecFromDBByKeyId(LRptKey);
      LHiconReportRec.FCommissionRptKind := ACommissionRptKind;

//      LDocDict.S['RptKey'] := LRptKey;
      LDocDict.S['SheetName'] := LSheetName;
      LDocDict.S['HiconReportRec'] := RecordSaveJson(LHiconReportRec, TypeInfo(THiconReportRec));

      LDocList.Append(LDocDict.Json);
    end;//if
  end;//for

  LJson := LDocList.Json;

  case THiCommissionRptKind(ACommissionRptKind) of
    hcrkTotal: MakeCommissionReportTotal(LJson);
    hcrkSummary: MakeCommissionReportSummary(LJson, COMMISSION_REPORT_SUMMARY_FILENAME);
    hcrkCode: MakeCommissionReportWorkCode(LJson, COMMISSION_REPORT_WORKCODE_FILENAME);
    hcrkSummaryByCode: MakeCommissionReportSummaryOfWorkCode(LJson, AWorkCode, COMMISSION_REPORT_TOTAL_FILENAME, 'CODE');
  end;
end;

procedure THiConReportListF.MakeZipFileFromSelected(AIsIncludeAttachFile: Boolean);
var
//  LDocList, LDocList2: IDocList;
  LStr: string;
  LUtf8: RawUtf8;
begin
  LUtf8 := GetHiRptList2JsonAryFromSelected();
  LStr := MakeRawUTF8ToBin64(LUtf8);

  MakeZipFileFromString(Utf8ToString(LStr));

//  LDocList := NextGrid2DocList(HiRptListGrid, False, True, True);
//  {Report: [], WorkItem: []}
//  FRptDocDict.Clear;
//  FRptDocDict.S[KN_REPORT] := LDocList.Json;//'Report'
//  LDocList2 := GetWorkItemDocListFromOrmBySelectedRows();
//  FRptDocDict.S[KN_WORKITEM] := LDocList2.Json;//'WorkItem': [[],[]} = array of array 임
//
//  if AIsIncludeAttachFile then
//
////  LStr := FRptDocDict.ToString();
//  LStr := FRptDocDict.Json;
//  LStr := MakeStringToBin64(LStr);

//  MakeZipFileFromString(LStr);
end;

procedure THiConReportListF.MakeZipFileFromString(const AContent: string; AFileName: string);
begin
  if AFileName = '' then
  begin
    AFileName := 'c:\temp\' + FormatDateTime('yyyymmddhhnnss', now) + HIRPT_FILE_EXT; //'.hirpt';
  end;

  FileFromString(AContent, AFileName);

  ShowMessage('Report List is saved to [' + AFileName + ']');
end;

procedure THiConReportListF.N10Click(Sender: TObject);
begin
  MakeReportBySelected(Ord(hcrkSummary));
end;

procedure THiConReportListF.N11Click(Sender: TObject);
begin
  NextGridToExcel(HiRptListGrid);
end;

procedure THiConReportListF.N15Click(Sender: TObject);
begin
  MakeReportBySelected(Ord(hcrkCode));
end;

procedure THiConReportListF.N7Click(Sender: TObject);
begin
  NextGridToExcel(HiRptListGrid);
end;

procedure THiConReportListF.N8Click(Sender: TObject);
begin
  MakeReportBySelected(Ord(hcrkTotal));
end;

procedure THiConReportListF.ReplaceWorkItemList2RptDocDict(const AKeyId: string;
  const AJsonAry: RawUtf8);
var
  LJsonAry: string;
  LList, LList2, LList3: IDocList;
  LDict: IDocDict;
  LVar: variant;
  i: integer;
begin
  LJsonAry := FRptDocDict.S[KN_WORKITEM];//array of array 임: [[],[]...]
  LList := DocList(LJsonAry);

  for i := 0 to LList.Len - 1 do
  begin
    LList2 := LList.L[i];

    for LDict in LList2 do
    begin
      if LDict.S['ReportKey4Item'] = AKeyId then
      begin
        LList.Del(i);
        LList.Append(_JSON(AJsonAry));
        FRptDocDict.S[KN_WORKITEM] := LList.Json;
        exit;
      end;
    end;
  end;
end;

procedure THiConReportListF.SaveastoDFM1Click(Sender: TObject);
begin
  SaveToDFM2('c:\temp\'+ ChangeFileExt(ExtractFileName(Application.ExeName), '.txt'), Self);
end;

function THiConReportListF.SaveRptDocDict2DB: integer;
begin
  Result := AddOrUpdateRptDocDict2DB();//신규 Report만 추가함
  ClearRptDocDict();
end;

procedure THiConReportListF.SetEnable4SaveDBBtn;
begin
  btn_Save2DB.Enabled := FRptDocDict.Len > 0;
end;

procedure THiConReportListF.ShowChangeRegisterList1Click(Sender: TObject);
var
  LJson: string;
begin
  if HiRptListGrid.SelectedRow = -1 then
    exit;

  LJson := GetJsonFromSelectedRow(HiRptListGrid);
  DisplayHiChgRegListForm(LJson, False);
end;

procedure THiConReportListF.ShowImportReportList1Click(Sender: TObject);
begin
  LoadReportListFromDocDict2Grid();
end;

procedure THiConReportListF.OnGetStream(
  Sender: TFileContentsStreamOnDemandClipboardFormat; Index: integer;
  out AStream: IStream);
var
  Stream: TMemoryStream;
  Data: AnsiString;
  LUtf8: RawUtf8;
begin
  Stream := TMemoryStream.Create;
  try
    AStream := nil;

//    LUtf8 := GetJsonAryFromSelectedRow(HiRptListGrid);
    LUtf8 := GetHiRptList2JsonAryFromSelected();

    if LUtf8 = '' then
      exit;

    LUtf8 := MakeRawUTF8ToBin64(LUtf8);

    Stream.Write(PChar(LUtf8)^, Length(LUtf8));
    AStream := TFixedStreamAdapter.Create(Stream, soOwned);
  except
    Stream.Free;
    raise;
  end;
end;

end.
