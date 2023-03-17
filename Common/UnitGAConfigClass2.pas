unit UnitGAConfigClass2;

interface

uses IniPersist, UnitConfigIniClass2, UnitServerConfigBase2;

type
  TGAConfig = class(TServerConfigBase)
  private
    FOLFolderListFileName,
    FEmailDBFileName,

    FMyEmailAddr,
    FMyOLRecvFolderPath,
    FMyNameSig,
    FMyEmployeeID,
    FMyTeamName,
    FMyDepartmentName,
    FMyCompanyName,

    FSalesPICSig,
    FShippingPICSig,
    FFieldServicePICSig,
    FHullRegPICSig,
    FSubConPurchasePICSig
    : string;
  public
    //Section Name, Key Name, Default Key Value  (Control.hint = SectionName;KeyName 으로 저장 함)
    [IniValue('EMail','My Employee ID','HG10411',7)]
    property MyEmployeeID : string read FMyEmployeeID write FMyEmployeeID;
    [IniValue('EMail','My Email Address','jhpark@hyundai-gs.com',8)]
    property MyEmailAddr : string read FMyEmailAddr write FMyEmailAddr;
    [IniValue('Signature','내이름서명','글로벌아카데미팀 박정현 차장',9)]
    property MyNameSig : string read FMyNameSig write FMyNameSig;
    [IniValue('EMail','My Outlook Recv Folder Path','\\jhpark@hyundai-gs.com\받은 편지함',10)]
    property MyOLRecvFolderPath : string read FMyOLRecvFolderPath write FMyOLRecvFolderPath;
    [IniValue('EMail','Team Name','글로벌아카데미팀',11)]
    property MyTeamName : string read FMyTeamName write FMyTeamName;
    [IniValue('EMail','Department Name','보증기술부',12)]
    property MyDepartmentName : string read FMyDepartmentName write FMyDepartmentName;
    [IniValue('EMail','Company Name','현대글로벌서비스',13)]
    property MyCompanyName : string read FMyCompanyName write FMyCompanyName;

    [IniValue('File','OL Folder List File Name','',40)]
    property OLFolderListFileName : string read FOLFolderListFileName write FOLFolderListFileName;
    [IniValue('File','Email DB File Name','',41)]
    property EmailDBFileName : string read FEmailDBFileName write FEmailDBFileName;

    [IniValue('Signature','매출 담당자','',15)]
    property SalesPICSig : string read FSalesPICSig write FSalesPICSig;
    [IniValue('Signature','출하 담당자','',16)]
    property ShippingPICSig : string read FShippingPICSig write FShippingPICSig;
    [IniValue('Signature','필드서비스 담당자','',17)]
    property FieldServicePICSig : string read FFieldServicePICSig write FFieldServicePICSig;
    [IniValue('Signature','표준공사 등록 담당자','',18)]
    property HullRegPICSig : string read FHullRegPICSig write FHullRegPICSig;
    [IniValue('Signature','기성처리 담당자','',19)]
    property SubConPurchasePICSig : string read FSubConPurchasePICSig write FSubConPurchasePICSig;
  end;

var
  FSettings : TGAConfig;

implementation

end.
