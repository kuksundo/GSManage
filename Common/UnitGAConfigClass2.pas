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
    //Section Name, Key Name, Default Key Value  (Control.hint = SectionName;KeyName ���� ���� ��)
    [IniValue('EMail','My Employee ID','HG10411',7)]
    property MyEmployeeID : string read FMyEmployeeID write FMyEmployeeID;
    [IniValue('EMail','My Email Address','jhpark@hyundai-gs.com',8)]
    property MyEmailAddr : string read FMyEmailAddr write FMyEmailAddr;
    [IniValue('Signature','���̸�����','�۷ι���ī������ ������ ����',9)]
    property MyNameSig : string read FMyNameSig write FMyNameSig;
    [IniValue('EMail','My Outlook Recv Folder Path','\\jhpark@hyundai-gs.com\���� ������',10)]
    property MyOLRecvFolderPath : string read FMyOLRecvFolderPath write FMyOLRecvFolderPath;
    [IniValue('EMail','Team Name','�۷ι���ī������',11)]
    property MyTeamName : string read FMyTeamName write FMyTeamName;
    [IniValue('EMail','Department Name','���������',12)]
    property MyDepartmentName : string read FMyDepartmentName write FMyDepartmentName;
    [IniValue('EMail','Company Name','����۷ι�����',13)]
    property MyCompanyName : string read FMyCompanyName write FMyCompanyName;

    [IniValue('File','OL Folder List File Name','',40)]
    property OLFolderListFileName : string read FOLFolderListFileName write FOLFolderListFileName;
    [IniValue('File','Email DB File Name','',41)]
    property EmailDBFileName : string read FEmailDBFileName write FEmailDBFileName;

    [IniValue('Signature','���� �����','',15)]
    property SalesPICSig : string read FSalesPICSig write FSalesPICSig;
    [IniValue('Signature','���� �����','',16)]
    property ShippingPICSig : string read FShippingPICSig write FShippingPICSig;
    [IniValue('Signature','�ʵ弭�� �����','',17)]
    property FieldServicePICSig : string read FFieldServicePICSig write FFieldServicePICSig;
    [IniValue('Signature','ǥ�ذ��� ��� �����','',18)]
    property HullRegPICSig : string read FHullRegPICSig write FHullRegPICSig;
    [IniValue('Signature','�⼺ó�� �����','',19)]
    property SubConPurchasePICSig : string read FSubConPurchasePICSig write FSubConPurchasePICSig;
  end;

var
  FSettings : TGAConfig;

implementation

end.
