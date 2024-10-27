unit UnitHiConReportMakeUtil;

interface

uses Sysutils, Dialogs, Classes, System.Variants,
  mormot.core.variants, mormot.core.unicode, mormot.core.datetime,
  mormot.core.os, mormot.core.json, mormot.core.base,
  UnitHiConReportMgrData;

const
  COMMISSION_REPORT_TOTAL_FILENAME = 'HiCONiS Commissioning Report.xlsx';
  COMMISSION_REPORT_SUMMARY_FILENAME = 'HiCONiS Commissioning Report-Summary.xlsx';
  COMMISSION_REPORT_WORKCODE_FILENAME = 'HiCONiS Commissioning Report.xlsx';

procedure MakeCommissionReportByReportKind(AJsonAry: string; AHiCommissionRptKind: integer; AXlsFileName: string);
procedure MakeCommissionReportTotal(AJsonAry: string; AFileName: string='');//Rec: THiconReportRec;
procedure MakeCommissionReportSummary(AJsonAry: string; AFileName: string='');
procedure MakeCommissionReportWorkCode(AJsonAry: string; AFileName: string='');
procedure MakeCommissionReportSummaryOfWorkCode(AJsonAry: string; AWorkCode: string;  AFileName: string=''; ASheetName: string='');

procedure SetCommissionReportHeaderBySheet(AHeaderJson: variant; ASheet: OleVariant);

procedure SetCommissionReportSummaryBySheet(AVar: variant; ASheet: OleVariant);
procedure SetCommissionReportSummaryDetailBySheet(AJsonAry: string; ASheet: OleVariant);
procedure SetCommissionReportSummaryDetailOfWorkCodeBySheet(AJsonAry, AWorkCode: string; ASheet: OleVariant);

procedure SetCommissionReportWorkCodeBySheet(AJsonAry: string; ASheet: OleVariant);

var
  DOC_DIR: string;

implementation

uses UnitExcelUtil, JHP.Util.Bit32Helper;

procedure MakeCommissionReportByReportKind(AJsonAry: string; AHiCommissionRptKind: integer; AXlsFileName: string);
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LSrcWorksheet, LDestWorksheet: OleVariant;
  LFileName, LTempFileName, LSheetName, LFileExt, LOriginSheetName: string;
  LVar: variant;
  LHiconReportRec: THiconReportRec;
  LDocList: IDocList;
  LDocDict: IDocDict;
  LJson, LDictStr: RawUtf8;
  i: integer;
begin
  case THiCommissionRptKind(AHiCommissionRptKind) of
    hcrkTotal:begin
      LOriginSheetName := 'Total';
    end;
    hcrkSummary:begin
      LOriginSheetName := '요약';
    end;
    hcrkCode:begin
    end;
    hcrkSummaryByCode:begin
    end;
  end;

  LFileName := DOC_DIR + AXlsFileName;

  if not FileExists(LFileName) then
  begin
    ShowMessage('File(' + LFileName + ')이 존재하지 않습니다');
    exit;
  end;

  LFileExt := FormatDateTime('-yyyymmddhhnnss', now) + '.xlsx';
  LTempFileName := 'c:\temp\' + ChangeFileExt(ExtractFileName(LFileName), LFileExt);

  if not CopyFile(LFileName, LTempFileName, False) then
  begin
    ShowMessage('File Copy Fail to ' + LTempFileName);
    exit;
  end;

  LExcel := GetActiveExcelOleObject(True);
  LExcel.DisplayAlerts := False; // Suppress confirmation dialogs

  LWorkBook := LExcel.Workbooks.Open(LTempFileName);

  LDocList := DocList(StringToUtf8(AJsonAry));

//  for LDocDict in LDocList.Objects do
  for i := 0 to LDocList.Len - 1 do
  begin
    LDictStr := LDocList.Item[i];
    LDocDict := DocDict(LDictStr);

    LJson := LDocDict.S['HiconReportRec'];
    RecordLoadJson(LHiconReportRec, LJson, TypeInfo(THiconReportRec));

    LSheetName := LDocDict.S['SheetName'];

    if LSheetName = '' then
      LDestWorksheet := LWorkBook.ActiveSheet
    else
    begin
      if CheckWorksheetExistByName(LWorkBook, LSheetName) then
      begin
        LDestWorksheet := LExcel.WorkSheets.Item[LSheetName];
        LDestWorksheet.Activate;
      end
      else
      begin
        LDestWorksheet := CopySheet2WorkBookByName(LWorkBook, LOriginSheetName, LSheetName);
      end;
    end;

    LVar := _JSON(StringToUtf8(LHiconReportRec.FReportListJson));

    case THiCommissionRptKind(AHiCommissionRptKind) of
      hcrkTotal:begin
        SetCommissionReportHeaderBySheet(LVar, LDestWorksheet);
        SetCommissionReportSummaryBySheet(LVar, LDestWorksheet);
      end;
      hcrkSummary:begin
        SetCommissionReportHeaderBySheet(LVar, LDestWorksheet);
        SetCommissionReportSummaryBySheet(LVar, LDestWorksheet);
        SetCommissionReportSummaryDetailBySheet(LHiconReportRec.FReportDetailJsonAry, LDestWorksheet);
      end;
      hcrkCode:begin
      end;
      hcrkSummaryByCode:begin
      end;
    end;
  end;//for

  DeleteSheetFromWorkBookByName(LWorkBook, LOriginSheetName);

  LExcel.DisplayAlerts := True;
  LExcel.Visible := true;
end;

procedure MakeCommissionReportTotal(AJsonAry: string; AFileName: string);//ARec: THiconReportRec
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LRange, LDetailRange: OleVariant;
  LWorksheet: OleVariant;
  LFileName, LStr: string;
  LVar: variant;
  LDate: TDateTime;
  LIdx, LRowCount: integer;
  LDocList: IDocList;
begin
end;

procedure MakeCommissionReportSummary(AJsonAry: string; AFileName: string);//ARec: THiconReportRec
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LSrcWorksheet, LDestWorksheet: OleVariant;
  LFileName, LTempFileName, LSheetName, LFileExt: string;
  LVar: variant;
  LHiconReportRec: THiconReportRec;
  LDocList: IDocList;
  LDocDict: IDocDict;
  LJson, LDictStr: RawUtf8;
  i: integer;
begin
{$REGION 'FReportListJson'}
  if AFileName = '' then
    AFileName := COMMISSION_REPORT_SUMMARY_FILENAME;

  MakeCommissionReportByReportKind(AJsonAry, Ord(hcrkSummary), AFileName);
{$ENDREGION}
end;

procedure MakeCommissionReportWorkCode(AJsonAry: string; AFileName: string);//ARec: THiconReportRec
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LWorksheet: OleVariant;
  LSrcWorksheet, LDestWorksheet: OleVariant;
  LFileName, LTempFileName, LSheetName: string;
  LVar: variant;
  LHiconReportRec: THiconReportRec;
  LDocList: IDocList;
  LDocDict: IDocDict;
  LJson: RawUtf8;
begin
{$REGION 'FReportListJson'}
  if AFileName = '' then
    AFileName := COMMISSION_REPORT_WORKCODE_FILENAME;

  LFileName := DOC_DIR + AFileName;

  if not FileExists(LFileName) then
  begin
    ShowMessage('File(' + LFileName + ')이 존재하지 않습니다');
    exit;
  end;

  LTempFileName := 'c:\temp\' + ExtractFileName(LFileName);

  if not CopyFile(LFileName, LTempFileName, False) then
  begin
    ShowMessage('File Copy Fail to ' + LTempFileName);
    exit;
  end;

  LExcel := GetActiveExcelOleObject(True);
  LWorkBook := LExcel.Workbooks.Open(LTempFileName);

  LDocList := DocList(AJsonAry);

  for LDocDict in LDocList do
  begin
    LJson := LDocDict.S['HiconReportRec'];
    RecordLoadJson(LHiconReportRec, LJson, TypeInfo(THiconReportRec));

    LSheetName := LDocDict.S['SheetName'];

    if LSheetName = '' then
      LDestWorksheet := LWorkBook.ActiveSheet
    else
    begin
      if CheckWorksheetExistByName(LWorkBook, LSheetName) then
      begin
        LDestWorksheet := LExcel.WorkSheets.Item[LSheetName];
        LDestWorksheet.Activate;
      end
      else
      begin
  //      LWorkSheet := LWorkBook.Sheets['요약'].Copy(LWorkBook.Sheets(LWorkBook.Sheets.Count));
  //      LSrcWorksheet := LWorkBook.ActiveSheet;
        CopySheet2WorkBookByName(LWorkBook, '요약', LSheetName);
      end;
    end;

    LVar := _JSON(StringToUtf8(LHiconReportRec.FReportListJson));

    SetCommissionReportHeaderBySheet(LVar, LDestWorksheet);
    SetCommissionReportWorkCodeBySheet(LHiconReportRec.FReportDetailJsonAry, LDestWorksheet);
  end;

  LExcel.Visible := true;

{$ENDREGION}
end;

procedure MakeCommissionReportSummaryOfWorkCode(AJsonAry: string; AWorkCode, AFileName, ASheetName: string);//ARec: THiconReportRec
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LRange, LDetailRange: OleVariant;
  LWorksheet: OleVariant;
  LFileName: string;
  LVar: variant;
begin
{$REGION 'FReportListJson'}
  if AFileName = '' then
    AFileName := COMMISSION_REPORT_TOTAL_FILENAME;

  LFileName := DOC_DIR + AFileName;

  if not FileExists(LFileName) then
  begin
    ShowMessage('File(' + LFileName + ')이 존재하지 않습니다');
    exit;
  end;

  LExcel := GetActiveExcelOleObject(True);
  LWorkBook := LExcel.Workbooks.Open(LFileName);

  if ASheetName = '' then
    LWorksheet := LExcel.ActiveSheet
  else
  begin
    if AWorkCode <> 'All' then
      ASheetName := ASheetName + '_' + AWorkCode;

    if CheckWorksheetExistByName(LWorkBook, ASheetName) then
    begin
      LWorkSheet := LExcel.WorkSheets.Item[ASheetName];
      LWorkSheet.Activate;
    end;
  end;

//  LVar := _JSON(StringToUtf8(ARec.FReportListJson));
//
//  SetCommissionReportHeaderBySheet(LVar, LWorkSheet);
//  SetCommissionReportSummaryDetailOfWorkCodeBySheet(ARec.FReportDetailJsonAry, AWorkCode, LWorkSheet);

  LExcel.Visible := true;
{$ENDREGION}
end;

procedure SetCommissionReportHeaderBySheet(AHeaderJson: variant; ASheet: OleVariant);
var
  LRange: OleVariant;
  LStr: string;
  LDate: TDateTime;
begin
  LRange := ASheet.range['B4']; //작성일자
  LDate := TimeLogToDateTime(AHeaderJson.ReportMakeDate);
  LRange.FormulaR1C1 := FormatDateTime('YYYY.MM.DD', LDate);

  LRange := ASheet.range['B5']; //작성자
  LStr := AHeaderJson.ReportAuthorName;
  LRange.FormulaR1C1 := LStr;

  LRange := ASheet.range['G4'];//선종
  LRange.FormulaR1C1 := AHeaderJson.VesselType;

  LRange := ASheet.range['G5'];//선주
  LStr := AHeaderJson.ProjectNo;
  LRange.FormulaR1C1 := LStr;

  LRange := ASheet.range['J4'];//공사번호
  LStr := AHeaderJson.ProjectNo;
  LRange.FormulaR1C1 := LStr;

  LRange := ASheet.range['J5'];//Hull No
  LStr := AHeaderJson.HullNo;
  LRange.FormulaR1C1 := LStr;
end;

procedure SetCommissionReportSummaryBySheet(AVar: variant; ASheet: OleVariant);
var
  LRange: OleVariant;
  LIdx: integer;
  LStr: string;
  LpjhBit32: TpjhBit32;
begin
  LRange := ASheet.range['A12']; //당일진행업무
  LStr := AVar.CurrentWorkDesc;
  LRange.FormulaR1C1 := LStr;

  LRange := ASheet.range['G12'];//명일진행업무
  LStr := AVar.NextWorkDesc;
  LRange.FormulaR1C1 := LStr;

  LRange := ASheet.range['A57'];//선주/선급 Comment
  LStr := AVar.OwnerComment;
  LRange.FormulaR1C1 := LStr;

  LpjhBit32 := AVar.ModifyItems;

  for LIdx := 0 to 6 do //Report의 Check Box 가 7개임
  begin
    LStr := 'Check Box ' + IntToStr(LIdx+1);
    SetValueCheckBoxByNameOnWorkSheet(ASheet, LStr, LpjhBit32.Bit[LIdx]);
  end;
end;

procedure SetCommissionReportSummaryDetailBySheet(AJsonAry: string; ASheet: OleVariant);
var
  LIdx, LRowCount: integer;
  LDocList: IDocList;
  LVar: variant;
  LRange: OleVariant;
  LStr: string;
  LDate: TDateTime;
begin
{$REGION 'FReportDetailJson'}
  //WorkDetail =========================================================
//  LDetailRange := 'A'+ IntToStr(LERow) + ':I' + IntToStr(LERow);
  LRowCount := 0;
  LIdx := 17;
  LDocList := DocList(StringToUtf8(AJsonAry));

  for LVar in LDocList do
  begin
    if LRowCount > 13 then
    begin

    end;

    LRange := ASheet.range['A'+IntToStr(LIdx)]; //Details 'A19'
    LStr := LVar.WorkDetail;
    LRange.FormulaR1C1 := LStr;

    LRange := ASheet.range['H'+IntToStr(LIdx)]; //From Time
    LDate := TimeLogToDateTime(LVar.WorkItemBeginTime);
    LRange.FormulaR1C1 := FormatDateTime('HH:mm', LDate);

    LRange := ASheet.range['I'+IntToStr(LIdx)]; //To Time
    LDate := TimeLogToDateTime(LVar.WorkItemEndTime);
    LRange.FormulaR1C1 := FormatDateTime('HH:mm', LDate);

    LRange := ASheet.range['J'+IntToStr(LIdx)]; //WorkHours
    LRange.FormulaR1C1 := LVar.WorkHours;

    LRange := ASheet.range['K'+IntToStr(LIdx)]; //WorkCode
    LRange.FormulaR1C1 := g_HiRptWorkCode.ToString(LVar.WorkCode);

    Inc(LIdx,2);
    Inc(LRowCount,2);
  end;
{$ENDREGION}
end;

procedure SetCommissionReportSummaryDetailOfWorkCodeBySheet(AJsonAry, AWorkCode: string; ASheet: OleVariant);
var
  LIdx, LRowCount: integer;
  LDocList: IDocList;
  LVar: variant;
  LRange: OleVariant;
  LStr: string;
  LDate: TDateTime;
begin
{$REGION 'FReportDetailJson'}
  //WorkDetail =========================================================
  LRowCount := 0;
  LIdx := 17;
  LDocList := DocList(StringToUtf8(AJsonAry));

  for LVar in LDocList do
  begin
    if LRowCount > 13 then
    begin

    end;

    if AWorkCode = LVar.WorkCode then
    begin
      LRange := ASheet.range['A'+IntToStr(LIdx)]; //Details
      LStr := LVar.WorkDetail;
      LRange.FormulaR1C1 := LStr;

      LRange := ASheet.range['H'+IntToStr(LIdx)]; //From Time
      LDate := TimeLogToDateTime(LVar.WorkItemBeginTime);
      LRange.FormulaR1C1 := FormatDateTime('HH:mm', LDate);

      LRange := ASheet.range['I'+IntToStr(LIdx)]; //To Time
      LDate := TimeLogToDateTime(LVar.WorkItemEndTime);
      LRange.FormulaR1C1 := FormatDateTime('HH:mm', LDate);

      LRange := ASheet.range['J'+IntToStr(LIdx)]; //WorkHours
      LRange.FormulaR1C1 := LVar.WorkHours;

      LRange := ASheet.range['K'+IntToStr(LIdx)]; //WorkCode
      LRange.FormulaR1C1 := g_HiRptWorkCode.ToString(LVar.WorkCode);

      Inc(LIdx,2);
      Inc(LRowCount,2);
    end;
  end;
{$ENDREGION}
end;

procedure SetCommissionReportWorkCodeBySheet(AJsonAry: string; ASheet: OleVariant);
var
  LDocList: IDocList;
  LVar: variant;
  LWorkHourSumList: TStringList;
  LWorkCode: string;
  i, LIdx, LWorkHour: integer;
  LRange: OleVariant;
begin
  LDocList := DocList(StringToUtf8(AJsonAry));
  LWorkHourSumList := TStringList.Create;
  try
    for LVar in LDocList do
    begin
      LWorkCode := g_HiRptWorkCode.ToString(LVar.WorkCode);
      LIdx := LWorkHourSumList.IndexOf(LWorkCode);

      if LIdx = -1 then
        LWorkHourSumList.Add(LWorkCode + '=' + IntToStr(LVar.WorkHours))
      else
      begin
        LWorkHour := StrToInt(LWorkHourSumList.ValueFromIndex[LIdx]);
        LWorkHour := LWorkHour + LVar.WorkHours;
        LWorkHourSumList.Add(LWorkCode + '=' + IntToStr(LWorkHour));
      end;
    end;

    for i := 0 to LWorkHourSumList.Count - 1 do
    begin
      LWorkCode := LWorkHourSumList.Names[i];
      case g_HiRptWorkCode.ToType(LWorkCode) of
        hrwcA  : LIdx := 8;
        hrwcB_1: LIdx := 10;
        hrwcB_2: LIdx := 12;
        hrwcB_3: LIdx := 14;
        hrwcB_4: LIdx := 16;
        hrwcC_1: LIdx := 18;
        hrwcC_2: LIdx := 20;
        hrwcD  : LIdx := 22;
        else LIdx := 0;
      end;

      if LIdx <> 0 then
      begin
        LRange := ASheet.range['K'+IntToStr(LIdx)];
        LRange.FormulaR1C1 := LWorkHourSumList.ValueFromIndex[i];
      end;
    end;//for
  finally
    LWorkHourSumList.Free;
  end;

end;

end.
