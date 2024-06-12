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
    hassTSSent, //Trouble Shoot �ۺ�
    hassSupplyPart, //���� ����
    hassSEOnboard, //Service Engineer �漱
    hassReqQuote4SE, //�뿪 - ������û
    hassConfirmQuote4SE, //�뿪 - ����Ȯ��
    hassAppoveQouto, //�뿪 - ����ǰ��
    hassSendOrder2SubCon, //�뿪 - ���ּ� �ۺ�
    hassReceitProcess,//�뿪 - ��ǥó��
    hassCheckMatCode,//���� - �ڵ�Ȯ��
    hassIssueMatPOR,//���� - POR ����
    hassCheckMatBudget,//���� - ����Ȯ��(������������)
    hassSendMatPOR,//���� - POR ����(POR�����ǿ��� ������)
    hassClaimClosed, //Claim ����
    hassFinal);

  THiconisASTrigger = (hastNull,
    hastRegister2Maps, //Maps�� ���
    hastCancelRegisgter, //Maps ��� ���
    hastReqTS2Lab, //Trouble Shooting ��û(�����)
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
const
  R_QueryDateType : array[Low(TQueryDateType)..High(TQueryDateType)] of string =
    ('', 'Inq ������ ����', 'Invoice ������ ����', 'QTN �Է��� ����',
      '�����뺸�� �Է��� ����', '');

  R_EngineerKind : array[Low(TEngineerKind)..High(TEngineerKind)] of string =
    ('', 'SuperIntendent', 'Service Engineer', 'Service Engineer(Elec.)',
      'Technician', ''
    );

  R_GSDocType : array[Low(TGSDocType)..High(TGSDocType)] of string =
    ('', '��ǰ ������(To ��)', '���� ������(To ��)', '��ǰ ������(From ���»�)',
      'PO(From ��)', 'PO(To ���»�)', 'Invoice(To ��)', 'Invoice(From ���»�)',
      'Service Report', '���ݰ�꼭(To ��)', '���ݰ�꼭(From ���»�)',
      '��ü����ǰ�Ǽ�', '����Ϸ�Ȯ�μ�', '�������ǰ�Ǽ�', '��༭',
      '������', '');

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

  R_ASServiceType : array[Low(TASServiceType)..High(TASServiceType)] of string =
    (
    '',
    ''
     );

  R_HiconisASState : array[Low(THiconisASState)..High(THiconisASState)] of string =
    (
    '',
    'Claim ����',
    'Claim ���',
    'Claim ���',
    'Trouble Shoot �ۺ�',
    '���� ����',
    'Service Engineer �漱',
    '�뿪 - ������û',
    '�뿪 - ����Ȯ��',
    '�뿪 - ����ǰ��',
    '�뿪 - ���ּ� �ۺ�',
    '�뿪 - ��ǥó��',
    '���� - �ڵ�Ȯ��',
    '���� - POR ����',
    '���� - ����Ȯ��(������������)',
    '���� - POR ����(POR�����ǿ��� ������)',
    'Claim ����',
    ''
     );

  R_HiconisASTrigger : array[Low(THiconisASTrigger)..High(THiconisASTrigger)] of string =
    (
    '',
    'Maps�� ���',
    'Maps ��� ���',
    'Trouble Shooting ��û(�����)',
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
