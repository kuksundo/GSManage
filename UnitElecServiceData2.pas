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
    FQtnNo, FOrderNo, FPoNo, FRemoteIPAddress, FClaimNo: string
  end;

  TEngineerKind = (ekNone, ekSuperIntendent, ekServiceEngineer, ekServiceEngineer_Elec, ekTechnician, ekFinal);

//  TGSDocType = (dtNull,
//              dtQuote2Cust4Material, dtQuote2Cust4Service, dtQuoteFromSubCon,
//              dtPOFromCustomer, dtPO2SubCon,
//              dtInvoice2Customer, dtInvoiceFromSubCon,
//              dtSRFromSubCon,
//              dtTaxBill2Customer, dtTaxBillFromSubCon,
//              dtCompanySelection, dtConfirmComplete, dtBudgetApproval,
//              dtContract, dtCert, dtFinal);

  TGSDocType = (dtNull,
              dtClaimReport,
              dtFinal);

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

  TEngineerAgency = (eaNone, eaSubCon, eaHGS, eaHELEC, eaFinal);//�����Ͼ� �Ҽӻ�

  TGSInvoiceItemType = (iitNull, iitServiceReport, iitWork_Week_N, iitWork_Week_OT,
              iitWork_Holiday_N, iitWork_Holiday_OT, iitTravellingHours,
              iitMaterials, iitAirFare, iitAccommodation, iitTransportation,
              iitMeal, iitEtc, iitFinal);

  TCalcInvoiceMethod = (cimNull, cimPerDay, cimPerHour, cimFinal);

  TASServiceChargeType = (assctNull, assctCharged, assctFree, assctFinal);

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
  TDeliveryKind = (dkNull, dkDomesticDelivery, dkOverSeaDelivery, dkFinal);
  TFreeOrCharge = (focNull, focFree, focCharge, focFinal);//��ȯ/��ȯ
  TClaimStatus = (csNull, csOpen, csReady, csDock, csClosed, csFinal);
const
  R_QueryDateType : array[Low(TQueryDateType)..High(TQueryDateType)] of string =
    ('', 'Inq ������ ����', 'Invoice ������ ����', 'QTN �Է��� ����',
      '�����뺸�� �Է��� ����', '');

  R_EngineerKind : array[Low(TEngineerKind)..High(TEngineerKind)] of string =
    ('', 'SuperIntendent', 'Service Engineer', 'Service Engineer(Elec.)',
      'Technician', ''
    );

//  R_GSDocType : array[Low(TGSDocType)..High(TGSDocType)] of string =
//    ('', '��ǰ ������(To ��)', '���� ������(To ��)', '��ǰ ������(From ���»�)',
//      'PO(From ��)', 'PO(To ���»�)', 'Invoice(To ��)', 'Invoice(From ���»�)',
//      'Service Report', '���ݰ�꼭(To ��)', '���ݰ�꼭(From ���»�)',
//      '��ü����ǰ�Ǽ�', '����Ϸ�Ȯ�μ�', '�������ǰ�Ǽ�', '��༭',
//      '������', '');

  R_GSDocType : array[Low(TGSDocType)..High(TGSDocType)] of string =
    ('', 'Claim Report', '');

  R_SalesProcess : array[Low(TSalesProcess)..High(TSalesProcess)] of string =
    ('', '������û���� <- ��', '������û -> ���»�', '�������Լ� <- ���»�',
      '�������ۺ� -> ��', 'SE�İ߿�û���� <- ��', '���ڽ������û -> ��',
      'SE�İ߰��ɹ��� -> ���»�', 'SE�İ߰���Ȯ�� <- ���»�',
      'SE�İ߰����뺸 -> ��', 'PO�����û -> ��', 'SE�İ߿�ûȮ�� <- ��',
      'PO�Լ� <- ��', 'SE�İ߿�û -> ���»�', 'QUOTATION�Է� -> MAPS',
      'QUOTATION���� -> MAPS', '�����뺸���Է� -> MAPS', '�����뺸������ -> MAPS',
      'POR ���� -> MAPS(POR����)', 'POR����Ȯ�� -> Hi-PRO', '�������õ�� -> MAPS',
      '������ -> �ù�', 'AWB�Լ� <- �ù�', 'AWB�ۺ� -> ��', 'SR�Լ� <- ���»�',
      'SR�ۺ� -> ��', 'Invoice�Լ� <- ���»�', 'Invoice�ۺ� -> ��',
      'InvoiceȮ�� <- ��', '�����뺸���ݾ׼��� -> MAPS', '�����뺸������� -> MAPS',
      '����ݾ�Ȯ�� -> MAPS(���������������)', '���ݰ�꼭�����û -> ���»�',
      '���ݰ�꼭���� -> ������', '���ݰ�꼭�Լ� <- ���»�',
      '���ݰ�꼭���� -> �����', '����ó����û -> �����', 'Service-Order �ۺ� -> ���»�',
      'Service-Order �Լ� <- ���»�', '��ü����ǰ�Ǽ� ����', '�۾��Ϸ�');

  R_SalesProcessType : array[Low(TSalesProcessType)..High(TSalesProcessType)] of string =
    ('', '����뿪-�ؿܰ�', '���籸��-�ؿܰ�', '����뿪-������',
      '���籸��-������', '����뿪/���籸��-�ؿܰ�', '����뿪/���籸��-������',
      '����뿪-�ؿܰ�(Field Service)', '����뿪-������(Field Service)',
      '����뿪/���籸��-�ؿܰ�(Field Service)', '����뿪/���籸��-������(Field Service)',
       '');

  R_ProcessDirection : array[Low(TProcessDirection)..High(TProcessDirection)] of string =
    ('', 'To ��', 'From ��', 'To ���»�', 'From ���»�', 'To �����Ϸ�Ʈ��',
      'From �����Ϸ�Ʈ��', 'To HGS', 'From HGS', '');

  R_ContainData4Mail : array[Low(TContainData4Mail)..High(TContainData4Mail)] of string =
    ('', 'Service Report', 'Quotation -> Customer', 'Quotation <- SubCon',
      'PO <- Customer', 'PO <- SubCon', 'Invoice -> Customer', 'Invoice <- SubCon',
      'InvoiceConfirm <- Customer', 'Tax Bill <- SubCon', 'Tax Bill -> Customer',
      'Tax Bill -> Customer');

  R_EngineerAgency : array[Low(TEngineerAgency)..High(TEngineerAgency)] of string =
    ('', '���»�', 'HGS', 'HEE', '');

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
    '����- ��� Tag ����(BMEA-����������â�� �԰�� �ʿ�)',
    '����- �������� ���� From ������(�ؿ� ��۽� CIPL �ۼ��� �ʿ�)',
    '����- �����ù迹��(��ü���ù�)',
    '����- �����ù���ǥó��',
    '����- �ؿ��ù迹��(Fedex)',
    '����- �ؿ��ù���ǥó��',
    '����- Commercial Invoice & Price List(CIPL) �ۼ� �Ϸ�',
    '����- ���� �Լ� �Ϸ� From ������',
    '����- ����+CIPL �ۺ� To ��',
    '����- ������ǰ�Ϸ�',
    '����- �ؿܼ�ǰ�Ϸ�',
    '����- Pick-up ��û To ������(Reclaim ����)',
    '����- �������Ȯ�� From ��',
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
    '����- ��� Tag ��û To ȣ�� �����',
    '���� - �������� ��û To ������',
    '����- �����ù迹��(��ü���ù�)',
    '����- �����ù���ǥó�� ��û',
    '����- �ؿ��ù迹��(Fedex)',
    '����- �ؿ��ù���ǥó�� ��û',
    '����- Commercial Invoice & Price List(CIPL) �ۼ�',
    '����- ���� ��û To ������',
    '����- ����+CIPL �ۺ� To ��',
    '����- ������ǰ',
    '����- �ؿܼ�ǰ',
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

  R_DeliveryKind : array[Low(TDeliveryKind)..High(TDeliveryKind)] of string =
    (
    '',
    '�����ù�',
    '�ؿܿ��',
    ''
     );

  R_FreeOrCharge : array[Low(TFreeOrCharge)..High(TFreeOrCharge)] of string =
    (
    '',
    '����',
    '��ȯ',
    ''
     );

  R_ClaimStatus : array[Low(TClaimStatus)..High(TClaimStatus)] of string =
    (
    '',
    'OPEN',
    'READY',
    'DOCK',
    'CLOSEDC',
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
//  g_ASServiceType: TLabelledEnum<TASServiceType>;
  g_ASServiceChargeType: TLabelledEnum<TASServiceChargeType>;
  g_HiconisASState: TLabelledEnum<THiconisASState>;
  g_HiconisASTrigger: TLabelledEnum<THiconisASTrigger>;
  g_ClaimServiceKind: TLabelledEnum<TClaimServiceKind>;
  g_ClaimImportanceKind: TLabelledEnum<TClaimImportanceKind>;
  g_DeliveryKind: TLabelledEnum<TDeliveryKind>;
  g_FreeOrCharge: TLabelledEnum<TFreeOrCharge>;
  g_ClaimStatus: TLabelledEnum<TClaimStatus>;

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

finalization

end.
