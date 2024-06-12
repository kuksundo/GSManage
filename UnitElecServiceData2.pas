unit UnitElecServiceData2;

interface

uses System.Classes, UnitEnumHelper, FSMClass_Dic, FSMState, Vcl.StdCtrls;

type
  TQueryDateType = (qdtNull, qdtInqRecv, qdtInvoiceIssue, qdtQTNInput,
    qdtOrderInput, qdtFinal);

  TSearchCondRec = record
    FFrom, FTo: TDateTime;
    FQueryDate: TQueryDateType;
    FHullNo, FShipName, FCustomer, FProdType, FSubject: string;
    FCurWork, FBefAft, FWorkKind: integer;
    FQtnNo, FOrderNo, FPoNo, FRemoteIPAddress: string
  end;

  TEngineerKind = (ekNone, ekSuperIntendent, ekServiceEngineer, ekServiceEngineer_Elec, ekTechnician, ekFinal);

  TGSDocType = (dtNull,
              dtQuote2Cust4Material, dtQuote2Cust4Service, dtQuoteFromSubCon,
              dtPOFromCustomer, dtPO2SubCon,
              dtInvoice2Customer, dtInvoiceFromSubCon,
              dtSRFromSubCon,
              dtTaxBill2Customer, dtTaxBillFromSubCon,
              dtCompanySelection, dtConfirmComplete, dtBudgetApproval,
              dtContract, dtCert, dtFinal);

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

  TContainData4Mail = (cdmNone, cdmServiceReport,cdmQtn2Cust, cdmQtnFromSubCon,
    cdmPoFromCust, cdmPo2SubCon,cdmInvoice2Cust, cdmInvoiceFromSubCon, cdmInvoiceConfirmFromCust,
    cdmTaxBillFromSubCon, cdmTaxBill2Cust, cdmFinal
  );

  TContainData4Mails = set of TContainData4Mail;

  TEngineerAgency = (eaNone, eaSubCon, eaHGS, eaHELEC, eaFinal);//엔지니어 소속사

  TGSInvoiceItemType = (iitNull, iitServiceReport, iitWork_Week_N, iitWork_Week_OT,
              iitWork_Holiday_N, iitWork_Holiday_OT, iitTravellingHours,
              iitMaterials, iitAirFare, iitAccommodation, iitTransportation,
              iitMeal, iitEtc, iitFinal);

  TCalcInvoiceMethod = (cimNull, cimPerDay, cimPerHour, cimFinal);

  TASServiceChargeType = (assctNull, assctCharged, assctFree, assctFinal);

  THiconisASState = (hassNull,
    hassNewClaimRecv, //Claim 접수
    hassNewClaimRegistered, //Claim 등록
    hassNewClaimCancelled, //Claim 취소
    hassTSSent, //Trouble Shoot 송부
    hassSupplyPart, //자재 공급
    hassSEOnboard, //Service Engineer 방선
    hassReqQuote4SE, //용역 - 견적요청
    hassConfirmQuote4SE, //용역 - 견적확정
    hassAppoveQouto, //용역 - 견적품의
    hassSendOrder2SubCon, //용역 - 발주서 송부
    hassReceitProcess,//용역 - 전표처리
    hassCheckMatCode,//자재 - 코드확인
    hassIssueMatPOR,//자재 - POR 발행
    hassCheckMatBudget,//자재 - 예산확인(보증예산정보)
    hassSendMatPOR,//자재 - POR 전송(POR관리탭에서 재전송)
    hassClaimClosed, //Claim 종료
    hassFinal);

  THiconisASTrigger = (hastNull,
    hastRegister2Maps, //Maps에 등록
    hastCancelRegisgter, //Maps 등록 취소
    hastReqTS2Lab, //Trouble Shooting 요청(담당자)
    hastFinal);

  TClaimServiceKind = (cskNull,
    cskPartSupply,//부품 공급
    cskPartSupplyNSE,//부품 공급 + S/E 방선
    cskSEOnboard,//S/E 방선
    cskTechInfo, //기술정보 제공
    cskOverDue,  //보증기간 경과
    cskByCrew,   //본선 조치
    cskOwnerPrepare,//선주사 준비
    cskYardPrepare, //조선소 준비
    cskPayCompensation,//보상금 지급
    cskFinal);
const
  R_QueryDateType : array[Low(TQueryDateType)..High(TQueryDateType)] of string =
    ('', 'Inq 접수일 기준', 'Invoice 발행일 기준', 'QTN 입력일 기준',
      '수주통보서 입력일 기준', '');

  R_EngineerKind : array[Low(TEngineerKind)..High(TEngineerKind)] of string =
    ('', 'SuperIntendent', 'Service Engineer', 'Service Engineer(Elec.)',
      'Technician', ''
    );

  R_GSDocType : array[Low(TGSDocType)..High(TGSDocType)] of string =
    ('', '부품 견적서(To 고객)', '서비스 견적서(To 고객)', '부품 견적서(From 협력사)',
      'PO(From 고객)', 'PO(To 협력사)', 'Invoice(To 고객)', 'Invoice(From 협력사)',
      'Service Report', '세금계산서(To 고객)', '세금계산서(From 협력사)',
      '업체선정품의서', '공사완료확인서', '예산승인품의서', '계약서',
      '인증서', '');

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

  R_ContainData4Mail : array[Low(TContainData4Mail)..High(TContainData4Mail)] of string =
    ('', 'Service Report', 'Quotation -> Customer', 'Quotation <- SubCon',
      'PO <- Customer', 'PO <- SubCon', 'Invoice -> Customer', 'Invoice <- SubCon',
      'InvoiceConfirm <- Customer', 'Tax Bill <- SubCon', 'Tax Bill -> Customer',
      'Tax Bill -> Customer');

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

  R_ASServiceType : array[Low(TASServiceType)..High(TASServiceType)] of string =
    (
    '',
    ''
     );

  R_HiconisASState : array[Low(THiconisASState)..High(THiconisASState)] of string =
    (
    '',
    'Claim 접수',
    'Claim 등록',
    'Claim 취소',
    'Trouble Shoot 송부',
    '자재 공급',
    'Service Engineer 방선',
    '용역 - 견적요청',
    '용역 - 견적확정',
    '용역 - 견적품의',
    '용역 - 발주서 송부',
    '용역 - 전표처리',
    '자재 - 코드확인',
    '자재 - POR 발행',
    '자재 - 예산확인(보증예산정보)',
    '자재 - POR 전송(POR관리탭에서 재전송)',
    'Claim 종료',
    ''
     );

  R_HiconisASTrigger : array[Low(THiconisASTrigger)..High(THiconisASTrigger)] of string =
    (
    '',
    'Maps에 등록',
    'Maps 등록 취소',
    'Trouble Shooting 요청(담당자)',
    ''
     );

  R_ClaimServiceKind : array[Low(TClaimServiceKind)..High(TClaimServiceKind)] of string =
    (
    '',
    '부품 공급',
    '부품 공급 + S/E 방선',
    'S/E 방선',
    '기술정보 제공',
    '보증기간 경과',
    '본선 조치',
    '선주사 준비',
    '조선소 준비',
    '보상금 지급',
    ''
     );

var
  g_QueryDateType: TLabelledEnum<TQueryDateType>;
  g_EngineerKind: TLabelledEnum<TEngineerKind>;
  g_GSDocType: TLabelledEnum<TGSDocType>;
  g_SalesProcess: TLabelledEnum<TSalesProcess>;
  g_SalesProcessType: TLabelledEnum<TSalesProcessType>;
  g_ProcessDirection: TLabelledEnum<TProcessDirection>;
  g_ContainData4Mail: TLabelledEnum<TContainData4Mail>;
  g_EngineerAgency: TLabelledEnum<TEngineerAgency>;
  g_GSInvoiceItemType: TLabelledEnum<TGSInvoiceItemType>;
  g_CalcInvoiceMethod: TLabelledEnum<TCalcInvoiceMethod>;
  g_ASServiceType: TLabelledEnum<TASServiceType>;
  g_ASServiceChargeType: TLabelledEnum<TASServiceChargeType>;
  g_HiconisASState: TLabelledEnum<THiconisASState>;
  g_HiconisASTrigger: TLabelledEnum<THiconisASTrigger>;
  g_ClaimServiceKind: TLabelledEnum<TClaimServiceKind>;

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

finalization

end.
