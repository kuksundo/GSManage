unit UnitHiASIniConfig;

interface

uses TypInfo, UnitIniAttriPersist, UnitIniConfigBase;

type
  THiASIniConfig = class(TJHPIniConfigBase)
    FMyEmailAddr,
    FMyOLRecvFolderPath,
    FMyNameSig,
    FMyEmployeeID,
    FMyTeamName,
    FMyDepartmentName,
    FMyCompanyName,
    FOLFolderListFileName,
    FReqBudgetIncreaseMailFN,//��ǰ�������� ��û Mail����
    FReqPartsInputMailFN,//�����԰� ��û Mail����
    FDIModuleRecallStatusFN, //DI ��� ���� ��Ȳ ����Ʈ ����(Json ����)
    FReqAttendReviewFN,//�漱���� ���� ��û

    FPurchasePIC,     //���Ŵ���� �̸��� �ּ�
    FDirectDeliverPIC,//���������Դ���� �̸��� �ּ�
    FInputPIC,        //�԰����� �̸��� �ּ�
    FShippingPIC,     //���ϴ���� �̸��� �ּ�
    FBudgetPIC,       //��ǰ�������� �̸��� �ּ�
    FServicePIC,      //�漱�����Ͼ����� �̸��� �ּ�
    FLogisticPIC,     //��������� �̸��� �ּ�
    FTechnicalPIC,    //�������� �̸��� �ּ�(����ȣCI)
    FASDocBaseDir     //AS�� ����(CIPL/Shipping Mark/�μ���/����Ϸ�Ȯ�μ�) ���� ����
    : string;
  public
    FHullNo, FShipName, FProjNo, FClaimNo, FText, FSubject, FPrice, FAgentDetail, FComissionCompany, FPlace, FServiceDate: string;
    FPorNo4PrjIsChanged: Boolean;
  published
    //Section Name, Key Name, Default Key Value  (Control.hint = SectionName;KeyName ���� ���� ��)
    [JHPIni('EMail','My Employee ID','A379042','1', tkString)]
    property MyEmployeeID : string read FMyEmployeeID write FMyEmployeeID;
    [JHPIni('EMail','My Email Address','great.park@hd.com','2', tkString)]
    property MyEmailAddr : string read FMyEmailAddr write FMyEmailAddr;
    [JHPIni('EMail','���̸�����','������ å��','3', tkString)]
    property MyNameSig : string read FMyNameSig write FMyNameSig;
    [JHPIni('EMail','My Outlook Recv Folder Path','\\great.park@hd.com\���� ������','4', tkString)]
    property MyOLRecvFolderPath : string read FMyOLRecvFolderPath write FMyOLRecvFolderPath;
    [JHPIni('EMail','Team Name','Ŀ�̼Ŵ�AS��','5', tkString)]
    property MyTeamName : string read FMyTeamName write FMyTeamName;
    [JHPIni('EMail','Department Name','������������','6', tkString)]
    property MyDepartmentName : string read FMyDepartmentName write FMyDepartmentName;
    [JHPIni('EMail','Company Name','HD���븶���ַ��','7', tkString)]
    property MyCompanyName : string read FMyCompanyName write FMyCompanyName;

    [JHPIni('Signature','PurchasePIC','PurchasePIC','11', tkString)]
    property PurchasePIC : string read FPurchasePIC write FPurchasePIC;
    [JHPIni('Signature','DirectDeliverPIC','DirectDeliverPIC','12', tkString)]
    property DirectDeliverPIC : string read FDirectDeliverPIC write FDirectDeliverPIC;
    [JHPIni('Signature','InputPIC','InputPIC','13', tkString)]
    property InputPIC : string read FInputPIC write FInputPIC;
    [JHPIni('Signature','ShippingPIC','ShippingPIC','14', tkString)]
    property ShippingPIC : string read FShippingPIC write FShippingPIC;
    [JHPIni('Signature','BudgetPIC','BudgetPIC','15', tkString)]
    property BudgetPIC : string read FBudgetPIC write FBudgetPIC;
    [JHPIni('Signature','ServicePIC','ServicePIC','16', tkString)]
    property ServicePIC : string read FServicePIC write FServicePIC;
    [JHPIni('Signature','LogisticPIC','LogisticPIC','17', tkString)]
    property LogisticPIC : string read FLogisticPIC write FLogisticPIC;
    [JHPIni('Signature','TechnicalPIC','TechnicalPIC','18', tkString)]
    property TechnicalPIC : string read FTechnicalPIC write FTechnicalPIC;

    [JHPIni('File','OLFolderListFileName','OLFolderListFileName.txt','21', tkString)]
    property OLFolderListFileName : string read FOLFolderListFileName write FOLFolderListFileName;
    [JHPIni('File','ReqBudgetIncreaseMailFN','ReqBudgetIncreaseMailFN.txt','22', tkString)]
    property ReqBudgetIncreaseMailFN : string read FReqBudgetIncreaseMailFN write FReqBudgetIncreaseMailFN;
    [JHPIni('File','ReqPartsInputMailFN','ReqPartsInputMailFN.txt','23', tkString)]
    property ReqPartsInputMailFN : string read FReqPartsInputMailFN write FReqPartsInputMailFN;
    [JHPIni('File','DIModuleRecallStatusFN','DIModuleRecallStatusFN.txt','29', tkString)]
    property DIModuleRecallStatusFN : string read FDIModuleRecallStatusFN write FDIModuleRecallStatusFN;
    [JHPIni('File','ReqAttendReviewFN','ReqAttendReviewFN.txt','30', tkString)]
    property ReqAttendReviewFN : string read FReqAttendReviewFN write FReqAttendReviewFN;
    [JHPIni('File','ASDocBaseDir','C:\Users\HHI\Documents\HiCONIS\','31', tkString)]
    property ASDocBaseDir : string read FASDocBaseDir write FASDocBaseDir;
  end;

implementation

end.
