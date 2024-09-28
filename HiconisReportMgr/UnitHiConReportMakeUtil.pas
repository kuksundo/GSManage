unit UnitHiConReportMakeUtil;

interface

uses Sysutils, Dialogs, Classes, System.Variants,
  mormot.core.variants, mormot.core.unicode, mormot.core.datetime,
  UnitHiConReportMgrData;

const
  COMMISSION_REPORT_TOTAL_FILENAME = 'HiCONiS Commissioning Report.xlsx';
  COMMISSION_REPORT_SUMMARY_FILENAME = 'HiCONiS Commissioning Report.xlsx';
  COMMISSION_REPORT_WORKCODE_FILENAME = 'HiCONiS Commissioning Report.xlsx';

procedure MakeCommissionReportTotal(ARec: THiconReportRec; AFileName: string='');
procedure MakeCommissionReportSummary(ARec: THiconReportRec; AFileName: string='');
procedure MakeCommissionReportWorkCode(ARec: THiconReportRec; AFileName: string='');

var
  DOC_DIR: string;

implementation

uses UnitExcelUtil, JHP.Util.Bit32Helper;

procedure MakeCommissionReportTotal(ARec: THiconReportRec; AFileName: string='');
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
  LpjhBit32: TpjhBit32;
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
  LWorksheet := LExcel.ActiveSheet;

  LVar := _JSON(StringToUtf8(ARec.FReportListJson));

  LRange := LWorksheet.range['B4']; //작성일자
  LDate := TimeLogToDateTime(LVar.ReportMakeDate);
  LRange.FormulaR1C1 := FormatDateTime('YYYY.MM.DD', LDate);

  LRange := LWorksheet.range['F4']; //작성자
  LFileName := LVar.ReportAuthorName;
  LRange.FormulaR1C1 := LFileName;

  LRange := LWorksheet.range['B5'];//호선번호(선종/선주)
//  LRange.FormulaR1C1 := LVar.ReportAuthorName;

  LRange := LWorksheet.range['F5'];//공사번호
  LFileName := LVar.ProjectNo;
  LRange.FormulaR1C1 := LFileName;

  LRange := LWorksheet.range['A12']; //당일진행업무
  LFileName := LVar.CurrentWorkDesc;
  LRange.FormulaR1C1 := LFileName;

  LRange := LWorksheet.range['E12'];//명일진행업무
  LFileName := LVar.NextWorkDesc;
  LRange.FormulaR1C1 := LFileName;

  LRange := LWorksheet.range['A45'];//선주/선급 Comment
  LFileName := LVar.OwnerComment;
  LRange.FormulaR1C1 := LFileName;

  LpjhBit32 := LVar.ModifyItems;

  for LIdx := 0 to 6 do //Report의 Check Box 가 7개임
  begin
    LFileName := 'Check Box ' + IntToStr(LIdx+1);
    SetValueCheckBoxByNameOnWorkSheet(LWorkSheet, LFileName, LpjhBit32.Bit[LIdx]);
  end;

{$ENDREGION}

{$REGION 'FReportDetailJson'}
  //WorkDetail =========================================================
//  LDetailRange := 'A'+ IntToStr(LERow) + ':I' + IntToStr(LERow);
  LRowCount := 0;
  LIdx := 19;
  LDocList := DocList(StringToUtf8(ARec.FReportDetailJsonAry));

  for LVar in LDocList do
  begin
    if LRowCount > 13 then
    begin

    end;

    LRange := LWorksheet.range['A'+IntToStr(LIdx)]; //Details 'A19'
    LFileName := LVar.WorkDetail;
    LRange.FormulaR1C1 := LFileName;

    LRange := LWorksheet.range['F'+IntToStr(LIdx)]; //From Time 'F19'
    LDate := TimeLogToDateTime(LVar.WorkItemBeginTime);
    LRange.FormulaR1C1 := FormatDateTime('HH:mm', LDate);

    LRange := LWorksheet.range['G'+IntToStr(LIdx)]; //To Time 'G19'
    LDate := TimeLogToDateTime(LVar.WorkItemEndTime);
    LRange.FormulaR1C1 := FormatDateTime('HH:mm', LDate);

    LRange := LWorksheet.range['H'+IntToStr(LIdx)]; //WorkHours 'H19'
    LRange.FormulaR1C1 := LVar.WorkHours;

    LRange := LWorksheet.range['I'+IntToStr(LIdx)]; //WorkCode 'I19'
    LRange.FormulaR1C1 := g_HiRptWorkCode.ToString(LVar.WorkCode);

    Inc(LIdx,2);
    Inc(LRowCount,2);
  end;
{$ENDREGION}

  LExcel.Visible := true;
end;

procedure MakeCommissionReportSummary(ARec: THiconReportRec; AFileName: string='');
begin

end;

procedure MakeCommissionReportWorkCode(ARec: THiconReportRec; AFileName: string='');
begin

end;

end.
