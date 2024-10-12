unit UnitHiconMPMData;

interface

uses System.Classes, System.SysUtils, UnitEnumHelper,
  mormot.core.variants, mormot.core.unicode;

const
  //호선별 Hiconis Backup 폴더에서 MPM 관련 백업파일 위치 지정
  DOWNLOAD_FULL_PATH = 'E:\pjh\Doc\HiCONIS\project\HMD8310\ACONIS-NX\DB\DOWNLOAD\';

type

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

//AJson: MPM or COM->home\db\interface.josn 파일 내용
//Result: Portxx List = {"Port1":{...}, "Port2":{...}, ...}
function GetPortListFromMPMIntfJson(AJson: string): string;
function GetPortDocListFromMPMIntfJson(AJson: string): IDocList;
//AJson: MPM->home\db\interface.josn 파일 내용
//Result: Ptc file name list = ["ptc01.json", "ptc02.json", ...]
function GetPtcFileNameListFromMPMIntfJson(AJson: string): string;
//AMPMName: MPM11
//Result: COM011xx.tgz List = ["COM01110.tgz", "OOM01120.tgz", ...] Base Dir에서 검색함-
function GetCOMTgzFileNameListByMPMName(AMPMName, ABaseDir: string): TStringList;
//AJson: MPM interface.json contents
//AFileName: *.tgz file name
//Result: {"Resource":"COM011110.tgz"/"MPM11.tgz", "Port":"ptc04.json", "PortValueInf":{...},"BaseDir": "full path"}
function GetTgzNPtcJsonNameFromInterfaceJson(AJson, AFileName, ASlotNo, ABaseDir: string): string;
//AMPMName: MPM11
//ASlotNo: system_bak.INF table의 SLOT Field 값
//Result: {"Resource":"COM011110.tgz"/"MPM11.tgz", "Port":"ptc04.json", "PortValueInf":{...},"BaseDir": "full path"}
//       MPM11.tgz의 interface.json에 SlotNo가 존재하면 "Resource" = "MPM11" 그렇지 않고 "COM011xx.tgz"에 존재하면 아래 내용처럼
//       COM011xx.tgz Name = ASlotNo값이 interface.json->"PORTx"->"InfADDR" 값과 일치해야 함
function GetMPMTgzNPtcJsonNameByMPMNameWithSlotNo(AMPMName, ASlotNo, ABaseDir: string): string; overload;
function GetMPMTgzNPtcJsonNameByMPMNameWithSlotNo(AJson, ABaseDir: string): string; overload;
//AMPMName: MPM11
//ASlotNo: system_bak.INF table의 SLOT Field 값
//Result: {"Resource":"COM011110.tgz", "Port":"ptc04.json", "PortValueInf":{...},"BaseDir": "full path"}
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
function GetPtcJsonContentsFromCOMNPortJson(AJson: string): string;
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
//Result: APtcJson에서 주소값 비교하여 해당 Query Json 반환
function GetQueryJsonFromPortNPtcJson(ATagInfoJson, APortJson, APtcJson: string): string;
function GetTagInfoRec_INFFromJson(AJson: string): TTagInfoRec_INF;

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
    LDict.S['Resource'] := AFileName; //MPM11.tgz
    LDict.S['Port'] := GetPtcJsonNameByPortName(LPortName);//"ptc04.json"
    //interface.json의 Portx Value
    LDict.S['PortValueInf'] := LJson2;
    LDict.S['BaseDir'] := ABaseDir;
    Result := LDict.Json;
  end;
end;

function GetMPMTgzNPtcJsonNameByMPMNameWithSlotNo(AMPMName, ASlotNo, ABaseDir: string): string; overload;
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
    //{"Resource":"COM011110.tgz"/"MPM11.tgz", "Port":"ptc04.json", "PortValueInf":{...},"BaseDir": "full path"}
    Result := GetTgzNPtcJsonNameFromInterfaceJson(LJson, LFileName, ASlotNo, ABaseDir);
  end;
end;

function GetMPMTgzNPtcJsonNameByMPMNameWithSlotNo(AJson, ABaseDir: string): string; overload;
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
    Result := GetCOMTgzNPortNameByMPMNameWithSlotNo(AJson, ABaseDir);
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
      Result := GetTgzNPtcJsonNameFromInterfaceJson(LJson, LFileName, ASlotNo, ABaseDir);

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
  LCOMTgzName := LBaseDir + LDict['Resource'];

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
  LPtcDict, LPortDict, LQryDict: IDocDict;
  LPtcQueryList: IDocList;
  LStr, LDir, LFnCode, LInBlkAddr, LCount, LStAddr: string;
  LTagInfo_INF: TTagInfoRec_INF;
begin
  Result := '';
  LTagInfo_INF := GetTagInfoRec_INFFromJson(ATagInfoJson);
  LPtcDict := DocDict(APtcJson);
  LPortDict := DocDict(APortJson);

  if LPortDict.Exists('PtType') then
  begin
    LStr := LPortDict['PtType'];

    if LStr = 'modbus_master' then
    begin
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

          if LTagInfo_INF.DIR = '0' then //modbus input: 01,02,03,04
          begin
            if LTagInfo_INF.&TYPE = '1' then //single
            begin
              if (LFnCode = '1') or (LFnCode = '2') then
              begin

              end;
            end
            else//multiple
            begin
              if (LFnCode = '3') or (LFnCode = '4') then
              begin

              end;
            end;
          end
          else
          if LTagInfo_INF.DIR = '1' then //modbus output: 05,06,15,16
          begin
            if LTagInfo_INF.&TYPE = '1' then //single
            begin
              if (LFnCode = '5') or (LFnCode = '6') then
              begin

              end;
            end
            else//multiple
            begin
              if (LFnCode = '15') or  (LFnCode = '16') then
              begin

              end;
            end;
          end;
        end;//for
      end;
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

end.
