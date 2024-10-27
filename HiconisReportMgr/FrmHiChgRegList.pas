unit FrmHiChgRegList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SBPro, NxScrollControl,
  NxCustomGridControl, NxCustomGrid, NxGrid, AdvOfficeTabSet, AeroButtons,
  Vcl.ExtCtrls, Vcl.Mask, JvExMask, JvToolEdit, JvCombobox, Vcl.Buttons,
  AdvEdit, AdvEdBtn, Vcl.StdCtrls, Vcl.ComCtrls, AdvGroupBox, AdvOfficeButtons,
  JvExControls, JvLabel, CurvyControls, Vcl.Menus,

  mormot.core.base, mormot.core.variants, mormot.core.buffers, mormot.core.unicode,
  mormot.core.data, mormot.orm.base, mormot.core.os, mormot.core.text,
  mormot.core.datetime, mormot.core.rtti, mormot.core.collections,

  VarRecUtils, UnitHiConReportMgrData, UnitHiConReportMgR
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
    procedure SaveastoDFM1Click(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure Btn_ExportClick(Sender: TObject);
    procedure Btn_NewClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FReportKey4ChgReg: TTimeLog;

    procedure ClearFindCondForm();
    procedure SetSrchCondHdrFromDict(ADict: IDocDict);

    function GetSqlWhereFromQueryDate(AQueryDate: THiRptMgrQueryDateType): string;
    procedure GetSearchCondRec(var ARec: THiRptMgrSearchCondRec);

    procedure DisplayChgRegList2GridByConstArray(AWhere: string; const AAry: TConstArray);
    procedure DisplayChgRegList2GridByRptKey(ARptKey: TTimeLog);
    procedure DisplayChgRegList2Grid(const ARec: THiRptMgrSearchCondRec);

    procedure HiChgRegItemEdit(const ARow: integer=-1);
    procedure LoadChgRegJson2Grid(AJson: string; ARow: integer=-1);
  public
    { Public declarations }
  end;

  //AFromDocDict : True = DB에 저장하지 않음
  function DisplayHiChgRegListForm(AReportJson: string; AFromDocDict: Boolean): integer;

var
  ChgRegListF: TChgRegListF;

implementation

uses UnitDFMUtil, UnitNextGridUtil2, UnitComboBoxUtil, JHP.Util.Bit32Helper,
  UnitExcelUtil,  UnitHiConChgRegItemOrm, UnitHiConReportListOrm,
  FrmHiChangeRegisterEdit;

{$R *.dfm}

function DisplayHiChgRegListForm(AReportJson: string; AFromDocDict: Boolean): integer;
var
  LChgRegListEditF: TChgRegListF;
  LJson: RawUtf8;
  LDict: IDocDict;
begin
  LDict := DocDict(AReportJson);

  LChgRegListEditF := TChgRegListF.Create(nil);
  try
    with LChgRegListEditF do
    begin
      FReportKey4ChgReg := StrToInt64(LDict['ReportKey']);

      SetSrchCondHdrFromDict(LDict);
      LJson := GetHiChgRegItemJsonAryByReportKey(FReportKey4ChgReg);
      AddNextGridRowsFromJsonAry(HiChgRegListGrid, LJson, HiChgRegListGrid.Columns.Count = 0);

      Result := ShowModal;

      if Result = mrOK then
      begin

      end;
    end;//with
  finally
    LChgRegListEditF.Free;
  end;
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
      AddNextGridRowsFromJsonAry(HiChgRegListGrid, LUtf8, HiChgRegListGrid.Columns.Count = 0);
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
      LDocList := LOrmHiChgRegItem.FillTable.ToIList<TOrmHiChgRegItem>;
      LUtf8 := LDocList.Data.SaveToJson();
      AddNextGridRowsFromJsonAry(HiChgRegListGrid, LUtf8, HiChgRegListGrid.Columns.Count = 0);
    finally
      HiChgRegListGrid.EndUpdate;
    end;
  finally
    FreeAndNil(LOrmHiChgRegItem);
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
  LKeyId: string;
begin
  if ARow = -1 then //Add
  begin
    LOrmHiChgRegItem := TOrmHiChgRegItem.Create;
    try
      LOrmHiChgRegItem.ReportKey4ChgReg := FReportKey4ChgReg;
      LOrmHiChgRegItem.RegDate := TimeLogFromDateTime(now);
      LOrmHiChgRegItem.ModifyDate_ChgReg := TimeLogFromDateTime(now);

      LUtf8 := LOrmHiChgRegItem.GetJsonValues(true, true, soSelect);
    finally
      LOrmHiChgRegItem.Free;
    end;
  end
  else
  begin
    LUtf8 := GetJsonFromSelectedRow(HiChgRegListGrid);
  end;

  //"저장" 버튼을 누르면 True
  if DisplayHiChgRegEditForm(LUtf8, LFromDocDict) = mrOK then
  begin
    LoadChgRegJson2Grid(LUtf8, ARow);

//    if LFromDocDict then
//    begin
//      LKeyId := HiChgRegListGrid.CellsByName['ReportKey', HiChgRegListGrid.SelectedRow];
//    end;
  end;
end;

procedure TChgRegListF.LoadChgRegJson2Grid(AJson: string; ARow: integer);
var
  LVar: variant;
begin
  LVar := _JSON(AJson);

  if ARow = -1 then
  begin
    if TDocVariantData(LVar).IsArray then
      AddNextGridRowsFromVariant2(HiChgRegListGrid, LVar)
    else
      AddNextGridRowFromVariant(HiChgRegListGrid, LVar, True);
  end
  else
    SetNxGridRowFromVar(HiChgRegListGrid, ARow, LVar);
end;

procedure TChgRegListF.SaveastoDFM1Click(Sender: TObject);
begin
  SaveToDFM2('c:\temp\'+ ChangeFileExt(ExtractFileName(Application.ExeName), '.txt'), Self);
end;

procedure TChgRegListF.SetSrchCondHdrFromDict(ADict: IDocDict);
begin
  HullNoEdit.Text := ADict['HullNo'];
  ShipNameEdit.Text := ADict['ShipName'];
  ProjNoEdit.Text := ADict['ProjectNo'];;
//  ClassSocietyEdit.Text := '';
//  ReportAuthorIDEdit.Text := '';
//
//  ReportKindCombo.ItemIndex := -1;
//  WorkCodeCB.ItemIndex := -1;
//
//  ModifyItemCheckCombo.SetUnCheckedAll();// := -1;
end;

end.
