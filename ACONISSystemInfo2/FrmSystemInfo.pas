unit FrmSystemInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, JvExComCtrls, JvComCtrls,
  JvCheckTreeView, Vcl.StdCtrls, TreeList,

  mormot.core.base, mormot.core.os, mormot.core.text,
  mormot.core.collections, mormot.core.variants, mormot.core.json,
  mormot.net.client, mormot.core.unicode, mormot.net.server,

  FrameIniTreeList;

type
  TAconisSysInfoF = class(TForm)
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Button1: TButton;
    Button2: TButton;
    IniTreeListFr1: TIniTreeListFr;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    FSysInfoIniJson: RawUtf8;
    function GetSysInfoIniJsonFromXls(AXlsFileName: string): RawUtf8;
  public
    { Public declarations }
  end;

var
  AconisSysInfoF: TAconisSysInfoF;

implementation

uses UnitTreeViewUtil2, UnitTreeListUtil, UnitExcelUtil, UnitStringUtil;

{$R *.dfm}

procedure TAconisSysInfoF.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    LoadTreeListFromIni(IniTreeListFr1.TreeList1, OpenDialog1.FileName);
  end;
end;

procedure TAconisSysInfoF.Button3Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    FSysInfoIniJson := GetSysInfoIniJsonFromXls(OpenDialog1.FileName);
  end;
end;

procedure TAconisSysInfoF.Button4Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    FileFromString(FSysInfoIniJson, SaveDialog1.FileName);
  end;
end;

function TAconisSysInfoF.GetSysInfoIniJsonFromXls(
  AXlsFileName: string): RawUtf8;
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LWorksheet: OleVariant;
  LRange: OleVariant;
  LDoc: IDocDict;
  LList: IDocList;
  LRow, LXlsRowCount: integer;
  LRangeStr, LSection, LValue, LName, LStr, LStr2: string;
  LJson: RawUtf8;
begin
  if not FileExists(AXlsFileName) then
  begin
    ShowMessage('File(' + AXlsFileName + ')이 존재하지 않습니다');
    exit;
  end;

  LDoc := DocDict('{}');
  LList:= DocList('[]');

  LExcel := GetActiveExcelOleObject(True);
  LWorkBook := LExcel.Workbooks.Open(AXlsFileName);
  LExcel.Visible := true;
  LWorksheet := LExcel.ActiveSheet;
  LRange := LWorkSheet.UsedRange;
  LXlsRowCount := LRange.Rows.Count;

  for LRow := 10 to LXlsRowCount do
  begin
    LRangeStr := 'A' + IntToStr(LRow);
    LRange := LWorksheet.range[LRangeStr];
    LStr := LRange.FormulaR1C1;
    LStr := Trim(LStr);

    if (LStr = '') or (LStr[1] = '#') then
      Continue;

    if LStr[1] = '[' then
    begin
      TrimLeftChar(LStr, '[');
      TrimRightChar(LStr, ']');
      LSection := Trim(LStr);
      LName := '';
      LValue := '';
    end
    else
    begin
      if Pos('=', LStr) > 0 then
      begin
        LName := StrToken(LStr, '=');
        LValue := StrToken(LStr, '=');
      end
      else
      begin
        LName := '';
        LValue := '';
      end;
    end;

    LDoc.S['Section'] := LSection;
    LDoc.S['Name'] := LName;
    LDoc.S['Value'] := LValue;

    LRangeStr := 'B' + IntToStr(LRow);
    LRange := LWorksheet.range[LRangeStr];
    LStr := LRange.FormulaR1C1;
    LStr := Trim(LStr);
    LDoc.S['기능설명'] := LStr;

    LRangeStr := 'C' + IntToStr(LRow);
    LRange := LWorksheet.range[LRangeStr];
    LStr := LRange.FormulaR1C1;
    LStr := Trim(LStr);
    LDoc.S['설정방법'] := LStr;

    LRangeStr := 'D' + IntToStr(LRow);
    LRange := LWorksheet.range[LRangeStr];
    LStr := LRange.FormulaR1C1;
    LStr := Trim(LStr);
    LDoc.S['대상프로그램'] := LStr;

    LRangeStr := 'E' + IntToStr(LRow);
    LRange := LWorksheet.range[LRangeStr];
    LStr := LRange.FormulaR1C1;
    LStr := Trim(LStr);
    LDoc.S['설정변경후 적용방법'] := LStr;

    LRangeStr := 'F' + IntToStr(LRow);
    LRange := LWorksheet.range[LRangeStr];
    LStr := LRange.FormulaR1C1;
    LStr := Trim(LStr);
    LDoc.S['비고'] := LStr;

    Result := LDoc.ToJson(jsonUnquotedPropNameCompact);
    LList.Append(Result);
    LDoc.Clear;
  end;//for

  Result := LList.ToJson(jsonUnquotedPropNameCompact);
end;

end.
