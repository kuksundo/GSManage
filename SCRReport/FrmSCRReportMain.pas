unit FrmSCRReportMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, NxColumns, NxColumnClasses,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid, DragDrop,
  DropSource, DragDropText, Vcl.StdCtrls,
  UDragDropFormat_SCRParam;

type
  TSCRReportF = class(TForm)
    MainMenu1: TMainMenu;
    ools1: TMenuItem;
    LoadBaseInfoXls2Grid1: TMenuItem;
    PopupMenu1: TPopupMenu;
    GenerateObjectCodeFromGrid1: TMenuItem;
    Save2DB1: TMenuItem;
    NextGrid1: TNextGrid;
    NxIncrementColumn1: TNxIncrementColumn;
    GenerateDFM4updatetag1: TMenuItem;
    AssigntagfromObject1: TMenuItem;
    NxTextColumn1: TNxTextColumn;
    Button1: TButton;
    SCRParamSource1: TDropTextSource;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;

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
  private
    FDragSource: TSCRParamDataFormat;
    FMousePoint: TPoint;

    procedure _LoadBaseInfoFromXls2Grid(AXlsFileName: string);
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

uses UnitExcelUtil, UnitDialogUtil, UnitDFMUtil, UnitNextGridUtil2,
  FrmSCRSetting, FrmSCRAppSetting, FrmSCRGESetting, FrmSCRMESetting;

{$R *.dfm}

{ TSCRReportF }

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
begin

end;

procedure TSCRReportF.InitVar;
begin
  FDragSource := TSCRParamDataFormat.Create(SCRParamSource1);

end;

procedure TSCRReportF.LoadBaseInfoFromXls2Grid;
var
  LFileName, LFilter: string;
begin
  LFilter := GetFilterFromFileExt('xls');
  LFileName := GetFileNameFromDialog(LFilter);
  _LoadBaseInfoFromXls2Grid(LFileName);
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
        LSCRD.FSourceHandle := 100;
        LSCRD.FSCRParam.F4S_LPSCR_Enable := True;
        LSCRD.FTagID := StrToIntDef(NextGrid1.Cells[0, LRow],0);
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

procedure TSCRReportF._LoadBaseInfoFromXls2Grid(AXlsFileName: string);
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LRange: OleVariant;
  LWorksheet: OleVariant;
  LCID: cardinal;
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

//  LRange := LWorksheet.range['D10'];
//  LRange.FormulaR1C1 := AQtnR.FCustomerInfo;

//  LWorkBook.Close(False,EmptyParam,EmptyParam,LCID);
//  LExcel.Quit;
//  LExcel.DisConnect;
end;

end.
