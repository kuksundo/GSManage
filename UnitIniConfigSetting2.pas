unit UnitIniConfigSetting2;

interface

uses IniPersist, UnitConfigIniClass2;

type
  TConfigSettings = class (TINIConfigBase)
  private
//    FMQServerEnable,
    FMQServerIP,
    FMQServerPort,
    FMQServerUserId,
    FMQServerPasswd,
    FMQServerTopic,
    FParamFileName,

    FSalesDirectorEmailAddr,
    FMaterialInputEmailAddr,
    FForeignInputEmailAddr,
    FElecHullRegEmailAddr,
    FShippingReqEmailAddr,
    FFieldServiceReqEmailAddr,
    FSubConPaymentEmailAddr,
    FMyNameSig,
    FShippingPICSig,
    FSalesPICSig,
    FFieldServicePICSig,
    FElecHullRegPICSig,
    FSubConPaymentPICSig,

    FWSServerPort
    : string;
    FWSEnabled, FRemoteAuthEnabled: Boolean;
  public
    //Section Name, Key Name, Default Key Value  (Control.hint = SectionName;KeyName ���� ���� ��)
//    [IniValue('MQ Server','MQ Server Enable', 'False')]
//    property MQServerEnable : string read FMQServerEnable write FMQServerEnable;
    [IniValue('MQ Server','MQ Server IP','10.14.21.117',1)]
    property MQServerIP : string read FMQServerIP write FMQServerIP;
    [IniValue('MQ Server','MQ Server Port','61613',2)]
    property MQServerPort : string read FMQServerPort write FMQServerPort;
    [IniValue('MQ Server','MQ Server UserId','pjh',3)]
    property MQServerUserId : string read FMQServerUserId write FMQServerUserId;
    [IniValue('MQ Server','MQ Server Passwd','pjh',4)]
    property MQServerPasswd : string read FMQServerPasswd write FMQServerPasswd;
    [IniValue('MQ Server','MQ Server Topic','',5)]
    property MQServerTopic : string read FMQServerTopic write FMQServerTopic;
    [IniValue('File','Param File Name','',6)]
    property ParamFileName : string read FParamFileName write FParamFileName;

    [IniValue('EMail','����ó�������','seonyunshin@hyundai-gs.com',7)]
    property SalesDirectorEmailAddr : string read FSalesDirectorEmailAddr write FSalesDirectorEmailAddr;
    [IniValue('EMail','���������Դ����','geunhyuk.lim@pantos.com',8)]
    property MaterialInputEmailAddr : string read FMaterialInputEmailAddr write FMaterialInputEmailAddr;
    [IniValue('EMail','��ü��ϴ����','seryeongkim@hyundai-gs.com',9)]
    property ForeignInputEmailAddr : string read FForeignInputEmailAddr write FForeignInputEmailAddr;
    [IniValue('EMail','ǥ�ذ����ϴ����','seryeongkim@hyundai-gs.com',10)]
    property ElecHullRegEmailAddr : string read FElecHullRegEmailAddr write FElecHullRegEmailAddr;
    [IniValue('EMail','���Ͽ�û�����','yungem.kim@pantos.com',11)]
    property ShippingReqEmailAddr : string read FShippingReqEmailAddr write FShippingReqEmailAddr;
    [IniValue('EMail','�ʵ弭�񽺴����','yongjunelee@hyundai-gs.com',12)]
    property FieldServiceReqEmailAddr : string read FFieldServiceReqEmailAddr write FFieldServiceReqEmailAddr;
    [IniValue('Signature','���̸�����','��ǰ����2�� ������ ����',13)]
    property MyNameSig : string read FMyNameSig write FMyNameSig;
    [IniValue('Signature','���ϴ���ڼ���','���佺 ������ ���Ӵ�',14)]
    property ShippingPICSig : string read FShippingPICSig write FShippingPICSig;
    [IniValue('Signature','�������ڼ���','��ǰ����2�� �ż�����',15)]
    property SalesPICSig : string read FSalesPICSig write FSalesPICSig;
    [IniValue('Signature','�ʵ弭�񽺴���ڼ���','�ʵ弭���� �̿��� �����',16)]
    property FieldServicePICSig : string read FFieldServicePICSig write FFieldServicePICSig;
    [IniValue('Signature','ǥ�ذ����ϴ���ڼ���','ICT�� �輼�� �����',17)]
    property ElecHullRegPICSig : string read FElecHullRegPICSig write FElecHullRegPICSig;
    [IniValue('EMail','�⼺ó�������','mjsong@hyundai-gs.com',18)]
    property SubConPaymentEmailAddr : string read FSubConPaymentEmailAddr write FSubConPaymentEmailAddr;
    [IniValue('Signature','�⼺ó������ڼ���','�ʵ弭���� �۹��� �����',19)]
    property SubConPaymentPICSig : string read FSubConPaymentPICSig write FSubConPaymentPICSig;

    [IniValue('WS Server','WS Server Port','2018',20)]
    property WSServerPort : string read FWSServerPort write FWSServerPort;
    [IniValue('WS Server','WS Server Enabled', 'True',21)]
    property WSEnabled : Boolean read FWSEnabled write FWSEnabled;
    [IniValue('WS Server','Remote Auth Enabled', 'False',22)]
    property RemoteAuthEnabled : Boolean read FRemoteAuthEnabled write FRemoteAuthEnabled;
  end;

implementation

end.
