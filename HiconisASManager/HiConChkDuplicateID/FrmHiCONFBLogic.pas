unit FrmHiCONFBLogic;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, AdvMenus, NxScrollControl,
  NxCustomGridControl, NxCustomGrid, NxGrid, Vcl.StdCtrls, Vcl.Buttons, ClipBrd,
  AdvToolBtn, Vcl.ExtCtrls, JvExControls, JvLabel, NxColumns, NxColumnClasses, NxCells,
  mormot.core.base, mormot.core.variants, Vcl.ComCtrls, JvExComCtrls,
  JvStatusBar, SBPro, NxCollection, Vcl.ImgList, PngImageList, JvComponentBase,
  JvCaptionButton, UnitControlMoveResize;

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

    procedure FormCreate(Sender: TObject);
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
    procedure FormShow(Sender: TObject);
    procedure TagListGridSelectCell(Sender: TObject; ACol, ARow: Integer);
    procedure FBInfoGridCellDblClick(Sender: TObject; ACol, ARow: Integer);
    procedure FBInfoGridSelectCell(Sender: TObject; ACol, ARow: Integer);
  private
    FDBFileName: string;
    FMousePoint: TPoint;
    FControlMoverResizer: TControlMoverResizer;

    function GetRowIdxByIndexNoFromGrid(const AIndexNo: integer; out AIsInField: Boolean): integer;
    procedure SetDBFileName2Statusbar(const ADBFileName: string);
    procedure SetDesc2Statusbar(const ADesc: string);

    function GetTagDescFromSelectedColumn(const ACol: integer): string;
    function GetTagListCountFromSelectedColumn(const ACol: integer): integer;

    procedure ShowTagList2Grid(const AColName: string);
    procedure MoveTagListPanel2CellPos(const ANxCell: TCell);
    procedure AddTagListNChId2Grid(const ATagList, ATagListChId, ATagDescList: string);
    procedure ShowFBLogicFromForm(ATagName: string; const AToNewForm: Boolean);
    procedure SetFGLogic2Grid(ATagName: string; ATagInfoJsonAry: RawUtf8; ADBFileName: string);
    function GetTagDescByTagNameFromDescList(const ATagName,
      ATagDescList: string): string;

    //Function Name이 NX-로 시작하거나 CARD 이면 MAPPING_TABLE의 TAG_NAME으로 부터 FB IO 정보를 가져옴
    function GetIsCardModeFromFBName(const AFBName: string): Boolean;
  public
    procedure SetDBFileName(const ADBFileName: string);
    //AFBInfoJsonAry : FUNCTION Table에서 가져옴
    procedure FBInfo2GridFromJsonAry(const AFBInfoJsonAry: RawUtf8; const AIsCardMode: Boolean);
    //ATagInfoJsonAry : MAPPING_TABLE에서 가져옴
    //ORG_TAG Field Value가 같은 Tag List 임
    procedure TagInfo2GridFromJsonAry(ATagInfoJsonAry: RawUtf8; ADBFileName: string='');
    //만약 2개이상의 Tag List가 존재하면 Srch Form에서 Double Click한 Tag Name만 반환 함
//    function GetOneTagNameFromMappingTableBySrchForm(ATagName, ADBFileName: string): string;
    procedure SetTagListCount2Grid();
    //FBInfoGrid의 각 채널의 TagName으로 VAR_NAME을 검색하여 각 채널에 할당함
    //복수개 Tag가 할당된 채널을 찾아서 Tag List를 채워 줌
    procedure SetVarNameList2GridByVarNameFromTagList(const ADBFileName: string);
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
        FBInfo2GridFromJsonAry(AFBInfoJsonAry, LIsCardMode);
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
    SetFGLogic2Grid(ATagName, ATagInfoJsonAry, ADBFileName);
    Show;
  end;
end;

{ THiCONFBLogicF }

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
  ShowFBLogicFromForm('', False);
//  CreateSrchTagForm(TagNameEdit.Text, FDBFileName);
end;

procedure THiCONFBLogicF.FBInfo2GridFromJsonAry(const AFBInfoJsonAry: RawUtf8;
  const AIsCardMode: Boolean);
var
  LDocDict: IDocDict;
  LDocList: IDocList;
  LRow, LInOut, LInRow, LOutRow: integer;
  LIsUpdateFBName: boolean;
  LFieldName: string;
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
          FBInfoGrid.Columns.Column['FBName'].Header.Caption := Utf8ToString(LDocDict.S['FUNC_NAME']);

          LIsUpdateFBName := True;
        end;
      end;

      LFieldName := LDocDict.S['FIELD_NAME'];

      if AIsCardMode then
        LFieldName := strTokenRev(LFieldName, '_');

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

  if (ACol <> 0) and (ACol <> 4)then
    exit;

  LStr := FBInfoGrid.Cells[ACol, ARow];

  if LStr <> '' then
  begin
    LStr := FBInfoGrid.Columns.Item[ACol].Name;
    ShowTagList2Grid(LStr);
//    ShowTagList2Grid('InputTagList');
  end;
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
  if FBInfoGrid.SelectedRow = -1 then
    exit;

  if (ACol <> 0) and (ACol <> 2) and (ACol <> 4) then
    exit;

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

procedure THiCONFBLogicF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FControlMoverResizer.Free;
end;

procedure THiCONFBLogicF.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Self = Application.MainForm then
    g_GPFormManager.CloseAllForms
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
begin
  if Application.MainForm = Self then
  begin
    ImageList1.GetIcon(2, Icon);
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

function THiCONFBLogicF.GetIsCardModeFromFBName(const AFBName: string): Boolean;
begin
  Result := (Pos('NX-', AFBName) > 0) or (AFBName = 'CARD');
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
  CreateNShowHiCONFBLogicForm(LTagName, '', FDBFileName);
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
    ShowFBLogicFromForm(LTagName, True);
  end;
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

procedure THiCONFBLogicF.ShowFBLogicFromForm(ATagName: string; const AToNewForm: Boolean);
var
  LOrgTagName: string;
begin
  if ATagName = '' then
    ATagName := TagNameEdit.Text;

  if ATagName <> '' then
  begin
    LOrgTagName := CreateSrchTagForm(ATagName, FDBFileName, True);

    if ATagName <> '' then
    begin
      if AToNewForm then
        CreateNShowHiCONFBLogicForm(ATagName, '', FDBFileName)
      else
        SetFGLogic2Grid(ATagName, '', FDBFileName);
    end;
  end;
end;

procedure THiCONFBLogicF.SetFGLogic2Grid(ATagName: string;
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
      ATagInfoJsonAry := THiConSystemDB.GetVar2JsonAryByOrgTagFromMAPPINGTable(ATagName, LRowCount, ADBFileName);

    if LRowCount = 0 then
    begin
    
    end
    else
      //OrgTag로 조회한 JsonAry에는 각 채널에 Var Name이 한개씩만 할당됨
      TagInfo2GridFromJsonAry(ATagInfoJsonAry, ADBFileName);
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

procedure THiCONFBLogicF.SetVarNameList2GridByVarNameFromTagList(const ADBFileName: string);
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
  LFBInfoJsonAry: RawUtf8;
  LFBName, LVarName, LTagList_Desc, LFieldName,
  LOrgTagName, LTagList, LChId, LDesc: string;
  LFieldIdx, LRowIdx, LInOut, LRowCount: integer;
  LIsUpdateFBName, LIsInField: boolean;
  LCell: TCell;
  LnxCustomColumn: TnxCustomColumn;
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

      if not LIsUpdateFBName then
      begin
        Caption := LDesc;
        Update;
        LFBName:= Utf8ToString(LDocDict.S['FUNC_NAME']);
        LOrgTagName := Utf8ToString(LDocDict.S['ORG_TAG']);

        //Function Name이 NX-로 시작하거나 CARD 이면 MAPPING_TABLE의 TAG_NAME으로 부터 FB IO 정보를 가져옴
        LIsCardMode := GetIsCardModeFromFBName(LFBName);

        if LIsCardMode then
        begin
          LFBInfoJsonAry := THiConSystemDB.GetFBInfo2JsonAryByFBNameFromMAPPINGTable(LOrgTagName, LRowCount, ADBFileName);
        end
        else
          LFBInfoJsonAry := THiConSystemDB.GetFBInfo2JsonAryByFBNameFromFUNCTIONTable(LFBName, LRowCount, ADBFileName);

        FBInfo2GridFromJsonAry(LFBInfoJsonAry, LIsCardMode);

        FBInfoGrid.CellsByName['FBName', 0] := LOrgTagName;
        LnxCustomColumn := FBInfoGrid.ColumnByName['FBName'];
        LnxCustomColumn.Width := GetColumnWidthByTextLength(FBInfoGrid, LnxCustomColumn, LOrgTagName);
        LIsUpdateFBName := True;
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
            FBInfoGrid.CellsByName['InTagName', LRowIdx] := LOrgTagName + '_' + FBInfoGrid.CellsByName['InField', LRowIdx];
          end;
        end
        else  //Output 인 경우
        begin
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
            FBInfoGrid.CellsByName['OutTagName', LRowIdx] := LOrgTagName + '_' + FBInfoGrid.CellsByName['OutField', LRowIdx];
          end;
        end;
      end;
    end;//for

    //각 채널에 복수개가 할당된 채널은 VAR_NAME(InputTagList/OutputTagList)으로 다시 조회하여 Grid에 표시함
    SetVarNameList2GridByVarNameFromTagList(ADBFileName);
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
    ShowFBLogicFromForm('', False);
  end;
end;

end.
