unit FrmHiconReportEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DropSource, DragDrop, DropTarget,
  Vcl.Menus, Vcl.ImgList, Vcl.Buttons, AdvEdit, AdvEdBtn, CurvyControls,
  pjhComboBox, NxColumnClasses, Vcl.StdCtrls, AeroButtons, Vcl.ExtCtrls,
  NxColumns, NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid,
  AdvGlowButton, Vcl.ComCtrls, AdvToolBtn, JvExControls, JvLabel, AdvGroupBox,
  AdvOfficeButtons,

  mormot.core.base, mormot.core.variants, mormot.core.buffers, mormot.core.unicode,
  mormot.core.data, mormot.orm.base, mormot.core.os, mormot.core.text,
  mormot.core.datetime, mormot.core.rtti, mormot.core.collections,

  UnitHiConReportListOrm, UnitHiConReportWorkItemOrm, UnitFrameFileList2,
  UnitHiConRptDM, UnitHGSSerialRecord2, NxEdit
  ;

type
  THiConReportEditF = class(TForm)
    PageControl1: TPageControl;
    TabSheet5: TTabSheet;
    JvLabel36: TJvLabel;
    JvLabel37: TJvLabel;
    Label2: TLabel;
    JvLabel38: TJvLabel;
    JvLabel16: TJvLabel;
    WorkBeginTime: TDateTimePicker;
    WorkEndTime: TDateTimePicker;
    NextWorkDesc: TMemo;
    CurrentWorkDesc: TMemo;
    TabSheet3: TTabSheet;
    SubConTS: TTabSheet;
    Panel1: TPanel;
    AeroButton2: TAeroButton;
    AeroButton3: TAeroButton;
    WorkItemGrid: TNextGrid;
    NxIncrementColumn1: TNxIncrementColumn;
    CurvyPanel1: TCurvyPanel;
    btn_Close: TAeroButton;
    AeroButton1: TAeroButton;
    CurvyPanel2: TCurvyPanel;
    Panel4: TPanel;
    JvLabel7: TJvLabel;
    JvLabel6: TJvLabel;
    JvLabel3: TJvLabel;
    JvLabel4: TJvLabel;
    ShipOwner: TEdit;
    HullNo: TAdvEditBtn;
    ShipName: TEdit;
    ProjectNo: TAdvEditBtn;
    BitBtn1: TBitBtn;
    Panel5: TPanel;
    JvLabel31: TJvLabel;
    JvLabel49: TJvLabel;
    JvLabel30: TJvLabel;
    JvLabel10: TJvLabel;
    ReportSubject: TEdit;
    ReportAuthorID: TEdit;
    ReportAuthorName: TEdit;
    ReportMakeDate: TDateTimePicker;
    DropEmptyTarget1: TDropEmptyTarget;
    DataFormatAdapterTarget: TDataFormatAdapter;
    DataFormatAdapter1: TDataFormatAdapter;
    DataFormatAdapter2: TDataFormatAdapter;
    DropEmptySource1: TDropEmptySource;
    DataFormatAdapter3: TDataFormatAdapter;
    SaveDialog1: TSaveDialog;
    ClassSociety: TEdit;
    JvLabel5: TJvLabel;
    JvLabel19: TJvLabel;
    ModifyItems: TAdvOfficeCheckGroup;
    WorkDetail: TNxTextColumn;
    WorkDetailRemark: TNxTextColumn;
    WorkItemBeginTime: TNxDateColumn;
    WorkItemEndTime: TNxDateColumn;
    ReportKey: TEdit;
    WorkCode: TNxNumberColumn;
    WorkHours: TNxNumberColumn;
    ReportKey4Item: TNxNumberColumn;
    ModifyDate_Item: TNxDateColumn;
    WorkItemKey: TNxNumberColumn;
    JvLabel2: TJvLabel;
    OwnerComment: TMemo;
    TJHPFileListFrame1: TJHPFileListFrame;
    JvLabel1: TJvLabel;
    ReportKind: TComboBox;
    JvLabel8: TJvLabel;
    ShipType: TEdit;
    ComissionRptNo: TNxButtonEdit;

    procedure AeroButton2Click(Sender: TObject);
    procedure WorkItemGridCellDblClick(Sender: TObject; ACol, ARow: Integer);
    procedure HullNoClickBtn(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AeroButton3Click(Sender: TObject);
  private
    procedure ReportWorkItemEdit(const ARow: integer=-1);
    procedure LoadWorkItemVar2Grid(AVar: variant; ARow: integer=-1);
    procedure LoadWorkItemVarFromGrid(var AVar: variant; const ARow: integer=-1);

    procedure InitEnum();

    function CheckRequiredInput4Report(): TWinControl;
    function CheckExistHangulInput4Report(): TWinControl;
    function CheckInputLengthOver4Report(): TWinControl;
  public
    function GetWorkItem2JsonFromGrid(): string;
    procedure SetWorkItemGridFromJson(const AJson: string);
    procedure AddModifyItemGrpValue2Json(var AJson: string);
    procedure DeleteWorkItemByReportKey();
  end;

  //AFromDocDict : True = DB에 저장하지 않음
  function DisplayHiRptEditForm(var AReportJson, AWorkItemJson: RawUtf8; AFromDocDict: Boolean): integer;

var
  HiConReportEditF: THiConReportEditF;

implementation

uses UnitNextGridUtil2, UnitRttiUtil2, UnitVesselMasterRecord2, UnitClipBoardUtil,
  UnitHiConReportMgrData, UnitCheckGrpAdvUtil, UnitComponentUtil, UnitTRegExUtil,
  FrmHiReportWorkItemEdit, FrmSearchVessel2;

{$R *.dfm}

function DisplayHiRptEditForm(var AReportJson, AWorkItemJson: RawUtf8;
  AFromDocDict: Boolean): integer;
var
  LHiConReportEditF: THiConReportEditF;
  LJson, LJson2: string;
  LVar: variant;
  LControl: TWinControl;
begin
  LHiConReportEditF := THiConReportEditF.Create(nil);
  try
    with LHiConReportEditF do
    begin
      LJson := Utf8ToString(AReportJson);
      SetCompNameValueFromJson2FormByClassType(LHiConReportEditF, LJson);
      LJson2 := Utf8ToString(AWorkItemJson);
      SetWorkItemGridFromJson(LJson2);
      PageControl1.ActivePageIndex := 0;

      while True do
      begin
        Result := ShowModal;

        if Result = mrOK then
        begin
          //필수 입력 항목 중 입력 안된 필드가 있으면 계속 ShowModal
          LControl := CheckRequiredInput4Report();

          if Assigned(LControl) then
          begin
            PageControl1.ActivePageIndex := 0;
            ActiveControl := LControl;
            Continue;
          end;

          //한글 입력 된 필드가 있으면 계속 ShowModal
          LControl := CheckExistHangulInput4Report();

          if Assigned(LControl) then
          begin
            PageControl1.ActivePageIndex := 0;
            ActiveControl := LControl;
            Continue;
          end;

          //길이가 70자 이상인 필드가 있으면 계속 ShowModal
          LControl := CheckInputLengthOver4Report();

          if Assigned(LControl) then
          begin
            PageControl1.ActivePageIndex := 0;
            ActiveControl := LControl;
            Continue;
          end;

          LJson := GetCompNameValue2JsonFromFormByClassType(LHiConReportEditF);
          LJson2 := GetWorkItem2JsonFromGrid();

          if not AFromDocDict then
          begin
            LVar := _Json(LJson);
            AddHiconReportListFromVariant(LVar);

            //기존 ReportKey->WorkItem 모두 지움
            DeleteWorkItemByReportKey();

            if LJson2 <> '[]' then
            begin
              LVar := _Json(LJson2);
              AddHiconReportDetailFromVarAry(LVar, True);
            end;
          end;

          AReportJson := StringToUtf8(LJson);
          AWorkItemJson := StringToUtf8(LJson2);
        end;//if

        Break;
      end;//while
    end;//with

  finally
    LHiConReportEditF.Free;
  end;
end;

procedure THiConReportEditF.AddModifyItemGrpValue2Json(var AJson: string);
var
  LVar: variant;
  LSet: integer;
begin
  LVar := _JSON(AJson);

  LSet := GetSetsFromCheckGrp(ModifyItems);
  TDocVariantData(LVar).AddOrUpdateValue('ModifyItems', LSet);

  AJson := Utf8ToString(LVar);
end;

procedure THiConReportEditF.AeroButton2Click(Sender: TObject);
begin
  ReportWorkItemEdit();
end;

procedure THiConReportEditF.AeroButton3Click(Sender: TObject);
var
  LRow: integer;
begin
  LRow := WorkItemGrid.SelectedRow;

  if LRow = -1 then
  begin
    ShowMessage('Select Item');
    exit;
  end;

  if MessageDlg('Aru you sure delete the selected item?.', mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    WorkItemGrid.BeginUpdate;
    try
      WorkItemGrid.Row[LRow].Visible := False;
    finally
      WorkItemGrid.EndUpdate;
    end;
  end;
end;

procedure THiConReportEditF.BitBtn1Click(Sender: TObject);
begin
  Content2Clipboard(HullNo.Text);
end;

function THiConReportEditF.CheckExistHangulInput4Report: TWinControl;
begin
  Result := CheckExistHangulInput(Self);
end;

function THiConReportEditF.CheckInputLengthOver4Report: TWinControl;
begin
  Result := CheckInputLengthOver(Self, 70);
end;

function THiConReportEditF.CheckRequiredInput4Report: TWinControl;
begin
  Result := CheckRequiredInput(Self);
end;

procedure THiConReportEditF.DeleteWorkItemByReportKey;
var
  LKey: TTimeLog;
begin
  LKey := StrToInt64Def(ReportKey.Text, 0);
  DeleteHiconReportDetailByRptKey(LKey);
end;

procedure THiConReportEditF.FormCreate(Sender: TObject);
begin
  InitEnum();
end;

function THiConReportEditF.GetWorkItem2JsonFromGrid: string;
var
  LVar: variant;
begin
  //Grid Row.Visible = True인 Row만 Variant에 추가함
  LVar := NextGrid2Variant(WorkItemGrid);
  Result := Utf8ToString(LVar);
end;

procedure THiConReportEditF.HullNoClickBtn(Sender: TObject);
var
  LVesselSearchParamRec: TVesselSearchParamRec;
begin
  LVesselSearchParamRec.fHullNo := HullNo.Text;
  LVesselSearchParamRec.fShipName := ShipName.Text;

  if ShowSearchVesselForm(LVesselSearchParamRec) = mrOK then
  begin
    HullNo.Text := LVesselSearchParamRec.fHullNo;
    ShipName.Text := LVesselSearchParamRec.fShipName;
    ShipType.Text := LVesselSearchParamRec.fShipType;
  end;
end;

procedure THiConReportEditF.InitEnum;
begin
  g_HiRptKind.SetType2Combo(ReportKind);
  g_HiRptModifiedItem.SetType2List(ModifyItems.Items);
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
  if WorkItemGrid.RowCount >= MAX_REPORT_WORKITEM then
  begin
    ShowMessage('작업상세 건수는 ' + IntToStr(MAX_REPORT_WORKITEM) + '건을 넘을 수 없습니다.');
    exit;
  end;

  TDocVariant.New(LVar);

  if ARow = -1 then //Add
  begin
    LVar.ReportKey4Item := StrToInt64Def(ReportKey.Text, 0);
    LVar.WorkItemKey := TimeLogFromDateTime(now);
    LVar.ModifyDate_Item := TimeLogFromDateTime(now);
    LVar.WorkItemBeginTime := TimeLogFromDateTime(WorkBeginTime.Date + time);
    LVar.WorkItemEndTime := TimeLogFromDateTime(WorkBeginTime.Date + time);
  end
  else
  begin
    LoadWorkItemVarFromGrid(LVar, ARow);
  end;

  //"저장" 버튼을 누르면 True
  if DisplayRptWorkItemEditForm(LVar) = mrOK then
    LoadWorkItemVar2Grid(LVar, ARow);
end;

procedure THiConReportEditF.SetWorkItemGridFromJson(const AJson: string);
var
  LDocList: IDocList;
  LAryUtf8: RawUtf8;
  LVar: variant;
begin
  LAryUtf8 := StringToUtf8(AJson);
  AddNextGridRowsFromJsonAry(WorkItemGrid, LAryUtf8);
end;

procedure THiConReportEditF.WorkItemGridCellDblClick(Sender: TObject; ACol,
  ARow: Integer);
begin
  ReportWorkItemEdit(ARow);
end;

end.
