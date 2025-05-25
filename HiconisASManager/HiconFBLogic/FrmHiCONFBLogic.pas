unit FrmHiCONFBLogic;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, AdvMenus, NxScrollControl,
  NxCustomGridControl, NxCustomGrid, NxGrid, Vcl.StdCtrls, Vcl.Buttons, ClipBrd, shellapi,
  AdvToolBtn, Vcl.ExtCtrls, JvExControls, JvLabel, NxColumns, NxColumnClasses, NxCells,
  mormot.core.base, mormot.core.variants, Vcl.ComCtrls, JvExComCtrls,
  JvStatusBar, SBPro, NxCollection, Vcl.ImgList, PngImageList, JvComponentBase,
  JvCaptionButton, UnitControlMoveResize, UnitFBLogicCLO, FormAboutDefs, EasterEgg;

type
  THiCONFBLogicF = class(TForm)
    Panel1: TPanel;
    FBInfoGrid: TNextGrid;
    JvLabel25: TJvLabel;
    InField: TNxTextColumn;
    OutField: TNxTextColumn;
    FBName: TNxTextColumn;
    InFieldIdx: TNxTextColumn;
    OutFieldIdx: TNxTextColumn;
    InTagName: TNxTextColumn;
    OutTagName: TNxTextColumn;
    TagNameEdit: TEdit;
    BitBtn1: TBitBtn;
    StatusBarPro1: TStatusBarPro;
    InputTagList: TNxMemoColumn;
    OutputTagList: TNxMemoColumn;
    InputTagList_ChId: TNxMemoColumn;
    OutputTagList_ChId: TNxMemoColumn;
    TagListPanel: TNxHeaderPanel;
    TagListGrid: TNextGrid;
    TagName: TNxTextColumn;
    TagChId: TNxTextColumn;
    PopupMenu1: TPopupMenu;
    OpenLogic1: TMenuItem;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    JvCaptionButton1: TJvCaptionButton;
    PngImageList1: TPngImageList;
    ImageList1: TImageList;
    InputTagList_Desc: TNxTextColumn;
    OutputTagList_Desc: TNxTextColumn;
    TagDesc: TNxTextColumn;
    NxIncrementColumn1: TNxIncrementColumn;
    OpenLogicToNewexe1: TMenuItem;
    N1: TMenuItem;
    ShowFieldInfo1: TMenuItem;
    OpenLogicToNewexe2: TMenuItem;
    N2: TMenuItem;
    About1: TMenuItem;
    FormAbout1: TFormAbout;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure FBInfoGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TagListPanelCollapse(Sender: TObject; var Accept: Boolean);
    procedure OutputTagListButtonClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure JvCaptionButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TagNameEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OpenLogic1Click(Sender: TObject);
    procedure TagListGridSelectCell(Sender: TObject; ACol, ARow: Integer);
    procedure FBInfoGridCellDblClick(Sender: TObject; ACol, ARow: Integer);
    procedure FBInfoGridSelectCell(Sender: TObject; ACol, ARow: Integer);
    procedure OpenLogicToNewexe1Click(Sender: TObject);
    procedure ShowFieldInfo1Click(Sender: TObject);
    procedure OpenLogicToNewexe2Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure FBInfoGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FDBFileName: string;
    FMousePoint: TPoint;
    FControlMoverResizer: TControlMoverResizer;
    FCLO4FBLogic: TCLO4FBLogic;
    FEgg: TEasternEgg;

    procedure OnEasterEgg(msg: string);

    function GetRowIdxByIndexNoFromGrid(const AIndexNo: integer; out AIsInField: Boolean): integer;
    procedure SetDBFileName2Statusbar(const ADBFileName: string);
    procedure SetDesc2Statusbar(const ADesc: string);

    function GetTagDescFromSelectedColumn(const ACol: integer): string;
    function GetTagListCountFromSelectedColumn(const ACol: integer): integer;

    procedure ShowTagList2Grid(const AColName: string);
    procedure MoveTagListPanel2CellPos(const ANxCell: TCell);
    procedure AddTagListNChId2Grid(const ATagList, ATagListChId, ATagDescList: string);
    //ATableName: MAPPING_TABLE or CONNECTION
    procedure ShowFBLogicFromForm(ATagName, ATableName, AFieldName: string; const AToNewForm: Boolean);
    procedure SetFBLogic2Grid(ATagName: string; ATagInfoJsonAry: RawUtf8; ADBFileName: string);
    function GetTagDescByTagNameFromDescList(const ATagName,
      ATagDescList: string): string;

    procedure ShowCardInfoByTagName(const ATagName: string);
    procedure ShowFBLogic2NewExe(const ATagName: string);

    //Function Name이 NX-로 시작하거나 CARD 이면 MAPPING_TABLE의 TAG_NAME으로 부터 FB IO 정보를 가져옴
    function GetIsCardModeFromFBName(const AFBName: string): Boolean;
    function GetFieldTagNameFromSelected(): string;
  public
    procedure SetDBFileName(const ADBFileName: string);
    //AFBTypeName : Function Block 종류
    //FBTagName: Function Block Tag Name
    function FBStructure2GridByName(const AFBTypeName, AFBTagName, ADBFileName: string): Boolean;
    //AFBInfoJsonAry : FUNCTION Table에서 가져옴
    procedure FBStructure2GridFromJsonAry(const AFBInfoJsonAry: RawUtf8; const AIsCardMode: Boolean);
    //ATagInfoJsonAry : MAPPING_TABLE에서 가져옴
    //ORG_TAG Field Value가 같은 Tag List 임
    procedure TagInfo2GridFromJsonAry(ATagInfoJsonAry: RawUtf8; ADBFileName: string='');
    //만약 2개이상의 Tag List가 존재하면 Srch Form에서 Double Click한 Tag Name만 반환 함
//    function GetOneTagNameFromMappingTableBySrchForm(ATagName, ADBFileName: string): string;
    procedure SetTagListCount2Grid();
    //FBInfoGrid의 각 채널의 TagName으로 MAPPING_TABLE에서 VAR_NAME을 검색하여 각 채널에 할당함
    //복수개 Tag가 할당된 채널을 찾아서 Tag List를 채워 줌
    procedure SetVarNameList2GridByTagListFromMappingTable(const ADBFileName: string);
    //FBInfoGrid의 FBName 으로 CONNECTION에서 ORG_TAG를 검색하여 각 채널에 할당함
    //복수개 Tag가 할당된 채널을 찾아서 Tag List를 채워 줌
    procedure SetVarNameList2GridByOrgTagFromConnection(const ADBFileName: string);
    //Grid에 복수개의 Description과 ChId를 채워 줌
    procedure SetVarNameList2GridFromJsonAry(const ATagColName, ADescColName, LChIdColName: string;
      const ARow: integer; const AJsonAry: RawUtf8);
  end;

function CreateHiCONFBBasicForm(AFBName: string; AFBInfoJsonAry: RawUtf8; ADBFileName: string=''): integer;
function CreateModalHiCONFBLogicForm(ATagName: string;
  ATagInfoJsonAry: RawUtf8; ADBFileName: string=''): integer;
//Showmodal 아님
function CreateNShowHiCONFBLogicForm(ATagName: string;
  ATagInfoJsonAry: RawUtf8; ADBFileName: string=''): integer;

{$IFDEF DEF_MAIN}
var
  HiCONFBLogicF : THiCONFBLogicF;
{$ENDIF}

implementation

uses UnitHiconSystemDBUtil, UnitNextGridUtil2, UnitDynamicFormManager, UnitStringUtil,
  FrmSearchModuleByTagName;

{$R *.dfm}

function CreateHiCONFBBasicForm(AFBName: string; AFBInfoJsonAry: RawUtf8; ADBFileName: string=''): integer;
var
  LHiCONFBLogicF: THiCONFBLogicF;
  LRowCount: integer;
  LIsCardMode: Boolean;
begin
  LHiCONFBLogicF := THiCONFBLogicF.Create(nil);
  try
    with LHiCONFBLogicF do
    begin
      if ADBFileName = '' then
        ADBFileName := FDBFileName
      else
        FDBFileName := ADBFileName;

      SetDBFileName2Statusbar(ADBFileName);

      if AFBName <> '' then
      begin
        if AFBInfoJsonAry = '' then
          AFBInfoJsonAry := THiConSystemDB.GetFBInfo2JsonAryByFBNameFromFUNCTIONTable(AFBName, LRowCount, ADBFileName);

        LIsCardMode := GetIsCardModeFromFBName(AFBName);
        FBStructure2GridFromJsonAry(AFBInfoJsonAry, LIsCardMode);
      end;
      ShowModal;
    end;
  finally
    FreeAndNil(LHiCONFBLogicF);
  end;
end;

function CreateModalHiCONFBLogicForm(ATagName: string;
  ATagInfoJsonAry: RawUtf8; ADBFileName: string): integer;
var
  LHiCONFBLogicF: THiCONFBLogicF;
  LFBInfoJsonAry: RawUtf8;
  LOrgTagName: RawUtf8;
  LFBName: string;
  LRowCount: integer;
begin
  LHiCONFBLogicF := THiCONFBLogicF.Create(nil);
  try
    with LHiCONFBLogicF do
    begin
      if ADBFileName = '' then
        ADBFileName := FDBFileName
      else
        FDBFileName := ADBFileName;

      SetDBFileName2Statusbar(ADBFileName);

      if ATagName <> '' then
      begin
        if ATagInfoJsonAry = '' then
        begin
          ATagInfoJsonAry := THiConSystemDB.GetVar2JsonAryByOrgTagFromMAPPINGTable(ATagName, LRowCount, ADBFileName);
        end;

        TagInfo2GridFromJsonAry(ATagInfoJsonAry, ADBFileName);
      end;

      ShowModal;
    end;
  finally
    FreeAndNil(LHiCONFBLogicF);
  end;
end;

function CreateNShowHiCONFBLogicForm(ATagName: string;
  ATagInfoJsonAry: RawUtf8; ADBFileName: string=''): integer;
var
  LHiCONFBLogicF: THiCONFBLogicF;
begin
  if not Assigned(g_GPFormManager) then
    g_GPFormManager := TGPFormManager.Create;

  LHiCONFBLogicF := g_GPFormManager.CreateNewForm(nil, THiCONFBLogicF, False) as THiCONFBLogicF;

  with LHiCONFBLogicF do
  begin
    SetFBLogic2Grid(ATagName, ATagInfoJsonAry, ADBFileName);
    Show;
  end;
end;

{ THiCONFBLogicF }

procedure THiCONFBLogicF.About1Click(Sender: TObject);
begin
  FormAbout1.Show(False);
end;

procedure THiCONFBLogicF.AddTagListNChId2Grid(const ATagList,
  ATagListChId, ATagDescList: string);
var
  LStrList, LStrList2, LDescList: TStringList;
  LStr: string;
  LRow, i: integer;
begin
  LStrList := TStringList.Create;
  LStrList2 := TStringList.Create;
  LDescList := TStringList.Create;
  try
    LStrList.Text := ATagList;
    LStrList2.Text := ATagListChId;
    LDescList.Text := ATagDescList;

    TagListGrid.BeginUpdate;
    try
      TagListGrid.ClearRows();

      for i := 0 to LStrList.Count - 1 do
      begin
        LRow := TagListGrid.AddRow();

        LStr := LStrList.Strings[i];
        LStr := StringReplace(LStr, '->', '', [rfReplaceAll]);
        TagListGrid.CellsByName['TagName', LRow] := LStr;

        TagListGrid.CellsByName['TagChId', LRow] := LStrList2.Strings[i];

        TagListGrid.CellsByName['TagDesc', LRow] := LDescList.Strings[i];

        TagListGrid.Row[LRow].RowHeight := 20;
      end;
    finally
      TagListGrid.EndUpdate;
    end;
  finally
    LStrList.Free;
    LStrList2.Free;
    LDescList.Free;
  end;
end;

procedure THiCONFBLogicF.BitBtn1Click(Sender: TObject);
begin
  ShowFBLogicFromForm('', '', '', False);
//  CreateSrchTagForm(TagNameEdit.Text, FDBFileName);
end;

procedure THiCONFBLogicF.FBStructure2GridFromJsonAry(const AFBInfoJsonAry: RawUtf8;
  const AIsCardMode: Boolean);
var
  LDocDict: IDocDict;
  LDocList: IDocList;
  LRow, LInOut, LInRow, LOutRow: integer;
  LIsUpdateFBName: boolean;
  LFieldName, LFuncName, LOrgTagName: string;
begin
  LIsUpdateFBName := False;

  LDocList := DocList(AFBInfoJsonAry);

  FBInfoGrid.BeginUpdate;
  try
    LInRow := 1;
    LOutRow := 1;

    for LDocDict in LDocList do
    begin
      if not LIsUpdateFBName then
      begin
        if FBInfoGrid.Columns.Column['FBName'].Header.Caption = 'FB Name' then
        begin
          LFuncName := Utf8ToString(LDocDict.S['FUNC_NAME']);
          FBInfoGrid.Columns.Column['FBName'].Header.Caption  := LFuncName;
          LOrgTagName := Utf8ToString(LDocDict.S['ORG_TAG']);
          LIsUpdateFBName := True;
        end;
      end;

      LFieldName := LDocDict.S['FIELD_NAME'];

      if LFieldName = '' then
        Continue;

      if AIsCardMode then
      begin
        LFieldName := GetSubStringAfter(LOrgTagName, LFieldName);
        TrimLeftChar(LFieldName, '_');
      end;
//        LFieldName := strTokenRev(LFieldName, '_')

      LInOut := LDocDict.I['IN_OUT'];

      if LInOut = 0 then //Input
      begin
        if FBInfoGrid.RowCount <= (LInRow - 1) then
          LRow := FBInfoGrid.AddRow(LInRow-(FBInfoGrid.RowCount-1));

        FBInfoGrid.CellsByName['InField', LInRow] := LFieldName;

        if AIsCardMode then
          FBInfoGrid.CellsByName['InFieldIdx', LInRow] := LFieldName
        else
          FBInfoGrid.CellsByName['InFieldIdx', LInRow] := LDocDict.S['INDEX_NO'];
        LInRow := LInRow + 2;
      end
      else
      if LInOut = 1 then //Output
      begin
        if FBInfoGrid.RowCount <= (LOutRow - 1) then
          LRow := FBInfoGrid.AddRow(LOutRow-(FBInfoGrid.RowCount-1));

        FBInfoGrid.CellsByName['OutField', LOutRow] := LFieldName;

        if AIsCardMode then
          FBInfoGrid.CellsByName['OutFieldIdx', LOutRow] := LFieldName
        else
        FBInfoGrid.CellsByName['OutFieldIdx', LOutRow] := LDocDict.S['INDEX_NO'];

        LOutRow := LOutRow + 2;
      end;
    end;//for
  finally
    FBInfoGrid.EndUpdate();
  end;
end;

procedure THiCONFBLogicF.FBInfoGridCellDblClick(Sender: TObject; ACol,
  ARow: Integer);
var
  LStr: string;
begin
  if FBInfoGrid.SelectedRow = -1 then
    exit;

  if (ACol <> 0) and (ACol <> 2) and (ACol <> 4) then
    exit;

  LStr := FBInfoGrid.Cells[ACol, ARow];

  if LStr <> '' then
  begin
    LStr := FBInfoGrid.Columns.Item[ACol].Name;

    if LStr = 'FBName' then
    begin
      LStr := FBInfoGrid.CellsByName[LStr, FBInfoGrid.SelectedRow];
      ShowCardInfoByTagName(LStr);
    end
    else
      ShowTagList2Grid(LStr);
  end;
end;

procedure THiCONFBLogicF.FBInfoGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FEgg.CheckKeydown(Key, Shift);
end;

procedure THiCONFBLogicF.FBInfoGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FMousePoint.X := X;
  FMousePoint.Y := Y;
end;

procedure THiCONFBLogicF.FBInfoGridSelectCell(Sender: TObject; ACol,
  ARow: Integer);
var
  LStr: string;
begin
  ShowFieldInfo1.Enabled := ACol in [1,3];

  if FBInfoGrid.SelectedRow = -1 then
    exit;

  if not (ACol in [0,1,2,3,4]) then
    exit;

//  if (ACol <> 0) and (ACol <> 2) and (ACol <> 4) then
//    exit;

  LStr := FBInfoGrid.Cells[ACol, ARow];

  if LStr <> '' then
  begin
    LStr := StringReplace(LStr, '->', '', [rfReplaceAll]);

    if GetTagListCountFromSelectedColumn(ACol) > 1 then
      exit;

    Clipboard.AsText := LStr;
    LStr := GetTagDescFromSelectedColumn(ACol);
    SetDesc2Statusbar(LStr);
  end;
end;

function THiCONFBLogicF.FBStructure2GridByName(const AFBTypeName,
  AFBTagName, ADBFileName: string): Boolean;
var
  LnxCustomColumn: TnxCustomColumn;
  LFBInfoJsonAry: RawUtf8;
  LRowCount: integer;
begin
  //Function Name이 NX-로 시작하거나 CARD 이거나 INF 이면(Result = TRUE)
  //MAPPING_TABLE의 TAG_NAME으로 부터 FB IO 정보를 가져옴
  //그 외는
  Result := GetIsCardModeFromFBName(AFBTypeName);

  if (Result) or (AFBTypeName = 'INF') then
  begin
    LFBInfoJsonAry := THiConSystemDB.GetFBInfo2JsonAryByFBNameFromMAPPINGTable(AFBTagName, LRowCount, ADBFileName);
  end
  else
    LFBInfoJsonAry := THiConSystemDB.GetFBInfo2JsonAryByFBNameFromFUNCTIONTable(AFBTypeName, LRowCount, ADBFileName);

  if LFBInfoJsonAry = '' then
  begin
    ShowMessage('There is no Function Block Info.');
  end
  else
  begin
    FBStructure2GridFromJsonAry(LFBInfoJsonAry, Result);

    FBInfoGrid.CellsByName['FBName', 0] := AFBTagName;
    LnxCustomColumn := FBInfoGrid.ColumnByName['FBName'];
    LnxCustomColumn.Width := GetColumnWidthByTextLength(FBInfoGrid, LnxCustomColumn, AFBTagName);
  end;
end;

procedure THiCONFBLogicF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FControlMoverResizer.Free;
end;

procedure THiCONFBLogicF.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Self = Application.MainForm then
  begin
    g_GPFormManager.CloseAllForms;

    if Assigned(FCLO4FBLogic) then
      FreeAndNil(FCLO4FBLogic);

    FEgg.Free;
  end
  else
    g_GPFormManager.DestroyForm(Handle);
end;

procedure THiCONFBLogicF.FormCreate(Sender: TObject);
begin
  if not Assigned(g_GPFormManager) then
    g_GPFormManager := TGPFormManager.Create;

  FControlMoverResizer := TControlMoverResizer.Create(TagListPanel);
end;

procedure THiCONFBLogicF.FormShow(Sender: TObject);
var
  LMsg: string;
begin
  if Application.MainForm = Self then
  begin
    FEgg := TEasternEgg.Create('Reg', [ssCtrl], 'REGINFO', Self, OnEasterEgg);
    ImageList1.GetIcon(2, Icon);

    if TCLO4FBLogic.CommandLineParse(FCLO4FBLogic, LMsg) then
    begin
      if FCLO4FBLogic.TagName <> '' then
      begin
        TagNameEdit.Text := FCLO4FBLogic.TagName;
        FDBFileName := FCLO4FBLogic.FDBName;
        BitBtn1Click(nil);
      end;
    end;
  end;
end;

//function THiCONFBLogicF.GetOneTagNameFromMappingTableBySrchForm(
//  ATagName, ADBFileName: string): string;
//var
//  LResult: RawUtf8;
//  LDocList: IDocList;
//begin
//  LResult := GetTagInfo2JsonAryFromMAPPINGTable(ATagName, 'TAG_NAME', ADBFileName);
//  LDocList := DocList(LResult);
//
//  if LDocList.Len > 1 then
//  begin
//
//  end;
//end;

function THiCONFBLogicF.GetFieldTagNameFromSelected: string;
begin
  Result := '';

  if FBInfoGrid.SelectedRow = -1 then
    exit;

//  Result := FBInfoGrid.CellsByName['FBName', 0] + '_' +
//  Result := FBInfoGrid.ColumnByName['FBName'].Header.Caption + '_' +
    Result := FBInfoGrid.Cells[FBInfoGrid.SelectedColumn, FBInfoGrid.SelectedRow];
end;

function THiCONFBLogicF.GetIsCardModeFromFBName(const AFBName: string): Boolean;
begin
  Result := (Pos('NX-', AFBName) > 0) or (AFBName = 'CARD');// or (AFBName = 'INF');
end;

function THiCONFBLogicF.GetRowIdxByIndexNoFromGrid(
  const AIndexNo: integer; out AIsInField: Boolean): integer;
var
  i: integer;
  LFieldIdx: integer;
begin
  Result := -1;

  for i := 0 to FBInfoGrid.RowCount - 1 do
  begin
    LFieldIdx := StrToIntDef(FBInfoGrid.CellsByName['InFieldIdx', i], -1);

    if LFieldIdx = AIndexNo then
    begin
      Result := i;
      AIsInField := True;
      Break;
    end;

    LFieldIdx := StrToIntDef(FBInfoGrid.CellsByName['OutFieldIdx', i], -1);

    if LFieldIdx = AIndexNo then
    begin
      Result := i;
      AIsInField := False;
      Break;
    end;
  end;
end;

function THiCONFBLogicF.GetTagDescByTagNameFromDescList(const ATagName,
  ATagDescList: string): string;
begin

end;

function THiCONFBLogicF.GetTagDescFromSelectedColumn(const ACol: integer): string;
var
  LStr: string;
begin
  case ACol of
    0: LStr := FBInfoGrid.CellsByName['InputTagList_Desc', FBInfoGrid.SelectedRow];
    4: LStr := FBInfoGrid.CellsByName['OutputTagList_Desc', FBInfoGrid.SelectedRow];
    else
      LStr := '';
  end;

  Result := LStr;
end;

function THiCONFBLogicF.GetTagListCountFromSelectedColumn(
  const ACol: integer): integer;
var
  LStr: string;
begin
  LStr := FBInfoGrid.Cells[ACol, FBInfoGrid.SelectedRow];

  Result := strTokenCount(LStr, #13);
end;

procedure THiCONFBLogicF.JvCaptionButton1Click(Sender: TObject);
begin
  JvCaptionButton1.ImageIndex := Ord(JvCaptionButton1.Down);

  if JvCaptionButton1.Down then
    FormStyle := fsStayOnTop
  else
    FormStyle := fsNormal;
end;

procedure THiCONFBLogicF.MenuItem1Click(Sender: TObject);
var
  LTagName: string;
begin
  if TagListGrid.SelectedRow = -1 then
    exit;

  LTagName := TagListGrid.CellsByName['TagName', TagListGrid.SelectedRow];
  ShowFBLogicFromForm(LTagName, '', '', True);
//  CreateNShowHiCONFBLogicForm(LTagName, '', FDBFileName);
end;

procedure THiCONFBLogicF.MoveTagListPanel2CellPos(const ANxCell: TCell);
var
  LRect: TRect;
  LPoint: TPoint;
begin
  LRect := FBInfoGrid.GetCellRect(ANxCell.ColumnIndex, ANxCell.RowIndex);

  LPoint := FBInfoGrid.ClientToScreen(LRect.TopLeft);
  LPoint := ScreenToClient(LPoint);

  TagListPanel.Top := LPoint.Y;
  TagListPanel.Left := LPoint.X;

  TagListPanel.Expanded := True;
  TagListPanel.Visible := True;
end;

procedure THiCONFBLogicF.OnEasterEgg(msg: string);
begin
  FormAbout1.LicenseText.Text := TCLO4FBLogic.FRegAppInfoB64;
  About1Click(nil);
end;

procedure THiCONFBLogicF.OpenLogic1Click(Sender: TObject);
var
  LTagName: string;
begin
  if FBInfoGrid.SelectedRow = -1 then
    exit;

  if (FBInfoGrid.Columns.Item[FBInfoGrid.SelectedColumn].Name = 'InputTagList') or
    (FBInfoGrid.Columns.Item[FBInfoGrid.SelectedColumn].Name = 'OutputTagList') then
  begin
    LTagName := FBInfoGrid.Cells[FBInfoGrid.SelectedColumn, FBInfoGrid.SelectedRow];
    LTagName := StringReplace(LTagName, '->', '', [rfReplaceAll]);
    ShowFBLogicFromForm(LTagName, '', '', True);
  end;
end;

procedure THiCONFBLogicF.OpenLogicToNewexe1Click(Sender: TObject);
var
  LTagName: string;
begin
  if FBInfoGrid.SelectedRow = -1 then
    exit;

  if (FBInfoGrid.Columns.Item[FBInfoGrid.SelectedColumn].Name = 'InputTagList') or
    (FBInfoGrid.Columns.Item[FBInfoGrid.SelectedColumn].Name = 'OutputTagList') then
  begin
    LTagName := FBInfoGrid.Cells[FBInfoGrid.SelectedColumn, FBInfoGrid.SelectedRow];
    LTagName := StringReplace(LTagName, '->', '', [rfReplaceAll]);

    ShowFBLogic2NewExe(LTagName);
  end;
end;

procedure THiCONFBLogicF.OpenLogicToNewexe2Click(Sender: TObject);
var
  LTagName: string;
begin
  if TagListGrid.SelectedRow = -1 then
    exit;

  LTagName := TagListGrid.CellsByName['TagName', TagListGrid.SelectedRow];

  ShowFBLogic2NewExe(LTagName);
end;

procedure THiCONFBLogicF.OutputTagListButtonClick(Sender: TObject);
begin
  if FBInfoGrid.SelectedRow = -1 then
    exit;

  ShowTagList2Grid('OutputTagList');
end;

procedure THiCONFBLogicF.SetDBFileName(const ADBFileName: string);
begin
  FDBFileName := ADBFileName;
end;

procedure THiCONFBLogicF.SetDBFileName2Statusbar(const ADBFileName: string);
begin
  StatusBarPro1.Panels[1].Text := ADBFileName;
end;

procedure THiCONFBLogicF.SetDesc2Statusbar(const ADesc: string);
begin
  StatusBarPro1.Panels[3].Text := ADesc;
end;

procedure THiCONFBLogicF.ShowCardInfoByTagName(const ATagName: string);
var
  LJsonAry: RawUtf8;
  LRowCount: integer;
  SrchModuleByTagF: TSrchModuleByTagF;
begin
  LJsonAry := THiConSystemDB.GetTagInfo2JsonAryFromTableName(ATagName, 'CODE', 'IOC', LRowCount, FDBFileName);

  SrchModuleByTagF := TSrchModuleByTagF.Create(nil);
  try
    with SrchModuleByTagF do
    begin
      SetDBInfo2Form(FDBFileName, 'IOC', 'CODE', ATagName);
      LoadTagInfoFromJsonAry2Grid(LJsonAry);

      if ShowModal = mrOK then
      begin
      end;
    end;//with
  finally
    FreeAndNil(SrchModuleByTagF);
  end;
end;

procedure THiCONFBLogicF.ShowFBLogic2NewExe(const ATagName: string);
var
  Params: string;
begin
  if ATagName = '' then
    exit;

  Params := '/tn=' + ATagName + ' /db="' + FDBFileName + '"';
  ShellExecute(Application.Handle, 'open', PChar(Application.ExeName),
                    PChar(Params), '', SW_SHOWNORMAL);
end;

procedure THiCONFBLogicF.ShowFBLogicFromForm(ATagName, ATableName, AFieldName: string; const AToNewForm: Boolean);
var
  LOrgTagName: string;
begin
  if ATagName = '' then
    ATagName := TagNameEdit.Text;

  RemoveSpace2String(ATagName);

  if ATagName <> '' then
  begin
    if Pos('%', ATagName) > 0 then
      LOrgTagName := CreateSrchTagForm(ATagName, FDBFileName, ATableName, AFieldName, True);

    if ATagName <> '' then
    begin
      if AToNewForm then
        CreateNShowHiCONFBLogicForm(ATagName, '', FDBFileName)
      else
        SetFBLogic2Grid(ATagName, '', FDBFileName);
    end;
  end;
end;

procedure THiCONFBLogicF.ShowFieldInfo1Click(Sender: TObject);
var
  LTagName, LFuncName, LWhere: string;
  LRowCount: integer;
  LJsonAry: RawUtf8;
begin
  LTagName := GetFieldTagNameFromSelected();
  LFuncName := FBInfoGrid.ColumnByName['FBName'].Header.Caption;
  LWhere := 'FUNC_NAME = "' + LFuncName + '" and FIELD_NAME = "' + LTagName + '"';

  LJsonAry := THiConSystemDB.GetFBInfo2JsonAryByWhereCondFromFUNCTIONTable(LFuncName, LWhere, LRowCount, FDBFileName);

  DisplayTagInfo2SrchTagFormByJsonAry(LTagName, FDBFileName, 'FUNCTION', 'TAG_NAME', LJsonAry);
end;

procedure THiCONFBLogicF.SetFBLogic2Grid(ATagName: string;
  ATagInfoJsonAry: RawUtf8; ADBFileName: string);
var
  LRowCount: integer;
begin
  if ADBFileName = '' then
    ADBFileName := FDBFileName
  else
    FDBFileName := ADBFileName;

  SetDBFileName2Statusbar(ADBFileName);

  if ATagName <> '' then
  begin
    TagNameEdit.Text := ATagName;

    if ATagInfoJsonAry = '' then
    begin
      ATagInfoJsonAry := THiConSystemDB.GetVar2JsonAryByOrgTagFromMAPPINGTable(ATagName, LRowCount, ADBFileName)
    end;

    if LRowCount = 0 then
    begin

    end
    else
    begin
      //OrgTag로 조회한 JsonAry에는 각 채널에 Var Name이 한개씩만 할당됨
      TagInfo2GridFromJsonAry(ATagInfoJsonAry, ADBFileName)
    end;
  end;
end;

procedure THiCONFBLogicF.SetTagListCount2Grid;
var
  i, LCount: integer;
  LStr: string;
begin
  for i := 0 to FBInfoGrid.RowCount - 1 do
  begin
    if FBInfoGrid.CellsByName['InputTagList',i] <> '' then
    begin
      LStr := FBInfoGrid.CellsByName['InputTagList',i];
      LCount := strTokenCount(LStr, #13);

      if LCount > 1 then
        FBInfoGrid.CellsByName['InField',i] := FBInfoGrid.CellsByName['InField',i] + ' (' + IntToStr(LCount) + ')';

      FBInfoGrid.CellsByName['InputTagList',i] := FBInfoGrid.CellsByName['InputTagList',i] + ' ->';
    end;

    if FBInfoGrid.CellsByName['OutputTagList',i] <> '' then
    begin
      LStr := FBInfoGrid.CellsByName['OutputTagList',i];
      LCount := strTokenCount(LStr, #13);

      if LCount > 1 then
        FBInfoGrid.CellsByName['OutField',i] := '(' + IntToStr(LCount) + ') ' + FBInfoGrid.CellsByName['OutField',i];

      FBInfoGrid.CellsByName['OutputTagList',i] := '->' + FBInfoGrid.CellsByName['OutputTagList',i];
    end;
  end;
end;

procedure THiCONFBLogicF.SetVarNameList2GridByOrgTagFromConnection(
  const ADBFileName: string);
var
  i, j, LRowCount: integer;
  LTagList, LTagList_Desc, LTagList_ChId, LTag_Desc, LTag_ChId,
  LIOTagList, LTagName, LInTagName, LOutTagName: string;
  LQryResult: RawUtf8;
  LDocDict: IDocDict;
  LDocList, LDocList2: IDocList;
  LCell: TCell;
begin
  LTagName := FBInfoGrid.CellsByName['FBName', 0];

  if LTagName = '' then
    exit;

  LQryResult := THiConSystemDB.GetVar2JsonAryByOrgTagFromConnectionTable(LTagName, LRowCount, ADBFileName);

  if LQryResult = '' then
    exit;

  LDocList := DocList(LQryResult);
  LDocList2 := DocList('[]');

  FBInfoGrid.BeginUpdate;
  try
    for i := 0 to FBInfoGrid.RowCount - 1 do
    begin
      LIOTagList := FBInfoGrid.CellsByName['InputTagList', i];

      //Grid의 InputTagList Column이 공란인 경우에만 InputTagList에 VAR_NAME을 저장함
      if LIOTagList = '' then
      begin
        LInTagName := FBInfoGrid.CellsByName['InTagName', i];

        if LInTagName <> '' then
        begin
          LDocList2.Clear;
          LDocList2 := LDocList.Filter('TAG_NAME=', LInTagName);
          LTagList := '';
          LTagList_Desc := '';
          LTagList_ChId := '';

          for LDocDict in LDocList2 do
          begin
            LTagName := Utf8ToString(LDocDict.S['T00']);
            LTagList := LTagList + LTagName + #13#10;

            if THiConSystemDB.GetTagDescNChIDByTagNameFromMAPPINGTable(LTagName, LTag_Desc, LTag_ChId, ADBFileName) then
            begin
              LTagList_Desc := LTagList_Desc + LTag_Desc + #13#10;
              LTagList_ChId := LTagList_ChId + LTag_ChId + #13#10;
            end;
          end;

          if LTagList <> '' then
          begin
            strTokenRev(LTagList, #13);
            FBInfoGrid.CellsByName['InputTagList', i] := LTagList;
            strTokenRev(LTagList_Desc, #13);
            FBInfoGrid.CellsByName['InputTagList_Desc', i] := LTagList_Desc;
            strTokenRev(LTagList_ChId, #13);
            FBInfoGrid.CellsByName['InputTagList_ChId', i] := LTagList_ChId;

            LCell := FBInfoGrid.CellByName['InputTagList', i];
            LCell.Color := clBlack;
            LCell.TextColor := clGreen;
          end;
        end;
      end;//if LIOTagList = ''

      LIOTagList := FBInfoGrid.CellsByName['OutputTagList', i];

      //Grid의 OutputTagList Column이 공란인 경우에만 OutputTagList에 VAR_NAME을 저장함
      if LIOTagList = '' then
      begin
        LOutTagName := FBInfoGrid.CellsByName['OutTagName', i];

        if LOutTagName <> '' then
        begin
          LDocList2.Clear;
          LDocList2 := LDocList.Filter('TAG_NAME=', LOutTagName);
          LTagList := '';
          LTagList_Desc := '';
          LTagList_ChId := '';

          for LDocDict in LDocList2 do
          begin
            LTagList := LTagList + Utf8ToString(LDocDict.S['T00']) + #13#10;

            if THiConSystemDB.GetTagDescNChIDByTagNameFromMAPPINGTable(LTagName, LTag_Desc, LTag_ChId, ADBFileName) then
            begin
              LTagList_Desc := LTagList_Desc + LTag_Desc + #13#10;
              LTagList_ChId := LTagList_ChId + LTag_ChId + #13#10;
            end;
          end;

          if LTagList <> '' then
          begin
            strTokenRev(LTagList, #13);
            FBInfoGrid.CellsByName['OutputTagList', i] := LTagList;
            strTokenRev(LTagList_Desc, #13);
            FBInfoGrid.CellsByName['OutputTagList_Desc', i] := LTagList_Desc;
            strTokenRev(LTagList_ChId, #13);
            FBInfoGrid.CellsByName['OutputTagList_ChId', i] := LTagList_ChId;

            LCell := FBInfoGrid.CellByName['OutputTagList', i];
            LCell.Color := clBlack;
            LCell.TextColor := clYellow;
          end;
        end;
      end;//if LIOTagList = ''
    end;
  finally
    FBInfoGrid.EndUpdate();
  end;
end;

procedure THiCONFBLogicF.SetVarNameList2GridByTagListFromMappingTable(const ADBFileName: string);
var
  i, LRowCount: integer;
  LTagList, LTagName: string;
  LQryResult: RawUtf8;
begin
  FBInfoGrid.BeginUpdate;
  try
    for i := 0 to FBInfoGrid.RowCount - 1 do
    begin
      LTagList := FBInfoGrid.CellsByName['InputTagList', i];

      if LTagList <> '' then
      begin
        LTagName := FBInfoGrid.CellsByName['InTagName', i];
        LQryResult := THiConSystemDB.GetVar2JsonAryByVarNameFromMAPPINGTable(LTagName, LRowCount, ADBFileName);

        if LQryResult <> '' then
          SetVarNameList2GridFromJsonAry('InputTagList', 'InputTagList_Desc', 'InputTagList_ChId', i, LQryResult);
      end;

      LTagList := FBInfoGrid.CellsByName['OutputTagList', i];

      if LTagList <> '' then
      begin
        LTagName := FBInfoGrid.CellsByName['OutTagName', i];
        LQryResult := THiConSystemDB.GetVar2JsonAryByVarNameFromMAPPINGTable(LTagName, LRowCount, ADBFileName);

        if LQryResult <> '' then
          SetVarNameList2GridFromJsonAry('OutputTagList', 'OutputTagList_Desc', 'OutputTagList_ChId', i, LQryResult);
      end;
    end;
  finally
    FBInfoGrid.EndUpdate();
  end;
end;

procedure THiCONFBLogicF.SetVarNameList2GridFromJsonAry(const ATagColName, ADescColName, LChIdColName: string;
  const ARow: integer; const AJsonAry: RawUtf8);
var
  LDocDict: IDocDict;
  LDocList: IDocList;
  LTagName, LDesc, LChId, LTagList, LDescList, LChIdList: string;
  LIsDataChanged: Boolean;
begin
  //MAPPING_TABLE에서 FB의 Channel에 할당된 Tag_Name으로 조회하여 가져온 정보
  LDocList := DocList(AJsonAry);

  LIsDataChanged := False;
  LTagList := FBInfoGrid.CellsByName[ATagColName, ARow];
  LDescList := FBInfoGrid.CellsByName[ADescColName, ARow];
  LChIdList := FBInfoGrid.CellsByName[LChIdColName, ARow];

  for LDocDict in LDocList do
  begin
    LTagName := Utf8ToString(LDocDict.S['TAG_NAME']);
    LDesc := Utf8ToString(LDocDict.S['DESCRIPTION']);
    LChId := Utf8ToString(LDocDict.S['CH_ID']);

    if Pos(LTagName, LTagList) <= 0 then
    begin
      if LTagList <> '' then
      begin
        LTagList := LTagList + #13#10;
        LDescList := LDescList + #13#10;
        LChIdList := LChIdList + #13#10;
      end;

      LTagList := LTagList + LTagName;
      LDescList := LDescList + LDesc;
      LChIdList := LChIdList + LChId;

      LIsDataChanged := True;
    end;
  end;//for

  if LIsDataChanged then
  begin
    FBInfoGrid.CellsByName[ATagColName, ARow] := LTagList;
    FBInfoGrid.CellsByName[ADescColName, ARow] := LDescList;
    FBInfoGrid.CellsByName[LChIdColName, ARow] := LChIdList;
  end;
end;

procedure THiCONFBLogicF.ShowTagList2Grid(const AColName: string);
var
  LCell: TCell;
  LTagList, LTagList_ChId, LDescList: string;
begin
  LTagList := FBInfoGrid.CellsByName[AColName, FBInfoGrid.SelectedRow];
  LTagList_ChId := FBInfoGrid.CellsByName[AColName+'_ChId', FBInfoGrid.SelectedRow];
  LDescList := FBInfoGrid.CellsByName[AColName+'_Desc', FBInfoGrid.SelectedRow];
  AddTagListNChId2Grid(LTagList, LTagList_ChId, LDescList);

  LCell := FBInfoGrid.CellByName[AColName, FBInfoGrid.SelectedRow];
  MoveTagListPanel2CellPos(LCell);
end;

procedure THiCONFBLogicF.TagInfo2GridFromJsonAry(ATagInfoJsonAry: RawUtf8; ADBFileName: string);
var
  LDocDict: IDocDict;
  LDocList: IDocList;
  LFBName, LVarName, LTagList_Desc, LFieldName, //LFBName2,
  LOrgTagName, LTagList, LChId, LDesc: string;
  LFieldIdx, LRowIdx, LInOut: integer;
  LIsUpdateFBName, LIsInField: boolean; //
  LCell: TCell;
  LIsCardMode: Boolean; //실제 HiCONIS IO Module은 Field Name을 달리 표현함
begin
  if ADBFileName = '' then
    ADBFileName := FDBFileName;

  LDocList := DocList(ATagInfoJsonAry); //MAPPING_TABLE에서 가져온 정보

  LIsUpdateFBName := False;

  FBInfoGrid.BeginUpdate;
  try
    FBInfoGrid.ClearRows;

    for LDocDict in LDocList do
    begin
      LDesc := Utf8ToString(LDocDict.S['DESCRIPTION']);
      LFBName:= Utf8ToString(LDocDict.S['FUNC_NAME']);

      if LFBName = 'INF' then
      begin

      end
      else
      begin
        if not LIsUpdateFBName then
  //      if LFBName <> LFBName2 then
        begin
  //        LFBName2 := LFBName;
          Caption := LDesc;
          Update;
          LOrgTagName := Utf8ToString(LDocDict.S['ORG_TAG']);

          LIsCardMode := FBStructure2GridByName(LFBName, LOrgTagName, ADBFileName);
          LIsUpdateFBName := True;
        end;
      end;

      //한개의 Channel에 복수 개의 VarName이 설정되었는지 검사
      //Card Mode에서는 한개의 Channel에 복수 개 VarName 할당이 불가하므로 Index_No를 사용하면 안됨
      if LIsCardMode then
      begin
        LFieldName := LDocDict.S['TAG_NAME'];
        LFieldName := strTokenRev(LFieldName, '_');
        LFieldIdx := StrToIntDef(LFieldName,0);
      end
      else
      begin
        LFieldIdx := LDocDict.I['INDEX_NO'];
      end;

      LRowIdx := GetRowIdxByIndexNoFromGrid(LFieldIdx, LIsInField);

      if LRowIdx <> -1 then
      begin
        FBInfoGrid.Row[LRowIdx].RowHeight := 20;
        LInOut := LDocDict.I['IN_OUT'];
        LVarName := LDocDict.S['VAR_NAME'];

        if LInOut = 0 then //Input 인 경우
        begin
          FBInfoGrid.CellsByName['InTagName', LRowIdx] := LOrgTagName + '_' + FBInfoGrid.CellsByName['InField', LRowIdx];
          LCell := FBInfoGrid.CellByName['InField', LRowIdx];
          LCell.Color := clBlack;
          LCell.TextColor := clLime;

          //할당된 변수가 있는 경우
          if LVarName <> '' then
          begin
            LCell := FBInfoGrid.CellByName['InputTagList', LRowIdx];
            LCell.Color := clBlack;
            LTagList := FBInfoGrid.CellsByName['InputTagList', LRowIdx];
            LChId := FBInfoGrid.CellsByName['InputTagList_ChId', LRowIdx];
            LTagList_Desc := FBInfoGrid.CellsByName['InputTagList_Desc', LRowIdx];

            if LTagList <> '' then
            begin
              LTagList := LTagList + #13#10;
              LChId := LChId + #13#10;
              LTagList_Desc := LTagList_Desc + #13#10;
            end;

            LTagList := LTagList + LVarName;
            FBInfoGrid.CellsByName['InputTagList', LRowIdx] := LTagList;// + '->';

            LChId := LChId + IntToStr(LDocDict.I['CH_ID']);
            FBInfoGrid.CellsByName['InputTagList_ChId', LRowIdx] := LChId;

            FBInfoGrid.CellsByName['InputTagList_Desc', LRowIdx] := LTagList_Desc + LDesc;
          end;
        end
        else  //Output 인 경우
        begin
          FBInfoGrid.CellsByName['OutTagName', LRowIdx] := LOrgTagName + '_' + FBInfoGrid.CellsByName['OutField', LRowIdx];

          LCell := FBInfoGrid.CellByName['OutField', LRowIdx];
          LCell.Color := clBlack;
          LCell.TextColor := clYellow;

          //할당된 변수가 있는 경우
          if LVarName <> '' then
          begin
            LCell := FBInfoGrid.CellByName['OutputTagList', LRowIdx];
            LCell.Color := clBlack;

            LTagList := FBInfoGrid.CellsByName['OutputTagList', LRowIdx];
            LChId := FBInfoGrid.CellsByName['OutputTagList_ChId', LRowIdx];
            LTagList_Desc := FBInfoGrid.CellsByName['OutputTagList_Desc', LRowIdx];

            if LTagList <> '' then
            begin
              LTagList := LTagList + #13#10;
              LChId := LChId + #13#10;
              LTagList_Desc := LTagList_Desc + #13#10;
            end;

            LTagList := LTagList + LVarName;
            FBInfoGrid.CellsByName['OutputTagList', LRowIdx] := LTagList; // '->' +

            LChId := LChId + IntToStr(LDocDict.I['CH_ID']);
            FBInfoGrid.CellsByName['OutputTagList_ChId', LRowIdx] := LChId;

            FBInfoGrid.CellsByName['OutputTagList_Desc', LRowIdx] := LTagList_Desc + LDesc;
          end;
        end;
      end;
    end;//for

    //각 채널에 복수개가 할당된 채널은 VAR_NAME(InputTagList/OutputTagList)으로 다시 조회하여 Grid에 표시함
//    SetVarNameList2GridByTagListFromMappingTable(ADBFileName);
    //각 채널에 복수개가 할당된 채널은 CONNECTION의 TAG_NAME(InputTagList/OutputTagList)으로 다시 조회하여 Grid에 표시함
    //MAPPING_TABLE에는 자동으로 할당되는 VAR_NAME이 없고 CONNECTION에는 존재함
    SetVarNameList2GridByOrgTagFromConnection(ADBFileName);
    SetTagListCount2Grid();
  finally
    FBInfoGrid.EndUpdate();
  end;
end;

procedure THiCONFBLogicF.TagListGridSelectCell(Sender: TObject; ACol,
  ARow: Integer);
var
  LStr: string;
begin
  LStr := TagListGrid.Cells[ACol, ARow];

  if LStr <> '' then
  begin
    Clipboard.AsText := LStr;
  end;

  SetDesc2Statusbar(TagListGrid.CellsByName['TagDesc', ARow]);
end;

procedure THiCONFBLogicF.TagListPanelCollapse(Sender: TObject;
  var Accept: Boolean);
begin
  TagListPanel.Visible := False;
end;

procedure THiCONFBLogicF.TagNameEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    ShowFBLogicFromForm('', '', '', False);
  end;
end;

end.
