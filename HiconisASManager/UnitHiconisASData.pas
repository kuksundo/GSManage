unit UnitHiconisASData;

interface

uses System.Classes, UnitEnumHelper, FSMClass_Dic, FSMState, Vcl.StdCtrls,
  JHP.Util.Bit32Helper;

const
  GDC_ADDRESS_HAN = '울산광역시 남구 신두왕로 50' + #13#10 + '글로벌디지털센터' + #13#10 + '박정현 책임' + #13#10 + 'REL: 052-204-5280';
  GDC_ADDRESS_ENG = 'GDC 2F, 50 Sinduwang-ro, Nam-Gu, Ulsan, Korea, 44776';

type
  TQueryDateType = (qdtNull,
    qdtMaterialOrder, qdtClaimRecvDate, qdtClaimInputDate, qdtClaimReadyDate,
    qdtClaimClosedDate, qdtAttendScheduled, qdtWorkBeginDate, qdtWorkEndDate,
    qdtModifyDate,
    qdtFinal);

  THiASFindCondition = (hfcNull,
    hfcInputToday,//오늘 입력한 Claim
    hfcInputReview,//하루 전 오후 ~ 현재 까지 입력한 Claim (장CI과 검토하기 위한 검색-10:30 ~ 11:30)
    hfcUpdateToday,//오늘 수정한 Claim
    hfcFinal);

  TSearchCondRec = record
    FFrom, FTo: TDateTime;
    FQueryDate: TQueryDateType;
    FHullNo, FShipName, FCustomer, FProdType, FSubject,
    FMaterialCode, FShippingNo, FWorkSummary, FMaterialName, FMatPorNo: string; //FPorNo,
    FCurWork, FBefAft, FWorkKind,
    FClaimServiceKind, FClaimStatus, FClaimCatetory, FClaimLocation, FClaimKind,
    FClaimCauseHW, FClaimCauseSW: integer;
    FQtnNo, FOrderNo, FPoNo, FRemoteIPAddress, FClaimNo: string;
    FIncludeClosed //Closed 된 Task도 포함하여 표시함
    : Boolean;
  end;

//  TGSDocType = (dtNull,
//              dtQuote2Cust4Material, dtQuote2Cust4Service, dtQuoteFromSubCon,
//              dtPOFromCustomer, dtPO2SubCon,
//              dtInvoice2Customer, dtInvoiceFromSubCon,
//              dtSRFromSubCon,
//              dtTaxBill2Customer, dtTaxBillFromSubCon,
//              dtCompanySelection, dtConfirmComplete, dtBudgetApproval,
//              dtContract, dtCert, dtFinal);

  THiASDocType = (dtNull,
              dtClaimReport,
              dtFinal);

  THiconisASState = (hassNull,
    hassNewClaimRecv, //Claim 접수
    hassNewClaimRegistered, //Claim 등록
    hassNewClaimCancelled, //Claim 취소
    hassTSRecv, //Trouble Shoot 수신
    hassTSSent, //Trouble Shoot 송부
    hassTechInfoCompleted, //기술정보제공완료
    hassSupplyPart, //자재 공급
    hassSEOnboard, //Service Engineer 방선

    hassClaimReviewRecv, //Claim 검토 결과 수신

    hassReqQuote4SE, //용역 - 견적요청
    hassConfirmQuote4SE, //용역 - 견적확정
    hassAppoveQouto, //용역 - 견적품의
    hassOrderMade4SubCon, //용역 - 발주서 작성 완료
    hassSendOrder2SubCon, //용역 - 발주서 송부
    hassOnboardSE, //용역 - SE 방선

    hassRecvInvoiceFromSubCon, //용역 - Invoice 접수
    hassReceitProcess,//용역 - 전표처리

    hassReclaimMatRecv, //자재 - Reclaim 자재 수령
    hassCheckMatCode,//자재 - 코드확인
    hassIssueMatPOR,//자재 - POR 발행
    hassCheckMatBudget,//자재 - 예산확인(보증예산정보)
    hassSendMatPOR,//자재 - POR 전송(POR관리탭에서 재전송)
    hassReqMatStore, //자재 - 입고 요청
    hassConfirmMatStore, //자재 - 입고 확인
    hassRecvDestAddress2Customer, //자재 - 배송지 주소 수신
    hassOrderShipment2BMEA, //자재 - 출하지시 To BMEA(조선기자재창고)
    hassOrderShipment2Domestic, //자재 - 출하지시 To 국내 배송지
    hassOrderShipment2Oversea, //자재 - 출하지시 To 해외 배송지
    hassDomesticTranportReq, //자재 - 국내운송의뢰서 작성 완료 및 품의
    hassOverseaTranportReq, //자재 - 해외운송의뢰서 작성 완료 및 품의
    hassApprovedDomesticTranportReq, //자재 - 국내운송의뢰서 품의 완료
    hassApprovedOverseaTranportReq, //자재 - 해외운송의뢰서 품의 완료
    hassDeliveryTagRecv, //자재- 배송 Tag 수신(BMEA-조선기자재창고 입고시 필요)
    hassPackingInfoRecv, //자재- 포장정보 수신 From 물류부(해외 운송시 CIPL 작성시 필요)
    hassDomesticDeliveryReserv, //자재- 국내택배예약(우체국택배)
    hassDomesticReceitProcess, //자재- 국내택배전표처리
    hassOverseaDeliveryReserv, //자재- 해외택배예약(Fedex)
    hassOverseaReceitProcess, //자재- 해외택배전표처리
    hassCIPLMade, //자재- Commercial Invoice & Price List(CIPL) 작성 완료
    hassDeliveryInvoiceRecv, //자재- 송장 입수 완료 From 물류부
    hassDlvInvoiceNCIPSent, //자재- 송장+CIPL 송부 To 고객
    hassDomesticShipmentCompleted, //자재- 국내송품완료
    hassOverseaShipmentCompleted, //자재- 해외송품완료
    hassPickUpRequested2Logistic, //자재- Pick-up 요청 To 물류부(Reclaim 자재)
    hassConfirmRecvMatFromCustomer, //자재- 자재수신확인 From 고객
    hassConfirmClaimClose, //Claim 종료 수신 From 고객

    hassClaimClosed, //Claim 종료
    hassFinal);

  THiconisASTrigger = (hastNull,
    hastRegister2Maps, //Maps에 등록
    hastCancelRegisgter, //Maps 등록 취소

    hastReqClaimReview, //Claim 검토 요청
    hastReqTS2Lab, //Trouble Shooting 요청(담당자)
    hastSendTS2Customer, //Trouble Shooting 송부 To 고객
    hastTechInfo2Customer, //기술정보제공완료

    hastReqQuote4SE, //용역 - 견적요청
    hastConfirmQuote4SE, //용역 - 견적확정
    hastAppoveQouto, //용역 - 견적품의
    hastMakeOrder4SubCon, //용역 - 발주서 작성
    hastSendOrder2SubCon, //용역 - 발주서 송부
    hastOnboardSE, //용역 - SE 방선
    hastReqInvoiceFromSubCon, //용역 - Invoice 요청
    hastReqReceitProcess,//용역 - 전표처리요청(김희진)

    hastReqReclaimMat, //자재 - Reclaim 자재 요청
    hastReqkMatCode,//자재 - 코드확인 요청
    hastReqIssueMatPOR,//자재 - POR 발행 요청
    hastReqCheckMatBudget,//자재 - 예산증액 요청(보증예산정보)
    hastSendMatPOR,//자재 - POR 전송(POR관리탭에서 재전송)
    hastReqMatStore, //자재 - 입고 요청
    hastCofirmMatStore, //자재 - 입고 확인
    hastReqDestAddress2Customer, //자재 - 배송지 주소 문의 To 고객
    hastOrderShipment2BMEA, //자재 - 출하지시 To BMEA(조선기자재창고)
    hastOrderShipment2Domestic, //자재 - 출하지시 To 국내 배송지
    hastOrderShipment2Oversea, //자재 - 출하지시 To 해외 배송지
    hastMakeDomesticTranportReq, //자재 - 국내운송의뢰서 작성
    hastMakeOverseaTranportReq, //자재 - 해외운송의뢰서 작성
    hastReqDomesticTranportApproval, //자재 - 국내운송의뢰서 품의 결재 요청
    hastReqOverseaTranportApproval, //자재 - 해외운송의뢰서 품의 결재 요청
    hastReqDeliveryTag, //자재- 배송 Tag 요청 To 호선 담당자
    hastReqPackingInfo2Logistic, //자재 - 포장정보 요청 To 물류부
    hastReqDomesticDeliveryReserv, //자재- 국내택배예약(우체국택배)
    hastReqDomesticReceitProcess, //자재- 국내택배전표처리 요청
    hastReqOverseaDeliveryReserv, //자재- 해외택배예약(Fedex)
    hastReqOverseaReceitProcess, //자재- 해외택배전표처리 요청
    hastMakeCIPL, //자재- Commercial Invoice & Price List(CIPL) 작성
    hastReqDeliveryInvoice, //자재- 송장 요청 To 물류부
    hastSendDlvInvoiceNCIP, //자재- 송장+CIPL 송부 To 고객
    hastShipmentDomestic, //자재- 국내송품
    hastShipmentOversea, //자재- 해외송품
    hastReqPickUp2Logistic, //자재- Pick-up 요청 To 물류부(Reclaim 자재)
    hastReqClaimClose2Customer, //Claim 종료 요청 To 고객
    hastReqConfirmRecvMat2Customer, //자재수신확인 요청 To 고객
    hastReqClaimClose, //Claim 종료

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

  TClaimImportanceKind = (ciknull, cikA, cikB, cikC, cikD, cikFinal);
  TClaimStatus = (csNull, csOpen, csReady, csDock, csClosed, csFinal);

  TClaimTypeKind = (ctkNull, ctkCatetory, ctkLocation, ctkCauseKind, ctkCauseHW, ctkCauseSW, ctkFinal);
  TClaimCategory = (ccNull, ccME, ccGE, ccFGSS, ccLFSS, ccCHS, ccFinal);
  TClaimLocation = (clNull, clECR, clBridge, clER, clShipOffice, clFinal);
  TClaimCauseKind = (cckNull, ckHW, cckSW, cckLogic, cckDB, cckConfig, cckComm, cckFinal);
  TClaimCauseHW = (cchNull, cchMPM, cchFBM, cchCPM, cchDI16, cchDI16S, cchDO16, //6
    cchDO16_i, cchDO8S, cchAI16, cchAI16_i, cchRT8, cchEAP, cchCOM, cchPrinter, //14
    cchMonitor, cchOWS, cchEAS, cchKBD, cchMouse, cchBaseBoard, cchAO8, cchFinal); //22
  TClaimCauseSW = (ccsNull, ccsFinal);
const
  R_QueryDateType : array[Low(TQueryDateType)..High(TQueryDateType)] of string =
    ('',
      '자재발주일', '클레임접수일', '클레임등록일', '클레임조치일',
      '클레임완료일', '방선예정일', '작업시작일', '작업완료일', '클레임수정일', '');

  R_HiASFindCondType : array[Low(THiASFindCondition)..High(THiASFindCondition)] of string =
    ('',
      '오늘 입력한 Claim',
      '일일 검토 Claim',
      '오늘 수정한 Claim',
    '');

  R_GSDocType : array[Low(THiASDocType)..High(THiASDocType)] of string =
    ('', 'Claim Report', '');

//  R_ASServiceType : array[Low(TASServiceType)..High(TASServiceType)] of string =
//    (
//    '',
//    ''
//     );

  R_HiconisASState : array[Low(THiconisASState)..High(THiconisASState)] of string =
    (
    '',
    'Claim 접수',
    'Claim 등록',
    'Claim 취소',
    'Trouble Shoot 수신',
    'Trouble Shoot 송부',
    '기술정보제공',
    '자재 공급',
    'Service Engineer 방선',

    'Claim 검토 결과 수신',

    '용역 - 견적요청',
    '용역 - 견적확정',
    '용역 - 견적품의',
    '용역 - 발주서 작성 완료',
    '용역 - 발주서 송부',
    '용역 - SE 방선',
    '용역 - Invoice 접수',
    '용역 - 전표처리',

    '자재 - Reclaim 자재 수령',
    '자재 - 코드확인',
    '자재 - POR 발행',
    '자재 - 예산확인(보증예산정보)',
    '자재 - POR 전송(POR관리탭에서 재전송)',
    '자재 - 입고 요청',
    '자재 - 입고 확인',
    '자재 - 배송지 주소 수신',
    '자재 - 출하지시 To BMEA(조선기자재창고)',
    '자재 - 출하지시 To 국내 배송지',
    '자재 - 출하지시 To 해외 배송지',
    '자재 - 국내운송의뢰서 작성 완료 및 품의',
    '자재 - 해외운송의뢰서 작성 완료 및 품의',
    '자재 - 국내운송의뢰서 품의 완료',
    '자재 - 해외운송의뢰서 품의 완료',
    '자재 - 배송 Tag 수신(BMEA-조선기자재창고 입고시 필요)',
    '자재 - 포장정보 수신 From 물류부(해외 운송시 CIPL 작성시 필요)',
    '자재 - 국내택배예약(우체국택배)',
    '자재 - 국내택배전표처리',
    '자재 - 해외택배예약(Fedex)',
    '자재 - 해외택배전표처리',
    '자재 - Commercial Invoice & Price List(CIPL) 작성 완료',
    '자재 - 송장 입수 완료 From 물류부',
    '자재 - 송장+CIPL 송부 To 고객',
    '자재 - 국내송품완료',
    '자재 - 해외송품완료',
    '자재 - Pick-up 요청 To 물류부(Reclaim 자재)',
    '자재 - 자재수신확인 From 고객',
    'Claim 종료 수신 From 고객',

    'Claim 종료',

    ''
     );

  R_HiconisASTrigger : array[Low(THiconisASTrigger)..High(THiconisASTrigger)] of string =
    (
    '',
    'Maps에 등록',
    'Maps 등록 취소',

    'Claim 검토 요청',
    'Trouble Shooting 요청(담당자)',
    'Trouble Shooting 송부 To 고객',
    '기술정보제공완료',

    '용역 - 견적요청',
    '용역 - 견적확정',
    '용역 - 견적품의',
    '용역 - 발주서 작성',
    '용역 - 발주서 송부',
    '용역 - SE 방선',
    '용역 - Invoice 요청',
    '용역 - 전표처리요청(김희진)',

    '자재 - Reclaim 자재 요청',
    '자재 - 코드확인 요청',
    '자재 - POR 발행 요청',
    '자재 - 예산증액 요청(보증예산정보)',
    '자재 - POR 전송(POR관리탭에서 재전송)',
    '자재 - 입고 요청',
    '자재 - 입고 확인',
    '자재 - 배송지 주소 문의 To 고객',
    '자재 - 출하지시 To BMEA(조선기자재창고)',
    '자재 - 출하지시 To 국내 배송지',
    '자재 - 출하지시 To 해외 배송지',
    '자재 - 국내운송의뢰서 작성',
    '자재 - 해외운송의뢰서 작성',
    '자재 - 국내운송의뢰서 품의 결재 요청',
    '자재 - 해외운송의뢰서 품의 결재 요청',
    '자재 - 배송 Tag 요청 To 호선 담당자',
    '자재 - 포장정보 요청 To 물류부',
    '자재 - 국내택배예약(우체국택배)',
    '자재 - 국내택배전표처리 요청',
    '자재 - 해외택배예약(Fedex)',
    '자재 - 해외택배전표처리 요청',
    '자재 - Commercial Invoice & Price List(CIPL) 작성',
    '자재 - 송장 요청 To 물류부',
    '자재 - 송장+CIPL 송부 To 고객',
    '자재 - 국내송품',
    '자재 - 해외송품',
    '자재- Pick-up 요청 To 물류부(Reclaim 자재)',
    'Claim 종료 요청 To 고객',
    '자재수신확인 요청 To 고객',
    'Claim 종료',
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

  R_ClaimImportanceKind : array[Low(TClaimImportanceKind)..High(TClaimImportanceKind)] of string =
    (
    '',
    'A:대형',
    'B:주요',
    'C:일반',
    'D:단순',
    ''
     );

  R_ClaimStatus : array[Low(TClaimStatus)..High(TClaimStatus)] of string =
    (
    '',
    'OPEN',
    'READY',
    'DOCK',
    'CLOSED',
    ''
     );

  R_ClaimTypeKind : array[Low(TClaimTypeKind)..High(TClaimTypeKind)] of string =
    (
    '',
    'Catetory',
    'Location',
    'CauseKind',
    'CauseHW',
    'CauseSW',
    ''
     );

  R_ClaimCategory : array[Low(TClaimCategory)..High(TClaimCategory)] of string =
    (
    '',
    'M/E',
    'G/E',
    'FGSS',
    'LFSS',
    'CHS',
    ''
     );

  R_ClaimLocation : array[Low(TClaimLocation)..High(TClaimLocation)] of string =
    (
    '',
    'ECR',
    'Bridge',
    'ER',
    'ShipOffice',
    ''
     );

  R_ClaimCauseKind : array[Low(TClaimCauseKind)..High(TClaimCauseKind)] of string =
    (
    '',
    'HW',
    'SW',
    'Logic',
    'DB',
    'Config',
    'Comm',
    ''
     );

  R_ClaimCauseHW : array[Low(TClaimCauseHW)..High(TClaimCauseHW)] of string =
    (
    '',
    'MPM',
    'FBM',
    'CPM',
    'DI16',
    'DI16S',
    'DO16',
    'DO16-i',
    'DO8S',
    'AI16',
    'AI16-i',
    'AO8',
    'RT8',
    'EAP',
    'COM',
    'Printer',
    'Monitor',
    'EAS',
    'Keyboard',
    'Mouse',
    'BaseBoard',
    'AO8',
    ''
     );

  R_ClaimCauseSW : array[Low(TClaimCauseSW)..High(TClaimCauseSW)] of string =
    (
    '',
    ''
     );

procedure SetState2ComboByClaimServiceKind(const ACSK: TClaimServiceKind; ACombo: TComboBox);
function GetCurWorkValueByClaimServiceKindSetAndCurWorkText(const ACSKSet: integer; const ACurWorkStatusText: string): integer;

var
  g_QueryDateType: TLabelledEnum<TQueryDateType>;
  g_HiASFindCondition: TLabelledEnum<THiASFindCondition>;
  g_GSDocType: TLabelledEnum<THiASDocType>;
//  g_ASServiceType: TLabelledEnum<TASServiceType>;
  g_HiconisASState: TLabelledEnum<THiconisASState>;
  g_HiconisASTrigger: TLabelledEnum<THiconisASTrigger>;
  g_ClaimServiceKind: TLabelledEnum<TClaimServiceKind>;
  g_ClaimImportanceKind: TLabelledEnum<TClaimImportanceKind>;
  g_ClaimStatus: TLabelledEnum<TClaimStatus>;

  g_ClaimTypeKind: TLabelledEnum<TClaimTypeKind>;
  g_ClaimCategory: TLabelledEnum<TClaimCategory>;
  g_ClaimLocation: TLabelledEnum<TClaimLocation>;
  g_ClaimCauseKind: TLabelledEnum<TClaimCauseKind>;
  g_ClaimCauseHW: TLabelledEnum<TClaimCauseHW>;
  g_ClaimCauseSW: TLabelledEnum<TClaimCauseSW>;

implementation

uses UnitStateMachineUtil, UnitHiconisMasterRecord;

procedure SetState2ComboByClaimServiceKind(const ACSK: TClaimServiceKind; ACombo: TComboBox);
begin
  case ACSK of
    cskPartSupply: TFSMHelper<THiconisASState,THiconisASTrigger>.GetAllStates2ComboUsingEnumHelper(g_FSM_Mat, g_HiconisASState, ACombo);
    cskPartSupplyNSE: TFSMHelper<THiconisASState,THiconisASTrigger>.GetAllStates2ComboUsingEnumHelper(g_FSM_SE_Mat, g_HiconisASState, ACombo);
    cskSEOnboard: TFSMHelper<THiconisASState,THiconisASTrigger>.GetAllStates2ComboUsingEnumHelper(g_FSM_SE, g_HiconisASState, ACombo);
    cskTechInfo: TFSMHelper<THiconisASState,THiconisASTrigger>.GetAllStates2ComboUsingEnumHelper(g_FSM_TechInfo, g_HiconisASState, ACombo);
    cskOverDue: ;
  end;
end;

function GetCurWorkValueByClaimServiceKindSetAndCurWorkText(const ACSKSet: integer; const ACurWorkStatusText: string): integer;
var
  i: integer;
  LpjhBit32: TpjhBit32;
begin

end;

initialization
//  g_QueryDateType.InitArrayRecord(R_QueryDateType);
//  g_HiASFindCondition.InitArrayRecord(R_HiASFindCondType);
//  g_EngineerKind.InitArrayRecord(R_EngineerKind);
//  g_GSDocType.InitArrayRecord(R_GSDocType);
//  g_SalesProcess.InitArrayRecord(R_SalesProcess);
//  g_SalesProcessType.InitArrayRecord(R_SalesProcessType);
//  g_ProcessDirection.InitArrayRecord(R_ProcessDirection);
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
