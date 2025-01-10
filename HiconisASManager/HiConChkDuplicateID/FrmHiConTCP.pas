unit FrmHiConTCP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RegularExpressions, Vcl.Menus,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, NxScrollControl,
  NxCustomGridControl, NxCustomGrid, NxGrid, NxColumnClasses, NxColumns,
  AdvOfficeTabSet,

  OtlCommon, OtlComm, OtlTaskControl, OtlContainerObserver, otlTask, OtlParallel,
  OtlSync,
  mormot.core.base, mormot.core.os, mormot.core.text,
  mormot.core.collections, mormot.core.variants, mormot.core.json,
  mormot.net.client, mormot.core.unicode, mormot.net.server, mormot.db.sql,

  PngBitBtn, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdIOHandler,
  IdGlobal, IdHTTP, UnitTaskDialogMB,
  UnitChkDupIdData, HtmlParser, UnitTRegExUtil, UnitHtmlUtil, Kit, UnitHiconMariaDBUtil,
  UnitHiConJsonUtil, UnitHiconMPMData, UnitHiconTCPIniConfig,
  FrmHiConTCPConfig
  ;

type
  TIDList = IList<TDupIDListRec>;
  TIDDic = IKeyValue<string, TIDListRec>;

  THiconisTCPF = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    ConsoleMemo: TMemo;
    Splitter1: TSplitter;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Close1: TMenuItem;
    N1: TMenuItem;
    SaveIPListToFile1: TMenuItem;
    SaveDialog1: TSaveDialog;
    LoadIPListFromFile1: TMenuItem;
    OpenDialog1: TOpenDialog;
    PngBitBtn1: TPngBitBtn;
    PngBitBtn2: TPngBitBtn;
    Splitter2: TSplitter;
    Panel3: TPanel;
    Panel4: TPanel;
    IPAddrGrid: TNextGrid;
    RES_NAME: TNxTextColumn;
    PMPM_PIP: TNxTextColumn;
    PMPM_SIP: TNxTextColumn;
    Port: TNxTextColumn;
    BitBtn4: TBitBtn;
    Panel5: TPanel;
    TaskTab: TAdvOfficeTabSet;
    IPGridPopup: TPopupMenu;
    CheckDuplicatedID1: TMenuItem;
    GetPortPrint1: TMenuItem;
    IdTCPClient1: TIdTCPClient;
    CheckDuplicatedIDFromAll1: TMenuItem;
    N2: TMenuItem;
    MPMBackup1: TMenuItem;
    BitBtn1: TBitBtn;
    LoadDupIdCheckResultFile1: TMenuItem;
    ShowProgress1: TMenuItem;
    CheckConnection1: TMenuItem;
    BitBtn3: TBitBtn;
    N4: TMenuItem;
    N5: TMenuItem;
    InfluxDB1: TMenuItem;
    ShowRetentionPolicies1: TMenuItem;
    NextGrid1: TNextGrid;
    AlterRetentionPolicy4OWSFromSelectedIP1: TMenuItem;
    AlterRetentionPolicy4OWSFromSelectedIP2: TMenuItem;
    N6: TMenuItem;
    MPM1: TMenuItem;
    N7: TMenuItem;
    N3: TMenuItem;
    Diagnostic1: TMenuItem;
    NIC1: TMenuItem;
    AdvancedConfiguration1: TMenuItem;
    GetNetworkAdapterList1: TMenuItem;
    Database1: TMenuItem;
    MariaDBConnect1: TMenuItem;
    ExecuteSQL1: TMenuItem;
    Windows1: TMenuItem;
    Straton1: TMenuItem;
    Config1: TMenuItem;
    Version1: TMenuItem;
    NetTimeServiceStatus1: TMenuItem;
    CheckStartup1: TMenuItem;
    AutoLogonEnabled1: TMenuItem;
    GetTagFromSVG1: TMenuItem;
    gzTest1: TMenuItem;
    DESCRIPTION: TNxTextColumn;
    MariaDB1: TMenuItem;
    InfluxDB2: TMenuItem;
    AccessDB1: TMenuItem;
    VerifyLogParam2: TMenuItem;
    ModifyLogParam2: TMenuItem;
    GetJsonFile1: TMenuItem;
    GetTagInfoFromSystemBak1: TMenuItem;
    GetModuleNamebyTagName1: TMenuItem;
    SearchINTTag1: TMenuItem;
    Options1: TMenuItem;
    SetConfig1: TMenuItem;
    Button1: TButton;
    DBInfo1: TMenuItem;
    MPMInfo1: TMenuItem;
    RunState1: TMenuItem;
    RunInfo1: TMenuItem;
    ViewLog1: TMenuItem;
    Utilities1: TMenuItem;
    Other1: TMenuItem;
    Maintenance1: TMenuItem;
    Interfaces1: TMenuItem;
    lres1: TMenuItem;
    lmpm1: TMenuItem;
    lver1: TMenuItem;
    fbver1: TMenuItem;
    version2: TMenuItem;
    resource1: TMenuItem;
    linkmap1: TMenuItem;
    pointmapo1: TMenuItem;
    retainmap1: TMenuItem;
    Web1: TMenuItem;
    Backup1: TMenuItem;
    GetVersions1: TMenuItem;
    hirs1: TMenuItem;
    hirswdt1: TMenuItem;
    logic1: TMenuItem;
    interfacea1: TMenuItem;
    hiscmim1: TMenuItem;
    N8: TMenuItem;
    All1: TMenuItem;
    version3: TMenuItem;
    AccessDBEngineInstalled1: TMenuItem;
    MariaDBInbstalled1: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn4Click(Sender: TObject);
    procedure SaveIPListToFile1Click(Sender: TObject);
    procedure LoadIPListFromFile1Click(Sender: TObject);
    procedure TaskTabChange(Sender: TObject);
    procedure PngBitBtn1Click(Sender: TObject);
    procedure PngBitBtn2Click(Sender: TObject);
//    procedure IPAddrGridSelectCell(Sender: TObject; ACol, ARow: Integer);
    procedure GetPortPrint1Click(Sender: TObject);
    procedure CheckDuplicatedID1Click(Sender: TObject);
    procedure MPMBackup1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure LoadDupIdCheckResultFile1Click(Sender: TObject);
    procedure ShowProgress1Click(Sender: TObject);
    procedure CheckConnection1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure ShowRetentionPolicies1Click(Sender: TObject);
    procedure AlterRetentionPolicy4OWSFromSelectedIP1Click(Sender: TObject);
    procedure AlterRetentionPolicy4OWSFromSelectedIP2Click(Sender: TObject);
    procedure AdvancedConfiguration1Click(Sender: TObject);
    procedure MariaDBConnect1Click(Sender: TObject);
    procedure ExecuteSQL1Click(Sender: TObject);
    procedure NetTimeServiceStatus1Click(Sender: TObject);
    procedure CheckStartup1Click(Sender: TObject);
    procedure AutoLogonEnabled1Click(Sender: TObject);
    procedure GetTagFromSVG1Click(Sender: TObject);
    procedure gzTest1Click(Sender: TObject);
    procedure VerifyLogParam2Click(Sender: TObject);
    procedure ModifyLogParam2Click(Sender: TObject);
    procedure GetJsonFile1Click(Sender: TObject);
    procedure GetTagInfoFromSystemBak1Click(Sender: TObject);
    procedure SearchINTTag1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SetConfig1Click(Sender: TObject);
    procedure version2Click(Sender: TObject);
    procedure fbver1Click(Sender: TObject);
    procedure lmpm1Click(Sender: TObject);
    procedure NextGrid1CellDblClick(Sender: TObject; ACol, ARow: Integer);
    procedure lver1Click(Sender: TObject);
    procedure lres1Click(Sender: TObject);
    procedure version3Click(Sender: TObject);
    procedure GetModuleNamebyTagName1Click(Sender: TObject);
    procedure AccessDBEngineInstalled1Click(Sender: TObject);
    procedure MariaDBInbstalled1Click(Sender: TObject);
  private
    FHiconTCPIniConfig: THiconTCPIniConfig;
    FHiconTCPIniFileName: string;
    //Key: IPName
    FIpAddrDic: IKeyValue<string, TIpListRec>;
    //Key: IPName
    FIDListDic: IKeyValue<string, TStringList>;
    //Key: 1. AI
    //Value: [[],[]] = array of array data
    //web->DB Information->lmpm 조회시 데이터 저장함
    FMPMListDic: IKeyValue<string, string>;
    //MM Address
//    FDupIdList: IList<TDupIDListRec>;
    //Key: IP Address
    FIpNDupIdList: IKeyValue<string, TIDList>;
    //Key: IP Address, TIDDic Key: MM Address
    FIpNIdList: IKeyValue<string, TIDDic>;

    FTCPResponse: TStringList;

    FCancelToken: IOmniCancellationToken;
    FWorker  : IOmniParallelLoop<integer>;
    FIpList,
    FMPMBackupResultList: TStringList;
    FHiConMariaDB: THiConMariaDB;
    FMyIpAddr: string; //This Computer Ip Address
    FIpAddrList4ThisComputer: TStringList;
    FHiConSWVersionRec: THiConSWVersionRec;

    procedure SetNextGridColumn4DupTagId();
    procedure SetIdList2GridByTagText(AIpAddr: string; ATagText: string);
    procedure SaveIpListToFile(AFileName: string);
    procedure LoadIpListFromFile(AFileName: string);
    procedure SetIdList2Grid(AIpAddr: string);
    procedure SetIdList2GridFromIpNIdList(AIpAddr: string);
    procedure SetIdList2GridFromIpNDupIdList(AIpAddr: string);

    function GetSelectedIpAddrList(AIsMaster: Boolean=true): string;
    //AIpAddrList: ';'로 구분됨
    function BackupMPM(AIpAddrList: string): string;
    //AIpAddr: IP 한개임
    function DownloadBackupMPMAsync(AIpAddr: string): string;
    //AIpList: ';'로 구분됨
    function DownloadBackupMPMForEach(AIpList: string): string;
    function GetMPMNameFromIpAddrDic(AIpAddr: string): string;

    procedure GetRetentionPoliciesBySelectedIpList(AIpAddrList: string);
    function AlterRetentionPoliciesBySelectedIpList(AParam: string): string;

    procedure GetNetTimeServiceStatus2Grid();

    function CheckIfExistAcoAutoRunInStartup(var APath: string): Boolean;
    function CheckIfExistAcoAutoRunInBIN(var APath: string): Boolean;
    function CheckIfExistAcoAutoRun: Boolean;
    function CompareAcoAutoRunInStartupNBIN: string;
    function CheckAcoAutoRunIsCorrect: string;
    function CheckIfExistInfluxdbConf: Boolean;
    function CheckInfluxdbConfIsCorrect: string;
    //현재 컴퓨터가 History Station = "E:\" OWS = "D:\" 반환
    function GetLogDrive(var AIsHistoryStation: Boolean): string;

    function GetExtractJsonFromCatOutput(ACatOutput: string): string;
    //이 함수는 MPMxx.tgz파일을 검색 후 데이터 없으면 COMxx.tgz 파일을 검색함
    //AInfTagName: INF_로 시작하는 Tag Name
    //Result: {"Resource":"COM011110.tgz"/"MPM11.tgz", "Port":"ptc04.json", "PortValueInf":{...},"BaseDir": "full path"}
    //       MPM11.tgz의 interface.json에 SlotNo가 존재하면 "Resource" = "MPM11" 그렇지 않고 "COM011xx.tgz"에 존재하면 아래 내용처럼
    //       COM011xx.tgz Name = ASlotNo값이 interface.json->"PORTx"->"InfADDR" 값과 일치해야 함
    function GetTgzNPtcJsonNameFromTgzByInfTag(AInfTagName: string): string;
    //Result: {"Resource":"COM011110"/"MPM11", "Port":"ptc04.json", "PortValueInf":{...},"BaseDir": "full path"}
    //       MPM11.tgz의 interface.json에 SlotNo가 존재하면 "Resource" = "MPM11" 그렇지 않고 "COM011xx.tgz"에 존재하면 아래 내용처럼
    //       COM011xx.tgz Name = ASlotNo값이 interface.json->"PORTx"->"InfADDR" 값과 일치해야 함
    function GetResNPtcJsonNameFromSrcByInfTag(ARec: TTagSearchRec): string;
    //이 함수는 COMxx.tgz 파일만 검색함
    //AInfTagName: INF_로 시작하는 Tag Name
    //Result: {"COM":"COM011110.tgz", "Port":"ptc04.json", "PortValueInf":{...},"BaseDir": "full path"}
    //       COM011xx.tgz Name = ASlotNo값이 interface.json->"PORTx"->"InfADDR" 값과 일치해야 함
    function GetCOMTgzNPortNameFromTgzByInfTag(AInfTagName: string): string;
    //AInfTagName: INF_로 시작하는 Tag Name
    //Result: Tag 값을 통신하는 ptcxx.json 파일 전체 내용 반환
    function GetPtcJsonContentsFromSrcByInfTag(AInfTagName: string; ASrcKind: TTagSearchRec): string;
    //AInfTagName: INF_로 시작하는 Tag Name
    //Result: Tag 값을 통신하는 interface.json->Portx 값을 반환
    function GetPortJsonContentsFromSrcByInfTag(AInfTagName: string; ASrcKind: TTagSearchRec): string;
    //AInfTagName: INF_로 시작하는 Tag Name
    //ASrcKind: 0 = Disk에 백업된 interface.json 파일을 읽음
    //          1 = Disk에 백업된 .tgz로부터 interface.json 파일을 읽음
    //          2 = interface.json 파일을 TCP 통신 연결하여 MPM에서 Download하여 c:\temp에 저장 후 읽음
    //Result: Tag 값을 통신하는 ptcxx.json->Query 내용 중에 InBlk 값이 일치하는 Query Json만 반환
    function GetQueryJsonFromSrcByInfTag(ARec: TTagSearchRec): string;
    function GetModuleTypeFromDBByTagName(ATagName: string): string;
  public
    procedure InitVar;
    procedure DestroyVar;
    procedure InitEnum;

    procedure SetConfig;
    procedure LoadConfigFromFile(AFileName: string = '');
    procedure LoadConfig2Form(AForm: THiConTCPConfigF);
    procedure LoadConfigForm2Object(AForm: THiConTCPConfigF);
    procedure ApplyConfigChanged;

    procedure GetIpList4ThisComputer();
    function GetHiconisIp4ThisComputer(): string;
    function GetHiconisPrimaryIP4ThisComputer(): string;
    function GetHiconisSecondaryIP4ThisComputer(): string;

    function GetIdFromMPM(ARec: TIpListRec): integer;
    procedure GetIdFromMPM_Async(ARec: TIpListRec);
    procedure GetIdsFromIpListDic;
    procedure GetIdsFromIpSelected;
    function GetChannelStrUrlFromIpRec(AIpAddr: string): string;

    procedure GetLResFromIpSelected;
    function GetLResFromMPM(ARec: TIpListRec): integer;
    function GetLResUrlFromIpRec(AIpAddr: string): string;
    procedure SetLResList2GridByTagText(AIpAddr: string; ATagText: string);
    procedure SetNextGridColumn4LRes();
    procedure SetLResList2Grid(const AIpAddr: string);

    procedure GetLMPMFromIpSelected;
    function GetLMPMFromMPM(ARec: TIpListRec): integer;
    function GetLMPMUrlFromIpRec(AIpAddr: string): string;
    procedure SetLMPMList2GridByTagText(AIpAddr: string; ATagText: string);
    procedure SetNextGridColumn4LMPM();
    procedure SetLMPMList2Grid(const AIpAddr: string);

    procedure SetLMPMFromMPMList2GridByKey(const AIpAddr, AKey: string);

    procedure GetVersionMPMFromIpSelected;
    function GetVersionMPMFromMPM(ARec: TIpListRec): integer;
    function GetVersionMPMUrlFromIpRec(AIpAddr: string): string;
    procedure SetVersionMPMList2GridByTagText(AIpAddr: string; ATagText: string);
    procedure SetNextGridColumn4VersionMPM();

    procedure GetVersionIntfFromIpSelected;
    function GetVersionIntfFromMPM(ARec: TIpListRec): integer;
    function GetVersionIntfUrlFromIpRec(AIpAddr: string): string;
    //THiConSWVersionRec.FInterface_a/FHiscm_Im을 채움
    procedure GetVersionIntfFromTagText(ATagText: string);
    procedure SetVersionIntfList2GridByTagText(AIpAddr: string; ATagText: string);
    procedure SetVersionIntf2Grid(const AIpAddr: string);
    procedure SetNextGridColumn4VersionIntf();

    procedure GetFBVerFromIpSelected;
    function GetFBVerFromMPM(ARec: TIpListRec): integer;
    function GetFBVerUrlFromIpRec(AIpAddr: string): string;
    procedure SetFBVerList2GridByTagText(AIpAddr: string; ATagText: string);
    procedure SetNextGridColumn4FBVer();

    procedure GetLVerFromIpSelected;
    function GetLVerFromMPM(ARec: TIpListRec): integer;
    function GetLVerUrlFromIpRec(AIpAddr: string): string;
    //THiConSWVersionRec.FHirs/FLogic을 채움
    procedure GetLVerListFromTagText(ATagText: string; out ADesc, ALogicVer: string);
    procedure SetLVerList2GridByTagText(const AIpAddr, ATagText: string);
    procedure SetLVerList2Grid(const AIpAddr, ADesc, AVer: string);
    procedure SetNextGridColumn4LVer();

    procedure HtmlParseFunc();
    procedure GetPreTagTextFromHtml();

    function GetFileNameFromIpAddr(AIpAddr: string): string;
    function GetIpListRecByIp(AIpAddr: string): TIpListRec;
    function GetIpListRecByResName(AResName: string): TIpListRec;

    procedure SetConnectStatus2IpAddrGridBySelected(AIdx: integer; AIsResetStatus: Boolean=false);
    procedure SetGridByConnectStatusByIp(AIdx: integer; AIpAddr: string=''; AIsResetStatus: Boolean=false);

    procedure SaveDupIdCheckResult2File(AIpAddr: string);
    procedure LoadDupIdCheckResultFromFile(AIpAddr: string);

    procedure DisplayDuplicatedAddr();
    procedure SetVisibleAllGridRow(AIsShow: Boolean);

    function GetPortPrintDebug(AIpAddr, APortName: string): string;
    function GetJsonFromMPMByFileName(AIpAddrList, AJsonFileName: string): string;
    procedure Log(const AMsg: string);
    procedure ShowTD(const ATDRec: TMsgBox);
  end;

var
  HiconisTCPF: THiconisTCPF;

implementation

uses System.TimeSpan, System.Diagnostics, PJEnvVars,
  UnitStringUtil, UnitExcelUtil, UnitNextGridUtil2, UnitAnimationThread,
  UnitCryptUtil3, pingsend, UnitHiConInfluxDBUtil, UnitNICUtil, UnitServiceUtil,
  UnitSystemUtil, UnitXMLUtil, getIp, UnitHiconSystemDBUtil, UnitGZipJclUtil,
  UnitJsonUtil, sevenzip, UnitHiconOWSUtil,
  FrmIpList, FrmElapsedTime, FrmTwoInputEdit, FrmStringsEdit, FrmTagInputEdit,
  FrmResPortInfo4INFTag, FrmNextGrid, FrmSearchModuleByTagName
  ;

{$R *.dfm}

procedure THiconisTCPF.SetGridByConnectStatusByIp(AIdx: integer; AIpAddr: string;
  AIsResetStatus: Boolean);
begin
  if PingHost(AIpAddr) = -1 then
//      ChangeRowColorByIndex(IPAddrGrid, AIdx, clYellow)
    ChangeRowFontColorByIndex(IPAddrGrid, AIdx, clRed)
  else
//      ChangeRowColorByIndex(IPAddrGrid, AIdx, clGreen)
    ChangeRowFontColorByIndex(IPAddrGrid, AIdx, clBlack);
end;

procedure THiconisTCPF.AccessDBEngineInstalled1Click(Sender: TObject);
var
  LResult: string;
begin
//  if THiConSystemDB.CheckAccessDBEngineInstalledFromADODB() then
  if THiConOWS.CheckAccessDBEngineInstalledFromRegistry() then
    LResult := 'AccessDB Engine Installed!'
  else
    LResult := 'AccessDB Engine Not Installed!';

  ShowMessage(LResult);
end;

procedure THiconisTCPF.AdvancedConfiguration1Click(Sender: TObject);
var
  LList: TStringList;
  LStr: string;
  LVar: variant;
begin
//  EnableNIC_WMI();
//  LList := GetNICIndexList_WMI();

//  LList := GetAdvPropertyListOfNIC();
//  LList := GetAdvPropertyListFromRegByIdx('0013');
  LStr := GetAdvNICProp2JsonFromRegKeyByIpAddr('10.8.2.100');
  LVar := _JSON(StringToUtf8(LStr));
  AddNextGridRowsFromVariant2(NextGrid1, LVar, True);
//  ShowMessage(LStr);
//  ShowMessage(GetNICAdvPropsJsonFromRegistryByIpAddr('', LList));

//  LList.Free;
end;

function THiconisTCPF.AlterRetentionPoliciesBySelectedIpList(AParam: string): string;
var
  LIpAddr, LIpAddrList, LIpAddrList2, LDuration, LShardDuration, LFailIpList: string;
  LVar: variant;
  LIsFirstRun: Boolean;
  LRec: TInfluxQueryResult;
begin
  LIsFirstRun := False;

  if AParam <> '' then
  begin
    //';'로 구분됨
    LIpAddrList := GetSelectedIpAddrList();
    LIpAddrList2 := LIpAddrList;
    //Duration;ShardDuration = ';'로 구분됨
    LDuration := StrToken(AParam, ';');
    LShardDuration := StrToken(AParam, ';');
  end;

  LFailIpList := '';

  while LIpAddrList <> '' do
  begin
    LIpAddr := StrToken(LIpAddrList, ';');
    Result := SetRetentionPolicies4OWSFromInfluxDB(LIpAddr, LDuration, LShardDuration);

    if Result <> '' then
    begin
      LRec := GetResultRecOfSetRetentPolicy(Result);

      if LRec.statement_id <> 0 then
        LFailIpList := LFailIpList + LIpAddr + #13#10;
    end;
  end;

  if LFailIpList = '' then
  begin
    ShowMessage('Alter Retention Policies is successeful.');
    GetRetentionPoliciesBySelectedIpList(LIpAddrList2);
  end
  else
    ShowMessage('Alter Retention Policies is fail. The fail IP List is as below: ' + #13#10 + LFailIpList);
end;

procedure THiconisTCPF.AlterRetentionPolicy4OWSFromSelectedIP1Click(
  Sender: TObject);
var
  LParam: string;
begin
  LParam := CreateTwoInputEdit('Alter Retention Policy for InfluxDB','Duration','30d','Shard Duration','1d');

  if AlterRetentionPoliciesBySelectedIpList(LParam) <> '' then
    ;
end;

procedure THiconisTCPF.AlterRetentionPolicy4OWSFromSelectedIP2Click(
  Sender: TObject);
var
  LParam: string;
begin
  LParam := CreateTwoInputEdit('Alter Retention Policy for InfluxDB','Duration','365d','Shard Duration','7d');

  if AlterRetentionPoliciesBySelectedIpList(LParam) <> '' then
    ;
end;

procedure THiconisTCPF.ApplyConfigChanged;
begin
  LoadConfigFromFile;
end;

procedure THiconisTCPF.AutoLogonEnabled1Click(Sender: TObject);
begin
  if not THiConOWS.CheckAdminAutoLogin() then
    ShowMessage('AutoLogon not enabled');
end;

function THiconisTCPF.BackupMPM(AIpAddrList: string): string;
var
  LIpAddr: string;
//  LProgress: IProgress;
begin
//  LProgress := ShowProgress('Downloading MPM...', False);
//  LProgress.EnableAbort := True;
//  LProgress.Marquee := True;
//
//  LProgress.UpdateMessage('Changing...');
//
//  while (not LProgress.Aborted) do
//  begin
    while AIpAddrList <> '' do
    begin
      LIpAddr := StrToken(AIpAddrList, ';');
      DownloadBackupMPMAsync(LIpAddr);
    end;//while
//  end;
end;

procedure THiconisTCPF.BitBtn1Click(Sender: TObject);
begin
  NextGrid1.BeginUpdate;
  try
    NextGrid1.ClearRows;
  finally
    NextGrid1.EndUpdate();
  end;
end;

procedure THiconisTCPF.BitBtn3Click(Sender: TObject);
begin
  SetConnectStatus2IpAddrGridBySelected(IpAddrGrid.SelectedRow);
end;

procedure THiconisTCPF.BitBtn4Click(Sender: TObject);
var
  LJson:string;
  LIpListRec: TIpListRec;
begin
  LJson := Utf8ToString(FIpAddrDic.Data.SaveToJson());

  if ShowIPAddressListForm(LJson) = mrOK then
  begin
    FIpAddrDic.Clear;
    FIpAddrDic.Data.LoadFromJson(StringToUtf8(LJson));

    LJson := Utf8ToString(GetIPListJsonFromIpList(FIpAddrDic));
    IPAddrGrid.ClearRows;
    SetIpListFromJson2Grid(LJson, IPAddrGrid);
  end;
end;

procedure THiconisTCPF.Button1Click(Sender: TObject);
//var
//  LStrList: TStringList;
begin
//  LStrList := GetCOMCardNameListFromDirByMPMName('MPM21', 'E:\temp\HiCONIS\DB\DOWNLOAD');
  ShowMessage(THiConSystemDB.GetCOMCardNameListFromIOCTableByMPMName('MPM31', ''));
//  LStrList.Free;
end;

function THiconisTCPF.CheckAcoAutoRunIsCorrect: string;
begin

end;

procedure THiconisTCPF.CheckConnection1Click(Sender: TObject);
begin
  if IpAddrGrid.SelectedRow = -1 then
  begin
    ShowMessage('IP를 선택하세요.');
    exit;
  end;

  SetConnectStatus2IpAddrGridBySelected(IpAddrGrid.SelectedRow);
end;

procedure THiconisTCPF.CheckDuplicatedID1Click(Sender: TObject);
begin
//  GetIdsFromIpListDic();
  GetIdsFromIpSelected();
end;

function THiconisTCPF.CheckIfExistAcoAutoRun: Boolean;
var
  LPath, LStr, LMsg: string;
begin
  Result := CheckIfExistAcoAutoRunInBIN(LPath);

  if Result then
    LStr := 'AcoAutoRun-NX.bat file is exist in below path:'
  else
    LStr := 'AcoAutoRun-NX.bat file is NOT exist in below path:';

  LMsg := LStr + #13#10 + LPath + #13#10#13#10;

  Result := CheckIfExistAcoAutoRunInStartup(LPath);

  LMsg := LMsg + LStr + #13#10 + LPath;

  ShowMessage(LMsg);
end;

function THiconisTCPF.CheckIfExistAcoAutoRunInBIN(var APath: string): Boolean;
begin
  APath := 'D:\ACONIS-NX\BIN\AcoAutoRun-NX.bat';
  Result := FileExists(APath);
end;

function THiconisTCPF.CheckIfExistAcoAutoRunInStartup(var APath: string): Boolean;
begin
  APath := GetEnvVarValue('APPDATA');
  APath := APath + '\Microsoft\Windows\Start Menu\Programs\Startup\AcoAutoRun-NX.bat';
  Result := FileExists(APath);
end;

function THiconisTCPF.CheckIfExistInfluxdbConf: Boolean;
var
  LPath, LStr, LMsg: string;
begin
  LPath := 'C:\Program Files\InfluxData\influxdb\influxdb-1.8.10-1\influxdb.conf';
  Result := CheckIfExistAcoAutoRunInBIN(LPath);

  if Result then
    LStr := 'AcoAutoRun-NX.bat file is exist in below path:'
  else
    LStr := 'AcoAutoRun-NX.bat file is NOT exist in below path:';

  LMsg := LStr + #13#10 + LPath + #13#10#13#10;

  Result := CheckIfExistAcoAutoRunInStartup(LPath);

  LMsg := LMsg + LStr + #13#10 + LPath;

  ShowMessage(LMsg);
end;

function THiconisTCPF.CheckInfluxdbConfIsCorrect: string;
begin

end;

procedure THiconisTCPF.CheckStartup1Click(Sender: TObject);
begin
  CheckIfExistAcoAutoRun();
end;

function THiconisTCPF.CompareAcoAutoRunInStartupNBIN: string;
begin

end;

procedure THiconisTCPF.DestroyVar;
begin
  FIpAddrList4ThisComputer.Free;
  FHiConMariaDB.DestroyDB();
  FHiConMariaDB.Free;
  FTCPResponse.Free;
  FHiconTCPIniConfig.Free;

  if Assigned(FIpList) then
    FIpList.Free;

  if Assigned(FMPMBackupResultList) then
    FMPMBackupResultList.Free;
end;

procedure THiconisTCPF.DisplayDuplicatedAddr;
var
  LIDList: TIDList;
  LRec: TDupIDListRec;
  i: integer;
begin
  SetVisibleAllGridRow(False);

  LIDList := FIpNDupIdList.Value[IPAddrGrid.SelectedRow];

  for LRec in LIDList do
  begin
    for i := 0 to NextGrid1.RowCount - 1 do
    begin
      if LRec.DupIdRec.MMAddress = NextGrid1.CellsByName['MMAddress', i] then
        NextGrid1.Row[i].Visible := True;
    end;
  end;
end;

function THiconisTCPF.DownloadBackupMPMAsync(AIpAddr: string): string;
var
  LResult: string;
begin
  Parallel.Async(
    procedure (const task: IOmniTask)
    var
      LHttp: TIdHttp;
      Lurl, LQuery, LFullUrl, LBackupFileSufix, LFN: string;
      LStream: TMemoryStream;
    begin
      LHttp := TIdHttp.Create(nil);
      try
        LUrl := 'http://' + AIpAddr + '/Backup';
        LQuery := '&=Make%20Backup';
        LFullUrl := LUrl + '?' + LQuery;

        LFullUrl := LHttp.Get(LFullUrl);

        if Pos('Download Backup', LFullUrl) > 0  then
        begin
          LStream := TMemoryStream.Create;
          try
            LUrl := 'http://' + AIpAddr + '/';
            //IP 마지막 주소값을 가져옴
            LBackupFileSufix := strTokenRev(AIpAddr, '.');
            LFN := 'MPM' + LBackupFileSufix + '.tgz';
            LQuery := '&=Download+Backup';
            LFullUrl := LUrl + '/' + LFN;// + '?' + LQuery;

            LHttp.Get(LFullUrl, LStream);
            LFN := 'c:\temp\' + LFN;
            LStream.SaveToFile(LFN);
            LResult := LFN;
          finally
            LStream.Free;
          end;
        end;
//          ShowMessage(Lurl);
      finally
        LHttp.Free;
      end;
    end,

    //Main thread에서 실행됨
    Parallel.TaskConfig.OnMessage(Self).OnTerminated(
      procedure (const ATask: IOmniTaskControl)
      begin
        Log('Backup file is downloaded to ' + LResult);
      end
    )
  );
end;

function THiconisTCPF.DownloadBackupMPMForEach(AIpList: string): string;
var
  LStr: string;
begin
  if not Assigned(FIpList) then
    FIpList := TStringList.Create
  else
    FIpList.Clear;

  while AIpList <> '' do
  begin
    LStr := StrToken(AIpList, ';');
    FIpList.Add(LStr);
  end;

  if not Assigned(FMPMBackupResultList) then
    FMPMBackupResultList := TStringList.Create
  else
    FMPMBackupResultList.Clear;

  ShowElapsedTimeForm();

  FWorker := Parallel.ForEach(0, FIpList.Count - 1)
    .CancelWith(FCancelToken)
    .NumTasks(FIpList.Count)
    .PreserveOrder
    .NoWait
    .OnStop(
        procedure (const task: IOmniTask)
        begin
          // because of NoWait, OnStop delegate is invoked from the worker code;
          //we must not destroy the worker at that point or the program will block
          task.Invoke(
            procedure
            begin
              ElapsedTimeF.Hide;
              ElapsedTimeF.Free;
              FMPMBackupResultList.SaveToFile('c:\temp\FMPMBackupResultList.txt');
              ShowMessage(FMPMBackupResultList.Text);
            end

          );//Invoke
        end
    ); //OnStop

    FWorker.Execute(
      procedure (const task: IOmniTask; const i: integer)
      var
        LHttp: TIdHttp;
        LIpAddr, Lurl, LQuery, LFullUrl, LBackupFileSufix, LFN: string;
        LStream: TMemoryStream;
        LStopWatch: TStopWatch;
      begin
        LIpAddr := FIpList.Strings[i];

        if PingHost(LIpAddr) = -1 then
        begin
          FMPMBackupResultList.Add(LiPAddr + ' : bad connection!');
        end
        else
        begin
          LStopWatch := TStopWatch.StartNew;
          LHttp := TIdHttp.Create(nil);
          try
            LUrl := 'http://' + LIpAddr + '/Backup';
            LQuery := '&=Make%20Backup';
            LFullUrl := LUrl + '?' + LQuery;

            LFullUrl := LHttp.Get(LFullUrl);

            if Pos('Download Backup', LFullUrl) > 0  then
            begin
              LStream := TMemoryStream.Create;
              try
                LUrl := 'http://' + LIpAddr + '/';
                //IP 마지막 주소값을 가져옴
                LBackupFileSufix := strTokenRev(LIpAddr, '.');
                LFN := 'MPM' + LBackupFileSufix + '.tgz';
                LQuery := '&=Download+Backup';
                LFullUrl := LUrl + '/' + LFN;// + '?' + LQuery;

                LHttp.Get(LFullUrl, LStream);
                LFN := 'c:\temp\' + LFN;
                LStream.SaveToFile(LFN);

                LFN := LFN + ' => Elapsed Time : ' +
                  IntToStr(LStopWatch.Elapsed.Minutes) + '분 ' +
                  IntToStr(LStopWatch.Elapsed.Seconds) + '초';
                FMPMBackupResultList.Add(LFN);
              finally
                LStream.Free;
              end;
            end;
    //          ShowMessage(Lurl);
          finally
            LHttp.Free;
            LStopWatch.Stop;
          end;
        end;//if ping
      end
    );
end;

procedure THiconisTCPF.ExecuteSQL1Click(Sender: TObject);
var
  LSQL: string;
  LSQLDBRows: ISQLDBRows;
  LNoResult: Boolean;
  AutoRun, Conf: RawByteString;
begin
  AutoRun := StringFromFile('E:/pjh/Dev/Lang/Bat/AcoAutoRun-NX.bat');
  Conf := StringFromFile('E:/pjh/Dev/Lang/Bat/influxdb.conf');
//  LSQL := 'CREATE OR REPLACE TABLE HiconConfig (AcoAutoRun_NX_bat TEXT, Influxdb_conf TEXT)';
//  LSQL := 'CREATE OR REPLACE TEMPORARY TABLE TempHiconConfig  LIKE HiconConfig';
//  LSQL := 'INSERT INTO HiconConfig(AcoAutoRun_NX_bat, Influxdb_conf) VALUES("AcoAutoRun_NX_bat", "Influxdb_conf")';// + + ')';
//  LSQL := 'UPDATE HiconConfig SET AcoAutoRun_NX_bat = "' + AutoRun + '", Influxdb_conf = "' + Conf + '"';// + + ')';
//  LSQL := 'UPDATE HiconConfig SET AcoAutoRun_NX_bat = LOAD_FILE("E:/pjh/Dev/Lang/Bat/AcoAutoRun-NX.bat"), Influxdb_conf = LOAD_FILE("E:/pjh/Dev/Lang/Bat/influxdb.conf")';
//  LSQL := 'UPDATE HiconConfig SET AcoAutoRun_NX_bat = LOAD_FILE("//10.8.2.100/d/AcoAutoRun-NX.bat"), Influxdb_conf = LOAD_FILE("//10.8.2.100/d/influxdb.conf")';
//  LSQL := 'UPDATE HiconConfig SET AcoAutoRun_NX_bat = LOAD_FILE("c:/temp/AcoAutoRun-NX.bat"), Influxdb_conf = LOAD_FILE("c:/temp/influxdb.conf")';
//  아래 SQL 실행시 => Permission error code 13 발생함
//  LSQL := 'SELECT LOAD_FILE("C:/temp/AcoAutoRun-NX.bat") INTO OUTFILE "C:/Users/Administrator/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup/AcoAutoRun-NX.bat"';
//  아래 SQL 실행시 => 네트웤 드라이브 사용: 복사된 AcoAutoRun-NX.bat 내용이 비어있음
//  LSQL := 'SELECT LOAD_FILE("//10.8.2.100/d/pjh/AcoAutoRun-NX.bat") INTO OUTFILE "C:/temp/333/AcoAutoRun-NX.bat"';
//  아래 SQL 실행시 => 정상 작동함
//  LSQL := 'SELECT LOAD_FILE("C:/temp/AcoAutoRun-NX.bat") INTO OUTFILE "C:/temp/333/AcoAutoRun-NX.bat"';

  if TpjhStringsEditorDlg.Execute(LSQL) then
  begin
    LNoResult := FHiConMariaDB.GetResultStatFromSQL(LSQL);
    FHiConMariaDB.ExecuteQuery(LSQL, LNoResult);
  end;
end;

procedure THiconisTCPF.fbver1Click(Sender: TObject);
begin
  GetFBVerFromIpSelected();
end;

procedure THiconisTCPF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DestroyVar;
end;

procedure THiconisTCPF.FormCreate(Sender: TObject);
begin
  InitVar;
end;

function THiconisTCPF.GetCOMTgzNPortNameFromTgzByInfTag(
  AInfTagName: string): string;
var
  LStr, LBaseDir: string;
begin
  //UnitGZipJclUtil 유닛을 사용하기 위해서 SevenzipLibraryDir에 7z.dll 경로를 지정함
  SevenzipLibraryDir := ExtractFilePath(Application.ExeName) + 'lib\';
  LBaseDir := DOWNLOAD_FULL_PATH;

  LStr := THiConSystemDB.GetTagInfo2JsonFromINFTable(AInfTagName);
  Result := GetCOMTgzNPortNameByMPMNameWithSlotNo(LStr, LBaseDir);
end;

function THiconisTCPF.GetExtractJsonFromCatOutput(ACatOutput: string): string;
var
  LStr: string;
begin
  LStr := StrToken(ACatOutput, '{');
  LStr := StrToken(ACatOutput, '@');
  LStr := StringReplace(LStr, '[root', '', [rfReplaceAll]);
  LStr := StringReplace(LStr, #13, '', [rfReplaceAll]);
  LStr := StringReplace(LStr, #10, '', [rfReplaceAll]);
  Result := '{' + LStr;
end;

procedure THiconisTCPF.GetFBVerFromIpSelected;
var
  i: integer;
  LIp, LResName: string;
  LIpListRec: TIpListRec;
begin
  for i := 0 to IPAddrGrid.RowCount - 1 do
  begin
    if IPAddrGrid.Row[i].Selected then
    begin
      LResName := IPAddrGrid.CellsByName['RES_NAME', i];
      LIp := IPAddrGrid.CellsByName['PMPM_PIP', i];
      LIpListRec := GetIpListRecByResName(LResName);

      if GetFBVerFromMPM(LIpListRec) = -1 then
        ShowMessage('Host not connected : <' + LIpListRec.PMPM_PIP + '>');
    end;
  end;
end;

function THiconisTCPF.GetFBVerFromMPM(ARec: TIpListRec): integer;
var
  LCon: RawByteString;
  LUrl, LIpAddr: string;
begin
  if ARec.PMPM_PIP = '127.0.0.1' then
    exit;

  LIpAddr := ARec.PMPM_PIP;

  Result := PingHost(LIpAddr);

  if Result = -1 then
  begin
    Log('Host not connected : <' + LIpAddr + '>');
    exit;
  end;

  LUrl := GetFBVerUrlFromIpRec(LIpAddr);

  LCon := HttpGet(LUrl, nil, False, nil, 5000);

  if LCon = '' then
  begin
    LIpAddr := ARec.PMPM_SIP;
    LUrl := GetFBVerUrlFromIpRec(LIpAddr);
    LCon := HttpGet(LUrl);

    if LCon <> '' then
    begin
      ConsoleMemo.Lines.Clear;
      ConsoleMemo.Lines.Text := LCon;
      SetFBVerList2GridByTagText(LIpAddr, ConsoleMemo.Lines.Text);
    end;
  end
  else
  begin
    ConsoleMemo.Lines.Clear;
    ConsoleMemo.Lines.Text := LCon;
    SetFBVerList2GridByTagText(LIpAddr, ConsoleMemo.Lines.Text);
  end;
end;

function THiconisTCPF.GetFBVerUrlFromIpRec(AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + '/fbver';
end;

function THiconisTCPF.GetFileNameFromIpAddr(AIpAddr: string): string;
begin
  EnsureDirectoryExists('c:\temp\');
  Result := 'c:\temp\' + replaceString(AIpAddr, '.', '_') + '.pjh';
end;

function THiconisTCPF.GetHiconisIp4ThisComputer: string;
begin
  Result := GetHiconisPrimaryIP4ThisComputer();

  if Result = '' then
    Result := GetHiconisSecondaryIP4ThisComputer();
end;

function THiconisTCPF.GetHiconisPrimaryIP4ThisComputer: string;
var
  LStr: string;
begin
  Result := '';

  for LStr in FIpAddrList4ThisComputer do
  begin
    if Pos('10.', LStr) > 0 then
    begin
      Result := LStr;
      exit;
    end;
  end;
end;

function THiconisTCPF.GetHiconisSecondaryIP4ThisComputer: string;
var
  LStr: string;
begin
  Result := '';

    for LStr in FIpAddrList4ThisComputer do
    begin
      if Pos('11.', LStr) > 0 then
      begin
        Result := LStr;
        exit;
      end;
    end;
end;

function THiconisTCPF.GetIdFromMPM(ARec: TIpListRec): integer;
var
  LCon: RawByteString;
  LUrl, LIpAddr: string;
begin
  if ARec.PMPM_PIP = '127.0.0.1' then
    exit;

  LIpAddr := ARec.PMPM_PIP;

  Result := PingHost(LIpAddr);

  if Result = -1 then
  begin
    Log('Host not connected : <' + LIpAddr + '>');
    exit;
  end;

  LUrl := GetChannelStrUrlFromIpRec(LIpAddr);

  LCon := HttpGet(LUrl, nil, False, nil, 5000);

  if LCon = '' then
  begin
    LIpAddr := ARec.PMPM_SIP;
    LUrl := GetChannelStrUrlFromIpRec(LIpAddr);
    LCon := HttpGet(LUrl);

    if LCon <> '' then
    begin
      ConsoleMemo.Lines.Clear;
      ConsoleMemo.Lines.Text := LCon;
      SetIdList2GridByTagText(LIpAddr, ConsoleMemo.Lines.Text);
    end;
  end
  else
  begin
    ConsoleMemo.Lines.Clear;
    ConsoleMemo.Lines.Text := LCon;
    SetIdList2GridByTagText(LIpAddr, ConsoleMemo.Lines.Text);
  end;
end;

procedure THiconisTCPF.GetIdFromMPM_Async(ARec: TIpListRec);
var
  LIpAddr: string;
  LCon: RawByteString;
begin
  if ARec.PMPM_PIP = '127.0.0.1' then
    exit;

  LIpAddr := ARec.PMPM_PIP;

  Parallel.Async(
    procedure (const task: IOmniTask)
    var
      LHttp: TIdHttp;
      Lurl, LQuery, LFullUrl: string;
    begin
      LUrl := GetChannelStrUrlFromIpRec(LIpAddr);
      LCon := HttpGet(LUrl);

      if LCon = '' then
      begin
        LIpAddr := ARec.PMPM_SIP;
        LUrl := GetChannelStrUrlFromIpRec(LIpAddr);
        LCon := HttpGet(LUrl);
      end;
    end,

    Parallel.TaskConfig.OnMessage(Self).OnTerminated(
      procedure
      begin
        if LCon <> '' then
        begin
          ConsoleMemo.Lines.Clear;
          ConsoleMemo.Lines.Text := LCon;
          SetIdList2GridByTagText(LIpAddr, ConsoleMemo.Lines.Text);
        end;
      end
    )
  );
end;

procedure THiconisTCPF.GetIdsFromIpListDic;
var
  LIpListRec: TIpListRec;
  i: integer;
begin
  NextGrid1.ClearRows;
  FIpNIdList.Clear;
  FIpNDupIdList.Clear;

  for i := 0 to FIpAddrDic.Count - 1 do
//  for LIpListRec in FIpAddrDic do
  begin
    LIpListRec := FIpAddrDic.Value[i];
//    GetIdFromMPM(LIpListRec);
    GetIdFromMPM_Async(LIpListRec);
  end;
end;

procedure THiconisTCPF.GetIdsFromIpSelected;
var
  i: integer;
  LIp, LResName: string;
  LIpListRec: TIpListRec;
begin
//  NextGrid1.ClearRows;
  FIpNIdList.Clear;
  FIpNDupIdList.Clear;

  for i := 0 to IPAddrGrid.RowCount - 1 do
  begin
    if IPAddrGrid.Row[i].Selected then
    begin
      LResName := IPAddrGrid.CellsByName['RES_NAME', i];
      LIp := IPAddrGrid.CellsByName['PMPM_PIP', i];
      LIpListRec := GetIpListRecByResName(LResName);

      if GetIdFromMPM(LIpListRec) = -1 then
        ShowMessage('Host not connected : <' + LIpListRec.PMPM_PIP + '>')
      else
        SaveDupIdCheckResult2File(LIp);
    end;
  end;
end;

procedure THiconisTCPF.GetIpList4ThisComputer;
begin
  FIpAddrList4ThisComputer := GetLocalIPList();
end;

function THiconisTCPF.GetIpListRecByIp(AIpAddr: string): TIpListRec;
begin
  if not FIpAddrDic.TryGetValue(AIpAddr, Result) then
    Result := Default(TIpListRec);
end;

function THiconisTCPF.GetIpListRecByResName(AResName: string): TIpListRec;
begin
  if not FIpAddrDic.TryGetValue(AResName, Result) then
    Result := Default(TIpListRec);
end;

procedure THiconisTCPF.GetJsonFile1Click(Sender: TObject);
var
  LIpAddrList, LStr: string;
begin
  //';'로 구분됨
  LIpAddrList := GetSelectedIpAddrList();

  LStr := GetJsonFromMPMByFileName(LIpAddrList, 'interface.json');
  FileFromString(LStr, 'c:\temp\interface.json');
  LStr := GetJsonFromMPMByFileName(LIpAddrList, 'channel.json');
  FileFromString(LStr, 'c:\temp\channel.json');
end;

function THiconisTCPF.GetJsonFromMPMByFileName(AIpAddrList,
  AJsonFileName: string): string;
var
  LIOHandler: TIdIOHandler;
  LIpAddr, LOutput: string;
  LBytesRead: integer;
  LBuffer: TIdBytes;
begin
  Result := '';
  FTCPResponse.Clear;

//  if IdTCPClient1.Connected then
//    IdTCPClient1.Disconnect;

  while AIpAddrList <> '' do
  begin
    LIpAddr := StrToken(AIpAddrList, ';');

    IdTCPClient1.Host := LIpAddr;
    IdTCPClient1.Port := 23;

    if not IdTCPClient1.Connected then
      IdTCPClient1.Connect;

    LIOHandler := IdTCPClient1.IOHandler;

    LIOHandler.WaitFor('login:');
    LIOHandler.WriteLn('root');
    LIOHandler.WaitFor('$');
    LIOHandler.WriteLn('cat /home/db/' + AJsonFileName);

//    if LIOHandler.InputBufferIsEmpty then
//      LIOHandler.CheckForDataOnSource(1000);

    while LIOHandler.CheckForDataOnSource(1000) do
    begin
      LBytesRead := LIOHandler.InputBuffer.Size;

      if LBytesRead > 0 then
      begin
        SetLength(LBuffer, LBytesRead);

        LIOHandler.ReadBytes(LBuffer, LBytesRead, False);
        LOutput := TEncoding.ASCII.GetString(TArray<Byte>(LBuffer));
        FTCPResponse.Add(LOutput);
      end;
    end;

//    ConsoleMemo.Lines.Assign(FTCPResponse);
    Result := GetExtractJsonFromCatOutput(FTCPResponse.Text);
    ConsoleMemo.Lines.Add(Result);
  end;

  IdTCPClient1.Disconnect;
end;

procedure THiconisTCPF.GetLMPMFromIpSelected;
var
  i: integer;
  LIp, LResName: string;
  LIpListRec: TIpListRec;
begin
  for i := 0 to IPAddrGrid.RowCount - 1 do
  begin
    if IPAddrGrid.Row[i].Selected then
    begin
      LResName := IPAddrGrid.CellsByName['RES_NAME', i];
      LIp := IPAddrGrid.CellsByName['PMPM_PIP', i];
      LIpListRec := GetIpListRecByResName(LResName);

      if GetLMPMFromMPM(LIpListRec) = -1 then
        ShowMessage('Host not connected : <' + LIpListRec.PMPM_PIP + '>');
    end;
  end;
end;

function THiconisTCPF.GetLMPMFromMPM(ARec: TIpListRec): integer;
var
  LCon: RawByteString;
  LUrl, LIpAddr: string;
begin
  if ARec.PMPM_PIP = '127.0.0.1' then
    exit;

  LIpAddr := ARec.PMPM_PIP;

  Result := PingHost(LIpAddr);

  if Result = -1 then
  begin
    Log('Host not connected : <' + LIpAddr + '>');
    exit;
  end;

  LUrl := GetLMPMUrlFromIpRec(LIpAddr);

  LCon := HttpGet(LUrl, nil, False, nil, 5000);

  if LCon = '' then
  begin
    LIpAddr := ARec.PMPM_SIP;
    LUrl := GetLMPMUrlFromIpRec(LIpAddr);
    LCon := HttpGet(LUrl);

    if LCon <> '' then
    begin
      ConsoleMemo.Lines.Clear;
      ConsoleMemo.Lines.Text := LCon;
      SetLMPMList2GridByTagText(LIpAddr, ConsoleMemo.Lines.Text);
    end;
  end
  else
  begin
    ConsoleMemo.Lines.Clear;
    ConsoleMemo.Lines.Text := LCon;
    SetLMPMList2GridByTagText(LIpAddr, ConsoleMemo.Lines.Text);
  end;
end;

function THiconisTCPF.GetLMPMUrlFromIpRec(AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + '/lmpm';
end;

function THiconisTCPF.GetLogDrive(var AIsHistoryStation: Boolean): string;
var
  LJson: RawUtf8;
  LDocDict: IDocDict;
begin
  Result := '';
  AIsHistoryStation := False;

  LJson := THiConSystemDB.GetHistoryStationInfo2JsonFromDB();

  if LJson <> '' then
  begin
    LDocDict := DocDict(LJson);

    //본 프로그램이 실행되는 컴퓨터가 History Station임
    if LDocDict.S['PMPM_PIP'] = FMyIpAddr then
    begin
      AIsHistoryStation := True;
      Result := 'E:';

      //E Drive가 없을 경우
      if not DirectoryExists(Result + '\') then
        Result := 'D:';
    end
    else
      Result := 'D:';
  end;
end;

procedure THiconisTCPF.GetLResFromIpSelected;
var
  i: integer;
  LIp, LResName: string;
  LIpListRec: TIpListRec;
begin
  for i := 0 to IPAddrGrid.RowCount - 1 do
  begin
    if IPAddrGrid.Row[i].Selected then
    begin
      LResName := IPAddrGrid.CellsByName['RES_NAME', i];
      LIp := IPAddrGrid.CellsByName['PMPM_PIP', i];
      LIpListRec := GetIpListRecByResName(LResName);

      if GetLResFromMPM(LIpListRec) = -1 then
        ShowMessage('Host not connected : <' + LIpListRec.PMPM_PIP + '>');
    end;
  end;
end;

function THiconisTCPF.GetLResFromMPM(ARec: TIpListRec): integer;
var
  LCon: RawByteString;
  LUrl, LIpAddr: string;
begin
  if ARec.PMPM_PIP = '127.0.0.1' then
    exit;

  LIpAddr := ARec.PMPM_PIP;

  Result := PingHost(LIpAddr);

  if Result = -1 then
  begin
    Log('Host not connected : <' + LIpAddr + '>');
    exit;
  end;

  LUrl := GetLResUrlFromIpRec(LIpAddr);

  LCon := HttpGet(LUrl, nil, False, nil, 5000);

  if LCon = '' then
  begin
    LIpAddr := ARec.PMPM_SIP;
    LUrl := GetLResUrlFromIpRec(LIpAddr);
    LCon := HttpGet(LUrl);

    if LCon <> '' then
    begin
      ConsoleMemo.Lines.Clear;
      ConsoleMemo.Lines.Text := LCon;
      SetLResList2GridByTagText(LIpAddr, ConsoleMemo.Lines.Text);
    end;
  end
  else
  begin
    ConsoleMemo.Lines.Clear;
    ConsoleMemo.Lines.Text := LCon;
    SetLResList2GridByTagText(LIpAddr, ConsoleMemo.Lines.Text);
  end;
end;

function THiconisTCPF.GetLResUrlFromIpRec(AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + '/lres';
end;

procedure THiconisTCPF.GetLVerFromIpSelected;
var
  i: integer;
  LIp, LResName: string;
  LIpListRec: TIpListRec;
begin
  for i := 0 to IPAddrGrid.RowCount - 1 do
  begin
    if IPAddrGrid.Row[i].Selected then
    begin
      LResName := IPAddrGrid.CellsByName['RES_NAME', i];
      LIp := IPAddrGrid.CellsByName['PMPM_PIP', i];
      LIpListRec := GetIpListRecByResName(LResName);

      if GetLVerFromMPM(LIpListRec) = -1 then
        ShowMessage('Host not connected : <' + LIpListRec.PMPM_PIP + '>');
    end;
  end;
end;

function THiconisTCPF.GetLVerFromMPM(ARec: TIpListRec): integer;
var
  LCon: RawByteString;
  LUrl, LIpAddr: string;
begin
  if ARec.PMPM_PIP = '127.0.0.1' then
    exit;

  LIpAddr := ARec.PMPM_PIP;

  Result := PingHost(LIpAddr);

  if Result = -1 then
  begin
    Log('Host not connected : <' + LIpAddr + '>');
    exit;
  end;

  LUrl := GetLVerUrlFromIpRec(LIpAddr);

  LCon := HttpGet(LUrl, nil, False, nil, 5000);

  if LCon = '' then
  begin
    LIpAddr := ARec.PMPM_SIP;
    LUrl := GetLVerUrlFromIpRec(LIpAddr);
    LCon := HttpGet(LUrl);

    if LCon <> '' then
    begin
      ConsoleMemo.Lines.Clear;
      ConsoleMemo.Lines.Text := LCon;
      SetLVerList2GridByTagText(LIpAddr, ConsoleMemo.Lines.Text);
    end;
  end
  else
  begin
    ConsoleMemo.Lines.Clear;
    ConsoleMemo.Lines.Text := LCon;
    SetLVerList2GridByTagText(LIpAddr, ConsoleMemo.Lines.Text);
  end;
end;

procedure THiconisTCPF.GetLVerListFromTagText(ATagText: string; out ADesc,
  ALogicVer: string);
var
  LStr, LLogic, LHirs: string;
  LRow, i: integer;
begin
  ATagText := StringReplace(ATagText, #13#10, '', [rfReplaceAll]);
  LStr := ExtractTextInsideGivenTagEx('pre', ATagText);
  LHirs := ExtractTextInsideGivenTagNth('table', LStr, 1);
  LLogic := ExtractTextInsideGivenTagNth('table', LStr, 5);

//  LStr := ExtractTextInsideGivenTagEx('pre', LHirs);
  LStr := ExtractTextBetweenDelim(LHirs, 'Ver', 'Copyright');
  LStr := StringReplace(LStr, #13#10, '', [rfReplaceAll]);
  LStr := Trim(LStr);
  FHiConSWVersionRec.FHirs := LStr;

  ADesc := ExtractTextInsideGivenTagNth('td', LLogic, 1);
  ALogicVer := ExtractTextInsideGivenTagNth('td', LLogic, 2);

  FHiConSWVersionRec.FLogic := ALogicVer;
end;

function THiconisTCPF.GetLVerUrlFromIpRec(AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + '/lver';
end;

procedure THiconisTCPF.GetModuleNamebyTagName1Click(Sender: TObject);
begin
  CreateSrchModuleByTagForm();
end;

function THiconisTCPF.GetModuleTypeFromDBByTagName(ATagName: string): string;
var
  LChannelInfoJson: string;
  LDocDict: IDocDict;
begin
  Result := '';
  LChannelInfoJson := THiConSystemDB.GetChInfo2JsonFromChannelTable(ATagName);

  if LChannelInfoJson <> '' then
  begin
    LDocDict := DocDict(LChannelInfoJson);

    if LDocDict.Exists('FUNC_NAME') then
      Result := LDocDict.S['FUNC_NAME'];
  end;
end;

function THiconisTCPF.GetMPMNameFromIpAddrDic(AIpAddr: string): string;
var
  i: Integer;
  LIpListRec: TIpListRec;
begin
  Result := '';

  for i := 0 to FIpAddrDic.Count - 1 do
  begin
    LIpListRec := FIpAddrDic.Value[i];

    if LIpListRec.PMPM_PIP = AIpAddr then
    begin
      Result := LIpListRec.RES_NAME;
    end;
  end;
end;

procedure THiconisTCPF.GetNetTimeServiceStatus2Grid;
var
  LJson: string;
  LVar: variant;
  LDocList: IDocList;
  LStatus: integer;
begin
  LDocList := DocList('[]');
  LJson := GetServiceInfo2JsonByName('W32Time');
  LVar := _JSON(LJson);
  LStatus := TDocVariantData(LVar).Value['Status'];
  LJson := g_ServiceState.ToString(LStatus);
  ShowMessage(LJson);
  LDocList.Append(LVar);
  LVar := LDocList.Json;
  AddNextGridRowsFromVariant2(NextGrid1, LVar, True);
//  AddNextGridRowFromVariant(NextGrid1, LVar, True);
end;

function THiconisTCPF.GetPortJsonContentsFromSrcByInfTag(
  AInfTagName: string; ASrcKind: TTagSearchRec): string;
var
  LStr, LBaseDir: string;
begin
  LStr := GetCOMTgzNPortNameFromTgzByInfTag(AInfTagName);
  Result := GetPortValueJsonFromCOMNPortJson(LStr);
end;

procedure THiconisTCPF.GetPortPrint1Click(Sender: TObject);
var
  LIpAddrList: string;
begin
  //';'로 구분됨
  LIpAddrList := GetSelectedIpAddrList();

  GetPortPrintDebug(LIpAddrList, '0');
end;

function THiconisTCPF.GetPortPrintDebug(AIpAddr, APortName: string): string;
var
  LIOHandler: TIdIOHandler;
begin
  FTCPResponse.Clear;

  if IdTCPClient1.Connected then
    IdTCPClient1.Disconnect;

  IdTCPClient1.Host := AIpAddr;
  IdTCPClient1.Port := 23;

  IdTCPClient1.Connect;
  LIOHandler := IdTCPClient1.IOHandler;

  LIOHandler.WaitFor('login:');
  LIOHandler.WriteLn('root');
  LIOHandler.WaitFor('$');
  LIOHandler.WriteLn('pp ' + APortName); //01
  LIOHandler.WaitFor('Select>>');
  LIOHandler.WriteLn('0');
  LIOHandler.WaitFor('Choice: 0');
//  LIOHandler.WaitFor('------------------------Debug Mode----------------------');

  repeat
    FTCPResponse.Add(LIOHandler.ReadLn(LF, 100));
  until LIOHandler.ReadLnTimedout;

  ConsoleMemo.Lines.Assign(FTCPResponse);
  Result := FTCPResponse.Text;
end;

procedure THiconisTCPF.GetPreTagTextFromHtml;
var
  LStr: string;
  LStrList: TStringList;
begin
//  LStr := ConsoleMemo.Lines.Text;//'<pre>0xa001ffc0 : AI04101_16'#$A'0xa001ffd8 : AI04101_02</pre>';
//  ConsoleMemo.Lines.Text := ExtractTextInsideGivenTagEx('pre', LStr);
//  LStrList := ExtractTextBetweenTags(LStr);
//  ConsoleMemo.Lines.Text := LStrList.Text;
//  LStrList.Free;
//  ConsoleMemo.Lines.Text := TRegEx.Match(LStr, '(?si)<pre>.*?</pre>').Value;
end;

function THiconisTCPF.GetPtcJsonContentsFromSrcByInfTag(
  AInfTagName: string; ASrcKind: TTagSearchRec): string;
var
  LStr, LBaseDir: string;
begin
  LStr := GetTgzNPtcJsonNameFromTgzByInfTag(AInfTagName);//GetCOMTgzNPortNameFromTgzByInfTag(AInfTagName);

  if LStr <> '' then
    Result := GetPtcJsonContentsFromTgzByCOMNPortJson(LStr);
end;

function THiconisTCPF.GetQueryJsonFromSrcByInfTag(ARec: TTagSearchRec): string;
var
  LResNPortJson, LTagInfoJson, LPtcJson, LPortIntfJson: string;
  LBaseDir: string;
  LDataSrc: TTagDataSrcRec;
begin
  //UnitGZipJclUtil 유닛을 사용하기 위해서 SevenzipLibraryDir에 7z.dll 경로를 지정함
  SevenzipLibraryDir := ExtractFilePath(Application.ExeName) + 'lib\';
  LBaseDir := DOWNLOAD_FULL_PATH;

  LTagInfoJson := THiConSystemDB.GetTagInfo2JsonFromINFTable(ARec.FTagName);

//  LStr := GetCOMTgzNPortNameByMPMNameWithSlotNo(LTagInfoJson, LBaseDir);
  //{"Resource":"COM011110"/"MPM11"/"FBM11", "Port":"ptc04", "PortValueInf":{...},"PtcValue":{...}, "BaseDir": "full path"}
//  LResNPortJson := GetReourceNPortName2JsonByTagInfo(LTagInfoJson, LBaseDir, AIsOnlne);
  LDataSrc := GetTagDataSrcRecByTagInfo(LTagInfoJson, ARec);

  //LStr: {"COM":"COM011110.tgz", "Port":"ptc04.json", "PortValueInf":{...},"BaseDir": "full path"}
//  LStr := GetCOMTgzNPortNameFromTgzByInfTag(AInfTagName);
  //PortValueInf Value 반환
//  LPortIntfJson := GetPortValueJsonFromCOMNPortJson(LStr);
//  LPtcJson := GetPtcJsonContentsFromTgzByCOMNPortJson(LStr);
//  Result := GetQueryJsonFromPortNPtcJson(LTagInfoJson, LPortIntfJson, LPtcJson);
//  Result := GetQueryJsonFromResourceNPortNameByTagInfo(LTagInfoJson, LResNPortJson);
end;

function THiconisTCPF.GetResNPtcJsonNameFromSrcByInfTag(ARec: TTagSearchRec): string;
var
  LStr, LPortName, LResName, LIPAddr, LDBName: string;
  LDict: IDocDict;
begin
//  LBaseDir := DOWNLOAD_FULL_PATH;

  Result := '';

  if ARec.FTagName = '' then
    exit;

  case ARec.FSrcKind of
    0,1: begin
      if ARec.FBaseDir = '' then
      begin
        ShowMessage('Base Dir should be "Z:\HiCONIS\HullNo_ICMS"');
        exit;
      end
      else
        LDBName := ARec.FBaseDir + 'D_Drive\ACONIS-NX\DB\system_bak.accdb';
    end;
    2: LDBName := 'D:\ACONIS-NX\DB\system_bak.accdb';
  end;

  LStr := THiConSystemDB.GetTagInfo2JsonFromINFTable(ARec.FTagName, LDBName);
  LPortName := GetResNPortNameByInfTagInfo(LStr, ARec);//GetResNPortName2JsonByInfTagInfo(LStr, ARec);
  LResName := StrToken(LPortName, ';');
  LIPAddr := GetIpAddrByResNameFromBackup(LResName, ARec.FBaseDir);

  LDict := DocDict(LStr);
  LDict.S['FTYPE'] := LDict.S['TYPE'];

  LDict.S['Resource'] := LResName;
  LDict.S['Port'] := LPortName;
  LDict.S['IPAddr1'] := StrToken(LIPAddr, ';');
  LDict.S['IPAddr2'] := LIPAddr;

  //{"TAG_NAME":"INF_SCR_ENG10_701","DESCRIPTION":"M/E LOW SULFUR FUEL SUPPLIED",
  //"RESOURCE":"COM01402","SLOT":83,"DIR":1,"TYPE":1,"ADDR":1003,"SUB_POS":0,
  //"FTYPE":"1","Port":"Port4","IPAddr1":"10.8.1.213","IPAddr2":"11.8.1.213"}
  Result := LDict.Json;

  CreateNShowDateSeletForm(Result);
end;

procedure THiconisTCPF.GetRetentionPoliciesBySelectedIpList(
  AIpAddrList: string);
var
  LIpAddr: string;
  LResult: string;
  LVar: variant;
  LIsFirstRun: Boolean;
begin
  LIsFirstRun := False;

  while AIpAddrList <> '' do
  begin
    LIpAddr := StrToken(AIpAddrList, ';');
    LResult := GetRetentionPolicies2JsonFromInfluxDB(LIpAddr);

    if LResult <> '' then
    begin
      LVar := _JSON(LResult);

      if not LIsFirstRun then
      begin
        AddNextGridColumnFromVariant(NextGrid1, LVar, False, True, True);
        LIsFirstRun := True;
      end;

      AddNextGridRowFromVariant(NextGrid1, LVar, True);
      Log(LResult);
    end;
  end;
end;

function THiconisTCPF.GetSelectedIpAddrList(AIsMaster: Boolean): string;
var
  i: integer;
  LList: string;
begin
  Result := '';
  LList := '';

  for i := 0 to IPAddrGrid.RowCount - 1 do
  begin
    if IPAddrGrid.Row[i].Selected then
    begin
      if AIsMaster then
        LList := LList + IPAddrGrid.CellsByName['PMPM_PIP', i] + ';'
      else
        LList := LList + IPAddrGrid.CellsByName['PMPM_SIP', i] + ';';
    end;
  end;

  Result := LList;
end;

procedure THiconisTCPF.GetTagFromSVG1Click(Sender: TObject);
var
  LStr: string;
begin
  if OpenDialog1.Execute then
  begin
    LStr := ExtractSpecificXmlTag(OpenDialog1.FileName, 'drwtaginfo');
    ShowMessage(LStr);
  end;
end;

procedure THiconisTCPF.GetTagInfoFromSystemBak1Click(Sender: TObject);
var
  LStr, LBaseDir, LMPMName, LSlotNo: string;
  LRec: TTagSearchRec;
begin
  //UnitGZipJclUtil 유닛을 사용하기 위해서 SevenzipLibraryDir에 7z.dll 경로를 지정함
//  SevenzipLibraryDir := ExtractFilePath(Application.ExeName) + 'lib\';
//  LBaseDir := 'E:\pjh\Doc\HiCONIS\project\HMD8310\ACONIS-NX\DB\DOWNLOAD\';
//
//  LStr := THiConSystemDB.GetTagInfo2JsonFromINFTable('INF_VT_AC_3358');
//  LStr := GetCOMTgzNPortNameByMPMNameWithSlotNo(LStr, LBaseDir);
//  //MPM11 가져옴
//  LMPMName := GetValueFromJsonDictByKeyName(LStr, 'RESOURCE');
//  LSlotNo := GetValueFromJsonDictByKeyName(LStr, 'SLOT');
//  LStr := LBaseDir + LStr + '.tgz';
  //MPM11.tgz 파일에서 "interface.json" 파일을 c:\temp\home\db에 Extract
//  LStr := ExtractFromTgz2DirByPackedName(LStr, '', 'home\db\interface.json');
//  LStr := GetPtcFileNameListFromMPMIntfJson(LStr);
//  LStr := GetPortListFromMPMIntfJson(LStr);

//  LStr := GetCOMTgzNPortNameByMPMNameWithSlotNo(LMPMName, LSlotNo, LBaseDir);
//  LStr := GetPtcJsonContentsFromTgzByCOMNPortJson(LStr);

//  LStr := GetPtcJsonContentsFromSrcByInfTag('INF_VT_AC_3358');
  LRec.FSrcKind := 1;
  LRec.FTagName := 'INF_VT_AC_3358';

  LStr := GetQueryJsonFromSrcByInfTag(LRec);

  ShowMessage(LStr);
end;

function THiconisTCPF.GetTgzNPtcJsonNameFromTgzByInfTag(
  AInfTagName: string): string;
var
  LStr, LBaseDir: string;
begin
  //UnitGZipJclUtil 유닛을 사용하기 위해서 SevenzipLibraryDir에 7z.dll 경로를 지정함
  SevenzipLibraryDir := ExtractFilePath(Application.ExeName) + 'lib\';
  LBaseDir := DOWNLOAD_FULL_PATH;

  LStr := THiConSystemDB.GetTagInfo2JsonFromINFTable(AInfTagName);
  Result := GetTgzNPtcJsonNameByTagInfo(LStr, LBaseDir);
end;

function THiconisTCPF.GetVersionMPMUrlFromIpRec(AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + '/version';
end;

procedure THiconisTCPF.GetVersionIntfFromIpSelected;
var
  i: integer;
  LIp, LResName: string;
  LIpListRec: TIpListRec;
begin
  for i := 0 to IPAddrGrid.RowCount - 1 do
  begin
    if IPAddrGrid.Row[i].Selected then
    begin
      LResName := IPAddrGrid.CellsByName['RES_NAME', i];
      LIp := IPAddrGrid.CellsByName['PMPM_PIP', i];
      LIpListRec := GetIpListRecByResName(LResName);

      if GetVersionIntfFromMPM(LIpListRec) = -1 then
        ShowMessage('Host not connected : <' + LIpListRec.PMPM_PIP + '>');
    end;
  end;
end;

function THiconisTCPF.GetVersionIntfFromMPM(ARec: TIpListRec): integer;
var
  LCon: RawByteString;
  LUrl, LIpAddr: string;
begin
  if ARec.PMPM_PIP = '127.0.0.1' then
    exit;

  LIpAddr := ARec.PMPM_PIP;

  Result := PingHost(LIpAddr);

  if Result = -1 then
  begin
    Log('Host not connected : <' + LIpAddr + '>');
    exit;
  end;

  LUrl := GetVersionIntfUrlFromIpRec(LIpAddr);

  LCon := HttpGet(LUrl, nil, False, nil, 5000);

  if LCon = '' then
  begin
    LIpAddr := ARec.PMPM_SIP;
    LUrl := GetVersionIntfUrlFromIpRec(LIpAddr);
    LCon := HttpGet(LUrl);

    if LCon <> '' then
    begin
      ConsoleMemo.Lines.Clear;
      ConsoleMemo.Lines.Text := LCon;
      SetVersionIntfList2GridByTagText(LIpAddr, ConsoleMemo.Lines.Text);
    end;
  end
  else
  begin
    ConsoleMemo.Lines.Clear;
    ConsoleMemo.Lines.Text := LCon;
    SetVersionIntfList2GridByTagText(LIpAddr, ConsoleMemo.Lines.Text);
  end;
end;

procedure THiconisTCPF.GetVersionIntfFromTagText(ATagText: string);
var
  LStr, LName, LVer: string;
  LRow: integer;
begin
  LStr := ExtractTextInsideGivenTagEx('table', ATagText);
  LName := ExtractTextInsideGivenTagNth('td', LStr, 1);
  LVer := ExtractTextInsideGivenTagNth('td', LStr, 2);

  LName := ExtractTextInsideGivenTagNth('td', LStr, 3);
  LVer := ExtractTextInsideGivenTagNth('td', LStr, 4);

  if LName = 'hiscm_im' then
    FHiConSWVersionRec.FHiscm_Im := LVer;

  LName := ExtractTextInsideGivenTagNth('td', LStr, 5);
  LVer := ExtractTextInsideGivenTagNth('td', LStr, 6);

  if LName = 'interface-a' then
    FHiConSWVersionRec.FInterface_a := LVer;
end;

function THiconisTCPF.GetVersionIntfUrlFromIpRec(AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + ':8000/version';
end;

procedure THiconisTCPF.GetVersionMPMFromIpSelected;
var
  i: integer;
  LIp, LResName: string;
  LIpListRec: TIpListRec;
begin
  for i := 0 to IPAddrGrid.RowCount - 1 do
  begin
    if IPAddrGrid.Row[i].Selected then
    begin
      LResName := IPAddrGrid.CellsByName['RES_NAME', i];
      LIp := IPAddrGrid.CellsByName['PMPM_PIP', i];
      LIpListRec := GetIpListRecByResName(LResName);

      if GetVersionMPMFromMPM(LIpListRec) = -1 then
        ShowMessage('Host not connected : <' + LIpListRec.PMPM_PIP + '>');
    end;
  end;
end;

function THiconisTCPF.GetVersionMPMFromMPM(ARec: TIpListRec): integer;
var
  LCon: RawByteString;
  LUrl, LIpAddr: string;
begin
  if ARec.PMPM_PIP = '127.0.0.1' then
    exit;

  LIpAddr := ARec.PMPM_PIP;

  Result := PingHost(LIpAddr);

  if Result = -1 then
  begin
    Log('Host not connected : <' + LIpAddr + '>');
    exit;
  end;

  LUrl := GetVersionMPMUrlFromIpRec(LIpAddr);

  LCon := HttpGet(LUrl, nil, False, nil, 5000);

  if LCon = '' then
  begin
    LIpAddr := ARec.PMPM_SIP;
    LUrl := GetVersionMPMUrlFromIpRec(LIpAddr);
    LCon := HttpGet(LUrl);

    if LCon <> '' then
    begin
      ConsoleMemo.Lines.Clear;
      ConsoleMemo.Lines.Text := LCon;
      SetVersionMPMList2GridByTagText(LIpAddr, ConsoleMemo.Lines.Text);
    end;
  end
  else
  begin
    ConsoleMemo.Lines.Clear;
    ConsoleMemo.Lines.Text := LCon;
    SetVersionMPMList2GridByTagText(LIpAddr, ConsoleMemo.Lines.Text);
  end;
end;

function THiconisTCPF.GetChannelStrUrlFromIpRec(AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + '/channelstr';
end;

procedure THiconisTCPF.gzTest1Click(Sender: TObject);
var
  LStr: string;
begin
  if OpenDialog1.Execute then
  begin
//    LStr := CompareProfibusJsonFromTgz(OpenDialog1.FileName, 'E:\temp\system_bak.accdb');
    LStr := CompareProfibusJsonFromTgzByAbbr(OpenDialog1.FileName, 'E:\temp\system_bak.accdb');
    ShowMessage(LStr);
  end;
end;

procedure THiconisTCPF.HtmlParseFunc;
var
//  HtmlParser: THtmlParser;
//  HtmlDoc: TDocument;
//  Formatter: TBaseFormatter;
  LStr: string;
begin
//  HtmlParser := THtmlParser.Create;
  try
    LStr := ConsoleMemo.Lines.Text;
//    HtmlDoc := THtmlParser.parse(LStr)

  finally
//    HtmlParser.Free
  end;

end;

procedure THiconisTCPF.InitEnum;
begin
  g_ServiceState.InitArrayRecord(R_ServiceState_Eng);
end;

procedure THiconisTCPF.InitVar;
begin
  FHiconTCPIniFileName := ChangeFileExt(ExtractFileName(Application.ExeName), '.ini');
  FHiconTCPIniConfig := THiconTCPIniConfig.Create(FHiconTCPIniFileName);

  FIpAddrDic := Collections.NewKeyValue<string, TIpListRec>;
//  FIpAddrDic := Collections.NewList<TIpListRec>;
//  FAddrIdListDic := Collections.NewKeyValue<string, TIDListRec>;
  FIDListDic := Collections.NewKeyValue<string, TStringList>;
//  FDupIdList := Collections.NewList<TDupIDListRec>;
  FIpNIdList := Collections.NewKeyValue<string, TIDDic>;
  FIpNDupIdList := Collections.NewKeyValue<string, TIDList>;
  FMPMListDic := Collections.NewKeyValue<string, string>;

  FTCPResponse := TStringList.Create;
  FHiConMariaDB := THiConMariaDB.Create;

  GetIpList4ThisComputer();

  FMyIpAddr := GetHiconisIp4ThisComputer();
  Caption := Caption + '(' + FMyIpAddr + ')';

  EnsureDirectoryExists('c:\temp');

  InitEnum();
end;

procedure THiconisTCPF.lmpm1Click(Sender: TObject);
begin
  GetLMPMFromIpSelected();
end;

//procedure THiconisTCPF.IPAddrGridSelectCell(Sender: TObject; ACol,
//  ARow: Integer);
//var
//  LIpAddr: string;
//begin
//  LIpAddr := IPAddrGrid.CellsByName['PMPM_PIP', ARow];
//  SetIdList2Grid(LIpAddr);
//end;

procedure THiconisTCPF.LoadConfig2Form(AForm: THiConTCPConfigF);
begin
  FHiConTCPIniConfig.LoadConfig2Form(AForm, FHiConTCPIniConfig);
end;

procedure THiconisTCPF.LoadConfigForm2Object(AForm: THiConTCPConfigF);
begin
  FHiConTCPIniConfig.LoadConfigForm2Object(AForm, FHiConTCPIniConfig);
end;

procedure THiconisTCPF.LoadConfigFromFile(AFileName: string);
begin
  if AFileName = '' then
    AFileName := FHiconTCPIniFileName;

  FHiConTCPIniConfig.Load(AFileName);
end;

procedure THiconisTCPF.LoadDupIdCheckResultFile1Click(Sender: TObject);
var
  LIp: string;
begin
  if IPAddrGrid.SelectedRow = -1 then
    exit;

    LIp := IPAddrGrid.CellsByName['PMPM_PIP', IPAddrGrid.SelectedRow];
//    LIp := IPAddrGrid.CellsByName['RES_NAME', IPAddrGrid.SelectedRow];
    LoadDupIdCheckResultFromFile(LIp);
end;

procedure THiconisTCPF.LoadDupIdCheckResultFromFile(AIpAddr: string);
var
  LResultRec: TResultCheckDupIDRec;
  LUtf8: RawUtf8;
  LFileName: string;
begin
  LFileName := GetFileNameFromIpAddr(AIpAddr);

  if not FileExists(LFileName) then
  begin
    ShowMessage('File Not Found => ' + LFileName);
  end;

  LUtf8 := StringFromFile(LFileName);
  LUtf8 := MakeDecryptNBase64String(LUtf8);

  LUtf8 := JSONReformat(LUtf8, jsonHumanReadable);
  ShowMessage(Utf8ToString(LUtf8));
end;

procedure THiconisTCPF.LoadIpListFromFile(AFileName: string);
var
  LRawStr: RawByteString;
  LJson: string;
begin
  LRawStr := StringFromFile(AFileName);

  FIpAddrDic.Data.LoadFromJson(LRawStr);

  LJson := Utf8ToString(GetIPListJsonFromIpList(FIpAddrDic));
  SetIpListFromJson2Grid(LJson, IPAddrGrid);
end;

procedure THiconisTCPF.LoadIPListFromFile1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    LoadIPListFromFile(OpenDialog1.FileName);
  end;
end;

procedure THiconisTCPF.Log(const AMsg: string);
begin
  ConsoleMemo.Lines.Add(AMsg);
end;

procedure THiconisTCPF.lres1Click(Sender: TObject);
begin
  GetLResFromIpSelected();
end;

procedure THiconisTCPF.lver1Click(Sender: TObject);
begin
  GetLVerFromIpSelected();
end;

procedure THiconisTCPF.MariaDBConnect1Click(Sender: TObject);
begin
  FHiConMariaDB.CreateDB('10.8.2.11', '3306', 'test', 'root', 'aconis');
  FHiConMariaDB.ConnectDB
end;

procedure THiconisTCPF.MariaDBInbstalled1Click(Sender: TObject);
var
  LResult: string;
begin
  if THiConOWS.CheckMariaDBInstalledFromService() then
    LResult := 'MariaDB Installed!'
  else
    LResult := 'MariaDB Not Installed!';

  ShowMessage(LResult);
end;

procedure THiconisTCPF.ModifyLogParam2Click(Sender: TObject);
var
  LResult, LLogDriveOld, LogDriveNew: string;
  LThisComIsHistoryStation: Boolean;
begin
  LogDriveNew := GetLogDrive(LThisComIsHistoryStation);

  if LThisComIsHistoryStation then
  begin
    LLogDriveOld := 'C:;D:';
    LogDriveNew := 'E:';
  end
  else
  begin
    LLogDriveOld := 'C:;E:';
    LogDriveNew := 'D:';
  end;

  LResult := ModifyLogParamFromConf(LLogDriveOld, LogDriveNew);//DEFAULT_INFLUXDB_CONF_NAME
  ShowMessage(LResult);
end;

procedure THiconisTCPF.MPMBackup1Click(Sender: TObject);
var
  LIpAddr: string;
begin
  //';'로 구분됨
  LIpAddr := GetSelectedIpAddrList();
  DownloadBackupMPMForEach(LIpAddr);
//  BackupMPM(LIpAddr);
end;

procedure THiconisTCPF.NetTimeServiceStatus1Click(Sender: TObject);
begin
  GetNetTimeServiceStatus2Grid();
end;

procedure THiconisTCPF.NextGrid1CellDblClick(Sender: TObject; ACol,
  ARow: Integer);
var
  LIpAddr, LKey: string;
begin
  if ARow = -1 then
    exit;

  LIpAddr := NextGrid1.CellsByName['IPAddr', ARow];
  LKey := NextGrid1.CellsByName['IOCard', ARow];

  SetLMPMFromMPMList2GridByKey(LIpAddr, LKey);
end;

procedure THiconisTCPF.PngBitBtn1Click(Sender: TObject);
begin
  NextGridToExcel(NextGrid1);
end;

procedure THiconisTCPF.PngBitBtn2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    NextGridToCsv(OpenDialog1.FileName, NextGrid1);
  end;
end;

procedure THiconisTCPF.SaveDupIdCheckResult2File(AIpAddr: string);
var
  LIDList: TIDList;
  LResultRec: TResultCheckDupIDRec;
  LUtf8: RawUtf8;
  LFileName: string;
begin
  LResultRec := Default(TResultCheckDupIDRec);
  LResultRec.ResourceInfoRec.PMPM_PIP := AIpAddr;

  if FIpNDupIdList.TryGetValue(AIpAddr, LIDList) then
    LResultRec.DupIdCount := IntToStr(LIDList.Count);
  LResultRec.CheckDate := FormatDateTime('yyyy-mm-dd hh:nn:ss', now);

  LUtf8 := RecordSaveJson(LResultRec, TypeInfo(TResultCheckDupIDRec));
  LUtf8 := MakeBase64NEncrypString(LUtf8);
  LFileName := GetFileNameFromIpAddr(AIpAddr);

  if FileFromString(LUtf8, LFileName) then
  begin
//    ShowMessage('File is saved successfully => ' + LFileName);
    ShowMessage('Duplicated ID 검사가 완료 되었습니다.' + #13#10 + 'Duplicated ID 건수 : [' + LResultRec.DupIdCount + ']');
  end;
end;

procedure THiconisTCPF.SaveIpListToFile(AFileName: string);
var
  LJson: string;
begin
  LJson := Utf8ToString(FIpAddrDic.Data.SaveToJson());
  FileFromString(LJson, AFileName);
end;

procedure THiconisTCPF.SaveIPListToFile1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    SaveIpListToFile(SaveDialog1.FileName);
  end;
end;

procedure THiconisTCPF.SearchINTTag1Click(Sender: TObject);
var
  LStr: string;
  LTagSearchRec: TTagSearchRec;
begin
  if IPAddrGrid.SelectedRow = -1 then
    LStr := ''
  else
    LStr := IPAddrGrid.CellsByName['PMPM_PIP', IPAddrGrid.SelectedRow];

  LTagSearchRec := GetTagSearchRecFromTagInfoEditForm(LStr);

  LStr := GetResNPtcJsonNameFromSrcByInfTag(LTagSearchRec);
end;

procedure THiconisTCPF.SetConfig;
var
  LConfigF: THiConTCPConfigF;
begin
  LConfigF := THiConTCPConfigF.Create(Self);

  try
    LoadConfig2Form(LConfigF);

    if LConfigF.ShowModal = mrOK then
    begin
      LoadConfigForm2Object(LConfigF);
      FHiConTCPIniConfig.Save();
      ApplyConfigChanged;
    end;
  finally
    LConfigF.Free;
  end;
end;

procedure THiconisTCPF.SetConfig1Click(Sender: TObject);
begin
  SetConfig;
end;

procedure THiconisTCPF.SetConnectStatus2IpAddrGridBySelected(AIdx: integer;
  AIsResetStatus: Boolean);
var
  LIp: string;
  LIsAll: Boolean;
  i: integer;
begin
  LIsAll := AIdx = -1;

  if LIsAll then
  begin
    for i := 0 to IPAddrGrid.RowCount - 1 do
    begin
      LIp := IPAddrGrid.CellsByName['PMPM_PIP', i];
      SetGridByConnectStatusByIp(i, LIp);
    end;
  end
  else
  begin
    LIp := IPAddrGrid.CellsByName['PMPM_PIP', AIdx];
    SetGridByConnectStatusByIp(AIdx, LIp);
  end;
end;

procedure THiconisTCPF.SetFBVerList2GridByTagText(AIpAddr, ATagText: string);
var
  LStr, LIdx, LFN, LFBName, LVer: string;
  LRow, i: integer;
  LList, LList2: IDocList;
  Lvar, LVar2: variant;
  LUtf8: RawUtf8;
begin
  ATagText := StringReplace(ATagText, #13#10, '', [rfReplaceAll]);
  LStr := ExtractTextInsideGivenTagEx('table', ATagText);
  LStr := ExtractTextInsideGivenTagEx('script', LStr);
  ATagText := StrToken(LStr, '=');
  LStr := StrToken(LStr, ';');

  LList := DocList(LStr);

  NextGrid1.BeginUpdate;
  try
    SetNextGridColumn4FBVer();

    for Lvar in LList do
    begin
      LUtf8 := LVar;
      LList2 := DocList(LUtf8);

      LVar2 := LList2.Pop(0);

      if LVar2 = 'index' then
        Continue;

      if VarIsNull(LVar2) then
        Break;

      LRow := NextGrid1.AddRow();
      NextGrid1.CellsByName['IPAddr', LRow] := AIpAddr;
      NextGrid1.CellsByName['index', LRow] := LVar2;
      NextGrid1.CellsByName['file', LRow] := LList2.Pop(0);
      NextGrid1.CellsByName['version', LRow] := LList2.Pop(0);
      NextGrid1.CellsByName['FName', LRow] := LList2.Pop(0);
    end;
  finally
    NextGrid1.EndUpdate();
  end;
end;

procedure THiconisTCPF.SetIdList2Grid(AIpAddr: string);
begin
  if TaskTab.ActiveTabIndex = 0 then//전체
    SetIdList2GridFromIpNIdList(AIpAddr)
  else
    SetIdList2GridFromIpNDupIdList(AIpAddr);
end;

procedure THiconisTCPF.SetIdList2GridByTagText(AIpAddr: string; ATagText: string);
var
  LStrList: TStringList;
  LStr, LId, LAddr: string;
  LRec: TIDListRec;
  LRow: integer;
  LDupIDListRec: TDupIDListRec;
  LDupList: IList<TDupIDListRec>;
  LIdDic: TIDDic;
begin
  LStrList := TStringList.Create;
  LStrList.Text := ExtractTextInsideGivenTagEx('pre', ATagText);
  NextGrid1.BeginUpdate;
  try
    SetNextGridColumn4DupTagId();

    LDupList := Collections.NewList<TDupIDListRec>;
    LIdDic := Collections.NewKeyValue<string, TIDListRec>;

    for LStr in LStrList do
    begin
      LId := LStr;
      LAddr := StrToken(LId, ':');
      LRec.MMAddress := Trim(LAddr);
      LRec.TagId := Trim(StrToken(LId, ':'));

      if not LIdDic.TryAdd(LRec.MMAddress, LRec) then
      begin
        LDupIDListRec.IpRec.PMPM_PIP := AIpAddr;
        LDupIDListRec.DupIdRec := LRec;
        LDupList.Add(LDupIDListRec);
      end;
  //    FIDListDic.Add(AIpName, LStrList);

      LRow := NextGrid1.AddRow();
//      NextGrid1.CellsByName['RES_NAME', LRow] := AIpRec.RES_NAME;
//      NextGrid1.CellsByName['PMPM_PIP', LRow] := AIpRec.PMPM_PIP;
      NextGrid1.CellsByName['MMAddress', LRow] := LRec.MMAddress;
      NextGrid1.CellsByName['TagId', LRow] := LRec.TagId;
      NextGrid1.CellsByName['MPMName', LRow] := GetMPMNameFromIpAddrDic(AIpAddr);
    end;//for

    FIpNIdList.Add(AIpAddr, LIdDic);

    if LDupList.Count > 0 then
      FIpNDupIdList.Add(AIpAddr, LDupList);
  finally
    NextGrid1.EndUpdate();
    LStrList.Free;
  end;
end;

procedure THiconisTCPF.SetIdList2GridFromIpNDupIdList(AIpAddr: string);
var
  LIDList: TIDList;
  LDupRec: TDupIDListRec;
  i, LRow: integer;
  LIpAddr: string;
begin
  NextGrid1.BeginUpdate;
  try
    NextGrid1.ClearRows;

    while AIpAddr <> '' do
    begin
      LIpAddr := StrToken(AIpAddr, ';');
      if FIpNDupIdList.TryGetValue(LIpAddr, LIDList) then
      begin
        for i := 0 to LIDList.Count - 1 do
        begin
          LDupRec := LIDList.Items[i];

          LRow := NextGrid1.AddRow();
          NextGrid1.CellsByName['MMAddress', LRow] := LDupRec.DupIdRec.MMAddress;
          NextGrid1.CellsByName['TagId', LRow] := LDupRec.DupIdRec.TagId;
          NextGrid1.CellsByName['MPMName', LRow] := GetMPMNameFromIpAddrDic(LIpAddr);
        end;
      end;
    end;//while
  finally
    NextGrid1.EndUpdate();
  end;
end;

procedure THiconisTCPF.SetIdList2GridFromIpNIdList(AIpAddr: string);
var
  LIDDic: TIDDic;
  LRec: TIDListRec;
  i, LRow: integer;
  LIpAddr: string;
begin
  NextGrid1.BeginUpdate;
  try
    NextGrid1.ClearRows;

    while AIpAddr <> '' do
    begin
      LIpAddr := StrToken(AIpAddr, ';');

      LIDDic := FIpNIdList.Items[LIpAddr];

      for i := 0 to LIDDic.Count - 1 do
      begin
        LRec := LIDDic.Value[i];

        LRow := NextGrid1.AddRow();
        NextGrid1.CellsByName['MMAddress', LRow] := LRec.MMAddress;
        NextGrid1.CellsByName['TagId', LRow] := LRec.TagId;
        NextGrid1.CellsByName['MPMName', LRow] := GetMPMNameFromIpAddrDic(LIpAddr);
      end;
    end;//while
  finally
    NextGrid1.EndUpdate();
  end;
end;

procedure THiconisTCPF.SetLMPMFromMPMList2GridByKey(const AIpAddr, AKey: string);
var
  LTable: string;
begin
  if FMPMListDic.TryGetValue(AKey, LTable) then
  begin
    LTable := StringReplace(LTable, ' ', '', [rfReplaceAll]);
    LTable := StringReplace(LTable, '[ms]', '_ms', [rfReplaceAll]);

    CreateNextGridForm('lmpm', AKey, LTable);
  end;
end;

procedure THiconisTCPF.SetLMPMList2Grid(const AIpAddr: string);
var
  i, LRow: integer;
begin
  NextGrid1.BeginUpdate;
  try
    NextGrid1.ClearRows();
    NextGrid1.Columns.Clear();

    SetNextGridColumn4LMPM();

    for i := FMPMListDic.Count - 1 downto 0 do
    begin
      LRow := NextGrid1.AddRow();
      NextGrid1.CellsByName['IOCard', LRow] := FMPMListDic.Key[i];
      NextGrid1.CellsByName['IPAddr', LRow] := AIpAddr;
    end;

  finally
    NextGrid1.EndUpdate();
  end;
end;

procedure THiconisTCPF.SetLMPMList2GridByTagText(AIpAddr, ATagText: string);
var
  LStr, LTotalCountStr, LTable, LIOCard, LDelim: string;//LScript,
  i, LTotalCount: integer;
begin
  ATagText := StringReplace(ATagText, #13#10, '', [rfReplaceAll]);
  LStr := ExtractTextInsideGivenTagEx('pre', ATagText);

  if Pos('Total RTU No =', LStr) > 0 then
  begin
    LTotalCountStr := StrToken(LStr, '=');
    LTotalCountStr := StrToken(LStr, '<');

    if not StrIsNumeric(LTotalCountStr) then
    begin
      ShowMessage('Please check "Total RTU No"');
      exit;
    end;
  end;

  LTotalCount := StrToIntDef(LTotalCountStr, 0);
  FMPMListDic.Clear;

  //"4. "을 검색하면 "14. "이 검색되는 문제 회피를 위해 downto로 수정함
  for i := LTotalCount downto 1 do
  begin
    LDelim := IntToStr(i) + '. ';
    //"1. AI (16) : 100 mSec" 가져옴
    LIOCard := ExtractTextBetweenDelim(LStr, LDelim, '<');

    if LIOCard = '' then
    begin
//        ShowMessage(LIOCard);
      Continue;
    end
    else
      LStr := ReplaceString(LStr, LDelim + LIOCard, '');

    LIOCard := LDelim + LIOCard;

    //LTotalCount 중에 없는 숫자가 존재하므로 일부 오류 발생하여 ExtractTextBetweenDelim()로 변경함
//    LTable := ExtractTextInsideGivenTagNth('table', LStr, i);
//    LScript := ExtractTextInsideGivenTagNth('script', LTable, 1);

    LDelim := 'ta' + IntToStr(i) + ' = ';
    LTable := ExtractTextBetweenDelim(LStr, LDelim, ';');
//    LTable := StrToken(LScript, '=');
//    LTable := StrToken(LScript, ';');

    FMPMListDic.Add(LIOCard, LTable);
//    if i = 1 then
//      SetLMPMFromMPMList2GridByKey(AIpAddr, LIOCard);
  end;//for

  SetLMPMList2Grid(AIpAddr);
end;

procedure THiconisTCPF.SetLResList2Grid(const AIpAddr: string);
begin

end;

procedure THiconisTCPF.SetLResList2GridByTagText(AIpAddr, ATagText: string);
var
  LStr, LData, LTotalCountStr,
  LIndex,	LPrimary,	LSecondary,	LMaster,	LTime: string;
  LRow,i, LCount: integer;
begin
  LStr := ExtractTextInsideGivenTagEx('pre', ATagText);

  if Pos('Total Resource No. =', LStr) > 0 then
  begin
    LTotalCountStr := StrToken(LStr, '=');
    LTotalCountStr := StrToken(LStr, '<');
  end;

  NextGrid1.BeginUpdate;
  try
    LCount := StrToIntDef(LTotalCountStr, 0);
    SetNextGridColumn4LRes();

    for i := 1 to LCount do
    begin
      LData := ExtractTextInsideGivenTagNth('tr', LStr, 3+i);
      LIndex := ExtractTextInsideGivenTagNth('td', LData, 1);
      LPrimary := ExtractTextInsideGivenTagNth('td', LData, 2);
      LSecondary := ExtractTextInsideGivenTagNth('td', LData, 3);
      LMaster := ExtractTextInsideGivenTagNth('td', LData, 4);
      LTime := ExtractTextInsideGivenTagNth('td', LData, 5);

      LRow := NextGrid1.AddRow();
      NextGrid1.CellsByName['IPAddr', LRow] := AIpAddr;
      NextGrid1.CellsByName['Index', LRow] := LIndex;
      NextGrid1.CellsByName['Primary', LRow] := LPrimary;
      NextGrid1.CellsByName['Secondary', LRow] := LSecondary;
      NextGrid1.CellsByName['Master', LRow] := LMaster;
      NextGrid1.CellsByName['Time', LRow] := LTime;
    end;
  finally
    NextGrid1.EndUpdate();
  end;
end;

procedure THiconisTCPF.SetLVerList2Grid(const AIpAddr, ADesc, AVer: string);
var
  LRow: integer;
begin
  NextGrid1.BeginUpdate;
  try
    SetNextGridColumn4LVer();

    LRow := NextGrid1.AddRow();
    NextGrid1.CellsByName['IPAddr', LRow] := AIpAddr;
    NextGrid1.CellsByName['Desc', LRow] := ADesc;
    NextGrid1.CellsByName['Info', LRow] := AVer;
  finally
    NextGrid1.EndUpdate();
  end;
end;

procedure THiconisTCPF.SetLVerList2GridByTagText(const AIpAddr, ATagText: string);
var
  LRow, i: integer;
  LDesc, LVer: string;
begin
  GetLVerListFromTagText(ATagText, LDesc, LVer);
  SetLVerList2Grid(AIpAddr, LDesc, LVer);
end;

procedure THiconisTCPF.SetNextGridColumn4DupTagId;
var
  LDoc: variant;
begin
  TDocVariant.New(LDoc);

  TDocVariantData(LDoc).Value['MMAddress'] := 'M/M Addr';
  TDocVariantData(LDoc).Value['TagId'] := 'Id';
  TDocVariantData(LDoc).Value['MPMName'] := 'Name';

  AddNextGridColumnFromVariant(NextGrid1, LDoc, False, True, True);
end;

procedure THiconisTCPF.SetNextGridColumn4FBVer;
var
  LDoc: variant;
begin
  TDocVariant.New(LDoc);

  TDocVariantData(LDoc).Value['IPAddr'] := 'IPAddr';
  TDocVariantData(LDoc).Value['index'] := 'index';
  TDocVariantData(LDoc).Value['file'] := 'file';
  TDocVariantData(LDoc).Value['version'] := 'wersion';
  TDocVariantData(LDoc).Value['FName'] := 'name';

  AddNextGridColumnFromVariant(NextGrid1, LDoc, False, True, True);
end;

procedure THiconisTCPF.SetNextGridColumn4LMPM();
var
  LDoc: variant;
  Lvar: variant;
  LList: IDocList;
  LStr: string;
begin
  TDocVariant.New(LDoc);
  TDocVariantData(LDoc).Value['IOCard'] := 'IO Card';
  TDocVariantData(LDoc).Value['IPAddr'] := 'IP Addr';

  AddNextGridColumnFromVariant(NextGrid1, LDoc, False, True, True);

  NextGrid1.Columns.Column['IOCard'].Alignment := taLeftJustify;
  NextGrid1.Columns.Column['IOCard'].Width := 200;
end;

procedure THiconisTCPF.SetNextGridColumn4LRes;
var
  LDoc: variant;
  Lvar: variant;
  LList: IDocList;
  LStr: string;
begin
  TDocVariant.New(LDoc);
  TDocVariantData(LDoc).Value['Index'] := 'Index';
  TDocVariantData(LDoc).Value['Primary'] := 'Primary';
  TDocVariantData(LDoc).Value['Secondary'] := 'Secondary';
  TDocVariantData(LDoc).Value['Master'] := 'Master';
  TDocVariantData(LDoc).Value['time'] := 'time';

  AddNextGridColumnFromVariant(NextGrid1, LDoc, False, True, True);
end;

procedure THiconisTCPF.SetNextGridColumn4LVer;
var
  LDoc: variant;
begin
  TDocVariant.New(LDoc);

  TDocVariantData(LDoc).Value['IPAddr'] := 'IPAddr';
  TDocVariantData(LDoc).Value['Desc'] := 'Desc';
  TDocVariantData(LDoc).Value['Info'] := 'Info';

  AddNextGridColumnFromVariant(NextGrid1, LDoc, False, True, True);
end;

procedure THiconisTCPF.SetNextGridColumn4VersionIntf;
var
  LDoc: variant;
begin
  TDocVariant.New(LDoc);

  TDocVariantData(LDoc).Value['IPAddr'] := 'IP Addr';
  TDocVariantData(LDoc).Value['Program'] := 'Version';
  TDocVariantData(LDoc).Value['Version'] := 'Version';

  AddNextGridColumnFromVariant(NextGrid1, LDoc, False, True, True);
end;

procedure THiconisTCPF.SetNextGridColumn4VersionMPM;
var
  LDoc: variant;
begin
  TDocVariant.New(LDoc);

  TDocVariantData(LDoc).Value['IPAddr'] := 'IP Addr';
  TDocVariantData(LDoc).Value['Program'] := 'Version';
  TDocVariantData(LDoc).Value['Version'] := 'Version';

  AddNextGridColumnFromVariant(NextGrid1, LDoc, False, True, True);
end;

procedure THiconisTCPF.SetVersionIntf2Grid(const AIpAddr: string);
var
  LRow: integer;
begin
  NextGrid1.BeginUpdate;
  try
    SetNextGridColumn4VersionIntf();

    LRow := NextGrid1.AddRow();
    NextGrid1.CellsByName['IPAddr', LRow] := AIpAddr;
    NextGrid1.CellsByName['Program', LRow] := 'hiscm_im';
    NextGrid1.CellsByName['Version', LRow] := FHiConSWVersionRec.FHiscm_Im;

    LRow := NextGrid1.AddRow();
    NextGrid1.CellsByName['IPAddr', LRow] := AIpAddr;
    NextGrid1.CellsByName['Program', LRow] := 'interface-a';
    NextGrid1.CellsByName['Version', LRow] := FHiConSWVersionRec.FInterface_a;
  finally
    NextGrid1.EndUpdate();
  end;
end;

procedure THiconisTCPF.SetVersionIntfList2GridByTagText(AIpAddr,
  ATagText: string);
begin
  GetVersionIntfFromTagText(ATagText);
  SetVersionIntf2Grid(AIpAddr);
end;

procedure THiconisTCPF.SetVersionMPMList2GridByTagText(AIpAddr, ATagText: string);
var
  LStr, LName, LVer: string;
  LRow: integer;
begin
  LStr := ExtractTextInsideGivenTagEx('table', ATagText);
  LName := ExtractTextInsideGivenTagNth('td', LStr, 1);
  LVer := ExtractTextInsideGivenTagNth('td', LStr, 2);

  NextGrid1.BeginUpdate;
  try
    SetNextGridColumn4VersionMPM();

    LName := ExtractTextInsideGivenTagNth('td', LStr, 3);
    LVer := ExtractTextInsideGivenTagNth('td', LStr, 4);

    LRow := NextGrid1.AddRow();
    NextGrid1.CellsByName['IPAddr', LRow] := AIpAddr;
    NextGrid1.CellsByName['Program', LRow] := LName;
    NextGrid1.CellsByName['Version', LRow] := LVer;

    LName := ExtractTextInsideGivenTagNth('td', LStr, 5);
    LVer := ExtractTextInsideGivenTagNth('td', LStr, 6);

    LRow := NextGrid1.AddRow();
    NextGrid1.CellsByName['IPAddr', LRow] := AIpAddr;
    NextGrid1.CellsByName['Program', LRow] := LName;
    NextGrid1.CellsByName['Version', LRow] := LVer;
  finally
    NextGrid1.EndUpdate();
  end;
end;

procedure THiconisTCPF.SetVisibleAllGridRow(AIsShow: Boolean);
var
  i: integer;
begin
  NextGrid1.BeginUpdate;
  try
    for i := 0 to NextGrid1.RowCount - 1 do
      NextGrid1.Row[i].Visible := AIsShow;
  finally
    NextGrid1.EndUpdate();
  end;
end;

procedure THiconisTCPF.ShowProgress1Click(Sender: TObject);
//var
//  ani : TAnimationThread;
//  r : TRect;
begin
//  r := panel1.clientrect;
//  InflateRect(r, - panel1.bevelwidth, - panel1.bevelwidth);
//  ani := TanimationThread.Create(panel1, r, panel1.color, clBlue, 25);
//  BitBtn1.Enabled := False;
//  Application.ProcessMessages;
//  Sleep(30000);  // replace with query.Open or such
//  BitBtn1.Enabled := True;
//  ani.Terminate;
//  ShowMessage('Done');

  ShowModalElapsedTimeForm();
end;


procedure THiconisTCPF.ShowRetentionPolicies1Click(Sender: TObject);
var
  LIpAddrList: string;
begin
  //';'로 구분됨
  LIpAddrList := GetSelectedIpAddrList();
  GetRetentionPoliciesBySelectedIpList(LIpAddrList);
end;

procedure THiconisTCPF.ShowTD(const ATDRec: TMsgBox);
begin
  TD('').WindowCaption(ATDRec.FCaption).Execute(Self);
end;

procedure THiconisTCPF.TaskTabChange(Sender: TObject);
var
  LIpAddr: string;
begin
  LIpAddr := GetSelectedIpAddrList();
  SetIdList2Grid(LIpAddr);
end;

procedure THiconisTCPF.VerifyLogParam2Click(Sender: TObject);
var
  LResult, LLogDrive: string;
  LThisComIsHistoryStation: Boolean;
begin
  LLogDrive := GetLogDrive(LThisComIsHistoryStation);

  LResult := VerifyLogParamFromConf(LLogDrive); //DEFAULT_INFLUXDB_CONF_NAME
  ShowMessage(LResult);
end;

procedure THiconisTCPF.version2Click(Sender: TObject);
begin
  GetVersionMPMFromIpSelected();
end;

procedure THiconisTCPF.version3Click(Sender: TObject);
begin
  GetVersionIntfFromIpSelected();
end;

end.
