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

    [IniValue('Signature','���̸�����','�۷ι���ī������ ������ ����',9)]

    [IniValue('EMail','My Outlook Recv Folder Path','\\jhpark@hyundai-gs.com\���� ������',10)]

    [IniValue('EMail','Team Name','�۷ι���ī������',11)]

    [IniValue('EMail','Department Name','���������',12)]

    [IniValue('EMail','Company Name','����۷ι�����',13)]




    [IniValue('File','Email DB File Name','',41)]




    [IniValue('Signature','���� �����','',16)]

    [IniValue('Signature','�ʵ弭�� �����','',17)]

    [IniValue('Signature','ǥ�ذ��� ��� �����','',18)]

    [IniValue('Signature','�⼺ó�� �����','',19)]

  end;

var
  FSettings : TGAConfig;

implementation

end.