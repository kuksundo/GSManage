unit UnitCertManageConfigClass2;

interface

uses IniPersist, UnitConfigIniClass2, UnitServerConfigBase2;

type
  TCertManageConfig = class(TServerConfigBase)
  private
    FMyEmailAddr,
    FMyOLRecvFolderPath,
    FMyNameSig,
    FMyEmployeeID,
    FMyTeamName,
    FMyDepartmentName,
    FMyCompanyName,
    FOLFolderListFileName
    : string;
  public
    //Section Name, Key Name, Default Key Value  (Control.hint = SectionName;KeyName ���� ���� ��)
    [IniValue('EMail','My Employee ID','HG10411',1)]
    property MyEmployeeID : string read FMyEmployeeID write FMyEmployeeID;
    [IniValue('EMail','My Email Address','jhpark@hyundai-gs.com',2)]
    property MyEmailAddr : string read FMyEmailAddr write FMyEmailAddr;
    [IniValue('EMail','���̸�����','�۷ι���ī������ ������ ����',3)]
    property MyNameSig : string read FMyNameSig write FMyNameSig;
    [IniValue('EMail','My Outlook Recv Folder Path','\\jhpark@hyundai-gs.com\���� ������',4)]
    property MyOLRecvFolderPath : string read FMyOLRecvFolderPath write FMyOLRecvFolderPath;
    [IniValue('EMail','Team Name','�۷ι���ī������',5)]
    property MyTeamName : string read FMyTeamName write FMyTeamName;
    [IniValue('EMail','Department Name','���������',6)]
    property MyDepartmentName : string read FMyDepartmentName write FMyDepartmentName;
    [IniValue('EMail','Company Name','����۷ι�����',7)]
    property MyCompanyName : string read FMyCompanyName write FMyCompanyName;
    [IniValue('EMail','OLFolderListFileName','OLFolderListFileName.txt',8)]
    property OLFolderListFileName : string read FOLFolderListFileName write FOLFolderListFileName;
  end;

var
  FSettings : TCertManageConfig;

implementation

end.
