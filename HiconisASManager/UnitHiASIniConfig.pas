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

    FPurchasePIC,     //구매담당자 이메일 주소
    FDirectDeliverPIC,//자재직투입담당자 이메일 주소
    FInputPIC,        //입고담당자 이메일 주소
    FShippingPIC,     //출하담당자 이메일 주소
    FBudgetPIC,       //부품예산담당자 이메일 주소
    FServicePIC       //방선엔지니어담당자 이메일 주소
    : string;
  public
    FHullNo, FShipName, FProjNo: string;
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

    [JHPIni('File','OLFolderListFileName','OLFolderListFileName.txt','21', tkString)]
    property OLFolderListFileName : string read FOLFolderListFileName write FOLFolderListFileName;
    [JHPIni('File','ReqBudgetIncreaseMailFN','ReqBudgetIncreaseMailFN.txt','22', tkString)]
    property ReqBudgetIncreaseMailFN : string read FReqBudgetIncreaseMailFN write FReqBudgetIncreaseMailFN;
  end;

implementation

end.
