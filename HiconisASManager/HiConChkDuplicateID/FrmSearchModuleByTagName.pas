unit FrmSearchModuleByTagName;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid, Vcl.Menus,
  mormot.core.base, mormot.core.variants, mormot.core.unicode,
  UnitHiconDBData, UnitHiconTCPIniConfig;

type
  TSrchModuleByTagF = class(TForm)
    OpenDialog1: TOpenDialog;
    TagInfoGrid: TNextGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    TagNameEdit: TEdit;
    Label2: TLabel;
    SystemDBEdit: TEdit;
    BitBtn3: TBitBtn;
    Splitter1: TSplitter;
    BitBtn1: TBitBtn;
    PopupMenu1: TPopupMenu;
    SelectFromTAGNAMEField1: TMenuItem;
    Label3: TLabel;
    HullNoEdit: TEdit;
    BitBtn2: TBitBtn;
    Label4: TLabel;
    BaseDirEdit: TEdit;
    Label5: TLabel;
    EquipKindCombo: TComboBox;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Label6: TLabel;
    TableCombo: TComboBox;
    Label7: TLabel;
    FieldCombo: TComboBox;
    N1: TMenuItem;
    ShowFBLogic1: TMenuItem;
    ShowFBDefaultInfoByFBName1: TMenuItem;
    BitBtn6: TBitBtn;
    N2: TMenuItem;
    ShowINFInfoFromSelected1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure TagInfoGridCellDblClick(Sender: TObject; ACol, ARow: Integer);
    procedure SelectFromTAGNAMEField1Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure ShowFBDefaultInfoByFBName1Click(Sender: TObject);
    procedure ShowFBLogic1Click(Sender: TObject);
    procedure ShowINFInfoFromSelected1Click(Sender: TObject);
  private
    procedure WMCopyData(var Msg: TMessage); message WM_COPYDATA;

    function CheckRequiredInput4Search(): Boolean;
    function IsTagNameColumnByIndex(const ACol: integer): Boolean;
    function GetTagInfoFromDB2Grid(ATagName: string=''): Boolean;
    function GetDBNameFromForm(): string;
    //DATA_TYPE,IN_OUT,SYS_TYPE 필드를 Desc로 대체함
    function UpdateDBValue2HumanReadable(const ATagInfoJsonAry: RawUtf8): RawUtf8;
    function GetTagNameFromGridBySelected(): string;
  protected
    procedure ProcessAsyncResult(const AMsg: string; const ARowCount, AMsgKind: integer);
    procedure ShowOrHideHullNoComp(const AIsShow: Boolean);
  public
    FHiconTCPIniConfig: THiconTCPIniConfig;
    FJsonResult: RawUtf8;
    FIsReturnDblClick: Boolean; //Grid를 Dbl Click할 경우 Tag Name을 반환함
    FSelectedTagName,
    FSelectedOrgTagName: string;

    procedure LoadTagInfoFromJsonAry2Grid(const ATagInfoJsonAry: RawUtf8);
    procedure SetDBInfo2Form(const ADBFileName, ATableName, AFieldName, ATagName: string);
  end;

function CreateSrchModuleByTagForm(AConfig: THiconTCPIniConfig; const ATagName: string=''): string;
function CreateSrchTagForm(var ATagName, ADBFileName: string;
  ATableName, AFieldName: string; const AIsReturnDblClick: Boolean=False): string;
function DisplayTagInfo2SrchTagFormByJsonAry(ATagName, ADBFileName, ATableName, AFieldName: string;
  AJsonAry: RawUtf8): string;

implementation

uses UnitComponentUtil, UnitHiconSystemDBUtil, UnitNextGridUtil2, NxCells,
  UnitCopyData, UnitHiconMPMData,
  FrmJHPWaitForm, FrmHiCONFBLogic;

{$R *.dfm}

function CreateSrchModuleByTagForm(AConfig: THiconTCPIniConfig;const ATagName: string): string;
var
  SrchModuleByTagF: TSrchModuleByTagF;
begin
  Result := '';
  SrchModuleByTagF := nil;

//  if Assigned(SrchModuleByTagF) then
//    FreeAndNil(SrchModuleByTagF);

  SrchModuleByTagF := TSrchModuleByTagF.Create(nil);
  try
    with SrchModuleByTagF do
    begin
      FHiconTCPIniConfig := AConfig;
      HullNoEdit.Text := FHiconTCPIniConfig.HiconHullNo;
      BaseDirEdit.Text := FHiconTCPIniConfig.HiconBaseDir;
      EquipKindCombo.Text := FHiconTCPIniConfig.EquipKind;

      TagNameEdit.Text := ATagName;


      if FileExists(DEFAULT_SYS_BAK_DB_NAME) then
        SystemDBEdit.Text := DEFAULT_SYS_BAK_DB_NAME
      else
        SystemDBEdit.Text := GetDBNameFromForm();

      if ShowModal = mrOK then
      begin
      end;
    end;
  finally
    FreeAndNil(SrchModuleByTagF);
  end;
end;

function CreateSrchTagForm(var ATagName, ADBFileName: string;
  ATableName, AFieldName: string;  const AIsReturnDblClick: Boolean): string;
var
  SrchModuleByTagF: TSrchModuleByTagF;
  LModalResult: integer;
begin
  Result := '';

  SrchModuleByTagF := TSrchModuleByTagF.Create(nil);
  try
    with SrchModuleByTagF do
    begin
      ShowOrHideHullNoComp(False);

      if ADBFileName = '' then
        ADBFileName := DEFAULT_SYS_BAK_DB_NAME;

      SystemDBEdit.Text := ADBFileName;

      if ATableName <> '' then
        TableCombo.Text := ATableName;

      if AFieldName <> '' then
        FieldCombo.Text := AFieldName;

      TagNameEdit.Text := ATagName;
      FIsReturnDblClick := AIsReturnDblClick;

      LModalResult := ShowModal;

      if LModalResult = mrOK then//Grid를 Double Click 한 경우
      begin
        ADBFileName := SystemDBEdit.Text;
        ATagName := FSelectedTagName;//GetTagNameFromGridBySelected();
        Result := FSelectedOrgTagName;
      end
      else
      if LModalResult = mrYes then //Close 버튼을 누른 경우
        ADBFileName := SystemDBEdit.Text;
    end;
  finally
    FreeAndNil(SrchModuleByTagF);
  end;
end;

function DisplayTagInfo2SrchTagFormByJsonAry(ATagName, ADBFileName, ATableName, AFieldName: string;
  AJsonAry: RawUtf8): string;
var
  SrchModuleByTagF: TSrchModuleByTagF;
begin
  SrchModuleByTagF := TSrchModuleByTagF.Create(nil);
  try
    with SrchModuleByTagF do
    begin
      ShowOrHideHullNoComp(False);

      if ADBFileName = '' then
        ADBFileName := DEFAULT_SYS_BAK_DB_NAME;

      SystemDBEdit.Text := ADBFileName;

      if ATableName <> '' then
        TableCombo.Text := ATableName;

      if AFieldName <> '' then
        FieldCombo.Text := AFieldName;

      TagNameEdit.Text := ATagName;

      LoadTagInfoFromJsonAry2Grid(AJsonAry);

      ShowModal;
    end;
  finally
    FreeAndNil(SrchModuleByTagF);
  end;
end;

procedure TSrchModuleByTagF.BitBtn1Click(Sender: TObject);
begin
  EventWaitShow('', False);
  GetTagInfoFromDB2Grid();

//  if CheckRequiredInput4Search() then
//  begin
//    LUtf8 := THiConSystemDB.GetTagInfo2JsonAryFromMAPPINGTable(TagNameEdit.Text, SystemDBEdit.Text);
//
//    if LUtf8 <> '' then
//    begin
//      LoadTagInfoFromJsonAry2Grid(LUtf8);
//    end;
//  end;
end;

procedure TSrchModuleByTagF.BitBtn3Click(Sender: TObject);
begin
  if OpenDialog1.Execute() then
  begin
    SystemDBEdit.Text := OpenDialog1.FileName;
  end;
end;

procedure TSrchModuleByTagF.BitBtn5Click(Sender: TObject);
begin
  SystemDBEdit.Text := GetDBNameFromForm();
end;

function TSrchModuleByTagF.CheckRequiredInput4Search: Boolean;
var
  LControl: TWinControl;
begin
  //필수 입력 항목 중 입력 안된 필드가 있으면 계속 ShowModal
  LControl := CheckRequiredInput(Self);

  Result := not Assigned(LControl);

  if not Result then
  begin
    ActiveControl := LControl;
  end;
end;

procedure TSrchModuleByTagF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  TagInfoGrid.ClearRows; //Memory Leak 방지 위해 추가함
//  TagInfoGrid.Columns.Clear;
end;

procedure TSrchModuleByTagF.FormCreate(Sender: TObject);
begin
  g_HiSysDB_InOut.InitArrayRecord(R_HiSysDB_InOut);
end;

function TSrchModuleByTagF.GetDBNameFromForm: string;
begin
  Result := BaseDirEdit.Text + HullNoEdit.Text + '_' + EquipKindCombo.Text + '\D_Drive\ACONIS-NX\DB\system_bak.accdb';
end;

function TSrchModuleByTagF.GetTagInfoFromDB2Grid(ATagName: string): Boolean;
var
  LDBNameFullPath, LTableName: string;
  LResult: integer;
begin
  if CheckRequiredInput4Search() then
  begin
    if ATagName = '' then
      ATagName := TagNameEdit.Text;

    LDBNameFullPath := SystemDBEdit.Text;

    if LDBNameFullPath = '' then
      LDBNameFullPath := GetDBNameFromForm();

    if not FileExists(LDBNameFullPath) then
    begin
      EventWaitHide();
      ShowMessage('DB not exist : [' + LDBNameFullPath + ']');
      exit;
    end;

    LTableName := TableCombo.Text;

    if LTableName = 'FUNCTION' then //Function Block Default 정보 테이블
    begin
      FJsonResult := THiConSystemDB.GetFBInfo2JsonAryByFBNameFromFUNCTIONTable_Async(Handle, ATagName, LDBNameFullPath);
//      LUtf8 := THiConSystemDB.GetFBInfo2JsonAryByFBNameFromFUNCTIONTable(ATagName, LDBNameFullPath);
//
//      if LUtf8 <> '' then
//      begin
//        LoadTagInfoFromJsonAry2Grid(LUtf8);
//      end;
    end
    else
    begin
      //결과는 WM_COPYDATA 로 반환 됨
      LResult := THiConSystemDB.GetTagInfo2JsonByTableName_Async(Handle, ATagName, LTableName, FieldCombo.Text, LDBNameFullPath);
    end;

    //VAR_NAME 필드에 없으면 TAG_NAME 필드에서 검색함
//    if LUtf8 = '' then
//    begin
//      ShowMessage('Data is null. Please change Tag Name or Field Name.');
//      exit;
//    end;
//      LUtf8 := THiConSystemDB.GetTagInfo2JsonAryFromMAPPINGTable(ATagName, 'TAG_NAME', LDBNameFullPath);

//    if LUtf8 <> '' then
//    begin
//      LoadTagInfoFromJsonAry2Grid(LUtf8);
//    end;
  end
  else
    EventWaitHide();
end;

function TSrchModuleByTagF.GetTagNameFromGridBySelected: string;
begin
  Result := '';

  if TagInfoGrid.SelectedRow <> -1 then
  begin
    if IsExistNextGridColumnName(TagInfoGrid, 'TAG_NAME') then
      Result := TagInfoGrid.CellsByName['TAG_NAME', TagInfoGrid.SelectedRow];
  end;
end;

function TSrchModuleByTagF.IsTagNameColumnByIndex(const ACol: integer): Boolean;
var
  LColName: string;
begin
  LColName := TagInfoGrid.Columns.Item[ACol].Name;

  Result := (LColName <> 'TAG_NAME') or (LColName <> 'VAR_NAME');
end;

procedure TSrchModuleByTagF.LoadTagInfoFromJsonAry2Grid(
  const ATagInfoJsonAry: RawUtf8);
var
  LUtf8: RawUtf8;
begin
  //AddNextGridRowsFromJsonAry()에서 ClearRows()를 실행하면 Memory Leak 발생함
  //Column을 동적으로 생성했을 경우 ClearRow를 먼저 실행한 후 Columns.Clear를 실행해야 Memory Leak 방지함
  TagInfoGrid.ClearRows;
  TagInfoGrid.Columns.Clear;

//{"TAG_NAME":"DI01320_07","DESCRIPTION":"","RESOURCE":"MPM13","RES_ID":3,"CH_ID":369228399,
//"DATA_TYPE":1,"ORG_TAG":"DI01320","IN_OUT":1,"INDEX_NO":0,"FUNC_NAME":"NX-DI16",
//"VAR_NAME":"SHG_SHG36_X","SYS_TYPE":10}
//DATA_TYPE,IN_OUT,SYS_TYPE 필드를 Desc로 대체함
  LUtf8 := UpdateDBValue2HumanReadable(ATagInfoJsonAry);
//  LUtf8 := ATagInfoJsonAry;
  AddNextGridRowsFromJsonAry(TagInfoGrid, LUtf8, True);
end;

procedure TSrchModuleByTagF.ProcessAsyncResult(const AMsg: string;
  const ARowCount, AMsgKind: integer);
begin
  case AMsgKind of
    //THiConSystemDB.GetTagInfo2JsonByTableName_Async 결과 처리
    1: begin
      if AMsg = '' then
      begin
        if FIsReturnDblClick then
          ModalResult := mrOK;
      end
      else begin
        FJsonResult := StringToUtf8(AMsg);

        //Data 갯수가 1개이면
        if ARowCount = 1 then
        begin
          if FIsReturnDblClick then
          begin
            FSelectedTagName := THiConSystemDB.GetTagNameFromJsonAryOfMAPPINGTable(FJsonResult);
            ModalResult := mrOK;
          end
          else
            LoadTagInfoFromJsonAry2Grid(FJsonResult);
        end
        else if ARowCount > 1 then
          LoadTagInfoFromJsonAry2Grid(FJsonResult);
      end;
    end;
    //THiConSystemDB.GetFBInfo2JsonAryByFBNameFromFUNCTIONTable_Async 결과 처리
    2: begin
      if AMsg <> '' then
      begin
        FJsonResult := StringToUtf8(AMsg);
        LoadTagInfoFromJsonAry2Grid(FJsonResult);
      end;
    end;
  end;

  EventWaitHide();
end;

procedure TSrchModuleByTagF.SelectFromTAGNAMEField1Click(Sender: TObject);
var
  LPoint: TPoint;
  LTagName: string;
  LCell: TCell;
  LRowCount: integer;
begin
  if TagInfoGrid.SelectedRow = -1 then
    exit;

  //LPoint.X : Col Index, LPoint.Y : Row Index
  LPoint := TagInfoGrid.SelectedCell;

  if IsTagNameColumnByIndex(LPoint.X) then
  begin
    LCell := TagInfoGrid.Cell[LPoint.X, LPoint.Y];;

    LTagName := LCell.AsString;

    FJsonResult := THiConSystemDB.GetTagInfo2JsonAryFromMAPPINGTable(LTagName, 'TAG_NAME', LRowCount, SystemDBEdit.Text);

    if FJsonResult <> '' then
    begin
      LoadTagInfoFromJsonAry2Grid(FJsonResult);
    end;
  end;
end;

procedure TSrchModuleByTagF.SetDBInfo2Form(const ADBFileName, ATableName, AFieldName,
  ATagName: string);
begin
  SystemDBEdit.Text := ADBFileName;
  TableCombo.Text := ATableName;
  FieldCombo.Text := AFieldName;
  TagNameEdit.Text := ATagName;
end;

procedure TSrchModuleByTagF.ShowFBDefaultInfoByFBName1Click(Sender: TObject);
var
  LFBName: string;
begin
  if TagInfoGrid.SelectedRow = -1 then
    exit;

  if TableCombo.Text = 'FUNCTION' then
  begin
    LFBName := TagInfoGrid.CellsByName['FUNC_NAME', TagInfoGrid.SelectedRow];
    CreateNShowHiCONFBLogicForm(LFBName, FJsonResult, '');
  end
  else
    ShowMessage('This feature is only for "FUNCION" Tabel');
end;

procedure TSrchModuleByTagF.ShowFBLogic1Click(Sender: TObject);
var
  LTagName: string;
begin
  if IsExistNextGridColumnName(TagInfoGrid, 'TAG_NAME') then
  begin
    LTagName := TagInfoGrid.CellsByName['TAG_NAME', TagInfoGrid.SelectedRow];

    if LTagName <> '' then
      CreateNShowHiCONFBLogicForm(LTagName, '', SystemDBEdit.Text);
  end;
end;

procedure TSrchModuleByTagF.ShowINFInfoFromSelected1Click(Sender: TObject);
var
  LStr, LColName: string;
  LTagSearchRec: TTagSearchRec;
begin
  if TagInfoGrid.SelectedRow = -1 then
    exit
  else
  begin
    LColName := TagInfoGrid.Columns.Item[TagInfoGrid.SelectedColumn].Name;

    if (LColName = 'TAG_NAME') or (LColName = 'VAR_NAME') or (LColName = 'ORG_TAG') then
      LStr := TagInfoGrid.CellsByName[LColName, TagInfoGrid.SelectedRow];
  end;

  if LStr = '' then
    exit;

  LTagSearchRec := GetTagSearchRecFromTagInfoEditForm(LStr);

  LStr := GetResNPtcJsonNameFromSrcByInfTag(LTagSearchRec);

  CreateNShowDateSeletForm(LStr);
end;

procedure TSrchModuleByTagF.ShowOrHideHullNoComp(const AIsShow: Boolean);
begin
  Label3.Visible := AIsShow;
  Label4.Visible := AIsShow;
  Label5.Visible := AIsShow;

  HullNoEdit.Visible := AIsShow;
  BaseDirEdit.Visible := AIsShow;
  EquipKindCombo.Visible := AIsShow;

  BitBtn2.Visible := AIsShow;
  BitBtn4.Visible := AIsShow;
  BitBtn5.Visible := AIsShow;
end;

procedure TSrchModuleByTagF.TagInfoGridCellDblClick(Sender: TObject; ACol,
  ARow: Integer);
begin
  if ARow = -1 then
    exit;

  if IsTagNameColumnByIndex(ACol) then
  begin
    FSelectedOrgTagName := '';
    FSelectedTagName := TagInfoGrid.Cells[ACol, ARow];

    if IsExistNextGridColumnName(TagInfoGrid, 'ORG_TAG') then
      FSelectedOrgTagName := TagInfoGrid.CellsByName['ORG_TAG', ARow];

    if FIsReturnDblClick then
      ModalResult := mrOK
    else
      GetTagInfoFromDB2Grid(FSelectedTagName);
  end;
end;

function TSrchModuleByTagF.UpdateDBValue2HumanReadable(
  const ATagInfoJsonAry: RawUtf8): RawUtf8;
var
  LList, LList2: IDocList;
  LDataTypeDict, LSysTypeDict, LDict: IDocDict;
  LUtf8: RawUtf8;
  LVar: variant;
  i: integer;
begin
  LList2 := DocList('[]');

  LUtf8 := THiConSystemDB.GetDataType2JsonFromDB(SystemDBEdit.Text);
  LDataTypeDict := DocDict(LUtf8);
  LUtf8 := THiConSystemDB.GetSystemType2JsonFromDB(SystemDBEdit.Text);
  LSysTypeDict := DocDict(LUtf8);

  //DATA_TYPE,IN_OUT,SYS_TYPE 필드를 Desc로 대체함
  LList := DocList(ATagInfoJsonAry);

  for i := 0 to LList.Len - 1 do
  begin
//    LVar := LList.Item[i];
    LUtf8 := LList.S[i];
    LDict := DocDict(LUtf8);
    LDict.S['DATA_TYPE'] := LDataTypeDict.S[LDict.S['DATA_TYPE']];
    LDict.S['IN_OUT'] := g_HiSysDB_InOut.ToString(StrToIntDef(LDict.S['IN_OUT'],0));
    LDict.S['SYS_TYPE'] := LSysTypeDict.S[LDict.S['SYS_TYPE']];
    LVar := _JSON(LDict.Json);
    LList2.Append(LVar);
  end;

  Result := LList2.Json;
end;

procedure TSrchModuleByTagF.WMCopyData(var Msg: TMessage);
var
  LMsg: string;
//  LRec : TRecToPass;
  LRowCount: integer;
begin
//  LRec := PRecToPass(PCopyDataStruct(Msg.LParam)^.lpData)^;
//  SetString(LMsg, PChar(@LRec.StrMsg), Length(LRec.StrMsg));
  LMsg := PChar(PCopyDataStruct(Msg.LParam)^.lpData);
  LRowCount := PCopyDataStruct(Msg.LParam)^.dwData;

  ProcessAsyncResult(LMsg, LRowCount, Msg.WParam);
end;

end.
