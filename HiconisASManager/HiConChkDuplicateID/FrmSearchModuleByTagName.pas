unit FrmSearchModuleByTagName;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid, Vcl.Menus,
  mormot.core.base, mormot.core.variants,
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
    Button1: TButton;
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
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TagInfoGridCellDblClick(Sender: TObject; ACol, ARow: Integer);
    procedure SelectFromTAGNAMEField1Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
  private
    function CheckRequiredInput4Search(): Boolean;
    function IsTagNameColumnByIndex(const ACol: integer): Boolean;
    function GetTagInfoFromDB2Grid(ATagName: string=''): Boolean;
    procedure LoadTagInfoFromJsonAry2Grid(const ATagInfoJsonAry: RawUtf8);
    function GetDBNameFromForm(): string;
    //DATA_TYPE,IN_OUT,SYS_TYPE 필드를 Desc로 대체함
    function UpdateDBValue2HumanReadable(const ATagInfoJsonAry: RawUtf8): RawUtf8;
  public
    FHiconTCPIniConfig: THiconTCPIniConfig;
  end;

  function CreateSrchModuleByTagForm(AConfig: THiconTCPIniConfig; const ATagName: string=''): string;

var
  SrchModuleByTagF: TSrchModuleByTagF;

implementation

uses UnitComponentUtil, UnitHiconSystemDBUtil, UnitNextGridUtil2, NxCells,
  FrmJHPWaitForm;

{$R *.dfm}

function CreateSrchModuleByTagForm(AConfig: THiconTCPIniConfig;const ATagName: string): string;
begin
  Result := '';

  if Assigned(SrchModuleByTagF) then
    FreeAndNil(SrchModuleByTagF);

  SrchModuleByTagF := TSrchModuleByTagF.Create(nil);
  try
    with SrchModuleByTagF do
    begin
      FHiconTCPIniConfig := AConfig;
      HullNoEdit.Text := FHiconTCPIniConfig.HiconHullNo;
      BaseDirEdit.Text := FHiconTCPIniConfig.HiconBaseDir;
      EquipKindCombo.Text := FHiconTCPIniConfig.EquipKind;

      TagNameEdit.Text := ATagName;


      if FileExists('D:\ACONIS-NX\DB\system_bak.accdb') then
        SystemDBEdit.Text := 'D:\ACONIS-NX\DB\system_bak.accdb'
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

procedure TSrchModuleByTagF.BitBtn1Click(Sender: TObject);
begin
  EventWaitShow('', False);
  GetTagInfoFromDB2Grid();
  EventWaitHide();

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

procedure TSrchModuleByTagF.Button1Click(Sender: TObject);
begin
  Close;
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
  LUtf8: RawUtf8;
  LDBNameFullPath: string;
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
      ShowMessage('DB not exist : [' + LDBNameFullPath + ']');
      exit;
    end;

    LUtf8 := THiConSystemDB.GetTagInfo2JsonAryFromMAPPINGTable(ATagName, 'VAR_NAME', LDBNameFullPath);

    //VAR_NAME 필드에 없으면 TAG_NAME 필드에서 검색함
    if LUtf8 = '' then
      LUtf8 := THiConSystemDB.GetTagInfo2JsonAryFromMAPPINGTable(ATagName, 'TAG_NAME', LDBNameFullPath);


    if LUtf8 <> '' then
    begin
      LoadTagInfoFromJsonAry2Grid(LUtf8);
    end;
  end;
end;

function TSrchModuleByTagF.IsTagNameColumnByIndex(const ACol: integer): Boolean;
begin
  Result := (TagInfoGrid.Columns.Column['TAG_NAME'].Index <> ACol) or
            (TagInfoGrid.Columns.Column['VAR_NAME'].Index <> ACol);
end;

procedure TSrchModuleByTagF.LoadTagInfoFromJsonAry2Grid(
  const ATagInfoJsonAry: RawUtf8);
var
  LUtf8: RawUtf8;
begin
//  TagInfoGrid.ClearRows; //AddNextGridRowsFromJsonAry()에서 ClearRows()를 실행함
  TagInfoGrid.Columns.Clear;

//{"TAG_NAME":"DI01320_07","DESCRIPTION":"","RESOURCE":"MPM13","RES_ID":3,"CH_ID":369228399,
//"DATA_TYPE":1,"ORG_TAG":"DI01320","IN_OUT":1,"INDEX_NO":0,"FUNC_NAME":"NX-DI16",
//"VAR_NAME":"SHG_SHG36_X","SYS_TYPE":10}
  LUtf8 := UpdateDBValue2HumanReadable(ATagInfoJsonAry);
//  LUtf8 := ATagInfoJsonAry;
  AddNextGridRowsFromJsonAry(TagInfoGrid, LUtf8, True);
end;

procedure TSrchModuleByTagF.SelectFromTAGNAMEField1Click(Sender: TObject);
var
  LUtf8: RawUtf8;
  LPoint: TPoint;
  LTagName: string;
  LCell: TCell;
begin
  if TagInfoGrid.SelectedRow = -1 then
    exit;

  //LPoint.X : Col Index, LPoint.Y : Row Index
  LPoint := TagInfoGrid.SelectedCell;

  if IsTagNameColumnByIndex(LPoint.X) then
  begin
    LCell := TagInfoGrid.Cell[LPoint.X, LPoint.Y];;

    LTagName := LCell.AsString;

    if LUtf8 = '' then
      LUtf8 := THiConSystemDB.GetTagInfo2JsonAryFromMAPPINGTable(LTagName, 'TAG_NAME', SystemDBEdit.Text);

    if LUtf8 <> '' then
    begin
      LoadTagInfoFromJsonAry2Grid(LUtf8);
    end;
  end;
end;

procedure TSrchModuleByTagF.TagInfoGridCellDblClick(Sender: TObject; ACol,
  ARow: Integer);
var
  LTagName: string;
begin
  if ARow = -1 then
    exit;

  if IsTagNameColumnByIndex(ACol) then
  begin
    LTagName := TagInfoGrid.Cells[ACol, ARow];

    GetTagInfoFromDB2Grid(LTagName);
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

end.
