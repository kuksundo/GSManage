unit UnitMakeMasterCustomerDB2;

interface

uses Sysutils, Dialogs, Classes, AdvSmoothSplashScreen,
  mormot.core.datetime, mormot.core.variants, mormot.core.data,
  UnitExcelUtil,
  UnitGAMasterRecord2,
  CommonData2;

procedure ImportMasterCustomerFromXlsFile(AFileName: string);
procedure ImportCustomerMasterFromMapsExportedXlsFile(AXlsFileName, ADBName: string; ASplashScreen: TAdvSmoothSplashScreen=nil);

implementation

uses UnitStringUtil;

procedure ImportMasterCustomerFromXlsFile(AFileName: string);
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LRange: OleVariant;
  LWorksheet: OleVariant;
  LY,LM,LD: word;
  LStr, LStr2, LStr3, LSectionPrefix: string;
  LIdx: integer;
  LDoc: Variant;
  LCompanyTypes: TCompanyTypes;
  LBusinessAreas: TBusinessAreas;
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

  LStr := 'C';
  LIdx := 5;
  LRange := LWorksheet.range[LStr+IntToStr(LIdx)];

  while true do
  begin
    LRange := LWorksheet.range['C'+IntToStr(LIdx)];

    if LRange.FormulaR1C1 <> '' then
      LDoc.Nation := LRange.FormulaR1C1
    else
      break;

    LRange := LWorksheet.range['D'+IntToStr(LIdx)];
    LDoc.City := LRange.FormulaR1C1;

    LRange := LWorksheet.range['E'+IntToStr(LIdx)];
    LDoc.CompanyName := LRange.FormulaR1C1;

    LRange := LWorksheet.range['G'+IntToStr(LIdx)];
    LStr := LRange.FormulaR1C1;
    if LStr <> '' then
    begin
      LStr2 := strToken(LStr, '.');
      if LStr2 <> '' then
      begin
        LY := 0;
        LM := 0;
        LD := 0;

        LY := StrToIntDef(LStr2, 0);

        LStr2 := strToken(LStr, '.');
        LM := StrToIntDef(LStr2, 0);
        LD := StrToIntDef(LStr, 0);

        LDoc.ContractDueDate := DateToStr(EncodeDate(LY, LM, LD));
      end;
    end;

    LRange := LWorksheet.range['H'+IntToStr(LIdx)];
    LDoc.Notes := LRange.FormulaR1C1;

    LRange := LWorksheet.range['M'+IntToStr(LIdx)];
    LDoc.ManagerName := LRange.FormulaR1C1;

    LRange := LWorksheet.range['N'+IntToStr(LIdx)];
    LDoc.MobilePhone := LRange.FormulaR1C1;

    LRange := LWorksheet.range['O'+IntToStr(LIdx)];
    LDoc.OfficePhone := LRange.FormulaR1C1;

    LRange := LWorksheet.range['Q'+IntToStr(LIdx)];
    LDoc.EMail := LRange.FormulaR1C1;

    LRange := LWorksheet.range['R'+IntToStr(LIdx)];
    LDoc.CompanyCode := LRange.FormulaR1C1;

    LRange := LWorksheet.range['S'+IntToStr(LIdx)];
    LDoc.CompanyName2 := LRange.FormulaR1C1;

    LDoc.TaskID := 0;
    LDoc.FirstName := '';
    LDoc.Surname := '';
    LDoc.CompanyAddress := '';
    LDoc.Position := '';
    LDoc.AgentInfo := '';
    LCompanyTypes := [ctSubContractor];
    LDoc.CompanyTypes := TCompanyType_SetToInt(LCompanyTypes);

    if LWorksheet.Name = '조선' then
      LBusinessAreas := [baShip]
    else
    if LWorksheet.Name = '엔진' then
      LBusinessAreas := [baEngine]
    else
      LBusinessAreas := [baElectric];

    LDoc.BusinessAreas := TBusinessArea_SetToInt(LBusinessAreas);

    AddMasterCustomerFromVariant(LDoc);

    Inc(LIdx);
  end;

  LWorkBook.Close;
  LExcel.Quit;
end;

procedure ImportCustomerMasterFromMapsExportedXlsFile(AXlsFileName, ADBName: string; ASplashScreen: TAdvSmoothSplashScreen);
const
  CustomerDBColumnAry : array[0..35] of string =
    ('', 'CompanyCode', '', 'CompanyTypes2', 'CompanyName', 'CompanyName2', 'CompanyAddress', '',
     '', '', '', 'Nation', 'FirstName',
     '', 'MobilePhone', 'Position', 'OfficePhone', '',
     'URL', 'EMail', 'TaxID', 'BusinessCondition', 'BusinessSector',
     '', '', '', '', '',
     '', 'Status', 'ERPConfirm', '', 'RegisteredDate',
     '', 'ModifyDate', '');

  CustomerListExcelColumnAry : array[0..35] of string =
    ('', '코드', '거래처약어', '구분', '거래처명(한글)', '거래처명(영문)', '주소(한글)', '주소(영문)',
     '품질등급', '납품등급', '판매등급', '국가명', '대표자',
     '성별', 'PhoneNo(대표자)', '직위', 'TEL', 'FAX',
     'URL', 'E-MAIL', '사업자번호(TAX-ID)', '업태', '업종',
     '주요품목', '고객구분', '가격그룹', '유통경로', '납품조건',
     '지불조건', 'STATUS', '확정여부', '등록자', '등록일시',
     '수정자', '수정일시', 'HIPROCD');
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LRange: OleVariant;
  LWorksheet: OleVariant;
  LStr, LStr2, LColNoChar: string;
  i, LCol, LRow, LLastRow, LLastColumn: integer;
  LDoc: Variant;
  LExcelColumnList, LDBColumnIndexList: TStringList;

  procedure BuildColumnIndexList;
  var
    Li: integer;
    LColChar: string;
  begin
    LColChar := 'A';

    for Li := 1 to LLastColumn do
    begin
      LRange := LWorksheet.range[LColChar+'1'];
      LStr2 := LRange.FormulaR1C1;
      LCol := LExcelColumnList.IndexOf(LStr2);

      if LCol <> -1 then
      begin
        LColNoChar := GetExcelColumnAlphabetByInt(LCol+1);
        LDBColumnIndexList.AddObject(LColNoChar, TObject(LCol));
      end;

      LColChar := GetIncXLColumn(LColChar);
    end;
  end;
begin
  if not FileExists(AXlsFileName) then
  begin
    ShowMessage('File(' + AXlsFileName + ')이 존재하지 않습니다');
    exit;
  end;

  LExcel := GetActiveExcelOleObject(True);
  LWorkBook := LExcel.Workbooks.Open(AXlsFileName);
//  LExcel.Visible := true;
  LWorksheet := LExcel.ActiveSheet;
  LLastRow := GetLastRowNumFromExcel(LWorkSheet);
  LLastColumn := GetLastColNumFromExcel(LWorkSheet);
  TDocVariant.New(LDoc, [dvoReturnNullForUnknownProperty]);

//  LStr := 'A';

  LExcelColumnList := TStringList.Create;
  LDBColumnIndexList := TStringList.Create;
  InitCompanyMasterClient(ADBName);
  try
    for i := Low(CustomerListExcelColumnAry) to High(CustomerListExcelColumnAry) do
      LExcelColumnList.Add(CustomerListExcelColumnAry[i]);

    BuildColumnIndexList();

    for LRow := 2 to LLastRow do
    begin
      if Assigned(ASplashScreen) then
      begin
        ASplashScreen.BeginUpdate;
        ASplashScreen.BasicProgramInfo.ProgramName.Text := 'Importing Data from xls...(' + IntToStr(LRow) + '/' + IntToStr(LLastRow) + ')';
        ASplashScreen.ProgressBar.Position := LRow/LLastRow*100;
        ASplashScreen.EndUpdate;
        ASplashScreen.Show;
      end;

      for i := 0 to LDBColumnIndexList.Count - 1 do
      begin
        LColNoChar := LDBColumnIndexList.Strings[i];
        LRange := LWorksheet.range[LColNoChar+IntToStr(LRow)];
        LCol := Integer(LDBColumnIndexList.Objects[i]);

        if CustomerDBColumnAry[LCol] <> '' then
        begin
          LStr := LRange.FormulaR1C1;

//          if (CustomerDBColumnAry[LCol] = 'CompanyTypes') or
          if (CustomerDBColumnAry[LCol] = 'CompanyTypes2') then
            LStr := GetCommaStringFromSetOfIntValueByCompanyTypes2(LStr);

          TDocVariantData(LDoc).Value[CustomerDBColumnAry[LCol]] := LStr;
        end;
      end;//for

      LDoc.ShipTypeDesc := '';
      LDoc.UpdatedDate := TimeLogFromDateTime(now);

      AddOrUpdateMasterCustomerFromVariant(LDoc);
    end;//for
  finally
    LExcelColumnList.Free;
    LDBColumnIndexList.Free;

    if Assigned(ASplashScreen) then
      ASplashScreen.Hide;
  end;

  LWorkBook.Close;
  LExcel.Quit;
end;

end.
