unit UnitHiconMPMData;

interface

uses System.Classes, System.SysUtils, UnitEnumHelper,
  mormot.core.variants, mormot.core.unicode, mormot.core.json;

const
  //ȣ���� Hiconis Backup �������� MPM ���� ������� ��ġ ����
  DOWNLOAD_FULL_PATH = 'E:\pjh\Doc\HiCONIS\project\HMD8310\ACONIS-NX\DB\DOWNLOAD\';

type
  TCheckMemRange = packed record
    FFnCode: string;
    FStAddr, FCount, FInBlkAddr, FTagInBlkAddr, FTagSubPos: word;
  end;

  TTagDataSrcRec = packed record
    FCheckMemRange,//: TCheckMemRange;
    FTagInfoJson,
    FInterfaceJosnValue,
    FPtcJsonValue,
    FChannelJsonValue,
    FSystemName,
    FMPMName,
    FIOCardName,
    FCardNum,
    FInfAddr, //SlotID
    FCOMAddr, //modbus address/nmea name/
    FChannelProt, //UART/TCP/UDP
    FChannelNo1,//MPM/COM card primary channel no
    FChannelNo2,//MPM/COM card secondary channel no
    FTerminalNo,
    FValue
    : string;
  end;

{$REGION 'TTAGINFO'}
  //System_bak.accdb->INF table���� ������
  TTagInfoRec_INF = packed record
    TAG_NAME,
    DESCRIPTION,
    RESOURCE,
    SLOT,
    DIR,
    &TYPE,
    ADDR,
    SUB_POS
    : string;
  end;

  //TagName�� ����� ModbusMaster ����
  TTagInfoRec_ModbusMaster = packed record
    TagInfoRec_INF: TTagInfoRec_INF;
    MPMName,
    IOCardType,
    ChannelNo
    : string;
  end;

  //TagName�� ����� ModbusSlave ����
  TTagInfoRec_ModbusSlave = packed record
    TagInfoRec_INF: TTagInfoRec_INF;
    MPMName,
    IOCardType,
    ChannelNo
    : string;
  end;

  //TagName�� ����� NMEA ����
  TTagInfoRec_NMEA = packed record
    TagInfoRec_INF: TTagInfoRec_INF;
    MPMName,
    IOCardType,
    ChannelNo
    : string;
  end;

  //TagName�� ����� Profibus ����
  TTagInfoRec_Profibus = packed record
    TagInfoRec_INF: TTagInfoRec_INF;
    MPMName
    : string;
  end;

  //TagName�� ����� H/W ����
  TTagInfoRec_INF_HW= packed record
    TagInfoRec_INF: TTagInfoRec_INF;
    MPMName,
    IOCardType,
    ChannelNo
    : string;
  end;
{$ENDREGION}

{$REGION 'TMPM_Channel_Json'}
  //channel.json�� "UART" field value = �迭���� 1�� ���� Json Value
  TMPM_Channel_UART_Obj = packed record
    ChNum,//"1",
    &Type,//"RS485",
    Baudrate,//"9600b",
    DataBit,//"8",
    StopBit,//"1",
    Parity,//"none",
    Termination//"OFF"
    : string;
  end;

  //channel.json�� "UART" field value = �迭��
  TMPM_Channel_UART = array of TMPM_Channel_UART_Obj;

  TMPM_Channel_TCP = packed record
    ChNum,
    MyPort,
    RemoteIP,
    RemotePort
    : string;
  end;

  TMPM_Channel = packed record
    DBTime,
    DBVer
    : string;
    UART: array of TMPM_Channel_UART;
    TCP,
    UDP: array of TMPM_Channel_TCP;
  end;
{$ENDREGION}

{$REGION 'TMPM_Interface_Json'}
  //interface.json�� "Portx" field value
  TPort_Interface = packed record
    SystemName,// "LOADING_COM",
    InfADDR,// "72",
    RedundancyCard,// "false",
    RedundancyCh,// "false",
    PtType,// "modbus_master",
    ScriptUse,// "false",
    ByteOrder,// "default",
    ChType,// "uart",
    PriCh,// "3",
    SecCh,// "2",
    ClnUse,// "false",
    ClnBlkStart,// "0",
    ClnBlkCnt,// "0",
    ClnPer,// "0",
    ClnP1,// "0",
    ClnP2,// "0",
    ClnP3// "0"
    : string;
  end;

  //interface.json�� "TimeInfo" field value
  TTimeInfoRec_Interface = packed record
    Use,// "true",
    PortNum,// "2",
    InBlkAddr,// "50",
    &Type// "zda_time"
    : string;
  end;

  TMPM_Interface = packed record
    DBTime,
    DBVer,
	  RedundancyCardNum
    : string;
	  TimeInfo: TTimeInfoRec_Interface;
  end;
{$ENDREGION}

{$REGION 'TPort_Profibus_Json'}
  TPort_Profibus_Slave_Module = packed record
    Slot,
    InByteSize
    : string;
  end;

  TPort_Profibus_Slave = packed record
    Addr,
    AlarmBit
    : string;
    Module: array of TPort_Profibus_Slave_Module;
  end;

  TPort_Profibus = packed record
    DBTime,
    DBVer,
    InBlkAddr,
    InBlkSize,
    OutBlkAddr,
    OutBlkSize,
    Vendor,
    DiagBlkAddr
    : string;
    Slave: array of TPort_Profibus_Slave;
  end;
{$ENDREGION}

{$REGION 'TPort_xx_NMEA'}
  TPort_xx_NMEA_Bypass = packed record
    ChType,//"UDP"
    PriCh, //"3"
    PtType //"aconis_com"
    : string;
  end;

  TPort_xx_NMEA_Sentence_Field = packed record
    Num,
    FType,
    Mapping
    : string;
  end;

  TPort_xx_NMEA_Sentence = packed record
    Dir,//"out"
    Format,//"ALR"
    Talker,//"PA"
    Opt,//"bypass"
    NumField,//"5"
    AlarmBit//"1"
    : string;

    Field: array of TPort_xx_NMEA_Sentence_Field;
  end;

  TPort_xx_NMEA = packed record
    DBTime,
    DBVer,
    Format,// "ascii"
    PacketStarter,// "$"
    DataEnder,// "*"
    PacketEnder,// "\r\n"
    Separator,// ","
    ErrorCheker,// "check_sum"
    OutPeriod//"1000"
    : string;
    Sentence: array of TPort_xx_NMEA_Sentence;
    StringConvert: string; //array of json object = [{},{}...]
    ByPass: TPort_xx_NMEA_Bypass;
  end;
{$ENDREGION}

{$REGION 'TPort_xx_MODBUS'}
  //ptcxx.json�� "Query" field value for modbus master
  TPort_xx_MODBUS_Query = packed record
    StID,       //"1"
    FncCode,    //"03"
    StAddr,     //"000"
    Count,      //"100"
    InBlkAddr,  //"000"
    Activation, //"polling"
    PerTime,    //"500"
    Timeout,    //"1000"
    RetNum,     //"3"
    AlarmBit,   //"1"
    TxMode      //"all"
    : string;
  end;

  TPort_xx_MODBUS = packed record
    DBTime,
    DBVer,
    RemoteIO
    : string;

    Query: array of TPort_xx_MODBUS_Query;
   end;
{$ENDREGION}

function GetTagInfoRec_INFFromJson(AJson: string): TTagInfoRec_INF;
//AJson: MPM or COM->home\db\interface.josn ���� ����
//Result: Portxx List = {"Port1":{...}, "Port2":{...}, ...}
function GetPortListFromMPMIntfJson(AJson: string): string;
function GetPortDocListFromMPMIntfJson(AJson: string): IDocList;
//AJson: MPM->home\db\interface.josn ���� ����
//Result: Ptc file name list = ["ptc01.json", "ptc02.json", ...]
function GetPtcFileNameListFromMPMIntfJson(AJson: string): string;
//AJson: MPM interface.json contents
//AFileName: *.tgz file name
//Result: {"Resource":"COM011110.tgz"/"MPM11.tgz", "Port":"ptc04.json", "PortValueInf":{...},"BaseDir": "full path"}
function GetTgzNPtcJsonNameFromInterfaceJson(AJson, AFileName, ASlotNo, ABaseDir: string): string;
//Result: {"Resource":"COM011110"/"MPM11", "Port":"ptc04", "PortValueInf":{...},"BaseDir": "full path"}
//Result���� ���� Ȯ���ڰ� ���ŵ�, �������� ���� ������
function GetResNPtcNameFromInterfaceJson(AJson, AFileName, ASlotNo, ABaseDir: string): string;
//AMPMName: MPM11
//Result: COM011xx.tgz List = ["COM01110.tgz", "OOM01120.tgz", ...] Base Dir���� �˻���-
function GetCOMTgzFileNameListByMPMName(AMPMName, ABaseDir: string): TStringList;
//AMPMName: MPM11
//ASlotNo: system_bak.INF table�� SLOT Field ��
//Result: {"Resource":"COM011110"/"MPM11", "Port":"ptc04.json", "PortValueInf":{...},"BaseDir": "full path"}
//       MPM11.tgz�� interface.json�� SlotNo�� �����ϸ� "Resource" = "MPM11" �׷��� �ʰ� "COM011xx.tgz"�� �����ϸ� �Ʒ� ����ó��
//       COM011xx.tgz Name = ASlotNo���� interface.json->"PORTx"->"InfADDR" ���� ��ġ�ؾ� ��
function GetMPMTgzNPtcJsonNameByMPMNameWithSlotNo(AMPMName, ASlotNo, ABaseDir: string): string;
//AMPMName: MPM11
//ASlotNo: system_bak.INF table�� SLOT Field ��
//Result: {"Resource":"COM011110", "Port":"ptc04.json", "PortValueInf":{...},"BaseDir": "full path"}
//       COM011xx.tgz Name = ASlotNo���� interface.json->"PORTx"->"InfADDR" ���� ��ġ�ؾ� ��(�� �Լ��� MPM11.tgz�� Ȯ�� ����)
function GetCOMTgzNPortNameByMPMNameWithSlotNo(AMPMName, ASlotNo, ABaseDir: string): string; overload;
//AJson: THiConSystemDB.GetTagInfo2JsonFromINFTable() ���ϰ�
//Result: ���� ����
function GetCOMTgzNPortNameByMPMNameWithSlotNo(AJson, ABaseDir: string): string; overload;
//AJson: {"Port1":{...}, "Port2":{...}, ...}
//Result: 'Port2' = "InfADDR" ���� ASlotNo �� ���� Port
function GetPortNameFromPortListJsonBySlotNo(AJson, ASlotNo: string): string;
//AJson: {"Port1":{...}, "Port2":{...}, ...}
//Result: '{...}' = "InfADDR" ���� ASlotNo �� ���� Port Value
function GetPortJsonValueFromPortListJsonBySlotNo(AJson, ASlotNo: string): string;
//APortName: "Port4"
//Result: "ptc04.json"
function GetPtcJsonNameByPortName(APortName: string): string;
//AJson: GetCOMTgzNPortNameByMPMNameWithSlotNo()�� �����
//Result: Port json file contents = ptc04.json ����
function GetPtcJsonContentsFromCOMNPortJson(AJson: string): string;
//AJson: GetCOMTgzNPortNameByMPMNameWithSlotNo()�� �����
//Result: Portx Value = interface.json ���뿡�� ���õ� "Portx" key ���� Value�� ��ȯ��
//    "Port4": {
//        "SystemName": "ACSWBD",
//        "InfADDR": "73",
//        "RedundancyCard": "false",
//        "RedundancyCh": "false",
//        "PtType": "modbus_master",
//        "ScriptUse": "false",
//        "ByteOrder": "default",
//        "ChType": "tcp",
//        "PriCh": "4",
//        "SecCh": "2",
//        "ClnUse": "false",
//        "ClnBlkStart": "0",
//        "ClnBlkCnt": "0",
//        "ClnPer": "0",
//        "ClnP1": "0",
//        "ClnP2": "0",
//        "ClnP3": "0"
//    }
function GetPortValueJsonFromCOMNPortJson(AJson: string): string;
//ATagInfoJson: INF Table���� Tag ���� ���� ������
//APortJson: interface.json->Portx value
//APtcJson: ptcxx.json ��ü ����
//Result: APtcJson���� �ּҰ� ���Ͽ� �ش� Query�� ��ȯ
//Result: {"Query":{...}, "ModbusAddr": "3000", "CheckMemRange":{...}}
function GetQueryJsonFromPortNPtcJson(ATagInfoJson, APortJson, APtcJson: string): string;
function SetQueryJsonFromTagDataSrcRec(var ATagDataSrcRec: TTagDataSrcRec): string;
function SetChannelJsonFromTagDataSrcRec(var ATagDataSrcRec: TTagDataSrcRec): string;
function SetChannelInfoFromInterfaceJsonByRec(var ATagDataSrcRec: TTagDataSrcRec): string;
function GetTerminalNoByChType(AChType, AChNo: string): string;

//ATagInfoJson: INF Table���� Tag ���� ���� ������
//AResNPortJson: GetReourceNPortName2JsonByTagInfo() �����
//function GetQueryJsonFromResourceNPortNameByTagInfo(ATagInfoJson, AResNPortJson: string): string;

//ATagInfoJson: INF Table���� Tag ���� ���� ������
//AResNPortJson:
function GetTagDataSrcRecByTagInfo(ATagInfoJson, ABaseDir: string; AIsOnline: Boolean): TTagDataSrcRec;
//ATagInfoJson: INF Table���� Tag ���� ���� ������
//ABaseDir: AIsOnline�� False�� ��� ȣ���� .tgz ������ ����� folder path
//AIsOnline: True = interface.json ������ TCP ��� �����Ͽ� MPM���� Download�Ͽ� c:\temp�� ���� �� ����
//           False= Disk�� ����� .tgz�κ��� interface.json ������ ����
//Result: TagName�� ����� ���Card �� Port �̸��� Json���� ��ȯ��
//{"Resource":"COM011110"/"MPM11"/"FBM11", "Port":"ptc04", "PortValueInf":{...},"PtcValue":{...}, "BaseDir": "full path"}
//"PortValueInf": interface.json->Port Value
//"PtcValue": ptcxx.json->"Query" Value = modbus master�� ���
//                        "Sentence" Value = nmea�� ���
function GetReourceNPortName2JsonByTagInfo(ATagInfoJson, ABaseDir: string; AIsOnline: Boolean=False): string;
function GetResNPortName2JsonByTagInfoFromBackup(ATagInfoJson, ABaseDir: string): string;
function GetResNPortName2JsonByTagInfoFromOnline(ATagInfoJson, ABaseDir: string): string;
function GetTgzNPtcJsonNameByTagInfo(AJson, ABaseDir: string): string;

//Result: {"Query":{...}, "ModbusAddr": "3000", "CheckMemRange":{...}}
function GetQuery4ModbusMasterFromPtcJson(ATagInfoRec: TTagInfoRec_INF; APtcJson: string): string;
function GetQuery4NmeaFromPtcJson(ATagInfoRec: TTagInfoRec_INF; APtcJson: string): string;
function GetQuery4ProfibusFromPtcJson(ATagInfoRec: TTagInfoRec_INF; APtcJson: string): string;

//AInBlkAddr: StrAddr�� ����� InBlkAddr
//ATagInBlkAddr: TagNo�� �Ҵ�� InBlkAddr
//Result: ATagIBlkAddr�� ��ġ�� ������ Modbus Address ��ȯ
//        '' �̸� Range �ȿ� ���ٴ� �ǹ���
function GetModbusAddrByInBlkAddr(ACheckMemRange: TCheckMemRange): string;
function CheckIfAddrInRange4ModbusByInBlkAddr(AFnCode, AStAddr, ACount, AInBlkAddr, ATagInBlkAddr, ATagSubPos: string): Boolean;
function GetCheckMemRangeRec(AFnCode, AStAddr, ACount, AInBlkAddr, ATagInBlkAddr, ATagSubPos: string): TCheckMemRange;

implementation

uses UnitFileSearchUtil, UnitStringUtil, UnitGZipJclUtil, UnitJsonUtil;

function GetPortListFromMPMIntfJson(AJson: string): string;
var
//  LList: IDocList;
  LDict, LDict2: IDocDict;
  i, j: integer;
  LKey: string;
begin
  Result := '';
//  LList := DocList('[]');
  LDict2 := DocDict('{}');
  LDict := DocDict(StringToUtf8(AJson));

  if LDict.Len > 4 then
  begin
    j := 1;

    for i := 4 to LDict.Len - 1 do
    begin
      LKey := 'Port' + IntToStr(j);

      if LDict.Exists(LKey) then
      begin
        LDict2.S[LKey] := LDict[LKey];
//        LList.Append(LDict[LKey]);
      end;

      Inc(j);
    end;

    Result := Utf8ToString(LDict2.Json);
  end;
end;

function GetPortDocListFromMPMIntfJson(AJson: string): IDocList;
begin

end;

function GetPtcFileNameListFromMPMIntfJson(AJson: string): string;
var
  LList: IDocList;
  LDict: IDocDict;
  i, j: integer;
  LKey: string;
begin
  Result := '';
  LList := DocList('[]');
  LDict := DocDict(StringToUtf8(AJson));

  if LDict.Len > 4 then
  begin
    j := 1;

    for i := 4 to LDict.Len - 1 do
    begin
      LKey := 'Port' + IntToStr(j);

      if LDict.Exists(LKey) then
      begin
        LList.Append('ptc'+format('%.2d',[j])+'.json');
      end;

      Inc(j);
    end;

    Result := Utf8ToString(LList.Json);
  end;
end;

function GetCOMTgzFileNameListByMPMName(AMPMName, ABaseDir: string): TStringList;
begin
  AMPMName := RemoveNonDigitsBetweenString(AMPMName);
  AMPMName := 'COM0' + AMPMName + '*.tgz';
  //filename = filesize list ��ȯ
  Result := FindAllFiles(ABaseDir, AMPMName);
end;

function GetTgzNPtcJsonNameFromInterfaceJson(AJson, AFileName, ASlotNo, ABaseDir: string): string;
var
  LJson2, LPortName: string;
  LDict: IDocDict;
begin
  Result := '';
  LDict := DocDict('{}');

  //AJson���� Port List {"Port1":{...}, "Port2":{...}, ...} ������
  LJson2 := GetPortListFromMPMIntfJson(AJson);
  //'Port2' = "InfADDR"
  LPortName := GetPortNameFromPortListJsonBySlotNo(LJson2, ASlotNo);
  LJson2 := GetPortJsonValueFromPortListJsonBySlotNo(LJson2, ASlotNo);

  if LPortName <> '' then
  begin
    AFileName := ExtractFileName(AFileName);
    LDict.S['Resource'] := AFileName; //MPM11
    LDict.S['Port'] := GetPtcJsonNameByPortName(LPortName);//"ptc04.json"
    //interface.json�� Portx Value
    LDict.S['PortValueInf'] := LJson2;
    LDict.S['BaseDir'] := ABaseDir;
    Result := LDict.Json;
  end;
end;

function GetResNPtcNameFromInterfaceJson(AJson, AFileName, ASlotNo, ABaseDir: string): string;
var
  LStr: string;
  LDict: IDocDict;
begin
  Result := '';
  LStr := GetTgzNPtcJsonNameFromInterfaceJson(AJson, AFileName, ASlotNo, ABaseDir);

  if LStr <> '' then
  begin
    LDict := DocDict(LStr);
    LStr := LDict.S['Resource'];
    LDict.S['Resource'] := ChangeFileExt(LStr, '');
    LStr := LDict.S['Port'];
    LDict.S['Port'] := ChangeFileExt(LStr, '');
    Result := Utf8ToString(LDict.Json);
  end;
end;

function GetMPMTgzNPtcJsonNameByMPMNameWithSlotNo(AMPMName, ASlotNo, ABaseDir: string): string;
var
  LStr, LJson, LJson2, LPortName, LFileName: string;
  LDict: IDocDict;
begin
  Result := '';
  LFileName := ABaseDir + AMPMName + '.tgz';

  if FileExists(LFileName) then
  begin
    //MPMxx.tgz file���� 'home\db\interface.json' ������ ������
    LJson := ExtractFromTgz2DirByPackedName(LFileName, '', 'home\db\interface.json');
    //{"Resource":"COM011110"/"MPM11", "Port":"ptc04.json", "PortValueInf":{...},"BaseDir": "full path"}
    Result := GetTgzNPtcJsonNameFromInterfaceJson(LJson, LFileName, ASlotNo, ABaseDir);
  end;
end;

function GetCOMTgzNPortNameByMPMNameWithSlotNo(AMPMName, ASlotNo, ABaseDir: string): string;
var
  LStrList: TStringList;
  LStr, LJson, LJson2, LPortName, LFileName: string;
begin
  Result := '';
  LStrList := GetCOMTgzFileNameListByMPMName(AMPMName, ABaseDir);
  try
    //filename = filesize list ��ȯ
    for LStr in LStrList do
    begin
      LFileName := LStr;
      LFileName := ABaseDir + StrToken(LFileName, '=');
      //COM0xxxx.tgz file���� 'home\db\interface.json' ������ ������
      LJson := ExtractFromTgz2DirByPackedName(LFileName, '', 'home\db\interface.json');
      //{"Resource":"COM011110.tgz"/"MPM11.tgz", "Port":"ptc04.json", "PortValueInf":{...},"BaseDir": "full path"}
//      Result := GetTgzNPtcJsonNameFromInterfaceJson(LJson, LFileName, ASlotNo, ABaseDir);
      //{"Resource":"COM011110"/"MPM11", "Port":"ptc04", "PortValueInf":{...},"BaseDir": "full path"}
      Result := GetResNPtcNameFromInterfaceJson(LJson, LFileName, ASlotNo, ABaseDir);

      if Result <> '' then
        Break;
    end;
  finally
    LStrList.Free;
  end;
end;

function GetCOMTgzNPortNameByMPMNameWithSlotNo(AJson, ABaseDir: string): string;
var
  LMPMName, LSlotNo, LAddr, LSubPos: string;
begin
  LMPMName := GetValueFromJsonDictByKeyName(AJson, 'RESOURCE');
  LSlotNo := GetValueFromJsonDictByKeyName(AJson, 'SLOT');
  LAddr := GetValueFromJsonDictByKeyName(AJson, 'ADDR');
  LSubPos := GetValueFromJsonDictByKeyName(AJson, 'SUB_POS');

  Result := GetCOMTgzNPortNameByMPMNameWithSlotNo(LMPMName, LSlotNo, ABaseDir);
end;

function GetPortNameFromPortListJsonBySlotNo(AJson, ASlotNo: string): string;
var
  LField: TDocDictFields;
  LDict, LDict2: IDocDict;
  LInfADDR: string;
begin
  Result := '';
  LDict := DocDict(AJson);

  for LField in LDict do
  begin
    LDict2 := DocDict(LField.Value);

    if LDict2.Exists('InfADDR') then
    begin
      LInfADDR := LDict2['InfADDR'];

      if LInfADDR = ASlotNo then
      begin
        Result := LField.Key;
        Break;
      end;
    end;
  end; //for
end;

function GetPortJsonValueFromPortListJsonBySlotNo(AJson, ASlotNo: string): string;
var
  LField: TDocDictFields;
  LDict, LDict2: IDocDict;
  LInfADDR: string;
begin
  Result := '';
  LDict := DocDict(AJson);

  for LField in LDict do
  begin
    LDict2 := DocDict(LField.Value);

    if LDict2.Exists('InfADDR') then
    begin
      LInfADDR := LDict2['InfADDR'];

      if LInfADDR = ASlotNo then
      begin
        Result := LDict2.Json;
        Break;
      end;
    end;
  end; //for
end;

function GetPtcJsonNameByPortName(APortName: string): string;
var
  i: integer;
begin
  APortName := RemoveNonDigitsBetweenString(APortName);
  i := StrToIntDef(APortName, 0);
  Result := 'ptc' + Format('%.2d', [i]) + '.json';
end;

//AJson: {"COM":"COM011110.tgz", "Port":"ptc04.json", "PortValueInf":{...},"BaseDir": "full path"}
function GetPtcJsonContentsFromCOMNPortJson(AJson: string): string;
var
  LDict: IDocDict;
  LPtcJsonName, LCOMTgzName, LBaseDir: string;
begin
  Result := '';
  LDict := DocDict(AJson);

  LBaseDir := LDict['BaseDir'];
  LCOMTgzName := LBaseDir + LDict['Resource'] + '.tgz';

  if FileExists(LCOMTgzName) then
  begin
    LPtcJsonName := LDict['Port'];

    //LCOMTgzName(.tgz) ���Ͽ��� LPtcJsonName(.json) ������ c:\temp\home\db�� Extract �� LPtcJsonName ���� ���� ��ȯ
    Result := ExtractFromTgz2DirByPackedName(LCOMTgzName, '', 'home\db\'+LPtcJsonName);
  end;
end;

function GetPortValueJsonFromCOMNPortJson(AJson: string): string;
var
  LDict: IDocDict;
  LPtcJsonName, LCOMTgzName, LBaseDir: string;
begin
  Result := '';
  LDict := DocDict(AJson);

  Result := LDict['PortValueInf'];
end;

function GetQueryJsonFromPortNPtcJson(ATagInfoJson, APortJson, APtcJson: string): string;
var
  LPortDict, LQryDict: IDocDict;
  LTagInfo_INF: TTagInfoRec_INF;
  LStr: string;
begin
  Result := '';
  LPortDict := DocDict(APortJson);
  LTagInfo_INF := GetTagInfoRec_INFFromJson(ATagInfoJson);

  if LPortDict.Exists('PtType') then
  begin
    LStr := LPortDict['PtType'];

    if LStr = 'modbus_master' then
    begin
      Result := GetQuery4ModbusMasterFromPtcJson(LTagInfo_INF, APtcJson);
    end;
  end;
end;

function SetQueryJsonFromTagDataSrcRec(var ATagDataSrcRec: TTagDataSrcRec): string;
var
  LTagInfoJson, LPortJson, LPtcJson: string;
  LDict: IDocDict;
begin
  LTagInfoJson := ATagDataSrcRec.FTagInfoJson;
  LPortJson := ATagDataSrcRec.FInterfaceJosnValue;
  LPtcJson :=  ATagDataSrcRec.FPtcJsonValue;

  //Result: {"Query":{...}, "ModbusAddr": "3000", "CheckMemRange":{...}}
  Result := GetQueryJsonFromPortNPtcJson(LTagInfoJson, LPortJson, LPtcJson);
  LDict := DocDict(Result);
  ATagDataSrcRec.FPtcJsonValue := LDict.S['Query'];
  ATagDataSrcRec.FCOMAddr := LDict.S['ModbusAddr'];
  ATagDataSrcRec.FCheckMemRange := LDict.S['CheckMemRange'];
end;

function SetChannelJsonFromTagDataSrcRec(var ATagDataSrcRec: TTagDataSrcRec): string;
var
  LChannelJson, LProt, LChNo, LChNo2, LChType: string;
  LChannelDict, LProtDict: IDocDict;
  LProtList: IDocList;
begin
  Result := '';
  LChannelDict := DocDict(ATagDataSrcRec.FChannelJsonValue);

  LProt := ATagDataSrcRec.FChannelProt;//TCP
  LChNo := ATagDataSrcRec.FChannelNo1;

  if LChannelDict.Exists(LProt) then
  begin
    LProtList := DocList(LChannelDict.S[LProt]);

    for LProtDict in LProtList.Objects do
    begin
      if LProtDict.Exists('ChNum') then
      begin
        LChNo2 := LProtDict.S['ChNum'];
        LChType := UpperCase(LProtDict.S['Type']);

        if LChNo = LChNo2 then
        begin
          Result := LProtDict.Json;
          ATagDataSrcRec.FChannelJsonValue := Result;

          if ATagDataSrcRec.FChannelProt = 'UART' then
          begin
            ATagDataSrcRec.FTerminalNo := GetTerminalNoByChType(LChType, LChNo);//LChType
          end;
        end;
      end;
    end;
  end;

end;

function GetTerminalNoByChType(AChType, AChNo: string): string;
var
  i, LBegin, LEnd: integer;
begin
  Result := '';
  LBegin := StrToIntDef(AChNo, 0);

  if AChType = 'RS422' then
  begin
    LEnd := LBegin * 4;

    for i := 3 to 0 do
      Result := Result + IntToStr(Lend - i) + ',';
  end
  else
  if AChType = 'RS485' then
  begin
    Result := Result + IntToStr(LBegin) + ',' + IntToStr(LBegin + 1);
  end
  else
  if AChType = 'RS232' then
  begin

  end
end;

function SetChannelInfoFromInterfaceJsonByRec(var ATagDataSrcRec: TTagDataSrcRec): string;
var
  LDict: IDocDict;
begin
  LDict := DocDict(ATagDataSrcRec.FInterfaceJosnValue);

  ATagDataSrcRec.FChannelProt := UpperCase(LDict.S['ChType']);
  ATagDataSrcRec.FChannelNo1 := LDict.S['PriCh'];
  ATagDataSrcRec.FChannelNo2 := LDict.S['SecCh'];
  ATagDataSrcRec.FSystemName := LDict.S['SystemName'];
end;

function GetTagDataSrcRecByTagInfo(ATagInfoJson, ABaseDir: string; AIsOnline: Boolean): TTagDataSrcRec;
var
  LResNPortJson, LPtcJson, LChannelJson: string;
  LDict, LTagDict: IDocDict;
  LPtcJsonName, LCOMTgzName: string;
begin
  Result := Default(TTagDataSrcRec);
  Result.FTagInfoJson := ATagInfoJson;
  //{"Resource":"COM011110"/"MPM11"/"FBM11", "Port":"ptc04.json", "PortValueInf":{...}, "BaseDir": "full path"}
  LResNPortJson := GetReourceNPortName2JsonByTagInfo(ATagInfoJson, ABaseDir, AIsOnline);

  if LResNPortJson <> '' then
  begin
    LDict := DocDict(LResNPortJson);
    LTagDict := DocDict(ATagInfoJson);

    Result.FMPMName := LTagDict['RESOURCE'];
    Result.FIOCardName := LDict['Resource'];
    Result.FCardNum := Copy(Result.FIOCardName, Length(Result.FIOCardName)-2, 2);
    Result.FInterfaceJosnValue := LDict['PortValueInf'];
    //Result.FChannelProt, Result.FSystemName, Result.FChannelNo1, Result.FChannelNo2 �� ������
    SetChannelInfoFromInterfaceJsonByRec(Result);

    LCOMTgzName := ABaseDir + LDict['Resource'] + '.tgz';

    if FileExists(LCOMTgzName) then
    begin
      LPtcJsonName := LDict['Port'] + '.json';;
      //LCOMTgzName(.tgz) ���Ͽ��� LPtcJsonName(.json) ������ c:\temp\home\db�� Extract �� LPtcJsonName ���� ���� ��ȯ
      LPtcJson := ExtractFromTgz2DirByPackedName(LCOMTgzName, '', 'home\db\'+LPtcJsonName);
     //,"PtcValue":{...} �߰�
      Result.FPtcJsonValue := LPtcJson;
      //Result.FPtcJsonValue, Result.FCOMAddr, Result.FCheckMemRange �� ������
      SetQueryJsonFromTagDataSrcRec(Result);
      LChannelJson := ExtractFromTgz2DirByPackedName(LCOMTgzName, '', 'home\db\channel.json');
      Result.FChannelJsonValue := LChannelJson;
      SetChannelJsonFromTagDataSrcRec(Result);
    end;
  end;

end;

function GetTagInfoRec_INFFromJson(AJson: string): TTagInfoRec_INF;
var
  LTagInfoDict: IDocDict;
begin
  Result := Default(TTagInfoRec_INF);

  LTagInfoDict := DocDict(AJson);

  Result.TAG_NAME := LTagInfoDict['TAG_NAME'];
  Result.DESCRIPTION := LTagInfoDict['DESCRIPTION'];
  Result.RESOURCE := LTagInfoDict['RESOURCE'];
  Result.SLOT := LTagInfoDict['SLOT'];
  Result.DIR := LTagInfoDict['DIR'];
  Result.&TYPE := LTagInfoDict['TYPE'];
  Result.ADDR := LTagInfoDict['ADDR'];
  Result.SUB_POS := LTagInfoDict['SUB_POS'];
end;

function GetReourceNPortName2JsonByTagInfo(ATagInfoJson, ABaseDir: string; AIsOnline: Boolean): string;
begin
  if AIsOnline then
  begin
    Result := GetResNPortName2JsonByTagInfoFromOnline(ATagInfoJson, ABaseDir);
  end
  else
  begin
    Result := GetResNPortName2JsonByTagInfoFromBackup(ATagInfoJson, ABaseDir);
  end;
end;

function GetResNPortName2JsonByTagInfoFromBackup(ATagInfoJson, ABaseDir: string): string;
var
  LJson: string;
begin
  LJson := GetTgzNPtcJsonNameByTagInfo(ATagInfoJson, ABaseDir);
  Result := LJson;
end;

function GetResNPortName2JsonByTagInfoFromOnline(ATagInfoJson, ABaseDir: string): string;
var
  LJson: string;
begin

end;

function GetTgzNPtcJsonNameByTagInfo(AJson, ABaseDir: string): string;
var
  LMPMName, LSlotNo, LAddr, LSubPos: string;
begin
  LMPMName := GetValueFromJsonDictByKeyName(AJson, 'RESOURCE');
  LSlotNo := GetValueFromJsonDictByKeyName(AJson, 'SLOT');
  LAddr := GetValueFromJsonDictByKeyName(AJson, 'ADDR');
  LSubPos := GetValueFromJsonDictByKeyName(AJson, 'SUB_POS');

  Result := GetMPMTgzNPtcJsonNameByMPMNameWithSlotNo(LMPMName, LSlotNo, ABaseDir);
  //MPM11.tgz->interface.json�� ASlotNo�� ��ġ�ϴ� "InfADDR"�� �������� ������
  //COM011xx.tgz���� �˻�
  if Result = '' then
    Result := GetCOMTgzNPortNameByMPMNameWithSlotNo(LMPMName, LSlotNo, ABaseDir);
end;

function GetQuery4ModbusMasterFromPtcJson(ATagInfoRec: TTagInfoRec_INF; APtcJson: string): string;
var
  LPtcDict, LQryDict, LResultDict: IDocDict;
  LPtcQueryList: IDocList;
  LStr, LDir, LFnCode, LInBlkAddr, LCount, LStAddr: string;
  LCheckMemRec: TCheckMemRange;
begin
  Result := '';
  LPtcDict := DocDict(APtcJson);
  LResultDict := DocDict('{}');

  if LPtcDict.Exists('Query') then
  begin
    LStr := LPtcDict['Query'];
    LPtcQueryList := DocList(LStr);

//        LQryDict: {
//            "StID": "1",
//            "FncCode": "5",
//            "StAddr": "3344",
//            "Count": "16",
//            "InBlkAddr": "1209",
//            "Activation": "on_change",
//            "PerTime": "100",
//            "Timeout": "1000",
//            "RetNum": "3",
//            "AlarmBit": "1",
//            "TxMode": "all"
//          }
    for LQryDict in LPtcQueryList.Objects do
    begin
      LFnCode := LQryDict['FncCode'];
      LInBlkAddr := LQryDict['InBlkAddr'];
      LCount := LQryDict['Count'];
      LStAddr := LQryDict['StAddr'];

      if ATagInfoRec.DIR = '0' then //modbus read function: 01,02,03,04
      begin
        if ATagInfoRec.&TYPE = '1' then //Boolean = coil/discrete(bitwise) : 01,02
        begin
          if (LFnCode = '1') or (LFnCode = '2') then
          begin

          end;
        end
        else//register
        begin
          if (LFnCode = '3') or (LFnCode = '4') then
          begin

          end;
        end;
      end
      else
      if ATagInfoRec.DIR = '1' then //modbus write function: 05,06,15,16
      begin
        if ATagInfoRec.&TYPE = '1' then //Boolean = coil/discrete(bitwise) : 05,06
        begin
          if (LFnCode = '5') or (LFnCode = '6') then
          begin
            LCheckMemRec := GetCheckMemRangeRec(LFnCode, LStAddr, LCount,
              LInBlkAddr, ATagInfoRec.ADDR, ATagInfoRec.SUB_POS);

            LStr := GetModbusAddrByInBlkAddr(LCheckMemRec);

            if LStr <> '' then
            begin
//              ModbusAddr := LStr;
              LResultDict.S['Query'] := LQryDict.Json;
              LResultDict.S['ModbusAddr'] := LStr;
              LResultDict.S['CheckMemRange'] := RecordSaveJson(LCheckMemRec, TypeInfo(TCheckMemRange));
              Result := Utf8ToString(LResultDict.Json);
              Break;
            end;
          end;
        end
        else//register
        begin
          if (LFnCode = '15') or  (LFnCode = '16') then
          begin

          end;
        end;
      end;
    end;//for
  end;
end;

function GetQuery4NmeaFromPtcJson(ATagInfoRec: TTagInfoRec_INF; APtcJson: string): string;
begin

end;

function GetQuery4ProfibusFromPtcJson(ATagInfoRec: TTagInfoRec_INF; APtcJson: string): string;
begin

end;

function GetModbusAddrByInBlkAddr(ACheckMemRange: TCheckMemRange): string;
var
  LWordCount,
  LStAddr,
  LEndAddr,
  LModAddr,
  LDiff
  : integer;
  LFnCode: string;
begin
  Result := '';
  LFnCode := ACheckMemRange.FFnCode;

  if (LFnCode = '1') or (LFnCode = '2') or (LFnCode = '5') or (LFnCode = '6') then //coil/decrete
  begin
    //InBlkAddr�� 16bit(1word) �����̹Ƿ� 16���� ����
    LWordCount := ACheckMemRange.FCount div 16;

    LStAddr := ACheckMemRange.FInBlkAddr;
    LEndAddr := ACheckMemRange.FInBlkAddr + LWordCount - 1;

    if (ACheckMemRange.FTagInBlkAddr >= LStAddr) and (ACheckMemRange.FTagInBlkAddr <= LEndAddr) then
    begin
      LDiff := (ACheckMemRange.FTagInBlkAddr - LStAddr) * 16;
      LModAddr := ACheckMemRange.FStAddr + LDiff + ACheckMemRange.FTagSubPos;
      Result := Format('%.4d',[LModAddr]);
    end;
  end
  else
  begin

  end;
end;

function CheckIfAddrInRange4ModbusByInBlkAddr(AFnCode, AStAddr, ACount, AInBlkAddr, ATagInBlkAddr, ATagSubPos: string): Boolean;
var
  LCheckMemRec: TCheckMemRange;
begin
  LCheckMemRec := GetCheckMemRangeRec(AFnCode, AStAddr, ACount, AInBlkAddr, ATagInBlkAddr, ATagSubPos);

  Result := (GetModbusAddrByInBlkAddr(LCheckMemRec) <> '');
end;

function GetCheckMemRangeRec(AFnCode, AStAddr, ACount, AInBlkAddr, ATagInBlkAddr, ATagSubPos: string): TCheckMemRange;
begin
  Result := Default(TCheckMemRange);

  with Result do
  begin
    FFnCode := AFnCode;
    FStAddr := StrToIntDef(AStAddr, 0);
    FCount := StrToIntDef(ACount, 0);
    FInBlkAddr := StrToIntDef(AInBlkAddr, 0);
    FTagInBlkAddr := StrToIntDef(ATagInBlkAddr, 0);
    FTagSubPos := StrToIntDef(ATagSubPos, 0);
  end;
end;

end.
