unit UnitCertManageConfigClass2;

interface

uses IniPersist, UnitConfigIniClass2, UnitServerConfigBase2;

type
  TCertManageConfig = class(TServerConfigBase)
  private
    FMQServerEnable: Boolean;
    FMQServerIP,
    FMQServerPort,
    FMQServerUserId,
    FMQServerPasswd,
    FMQServerTopic,
    FMQProtocol,

    FNamedPipeServerName,
    FNamedPipeComputerName,
    FWSServerIPAddr,
    FWSServerPort,
    FWSServerTransmissionKey
    : string;
    FNamedPipeEnabled,
    FWSEnabled, FRemoteAuthEnabled: Boolean;

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
    [IniValue('MQ Server','MQ Server Enable', 'False', 80)]
    property MQServerEnable : Boolean read FMQServerEnable write FMQServerEnable;
    [IniValue('MQ Server','MQ Server IP','10.14.21.117',81)]
    property MQServerIP : string read FMQServerIP write FMQServerIP;
    [IniValue('MQ Server','MQ Server Port','61613',82)]
    property MQServerPort : string read FMQServerPort write FMQServerPort;
    [IniValue('MQ Server','MQ Server UserId','pjh',83)]
    property MQServerUserId : string read FMQServerUserId write FMQServerUserId;
    [IniValue('MQ Server','MQ Server Passwd','pjh',84)]
    property MQServerPasswd : string read FMQServerPasswd write FMQServerPasswd;
    [IniValue('MQ Server','MQ Server Topic','',85)]
    property MQServerTopic : string read FMQServerTopic write FMQServerTopic;
    [IniValue('MQ Server','MQ Server Protocol', 'AMQP', 86)]




    [IniValue('WS Server','WS Server IP Address','127.0.0.1',91)]

    [IniValue('WS Server','WS Server Port','704',92)]

    [IniValue('WS Server','WS Server TranmissionKey','OL_PrivateKey',93)]

    [IniValue('WS Server','Remote Auth Enabled', 'False',94)]


    [IniValue('Named Pipe Server','Named Pipe Enabled', 'True',100)]

    [IniValue('Named Pipe Server','Named Pipe Server Name','Mail2CromisIPCServer2',101)]

    [IniValue('Named Pipe Server','Named Pipe Computer Name','',102)]


    //Section Name, Key Name, Default Key Value  (Control.hint = SectionName;KeyName ���� ���� ��)
    [IniValue('EMail','My Employee ID','HG10411',1)]
    property MyEmployeeID : string read FMyEmployeeID write FMyEmployeeID;
    [IniValue('EMail','My Email Address','jhpark@hyundai-gs.com',2)]

    [IniValue('EMail','���̸�����','�۷ι���ī������ ������ ����',3)]

    [IniValue('EMail','My Outlook Recv Folder Path','\\jhpark@hyundai-gs.com\���� ������',4)]

    [IniValue('EMail','Team Name','�۷ι���ī������',5)]

    [IniValue('EMail','Department Name','���������',6)]

    [IniValue('EMail','Company Name','����۷ι�����',7)]

    [IniValue('EMail','OLFolderListFileName','OLFolderListFileName.txt',8)]

  end;

var
  FSettings : TCertManageConfig;

implementation

end.