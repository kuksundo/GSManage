unit FrmSCRReportMain;
{ *) 프로그램 사용 방법
1. 엑셀 파일(B&R Recipe.xlsx)을 아래와 같이 편집하여 저장한다
   - 구분자 셀(D Column)을 공란으로 채운다: option, common, HP Parameter 등
   - J Column에 값을 입력하여 Data Type을 인식할 수 있도록 한다(TRUE or 숫자)
2. 엑셀 파일 내용을 Grid로 읽어 들인다
   - Tools -> Load Base Info Xls 2 Grid 실행
3. Grid의 내용을 Json Text로 저장하여 향후 프로그램 시작 시 Recipe Info를 Load
   - Save Grid 2 Json File(popup menu) 실행
   - 저장한 SCR_Recipe_Json.txt 및 SCR_Recipe_JsonSCRRecipeDivisionList.txt 파일을 프로그램 home 폴더에 복사
   - SCR_Recipe_JsonSCRRecipeDivisionList.txt 파일은 Recipe 파일 load시에 구분자를 skip하기 위함
4. Grid의 내용을 참조하여 SCRParamClass record field code를 생성한다
   - Generate Obj Code From Grid(popup menu) 실행
   - c:\temp\에 여러개 txt 파일이 생성됨
   - txt 파일을 프로그램 home 폴더에 복사
5. Compile
}
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, NxColumns, NxColumnClasses,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid, DragDrop,
  DropSource, DragDropText, Vcl.StdCtrls, mormot.core.data, mormot.core.text,
  mormot.core.unicode, mormot.core.base,
  UDragDropFormat_SCRParam, USCRParamClass;

type
  TSCRReportF = class(TForm)
    MainMenu1: TMainMenu;
    ools1: TMenuItem;
    LoadBaseInfoXls2Grid1: TMenuItem;
    PopupMenu1: TPopupMenu;
    GenerateObjectCodeFromGrid1: TMenuItem;
    Save2DB1: TMenuItem;
    NextGrid1: TNextGrid;
    TagId: TNxIncrementColumn;
    GenerateDFM4updatetag1: TMenuItem;
    AssigntagfromObject1: TMenuItem;
    TagName: TNxTextColumn;
    Button1: TButton;
    SCRParamSource1: TDropTextSource;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    TagDesc: TNxTextColumn;
    ParamKind: TNxTextColumn;
    SCRTYpe: TNxTextColumn;
    SCRComponent: TNxTextColumn;
    ValueBitNo: TNxTextColumn;
    ParamValue: TNxTextColumn;
    Save2JsonFile1: TMenuItem;
    LoadFromJsonFile2Grid1: TMenuItem;
    LoadFromJsonFile2Aryt1: TMenuItem;
    N1: TMenuItem;
    LaodFromObj2Grid1: TMenuItem;
    ValueType: TNxTextColumn;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NextGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure NextGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure LoadBaseInfoXls2Grid1Click(Sender: TObject);
    procedure Save2JsonFile1Click(Sender: TObject);
    procedure LoadFromJsonFile2Grid1Click(Sender: TObject);
    procedure LoadFromJsonFile2Aryt1Click(Sender: TObject);
    procedure LaodFromObj2Grid1Click(Sender: TObject);
    procedure GenerateObjectCodeFromGrid1Click(Sender: TObject);
  private
    FDragSource: TSCRParamDataFormat;
    FMousePoint: TPoint;
    FSCRRecipeObjAry: TSCRRecipeInfoObjArray;
    FSCRRecipeDynAry: TDynArray;
    FSCRRecipeDivisionList: TStringList;

    procedure _LoadBaseInfoFromXls2Grid(AXlsFileName: string);
    procedure AddRecipeFromAry2Grid();
    procedure Save2JsonFile();
    procedure LoadFromJsonFile2Grid();
    procedure LoadFromJsonFile2ObjAry(out AObjAry: TSCRRecipeInfoObjArray);
  public
    procedure InitVar;
    procedure DestroyVar;

    procedure LoadBaseInfoFromXls2Grid;
    procedure GenerateObjectCodeFromGrid;
    procedure AssignComponentTagFromObject(AObject: TObject);
    procedure GenerateDFM4UpdatedComponentTag;
  end;

var
  SCRReportF: TSCRReportF;

implementation

uses UnitExcelUtil, UnitDialogUtil, UnitDFMUtil, UnitNextGridUtil2, UnitStringUtil,
  FrmSCRSetting, FrmSCRAppSetting, FrmSCRGESetting, FrmSCRMESetting;

{$R *.dfm}

{ TSCRReportF }

procedure TSCRReportF.AddRecipeFromAry2Grid;
var
  i, LRow: integer;
  LSCRRecipeInfo: TSCRRecipeInfo;
begin
  With NextGrid1, LSCRRecipeInfo do
  begin
    for i := 0 to FSCRRecipeDynAry.Count - 1 do
    begin
      LSCRRecipeInfo := FSCRRecipeObjAry[i];

      LRow := AddRow();
      FTagID := StrToInt(CellByName['TagId', LRow].AsString);
      CellByName['TagName', LRow].AsString := FTagName;
      CellByName['TagDesc', LRow].AsString := FTagDesc;
      CellByName['SCRTYpe', LRow].AsString := FSCRTYpe;
      CellByName['ParamKind', LRow].AsString := FParamKind;
      CellByName['SCRComponent', LRow].AsString := FSCRComponent;
      CellByName['ValueBitNo', LRow].AsInteger := FValueBitNo;
      CellByName['ParamValue', LRow].AsString := FParamValue;
      CellByName['ValueType', LRow].AsString := FValueType;
    end;
  end;//with
end;

procedure TSCRReportF.AssignComponentTagFromObject(AObject: TObject);
begin

end;

procedure TSCRReportF.Button1Click(Sender: TObject);
var
  LRow: integer;
begin
  LRow := NextGrid1.AddRow();
  NextGrid1.Cells[1,LRow] := 'aaa-' + IntToStr(LRow);
end;

procedure TSCRReportF.Button2Click(Sender: TObject);
begin
  CreateNShowSCRAppSetting2(Self as TComponent);
end;

procedure TSCRReportF.Button3Click(Sender: TObject);
begin
  if Assigned(SCRAppSettingF) then
    FreeAndNil(SCRAppSettingF);
end;

procedure TSCRReportF.Button4Click(Sender: TObject);
begin
  CreateNShowSCRGESetting2(Self as TComponent);
end;

procedure TSCRReportF.Button5Click(Sender: TObject);
begin
  CreateNShowSCRMESetting2(Self as TComponent);
end;

procedure TSCRReportF.Button6Click(Sender: TObject);
begin
  if Assigned(SCRGESettingF) then
    FreeAndNil(SCRGESettingF);
end;

procedure TSCRReportF.Button7Click(Sender: TObject);
begin
  if Assigned(SCRMESettingF) then
    FreeAndNil(SCRMESettingF);
end;

procedure TSCRReportF.DestroyVar;
begin
  FSCRRecipeDivisionList.Free;
  FSCRRecipeDynAry.Clear;

  FDragSource.Free;
end;

procedure TSCRReportF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DestroyVar;
end;

procedure TSCRReportF.FormCreate(Sender: TObject);
begin
  InitVar;
end;

procedure TSCRReportF.GenerateDFM4UpdatedComponentTag;
begin

end;

procedure TSCRReportF.GenerateObjectCodeFromGrid;
var
  i, LIdx: integer;
  LBoolStr, LDefaultValue, LStr, LStr2, LStr3, LTagName, LParamValue, LSCRType, LParamKind: string;
  LPropList_App, LFieldList_App: TStringList;
  LPropList_ME_HP, LFieldList_ME_HP: TStringList;
  LPropList_ME_LP, LFieldList_ME_LP: TStringList;
  LPropList_AE1, LFieldList_AE1: TStringList;
  LPropList_AE2, LFieldList_AE2: TStringList;
  LPropList_AE3, LFieldList_AE3: TStringList;
  LPropList_AE4, LFieldList_AE4: TStringList;
  LPropList_AE5, LFieldList_AE5: TStringList;
  LPropList_AE6, LFieldList_AE6: TStringList;
  LPropList_AE7, LFieldList_AE7: TStringList;
  LPropList_AE8, LFieldList_AE8: TStringList;
begin
  LPropList_App := TStringList.Create;
  LFieldList_App := TStringList.Create;
  LPropList_ME_HP := TStringList.Create;
  LFieldList_ME_HP := TStringList.Create;
  LPropList_ME_LP := TStringList.Create;
  LFieldList_ME_LP := TStringList.Create;
  LPropList_AE1 := TStringList.Create;
  LFieldList_AE1 := TStringList.Create;
  LPropList_AE2 := TStringList.Create;
  LFieldList_AE2 := TStringList.Create;
  LPropList_AE3 := TStringList.Create;
  LFieldList_AE3 := TStringList.Create;
  LPropList_AE4 := TStringList.Create;
  LFieldList_AE4 := TStringList.Create;
  LPropList_AE5 := TStringList.Create;
  LFieldList_AE5 := TStringList.Create;
  LPropList_AE6 := TStringList.Create;
  LFieldList_AE6 := TStringList.Create;
  LPropList_AE7 := TStringList.Create;
  LFieldList_AE7 := TStringList.Create;
  LPropList_AE8 := TStringList.Create;
  LFieldList_AE8 := TStringList.Create;
  try
    for i := 0 to NextGrid1.RowCount - 1 do
    begin
      LTagName := NextGrid1.CellByName['TagName', i].AsString;

      if LTagName = '' then
        Continue;

      LParamValue := NextGrid1.CellByName['ParamValue', i].AsString;

      LBoolStr := GetValuTypeFromParamValue(LParamValue);

      if LBoolStr = 'BOOL' then
      begin
        LDefaultValue := 'False';
      end
      else
      if LBoolStr = 'DOUBLE' then
      begin
        LDefaultValue := '0.0';
      end
      else
      begin
//        LBoolStr := 'Integer';
        LDefaultValue := '0';
      end;

//      LBoolStr := 'string';//모두 string형으로 통일함(RTTI로 SetValue시 Error를 방지하기 위함)

      LStr := 'F' + LTagName + ': ' + LBoolStr + ';';
      LStr2 := '[IniValue(' +
        '''' + LTagName + ''', ' +
        '''' + NextGrid1.CellByName['TagDesc', i].AsString + ''', ' +
        '''' + LDefaultValue + ''', ' +
        NextGrid1.CellByName['TagId', i].AsString + ')]';
      LStr3 := 'property ' + LTagName + ' : ' + LBoolStr +
        ' read F' + LTagName + ' write F' + LTagName + ';';

      LSCRType := NextGrid1.CellByName['SCRType', i].AsString;
      LParamKind := NextGrid1.CellByName['ParamKind', i].AsString;

      if (UpperCase(LParamKind) = 'APPLICATION SETTING') then//App Setting
      begin
        LFieldList_App.Add(LStr);
        LPropList_App.Add(LStr2);
        LPropList_App.Add(LStr3);
      end
      else
      if (UpperCase(LSCRType) = '2S HPSCR') then//ME Setting
      begin
        LFieldList_ME_HP.Add(LStr);
        LPropList_ME_HP.Add(LStr2);
        LPropList_ME_HP.Add(LStr3);
      end
      else
      if (UpperCase(LSCRType) = '2S LPSCR') then//Etc Setting
      begin
        LFieldList_ME_LP.Add(LStr);
        LPropList_ME_LP.Add(LStr2);
        LPropList_ME_LP.Add(LStr3);
      end
      else
      if (UpperCase(LSCRType) = '4S LPSCR') then //GE Setting
      begin
        if UpperCase(LParamKind) = 'GE NO1' then
        begin
          LFieldList_AE1.Add(LStr);
          LPropList_AE1.Add(LStr2);
          LPropList_AE1.Add(LStr3);
        end
        else
        if UpperCase(LParamKind) = 'GE NO2' then
        begin
          LFieldList_AE2.Add(LStr);
          LPropList_AE2.Add(LStr2);
          LPropList_AE2.Add(LStr3);
        end
        else
        if UpperCase(LParamKind) = 'GE NO3' then
        begin
          LFieldList_AE3.Add(LStr);
          LPropList_AE3.Add(LStr2);
          LPropList_AE3.Add(LStr3);
        end
        else
        if UpperCase(LParamKind) = 'GE NO4' then
        begin
          LFieldList_AE4.Add(LStr);
          LPropList_AE4.Add(LStr2);
          LPropList_AE4.Add(LStr3);
        end
        else
        if UpperCase(LParamKind) = 'GE NO5' then
        begin
          LFieldList_AE5.Add(LStr);
          LPropList_AE5.Add(LStr2);
          LPropList_AE5.Add(LStr3);
        end
        else
        if UpperCase(LParamKind) = 'GE NO6' then
        begin
          LFieldList_AE6.Add(LStr);
          LPropList_AE6.Add(LStr2);
          LPropList_AE6.Add(LStr3);
        end
        else
        if UpperCase(LParamKind) = 'GE NO7' then
        begin
          LFieldList_AE7.Add(LStr);
          LPropList_AE7.Add(LStr2);
          LPropList_AE7.Add(LStr3);
        end
        else
        if UpperCase(LParamKind) = 'GE NO8' then
        begin
          LFieldList_AE8.Add(LStr);
          LPropList_AE8.Add(LStr2);
          LPropList_AE8.Add(LStr3);
        end
      end
    end;

    LFieldList_App.SaveToFile('c:\temp\SCRParamFieldList-App.txt');
    LPropList_App.SaveToFile('c:\temp\SCRParamPropertyList-App.txt');
    LFieldList_ME_HP.SaveToFile('c:\temp\SCRParamFieldList-ME-HP.txt');
    LPropList_ME_HP.SaveToFile('c:\temp\SCRParamPropertyList-ME-HP.txt');
    LFieldList_ME_LP.SaveToFile('c:\temp\SCRParamFieldList-ME-LP.txt');
    LPropList_ME_LP.SaveToFile('c:\temp\SCRParamPropertyList-ME-LP.txt');

    LFieldList_AE1.SaveToFile('c:\temp\SCRParamFieldList-AE1.txt');
    LPropList_AE1.SaveToFile('c:\temp\SCRParamPropertyList-AE1.txt');
    LFieldList_AE2.SaveToFile('c:\temp\SCRParamFieldList-AE2.txt');
    LPropList_AE2.SaveToFile('c:\temp\SCRParamPropertyList-AE2.txt');
    LFieldList_AE3.SaveToFile('c:\temp\SCRParamFieldList-AE3.txt');
    LPropList_AE3.SaveToFile('c:\temp\SCRParamPropertyList-AE3.txt');
    LFieldList_AE4.SaveToFile('c:\temp\SCRParamFieldList-AE4.txt');
    LPropList_AE4.SaveToFile('c:\temp\SCRParamPropertyList-AE4.txt');
    LFieldList_AE5.SaveToFile('c:\temp\SCRParamFieldList-AE5.txt');
    LPropList_AE5.SaveToFile('c:\temp\SCRParamPropertyList-AE5.txt');
    LFieldList_AE6.SaveToFile('c:\temp\SCRParamFieldList-AE6.txt');
    LPropList_AE6.SaveToFile('c:\temp\SCRParamPropertyList-AE6.txt');
    LFieldList_AE7.SaveToFile('c:\temp\SCRParamFieldList-AE7.txt');
    LPropList_AE7.SaveToFile('c:\temp\SCRParamPropertyList-AE7.txt');
    LFieldList_AE8.SaveToFile('c:\temp\SCRParamFieldList-AE8.txt');
    LPropList_AE8.SaveToFile('c:\temp\SCRParamPropertyList-AE8.txt');
  finally
    LPropList_App.Free;
    LFieldList_App.Free;
    LPropList_ME_HP.Free;
    LFieldList_ME_HP.Free;
    LPropList_ME_LP.Free;
    LFieldList_ME_LP.Free;
    LPropList_AE1.Free;
    LFieldList_AE1.Free;
    LPropList_AE2.Free;
    LFieldList_AE2.Free;
    LPropList_AE3.Free;
    LFieldList_AE3.Free;
    LPropList_AE4.Free;
    LFieldList_AE4.Free;
    LPropList_AE5.Free;
    LFieldList_AE5.Free;
    LPropList_AE6.Free;
    LFieldList_AE6.Free;
    LPropList_AE7.Free;
    LFieldList_AE7.Free;
    LPropList_AE8.Free;
    LFieldList_AE8.Free;
  end;
end;

procedure TSCRReportF.GenerateObjectCodeFromGrid1Click(Sender: TObject);
begin
  GenerateObjectCodeFromGrid;
end;

procedure TSCRReportF.InitVar;
begin
  FDragSource := TSCRParamDataFormat.Create(SCRParamSource1);
  FSCRRecipeDynAry.Init(TypeInfo(TSCRRecipeInfoObjArray), FSCRRecipeObjAry);

  FSCRRecipeDivisionList := TStringList.Create;
end;

procedure TSCRReportF.LaodFromObj2Grid1Click(Sender: TObject);
begin
  AddRecipeFromAry2Grid();
end;

procedure TSCRReportF.LoadBaseInfoFromXls2Grid;
var
  LFileName, LFilter: string;
begin
  LFilter := GetFilterFromFileExt('xlsx');
  LFileName := GetFileNameFromDialog(LFilter);
  _LoadBaseInfoFromXls2Grid(LFileName);
end;

procedure TSCRReportF.LoadBaseInfoXls2Grid1Click(Sender: TObject);
begin
  LoadBaseInfoFromXls2Grid();
end;

procedure TSCRReportF.LoadFromJsonFile2Aryt1Click(Sender: TObject);
begin
  LoadFromJsonFile2ObjAry(FSCRRecipeObjAry);
end;

procedure TSCRReportF.LoadFromJsonFile2Grid;
var
  LFileName: string;
begin
  LFileName := GetFileNameFromDialog();

  NextGrid1.ClearRows;

  NextGridFromJsonFile(NextGrid1, LFileName);
end;

procedure TSCRReportF.LoadFromJsonFile2Grid1Click(Sender: TObject);
begin
  LoadFromJsonFile2Grid();
end;

procedure TSCRReportF.LoadFromJsonFile2ObjAry(
  out AObjAry: TSCRRecipeInfoObjArray);
var
  LFileName: string;
begin
  LFileName := GetFileNameFromDialog();
  LoadSCRRecipeInfoObjArrayFromJsonFile(LFileName, AObjAry);
end;

procedure TSCRReportF.NextGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  LRect: TRect;
  LPoint: TPoint;
  LRow: integer;
  LSCRD: TSCRParam_DragDrop;
begin
  LRect := NextGrid1.GetHeaderRect;
  LPoint.X := X;
  LPoint.Y := Y;

  if PtInRect(LRect, LPoint) then
    exit;

  LRow := GetRowFromMouseDown(NextGrid1, LPoint);

  if LRow <> -1 then
  begin
    if (DragDetectPlus(TWinControl(Sender).Handle, Point(X,Y))) then
    begin
      //복수개를 Selection 할때는 Select 후 마우스 Drag 함
      if NextGrid1.SelectedCount > 1 then
      begin

      end
      else //한개만 Drag 할떄는 Select가 실행되기 전에 Drag 함
      begin
//        LSCRD.FSourceHandle := 100;
//        LSCRD.FSCRParam.F4S_LPSCR_Enable := True;
        LSCRD.FTagID := StrToIntDef(NextGrid1.CellByName['TagId', LRow].AsString,0);
        LSCRD.FTagName := NextGrid1.CellByName['TagName', LRow].AsString;
        LSCRD.FTagName := RemoveSpaceBetweenStrings(LSCRD.FTagName);
        FDragSource.SCRD := LSCRD;
      end;

      SCRParamSource1.Execute;
    end;
  end;
end;

procedure TSCRReportF.NextGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  FMousePoint.X := X;
  FMousePoint.Y := Y;
end;

procedure TSCRReportF.Save2JsonFile;
var
  LFileName: string;
begin
  LFileName := GetFileNameFromSaveDialog();
  NextGrid2JsonFile(NextGrid1, LFileName);
  FSCRRecipeDivisionList.SaveToFile(ChangeFileExt(LFileName, 'SCRRecipeDivisionList.txt'));
end;

procedure TSCRReportF.Save2JsonFile1Click(Sender: TObject);
begin
  Save2JsonFile();
end;

procedure TSCRReportF._LoadBaseInfoFromXls2Grid(AXlsFileName: string);
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LRange, LRange2: OleVariant;
  LWorksheet: OleVariant;
  LIdx, LLastRow: integer;
  LStr, LStr2: string;
  LCID: cardinal;
  LRecipe: TSCRRecipeInfo;
begin
  if AXlsFileName = '' then
    exit;

  if not FileExists(AXlsFileName) then
  begin
    ShowMessage('File(' + AXlsFileName + ')이 존재하지 않습니다');
    exit;
  end;

//  LCID := GetUserDefaultLCID;
  LExcel := GetActiveExcelOleObject(True);
  LExcel.Visible := true;
  LWorkBook := LExcel.Workbooks.Open(AXlsFileName);
  LWorksheet := LExcel.ActiveSheet;
  LLastRow := GetLastRowNumFromExcel(LWorkSheet);

  FSCRRecipeDivisionList.Clear;
  LIdx := 2;
//  LStr2 := GetIncXLColumn(LStr);
//  LRange2 := LWorksheet.range[LStr2+IntToStr(LIdx)];

  while LIdx <= LLastRow do
  begin
    LStr := 'D';
    LRange := LWorksheet.range[LStr+IntToStr(LIdx)];

    if LRange.FormulaR1C1 = '' then
    begin
      LStr := 'C';
      LRange2 := LWorksheet.range[LStr+IntToStr(LIdx)];
      LStr2 := LRange2.FormulaR1C1;

      if LStr2 <> '' then
        FSCRRecipeDivisionList.Add(LStr2 + '=' + IntToStr(LIdx-2));

      inc(LIdx);
      Continue;
    end;

    LRecipe := TSCRRecipeInfo.Create;

    LStr := 'C';
    LRange2 := LWorksheet.range[LStr+IntToStr(LIdx)];
    LStr2 := LRange2.FormulaR1C1;
    LStr2 := StringReplace(LStr2, '[', '_', [rfReplaceAll]);
    LStr2 := StringReplace(LStr2, ']', '_', [rfReplaceAll]);

    //RTTI error를 피하기 위해 Record 사이즈를 64KB 이하로 줄여야 함
    LStr2 := StringReplace(LStr2, 'Dosing', 'Dose', [rfReplaceAll]);
    LStr2 := StringReplace(LStr2, 'Engine', 'Eng', [rfReplaceAll]);
    LStr2 := StringReplace(LStr2, 'TwoStrokeScr', '2S', [rfReplaceAll]);
    LStr2 := StringReplace(LStr2, 'FourStrokeScr', '4S', [rfReplaceAll]);
    LStr2 := StringReplace(LStr2, 'Reducing', 'Reduce', [rfReplaceAll]);
    LStr2 := StringReplace(LStr2, 'GEN_', '', [rfReplaceAll]);
    LStr2 := StringReplace(LStr2, '__', '_', [rfReplaceAll]);
    LStr2 := StringReplace(LStr2, 'SetPoint', 'SP', [rfReplaceAll]);
    LStr2 := StringReplace(LStr2, 'Inlet', 'In', [rfReplaceAll]);
    LStr2 := StringReplace(LStr2, 'Outlet', 'Out', [rfReplaceAll]);

    LStr2 := RemoveSpaceBetweenStrings(LStr2);
    LRecipe.FTagName := StringReplace(LStr2, '.', '_', [rfReplaceAll]);

    LStr := 'I';
    LRange2 := LWorksheet.range[LStr+IntToStr(LIdx)];
    LStr2 := LRange2.FormulaR1C1;
    LRecipe.FTagDesc := LStr2;

    LStr := 'J';
    LRange2 := LWorksheet.range[LStr+IntToStr(LIdx)];
    LStr2 := LRange2.FormulaR1C1;
    LRecipe.FParamValue := LStr2;

    LStr := 'D';
    LRange2 := LWorksheet.range[LStr+IntToStr(LIdx)];
    LStr2 := LRange2.FormulaR1C1;
    LRecipe.FSCRType := LStr2;

    LStr := 'E';
    LRange2 := LWorksheet.range[LStr+IntToStr(LIdx)];
    LStr2 := LRange2.FormulaR1C1;
    LRecipe.FParamKind := LStr2;

    LStr := 'F';
    LRange2 := LWorksheet.range[LStr+IntToStr(LIdx)];
    LStr2 := LRange2.FormulaR1C1;
    LRecipe.FSCRComponent := LStr2;

    LStr := 'H';
    LRange2 := LWorksheet.range[LStr+IntToStr(LIdx)];
    LStr2 := LRange2.FormulaR1C1;
    LRecipe.FValueBitNo := StrToIntDef(LStr2, -1);

    Lrecipe.FValueType := GetValuTypeFromParamValue(LRecipe.FParamValue);

    FSCRRecipeDynAry.Add(LRecipe);

    if LIdx >= LLastRow then
      Break;

    inc(LIdx);
  end;

  AddRecipeFromAry2Grid();
//  LWorkBook.Close(False,EmptyParam,EmptyParam,LCID);
//  LExcel.Quit;
//  LExcel.DisConnect;
end;

end.
