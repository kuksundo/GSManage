unit UnitMakeHiconDBUtil;

interface

uses Sysutils, Dialogs, Classes, Forms,
  mormot.core.base, mormot.core.datetime, mormot.core.variants, mormot.core.data,
  mormot.core.unicode, mormot.core.text, mormot.core.os
  ,UnitStringUtil, UnitFileSearchUtil, UnitExcelUtil, UnitHiConFuncCodeOrm
  ;

//function ImportHiconFuncCodeFromXlsFile(AFileName: string): integer;

implementation

uses UnitDateUtil2, UnitmORMotUtil2;

//function ImportHiconFuncCodeFromXlsFile(AFileName: string): integer;
//var
//  LExcel: OleVariant;
//  LWorkBook: OleVariant;
//  LWorksheet: OleVariant;
//  LRange: OleVariant;
//  LStr, LStr2: string;
//  LIdx, LLastRow, i: integer;
//  LDoc: Variant;
//begin
//  if not FileExists(AFileName) then
//  begin
//    ShowMessage('File(' + AFileName + ')이 존재하지 않습니다');
//    exit;
//  end;
//
//  InitHiconFuncCodeClient(Application.ExeName);
//  LExcel := GetActiveExcelOleObject(True);
//  LWorkBook := LExcel.Workbooks.Open(AFileName);
////  LExcel.Visible := true;
//  LWorksheet := LExcel.ActiveSheet;
//  LLastRow := GetLastRowNumFromExcel(LWorkSheet);
//  TDocVariant.New(LDoc, [dvoReturnNullForUnknownProperty]);
//  Result := 0;
//  LIdx := 4;
//
////  while LRange.FormulaR1C1 <> '' do
//  for i := 4 to LLastRow do
//  begin
//    LRange := LWorksheet.range['A'+IntToStr(LIdx)];
//    LDoc.FuncCode := LRange.FormulaR1C1;
//    LRange := LWorksheet.range['B'+IntToStr(LIdx)];
//    LDoc.DataType := LRange.FormulaR1C1;
//    LRange := LWorksheet.range['C'+IntToStr(LIdx)];
//    LDoc.Desc := LRange.FormulaR1C1;
//    LRange := LWorksheet.range['D'+IntToStr(LIdx)];
//    LDoc.GrpModule_CB := LRange.FormulaR1C1;
//    LRange := LWorksheet.range['E'+IntToStr(LIdx)];
//    LDoc.GrpModule_SbMotor1 := LRange.FormulaR1C1;
//    LRange := LWorksheet.range['F'+IntToStr(LIdx)];
//    LDoc.GrpModule_SbMotor2 := LRange.FormulaR1C1;
//    LRange := LWorksheet.range['G'+IntToStr(LIdx)];
//    LDoc.GrpModule_VFD := LRange.FormulaR1C1;
//    LRange := LWorksheet.range['H'+IntToStr(LIdx)];
//    LDoc.GrpModule_MotorFr := LRange.FormulaR1C1;
//    LRange := LWorksheet.range['I'+IntToStr(LIdx)];
//    LDoc.GrpModule_ValveC := LRange.FormulaR1C1;
//    LRange := LWorksheet.range['J'+IntToStr(LIdx)];
//    LDoc.GrpModule_ValveD := LRange.FormulaR1C1;
//    LRange := LWorksheet.range['K'+IntToStr(LIdx)];
//    LDoc.GrpModule_ValveT := LRange.FormulaR1C1;
//    LRange := LWorksheet.range['L'+IntToStr(LIdx)];
//    LDoc.GeneralModule_Measdh := LRange.FormulaR1C1;
//    LRange := LWorksheet.range['M'+IntToStr(LIdx)];
//    LDoc.GeneralModule_Measav := LRange.FormulaR1C1;
//    LRange := LWorksheet.range['N'+IntToStr(LIdx)];
//    LDoc.SignalType := LRange.FormulaR1C1;
//
//    AddOrUpdateHiconFuncCodeFromVariant(LDoc.FuncCode, LDoc, True);
//
//    Inc(LIdx);
//    Inc(Result);
//  end;//While
//
//  DestroyHiconFuncCodeClient();
//  LWorkBook.Close;
//  LExcel.Quit;
//
//  ShowMessage(IntToStr(Result) + ' row(s) are added to OrmHiconFuncCode');
//end;

end.
