unit UnitImportFromXls;

interface

uses Sysutils, Dialogs, System.Variants,
  mormot.core.variants, mormot.core.data, mormot.core.datetime,
  UnitExcelUtil,
  UnitHiASMaterialCodeRecord, UnitHiASProjectRecord;

procedure ImportMaterialCodeFromXlsFile(AFileName: string);
procedure ImportHiconisProjectFromXlsFile(AFileName: string);

implementation

uses UnitStringUtil, UnitDateUtil2;

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

procedure ImportHiconisProjectFromXlsFile(AFileName: string);
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LRange: OleVariant;
  LWorksheet: OleVariant;
  LY,LM,LD: word;
  LStr, LStrIdx, LStr3, LSectionPrefix: string;
  LIdx: integer;
  LDoc: Variant;
  LDate: TDate;
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

  LStr := 'B';
  LIdx := 7;

  while true do
  begin
    LStrIdx := IntToStr(LIdx);

    LRange := LWorksheet.range[LStr+LStrIdx];//HullNo

    if LRange.FormulaR1C1 <> '' then
      LDoc.HullNo := LRange.FormulaR1C1
    else
      break;

    LRange := LWorksheet.range['D'+LStrIdx]; //Vessel_Qty
    LDoc.Vessel_Qty := LRange.FormulaR1C1;
    LRange := LWorksheet.range['E'+LStrIdx]; //Vessel_Unit
    LDoc.Vessel_Unit := LRange.FormulaR1C1;
    LRange := LWorksheet.range['F'+LStrIdx]; //Vessel_Type
    LDoc.Vessel_Type := LRange.FormulaR1C1;
    LRange := LWorksheet.range['G'+LStrIdx]; //DeliveryDate
    LStr3 := LRange.Value;
    if (LStr3 <> '') and (LStr3 <> '-') then
      LDate := GetDateFromFormatStr('yyyy-mm-dd', '-', LStr3);
//      LDate := VarToDateTime(LStr3);
    LDoc.DeliveryDate := TimeLogFromDateTime(LDate);
    LRange := LWorksheet.range['I'+LStrIdx]; //Shipyard
    LDoc.Shipyard := LRange.FormulaR1C1;
    LRange := LWorksheet.range['J'+LStrIdx]; //ShipOwener
    LDoc.ShipOwener := LRange.FormulaR1C1;
    LRange := LWorksheet.range['K'+LStrIdx]; //HiconisSystem
    LDoc.HiconisSystem := LRange.FormulaR1C1;
    LRange := LWorksheet.range['L'+LStrIdx]; //EngineKind
    LDoc.EngineKind := LRange.FormulaR1C1;
    LRange := LWorksheet.range['M'+LStrIdx]; //SocityClass
    LDoc.SocityClass := LRange.FormulaR1C1;
    LRange := LWorksheet.range['O'+LStrIdx]; //WarrantyCond1_Code
    LDoc.WarrantyCond1_Code := LRange.FormulaR1C1;
    LRange := LWorksheet.range['P'+LStrIdx]; //WarrantyCond1_Name
    LDoc.WarrantyCond1_Name := LRange.FormulaR1C1;
    LRange := LWorksheet.range['Q'+LStrIdx]; //WarrantyCond1_Period
    LDoc.WarrantyCond1_Period := LRange.FormulaR1C1;
    LRange := LWorksheet.range['R'+LStrIdx]; //WarrantyCond1_Period_Unit
    LDoc.WarrantyCond1_Period_Unit := LRange.FormulaR1C1;
    LRange := LWorksheet.range['S'+LStrIdx]; //WarrantyCond1_Period_Unit_Name
    LDoc.WarrantyCond1_Period_Unit_Name := LRange.FormulaR1C1;
    LRange := LWorksheet.range['T'+LStrIdx]; //WarrantyCond2_Code
    LDoc.WarrantyCond2_Code := LRange.FormulaR1C1;
    LRange := LWorksheet.range['U'+LStrIdx]; //WarrantyCond2_Name
    LDoc.WarrantyCond2_Name := LRange.FormulaR1C1;
    LRange := LWorksheet.range['V'+LStrIdx]; //WarrantyCond2_Period
    LDoc.WarrantyCond2_Period := LRange.FormulaR1C1;
    LRange := LWorksheet.range['W'+LStrIdx]; //WarrantyCond2_Period_Unit
    LDoc.WarrantyCond2_Period_Unit := LRange.FormulaR1C1;
    LRange := LWorksheet.range['X'+LStrIdx]; //WarrantyCond2_Period_Unit_Name
    LDoc.WarrantyCond2_Period_Unit_Name := LRange.FormulaR1C1;
    LRange := LWorksheet.range['Y'+LStrIdx]; //AdventKind
    LDoc.AdventKind := LRange.FormulaR1C1;
    LRange := LWorksheet.range['Z'+LStrIdx]; //ExtendWarrantyPeriod
    LDoc.ExtendWarrantyPeriod := LRange.FormulaR1C1;
    LRange := LWorksheet.range['AA'+LStrIdx]; //TotalWarrantyPeriod
    LDoc.TotalWarrantyPeriod := LRange.Value;

    LDoc.ModifyDate := TimeLogFromDateTime(Now);

    AddHiASProjectFromVariant(LDoc);
    Inc(LIdx);
  end;//while

  LWorkBook.Close;
  LExcel.Quit;
end;

end.
