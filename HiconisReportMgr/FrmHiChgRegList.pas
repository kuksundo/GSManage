unit FrmHiChgRegList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SBPro, NxScrollControl, Winapi.ActiveX,
  NxCustomGridControl, NxCustomGrid, NxGrid, AdvOfficeTabSet, AeroButtons,
  Vcl.ExtCtrls, Vcl.Mask, JvExMask, JvToolEdit, JvCombobox, Vcl.Buttons,
  AdvEdit, AdvEdBtn, Vcl.StdCtrls, Vcl.ComCtrls, AdvGroupBox, AdvOfficeButtons,
  JvExControls, JvLabel, CurvyControls, Vcl.Menus, NxColumnClasses, NxColumns,

  DropSource, DragDrop, DropTarget, DragDropFile, DragDropFormats,

  mormot.core.base, mormot.core.variants, mormot.core.buffers, mormot.core.unicode,
  mormot.core.data, mormot.orm.base, mormot.core.os, mormot.core.text, mormot.core.json,
  mormot.core.datetime, mormot.core.rtti, mormot.core.collections, mormot.rest.sqlite3,
  mormot.orm.core,

  {$IFDEF DEF_HiConChgReportMgR}, UnitHiConChgReportMgR, {$ELSE}UnitHiConReportMgR,{$ENDIF}
  VarRecUtils, UnitHiConReportMgrData, UnitJHPFileRecord
  ;

type
  TChgRegListF = class(TForm)
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
    JvLabel10: TJvLabel;
    JvLabel12: TJvLabel;
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
    ReportKindCombo: TComboBox;
    ModifyItemCheckCombo: TJvCheckedComboBox;
    ReportAuthorIDEdit: TEdit;
    Panel2: TPanel;
    Panel1: TPanel;
    btn_Search: TAeroButton;
    btn_Close: TAeroButton;
    Btn_New: TAeroButton;
    Panel3: TPanel;
    Btn_Export: TAeroButton;
    Btn_Clear: TAeroButton;
    btn_Save2DB: TAeroButton;
    TaskTab: TAdvOfficeTabSet;
    HiChgRegListGrid: TNextGrid;
    StatusBarPro1: TStatusBarPro;
    PopupMenu1: TPopupMenu;
    SaveastoDFM1: TMenuItem;
    ReportKey: TEdit;

    NxIncrementColumn1: TNxIncrementColumn;
    RowID:TnxNumberColumn;
    ReportKey4ChgReg:TnxNumberColumn;
    ChgRegRptNo:TnxTextColumn;
    ChgRegRptAuthorID:TnxTextColumn;
    ChgRegRptAuthorName:TnxTextColumn;
    ChgRegSubject:TnxTextColumn;
    SystemName:TnxTextColumn;
    DocRef:TnxTextColumn;
    Chapter:TnxTextColumn;
    InitiatedDuring: TNxTextColumn;
    ReqSrc:TnxTextColumn;
    Modification:TnxTextColumn;
    ModDetail:TnxTextColumn;
    Plan_Engineer:TnxTextColumn;
    Plan_ClosePIC:TnxTextColumn;
    Plan_Finish:TnxTextColumn;
    EstimatedWorkHour:TnxTextColumn;
    Importance:TnxTextColumn;
    Open_PIC:TnxTextColumn;
    Test_PIC:TnxTextColumn;
    Close_PIC:TnxTextColumn;
    SetColCaptionFromList1: TMenuItem;
    Involves: TNxTextColumn;
    DeleteHCRReport1: TMenuItem;
    N1: TMenuItem;
    ExportSelectedToExcel1: TMenuItem;
    N2: TMenuItem;
    RegisteredBy: TNxTextColumn;
    Priority: TNxTextColumn;
    OpenStatus: TNxTextColumn;
    Distinction: TNxTextColumn;
    ChgRegCompany: TNxTextColumn;
    ExportSelectedTohichg1: TMenuItem;
    DropEmptyTarget1: TDropEmptyTarget;
    DataFormatAdapterOutlook1: TDataFormatAdapter;
    DataFormatAdapterTarget: TDataFormatAdapter;
    DataFormatAdapter1: TDataFormatAdapter;
    DropEmptySource1: TDropEmptySource;
    DataFormatAdapter2: TDataFormatAdapter;
    OpenDialog1: TOpenDialog;
    ChgRegDate: TNxTextColumn;
    ChgRegCloseDate: TNxTextColumn;
    ChgRegOpenDate: TNxTextColumn;
    ChgRegTestDate: TNxTextColumn;
    ChgRegModifyDate: TNxTextColumn;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SaveastoDFM1Click(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure Btn_ExportClick(Sender: TObject);
    procedure Btn_NewClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SetColCaptionFromList1Click(Sender: TObject);
    procedure HiChgRegListGridCellDblClick(Sender: TObject; ACol,
      ARow: Integer);
    procedure DeleteHCRReport1Click(Sender: TObject);
    procedure ExportSelectedToExcel1Click(Sender: TObject);
    procedure ExportSelectedTohichg1Click(Sender: TObject);
    procedure DropEmptyTarget1Drop(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
    procedure HiChgRegListGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FReportKey4ChgReg: TTimeLog;
    FJHPFileDB4ChgReg: TRestClientDB;
    FJHPFileDB4ChgRegModel: TOrmModel;

    //보고서 리스트 내,외부 저장용
    FHiChgRegDocDict: IDocDict; //{Report: [], WorkItem: []}
    FHiChgRegDocList: IDocList; //[{Report: [], WorkItem: []},...]

    procedure OnGetStream(Sender: TFileContentsStreamOnDemandClipboardFormat;
      Index: integer; out AStream: IStream);

    procedure ClearFindCondForm();
    procedure SetSrchCondHdrFromDict(ADict: IDocDict);

    function GetSqlWhereFromQueryDate(AQueryDate: THiRptMgrQueryDateType): string;
    procedure GetSearchCondRec(var ARec: THiRptMgrSearchCondRec);

    procedure DisplayChgRegList2GridByConstArray(AWhere: string; const AAry: TConstArray);
    procedure DisplayChgRegList2GridByRptKey(ARptKey: TTimeLog);
    procedure DisplayChgRegList2Grid(const ARec: THiRptMgrSearchCondRec);
    function AddHiChgRegListGridRowsFromJsonAry(AJsonAry: RawUtf8; AIsAddColumn: Boolean=false; AIsClearRow: Boolean=false): integer;

    procedure HiChgRegItemEdit(const ARow: integer=-1);
    procedure LoadChgRegJson2Grid(AVar: Variant; ARow: integer=-1);

    function GetNewChgRegRptNoBySerial(AYear, ASerialNo: integer): string;
    function GetNewChgRegRptNoByHullNo(AHullNo, ASerialNo: string): string;

    procedure DeleteHCRReportFromSelectedGrid();
    procedure DeleteHCRReportByChgRegRptNo(const AChgRegRptNo: RawUTF8);
    procedure DeleteHCRReportByReportKeyNChgRegRptNo(const ARptKey: TTimeLog; const AChgRegRptNo: RawUTF8);
    procedure MakeHCRReportBySelected();

    function GetHiconReportRecByHcrNo(const AHcrNo: string): THiconReportRec;

    function ReplaceStatusValue2StrFromJsonAry(AJson: RawUtf8): RawUtf8;
    function ReplaceStatusValue2StrFromJson(AJson: RawUtf8): RawUtf8;
    function ReplaceStrValue2StatusFromJsonAry(AJson: RawUtf8): RawUtf8;
    function ReplaceStrValue2StatusFromJson(AJson: RawUtf8): RawUtf8;

    procedure LoadHiChgRegList2GridFromFile();
    procedure MakeZipFileFromSelected(AIsIncludeAttachFile: Boolean=False);
    procedure MakeZipFileFromString(const AContent: string; AFileName: string='');
    function GetHiChgRegList2JsonAryFromSelected(AIsIncludeAttachFile: Boolean=False): RawUtf8;

    procedure ClearChgRegDocDict();
    procedure ClearChgRegDocList();
    procedure SetEnable4SaveDBBtn();

    procedure LoadChgRegListFromDocDict2Grid();
    procedure LoadChgRegListFromDocList2Grid();
    procedure LoadChgRegListFromRawByteString(const ARaw: RawByteString);
    procedure LoadChgRegListFromJsonAry2Grid(AJson: RawUtf8);
    procedure LoadChgRegFromJson2Grid(AJson: RawUtf8; ARow: integer=-1);
    procedure LoadChgRegVar2Grid(AVar: variant; ARow: integer=-1);
    function GetRowIdxFromGridByKeyId(const ARpgKeyId, AChgRegRptNo: string): integer;
  public
    Class procedure DeleteHCRReportByReportKey(const ARptKey: TTimeLog);
  end;

  //AFromDocDict : True = DB에 저장하지 않음
  function DisplayHiChgRegListForm(AReportJson: string; AFromDocDict: Boolean): integer;

var
  ChgRegListF: TChgRegListF;

implementation

uses UnitDFMUtil, UnitNextGridUtil2, UnitComboBoxUtil, JHP.Util.Bit32Helper,
  UnitExcelUtil,  UnitHiConChgRegItemOrm, UnitHiConReportListOrm, UnitHGSSerialRecord2,
  UnitHiConReportMakeUtil, UnitBase64Util2, UnitDragUtil, UnitmORMotUtil2,
  FrmHiChangeRegisterEdit;

{$R *.dfm}

function DisplayHiChgRegListForm(AReportJson: string; AFromDocDict: Boolean): integer;
var
  LChgRegListEditF: TChgRegListF;
  LJson: RawUtf8;
  LDict: IDocDict;
begin
  LChgRegListEditF := TChgRegListF.Create(nil);
  try
    with LChgRegListEditF do
    begin
      if AReportJson <> '' then
      begin
        LDict := DocDict(AReportJson);
        FReportKey4ChgReg := StrToInt64(LDict['ReportKey']);
        SetSrchCondHdrFromDict(LDict);
      end
      else
        FReportKey4ChgReg := -1;

      LJson := GetHiChgRegItemJsonAryByReportKey(FReportKey4ChgReg);
      AddHiChgRegListGridRowsFromJsonAry(LJson, HiChgRegListGrid.Columns.Count = 0);

      Result := ShowModal;

      if Result = mrOK then
      begin
        AddHiChgRegListGridRowsFromJsonAry(LJson, HiChgRegListGrid.Columns.Count = 0);
      end;
    end;//with
  finally
    LChgRegListEditF.Free;
  end;
end;

function TChgRegListF.AddHiChgRegListGridRowsFromJsonAry(AJsonAry: RawUtf8;
  AIsAddColumn, AIsClearRow: Boolean): integer;
var
  LJson: RawUtf8;
  i: integer;
  LColumn: TnxCustomColumn;
begin
  LJson := ReplaceStatusValue2StrFromJsonAry(AJsonAry);
  AddNextGridRowsFromJsonAry(HiChgRegListGrid, LJson, AIsAddColumn);

  LColumn := HiChgRegListGrid.ColumnByName['ChgRegRptNo'];
  LJson := HiChgRegListGrid.CellsByName['ChgRegRptNo', HiChgRegListGrid.RowCount - 1];
  i := GetColumnWidthByTextLength(HiChgRegListGrid, LColumn, LJson);
  LColumn.Width := i;
end;

procedure TChgRegListF.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TChgRegListF.Btn_ExportClick(Sender: TObject);
begin
  NextGridToExcel(HiChgRegListGrid, '', '', True);
end;

procedure TChgRegListF.Btn_NewClick(Sender: TObject);
begin
  HiChgRegItemEdit();
end;

procedure TChgRegListF.btn_SearchClick(Sender: TObject);
var
  LSearchCondRec: THiRptMgrSearchCondRec;
begin
  GetSearchCondRec(LSearchCondRec);
  DisplayChgRegList2Grid(LSearchCondRec);
end;

procedure TChgRegListF.Button1Click(Sender: TObject);
begin
  ClearFindCondForm();
end;

procedure TChgRegListF.ClearChgRegDocDict;
begin
  FHiChgRegDocDict.Clear;
  SetEnable4SaveDBBtn();
end;

procedure TChgRegListF.ClearChgRegDocList;
begin
  FHiChgRegDocList.Clear;
  SetEnable4SaveDBBtn();
end;

procedure TChgRegListF.ClearFindCondForm;
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

procedure TChgRegListF.DeleteHCRReport1Click(Sender: TObject);
begin
  DeleteHCRReportFromSelectedGrid();
end;

procedure TChgRegListF.DeleteHCRReportByChgRegRptNo(
  const AChgRegRptNo: RawUTF8);
begin
  DeleteHiChgRegItemByChgRegRptNo(AChgRegRptNo);
end;

class procedure TChgRegListF.DeleteHCRReportByReportKey(const ARptKey: TTimeLog);
var
  LJHPFileDB4ChgReg: TRestClientDB;
  LJHPFileDB4ChgRegModel: TOrmModel;
begin
  DeleteHiChgRegItemFromDBByRptKey(ARptKey);
  LJHPFileDB4ChgReg := InitJHPFileClient2(ExtractFilePath(Application.ExeName) + 'HiconChgReg.exe', LJHPFileDB4ChgRegModel);
  try
    DeleteJHPFilesFromDBByTaskID(ARptKey, LJHPFileDB4ChgReg);
  finally
    LJHPFileDB4ChgRegModel.Free;
    LJHPFileDB4ChgReg.Free;
  end;
end;

procedure TChgRegListF.DeleteHCRReportByReportKeyNChgRegRptNo(
  const ARptKey: TTimeLog; const AChgRegRptNo: RawUTF8);
var
  LMsg: string;
begin
  if DeleteHiChgRegItemByRptKeyNChgRegRptNo(ARptKey, AChgRegRptNo) then
    LMsg := 'Successful'
  else
    LMsg := 'Fail';

  ShowMessage('Delete for Change Register Report [' + AChgRegRptNo + '] is ' + LMsg);
end;

procedure TChgRegListF.DeleteHCRReportFromSelectedGrid;
var
  LRptKey: TTimeLog;
  LChgRegRptNo: RawUtf8;
begin
  if HiChgRegListGrid.SelectedRow = -1 then
    exit;

  if MessageDlg('선택한 Change Register Report를 삭제 할까요?.' + #13#10 +
    '삭제 후에는 복원이 안 됩니다..' , mtConfirmation, [mbYes, mbNo],0) = mrNo then
    exit;

  LRptKey := StrToInt64Def(HiChgRegListGrid.CellsByName['ReportKey4ChgReg', HiChgRegListGrid.SelectedRow],0);
  LChgRegRptNo := HiChgRegListGrid.CellsByName['ChgRegRptNo', HiChgRegListGrid.SelectedRow];
  DeleteHCRReportByReportKeyNChgRegRptNo(LRptKey, LChgRegRptNo);

//  ShowMessage('Reoprt 삭제가 완료 되었습니다.');

  btn_SearchClick(nil);
end;

procedure TChgRegListF.DisplayChgRegList2Grid(
  const ARec: THiRptMgrSearchCondRec);
var
  LOrmHiconReportList: TOrmHiconReportList;
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
          AddConstArray(ConstArray, [i]);

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

    if LWhere = '' then
    begin
      LWhere := 'ID <> ?';
      AddConstArray(ConstArray, [0]);
    end;

    LOrmHiconReportList := TOrmHiconReportList.CreateAndFillPrepare(g_HiconReportListDB.Orm, LWhere, ConstArray);
    try
      if LOrmHiconReportList.FillOne then
      begin
        DisplayChgRegList2GridByRptKey(LOrmHiconReportList.ReportKey);
      end;

    finally
      LOrmHiconReportList.Free;
    end;
  finally
    FinalizeConstArray(ConstArray);
  end;
end;

procedure TChgRegListF.DisplayChgRegList2GridByConstArray(AWhere: string;
  const AAry: TConstArray);
var
  LOrmHiChgRegItem: TOrmHiChgRegItem;
  LUtf8: RawUtf8;
  LDocList: IList<TOrmHiChgRegItem>;
begin
  LOrmHiChgRegItem := TOrmHiChgRegItem.CreateAndFillPrepare(g_HiChgRegItemDB.Orm, AWhere, AAry);
  try
    HiChgRegListGrid.BeginUpdate;
    try
      LDocList := LOrmHiChgRegItem.FillTable.ToIList<TOrmHiChgRegItem>;
      LUtf8 := LDocList.Data.SaveToJson();
      AddHiChgRegListGridRowsFromJsonAry(LUtf8, HiChgRegListGrid.Columns.Count = 0);
    finally
      HiChgRegListGrid.EndUpdate;
    end;

  finally
    FreeAndNil(LOrmHiChgRegItem);
  end;
end;

procedure TChgRegListF.DisplayChgRegList2GridByRptKey(ARptKey: TTimeLog);
var
  LOrmHiChgRegItem: TOrmHiChgRegItem;
  LUtf8: RawUtf8;
  LDocList: IList<TOrmHiChgRegItem>;
begin
  LOrmHiChgRegItem := GetHiChgRegItemByReportKey(ARptKey);
  try
    HiChgRegListGrid.BeginUpdate;
    try
      HiChgRegListGrid.ClearRows();
      LDocList := LOrmHiChgRegItem.FillTable.ToIList<TOrmHiChgRegItem>;
      LUtf8 := LDocList.Data.SaveToJson();
      AddHiChgRegListGridRowsFromJsonAry(LUtf8, HiChgRegListGrid.Columns.Count = 0);
    finally
      HiChgRegListGrid.EndUpdate;
    end;
  finally
    FreeAndNil(LOrmHiChgRegItem);
  end;
end;

procedure TChgRegListF.DropEmptyTarget1Drop(Sender: TObject;
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

        if LowerCase(LFileExt) = HICHGREG_FILE_EXT then
        begin
          LTargetStream := GetStreamFromDropDataFormat2(TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat), i);
          try
            if not Assigned(LTargetStream) then
              ShowMessage('Not Assigned');

            LRawByte := StreamToRawByteString(LTargetStream);
            LFromOutlook := True;

            if LRawByte <> '' then
            begin
              LoadChgRegListFromRawByteString(LRawByte);
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

        if LowerCase(LFileExt) = HICHGREG_FILE_EXT then
        begin
          if FileExists(LFileName) then
            LRawByte := StringFromFile(LFileName)
          else
            LRawByte := '';
        end;

        if LRawByte <> '' then
        begin
          LoadChgRegListFromRawByteString(LRawByte);
      //    ShowMessage(FRptDocDict.S[KN_REPORT]);
        end;
      end;//for
    end;
  end;
end;

procedure TChgRegListF.ExportSelectedToExcel1Click(Sender: TObject);
begin
  MakeHCRReportBySelected();
end;

procedure TChgRegListF.ExportSelectedTohichg1Click(Sender: TObject);
begin
  MakeZipFileFromSelected();
end;

procedure TChgRegListF.FormCreate(Sender: TObject);
begin
  InitHiChgRegItemClient('');
  FJHPFileDB4ChgReg := InitJHPFileClient2(ExtractFilePath(Application.ExeName) + 'HiconChgReg.exe', FJHPFileDB4ChgRegModel);
  FHiChgRegDocDict := DocDict('{}');
  FHiChgRegDocList := DocList('[]');

  if not g_HiRptOpenStatus.IsInitArray then
    g_HiRptOpenStatus.InitArrayRecord(R_HiRptOpenStatus);

  if not g_HiRptDistinction.IsInitArray then
    g_HiRptDistinction.InitArrayRecord(R_HiRptDistinction);

  (DataFormatAdapter2.DataFormat as TVirtualFileStreamDataFormat).OnGetStream := OnGetStream;
end;

procedure TChgRegListF.FormDestroy(Sender: TObject);
begin
  FJHPFileDB4ChgRegModel.Free;
  FJHPFileDB4ChgReg.Free;
end;

function TChgRegListF.GetHiChgRegList2JsonAryFromSelected(AIsIncludeAttachFile: Boolean): RawUtf8;
var
  LDocList, LDocList2: IDocList;
  LVar: variant;
  LUtf8: RawUtf8;
  LKeyId: TTimeLog;
  i, LCount: integer;
begin
  Result := '';
  LDocList := DocList('[]');

  for i := 0 to HiChgRegListGrid.RowCount - 1 do
  begin
    FHiChgRegDocDict.Clear;

    if HiChgRegListGrid.Row[i].Selected then
    begin
      LVar := GetNxGridRow2Variant(HiChgRegListGrid, i);
      LUtf8 := LVar;
      //{'ChgRegRpt': {}, 'Files': [{},{}...]}
      FHiChgRegDocDict.S[KN_CHGREGRPT] := LUtf8;//'ChgRegRpt'

      LKeyId := StrToInt64Def(HiChgRegListGrid.CellByName['ReportKey4ChgReg', i].AsString, 0);

      if AIsIncludeAttachFile then
      begin
        LCount := GetFileCountFromTaskID(LKeyId, FJHPFileDB4ChgReg);

        if LCount > 0 then
        begin
          LUtf8 := GetFiles2JsonAryFromOrmByID(LKeyId, FJHPFileDB4ChgReg);
          FHiChgRegDocDict.S[KN_CHGREGRPT_FILES] := LUtf8;//'Report_Files': [] = json array임
        end;
      end
      else
        FHiChgRegDocDict.S[KN_CHGREGRPT_FILES] := '[]';


      LDocList.Append(FHiChgRegDocDict.Json);
    end;
  end;

  Result := LDocList.Json;
end;

function TChgRegListF.GetHiconReportRecByHcrNo(
  const AHcrNo: string): THiconReportRec;
var
  LOrmHiChgRegItem: TOrmHiChgRegItem;
  LVar: variant;
begin
  Result := Default(THiconReportRec);

  LOrmHiChgRegItem := GetHiChgRegItemByHcrNo(AHcrNo);
  try
    Result.FReportDetailJsonAry := Utf8ToString(LOrmHiChgRegItem.GetJsonValues(true, false, soSelect));
  finally
    LOrmHiChgRegItem.Free;
  end;
end;

function TChgRegListF.GetNewChgRegRptNoByHullNo(AHullNo, ASerialNo: string): string;
begin
  Result := 'HMS-' + g_HiRptKind2.ToString(hrkCHR) + '-' + AHullNo + '-' + ASerialNo;// + '-' + g_HiRptCategory.ToString(hrcIAS)
end;

function TChgRegListF.GetNewChgRegRptNoBySerial(AYear, ASerialNo: integer): string;
begin
  Result := 'HMS-' + g_HiRptKind2.ToString(hrkCHR) + '-' + IntToStr(AYear) + '-' + IntToStr(ASerialNo);// + '-' + g_HiRptCategory.ToString(hrcIAS)
end;

function TChgRegListF.GetRowIdxFromGridByKeyId(const ARpgKeyId, AChgRegRptNo: string): integer;
var
  i: integer;
begin
  Result := -1;

  for i := 0 to HiChgRegListGrid.RowCount - 1 do
  begin
    if (HiChgRegListGrid.CellsByName['ReportKey4ChgReg',i] = ARpgKeyId) and
      (HiChgRegListGrid.CellsByName['ChgRegRptNo',i] = AChgRegRptNo) then
    begin
      Result := i;
      Break;
    end;
  end;
end;

procedure TChgRegListF.GetSearchCondRec(var ARec: THiRptMgrSearchCondRec);
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

function TChgRegListF.GetSqlWhereFromQueryDate(
  AQueryDate: THiRptMgrQueryDateType): string;
begin

end;

procedure TChgRegListF.HiChgRegItemEdit(const ARow: integer);
var
  LOrmHiChgRegItem: TOrmHiChgRegItem;
  LUtf8: RawUtf8;
  LFromDocDict: Boolean;
  LYear, LSerial: integer;
  LVar: Variant;
begin
  if ARow = -1 then //Add
  begin
    LOrmHiChgRegItem := TOrmHiChgRegItem.Create;
    try
      LYear := CurrentYear();
      LSerial := GetNextHGSSerialFromProductType(LYear, Ord(hrkCHR));

      LOrmHiChgRegItem.ReportKey4ChgReg := FReportKey4ChgReg;
//      LOrmHiChgRegItem.ChgRegRptNo := GetNewChgRegRptNoBySerial(LYear, LSerial);
      LOrmHiChgRegItem.ChgRegRptNo := GetNewChgRegRptNoByHullNo(HullNoEdit.Text, '001');
      LOrmHiChgRegItem.ChgRegDate := TimeLogFromDateTime(now);
      LOrmHiChgRegItem.ChgRegModifyDate := TimeLogFromDateTime(now);
      LOrmHiChgRegItem.ChgRegRptAuthorID := ClassSocietyEdit.Text;

      LUtf8 := LOrmHiChgRegItem.GetJsonValues(true, true, soSelect);
    finally
      LOrmHiChgRegItem.Free;
    end;
  end
  else
  begin
    LUtf8 := GetJsonFromSelectedRow(HiChgRegListGrid);
    LUtf8 := ReplaceStrValue2StatusFromJson(LUtf8);
  end;

  //"저장" 버튼을 누르면 True
  if DisplayHiChgRegEditForm(FReportKey4ChgReg, LUtf8, LFromDocDict, FJHPFileDB4ChgReg) = mrOK then
  begin
    //신규 추가한 경우 Report No가 새로 생성됨
    //Current Serial No를 DB에 저장 해야함
    if ARow = -1 then //Add
    begin
      AddOrUpdateNextHGSSerial(LYear, Ord(hrkCHR), 0, LSerial);
    end;

    //DB에 저장함
    LVar := _JSON(LUtf8);

    AddHiChgRegItemFromVariant(LVar, False);

    LoadChgRegJson2Grid(LVar, ARow);

//    if LFromDocDict then
//    begin
//      LKeyId := HiChgRegListGrid.CellsByName['ReportKey', HiChgRegListGrid.SelectedRow];
//    end;
  end;
end;

procedure TChgRegListF.HiChgRegListGridCellDblClick(Sender: TObject; ACol,
  ARow: Integer);
begin
  if HiChgRegListGrid.SelectedRow <> -1 then
    HiChgRegItemEdit(HiChgRegListGrid.SelectedRow);
end;

procedure TChgRegListF.HiChgRegListGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  LFileName: string;
begin
//  if (DragDetectPlus(TWinControl(Sender).Handle, Point(X,Y))) then
  if (HiChgRegListGrid.SelectedCount > 0) and (DragDetectPlus(TWinControl(Sender))) then
  begin
    if HiChgRegListGrid.SelectedRow = -1 then
      exit;

    TVirtualFileStreamDataFormat(DataFormatAdapter2.DataFormat).FileNames.Clear;
    LFileName := IntToStr(TimeLogFromDateTime(now)) + HICHGREG_FILE_EXT;
    TVirtualFileStreamDataFormat(DataFormatAdapter2.DataFormat).FileNames.Add(LFileName);

    DropEmptySource1.Execute;
  end;
end;

procedure TChgRegListF.LoadChgRegFromJson2Grid(AJson: RawUtf8; ARow: integer);
var
  LVar: variant;
begin
  LVar := _JSON(AJson);
  LoadChgRegVar2Grid(LVar, ARow);
end;

procedure TChgRegListF.LoadChgRegJson2Grid(AVar: Variant; ARow: integer);
var
  LUtf8: RawUtf8;
begin
  LUtf8 := AVar;
  LUtf8 := ReplaceStatusValue2StrFromJson(LUtf8);
  AVar := _JSON(LUtf8);

  if ARow = -1 then
  begin
    if TDocVariantData(AVar).IsArray then
      AddNextGridRowsFromVariant2(HiChgRegListGrid, AVar)
    else
      AddNextGridRowFromVariant(HiChgRegListGrid, AVar, True);
  end
  else
    SetNxGridRowFromVar(HiChgRegListGrid, ARow, AVar);
end;

procedure TChgRegListF.LoadChgRegListFromDocDict2Grid;
begin
  if HiChgRegListGrid.RowCount > 0 then
    HiChgRegListGrid.ClearRows;

  LoadChgRegListFromJsonAry2Grid(FHiChgRegDocDict.S[KN_CHGREGRPT]);
end;

procedure TChgRegListF.LoadChgRegListFromDocList2Grid;
var
  LDict: IDocDict;
  LUtf8: RawUtf8;
  LRow: integer;
  i: integer;
  LVar: variant;
begin
  if HiChgRegListGrid.RowCount > 0 then
    HiChgRegListGrid.ClearRows;

  for i := 0 to FHiChgRegDocList.Len - 1 do
  begin
    LUtf8 := FHiChgRegDocList.Item[i];
    LDict := DocDict(LUtf8);
    LVar := _JSON(LDict.S[KN_CHGREGRPT]);
    LoadChgRegJson2Grid(LVar);
  end;
end;

procedure TChgRegListF.LoadChgRegListFromJsonAry2Grid(AJson: RawUtf8);
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
    LRow := GetRowIdxFromGridByKeyId(LDict.S['ReportKey4ChgReg'], LDict.S['ChgRegRptNo']);
    LUtf8 := LDict.Json;

    LoadChgRegFromJson2Grid(LUtf8, LRow);
  end;
end;

procedure TChgRegListF.LoadChgRegListFromRawByteString(
  const ARaw: RawByteString);
var
  LContent: string;
begin
  ClearChgRegDocList();

  LContent := MakeBase64ToString(ARaw);

  FHiChgRegDocList := DocList(StringToUtf8(LContent));

  LoadChgRegListFromDocList2Grid();
end;

procedure TChgRegListF.LoadChgRegVar2Grid(AVar: variant; ARow: integer);
begin
  if ARow = -1 then
  begin
    if TDocVariantData(AVar).IsArray then
      AddNextGridRowsFromVariant2(HiChgRegListGrid, AVar)
    else
      AddNextGridRowFromVariant(HiChgRegListGrid, AVar, True);
  end
  else
    SetNxGridRowFromVar(HiChgRegListGrid, ARow, AVar);
end;

procedure TChgRegListF.LoadHiChgRegList2GridFromFile;
var
  LRaw: RawByteString;
begin
  OpenDialog1.InitialDir := 'c:\temp';
  OpenDialog1.Filter := 'Report Files|*.hirpt|All Files|*.*';

  if OpenDialog1.Execute then
  begin
    LRaw := StringFromFile(OpenDialog1.FileName);
    LoadChgRegListFromRawByteString(LRaw);
  end;
end;

procedure TChgRegListF.MakeHCRReportBySelected;
var
  LRptKey, LCRKey,
  LJsonAry, LSheetName: string;
  LHiconReportRec: THiconReportRec;
  LDocList: IDocList;
//  LDocDict: IDocDict;
  i: integer;
begin
  if HiChgRegListGrid.SelectedRow = -1 then
  begin
    ShowMessage('출력 할 Reoprt 를 선택하세요.');
    exit;
  end;

  LDocList := DocList('[]');
//  LDocDict := DocDict('{}');

  for i := HiChgRegListGrid.RowCount - 1 downto 0 do
  begin
    if HiChgRegListGrid.Row[i].Selected then
    begin
      LCRKey := HiChgRegListGrid.CellsByName['ChgRegRptNo', i];
      //LHiconReportRec.FReportDetailJsonAry에 HCR Json을 저장함
      LHiconReportRec := GetHiconReportRecByHcrNo(LCRKey);
      LRptKey := HiChgRegListGrid.CellsByName['ReportKey4ChgReg', i];
      LHiconReportRec.FReportListJson := Utf8ToString(GetHiConReportJsonByKeyID(LRptKey));
      LHiconReportRec.FReportKind := Ord(hrkCHR);
      LJsonAry := RecordSaveJson(LHiconReportRec, TypeInfo(THiconReportRec));
      LDocList.Append(LJsonAry);
    end;//if
  end;//for

  LJsonAry := LDocList.Json;

  MakeChangeRegisterReport_Async(LJsonAry);
//  ShowMessage('Change Register Report is created.');
end;

procedure TChgRegListF.MakeZipFileFromSelected(AIsIncludeAttachFile: Boolean);
var
  LStr: string;
  LUtf8: RawUtf8;
begin
  LUtf8 := GetHiChgRegList2JsonAryFromSelected();
  LStr := MakeRawUTF8ToBin64(LUtf8);

  MakeZipFileFromString(Utf8ToString(LStr));
end;

procedure TChgRegListF.MakeZipFileFromString(const AContent: string;
  AFileName: string);
begin
  if AFileName = '' then
  begin
    AFileName := 'c:\temp\' + FormatDateTime('yyyymmddhhnnss', now) + HICHGREG_FILE_EXT; //'.hichg';
  end;

  FileFromString(AContent, AFileName);

  ShowMessage('Report List is saved to [' + AFileName + ']');
end;

procedure TChgRegListF.OnGetStream(
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

    LUtf8 := GetHiChgRegList2JsonAryFromSelected();

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

function TChgRegListF.ReplaceStatusValue2StrFromJson(AJson: RawUtf8): RawUtf8;
var
  LStr: string;
  LDict: IDocDict;
  LTimeLog: TTimeLog;
//  LDate: TDate;
begin
  Result := '';

  LDict := DocDict(AJson);
  LStr := LDict.S['OpenStatus'];
  LDict.S['OpenStatus'] := g_HiRptOpenStatus.ToString(StrToIntDef(LStr,0));
  LStr := LDict.S['Distinction'];
  LDict.S['Distinction'] := g_HiRptDistinction.ToString(StrToIntDef(LStr,0));

  LTimeLog := LDict.I['ChgRegDate'];
  LStr := GetDateStrFromTimeLog(LTimeLog);
  LDict.S['ChgRegDate'] := LStr;

  LTimeLog := LDict.I['ChgRegOpenDate'];
  LStr := GetDateStrFromTimeLog(LTimeLog);
  LDict.S['ChgRegOpenDate'] := LStr;

  LTimeLog := LDict.I['ChgRegTestDate'];
  LStr := GetDateStrFromTimeLog(LTimeLog);
  LDict.S['ChgRegTestDate'] := LStr;

  LTimeLog := LDict.I['ChgRegCloseDate'];
  LStr := GetDateStrFromTimeLog(LTimeLog);
  LDict.S['ChgRegCloseDate'] := LStr;

  LTimeLog := LDict.I['ChgRegModifyDate'];
  LStr := GetDateStrFromTimeLog(LTimeLog);
  LDict.S['ChgRegModifyDate'] := LStr;

  Result := LDict.Json;
end;

function TChgRegListF.ReplaceStatusValue2StrFromJsonAry(AJson: RawUtf8): RawUtf8;
var
  LObj: IDocObject;
  LList, LList2: IDOcList;
begin
  Result := '';

  LList := DocList(AJson);
  LList2 := DocList('[]');

  for LObj in LList do
  begin
    AJson := LObj.Json;
    AJson := ReplaceStatusValue2StrFromJson(AJson);
    LList2.Append(AJson);
  end;

  Result := LList2.ToString();//jsonHumanReadable
end;

function TChgRegListF.ReplaceStrValue2StatusFromJson(AJson: RawUtf8): RawUtf8;
var
  LStr: string;
  LDict: IDocDict;
begin
  Result := '';
  LDict := DocDict(AJson);

  LStr := LDict.S['OpenStatus'];
  LDict.I['OpenStatus'] := g_HiRptOpenStatus.ToOrdinal(LStr);
  LStr := LDict.S['Distinction'];
  LDict.I['Distinction'] := g_HiRptDistinction.ToOrdinal(LStr);

  LStr := LDict.S['ChgRegDate'];
  LDict.I['ChgRegDate'] := GetTimeLogFromStr(LStr);

  LStr := LDict.S['ChgRegOpenDate'];
  LDict.I['ChgRegOpenDate'] := GetTimeLogFromStr(LStr);

  LStr := LDict.S['ChgRegTestDate'];
  LDict.I['ChgRegTestDate'] := GetTimeLogFromStr(LStr);

  LStr := LDict.S['ChgRegCloseDate'];
  LDict.I['ChgRegCloseDate'] := GetTimeLogFromStr(LStr);

  LStr := LDict.S['ChgRegModifyDate'];
  LDict.I['ChgRegModifyDate'] := GetTimeLogFromStr(LStr);

  Result := LDict.Json;
end;

function TChgRegListF.ReplaceStrValue2StatusFromJsonAry(AJson: RawUtf8): RawUtf8;
var
  LObj: IDocObject;
  LList, LList2: IDOcList;
begin
  Result := '';

  LList := DocList(AJson);
  LList2 := DocList('[]');

  for LObj in LList do
  begin
    AJson := LObj.Json;
    AJson := ReplaceStrValue2StatusFromJson(AJson);
    LList2.Append(AJson);
  end;

  Result := LList2.ToString();
end;

procedure TChgRegListF.SaveastoDFM1Click(Sender: TObject);
begin
  SaveToDFM2('c:\temp\'+ ChangeFileExt(ExtractFileName(Application.ExeName), '.txt'), Self);
end;

procedure TChgRegListF.SetColCaptionFromList1Click(Sender: TObject);
var
  LStrList: TStringList;
begin
  LStrList := TStringList.Create;
  try
    if FileExists('c:\temp\NameNHintList.txt') then
    begin
      LStrList.LoadFromFile('c:\temp\NameNHintList.txt');
      SetColumnCaptionFromListOnlyColumnExist(HiChgRegListGrid, LStrList);
    end;
  finally
    LStrList.Free;
  end;
end;

procedure TChgRegListF.SetEnable4SaveDBBtn;
begin
  btn_Save2DB.Enabled := FHiChgRegDocDict.Len > 0;
end;

procedure TChgRegListF.SetSrchCondHdrFromDict(ADict: IDocDict);
begin
  HullNoEdit.Text := ADict['HullNo'];
  ShipNameEdit.Text := ADict['ShipName'];
  ProjNoEdit.Text := ADict['ProjectNo'];
  ClassSocietyEdit.Text := ADict['ClassSociety'];

//  ClassSocietyEdit.Text := '';
//  ReportAuthorIDEdit.Text := '';
//
//  ReportKindCombo.ItemIndex := -1;
//  WorkCodeCB.ItemIndex := -1;
//
//  ModifyItemCheckCombo.SetUnCheckedAll();// := -1;
end;

end.
