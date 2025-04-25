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
    FReqBudgetIncreaseMailFN,//부품예산증액 요청 Mail원본
    FReqPartsInputMailFN,//자재입고 요청 Mail원본
    FDIModuleRecallStatusFN, //DI 모듈 리콜 현황 리스트 파일(Json 형식)
    FReqAttendReviewFN,//방선가능 검토 요청

    FPurchasePIC,     //구매담당자 이메일 주소
    FDirectDeliverPIC,//자재직투입담당자 이메일 주소
    FInputPIC,        //입고담당자 이메일 주소
    FShippingPIC,     //출하담당자 이메일 주소
    FBudgetPIC,       //부품예산담당자 이메일 주소
    FServicePIC,      //방선엔지니어담당자 이메일 주소
    FLogisticPIC,     //물류담당자 이메일 주소
    FTechnicalPIC,    //기술담당자 이메일 주소(장주호CI)
    FASDocBaseDir     //AS용 문서(CIPL/Shipping Mark/인수증/공사완료확인서) 저장 폴더
    : string;
  public
    FHullNo, FShipName, FProjNo, FClaimNo, FText, FSubject, FPrice, FAgentDetail, FComissionCompany, FPlace, FServiceDate: string;
    FPorNo4PrjIsChanged: Boolean;
  published
    //Section Name, Key Name, Default Key Value  (Control.hint = SectionName;KeyName 으로 저장 함)
    [JHPIni('EMail','My Employee ID','A379042','1', tkString)]
    property MyEmployeeID : string read FMyEmployeeID write FMyEmployeeID;
    [JHPIni('EMail','My Email Address','great.park@hd.com','2', tkString)]
    property MyEmailAddr : string read FMyEmailAddr write FMyEmailAddr;
    [JHPIni('EMail','내이름서명','박정현 책임','3', tkString)]
    property MyNameSig : string read FMyNameSig write FMyNameSig;
    [JHPIni('EMail','My Outlook Recv Folder Path','\\great.park@hd.com\받은 편지함','4', tkString)]
    property MyOLRecvFolderPath : string read FMyOLRecvFolderPath write FMyOLRecvFolderPath;
    [JHPIni('EMail','Team Name','커미셔닝AS팀','5', tkString)]
    property MyTeamName : string read FMyTeamName write FMyTeamName;
    [JHPIni('EMail','Department Name','디지털제어설계부','6', tkString)]
    property MyDepartmentName : string read FMyDepartmentName write FMyDepartmentName;
    [JHPIni('EMail','Company Name','HD현대마린솔루션','7', tkString)]
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
