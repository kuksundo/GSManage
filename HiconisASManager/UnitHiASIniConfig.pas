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

    [JHPIni('EMail','���̸�����','������ å��','3', tkString)]

    [JHPIni('EMail','My Outlook Recv Folder Path','\\great.park@hd.com\���� ������','4', tkString)]

    [JHPIni('EMail','Team Name','Ŀ�̼Ŵ�AS��','5', tkString)]

    [JHPIni('EMail','Department Name','������������','6', tkString)]

    [JHPIni('EMail','Company Name','HD���븶���ַ��','7', tkString)]

    [JHPIni('EMail','OLFolderListFileName','OLFolderListFileName.txt','8', tkString)]

  end;

implementation

end.