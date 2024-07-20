unit UnitMakeReport2;

interface

uses Windows, Sysutils, Dialogs, Classes, System.Variants, DateUtils,
  mormot.core.variants, mormot.core.base, mormot.core.unicode, mormot.core.json,
  mormot.core.text, mormot.core.os,
  UnitExcelUtil, CommonData2, Word2010, Excel2010, UnitJHPFileData,
  UnitJHPFileRecord;

const
//  DOC_DIR = 'C:\Users\HGS\Documents\양식\';
//  DOC_DIR = '.\양식\';
  QTN_FILE_2_CUST_KOR = 'QUOTATION-KOR.xls';
  QTN_FILE_2_CUST_ENG = 'QUOTATION-ENG.xls';
  PO_FILE_2_SUBCON_KOR = '';
  PO_FILE_2_SUBCON_ENG = 'Service-Order.xlsx';
  INVOICE_FILE_2_CUST_KOR = 'INVOICE-KOR.xlsx';
  INVOICE_FILE_2_CUST_ENG = 'INVOICE-ENG.xlsx';
  INVOICE_FILE_SUBCON_SANISN = '업체청구서_SANISN.docx';
  INVOICE_FILE_SUBCON_LUXCO = '업체청구서_럭스코.xls';
  COMMERCIAL_INVOICE_FILE = 'COMMERCIAL-INVOICE-PACKING-LIST.xlsx';
  COMPANY_SELECTION_FILE = '업체선정품의서.xls';
  COMPANY_SELECTION_FILE1 = '업체선정품의서_단독업체.xls';
  COMPANY_SELECTION_FILE2 = '업체선정품의서_복수업체.xls';
  CONFIRM_COMPLETION_FILE = '공사완료확인서.xls';
  BUDGET_APPROVAL_FILE = '';
  CONTRACT_FILE = '';
  CUSTOMER_REG_ENG = 'Customer_Registration.xlsx';
  SUBCON_INVOICE_LIST_FILE = '외주용역비_인보이스_처리현황.xlsx';
  INVOICE_FILE_VDR_APT = 'Invoice_of_VDR_APT.ods';
  INVOICE_LIST_FILE_VDR_APT = 'InvoiceList_of_VDR_APT.ods'; //분기별 Invoice List를 정리한 파일
  INVOICE_FILE_LIST_NAME = 'c:\temp\VDR_APT_Invoice_List.txt';

  SALES_MUSTACHE_FILE_NAME = 'Mustache_매출요청메일.htm';
  INVOICE_SEND_MUSTACHE_FILE_NAME = 'Mustache_Invoice송부메일.htm';
  DIRECT_SHIPPING_MUSTACHE_FILE_NAME = 'Mustache_직투입요청메일.htm';
  FOREIGN_REG_MUSTACHE_FILE_NAME = 'Mustache_해외매출_고객사_거래처등록요청메일.htm';
  ELEC_HULLNO_REG_REQ_MUSTACHE_FILE_NAME = 'Mustache_전전_비표준공사_생성_요청메일.htm';
  PO_REQ_MUSTACHE_FILE_NAME = 'Mustache_PO요청메일.htm';
  VDR_APT_COC_KOR_SEND_MUSTACHE_FILE_NAME = 'Mustache_VDRAPT_SEND_COC_메일_KOR.htm';
  VDR_APT_COC_ENG_SEND_MUSTACHE_FILE_NAME = 'Mustache_VDRAPT_SEND_COC_메일_ENG.htm';
  VDR_APT_INVOICE_SEND_MUSTACHE_FILE_NAME = 'Mustache_VDRAPT_SEND_INVOICE_메일.htm';
  SHIPPING_MUSTACHE_FILE_NAME = 'Mustache_SHIPPING요청메일.htm';
  FORWARD_FIELDSERVICE_MUSTACHE_FILE_NAME = 'Mustache_FIELDSERVICE전달메일.htm';
  PAYCHECK_SUBCON_MUSTACHE_FILE_NAME = 'Mustache_기성확인요청메일.htm';
  SUBCON_QUOTATION_REQ_MUSTACHE_FILE_NAME = 'Mustache_업체견적요청메일.htm';
  SUBCON_PAYMENT_REQ_MUSTACHE_FILE_NAME = 'Mustache_기성처리요청메일.htm';
  SUBCON_SERVICE_ORDER_REQ_MUSTACHE_FILE_NAME = 'Mustache_서비스오더날인요청메일.htm';
  CIPL_FILE_NAME = 'CIPL_Template.ods';
  SHIPMARK_FILE_NAME = 'SHIPPINGMARK_Template.ods';
  RECEIPTACCEPT_FILE_NAME = 'ReceiptAccept_Template.ods';

  //HGS Invoice 작성시 Mustache에서 사용함
  INVOICE_ITEM_SE_CHARGE_WN = 'Service Engineering Charge' + #13#10 + '({{InvoiceItemDesc}} S/E, {{Qty}} WorkDay(s), USD1,310/day)';
  INVOICE_ITEM_SE_CHARGE_WOT = 'Service Engineering Charge' + #13#10 + '({{InvoiceItemDesc}} S/E, {{Qty}} WorkHours, USD220/hr)';
  INVOICE_ITEM_SE_CHARGE_HN = 'Service Engineering Charge' + #13#10 + '({{InvoiceItemDesc}} S/E, {{Qty}} WorkDay(s), USD1,850/day)';
  INVOICE_ITEM_SE_CHARGE_HOT = 'Service Engineering Charge' + #13#10 + '({{InvoiceItemDesc}} S/E, {{Qty}} WorkHours, USD330/hr)';
  INVOICE_ITEM_TRAVELLING_CHARGE = 'Travelling Charge' + #13#10 + '({{InvoiceItemDesc}} S/E, {{TravellingHours}} Hours, USD120/hr)';
  INVOICE_ITEM_FLIGHT_FEE = 'Flight Fee' + #13#10 + '(Actual Cost + Admin fee:15%)';
  INVOICE_ITEM_ACCOMMODATION_FEE = 'Accommodation Fee' + #13#10 + '(Actual Cost + Admin fee:15%)';
  INVOICE_ITEM_MATERIAL_CHARGE = 'Material' + #13#10 + '({{Material}})';
  INVOICE_ITEM_TRANSPORTATION_FEE = 'Transportation' + #13#10 + '({{Transportation}})';
  INVOICE_ITEM_MEAL_FEE = 'Meal' + #13#10 + '({{Meal}})';

  COMPANY_SELECTION_CONTENT = '   표제 호선의 작업을 위해 다음과 같이 업체 견적을 접수/검토 후 ';
  WORK_PERIOD_CHANGE_DESC = '※ Work schedule can be changed according to vessel schedule';

  //Email Action To OutLook (UnitStrategy4OLEmailInterface.Algorithm4EmailAction)
  ACTION_MakeEmailHTMLBody = 1;
  ACTION_MakeAttachFile = 2;

  MAILKIND_VDRAPT_REPLY_WITHMAKEZIP = 1; //Zip 파일 생성
  MAILKIND_VDRAPT_REPLY_WITHNOMAKEZIP = 2; //Zip 파일 생성하지 않고 파일명만 필요
  MAILKIND_VDRAPT_REPLY_IFZIPEXIST = 3; //c:\temp 폴더에 zip파일이 존재하지 않으면 생성
type
  Doc_Qtn_Rec = record
    FCustomerInfo, FQtnNo, FQtnDate, FHullNo, FShipName,
    FSubject, FProduceType, FPONo, FValidateDate: string;
  end;

//  Doc_Invoice_Rec = record
//    FCompanyCode, FCustomerInfo, FInvNo, FInvDate, FHullNo, FShipName,
//    FSubject, FProduceType, FPONo, FTotalPrice: string;
//    FOnboardDate: TDate;
//    FInvoiceItemList: TStringList;
//  end;

  Doc_Invoice_Item_Rec = record
    FItemType, FItemDesc, FQty, FFUnit, FUnitPrice, FTotalPrice: string;
  end;

  Doc_ServiceOrder_Rec = record
    FSubConName, FSubConManager, FSubConPhonNo, FSubConEmail, FHullNo, FShipName,
    FShipOwner, FSubject, FProduceType, FPONo2SubCon, FOrderDate, FWorkSch, FEngineerNo,
    FTechnicanNo, FLocalAgent, FWorkDesc, FProjCode, FCustomer, FWorkPeriod, FWorkDays,
    FNationPort, FWorkSummary, FSubConPrice, FManagerDepartment: string;
  end;

  Doc_Cust_Reg_Rec = record
    FCompanyName, FCountry, FTaxID, FCity, FCompanyAddress,
    FTelNo, FFaxNo, FEMailAddress: string;
  end;

  Doc_SubCon_Invoice_List_Rec = record
    FProjectCode, FHullNo, FClaimNo, FPONo, FPOIssueDate,
    FSubConName, FWorkFinishDate, FInvoiceIssueDate: string;
  end;

  Doc_SubCon_Invoice_List_Recs = array of Doc_SubCon_Invoice_List_Rec;

  //ALang: 1 = Eng, 2 = Kor
  procedure MakeDocQtn(AQtnR: Doc_Qtn_Rec; ALang: integer = 1);
  procedure MakeDocPO(ALang: integer=1);
  procedure MakeDocInvoice(AInvR: Doc_Invoice_Rec; ALang: integer=1);
  procedure MakeDocInvoice4VDRAPT(const AList: TStringList; AFileKind: TJHPFileFormat; ALang: integer=1);
  function MakeDocInvoice4VDRAPT_(ADoc_Invoice_Rec: Doc_Invoice_Rec; ACertList: TStringList;
    AFileKind: TJHPFileFormat; ALang: integer=1): string;
  procedure MakeDocInvoiceList4VDRAPT_(AInvoiceList: TStringList);
  procedure GetInvoiceItemRec(ADelimitedStr: string;
    var AItem: Doc_Invoice_Item_Rec);
  procedure MakeDocServiceOrder(ASOR: Doc_ServiceOrder_Rec);
  //ADocType = 1 : 단독업체, 2 : 복수업체
  procedure MakeDocCompanySelection(ASOR: Doc_ServiceOrder_Rec; ADocType: integer);
  procedure MakeDocConfirmComplete(ASOR: Doc_ServiceOrder_Rec);
  procedure MakeDocBudgetApproval;
  procedure MakeDocContract;

  //승선허가서
  procedure MakeDocBoardingPermit;
  procedure MakeDocCustomerRegistration(ACRR: Doc_Cust_Reg_Rec; ALang: integer=1);
  function MakeDocSubConInvoiceList: OleVariant;
  procedure MakeDocSubConInvoiceList2(AWorkSheet: OleVariant;
    ASIL: Doc_SubCon_Invoice_List_Rec; ARow: integer);

  //업체 Invoice 생성
  procedure MakeSubConInvoice(ACompanyName: string; ADoc_Invoice_Rec:Doc_Invoice_Rec);
  procedure MakeSubConInvoice_SANISN(ADoc_Invoice_Rec:Doc_Invoice_Rec);
  procedure MakeSubConInvoice_LUXCO(ADoc_Invoice_Rec:Doc_Invoice_Rec);

  //CIPL 생성
  procedure MakeCIPL(ACIPLRec: DOC_CIPL_Rec);
  procedure MakeShippingMark(AShipMarkRec: DOC_SHIPMARK_Rec);
  //인수증 출력
  procedure MakeReceiptAcceptance(ARectAcceptRec: DOC_RECEIPTACCPT_Rec);

  //Claim Info를 Json으로 반환 함
  function GetClaimInfoJsonFromReport_Xls(AXlsFileName: string): RawUtf8;
  //Outlook에서 Drag한 경우 File이 RawByteString으로 전달됨
  //Claim Info를 Json으로 반환 함
  function GetClaimInfoJsonFromXlsString(AXlsFile: RawByteString): RawUtf8;

  //힘센엔진 견적서
var
  DOC_DIR: string;

implementation

uses UnitStringUtil, UnitStreamUtil,
  UnitHiconisASVarJsonUtil,
  UnitElecServiceData2, UnitDateUtil,
  UnitGSTariffRecord2, UnitGSTriffData;

procedure MakeDocQtn(AQtnR: Doc_Qtn_Rec; ALang: integer = 1);
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LRange: OleVariant;
  LWorksheet: OleVariant;
  LFileName: string;
begin
  if ALang = 1 then
    LFileName := QTN_FILE_2_CUST_ENG
  else
    LFileName := QTN_FILE_2_CUST_KOR;

//  LFileName := '"' + DOC_DIR + LFileName + '"';
  LFileName := DOC_DIR + LFileName;

//  ShowMessage(GetCurrentDir);

  if not FileExists(LFileName) then
  begin
    ShowMessage('File(' + LFileName + ')이 존재하지 않습니다');
    exit;
  end;

  LExcel := GetActiveExcelOleObject(True);
  LWorkBook := LExcel.Workbooks.Open(LFileName);
  LExcel.Visible := true;
//  LExcel.ActiveWindow.Zoom := 100;
//  LWorkbook.Sheets['Sheet1'].Activate;
  LWorksheet := LExcel.ActiveSheet;

  LRange := LWorksheet.range['D10'];
  LRange.FormulaR1C1 := AQtnR.FCustomerInfo;
  LRange := LWorksheet.range['AL7'];
  LRange.FormulaR1C1 := AQtnR.FQtnNo;
  LRange := LWorksheet.range['AF9'];
  LRange.FormulaR1C1 := AQtnR.FQtnDate;
  LRange := LWorksheet.range['L19'];
  LRange.FormulaR1C1 := AQtnR.FHullNo;
  LRange := LWorksheet.range['AK19'];
  LRange.FormulaR1C1 := AQtnR.FShipName;
  LRange := LWorksheet.range['L21'];
  LRange.FormulaR1C1 := AQtnR.FSubject;
  LRange := LWorksheet.range['AK21'];
  LRange.FormulaR1C1 := AQtnR.FProduceType;
  LRange := LWorksheet.range['L22'];
  LRange.FormulaR1C1 := AQtnR.FPONo;
  LRange := LWorksheet.range['N32'];
  LRange.FormulaR1C1 := AQtnR.FValidateDate;
end;

procedure MakeDocPO(ALang: integer);
begin

end;

procedure MakeDocInvoice(AInvR: Doc_Invoice_Rec; ALang: integer);
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LRange: OleVariant;
  LWorksheet: OleVariant;
  LFileName, LStr, LRangeStr: string;
  LStrList: TStringList;
  i,j, LRow: integer;
  LDoc : variant;
//  LItem: Doc_Invoice_Item_Rec;
begin
  if ALang = 1 then
    LFileName := INVOICE_FILE_2_CUST_ENG
  else
    LFileName := INVOICE_FILE_2_CUST_KOR;

  LFileName := DOC_DIR + LFileName;

  if not FileExists(LFileName) then
  begin
    ShowMessage('File(' + LFileName + ')이 존재하지 않습니다');
    exit;
  end;

  LExcel := GetActiveExcelOleObject(True);
  LWorkBook := LExcel.Workbooks.Open(LFileName);
  LExcel.Visible := true;
  LWorksheet := LExcel.ActiveSheet;

  LRange := LWorksheet.range['A8'];
  LRange.FormulaR1C1 := AInvR.FCustomerInfo;
  LRange := LWorksheet.range['I5'];
  LRange.FormulaR1C1 := 'Invoice : ' + AInvR.FInvNo;
//  LRange := LWorksheet.range['AF9'];
//  LRange.FormulaR1C1 := AInvR.FInvDate;
  LRange := LWorksheet.range['D21'];
  LRange.FormulaR1C1 := AInvR.FHullNo;
  LRange := LWorksheet.range['K21'];
  LRange.FormulaR1C1 := AInvR.FShipName;
  LRange := LWorksheet.range['D22'];
  LRange.FormulaR1C1 := AInvR.FSubject;
  LRange := LWorksheet.range['K22'];
  LRange.FormulaR1C1 := AInvR.FProduceType;
  LRange := LWorksheet.range['D23'];
  LRange.FormulaR1C1 := AInvR.FPONo;

  if Assigned(AInvR.FInvoiceItemList) then
  begin
    LStrList := TStringList.Create;
    LStrList.StrictDelimiter := True;
    LStrList.Delimiter := ';';
    try
      LRow := 27;
      TDocVariant.New(LDoc);

      for i := 0 to AInvR.FInvoiceItemList.Count - 1 do
      begin
//        LStrList.Text := AInvR.FInvoiceItemList.Strings[i];
//        for j := 0 to LStrList.Count - 1 do
//        begin
        LStr := AInvR.FInvoiceItemList.Strings[i];
        GetInvoiceItem2Var(LStr, LDoc);
        LStr := MakeInvoiceItemFromVar(LDoc);

        if LRow > 27 then
        begin
          LRangeStr := 'A' + IntToStr(LRow-1) + ':M' + IntToStr(LRow-1);
          LRange := LWorksheet.range[LRangeStr];//['A27:M27']
          LRange.Copy;
          LRangeStr := 'A' + IntToStr(LRow) + ':M' + IntToStr(LRow);
          LRange := LWorksheet.range[LRangeStr];//'A28:M28'];
          LRange.Insert;
          LRange := LWorkSheet.Rows[LRow];
          LRange.RowHeight := 25;
        end;

        //No.
        LRangeStr := 'A' + IntToStr(LRow);
        LRange := LWorksheet.range[LRangeStr];
        LRange.FormulaR1C1 := IntToStr(LRow-27+1);
        //Description.
        LRangeStr := 'B' + IntToStr(LRow);
        LRange := LWorksheet.range[LRangeStr];
        LRange.FormulaR1C1 := LStr;
        //Qty.
        LRangeStr := 'H' + IntToStr(LRow);
        LRange := LWorksheet.range[LRangeStr];
        LStr := LDoc.Qty;
        LRange.FormulaR1C1 := LStr;
        //Unit.
        LRangeStr := 'I' + IntToStr(LRow);
        LRange := LWorksheet.range[LRangeStr];
//        LStr := LDoc.FUnit;
        LRange.FormulaR1C1 := 'SET';
        //Unit Price.
        LRangeStr := 'K' + IntToStr(LRow);
        LRange := LWorksheet.range[LRangeStr];
        LStr := LDoc.UnitPrice;
        LRange.FormulaR1C1 := LStr;
        //Unit Price.
        LRangeStr := 'L' + IntToStr(LRow);
        LRange := LWorksheet.range[LRangeStr];
        LStr := LDoc.TotalPrice;
        LRange.FormulaR1C1 := LStr;

        inc(LRow);
//        end;
      end;
    finally
      LStrList.Free;
    end;
  end;
end;

procedure MakeDocInvoice4VDRAPT(const AList: TStringList; AFileKind: TJHPFileFormat; ALang: integer=1);
var
  i, j, LCount, LCount2, LMonth, LPrice: integer;
  LStrList, LCertList, LCreatedFileList, LInvoiceListPerCompany: TStringList;
  LUtf8: RawUTF8;
  LDoc_Invoice_Rec: Doc_Invoice_Rec;
  LStr, LQty, LFileName, LCompanyName: string;
begin
  LCertList := TStringList.Create;
  LCreatedFileList := TStringList.Create;
  LInvoiceListPerCompany := TStringList.Create;
  try
    LCount := AList.Count;

    for i := 0 to LCount - 1 do
    begin
      LStrList := AList.Objects[i] as TStringList;
      LCount2 := LStrList.Count;
      LCertList.Clear;

      for j := 0 to LCount2 - 1 do
      begin
        LDoc_Invoice_Rec := Default(Doc_Invoice_Rec);
        LUtf8 := StringToUTF8(LStrList.Strings[j]);
        RecordLoadJSON(LDoc_Invoice_Rec, LUtf8, TypeInfo(Doc_Invoice_Rec));
        LMonth := MonthOf(LDoc_Invoice_Rec.FOnboardDate);
        LStr := '(' + IntToStr(j+1) + ') Cert. No.: ' +LDoc_Invoice_Rec.FSubject +
          ', Ship Name: ' + LDoc_Invoice_Rec.FShipName +
          '(' + LDoc_Invoice_Rec.FHullNo + '),' +
          'APT Date: ' + pjhShortMonthNames[LMonth] + '.' +
          FormatDateTime('dd, yyyy', LDoc_Invoice_Rec.FOnboardDate);
        LCertList.Add(LStr);
      end;

      LQty := IntToStr(LCount2);
      LPrice := GetGSServiceRate('0001056374',
        YearOf(LDoc_Invoice_Rec.FOnboardDate),
        gswtVDRAPTCert);
      LDoc_Invoice_Rec.FTotalPrice := IntToStr(LPrice);
      LFileName := MakeDocInvoice4VDRAPT_(LDoc_Invoice_Rec, LCertList, AFileKind);
      LCreatedFileList.Add(LFileName);

      LDoc_Invoice_Rec.FTotalPrice := IntToStr(LPrice*LCount2);
      LUtf8 := RecordSaveJson(LDoc_Invoice_Rec, TypeInfo(Doc_Invoice_Rec));
      LInvoiceListPerCompany.Add(Utf8ToString(LUtf8));
    end;//for

    MakeDocInvoiceList4VDRAPT_(LInvoiceListPerCompany);
    ShowMessage(LCreatedFileList.Text);
    LCreatedFileList.SaveToFile(INVOICE_FILE_LIST_NAME);
  finally
    LInvoiceListPerCompany.Free;
    LCreatedFileList.Free;
    LCertList.Free;
  end;
end;

function MakeDocInvoice4VDRAPT_(ADoc_Invoice_Rec: Doc_Invoice_Rec; ACertList: TStringList;
  AFileKind: TJHPFileFormat; ALang: integer=1): string;
var
  LExcel: TExcelApplication;
  LWorkBook: _WorkBook;
  LWorksheet: _Worksheet;
  LRange: OleVariant;
  LFileName, LQty,
  LExcelFileName, LInvNo: string;
  LERow,i: integer;
  LCID: cardinal;
begin
  LFileName := DOC_DIR + INVOICE_FILE_VDR_APT;

  if not FileExists(LFileName) then
  begin
    ShowMessage('File(' + LFileName + ')이 존재하지 않습니다');
    exit;
  end;

  LExcelFileName := 'c:\temp\' + ExtractFileName(LFileName);

  //CopyFile시에 제한된 보기로 설정되어 진행 불가 함
//  if not CopyFile(LFileName, LExcelFileName, False) then
//  begin
//    ShowMessage('Failure Copy File : ' + LFileName + ' -> ' + LExcelFileName);
//    exit;
//  end;

  LCID := GetUserDefaultLCID;

  LExcel := TExcelApplication.Create(nil);
  LExcel.Connect;
  LWorkBook := LExcel.Workbooks.Open(LFileName,
    EmptyParam, EmptyParam, EmptyParam, EmptyParam,
    EmptyParam, EmptyParam, EmptyParam, EmptyParam,
    EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,LCID
    );

//  LWorkBook.SaveCopyAs(LExcelFileName, LCID);

//  if AFileKind = gfkEXCEL then
//    LExcel.Visible[LCID] := true;

//  LWorkBook.SaveAs(LExcelFileName, xlWorkBookNormal,
//    EmptyParam, EmptyParam, EmptyParam, EmptyParam,
//    xlExclusive, xlUserResolution, EmptyParam, EmptyParam,
//    EmptyParam, EmptyParam, LCID
//    );
//  LWorkBook.Close(False,EmptyParam,EmptyParam,LCID);
//  LWorkBook := LExcel.Workbooks.Open(LExcelFileName,
//    EmptyParam, EmptyParam, EmptyParam, EmptyParam,
//    EmptyParam, EmptyParam, EmptyParam, EmptyParam,
//    EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,LCID
//    );

  LWorksheet := LWorkBook.ActiveSheet as _Worksheet;
  LERow := 34;
  LQty := IntToStr(ACertList.Count);

  LRange := LWorksheet.range['K5','K5'];
  LRange.FormulaR1C1 := ADoc_Invoice_Rec.FInvNo;
  LInvNo := ADoc_Invoice_Rec.FInvNo;
  LInvNo := LInvNo + '(' + ADoc_Invoice_Rec.FCompanyName + ')';
  LRange := LWorksheet.range['I6','I6'];
  LRange.FormulaR1C1 := 'Date: ' + ADoc_Invoice_Rec.FInvDate;
  LRange := LWorksheet.range['A8','A8'];
  LRange.FormulaR1C1 := ADoc_Invoice_Rec.FCustomerInfo;
  LRange := LWorksheet.range['H28','H28'];
  LRange.FormulaR1C1 := LQty;
  LRange := LWorksheet.range['K28','K28'];
  LRange.FormulaR1C1 := ADoc_Invoice_Rec.FTotalPrice;

  for i := 0 to ACertList.Count - 1 do
  begin
    LRange := LWorksheet.range['A34','M34'];
    LRange.Copy;
    Inc(LERow);
    LRange := LWorksheet.range['A'+IntToStr(LERow),'M'+IntToStr(LERow)];
    LRange.Insert;
    LRange := LWorksheet.range['A'+IntToStr(LERow),'A'+IntToStr(LERow)];
    LRange.FormulaR1C1 := ACertList.Strings[i];//' (' + IntToStr(i+1) + ') ' +
  end;

  if AFileKind = gfkEXCEL then
  begin
    Result := GetDefaultInvoiceFileName(gfkEXCEL, LInvNo);
    LWorkBook.SaveAs(Result, xlOpenDocumentSpreadsheet,//xlWorkBookNormal,
      EmptyParam, EmptyParam, EmptyParam, EmptyParam,
      xlExclusive, xlUserResolution, EmptyParam, EmptyParam,
//      xlNoChange, xlUserResolution, EmptyParam, EmptyParam,
      EmptyParam, EmptyParam, LCID
      );

  end
  else
  begin
    Result := GetDefaultInvoiceFileName(gfkPDF, LInvNo);
    LWorksheet.ExportAsFixedFormat(xlTypePdf, Result,
      xlQualityStandard, True, False, EmptyParam, EmptyParam, True, EmptyParam);
  end;

  LWorkBook.Close(False,EmptyParam,EmptyParam,LCID);
  LExcel.Quit;
  LExcel.DisConnect;
  FreeAndNil(LExcel);
end;

procedure MakeDocInvoiceList4VDRAPT_(AInvoiceList: TStringList);
var
  LExcel: TExcelApplication;
  LWorkBook: _WorkBook;
  LWorksheet: _Worksheet;
  LRange: OleVariant;
  LFileName, LExcelFileName, LRangeStr: string;
  LDoc_Invoice_Rec: Doc_Invoice_Rec;
  LERow,i: integer;
  LCID: cardinal;
  LUtf8: RawUTF8;
begin
  LFileName := DOC_DIR + INVOICE_LIST_FILE_VDR_APT;

  if not FileExists(LFileName) then
  begin
    ShowMessage('File(' + LFileName + ')이 존재하지 않습니다');
    exit;
  end;

  LExcelFileName := 'c:\temp\' + ExtractFileName(LFileName);

  LCID := GetUserDefaultLCID;

  LExcel := TExcelApplication.Create(nil);
  LExcel.Connect;
  LWorkBook := LExcel.Workbooks.Open(LFileName,
    EmptyParam, EmptyParam, EmptyParam, EmptyParam,
    EmptyParam, EmptyParam, EmptyParam, EmptyParam,
    EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,LCID
    );

  LWorksheet := LWorkBook.ActiveSheet as _Worksheet;
  LERow := 2;

  for i := 0 to AInvoiceList.Count - 1 do
  begin
    LDoc_Invoice_Rec := Default(Doc_Invoice_Rec);
    LUtf8 := StringToUTF8(AInvoiceList.Strings[i]);
    RecordLoadJSON(LDoc_Invoice_Rec, LUtf8, TypeInfo(Doc_Invoice_Rec));

    LRangeStr := 'A'+IntToStr(LERow);
    LRange := LWorksheet.range[LRangeStr,LRangeStr];
    LRange.FormulaR1C1 := LDoc_Invoice_Rec.FCompanyName;

    LRangeStr := 'B'+IntToStr(LERow);
    LRange := LWorksheet.range[LRangeStr,LRangeStr];
    LRange.FormulaR1C1 := LDoc_Invoice_Rec.FCompanyCode;

    LRangeStr := 'D'+IntToStr(LERow);
    LRange := LWorksheet.range[LRangeStr,LRangeStr];
    LRange.FormulaR1C1 := LDoc_Invoice_Rec.FTotalPrice;
    Inc(LERow);
  end;

  LWorkBook.SaveAs(LExcelFileName, xlOpenDocumentSpreadsheet,//xlWorkBookNormal,
    EmptyParam, EmptyParam, EmptyParam, EmptyParam,
    xlExclusive, xlUserResolution, EmptyParam, EmptyParam,
    EmptyParam, EmptyParam, LCID
    );
  LWorkBook.Close(False,EmptyParam,EmptyParam,LCID);
  LExcel.Quit;
  LExcel.DisConnect;
  FreeAndNil(LExcel);
end;

procedure GetInvoiceItemRec(ADelimitedStr: string;
  var AItem: Doc_Invoice_Item_Rec);
begin
  AItem.FItemType := strToken(ADelimitedStr, ';');
  AItem.FItemDesc := strToken(ADelimitedStr, ';');
  AItem.FQty := strToken(ADelimitedStr, ';');
  AItem.FFUnit := strToken(ADelimitedStr, ';');
  AItem.FUnitPrice := strToken(ADelimitedStr, ';');
  AItem.FTotalPrice := strToken(ADelimitedStr, ';');
end;

procedure MakeDocServiceOrder(ASOR: Doc_ServiceOrder_Rec);
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LRange: OleVariant;
  LWorksheet: OleVariant;
  LFileName: string;
begin
  LFileName := DOC_DIR + PO_FILE_2_SUBCON_ENG;

  if not FileExists(LFileName) then
  begin
    ShowMessage('File(' + LFileName + ')이 존재하지 않습니다');
    exit;
  end;

  LExcel := GetActiveExcelOleObject(True);
  LWorkBook := LExcel.Workbooks.Open(LFileName);
  LExcel.Visible := true;
  LWorksheet := LExcel.ActiveSheet;

  LRange := LWorksheet.range['E4'];
  LRange.FormulaR1C1 := ASOR.FSubConName;
  LRange := LWorksheet.range['E5'];
  LRange.FormulaR1C1 := ASOR.FSubConManager;
  LRange := LWorksheet.range['E6'];
  LRange.FormulaR1C1 := ASOR.FSubConPhonNo;
  LRange := LWorksheet.range['E7'];
  LRange.FormulaR1C1 := ASOR.FSubConEmail;
  LRange := LWorksheet.range['K8'];
  LRange.FormulaR1C1 := ASOR.FHullNo;
  LRange := LWorksheet.range['K9'];
  LRange.FormulaR1C1 := ASOR.FShipName;
  LRange := LWorksheet.range['E11'];
  LRange.FormulaR1C1 := ASOR.FSubject;
  LRange := LWorksheet.range['K10'];
  LRange.FormulaR1C1 := ASOR.FShipOwner;
  LRange := LWorksheet.range['W10'];
  LRange.FormulaR1C1 := ASOR.FProduceType;
  LRange := LWorksheet.range['S6'];
  LRange.FormulaR1C1 := ASOR.FOrderDate;
  LRange := LWorksheet.range['S7'];
  LRange.FormulaR1C1 := ASOR.FPONo2SubCon;
  LRange := LWorksheet.range['E13'];
  LRange.FormulaR1C1 := ASOR.FWorkSch + #13#10 + WORK_PERIOD_CHANGE_DESC;
  LRange := LWorksheet.range['X13'];
  LRange.FormulaR1C1 := ASOR.FEngineerNo;
  LRange := LWorksheet.range['S17'];
  LRange.FormulaR1C1 := ASOR.FLocalAgent;
  LRange := LWorksheet.range['E23'];
  LRange.FormulaR1C1 := ASOR.FWorkDesc;
end;

procedure MakeDocCompanySelection(ASOR: Doc_ServiceOrder_Rec; ADocType: integer);
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LRange: OleVariant;
  LWorksheet: OleVariant;
  LFileName, LStr: string;
begin
  if ADocType = 1 then
    LFileName := DOC_DIR + COMPANY_SELECTION_FILE1
  else
  if ADocType = 2 then
    LFileName := DOC_DIR + COMPANY_SELECTION_FILE2;

  if not FileExists(LFileName) then
  begin
    ShowMessage('File(' + LFileName + ')이 존재하지 않습니다');
    exit;
  end;

  LExcel := GetActiveExcelOleObject(True);
  LWorkBook := LExcel.Workbooks.Open(LFileName);
  LExcel.Visible := true;
  LWorksheet := LExcel.ActiveSheet;

  LRange := LWorksheet.range['C4'];
  LRange.FormulaR1C1 := FormatDateTime('YYYY.MM.DD', now);
//  LRange := LWorksheet.range['C11']; //부서명
//  LRange.FormulaR1C1 := ASOR.;
  LRange := LWorksheet.range['C47']; //제목
  LRange.FormulaR1C1 := ASOR.FHullNo + ' ' + ASOR.FShipName + ' - ' + ASOR.FSubject;
//  LRange := LWorksheet.range['A49'];
//  LStr := COMPANY_SELECTION_CONTENT + ASOR.FSubConName + '를 선정하여';
//  LRange.FormulaR1C1 := LStr;
  LRange := LWorksheet.range['A52'];
  LRange.FormulaR1C1 := '   1. 선정 업체 : ' + ASOR.FSubConName;
  LRange := LWorksheet.range['A58'];
  LStr := '   3. 고객(공사코드) : ' + ASOR.FCustomer + ' ( ' + ASOR.FProjCode + ' ) ';
  LRange.FormulaR1C1 := LStr;
  LRange := LWorksheet.range['A59'];
  LRange.FormulaR1C1 := '   4. 작업 일정(작업장소) : ' + ASOR.FWorkPeriod + ' ( ' + ASOR.FWorkDays + ' 일), ' + ASOR.FNationPort;
  LRange := LWorksheet.range['A60'];
  LRange.FormulaR1C1 := '   5. 작업 내용 : ' + ASOR.FWorkSummary;
  LRange := LWorksheet.range['A61'];
  LRange.FormulaR1C1 := '   6. 기타 : 1) 작업인원 (' + ASOR.FEngineerNo + '명)';
  LRange := LWorksheet.range['A62'];
  LRange.FormulaR1C1 := '             2) Service Tariff에 의거 정산 예정';
  LWorksheet := LExcel.WorkSheets.Item['Sheet1'];
  LRange := LWorksheet.range['C4'];
  LRange.FormulaR1C1 := ASOR.FSubConName;
  LRange := LWorksheet.range['H4'];
  LRange.FormulaR1C1 := ASOR.FSubConPrice;
end;

procedure MakeDocConfirmComplete(ASOR: Doc_ServiceOrder_Rec);
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LRange: OleVariant;
  LWorksheet: OleVariant;
  LFileName, LStr: string;
begin
  LFileName := DOC_DIR + CONFIRM_COMPLETION_FILE;

  if not FileExists(LFileName) then
  begin
    ShowMessage('File(' + LFileName + ')이 존재하지 않습니다');
    exit;
  end;

  LExcel := GetActiveExcelOleObject(True);
  LWorkBook := LExcel.Workbooks.Open(LFileName);
  LExcel.Visible := true;
  LWorksheet := LExcel.ActiveSheet;

  LRange := LWorksheet.range['E8'];
  LRange.FormulaR1C1 := ASOR.FWorkSummary;
  LRange := LWorksheet.range['E9'];
  LRange.FormulaR1C1 := ASOR.FSubConName;
  LRange := LWorksheet.range['E10'];
  LRange.FormulaR1C1 := ASOR.FSubConPrice;
  LRange := LWorksheet.range['A24'];
  LRange.FormulaR1C1 := FormatDateTime('YYYY년 MM월 DD일', now);
end;

procedure MakeDocBudgetApproval;
begin

end;

procedure MakeDocContract;
begin

end;

procedure MakeDocBoardingPermit;
begin

end;

procedure MakeDocCustomerRegistration(ACRR: Doc_Cust_Reg_Rec; ALang: integer);
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LRange: OleVariant;
  LWorksheet: OleVariant;
  LFileName, LStr: string;
begin
  LFileName := DOC_DIR + CUSTOMER_REG_ENG;

  if not FileExists(LFileName) then
  begin
    ShowMessage('File(' + LFileName + ')이 존재하지 않습니다');
    exit;
  end;

  LExcel := GetActiveExcelOleObject(True);
  LWorkBook := LExcel.Workbooks.Open(LFileName);
  LExcel.Visible := true;
  LWorksheet := LExcel.ActiveSheet;

  LRange := LWorksheet.range['F9'];
  LRange.FormulaR1C1 := ACRR.FCompanyName;
  LRange := LWorksheet.range['J9'];
  LRange.FormulaR1C1 := ACRR.FCountry;
  LRange := LWorksheet.range['J11'];
  LRange.FormulaR1C1 := ACRR.FCity;
  LRange := LWorksheet.range['F12'];
  LRange.FormulaR1C1 := ACRR.FCompanyAddress;
  LRange := LWorksheet.range['G13'];
  LRange.FormulaR1C1 := ACRR.FTelNo;
  LRange := LWorksheet.range['J13'];
  LRange.FormulaR1C1 := ACRR.FFaxNo;
  LRange := LWorksheet.range['J14'];
  LRange.FormulaR1C1 := ACRR.FEMailAddress;
end;

function MakeDocSubConInvoiceList: OleVariant;
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LRange: OleVariant;
  LWorksheet: OleVariant;
  LFileName, LStr: string;
begin
  LFileName := DOC_DIR + SUBCON_INVOICE_LIST_FILE;

  if not FileExists(LFileName) then
  begin
    ShowMessage('File(' + LFileName + ')이 존재하지 않습니다');
    exit;
  end;

  LExcel := GetActiveExcelOleObject(True);
  LWorkBook := LExcel.Workbooks.Open(LFileName);
  LExcel.Visible := true;
  LWorksheet := LExcel.ActiveSheet;

  LRange := LWorksheet.range['A1'];
  LRange.FormulaR1C1 := FormatDateTime('YY년 M월', now) + ' 외주 용역비 인보이스 처리 현황';
  LRange := LWorksheet.range['M3'];
  LRange.FormulaR1C1 := FormatDateTime('YYYY.MM.DD', now);
  LRange := LWorksheet.range['A3'];
  LRange.FormulaR1C1 := '[부품기술영업부]';

  Result := LWorkSheet;
end;

procedure MakeDocSubConInvoiceList2(AWorkSheet: OleVariant;
  ASIL: Doc_SubCon_Invoice_List_Rec; ARow: integer);
var
  LRange: OleVariant;
  LWorksheet: OleVariant;
  LStr: OleVariant;
begin
  LStr := IntToStr(ARow);
  LRange := AWorkSheet.range['B'+LStr];
  LRange.FormulaR1C1 := '부품서비스2팀';
  LRange := AWorkSheet.range['C'+LStr];
  LRange.FormulaR1C1 := '박정현';
  LRange := AWorkSheet.range['D'+LStr];
  LRange.FormulaR1C1 := ASIL.FProjectCode;
  LRange := AWorkSheet.range['E'+LStr];
  LRange.FormulaR1C1 := ASIL.FHullNo;
  LRange := AWorkSheet.range['G'+LStr];
  LRange.FormulaR1C1 := ASIL.FPONo;
  LRange := AWorkSheet.range['H'+LStr];
  LRange.FormulaR1C1 := ASIL.FPOIssueDate;
  LRange := AWorkSheet.range['I'+LStr];
  LRange.FormulaR1C1 := ASIL.FSubConName;
  LRange := AWorkSheet.range['J'+LStr];
  LRange.FormulaR1C1 := ASIL.FWorkFinishDate;
  LRange := AWorkSheet.range['K'+LStr];
  LRange.FormulaR1C1 := ASIL.FInvoiceIssueDate;
end;

procedure MakeSubConInvoice(ACompanyName: string; ADoc_Invoice_Rec:Doc_Invoice_Rec);
begin
  if ACompanyName = 'SANISN' then
    MakeSubConInvoice_SANISN(ADoc_Invoice_Rec)
  else
  if ACompanyName = '럭스코' then
    MakeSubConInvoice_LUXCO(ADoc_Invoice_Rec);
end;

procedure MakeSubConInvoice_SANISN(ADoc_Invoice_Rec:Doc_Invoice_Rec);
var
  wordApp : Word2010._Application;
  doc : WordDocument;
  LSections: Sections;
  LSection: Section;
  LHeaders: HeadersFooters;
  LHeader: HeaderFooter;
  LTable: Table;
  LCell: Cell;
  LFields: Fields;
  LField: Field;
  filename : OleVariant;
  i, LTotalPrice, LTotalPrice2, LQty, LNumOfWorker: integer;
  LStr,LStr2: string;
  LDoc: Variant;
begin
  filename := DOC_DIR + INVOICE_FILE_SUBCON_SANISN;
  try
    wordApp := Word2010.CoWordApplication.Create;
    wordApp.visible := True;

    doc := wordApp.documents.open( filename, emptyparam,emptyparam,emptyparam,
      emptyparam,emptyparam,emptyparam,emptyparam,
      emptyparam,emptyparam,emptyparam,emptyparam,
      emptyparam,emptyparam,emptyparam,emptyparam );

//    for i := 1 to doc.Tables.Count do
//    begin
    LTable := doc.Tables.Item(1);
    LCell := LTable.Cell(1,1);
    LCell.Range.Text := 'Invoice To: ' + ADoc_Invoice_Rec.FShipName + ' (' + ADoc_Invoice_Rec.FHullNo + ')';

    LTable := doc.Tables.Item(2);
    LCell := LTable.Cell(2,2);
    LCell.Range.Text := ADoc_Invoice_Rec.FPONo;
    LCell := LTable.Cell(2,4);
    LCell.Range.Text := FormatDateTime('dd-mmmm-yyyy',now);
    LCell := LTable.Cell(5,4);
    LCell.Range.Text := FormatDateTime('dd-mmmm-yyyy',ADoc_Invoice_Rec.FOnboardDate);

    TDocVariant.New(LDoc);

    for i := 0 to ADoc_Invoice_Rec.FInvoiceItemList.Count - 1 do
    begin
      LStr := ADoc_Invoice_Rec.FInvoiceItemList.Strings[i];
      GetInvoiceItem2Var(LStr, LDoc);
      LTotalPrice := StrToIntDef(LDoc.TotalPrice,0);
      LQty := StrToIntDef(LDoc.Qty,0);
      LNumOfWorker := StrToIntDef(LDoc.InvoiceItemDesc,1);

      if LDoc.InvoiceItemType = g_GSInvoiceItemType.ToString(iitMaterials) then
      begin
        LTable := doc.Tables.Item(3);
        LCell := LTable.Cell(12,3);
        LCell.Range.Text := LDoc.InvoiceItemDesc;  //자재 desc
        LCell := LTable.Cell(12,4);
        LCell.Range.Text := IntToStr(LQty);
        LCell := LTable.Cell(12,5);
        LCell.Range.Text := LDoc.UnitPrice;
        LCell := LTable.Cell(12,6);
        LCell.Range.Text := IntToStr(LTotalPrice);
      end
      else
      if LDoc.InvoiceItemType = g_GSInvoiceItemType.ToString(iitWork_Week_N) then
      begin
        LTable := doc.Tables.Item(3);
        LCell := LTable.Cell(3,6);
        LCell.Range.Text := IntToStr(LQty * LNumOfWorker);  //Normal work Qty
        LCell := LTable.Cell(3,7);
        LCell.Range.Text := LDoc.UnitPrice;
        LCell := LTable.Cell(3,8);
        LCell.Range.Text := IntToStr(LTotalPrice);
      end
      else
      if LDoc.InvoiceItemType = g_GSInvoiceItemType.ToString(iitWork_Holiday_N) then
      begin
        LTable := doc.Tables.Item(3);
        LCell := LTable.Cell(4,6);
        LCell.Range.Text := IntToStr(LQty * LNumOfWorker);  //Holiday work Qty
        LCell := LTable.Cell(4,7);
        LCell.Range.Text := LDoc.UnitPrice;
        LCell := LTable.Cell(4,8);
        LCell.Range.Text := IntToStr(LTotalPrice);
      end
      else
      if LDoc.InvoiceItemType = g_GSInvoiceItemType.ToString(iitTravellingHours) then
      begin
        LTable := doc.Tables.Item(3);
        LCell := LTable.Cell(5,4);
        LCell.Range.Text := IntToStr(LQty * LNumOfWorker);  //Travelling Qty
        LCell := LTable.Cell(5,5);
        LCell.Range.Text := LDoc.UnitPrice;
        LCell := LTable.Cell(5,6);
        LCell.Range.Text := IntToStr(LTotalPrice);
      end
      else
      if LDoc.InvoiceItemType = g_GSInvoiceItemType.ToString(iitAirFare) then
      begin
        LTable := doc.Tables.Item(3);
        LCell := LTable.Cell(7,6);
        LCell.Range.Text := IntToStr(LQty);  //Air Fare Qty
        LCell := LTable.Cell(7,7);
        LCell.Range.Text := LDoc.UnitPrice;
        LCell := LTable.Cell(7,8);
        LCell.Range.Text := IntToStr(LTotalPrice);
      end
      else
      if LDoc.InvoiceItemType = g_GSInvoiceItemType.ToString(iitAccommodation) then
      begin
        LTable := doc.Tables.Item(3);
        LCell := LTable.Cell(10,6);
        LCell.Range.Text := IntToStr(LQty);  //Accommodation Qty
        LCell := LTable.Cell(10,7);
        LCell.Range.Text := LDoc.UnitPrice;
        LCell := LTable.Cell(10,8);
        LCell.Range.Text := IntToStr(LTotalPrice);
      end
      else
      if LDoc.InvoiceItemType = g_GSInvoiceItemType.ToString(iitTransportation) then
      begin
        LTable := doc.Tables.Item(3);
        LCell := LTable.Cell(9,6);
        LCell.Range.Text := IntToStr(LQty);  //Transportation Qty
        LCell := LTable.Cell(9,7);
        LCell.Range.Text := LDoc.UnitPrice;
        LCell := LTable.Cell(9,8);
        LCell.Range.Text := IntToStr(LTotalPrice);
      end
      else
      if LDoc.InvoiceItemType = g_GSInvoiceItemType.ToString(iitMeal) then
      begin
        LTable := doc.Tables.Item(3);
        LCell := LTable.Cell(11,6);
        LCell.Range.Text := IntToStr(LQty);  //Meal Qty
        LCell := LTable.Cell(11,7);
        LCell.Range.Text := LDoc.UnitPrice;
        LCell := LTable.Cell(11,8);
        LCell.Range.Text := IntToStr(LTotalPrice);
      end
      else
      if LDoc.InvoiceItemType = g_GSInvoiceItemType.ToString(iitEtc) then
      begin

      end;
    end;

  LTable := doc.Tables.Item(3);
  LCell := LTable.Cell(13,2);
  LCell.Range.Text := ADoc_Invoice_Rec.FTotalPrice;
//      ShowMessage(LStr2);
//    end;
  finally
//    wordApp.quit(EmptyParam, EmptyParam, EmptyParam);
  end;
end;

procedure MakeSubConInvoice_LUXCO(ADoc_Invoice_Rec:Doc_Invoice_Rec);
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LRange: OleVariant;
  LWorksheet: OleVariant;
  LFileName, LStr: string;
  LDoc: Variant;
  i, LTotalPrice, LTotalPrice2, LQty, LNumOfWorker: integer;
begin
  LFileName := DOC_DIR + INVOICE_FILE_SUBCON_LUXCO;

  if not FileExists(LFileName) then
  begin
    ShowMessage('File(' + LFileName + ')이 존재하지 않습니다');
    exit;
  end;

  LExcel := GetActiveExcelOleObject(True);
  LWorkBook := LExcel.Workbooks.Open(LFileName);
  LExcel.Visible := true;
  LWorksheet := LExcel.ActiveSheet;

  LRange := LWorksheet.range['C7'];
  LRange.FormulaR1C1 := ADoc_Invoice_Rec.FSubject;

  TDocVariant.New(LDoc);

  for i := 0 to ADoc_Invoice_Rec.FInvoiceItemList.Count - 1 do
  begin
    LStr := ADoc_Invoice_Rec.FInvoiceItemList.Strings[i];
    GetInvoiceItem2Var(LStr, LDoc);
    LTotalPrice := StrToIntDef(LDoc.TotalPrice,0);
    LQty := StrToIntDef(LDoc.Qty,0);
    LNumOfWorker := StrToIntDef(LDoc.InvoiceItemDesc,1);

    if LDoc.InvoiceItemType = g_GSInvoiceItemType.ToString(iitMaterials) then
    begin
      LRange := LWorksheet.range['G14'];
      LRange.FormulaR1C1 := LTotalPrice;
    end
    else
    if LDoc.InvoiceItemType = g_GSInvoiceItemType.ToString(iitWork_Week_N) then
    begin
      LRange := LWorksheet.range['G20'];
      LRange.FormulaR1C1 := LQty * LNumOfWorker;
      LRange := LWorksheet.range['I20'];
      LRange.FormulaR1C1 := LTotalPrice;
    end
    else
    if LDoc.InvoiceItemType = g_GSInvoiceItemType.ToString(iitTravellingHours) then
    begin
      LRange := LWorksheet.range['G21'];
      LRange.FormulaR1C1 := LQty * LNumOfWorker;
      LRange := LWorksheet.range['I21'];
      LRange.FormulaR1C1 := LTotalPrice;
    end
    else
    if LDoc.InvoiceItemType = g_GSInvoiceItemType.ToString(iitAirFare) then
    begin
      LRange := LWorksheet.range['G23'];
      LRange.FormulaR1C1 := LTotalPrice;
    end
    else
    if LDoc.InvoiceItemType = g_GSInvoiceItemType.ToString(iitAccommodation) then
    begin
      LTotalPrice2 := LTotalPrice2 + LTotalPrice;
    end
    else
    if LDoc.InvoiceItemType = g_GSInvoiceItemType.ToString(iitTransportation) then
    begin
      LTotalPrice2 := LTotalPrice2 + LTotalPrice;
    end
    else
    if LDoc.InvoiceItemType = g_GSInvoiceItemType.ToString(iitMeal) then
    begin
      LTotalPrice2 := LTotalPrice2 + LTotalPrice;
    end
    else
    if LDoc.InvoiceItemType = g_GSInvoiceItemType.ToString(iitEtc) then
    begin
      LTotalPrice2 := LTotalPrice2 + LTotalPrice;
    end;

    LRange := LWorksheet.range['G24'];
    LRange.FormulaR1C1 := LTotalPrice2;
  end;
end;

procedure MakeCIPL(ACIPLRec: DOC_CIPL_Rec);
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LRange: OleVariant;
  LWorksheet: OleVariant;
  LFileName, LTempFileName, LStr: string;
  LDoc: Variant;
  LFileCopySuccess: Boolean;
  i, LTotalPrice, LTotalPrice2, LQty, LNumOfWorker: integer;
begin
  LFileName := DOC_DIR + CIPL_FILE_NAME;

  if not FileExists(LFileName) then
  begin
    ShowMessage('File(' + LFileName + ')이 존재하지 않습니다');
    exit;
  end;

  LTempFileName := 'c:\temp\' + ACIPLRec.FHullNo + '_' + ACIPLRec.FDescription + '_' + FormatDateTime('yyyymmdd', Date) + '.pjh';
  LFileCopySuccess := CopyFile(LFileName, LTempFileName, False);

  if LFileCopySuccess then
  begin
    LExcel := GetActiveExcelOleObject(True);
    LWorkBook := LExcel.Workbooks.Open(LTempFileName);
    LExcel.Visible := true;
//    LWorksheet := LExcel.ActiveSheet;
    LWorksheet := LWorkBook.Sheets.Item['Sheet1'];

    LRange := LWorksheet.range['A9'];
    LRange.FormulaR1C1 := ACIPLRec.FAccount;

    LRange := LWorksheet.range['A11'];
    LRange.FormulaR1C1 := ACIPLRec.FAccountAddr;

    LRange := LWorksheet.range['A16'];
    LRange.FormulaR1C1 := ACIPLRec.FPortOfLoading;

    LRange := LWorksheet.range['D3'];
    LRange.FormulaR1C1 := ACIPLRec.FInvoieNo;

    LRange := LWorksheet.range['G9'];
    LRange.FormulaR1C1 := ACIPLRec.FTermOfDelivery;

    LRange := LWorksheet.range['D11'];
    LRange.FormulaR1C1 := ACIPLRec.FRemark;

    LRange := LWorksheet.range['A21'];
    LRange.FormulaR1C1 := ACIPLRec.FClaimNo;

    LRange := LWorksheet.range['B21'];
    LRange.FormulaR1C1 := ACIPLRec.FDescription;

    LRange := LWorksheet.range['E21'];
    LRange.FormulaR1C1 := ACIPLRec.FQty;

    LRange := LWorksheet.range['H21'];
    LRange.FormulaR1C1 := ACIPLRec.FUnitPrice;

    LRange := LWorksheet.range['J21'];
    LRange.FormulaR1C1 := ACIPLRec.FAmount;

    //Packing List Sheet
    LWorksheet := LWorkBook.Sheets.Item['Sheet2'];

    LRange := LWorksheet.range['A9'];
    LRange.FormulaR1C1 := ACIPLRec.FAccount;

    LRange := LWorksheet.range['A11'];
    LRange.FormulaR1C1 := ACIPLRec.FAccountAddr;

    LRange := LWorksheet.range['A16'];
    LRange.FormulaR1C1 := ACIPLRec.FPortOfLoading;

    LRange := LWorksheet.range['E3'];
    LRange.FormulaR1C1 := ACIPLRec.FInvoieNo;

    LRange := LWorksheet.range['H9'];
    LRange.FormulaR1C1 := ACIPLRec.FTermOfDelivery;

    LRange := LWorksheet.range['E11'];
    LRange.FormulaR1C1 := ACIPLRec.FRemark;

    LRange := LWorksheet.range['A21'];
    LRange.FormulaR1C1 := ACIPLRec.FNumOfPkgs;

    LRange := LWorksheet.range['B21'];
    LRange.FormulaR1C1 := ACIPLRec.FDescription;

    LRange := LWorksheet.range['F21'];
    LRange.FormulaR1C1 := ACIPLRec.FQty;

    LRange := LWorksheet.range['I21'];
    LRange.FormulaR1C1 := ACIPLRec.FNewWeight;

    LRange := LWorksheet.range['J21'];
    LRange.FormulaR1C1 := ACIPLRec.FGrossWeight;

    LRange := LWorksheet.range['L21'];
    LRange.FormulaR1C1 := ACIPLRec.FMeasurement;

    LRange := LWorksheet.range['L22'];
    LRange.FormulaR1C1 := ACIPLRec.FCMB;

//    LWorkBook.Close;
//    LExcel.Quit;
  end;
end;

procedure MakeShippingMark(AShipMarkRec: DOC_SHIPMARK_Rec);
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LRange: OleVariant;
  LWorksheet: OleVariant;
  LFileName, LTempFileName, LStr: string;
  LFileCopySuccess: Boolean;
begin
  LFileName := DOC_DIR + SHIPMARK_FILE_NAME;

  if not FileExists(LFileName) then
  begin
    ShowMessage('File(' + LFileName + ')이 존재하지 않습니다');
    exit;
  end;

  LTempFileName := 'c:\temp\' + AShipMarkRec.FHullNo + '_' + AShipMarkRec.FDescription + '_' + FormatDateTime('yyyymmdd', Date) + '.pjh';
  LFileCopySuccess := CopyFile(LFileName, LTempFileName, False);

  if LFileCopySuccess then
  begin
    LExcel := GetActiveExcelOleObject(True);
    LWorkBook := LExcel.Workbooks.Open(LTempFileName);
    LExcel.Visible := true;
    LWorksheet := LExcel.ActiveSheet;
//    LWorksheet := LWorkBook.Sheets.Item['Sheet1'];

    LRange := LWorksheet.range['G4'];
    LRange.FormulaR1C1 := AShipMarkRec.FHullNo + ' / ' + AShipMarkRec.FShipName;

    LRange := LWorksheet.range['G5'];
    LRange.FormulaR1C1 := AShipMarkRec.FClaimNo;

    LRange := LWorksheet.range['G6'];
    LRange.FormulaR1C1 := AShipMarkRec.FDescription + ' / ' + AShipMarkRec.FQty + 'EA';

    LRange := LWorksheet.range['G7'];
    LRange.FormulaR1C1 := AShipMarkRec.FNumOfPkgs;

//    LWorkBook.Close;
//    LExcel.Quit;
  end;
end;

function GetClaimInfoJsonFromReport_Xls(AXlsFileName: string): RawUtf8;
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LWorksheet: OleVariant;
  LRange: OleVariant;
  LDoc: IDocDict;
begin
  if not FileExists(AXlsFileName) then
  begin
    ShowMessage('File(' + AXlsFileName + ')이 존재하지 않습니다');
    exit;
  end;

  LDoc := DocDict('{}');

  LExcel := GetActiveExcelOleObject(True);
  LWorkBook := LExcel.Workbooks.Open(AXlsFileName);
  LExcel.Visible := true;
  LWorksheet := LExcel.ActiveSheet;
  AXlsFileName := LWorkSheet.Name;

  if UpperCase(AXlsFileName) <> 'CLAIM REPORT' then
    LWorksheet := LWorkBook.Sheets.Item['Claim Report'];

  LRange := LWorksheet.range['F2'];
  LDoc.S['ShipName'] := LRange.FormulaR1C1;

  LRange := LWorksheet.range['R2'];
  LDoc.S['HullNo'] := LRange.FormulaR1C1;

  LRange := LWorksheet.range['Z2'];
  LDoc.S['ClaimNo'] := LRange.FormulaR1C1;

  LRange := LWorksheet.range['F3'];
  LDoc.S['Subject'] := LRange.FormulaR1C1;

  LRange := LWorksheet.range['Z3'];
  LDoc.S['IssueDate'] := LRange.FormulaR1C1;

  LRange := LWorksheet.range['F4'];
  LDoc.S['Supplier'] := LRange.FormulaR1C1;

  LRange := LWorksheet.range['F5'];
  LDoc.S['Category'] := LRange.FormulaR1C1;

  LRange := LWorksheet.range['F6'];
  LDoc.S['System'] := LRange.FormulaR1C1;

  LRange := LWorksheet.range['F7'];
  LDoc.S['Location'] := LRange.FormulaR1C1;

  LRange := LWorksheet.range['F8'];
  LDoc.S['DefectType'] := LRange.FormulaR1C1;

  LRange := LWorksheet.range['F9'];
  LDoc.S['Cause'] := LRange.FormulaR1C1;

  LRange := LWorksheet.range['A12'];
  LDoc.S['ProblemDesc'] := LRange.FormulaR1C1;

  LRange := LWorksheet.range['A14'];
  LDoc.S['ByShipStaff'] := LRange.FormulaR1C1;

  LRange := LWorksheet.range['Q14'];
  LDoc.S['PartsRequired'] := LRange.FormulaR1C1;

  LRange := LWorksheet.range['A15'];
  LDoc.S['SE'] := LRange.FormulaR1C1;

  LRange := LWorksheet.range['Q15'];
  LDoc.S['TSInfo'] := LRange.FormulaR1C1;

  LRange := LWorksheet.range['A17'];
  LDoc.S['OwnerComment'] := LRange.FormulaR1C1;

  LRange := LWorksheet.range['F18'];
  LDoc.S['AgentDetail'] := LRange.FormulaR1C1;

  Result := LDoc.ToJson(jsonUnquotedPropNameCompact);

//  LWorkBook.Close;
//  LExcel.Quit;
end;

procedure MakeReceiptAcceptance(ARectAcceptRec: DOC_RECEIPTACCPT_Rec);
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LRange: OleVariant;
  LWorksheet: OleVariant;
  LFileName, LTempFileName, LStr: string;
  LFileCopySuccess: Boolean;
begin
  LFileName := DOC_DIR + RECEIPTACCEPT_FILE_NAME;

  if not FileExists(LFileName) then
  begin
    ShowMessage('File(' + LFileName + ')이 존재하지 않습니다');
    exit;
  end;

  LTempFileName := 'c:\temp\' + ARectAcceptRec.FHullNo + '_ReceiptAccept_' + FormatDateTime('yyyymmdd', Date) + '.pjh';
  LFileCopySuccess := CopyFile(LFileName, LTempFileName, False);

  if LFileCopySuccess then
  begin
    LExcel := GetActiveExcelOleObject(True);
    LWorkBook := LExcel.Workbooks.Open(LTempFileName);
    LExcel.Visible := true;
    LWorksheet := LExcel.ActiveSheet;
//    LWorksheet := LWorkBook.Sheets.Item['Sheet1'];

    LRange := LWorksheet.range['B8'];
    LRange.FormulaR1C1 := ARectAcceptRec.FProjectName;

    LRange := LWorksheet.range['D8'];
    LRange.FormulaR1C1 := ARectAcceptRec.FProjectNo;

    LRange := LWorksheet.range['F8'];
    LRange.FormulaR1C1 := ARectAcceptRec.FDepartment;

    LRange := LWorksheet.range['H8'];
    LRange.FormulaR1C1 := ARectAcceptRec.FPICName;

    LRange := LWorksheet.range['B11'];
    LRange.FormulaR1C1 := ARectAcceptRec.FPORNo;

    LRange := LWorksheet.range['D11'];
    LRange.FormulaR1C1 := ARectAcceptRec.FMatName;

    LRange := LWorksheet.range['H11'];
    LRange.FormulaR1C1 := ARectAcceptRec.FQty;

    LRange := LWorksheet.range['D15'];
    LRange.FormulaR1C1 := ARectAcceptRec.FShipName;

    LRange := LWorksheet.range['D16'];
    LRange.FormulaR1C1 := ARectAcceptRec.FHullNo;

    LRange := LWorksheet.range['H15'];
    LRange.FormulaR1C1 := ARectAcceptRec.FClaimNo;

    LRange := LWorksheet.range['H16'];
    LRange.FormulaR1C1 := ARectAcceptRec.FQty;

    LRange := LWorksheet.range['D17'];
    LRange.FormulaR1C1 := ARectAcceptRec.FMatDesc;

    LRange := LWorksheet.range['C19'];
    LRange.FormulaR1C1 := ARectAcceptRec.FReciptDate;

    LRange := LWorksheet.range['C21'];
    LRange.FormulaR1C1 := ARectAcceptRec.FRecvCompany;

    LRange := LWorksheet.range['C23'];
    LRange.FormulaR1C1 := ARectAcceptRec.FSpec;

    LRange := LWorksheet.range['C24'];
    LRange.FormulaR1C1 := ARectAcceptRec.FRemark;
  end;
end;

function GetClaimInfoJsonFromXlsString(AXlsFile: RawByteString): RawUtf8;
var
  LStream: TStream;
  LTmpXlsFileName: string;
begin
  Result := '';

  try
    LStream := RawByteStringToStream(AXlsFile);
    //'c:\Temp\Temp.xls' 에 LStream을 저장함
    LTmpXlsFileName := GetFileNameFromStream(LStream);
    Result := GetClaimInfoJsonFromReport_Xls(LTmpXlsFileName);
  finally
    LStream.Free
  end;
end;

end.
