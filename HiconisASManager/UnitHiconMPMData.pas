unit UnitHiconMPMData;

interface

uses System.Classes, System.SysUtils, UnitEnumHelper,
  mormot.core.variants, mormot.core.unicode, mormot.core.json;

const
  //호선별 Hiconis Backup 폴더에서 MPM 관련 백업파일 위치 지정
  DOWNLOAD_FULL_PATH = 'E:\pjh\Doc\HiCONIS\project\HMD8310\ACONIS-NX\DB\DOWNLOAD\';

type
  TTagSearchRec = packed record
    FTagName,
    FBaseDir,
    FIPAddr
    : string;
    FSrcKind //0:From Backup, 1:From Tgz Backup, 2: From Online
    : integer;
  end;

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

  //\COM01110\home\sysconfig\ifcfg-eth0 내용 저장용 Record
  TResEtherInfoRec = packed record
    DEVICE,
    BOOTPROTO,
    IPADDR,
    NETMASK,
    BROADCAST,
    NETWORK,
    ONBOOT,
    GATEWAY,
    GATEWAYDEV,
    MACADDR
    : string;
  end;

  TResPortInfoRec = packed record
    Resource,
    Port,
    IPAddr1,
    IPAddr2
    : string;
  end;

{$REGION 'TTAGINFO'}
  //System_bak.accdb->INF table에서 가져옴
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

  //TagName에 연결된 ModbusMaster 정보
  TTagInfoRec_ModbusMaster = packed record
    TagInfoRec_INF: TTagInfoRec_INF;
    MPMName,
    IOCardType,
    ChannelNo
    : string;
  end;

  //TagName에 연결된 ModbusSlave 정보
  TTagInfoRec_ModbusSlave = packed record
    TagInfoRec_INF: TTagInfoRec_INF;
    MPMName,
    IOCardType,
    ChannelNo
    : string;
  end;

  //TagName에 연결된 NMEA 정보
  TTagInfoRec_NMEA = packed record
    TagInfoRec_INF: TTagInfoRec_INF;
    MPMName,
    IOCardType,
    ChannelNo
    : string;
  end;

  //TagName에 연결된 Profibus 정보
  TTagInfoRec_Profibus = packed record
    TagInfoRec_INF: TTagInfoRec_INF;
    MPMName
    : string;
  end;

  //TagName에 연결된 H/W 정보
  TTagInfoRec_INF_HW= packed record
    TagInfoRec_INF: TTagInfoRec_INF;
    MPMName,
    IOCardType,
    ChannelNo
    : string;
  end;
{$ENDREGION}

{$REGION 'TMPM_Channel_Json'}
  //channel.json내 "UART" field value = 배열에서 1개 원소 Json Value
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

  //channel.json내 "UART" field value = 배열임
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
  //interface.json내 "Portx" field value
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

  //interface.json내 "TimeInfo" field value
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
  //ptcxx.json내 "Query" field value for modbus master
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

//AMPMName: MPM11/FBM11
//Result: '11;
function GetMPMNoFromResName(AMPMName: string): string;
//AMPMName: MPM11/FBM11
//ADirName: 검샐할 폴더 full path
//Result: COM011* list
function GetCOMCardNameListFromDirByMPMName(AMPMName, ADirName: string): TStringList;
//ABaseDir: 호선No별 Folder Name(F:\Hiconis_Backup\HMD8310_ICMS\)
function GetIntfJsonContentsBySlotNo(AMPMName, ASlotNo, ABaseDir: string; out APortName: string): string;
//Result: Port4
function GetPortNameFromIntfJsonBySlotNo(AJson, ASlotNo: string): string;
//AFileName: Interface.json full path name
function GetPortNameFromIntfJsonFNBySlotNo(AFileName, ASlotNo: string): string;
//function GetPtcJsonContentsByResName(AResName: string): string;

function GetTagInfoRec_INFFromJson(AJson: string): TTagInfoRec_INF;
//AJson: MPM or COM->home\db\interface.josn 파일 내용
//Result: Portxx List = {"Port1":{...}, "Port2":{...}, ...}
function GetPortListFromMPMIntfJson(AJson: string): string;
function GetPortDocListFromMPMIntfJson(AJson: string): IDocList;
//AJson: MPM->home\db\interface.josn 파일 내용
//Result: Ptc file name list = ["ptc01.json", "ptc02.json", ...]
function GetPtcFileNameListFromMPMIntfJson(AJson: string): string;
//AJson: MPM interface.json contents
//AFileName: *.tgz file name
//Result: {"Resource":"COM011110.tgz"/"MPM11.tgz", "Port":"ptc04.json", "PortValueInf":{...},"BaseDir": "full path"}
function GetTgzNPtcJsonNameFromInterfaceJson(AJson, AFileName, ASlotNo, ABaseDir: string): string;
//Result: {"Resource":"COM011110"/"MPM11", "Port":"ptc04", "PortValueInf":{...},"BaseDir": "full path"}
//Result에서 파일 확장자가 제거됨, 나머지는 위와 동일함
function GetResNPtcNameFromInterfaceJson(AJson, AFileName, ASlotNo, ABaseDir: string): string;
//AMPMName: MPM11
//Result: COM011xx.tgz List = ["COM01110.tgz", "OOM01120.tgz", ...] Base Dir에서 검색함-
function GetCOMTgzFileNameListByMPMName(AMPMName, ABaseDir: string): TStringList;
//AMPMName: MPM11
//ASlotNo: system_bak.INF table의 SLOT Field 값
//Result: {"Resource":"COM011110"/"MPM11", "Port":"ptc04.json", "PortValueInf":{...},"BaseDir": "full path"}
//       MPM11.tgz의 interface.json에 SlotNo가 존재하면 "Resource" = "MPM11" 그렇지 않고 "COM011xx.tgz"에 존재하면 아래 내용처럼
//       COM011xx.tgz Name = ASlotNo값이 interface.json->"PORTx"->"InfADDR" 값과 일치해야 함
function GetMPMTgzNPtcJsonNameByMPMNameWithSlotNo(AMPMName, ASlotNo, ABaseDir: string): string;
//AMPMName: MPM11
//ASlotNo: system_bak.INF table의 SLOT Field 값
//Result: {"Resource":"COM011110", "Port":"ptc04.json", "PortValueInf":{...},"BaseDir": "full path"}
//       COM011xx.tgz Name = ASlotNo값이 interface.json->"PORTx"->"InfADDR" 값과 일치해야 함(이 함수는 MPM11.tgz는 확인 안함)
function GetCOMTgzNPortNameByMPMNameWithSlotNo(AMPMName, ASlotNo, ABaseDir: string): string; overload;
//AJson: THiConSystemDB.GetTagInfo2JsonFromINFTable() 리턴값
//Result: 위와 동일
function GetCOMTgzNPortNameByMPMNameWithSlotNo(AJson, ABaseDir: string): string; overload;
//AJson: {"Port1":{...}, "Port2":{...}, ...}
//Result: 'Port2' = "InfADDR" 값이 ASlotNo 와 같은 Port
function GetPortNameFromPortListJsonBySlotNo(AJson, ASlotNo: string): string;
//AJson: {"Port1":{...}, "Port2":{...}, ...}
//Result: '{...}' = "InfADDR" 값이 ASlotNo 와 같은 Port Value
function GetPortJsonValueFromPortListJsonBySlotNo(AJson, ASlotNo: string): string;
//APortName: "Port4"
//Result: "ptc04.json"
function GetPtcJsonNameByPortName(APortName: string): string;
//AJson: GetCOMTgzNPortNameByMPMNameWithSlotNo()의 결과값
//Result: Port json file contents = ptc04.json 내용
function GetPtcJsonContentsFromTgzByCOMNPortJson(AJson: string): string;
//AJson: GetCOMTgzNPortNameByMPMNameWithSlotNo()의 결과값
//Result: Portx Value = interface.json 내용에서 선택된 "Portx" key 값의 Value를 반환함
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
//ATagInfoJson: INF Table에서 Tag 관련 정보 가져옴
//APortJson: interface.json->Portx value
//APtcJson: ptcxx.json 전체 내용
//Result: APtcJson에서 주소값 비교하여 해당 Query에 반환
//Result: {"Query":{...}, "ModbusAddr": "3000", "CheckMemRange":{...}}
function GetQueryJsonFromPortNPtcJson(ATagInfoJson, APortJson, APtcJson: string): string;
function SetQueryJsonFromTagDataSrcRec(var ATagDataSrcRec: TTagDataSrcRec): string;
function SetChannelJsonFromTagDataSrcRec(var ATagDataSrcRec: TTagDataSrcRec): string;
function SetChannelInfoFromInterfaceJsonByRec(var ATagDataSrcRec: TTagDataSrcRec): string;
function GetTerminalNoByChType(AChType, AChNo: string): string;

//ATagInfoJson: INF Table에서 Tag 관련 정보 가져옴
//AResNPortJson: GetReourceNPortName2JsonByTagInfo() 결과값
//function GetQueryJsonFromResourceNPortNameByTagInfo(ATagInfoJson, AResNPortJson: string): string;

//ATagInfoJson: INF Table에서 Tag 관련 정보 가져옴
//AResNPortJson:
function GetTagDataSrcRecByTagInfo(ATagInfoJson: string; ARec: TTagSearchRec): TTagDataSrcRec;
//ATagInfoJson: INF Table에서 Tag 관련 정보 가져옴
//ARec.FBaseDir: ASrcKind이 0 또는 1인 경우 호선별 파일이 저장된 folder path
//ARec.FIPAddr: ASrcKind이 2인 경우 Card IP Address
//ARec.FSrcKind: 0 = Disk에 백업된 interface.json 파일을 읽음
//               1 = Disk에 백업된 .tgz로부터 interface.json 파일을 읽음
//               2 = interface.json 파일을 TCP 통신 연결하여 MPM에서 Download하여 c:\temp에 저장 후 읽음
//Result: TagName에 연결된 통신Card 및 Port 이름을 Json으로 반환함
//{"Resource":"COM011110"/"MPM11"/"FBM11", "Port":"port4", "PortValueInf":{...},"PtcValue":{...}, "BaseDir": "full path"}
//"PortValueInf": interface.json->Port Value
//"PtcValue": ptcxx.json->"Query" Value = modbus master의 경우
//                        "Sentence" Value = nmea의 경우
function GetResNPortName2JsonByInfTagInfo(ATagInfoJson: string; ARec: TTagSearchRec): string;
function GetResNPortName2JsonByTagInfoFromBackup(AInfRec: TTagInfoRec_INF; ARec: TTagSearchRec): string;
function GetResNPortName2JsonByTagInfoFromTgzBackup(AInfRec: TTagInfoRec_INF; ARec: TTagSearchRec): string;
function GetResNPortName2JsonByTagInfoFromOnline(AInfRec: TTagInfoRec_INF; ARec: TTagSearchRec): string;
function GetTgzNPtcJsonNameByTagInfo(AJson, ABaseDir: string): string;

function GetResNPortNameByInfTagInfo(ATagInfoJson: string; ARec: TTagSearchRec): string;
//Result: COM01110;10.8.1.11;Port4
function GetResPortIPAddrByInfTagInfo(ATagInfoJson: string; ARec: TTagSearchRec): string;

//AResName: COM01110
//ABaseDir: 호선별 자료 저장 폴더명
//Result:
function GetEtherInfoByResNameFromBackup(AResName, ABaseDir: string): string;
function GetResEtherInfoList2JsonFromBackup(AResName, ABaseDir: string): string;
function GetResEtherInfoRecFromFN(AFileName: string; var ARec: TResEtherInfoRec): Boolean;
function GetResEtherInfo2JsonFromFN(AFileName: string): string;

//Result: "10.8.1.11;110.8.1.12"
function GetIpAddrByResNameFromBackup(AResName, ABaseDir: string): string;
function GetIpAddrByResNameFromOnline(AResName, AIpAddr: string): string;

//Result: {"Query":{...}, "ModbusAddr": "3000", "CheckMemRange":{...}}
function GetQuery4ModbusMasterFromPtcJson(ATagInfoRec: TTagInfoRec_INF; APtcJson: string): string;
function GetQuery4NmeaFromPtcJson(ATagInfoRec: TTagInfoRec_INF; APtcJson: string): string;
function GetQuery4ProfibusFromPtcJson(ATagInfoRec: TTagInfoRec_INF; APtcJson: string): string;

//AInBlkAddr: StrAddr와 연결된 InBlkAddr
//ATagInBlkAddr: TagNo에 할당된 InBlkAddr
//Result: ATagIBlkAddr의 위치와 동일한 Modbus Address 반환
//        '' 이면 Range 안에 없다는 의미임
function GetModbusAddrByInBlkAddr(ACheckMemRange: TCheckMemRange): string;
function CheckIfAddrInRange4ModbusByInBlkAddr(AFnCode, AStAddr, ACount, AInBlkAddr, ATagInBlkAddr, ATagSubPos: string): Boolean;
function GetCheckMemRangeRec(AFnCode, AStAddr, ACount, AInBlkAddr, ATagInBlkAddr, ATagSubPos: string): TCheckMemRange;

function GetTagSearchRecFromTagInfoEditForm(AIpAddr: string=''): TTagSearchRec;

implementation

uses UnitFileSearchUtil, UnitStringUtil, UnitGZipJclUtil, UnitJsonUtil,
  UnitFolderUtil2, UnitFileUtil,
  FrmTagInputEdit;

function GetMPMNoFromResName(AMPMName: string): string;
begin
  Result := RemoveNonDigitsBetweenString(AMPMName);

//  if Pos('MPM', AMPMName) <> 0 then
//    Result := StringReplace(AMPMName, 'MPM', '', [rfReplaceAll])
//  else
//  if Pos('FBM', AMPMName) <> 0 then
//    Result := StringReplace(AMPMName, 'FBM', '', [rfReplaceAll])
//  else
//    Result := '';
end;

function GetCOMCardNameListFromDirByMPMName(AMPMName, ADirName: string): TStringList;
var
  LCOMCardName: string;
begin
  LCOMCardName := 'COM0' + GetMPMNoFromResName(AMPMName) + '*';
  Result := GetFileListFromFolder(ADirName, LCOMCardName, False, faDirectory);
end;

function GetIntfJsonContentsBySlotNo(AMPMName, ASlotNo, ABaseDir: string; out APortName: string): string;
var
  LFullPathIntfJsonFN, LJson, LPortName, LCOMCardName: string;
  LComList: TStringList;
  i: integer;
begin
  Result := '';

  if ABaseDir = '' then
    ABaseDir := 'C:\temp\';

  ABaseDir := IncludeTrailingPathDelimiter(ABaseDir) + 'MPM_FBM_COM\';

  LFullPathIntfJsonFN := ABaseDir + AMPMName + '\home\db\interface.json';

  if FileExists(LFullPathIntfJsonFN) then
  begin
    LJson := StringFromFile(LFullPathIntfJsonFN);

    //일치하는 SlotNo = InfAddr port가 MPM의 Interface.json에 없으면
    if LPortName = '' then
    begin
      //COM Card List에서 검색함
      LComList := GetCOMCardNameListFromDirByMPMName(AMPMName, ABaseDir);
      try
        for i := 0 to LComList.Count - 1 do
        begin
          LFullPathIntfJsonFN := IncludeTrailingPathDelimiter(LComList.Strings[i]) + 'home\db\interface.json';

          LJson := StringFromFile(LFullPathIntfJsonFN);
          LPortName := GetPortNameFromIntfJsonBySlotNo(LJson, ASlotNo);

          if LPortName <> '' then
          begin
            LCOMCardName := ExtractFileName(LComList.Strings[i]);
            Result := LJson;
            APortName := LCOMCardName + ';' + LPortName;
          end;
        end;
      finally
        LComList.Free
      end;
    end
    else
    begin
      Result := LJson;
      LPortName := AMPMName + ';' + GetPortNameFromIntfJsonBySlotNo(LJson, ASlotNo);
      APortName := LPortName;
    end;
  end;
end;

function GetPortNameFromIntfJsonBySlotNo(AJson, ASlotNo: string): string;
var
  LJson: string;
begin
  //AJson에서 Port List {"Port1":{...}, "Port2":{...}, ...} 가져옴
  LJson := GetPortListFromMPMIntfJson(AJson);
  //'Port2' = "InfADDR"
  Result := GetPortNameFromPortListJsonBySlotNo(LJson, ASlotNo);
end;

function GetPortNameFromIntfJsonFNBySlotNo(AFileName, ASlotNo: string): string;
var
  LJson: string;
begin
  Result := '';

  if FileExists(AFileName) then
  begin
    LJson := StringFromFile(AFileName);
    Result := GetPortNameFromIntfJsonBySlotNo(LJson, ASlotNo);
  end;
end;

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
  //filename = filesize list 반환
  Result := FindAllFiles(ABaseDir, AMPMName);
end;

function GetTgzNPtcJsonNameFromInterfaceJson(AJson, AFileName, ASlotNo, ABaseDir: string): string;
var
  LJson2, LPortName: string;
  LDict: IDocDict;
begin
  Result := '';
  LDict := DocDict('{}');

  //AJson에서 Port List {"Port1":{...}, "Port2":{...}, ...} 가져옴
  LJson2 := GetPortListFromMPMIntfJson(AJson);
  //'Port2' = "InfADDR"
  LPortName := GetPortNameFromPortListJsonBySlotNo(LJson2, ASlotNo);
  LJson2 := GetPortJsonValueFromPortListJsonBySlotNo(LJson2, ASlotNo);

  if LPortName <> '' then
  begin
    AFileName := ExtractFileName(AFileName);
    LDict.S['Resource'] := AFileName; //MPM11
    LDict.S['Port'] := GetPtcJsonNameByPortName(LPortName);//"ptc04.json"
    //interface.json의 Portx Value
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
    //MPMxx.tgz file에서 'home\db\interface.json' 내용을 가져옴
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
    //filename = filesize list 반환
    for LStr in LStrList do
    begin
      LFileName := LStr;
      LFileName := ABaseDir + StrToken(LFileName, '=');
      //COM0xxxx.tgz file에서 'home\db\interface.json' 내용을 가져옴
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
function GetPtcJsonContentsFromTgzByCOMNPortJson(AJson: string): string;
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

    //LCOMTgzName(.tgz) 파일에서 LPtcJsonName(.json) 파일을 c:\temp\home\db에 Extract 후 LPtcJsonName 파일 내용 반환
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
    end
    else
    if LStr = 'nmea' then
    begin
      Result := GetQuery4NmeaFromPtcJson(LTagInfo_INF, APtcJson);
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

function GetTagDataSrcRecByTagInfo(ATagInfoJson: string; ARec: TTagSearchRec): TTagDataSrcRec;
var
  LResNPortJson, LPtcJson, LChannelJson: string;
  LDict, LTagDict: IDocDict;
  LPtcJsonName, LCOMTgzName: string;
begin
  Result := Default(TTagDataSrcRec);
  Result.FTagInfoJson := ATagInfoJson;
  //{"Resource":"COM011110"/"MPM11"/"FBM11", "Port":"ptc04.json", "PortValueInf":{...}, "BaseDir": "full path"}
  LResNPortJson := GetResNPortName2JsonByInfTagInfo(ATagInfoJson, ARec);

  if LResNPortJson <> '' then
  begin
    LDict := DocDict(LResNPortJson);
    LTagDict := DocDict(ATagInfoJson);

    Result.FMPMName := LTagDict['RESOURCE'];
    Result.FIOCardName := LDict['Resource'];
    Result.FCardNum := Copy(Result.FIOCardName, Length(Result.FIOCardName)-2, 2);
    Result.FInterfaceJosnValue := LDict['PortValueInf'];
    //Result.FChannelProt, Result.FSystemName, Result.FChannelNo1, Result.FChannelNo2 를 갱신함
    SetChannelInfoFromInterfaceJsonByRec(Result);

    LCOMTgzName := ARec.FBaseDir + LDict['Resource'] + '.tgz';

    if FileExists(LCOMTgzName) then
    begin
      LPtcJsonName := LDict['Port'] + '.json';;
      //LCOMTgzName(.tgz) 파일에서 LPtcJsonName(.json) 파일을 c:\temp\home\db에 Extract 후 LPtcJsonName 파일 내용 반환
      LPtcJson := ExtractFromTgz2DirByPackedName(LCOMTgzName, '', 'home\db\'+LPtcJsonName);
     //,"PtcValue":{...} 추가
      Result.FPtcJsonValue := LPtcJson;
      //Result.FPtcJsonValue, Result.FCOMAddr, Result.FCheckMemRange 를 갱신함
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
  if AJson = '' then
    exit;

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

function GetResNPortName2JsonByInfTagInfo(ATagInfoJson: string; ARec: TTagSearchRec): string;
var
  LTagInfoRec_INF: TTagInfoRec_INF;
begin
  if ATagInfoJson = '' then
    exit;

  LTagInfoRec_INF := GetTagInfoRec_INFFromJson(ATagInfoJson);

  case ARec.FSrcKind of
    0: Result := GetResNPortName2JsonByTagInfoFromBackup(LTagInfoRec_INF, ARec);
    1: Result := GetResNPortName2JsonByTagInfoFromTgzBackup(LTagInfoRec_INF, ARec);
    2: Result := GetResNPortName2JsonByTagInfoFromOnline(LTagInfoRec_INF, ARec);
  end;
end;

function GetResNPortName2JsonByTagInfoFromBackup(AInfRec: TTagInfoRec_INF; ARec: TTagSearchRec): string;
var
  LIntfJsonContents, LPortListJson, LPortName: string;
  LDict: IDocDict;
begin
  Result := '';

  LDict := DocDict('{}');

  //SlotNo 가 InfAddr과 일치하는 interface.json을 가져옴- LPortName에 "COMCardName;Portname" 반환함
  LIntfJsonContents := GetIntfJsonContentsBySlotNo(AInfRec.RESOURCE,
                                                   AInfRec.SLOT,
                                                   ARec.FBaseDir,
                                                   LPortName);

  if LIntfJsonContents = '' then
    exit;

  //AJson에서 Port List {"Port1":{...}, "Port2":{...}, ...} 가져옴
  LPortListJson := GetPortListFromMPMIntfJson(LIntfJsonContents);

  LDict.S['Resource'] := StrToken(LPortName, ';'); //MPM11
  LDict.S['Port'] := LPortName; //COM01110;Port4
  //interface.json의 Portx(=LPortName) Value
  LDict.S['PortValueInf'] := GetPortJsonValueFromPortListJsonBySlotNo(LPortListJson,AInfRec.SLOT);
  LDict.S['PtcFileName'] := GetPtcJsonNameByPortName(LPortName);//"ptc04.json"
  Result := LDict.Json;

  //'Port2' = "InfADDR"
//  LPortName := GetPortNameFromPortListJsonBySlotNo(LJson2, ASlotNo);
//  LJson2 := GetPortJsonValueFromPortListJsonBySlotNo(LJson2, ASlotNo);
//
//  if LPortName <> '' then
//  begin
//    AFileName := ExtractFileName(AFileName);
//    LDict.S['Resource'] := AFileName; //MPM11
//    LDict.S['Port'] := GetPtcJsonNameByPortName(LPortName);//"ptc04.json"
//    //interface.json의 Portx Value
//    LDict.S['PortValueInf'] := LJson2;
//    LDict.S['BaseDir'] := ABaseDir;
//    Result := LDict.Json;
//  end;
end;

function GetResNPortName2JsonByTagInfoFromTgzBackup(AInfRec: TTagInfoRec_INF; ARec: TTagSearchRec): string;
var
  LJson: string;
begin
//  LJson := GetTgzNPtcJsonNameByTagInfo(AInfRec, ARec.FBaseDir);
  Result := LJson;
end;

function GetResNPortName2JsonByTagInfoFromOnline(AInfRec: TTagInfoRec_INF; ARec: TTagSearchRec): string;
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
  //MPM11.tgz->interface.json에 ASlotNo와 일치하는 "InfADDR"가 존재하지 않으면
  //COM011xx.tgz에서 검색
  if Result = '' then
    Result := GetCOMTgzNPortNameByMPMNameWithSlotNo(LMPMName, LSlotNo, ABaseDir);
end;

function GetResNPortNameByInfTagInfo(ATagInfoJson: string; ARec: TTagSearchRec): string;
var
  LJson: string;
  LDict: IDocDict;
  LTagInfoRec_INF: TTagInfoRec_INF;
begin
  if ATagInfoJson = '' then
    exit;

  LTagInfoRec_INF := GetTagInfoRec_INFFromJson(ATagInfoJson);

  case ARec.FSrcKind of
    0: begin
      LJson := GetResNPortName2JsonByInfTagInfo(ATagInfoJson, ARec);
      LDict := DocDict(LJson);
      Result := LDict.S['Resource'];
      Result := Result + ';' + LDict.S['Port'];
    end;
    1: ;
    2: ;
  end;
end;

function GetResPortIPAddrByInfTagInfo(ATagInfoJson: string; ARec: TTagSearchRec): string;
var
  LStr, LPortName, LResName, LIPAddr: string;
begin
  LPortName := GetResNPortNameByInfTagInfo(ATagInfoJson, ARec);//GetResNPortName2JsonByInfTagInfo(LStr, ARec);
  LResName := StrToken(LPortName, ';');

  LIPAddr := GetIpAddrByResNameFromBackup(LResName, ARec.FBaseDir);

  Result := LResName + ';' + LPortName + ';' + LIPAddr;
end;

function GetEtherInfoByResNameFromBackup(AResName, ABaseDir: string): string;
begin
  Result := GetResEtherInfoList2JsonFromBackup(AResName, ABaseDir);
end;

function GetResEtherInfoList2JsonFromBackup(AResName, ABaseDir: string): string;
var
  LFullPathConfigFN, LJson, LPortName, LCOMCardName: string;
  LList: IDocList;
begin
  Result := '';

  if ABaseDir = '' then
    ABaseDir := 'C:\temp\';

  LList := DocList('[]');

  ABaseDir := IncludeTrailingPathDelimiter(ABaseDir) + 'MPM_FBM_COM\';

  LFullPathConfigFN := ABaseDir + AResName + '\home\sysconfig\ifcfg-eth0';
  LJson := GetResEtherInfo2JsonFromFN(LFullPathConfigFN);

  if LJson <> '' then
    LList.Append(StringToUtf8(LJson));

  LFullPathConfigFN := ABaseDir + AResName + '\home\sysconfig\ifcfg-eth1';
  LJson := GetResEtherInfo2JsonFromFN(LFullPathConfigFN);

  if LJson <> '' then
    LList.Append(StringToUtf8(LJson));

  Result := Utf8ToString(LList.Json);
end;

function GetResEtherInfoRecFromFN(AFileName: string; var ARec: TResEtherInfoRec): Boolean;
var
  LStrList: TStringList;
begin
  Result := False;

  if FileExists(AFileName) then
  begin
    LStrList := TStringList.Create;
    try
      LStrList.LoadFromFile(AFileName);

      ARec.DEVICE := LStrList.Values['DEVICE'];
      ARec.BOOTPROTO := LStrList.Values['BOOTPROTO'];
      ARec.IPADDR := LStrList.Values['IPADDR'];
      ARec.NETMASK := LStrList.Values['NETMASK'];
      ARec.BROADCAST := LStrList.Values['BROADCAST'];
      ARec.NETWORK := LStrList.Values['NETWORK'];
      ARec.ONBOOT := LStrList.Values['ONBOOT'];
      ARec.GATEWAY := LStrList.Values['GATEWAY'];
      ARec.GATEWAYDEV := LStrList.Values['GATEWAYDEV'];
      ARec.MACADDR := LStrList.Values['MACADDR'];

      Result := True;
    finally
      LStrList.Free;
    end;
  end;
end;

function GetResEtherInfo2JsonFromFN(AFileName: string): string;
var
  LResEtherInfoRec: TResEtherInfoRec;
begin
  if GetResEtherInfoRecFromFN(AFileName,LResEtherInfoRec) then
  begin
    Result := RecordSaveJson(LResEtherInfoRec, TypeInfo(TResEtherInfoRec));
  end;
end;

function GetIpAddrByResNameFromBackup(AResName, ABaseDir: string): string;
var
  LResEtherInfoRec: TResEtherInfoRec;
  LFullPathConfigFN: string;
begin
  Result := '';

  if ABaseDir = '' then
    ABaseDir := 'C:\temp\';

  ABaseDir := IncludeTrailingPathDelimiter(ABaseDir) + 'MPM_FBM_COM\';

  LFullPathConfigFN := ABaseDir + AResName + '\home\sysconfig\ifcfg-eth0';

  if GetResEtherInfoRecFromFN(LFullPathConfigFN, LResEtherInfoRec) then
    Result := LResEtherInfoRec.IPADDR;

  LFullPathConfigFN := ABaseDir + AResName + '\home\sysconfig\ifcfg-eth1';

  if GetResEtherInfoRecFromFN(LFullPathConfigFN, LResEtherInfoRec) then
    Result := Result + ';' + LResEtherInfoRec.IPADDR;
end;

function GetIpAddrByResNameFromOnline(AResName, AIpAddr: string): string;
begin

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
    //InBlkAddr은 16bit(1word) 단위이므로 16으로 나눔
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

function GetTagSearchRecFromTagInfoEditForm(AIpAddr: string): TTagSearchRec;
var
  LStr: string;
begin
  Result := Default(TTagSearchRec);

  LStr := CreateTagInputEdit('','','','',AIpAddr);

  Result.FTagName := strToken(LStr, ';');
  Result.FSrcKind := StrTointDef(strToken(LStr, ';'), 0);

  case Result.FSrcKind of
    0,1: Result.FBaseDir := strToken(LStr, ';');
    2: Result.FIPAddr := strToken(LStr, ';');
  end;
end;

end.
