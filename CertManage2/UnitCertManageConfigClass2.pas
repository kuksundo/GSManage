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
    //Section Name, Key Name, Default Key Value  (Control.hint = SectionName;KeyName 으로 저장 함)
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
    property MQProtocol : string read FMQProtocol write FMQProtocol;

    [IniValue('WS Server','WS Server Enabled', 'True',90)]
    property WSEnabled : Boolean read FWSEnabled write FWSEnabled;
    [IniValue('WS Server','WS Server IP Address','127.0.0.1',91)]
    property WSServerIPAddr : string read FWSServerIPAddr write FWSServerIPAddr;
    [IniValue('WS Server','WS Server Port','704',92)]
    property WSServerPort : string read FWSServerPort write FWSServerPort;
    [IniValue('WS Server','WS Server TranmissionKey','OL_PrivateKey',93)]
    property WSServerTransmissionKey : string read FWSServerTransmissionKey write FWSServerTransmissionKey;
    [IniValue('WS Server','Remote Auth Enabled', 'False',94)]
    property RemoteAuthEnabled : Boolean read FRemoteAuthEnabled write FRemoteAuthEnabled;

    [IniValue('Named Pipe Server','Named Pipe Enabled', 'True',100)]
    property NamedPipeEnabled : Boolean read FNamedPipeEnabled write FNamedPipeEnabled;
    [IniValue('Named Pipe Server','Named Pipe Server Name','Mail2CromisIPCServer2',101)]
    property NamedPipeServerName : string read FNamedPipeServerName write FNamedPipeServerName;
    [IniValue('Named Pipe Server','Named Pipe Computer Name','',102)]
    property NamedPipeComputerName : string read FNamedPipeComputerName write FNamedPipeComputerName;

    //Section Name, Key Name, Default Key Value  (Control.hint = SectionName;KeyName 으로 저장 함)
    [IniValue('EMail','My Employee ID','HG10411',1)]
    property MyEmployeeID : string read FMyEmployeeID write FMyEmployeeID;
    [IniValue('EMail','My Email Address','jhpark@hyundai-gs.com',2)]
    property MyEmailAddr : string read FMyEmailAddr write FMyEmailAddr;
    [IniValue('EMail','내이름서명','글로벌아카데미팀 박정현 차장',3)]
    property MyNameSig : string read FMyNameSig write FMyNameSig;
    [IniValue('EMail','My Outlook Recv Folder Path','\\jhpark@hyundai-gs.com\받은 편지함',4)]
    property MyOLRecvFolderPath : string read FMyOLRecvFolderPath write FMyOLRecvFolderPath;
    [IniValue('EMail','Team Name','글로벌아카데미팀',5)]
    property MyTeamName : string read FMyTeamName write FMyTeamName;
    [IniValue('EMail','Department Name','보증기술부',6)]
    property MyDepartmentName : string read FMyDepartmentName write FMyDepartmentName;
    [IniValue('EMail','Company Name','현대글로벌서비스',7)]
    property MyCompanyName : string read FMyCompanyName write FMyCompanyName;
    [IniValue('EMail','OLFolderListFileName','OLFolderListFileName.txt',8)]
    property OLFolderListFileName : string read FOLFolderListFileName write FOLFolderListFileName;
  end;

var
  FSettings : TCertManageConfig;

implementation

end.
