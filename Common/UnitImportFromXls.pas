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
    ShowMessage('File(' + AFileName + ')�� �������� �ʽ��ϴ�');
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
    LRange := LWorksheet.range[LStr+IntToStr(LIdx)];//ǰ���ȣ

    if LRange.FormulaR1C1 <> '' then
      LDoc.ProductNo := LRange.FormulaR1C1
    else
      break;

    LRange := LWorksheet.range['B'+IntToStr(LIdx)]; //�����ȣ
    LDoc.MaterialCode := LRange.FormulaR1C1;

    LRange := LWorksheet.range['C'+IntToStr(LIdx)]; //�����ȣ
    LDoc.DrawingNo := LRange.FormulaR1C1;

    LRange := LWorksheet.range['D'+IntToStr(LIdx)]; //�����
    LDoc.MaterialName := LRange.FormulaR1C1;

    LRange := LWorksheet.range['E'+IntToStr(LIdx)]; //���޾�ü��
    LDoc.SupplierName := LRange.FormulaR1C1;

    AddMaterialCodeFromVariant(LDoc);

    Inc(LIdx);
  end;

  LWorkBook.Close;
  LExcel.Quit;
end;

end.
