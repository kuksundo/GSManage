unit UnitElecServiceData2;

interface

uses System.Classes, UnitEnumHelper, FSMClass_Dic, FSMState, Vcl.StdCtrls;

type
  TEngineerKind = (ekNone, ekSuperIntendent, ekServiceEngineer, ekServiceEngineer_Elec, ekTechnician, ekFinal);

//  TGSDocType = (dtNull,
//              dtQuote2Cust4Material, dtQuote2Cust4Service, dtQuoteFromSubCon,
//              dtPOFromCustomer, dtPO2SubCon,
//              dtInvoice2Customer, dtInvoiceFromSubCon,
//              dtSRFromSubCon,
//              dtTaxBill2Customer, dtTaxBillFromSubCon,
//              dtCompanySelection, dtConfirmComplete, dtBudgetApproval,
//              dtContract, dtCert, dtFinal);

  TSalesProcess = (spNone, spQtnReqRecvFromCust, spQtnReq2SubCon, spQtnRecvFromSubCon, spQtnSend2Cust,
    spSEAttendReqFromCust, spVslSchedReq2Cust, spSECanAvail2SubCon, spSEAvailRecvFromSubCon,
    spSECanAttend2Cust, spSEAttendConfirmFromCust, spPOReq2Cust, spPORecvFromCust, spSEDispatchReq2SubCon,//13
    spQtnInput, spQtnApproval, spOrderInput, spOrderApproval, spPORCreate, spPORCheck4HiPRO,//19
    spShipInstruct, spDelivery, spAWBRecv, spAWBSend2Cust, spSRRecvFromSubCon, //24
    spSRSend2Cust, spInvoiceRecvFromSubCon, spInvoiceSend2Cust, spInvoiceConfirmFromCust,//28
    spOrderPriceModify, spModifiedOrderApproval, spSalesPriceConfirm,
    spTaxBillReq2SubCon, spTaxBillIssue2Cust, spTaxBillRecvFromSubCon, spTaxBillSend2GeneralAffair, //35
    spSaleReq2GeneralAffair, spSOSend2SubCon, spSORecvFromSubCon, spSubConChooseApproval, spFinal //40
  );

  TSalesProcessType = (sptNone, sptForeignCustOnlyService, sptDomesticCustOnlyService,
    sptForeignCustOnlyMaterial,  sptDomesticCustOnlyMaterial,
    sptForeignCustWithServiceNMaterial, sptDomesticCustWithServiceNMaterial,
    sptForeignCustOnlyService4FieldService, sptDomesticCustOnlyService4FieldService,
    sptForeignCustWithServiceNMaterial4FieldService,
    sptDomesticCustWithServiceNMaterial4FieldService,
    sptFinal);

  TProcessDirection = (pdNone, pdToCustomer, pdFromCustomer, pdToSubCon, pdFromSubCon,
    pdToHElec, pdFromHElec, pdToHGS, pdFromHGS, pdFinal);

//  TContainData4Mail = (cdmNone, cdmServiceReport,cdmQtn2Cust, cdmQtnFromSubCon,
//    cdmPoFromCust, cdmPo2SubCon,cdmInvoice2Cust, cdmInvoiceFromSubCon, cdmInvoiceConfirmFromCust,
//    cdmTaxBillFromSubCon, cdmTaxBill2Cust, cdmFinal
//  );

  TEngineerAgency = (eaNone, eaSubCon, eaHGS, eaHELEC, eaFinal);//엔지니어 소속사

  TGSInvoiceItemType = (iitNull, iitServiceReport, iitWork_Week_N, iitWork_Week_OT,
              iitWork_Holiday_N, iitWork_Holiday_OT, iitTravellingHours,
              iitMaterials, iitAirFare, iitAccommodation, iitTransportation,
              iitMeal, iitEtc, iitFinal);

  TCalcInvoiceMethod = (cimNull, cimPerDay, cimPerHour, cimFinal);

  TASServiceChargeType = (assctNull, assctCharged, assctFree, assctFinal);

  TDeliveryKind = (dkNull, dkDomesticDelivery, dkOverSeaDelivery, dkFinal);
  TFreeOrCharge = (focNull, focFree, focCharge, focFinal);//유환/무환

const
  R_EngineerKind : array[Low(TEngineerKind)..High(TEngineerKind)] of string =
    ('', 'SuperIntendent', 'Service Engineer', 'Service Engineer(Elec.)',
      'Technician', ''
    );

//  R_GSDocType : array[Low(TGSDocType)..High(TGSDocType)] of string =
//    ('', '부품 견적서(To 고객)', '서비스 견적서(To 고객)', '부품 견적서(From 협력사)',
//      'PO(From 고객)', 'PO(To 협력사)', 'Invoice(To 고객)', 'Invoice(From 협력사)',
//      'Service Report', '세금계산서(To 고객)', '세금계산서(From 협력사)',
//      '업체선정품의서', '공사완료확인서', '예산승인품의서', '계약서',
//      '인증서', '');

  R_SalesProcess : array[Low(TSalesProcess)..High(TSalesProcess)] of string =
    ('', '견적요청접수 <- 고객', '견적요청 -> 협력사', '젼적서입수 <- 협력사',
      '견적서송부 -> 고객', 'SE파견요청접수 <- 고객', '선박스케쥴요청 -> 고객',
      'SE파견가능문의 -> 협력사', 'SE파견가능확인 <- 협력사',
      'SE파견가능통보 -> 고객', 'PO발행요청 -> 고객', 'SE파견요청확인 <- 고객',
      'PO입수 <- 고객', 'SE파견요청 -> 협력사', 'QUOTATION입력 -> MAPS',
      'QUOTATION승인 -> MAPS', '수주통보서입력 -> MAPS', '수주통보서승인 -> MAPS',
      'POR 생성 -> MAPS(POR관리)', 'POR발행확인 -> Hi-PRO', '출하지시등록 -> MAPS',
      '자재배송 -> 택배', 'AWB입수 <- 택배', 'AWB송부 -> 고객', 'SR입수 <- 협력사',
      'SR송부 -> 고객', 'Invoice입수 <- 협력사', 'Invoice송부 -> 고객',
      'Invoice확인 <- 고객', '수주통보서금액수정 -> MAPS', '수주통보서재승인 -> MAPS',
      '매출금액확인 -> MAPS(공사매출정보관리)', '세금계산서발행요청 -> 협력사',
      '세금계산서발행 -> 국내고객', '세금계산서입수 <- 협력사',
      '세금계산서전달 -> 담당자', '매출처리요청 -> 담당자', 'Service-Order 송부 -> 협력사',
      'Service-Order 입수 <- 협력사', '업체선정품의서 결재', '작업완료');

  R_SalesProcessType : array[Low(TSalesProcessType)..High(TSalesProcessType)] of string =
    ('', '유상용역-해외고객', '자재구매-해외고객', '유상용역-국내고객',
      '자재구매-국내고객', '유상용역/자재구매-해외고객', '유상용역/자재구매-국내고객',
      '유상용역-해외고객(Field Service)', '유상용역-국내고객(Field Service)',
      '유상용역/자재구매-해외고객(Field Service)', '유상용역/자재구매-국내고객(Field Service)',
       '');

  R_ProcessDirection : array[Low(TProcessDirection)..High(TProcessDirection)] of string =
    ('', 'To 고객', 'From 고객', 'To 협력사', 'From 협력사', 'To 현대일렉트릭',
      'From 현대일렉트릭', 'To HGS', 'From HGS', '');

  R_EngineerAgency : array[Low(TEngineerAgency)..High(TEngineerAgency)] of string =
    ('', '협력사', 'HGS', 'HEE', '');

  R_GSInvoiceItemType : array[Low(TGSInvoiceItemType)..High(TGSInvoiceItemType)] of string =
    (
    '',
    'Service Report',
    'Work(Weekday-Normal)',
    'Work(Weekday-OverTime)',
    'Work(Holiday-Normal)',
    'Work(Holiday-OverTime)',
    'Trevelling Hours',
    'Materials',
    'Ex(Airfare)',
    'Ex(Accommodation)',
    'Ex(Transportation)',
    'Ex(Meal)',
    'Ex(Etc)',
    ''
  );

  R_CalcInvoiceMethod : array[Low(TCalcInvoiceMethod)..High(TCalcInvoiceMethod)] of string =
    (
    '',
    'Per Day',
    'Per Hour',
    ''
     );

  R_ASServiceChargeType : array[Low(TASServiceChargeType)..High(TASServiceChargeType)] of string =
    (
    '',
    'Charged',
    'Free',
    ''
     );

//  R_ASServiceType : array[Low(TASServiceType)..High(TASServiceType)] of string =
//    (
//    '',
//    ''
//     );

  R_DeliveryKind : array[Low(TDeliveryKind)..High(TDeliveryKind)] of string =
    (
    '',
    '국내택배',
    '해외운송',
    ''
     );

  R_FreeOrCharge : array[Low(TFreeOrCharge)..High(TFreeOrCharge)] of string =
    (
    '',
    '무한',
    '유환',
    ''
     );

var
  g_EngineerKind: TLabelledEnum<TEngineerKind>;
  g_SalesProcess: TLabelledEnum<TSalesProcess>;
  g_SalesProcessType: TLabelledEnum<TSalesProcessType>;
  g_ProcessDirection: TLabelledEnum<TProcessDirection>;
  g_EngineerAgency: TLabelledEnum<TEngineerAgency>;
  g_GSInvoiceItemType: TLabelledEnum<TGSInvoiceItemType>;
  g_CalcInvoiceMethod: TLabelledEnum<TCalcInvoiceMethod>;
//  g_ASServiceType: TLabelledEnum<TASServiceType>;
  g_ASServiceChargeType: TLabelledEnum<TASServiceChargeType>;
  g_DeliveryKind: TLabelledEnum<TDeliveryKind>;
  g_FreeOrCharge: TLabelledEnum<TFreeOrCharge>;

procedure SalesProcess2List(AList: TStringList; AFSMState: TFSMState);

implementation

procedure SalesProcess2List(AList: TStringList; AFSMState: TFSMState);
var
  LIntArr: TIntegerArray;
  i: integer;
begin
  AList.Clear;
  AList.Add('');
  LIntArr := AFSMState.GetOutputs;

  for i := Low(LIntArr) to High(LIntArr) do
    AList.Add(g_SalesProcess.ToString(LIntArr[i]));
end;

initialization
//  g_QueryDateType.InitArrayRecord(R_QueryDateType);
//  g_EngineerKind.InitArrayRecord(R_EngineerKind);
//  g_GSDocType.InitArrayRecord(R_GSDocType);
//  g_SalesProcess.InitArrayRecord(R_SalesProcess);
//  g_SalesProcessType.InitArrayRecord(R_SalesProcessType);
//  g_ProcessDirection.InitArrayRecord(R_ProcessDirection);
//  g_ContainData4Mail.InitArrayRecord(R_ContainData4Mail);
//  g_EngineerAgency.InitArrayRecord(R_EngineerAgency);
//  g_GSInvoiceItemType.InitArrayRecord(R_GSInvoiceItemType);
//  g_CalcInvoiceMethod.InitArrayRecord(R_CalcInvoiceMethod);
//  g_ASServiceChargeType.InitArrayRecord(R_ASServiceChargeType);
//  g_ASServiceType.InitArrayRecord(R_ASServiceType);
//  g_HiconisASState.InitArrayRecord(R_HiconisASState);
//  g_HiconisASTrigger.InitArrayRecord(R_HiconisASTrigger);
//  g_ClaimServiceKind.InitArrayRecord(R_ClaimServiceKind);
//  g_ClaimImportanceKind.InitArrayRecord(R_ClaimImportanceKind);
//  g_DeliveryKind.InitArrayRecord(R_DeliveryKind);
//  g_FreeOrCharge.InitArrayRecord(R_FreeOrCharge);
//  g_ClaimStatus.InitArrayRecord(R_ClaimStatus);
//  g_ClaimCategory.InitArrayRecord(R_ClaimCategory);
//  g_ClaimLocation.InitArrayRecord(R_ClaimLocation);
//  g_ClaimCauseKind.InitArrayRecord(R_ClaimCauseKind);
//  g_ClaimCauseHW.InitArrayRecord(R_ClaimCauseHW);
//  g_ClaimCauseSW.InitArrayRecord(R_ClaimCauseSW);
//  g_ClaimTypeKind.InitArrayRecord(R_ClaimTypeKind);

finalization

end.
