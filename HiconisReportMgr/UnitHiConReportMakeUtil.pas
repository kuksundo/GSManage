unit UnitHiConReportMakeUtil;

interface

uses Sysutils, Dialogs, Classes, System.Variants,
  mormot.core.variants, mormot.core.unicode, mormot.core.datetime,
  UnitHiConReportMgrData;

const
  COMMISSION_REPORT_TOTAL_FILENAME = 'HiCONiS Commissioning Report.xlsx';
  COMMISSION_REPORT_SUMMARY_FILENAME = 'HiCONiS Commissioning Report.xlsx';
  COMMISSION_REPORT_WORKCODE_FILENAME = 'HiCONiS Commissioning Report.xlsx';

procedure MakeCommissionReportTotal(ARec: THiconReportRec; AFileName: string=''; ASheetName: string='');
procedure MakeCommissionReportSummary(ARec: THiconReportRec; AFileName: string=''; ASheetName: string='');
procedure MakeCommissionReportWorkCode(ARec: THiconReportRec; AFileName: string=''; ASheetName: string='');
procedure MakeCommissionReportSummaryOfWorkCode(ARec: THiconReportRec; AWorkCode: string;  AFileName: string=''; ASheetName: string='');

procedure SetCommissionReportHeaderBySheet(AHeaderJson: variant; ASheet: OleVariant);

procedure SetCommissionReportSummaryBySheet(AVar: variant; ASheet: OleVariant);
procedure SetCommissionReportSummaryDetailBySheet(AJsonAry: string; ASheet: OleVariant);
procedure SetCommissionReportSummaryDetailOfWorkCodeBySheet(AJsonAry, AWorkCode: string; ASheet: OleVariant);

procedure SetCommissionReportWorkCodeBySheet(AJsonAry: string; ASheet: OleVariant);

var
  DOC_DIR: string;

implementation

uses UnitExcelUtil, JHP.Util.Bit32Helper;

procedure MakeCommissionReportTotal(ARec: THiconReportRec; AFileName, ASheetName: string);
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

procedure MakeCommissionReportSummary(ARec: THiconReportRec; AFileName, ASheetName: string);
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
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
    LWorksheet := LWorkBook.ActiveSheet
  else
  begin
    if CheckWorksheetExistByName(LWorkBook, ASheetName) then
    begin
      LWorkSheet := LExcel.WorkSheets.Item[ASheetName];
      LWorkSheet.Activate;
    end;
  end;

  LVar := _JSON(StringToUtf8(ARec.FReportListJson));

  SetCommissionReportHeaderBySheet(LVar, LWorkSheet);
  SetCommissionReportSummaryBySheet(LVar, LWorkSheet);
  SetCommissionReportSummaryDetailBySheet(ARec.FReportDetailJsonAry, LWorkSheet);

  LExcel.Visible := true;
end;

procedure MakeCommissionReportWorkCode(ARec: THiconReportRec; AFileName, ASheetName: string);
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
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
    if CheckWorksheetExistByName(LWorkBook, ASheetName) then
    begin
      LWorkSheet := LExcel.WorkSheets.Item[ASheetName];
      LWorkSheet.Activate;
    end;
  end;

  LVar := _JSON(StringToUtf8(ARec.FReportListJson));

  SetCommissionReportHeaderBySheet(LVar, LWorkSheet);
  SetCommissionReportWorkCodeBySheet(ARec.FReportDetailJsonAry, LWorkSheet);
{$ENDREGION}
end;

procedure MakeCommissionReportSummaryOfWorkCode(ARec: THiconReportRec; AWorkCode, AFileName, ASheetName: string);
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

  LVar := _JSON(StringToUtf8(ARec.FReportListJson));

  SetCommissionReportHeaderBySheet(LVar, LWorkSheet);
  SetCommissionReportSummaryDetailOfWorkCodeBySheet(ARec.FReportDetailJsonAry, AWorkCode, LWorkSheet);

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
