unit UnitImportFromXls;

interface

uses Sysutils, Dialogs,
  mormot.core.variants, mormot.core.data,
  UnitExcelUtil,
  UnitHiASMaterialCodeRecord;

procedure ImportMaterialCodeFromXlsFile(AFileName: string);

implementation

uses UnitStringUtil;

procedure ImportMaterialCodeFromXlsFile(AFileName: string);
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LRange: OleVariant;
  LWorksheet: OleVariant;
  LY,LM,LD: word;
  LStr, LStr2, LStr3, LSectionPrefix: string;
  LIdx: integer;
  LDoc: Variant;
begin
  if not FileExists(AFileName) then
  begin
    ShowMessage('File(' + AFileName + ')이 존재하지 않습니다');
    exit;
  end;

  LExcel := GetActiveExcelOleObject(True);
  LWorkBook := LExcel.Workbooks.Open(AFileName);
//  LExcel.Visible := true;
  LWorksheet := LExcel.ActiveSheet;

  TDocVariant.New(LDoc, [dvoReturnNullForUnknownProperty]);

  LStr := 'A';
  LIdx := 2;

  while true do
  begin
    LRange := LWorksheet.range[LStr+IntToStr(LIdx)];//품목번호

    if LRange.FormulaR1C1 <> '' then
      LDoc.ProductNo := LRange.FormulaR1C1
    else
      break;

    LRange := LWorksheet.range['B'+IntToStr(LIdx)]; //자재번호
    LDoc.MaterialCode := LRange.FormulaR1C1;

    LRange := LWorksheet.range['C'+IntToStr(LIdx)]; //도면번호
    LDoc.DrawingNo := LRange.FormulaR1C1;

    LRange := LWorksheet.range['D'+IntToStr(LIdx)]; //자재명
    LDoc.MaterialName := LRange.FormulaR1C1;

    LRange := LWorksheet.range['E'+IntToStr(LIdx)]; //공급업체명
    LDoc.SupplierName := LRange.FormulaR1C1;

    AddMaterialCodeFromVariant(LDoc);

    Inc(LIdx);
  end;

  LWorkBook.Close;
  LExcel.Quit;
end;

end.
