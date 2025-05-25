unit UnitHiconisASData;

interface

uses System.Classes, UnitEnumHelper, FSMClass_Dic, FSMState, Vcl.StdCtrls,
  JHP.Util.Bit32Helper;

const
  GDC_ADDRESS_HAN = '��걤���� ���� �ŵοշ� 50' + #13#10 + '�۷ι������м���' + #13#10 + '������ å��' + #13#10 + 'REL: 052-204-5280';
  GDC_ADDRESS_ENG = 'GDC 2F, 50 Sinduwang-ro, Nam-Gu, Ulsan, Korea, 44776';

type
  TQueryDateType = (qdtNull,
    qdtMaterialOrder, qdtClaimRecvDate, qdtClaimInputDate, qdtClaimReadyDate,
    qdtClaimClosedDate, qdtAttendScheduled, qdtWorkBeginDate, qdtWorkEndDate,
    qdtModifyDate,
    qdtFinal);

  THiASFindCondition = (hfcNull,
    hfcInputToday,//���� �Է��� Claim
    hfcInputReview,//�Ϸ� �� ���� ~ ���� ���� �Է��� Claim (��CI�� �����ϱ� ���� �˻�-10:30 ~ 11:30)
    hfcUpdateToday,//���� ������ Claim
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
    FIncludeClosed //Closed �� Task�� �����Ͽ� ǥ����
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
    hassNewClaimRecv, //Claim ����
    hassNewClaimRegistered, //Claim ���
    hassNewClaimCancelled, //Claim ���
    hassTSRecv, //Trouble Shoot ����
    hassTSSent, //Trouble Shoot �ۺ�
    hassTechInfoCompleted, //������������Ϸ�
    hassSupplyPart, //���� ����
    hassSEOnboard, //Service Engineer �漱

    hassClaimReviewRecv, //Claim ���� ��� ����

    hassReqQuote4SE, //�뿪 - ������û
    hassConfirmQuote4SE, //�뿪 - ����Ȯ��
    hassAppoveQouto, //�뿪 - ����ǰ��
    hassOrderMade4SubCon, //�뿪 - ���ּ� �ۼ� �Ϸ�
    hassSendOrder2SubCon, //�뿪 - ���ּ� �ۺ�
    hassOnboardSE, //�뿪 - SE �漱

    hassRecvInvoiceFromSubCon, //�뿪 - Invoice ����
    hassReceitProcess,//�뿪 - ��ǥó��

    hassReclaimMatRecv, //���� - Reclaim ���� ����
    hassCheckMatCode,//���� - �ڵ�Ȯ��
    hassIssueMatPOR,//���� - POR ����
    hassCheckMatBudget,//���� - ����Ȯ��(������������)
    hassSendMatPOR,//���� - POR ����(POR�����ǿ��� ������)
    hassReqMatStore, //���� - �԰� ��û
    hassConfirmMatStore, //���� - �԰� Ȯ��
    hassRecvDestAddress2Customer, //���� - ����� �ּ� ����
    hassOrderShipment2BMEA, //���� - �������� To BMEA(����������â��)
    hassOrderShipment2Domestic, //���� - �������� To ���� �����
    hassOrderShipment2Oversea, //���� - �������� To �ؿ� �����
    hassDomesticTranportReq, //���� - ��������Ƿڼ� �ۼ� �Ϸ� �� ǰ��
    hassOverseaTranportReq, //���� - �ؿܿ���Ƿڼ� �ۼ� �Ϸ� �� ǰ��
    hassApprovedDomesticTranportReq, //���� - ��������Ƿڼ� ǰ�� �Ϸ�
    hassApprovedOverseaTranportReq, //���� - �ؿܿ���Ƿڼ� ǰ�� �Ϸ�
    hassDeliveryTagRecv, //����- ��� Tag ����(BMEA-����������â�� �԰�� �ʿ�)
    hassPackingInfoRecv, //����- �������� ���� From ������(�ؿ� ��۽� CIPL �ۼ��� �ʿ�)
    hassDomesticDeliveryReserv, //����- �����ù迹��(��ü���ù�)
    hassDomesticReceitProcess, //����- �����ù���ǥó��
    hassOverseaDeliveryReserv, //����- �ؿ��ù迹��(Fedex)
    hassOverseaReceitProcess, //����- �ؿ��ù���ǥó��
    hassCIPLMade, //����- Commercial Invoice & Price List(CIPL) �ۼ� �Ϸ�
    hassDeliveryInvoiceRecv, //����- ���� �Լ� �Ϸ� From ������
    hassDlvInvoiceNCIPSent, //����- ����+CIPL �ۺ� To ��
    hassDomesticShipmentCompleted, //����- ������ǰ�Ϸ�
    hassOverseaShipmentCompleted, //����- �ؿܼ�ǰ�Ϸ�
    hassPickUpRequested2Logistic, //����- Pick-up ��û To ������(Reclaim ����)
    hassConfirmRecvMatFromCustomer, //����- �������Ȯ�� From ��
    hassConfirmClaimClose, //Claim ���� ���� From ��

    hassClaimClosed, //Claim ����
    hassFinal);

  THiconisASTrigger = (hastNull,
    hastRegister2Maps, //Maps�� ���
    hastCancelRegisgter, //Maps ��� ���

    hastReqClaimReview, //Claim ���� ��û
    hastReqTS2Lab, //Trouble Shooting ��û(�����)
    hastSendTS2Customer, //Trouble Shooting �ۺ� To ��
    hastTechInfo2Customer, //������������Ϸ�

    hastReqQuote4SE, //�뿪 - ������û
    hastConfirmQuote4SE, //�뿪 - ����Ȯ��
    hastAppoveQouto, //�뿪 - ����ǰ��
    hastMakeOrder4SubCon, //�뿪 - ���ּ� �ۼ�
    hastSendOrder2SubCon, //�뿪 - ���ּ� �ۺ�
    hastOnboardSE, //�뿪 - SE �漱
    hastReqInvoiceFromSubCon, //�뿪 - Invoice ��û
    hastReqReceitProcess,//�뿪 - ��ǥó����û(������)

    hastReqReclaimMat, //���� - Reclaim ���� ��û
    hastReqkMatCode,//���� - �ڵ�Ȯ�� ��û
    hastReqIssueMatPOR,//���� - POR ���� ��û
    hastReqCheckMatBudget,//���� - �������� ��û(������������)
    hastSendMatPOR,//���� - POR ����(POR�����ǿ��� ������)
    hastReqMatStore, //���� - �԰� ��û
    hastCofirmMatStore, //���� - �԰� Ȯ��
    hastReqDestAddress2Customer, //���� - ����� �ּ� ���� To ��
    hastOrderShipment2BMEA, //���� - �������� To BMEA(����������â��)
    hastOrderShipment2Domestic, //���� - �������� To ���� �����
    hastOrderShipment2Oversea, //���� - �������� To �ؿ� �����
    hastMakeDomesticTranportReq, //���� - ��������Ƿڼ� �ۼ�
    hastMakeOverseaTranportReq, //���� - �ؿܿ���Ƿڼ� �ۼ�
    hastReqDomesticTranportApproval, //���� - ��������Ƿڼ� ǰ�� ���� ��û
    hastReqOverseaTranportApproval, //���� - �ؿܿ���Ƿڼ� ǰ�� ���� ��û
    hastReqDeliveryTag, //����- ��� Tag ��û To ȣ�� �����
    hastReqPackingInfo2Logistic, //���� - �������� ��û To ������
    hastReqDomesticDeliveryReserv, //����- �����ù迹��(��ü���ù�)
    hastReqDomesticReceitProcess, //����- �����ù���ǥó�� ��û
    hastReqOverseaDeliveryReserv, //����- �ؿ��ù迹��(Fedex)
    hastReqOverseaReceitProcess, //����- �ؿ��ù���ǥó�� ��û
    hastMakeCIPL, //����- Commercial Invoice & Price List(CIPL) �ۼ�
    hastReqDeliveryInvoice, //����- ���� ��û To ������
    hastSendDlvInvoiceNCIP, //����- ����+CIPL �ۺ� To ��
    hastShipmentDomestic, //����- ������ǰ
    hastShipmentOversea, //����- �ؿܼ�ǰ
    hastReqPickUp2Logistic, //����- Pick-up ��û To ������(Reclaim ����)
    hastReqClaimClose2Customer, //Claim ���� ��û To ��
    hastReqConfirmRecvMat2Customer, //�������Ȯ�� ��û To ��
    hastReqClaimClose, //Claim ����

    hastFinal);

  TClaimServiceKind = (cskNull,
    cskPartSupply,//��ǰ ����
    cskPartSupplyNSE,//��ǰ ���� + S/E �漱
    cskSEOnboard,//S/E �漱
    cskTechInfo, //������� ����
    cskOverDue,  //�����Ⱓ ���
    cskByCrew,   //���� ��ġ
    cskOwnerPrepare,//���ֻ� �غ�
    cskYardPrepare, //������ �غ�
    cskPayCompensation,//����� ����
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
      '���������', 'Ŭ����������', 'Ŭ���ӵ����', 'Ŭ������ġ��',
      'Ŭ���ӿϷ���', '�漱������', '�۾�������', '�۾��Ϸ���', 'Ŭ���Ӽ�����', '');

  R_HiASFindCondType : array[Low(THiASFindCondition)..High(THiASFindCondition)] of string =
    ('',
      '���� �Է��� Claim',
      '���� ���� Claim',
      '���� ������ Claim',
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
    'Claim ����',
    'Claim ���',
    'Claim ���',
    'Trouble Shoot ����',
    'Trouble Shoot �ۺ�',
    '�����������',
    '���� ����',
    'Service Engineer �漱',

    'Claim ���� ��� ����',

    '�뿪 - ������û',
    '�뿪 - ����Ȯ��',
    '�뿪 - ����ǰ��',
    '�뿪 - ���ּ� �ۼ� �Ϸ�',
    '�뿪 - ���ּ� �ۺ�',
    '�뿪 - SE �漱',
    '�뿪 - Invoice ����',
    '�뿪 - ��ǥó��',

    '���� - Reclaim ���� ����',
    '���� - �ڵ�Ȯ��',
    '���� - POR ����',
    '���� - ����Ȯ��(������������)',
    '���� - POR ����(POR�����ǿ��� ������)',
    '���� - �԰� ��û',
    '���� - �԰� Ȯ��',
    '���� - ����� �ּ� ����',
    '���� - �������� To BMEA(����������â��)',
    '���� - �������� To ���� �����',
    '���� - �������� To �ؿ� �����',
    '���� - ��������Ƿڼ� �ۼ� �Ϸ� �� ǰ��',
    '���� - �ؿܿ���Ƿڼ� �ۼ� �Ϸ� �� ǰ��',
    '���� - ��������Ƿڼ� ǰ�� �Ϸ�',
    '���� - �ؿܿ���Ƿڼ� ǰ�� �Ϸ�',
    '���� - ��� Tag ����(BMEA-����������â�� �԰�� �ʿ�)',
    '���� - �������� ���� From ������(�ؿ� ��۽� CIPL �ۼ��� �ʿ�)',
    '���� - �����ù迹��(��ü���ù�)',
    '���� - �����ù���ǥó��',
    '���� - �ؿ��ù迹��(Fedex)',
    '���� - �ؿ��ù���ǥó��',
    '���� - Commercial Invoice & Price List(CIPL) �ۼ� �Ϸ�',
    '���� - ���� �Լ� �Ϸ� From ������',
    '���� - ����+CIPL �ۺ� To ��',
    '���� - ������ǰ�Ϸ�',
    '���� - �ؿܼ�ǰ�Ϸ�',
    '���� - Pick-up ��û To ������(Reclaim ����)',
    '���� - �������Ȯ�� From ��',
    'Claim ���� ���� From ��',

    'Claim ����',

    ''
     );

  R_HiconisASTrigger : array[Low(THiconisASTrigger)..High(THiconisASTrigger)] of string =
    (
    '',
    'Maps�� ���',
    'Maps ��� ���',

    'Claim ���� ��û',
    'Trouble Shooting ��û(�����)',
    'Trouble Shooting �ۺ� To ��',
    '������������Ϸ�',

    '�뿪 - ������û',
    '�뿪 - ����Ȯ��',
    '�뿪 - ����ǰ��',
    '�뿪 - ���ּ� �ۼ�',
    '�뿪 - ���ּ� �ۺ�',
    '�뿪 - SE �漱',
    '�뿪 - Invoice ��û',
    '�뿪 - ��ǥó����û(������)',

    '���� - Reclaim ���� ��û',
    '���� - �ڵ�Ȯ�� ��û',
    '���� - POR ���� ��û',
    '���� - �������� ��û(������������)',
    '���� - POR ����(POR�����ǿ��� ������)',
    '���� - �԰� ��û',
    '���� - �԰� Ȯ��',
    '���� - ����� �ּ� ���� To ��',
    '���� - �������� To BMEA(����������â��)',
    '���� - �������� To ���� �����',
    '���� - �������� To �ؿ� �����',
    '���� - ��������Ƿڼ� �ۼ�',
    '���� - �ؿܿ���Ƿڼ� �ۼ�',
    '���� - ��������Ƿڼ� ǰ�� ���� ��û',
    '���� - �ؿܿ���Ƿڼ� ǰ�� ���� ��û',
    '���� - ��� Tag ��û To ȣ�� �����',
    '���� - �������� ��û To ������',
    '���� - �����ù迹��(��ü���ù�)',
    '���� - �����ù���ǥó�� ��û',
    '���� - �ؿ��ù迹��(Fedex)',
    '���� - �ؿ��ù���ǥó�� ��û',
    '���� - Commercial Invoice & Price List(CIPL) �ۼ�',
    '���� - ���� ��û To ������',
    '���� - ����+CIPL �ۺ� To ��',
    '���� - ������ǰ',
    '���� - �ؿܼ�ǰ',
    '����- Pick-up ��û To ������(Reclaim ����)',
    'Claim ���� ��û To ��',
    '�������Ȯ�� ��û To ��',
    'Claim ����',
    ''
     );

  R_ClaimServiceKind : array[Low(TClaimServiceKind)..High(TClaimServiceKind)] of string =
    (
    '',
    '��ǰ ����',
    '��ǰ ���� + S/E �漱',
    'S/E �漱',
    '������� ����',
    '�����Ⱓ ���',
    '���� ��ġ',
    '���ֻ� �غ�',
    '������ �غ�',
    '����� ����',
    ''
     );

  R_ClaimImportanceKind : array[Low(TClaimImportanceKind)..High(TClaimImportanceKind)] of string =
    (
    '',
    'A:����',
    'B:�ֿ�',
    'C:�Ϲ�',
    'D:�ܼ�',
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
