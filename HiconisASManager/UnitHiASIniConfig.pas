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
    FOLFolderListFileName
    : string;
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
    [JHPIni('EMail','OLFolderListFileName','OLFolderListFileName.txt','8', tkString)]
    property OLFolderListFileName : string read FOLFolderListFileName write FOLFolderListFileName;
  end;

implementation

end.
