unit CommonData2;

interface

uses System.Classes, System.SysUtils, System.StrUtils, Vcl.StdCtrls,
{$IFDEF USE_OUTLOOK2016}
  Outlook2016_TLB,
{$ELSE}
  Outlook2010,
{$ENDIF}
  UnitEnumHelper;

type
  TGUIDFileName = record
    HasInput: boolean;
    FileName: string[255];
  end;

  TOLMsgFile4STOMP = record
    FHost, FUserId, FPasswd, FTopic: string;
    FMsgFileName,
    FMsgFilePath,
    FMsgFile: string;
  end;

  TEntryIdRecord = record
    FEntryId,
    FStoreId,
    FStoreId4Move,
    FFolderPath,
    FNewEntryId,
    FSubject,
    FTo,
    FHTMLBody,
    FHullNo,
    FSubFolder,
    FAttached,
    FAttachFileName: string;
    FIgnoreReceiver2pjh: Boolean; //True = �����ڰ� pjh�ΰ� ������ ����
    FIgnoreEmailMove2WorkFolder: Boolean; //True = Working Folder�� �̵� ����
    //True = Move�ϰ��� ������ ���� �Ʒ��� HullNo Folder ���� �� ������ ������ ���� �̵� ��
    FIsCreateHullNoFolder: Boolean;
//    FIsShowMailContents: Boolean; //True = Mail Display
  end;

  TOLMsgFileRecord = record
    FEntryId,
    FStoreId,
    FSender,
    FReceiver,
    FCarbonCopy,
    FBlindCC,
    FSubject,
    FUserEmail,
    FUserName,
    FSavedOLFolderPath,
    FSpecialStatement: string;
    FMailItem: MailItem;
    FReceiveDate: TDateTime;
    FServiceType,
    FEmailKind: integer;

    procedure Clear;
  end;

  TOLAccountInfo = record
    SmtpAddress, DisplayName, UserName: string;
  end;

  TSettingInfo = record
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
    FSubConPaymentPICSig
    : string;
  end;

  Doc_Invoice_Rec = packed record
    FCompanyCode, FCompanyName, FCustomerInfo, FInvNo, FInvDate, FHullNo, FShipName,
    FSubject, FProduceType, FPONo, FTotalPrice,
    FIMONo, FVDRSerialNo, FVDRTYpe, FAPTPlace, FAPTResult, FEmail: string;
    FOnboardDate: TDate;
    FInvoiceItemList: TStringList;
  end;

  TDBCRUDResult = (crudNull, crudOK, crudFail, crudUpdateOK, crudAddOK, crudDeleteOK, crudCreateOK,
    crudUpdateFail, crudAddFail, crudDeleteFail, crudCreateFail, crudFinal);
  TTierStep = (tsNull, tsTierI, tsTierII, tsTierIII, tsFinal);
  TTierSteps = set of TTierStep;
                      //
  TCompanyType = (ctNull, ctNewCompany, ctMaker, ctOwner, ctAgent, ctCorporation, ctSubContractor, ctFinal);
  TCompanyTypes = set of TCompanyType;
  TCompanyType2 = (ct2Null, ct2OurCompany, ct2Licensor, ct2Partner, ct2SubContractor, ct2Client, ct2ShipBuilder,
    ct2Dealer, ct2Agent, ct2Class, ct2Logistic, ct2Etc, ct2Corporation, ct2Final);
  TCompanyTypes2 = set of TCompanyType2;
  TBusinessArea = (baNull, baShip, baEngine, baElectric, baFinal);  //����,����,��������
  TBusinessAreas = set of TBusinessArea;
  TCurrencyKind = (ckNone, ckKW, ckUSD, ckEUR);
  TBusinessRegion = (brNone, brSouthEurope, brNorthEurope, brMiddleEast, brGreece,
    brSingapore, brAmerica, brEastSouthAsia, brEastNorthAsia, brFinal);
  TBusinessRegions = set of TBusinessRegion;

const
  R_TierStep : array[Low(TTierStep)..High(TTierStep)] of string =
    ('', 'Tier I', 'Tier II', 'Tier III', '');

  R_CompanyType : array[ctNull..ctFinal] of record
    Description : string;
    Value       : TCompanyType;
  end = ((Description : '';                   Value : ctNull),
         (Description : '1.New Company';      Value : ctNewCompany),
         (Description : '3.Maker';            Value : ctMaker),
         (Description : '4.Owner';            Value : ctOwner),
         (Description : '6.Agent';            Value : ctAgent),
         (Description : 'B.����';             Value : ctCorporation),
         (Description : '���»�';             Value : ctSubContractor),
         (Description : '';                   Value : ctFinal)
         );

  R_CompanyType2 : array[ct2Null..ct2Final] of record
    Description : string;
    Value       : TCompanyType2;
  end = ((Description : '';                   Value : ct2Null),
         (Description : '1.���';             Value : ct2OurCompany),
         (Description : '2.���̼���';         Value : ct2Licensor),
         (Description : '3.���¾�ü';         Value : ct2Partner),
         (Description : '4.����';           Value : ct2Client),
         (Description : '5.������';           Value : ct2ShipBuilder),
         (Description : '6.����(�븮��)';     Value : ct2Dealer),
         (Description : '7.������ü';         Value : ct2Agent),
         (Description : '8.����';             Value : ct2Class),
         (Description : '9.������ü';         Value : ct2Logistic),
         (Description : 'A.��Ÿ';             Value : ct2Etc),
         (Description : 'B.����';             Value : ct2Corporation),
         (Description : 'C.�뿪���־�ü';     Value : ct2SubContractor),
         (Description : '';                   Value : ct2Final)
         );

  R_BusinessArea : array[baNull..baFinal] of record
    Description : string;
    Value       : TBusinessArea;
  end = ((Description : '';           Value : baNull),
         (Description : '����';       Value : baShip),
         (Description : '����';       Value : baEngine),
         (Description : '����';       Value : baElectric),
         (Description : '';           Value : baFinal)
         );

  R_CurrencyKind : array[ckNone..ckEUR] of record
    Description : string;
    Value       : TCurrencyKind;
  end = ((Description : '';             Value : ckNone),
         (Description : 'KRW'; Value : ckKW),
         (Description : 'USD'; Value : ckUSD),
         (Description : 'EUR'; Value : ckEUR)
         );

//  gpSHARED_DATA_NAME = 'SharedData_{BCB1C40A-3B72-44FC-9E72-91E5FF498924}';
//  SHARED_DATA_NAME = 'SharedData_{32EF1528-1D5E-48AE-B8AF-341309C303FA}';

//  CONSUME_EVENT_NAME = SHARED_DATA_NAME + '_ConsumeEvent';
//  PRODUCE_EVENT_NAME = SHARED_DATA_NAME + '_ProduceEvent';

  FOLDER_NAME_4_TEMP_MSG_FILES = 'c:\temp\emailmsgs\';
  EMAIL_TOPIC_NAME = '/topic/emailtopic';
  FOLDER_LIST_FILE_NAME = 'FolderList';
  OLFOLDER_LIST_FILE_NAME = 'OLFolderList.txt';
  IPC_SERVER_NAME_4_OUTLOOK = 'Mail2CromisIPCServer';
  //Response�� �ʿ��Ҷ� ���Ǵ� ������, �񵿱� ����� �ƴ�(�񵿱� ����� Response�� �ȵ�)
  IPC_SERVER_NAME_4_OUTLOOK2 = 'Mail2CromisIPCServer2';
  IPC_SERVER_NAME_4_INQMANAGE = 'Mail2CromisIPCClient';
  WS_SERVER_NAME_4_OUTLOOK = 'WSServer4OLMail';

  CMD_LIST = 'CommandList';
  CMD_SEND_MAIL_ENTRYID = 'Send Mail Entry Id';
  CMD_SEND_MAIL_ENTRYID2 = 'Send Mail Entry Id2';
  CMD_SEND_FOLDER_STOREID = 'Send Folder Store Id';
  CMD_SEND_MAIL_2_MSGFILE = 'Send Mail To Msg File';

  CMD_RESPONDE_MOVE_FOLDER_MAIL = 'Resonse for Move Mail to Folder';
  CMD_REQ_MAIL_VIEW = 'Request Mail View';
  CMD_REQ_MAIL_VIEW_FROM_MSGFILE = 'Request Mail View From .msg file';
  CMD_REQ_MAILINFO_SEND = 'Request Mail-Info to Send';
  //���ϸ���Ʈ���� ����, TaskID�� �ڵ����� ��
  CMD_REQ_MAILINFO_SEND2 = 'Request Mail-Info to Send2';
  CMD_REQ_MOVE_FOLDER_MAIL = 'Request Move Mail to Folder';
  CMD_REQ_REPLY_MAIL = 'Request Reply Mail';
  CMD_REQ_CREATE_MAIL = 'Request Create Mail';
  CMD_REQ_FORWARD_MAIL = 'Request Forward Mail';
  CMD_REQ_ADD_APPOINTMENT = 'Request Add Appointment';
  //Remote Command
  CMD_REQ_TASK_LIST = 'Request Task List';
  CMD_REQ_TASK_DETAIL = 'Request Task Detail';
  CMD_REQ_TASK_EAMIL_LIST = 'Request Task Email List';
  CMD_REQ_TASK_EAMIL_CONTENT = 'Request Task Email Content';
  CMD_EXECUTE_SAVE_TASK_DETAIL = 'Execute Save Task Detail';
  CMD_REQ_VESSEL_LIST = 'Request Vessel List';

//  SALES_DIRECTOR_EMAIL_ADDR = 'shjeon@hyundai-gs.com';//����ó�������
  SALES_DIRECTOR_EMAIL_ADDR = 'seonyunshin@hyundai-gs.com';//����ó�������
  MATERIAL_INPUT_EMAIL_ADDR = 'geunhyuk.lim@pantos.com';//���������Կ�û
  FOREIGN_INPUT_EMAIL_ADDR = 'seryeongkim@hyundai-gs.com';//�ؿܰ���ü���
  ELEC_HULL_REG_EMAIL_ADDR = 'seryeongkim@hyundai-gs.com';//������ǥ�ذ��� ���� ��û
  PO_REQ_EMAIL_ADDR = 'seryeongkim@hyundai-gs.com';//PO ��û
  SHIPPING_REQ_EMAIL_ADDR = 'yungem.kim@pantos.com';//���� ��û
  FIELDSERVICE_REQ_EMAIL_ADDR = 'yongjunelee@hyundai-gs.com';//�ʵ弭�� ����

  MY_EMAIL_SIG = '��ǰ����2�� ������ ����';
  SHIPPING_MANAGER_SIG = '���佺 ������ ���Ӵ�';
//  SALES_MANAGER_SIG = '��ǰ����1�� ������ �����';
  SALES_MANAGER_SIG = '��ǰ����2�� �ż�����';
  FIELDSERVICE_MANAGER_SIG = '�ʵ弭���� �̿��� �����';

  //Task�� Outlook ÷�����Ϸ� ���鶧 �ν��ϱ� ���� ���ڿ�
  TASK_JSON_DRAG_SIGNATURE = '{274C083F-EB64-49D8-ADE7-8804CFD0D030}';
  INVOICETASK_JSON_DRAG_SIGNATURE = '{144B4D16-A8E7-4E9A-89C1-994FE6AEC793}';

  REGEX_HULLNO_PATTERN = '^[A-Za-z]{1,4}\d{4}$';
  REGEX_SHIPNAME_PATTERN = '^[A-Za-z]+[A-Za-z0-9]+$';
  REGEX_ORDERNO_PATTERN = '^[A-Za-z]{3}[0-9]{1,7}$';

  QUOTATION_MANAGE_EXE_NAME = 'QuotationManage.exe';

function GetCylCountFromEngineModel(AEngineModel: string): string;
procedure OLMsgFileRecordClear;

//function ShipProductType2String(AShipProductType:TShipProductType) : string;
//function String2ShipProductType(AShipProductType:string): TShipProductType;
//procedure ShipProductType2Combo(AComboBox:TComboBox);
//function EngineProductType2String(AShipProductType:TShipProductType) : string;
//function String2ShipProductType(AShipProductType:string): TShipProductType;
//procedure ShipProductType2Combo(AComboBox:TComboBox);
//function ElecProductType2String(AElecProductType:TElecProductType) : string;
//function String2ElecProductType(AElecProductType:string): TElecProductType;
//procedure ElecProductType2Combo(AComboBox:TComboBox);
//function ElecProductDetailType2String(AElecProductDetailType:TElecProductDetailType) : string;
//function String2ElecProductDetailType(AElecProductDetailType:string): TElecProductDetailType;
//procedure ElecProductDetailType2Combo(AComboBox:TComboBox);

//function GSInvoiceItemType2String(AGSInvoiceItemType:TGSInvoiceItemType) : string;
//function String2GSInvoiceItemType(AGSInvoiceItemType:string): TGSInvoiceItemType;
//procedure GSInvoiceItemType2Combo(AComboBox:TComboBox);
function CompanyType2String(ACompanyType:TCompanyType) : string;
function String2CompanyType(ACompanyType:string): TCompanyType;
function String2CompanyType2(ACompanyType:string): TCompanyType2;
procedure CompanyType2Combo(AComboBox:TComboBox);
function TCompanyType_SetToInt(ss : TCompanyTypes) : integer;
function IntToTCompanyType_Set(mask : integer) : TCompanyTypes;
function TCompanyType2_SetToInt(ss : TCompanyTypes2) : integer;
function IntToTCompanyType2_Set(mask : integer) : TCompanyTypes2;
function IsInFromInt2TCompanyType(mask : integer; ss: TCompanyType): Boolean;
function IsInFromCompanyTypes2TCompanyType(mask : TCompanyTypes; ss: TCompanyType): Boolean;
function GetCompanyTypes2String(ACompanyTypes: TCompanyTypes): string;
function GetCompanyTypesFromCommaString(ACommaStr:string): TCompanyTypes;
function GetCompanyTypes2FromCommaString(ACommaStr:string): TCompanyTypes2;
function GetCommaStringFromSetOfIntValueByCompanyTypes2(ACommaStrOfIntValue:string): string;
function String2TCompanyType_Set(AStr:string): TCompanyTypes;
function HVCodes2TCompanyType_Set(ASepecialConfig:string): TCompanyTypes;
function GetFirstCompanyTypeIndex(ss: TCompanyTypes) : integer;
function TBusinessArea_SetToInt(ss : TBusinessAreas) : integer;
function IntToTBusinessArea_Set(mask : integer) : TBusinessAreas;
function GetBusinessAreasFromCommaString(ACommaStr:string): TBusinessAreas;
function IsInFromInt2TBusinessArea(mask : integer; ss: TBusinessArea): Boolean;
function IsInFromTBusinessAreas2TBusinessAreas(mask : TBusinessAreas; ss: TBusinessAreas): Boolean;
function GetBusinessAreas2String(ABusinessAreas: TBusinessAreas): string;
function BusinessArea2String(ABusinessArea:TBusinessArea) : string;
function String2BusinessArea(ABusinessArea:string): TBusinessArea;

function CurrencyKind2String(ACurrencyKind:TCurrencyKind) : string;
function String2CurrencyKind(ACurrencyKind:string): TCurrencyKind;
procedure CurrencyKind2Combo(AComboBox:TComboBox);

var
  g_MyEmailInfo: TOLAccountInfo;

  g_TierStep: TLabelledEnum<TTierStep>;

implementation

uses UnitStringUtil, UnitRttiUtil2, Rtti;

function GetCylCountFromEngineModel(AEngineModel: string): string;
begin
  Result := '';

  if POS('H', AEngineModel) >= 0 then
  begin
    Result := strToken(AEngineModel, 'H');
  end
  else
  if POS('L', AEngineModel) >= 0 then
  begin
    Result := strToken(AEngineModel, 'L');
  end;
end;

procedure OLMsgFileRecordClear;
begin
end;

{ TOLMsgFileRecord }

procedure TOLMsgFileRecord.Clear;
begin
  FEntryId := '';
  FStoreId := '';
  FSender := '';
  FReceiver := '';
  FCarbonCopy := '';
  FBlindCC := '';
  FSubject := '';
  FReceiveDate := 0;
  FMailItem := nil;
end;

//function ShipProductType2String(AShipProductType:TShipProductType) : string;
//begin
//  if AShipProductType <= High(TShipProductType) then
//    Result := R_ShipProductType[AShipProductType].Description;
//end;
//
//function String2ShipProductType(AShipProductType:string): TShipProductType;
//var Li: TShipProductType;
//begin
//  for Li := shptNull to shptFinal do
//  begin
//    if R_ShipProductType[Li].Description = AShipProductType then
//    begin
//      Result := R_ShipProductType[Li].Value;
//      exit;
//    end;
//  end;
//end;
//
//procedure ShipProductType2Combo(AComboBox:TComboBox);
//var Li: TShipProductType;
//begin
//  AComboBox.Clear;
//
//  for Li := shptNull to Pred(shptFinal) do
//  begin
//    AComboBox.Items.Add(R_ShipProductType[Li].Description);
//  end;
//end;

//function ElecProductType2String(AElecProductType:TElecProductType) : string;
//begin
//  if AElecProductType <= High(TElecProductType) then
//    Result := R_ElecProductType[AElecProductType].Description;
//end;
//
//function String2ElecProductType(AElecProductType:string): TElecProductType;
//var Li: TElecProductType;
//begin
//  for Li := eptNull to eptFinal do
//  begin
//    if R_ElecProductType[Li].Description = AElecProductType then
//    begin
//      Result := R_ElecProductType[Li].Value;
//      exit;
//    end;
//  end;
//end;
//
//procedure ElecProductType2Combo(AComboBox:TComboBox);
//var Li: TElecProductType;
//begin
//  AComboBox.Clear;
//
//  for Li := eptNull to Pred(eptFinal) do
//  begin
//    AComboBox.Items.Add(R_ElecProductType[Li].Description);
//  end;
//end;
//
//function ElecProductDetailType2String(AElecProductDetailType:TElecProductDetailType) : string;
//begin
//  if AElecProductDetailType <= High(TElecProductDetailType) then
//    Result := R_ElecProductDetailType[AElecProductDetailType].Description;
//end;
//
//function String2ElecProductDetailType(AElecProductDetailType:string): TElecProductDetailType;
//var Li: TElecProductDetailType;
//begin
//  for Li := epdtNull to epdtFinal do
//  begin
//    if R_ElecProductDetailType[Li].Description = AElecProductDetailType then
//    begin
//      Result := R_ElecProductDetailType[Li].Value;
//      exit;
//    end;
//  end;
//end;
//
//procedure ElecProductDetailType2Combo(AComboBox:TComboBox);
//var Li: TElecProductDetailType;
//begin
//  AComboBox.Clear;
//
//  for Li := epdtNull to Pred(epdtFinal) do
//  begin
//    AComboBox.Items.Add(R_ElecProductDetailType[Li].Description);
//  end;
//end;

function CompanyType2String(ACompanyType:TCompanyType) : string;
begin
  if ACompanyType <= High(TCompanyType) then
    Result := R_CompanyType[ACompanyType].Description;
end;

function String2CompanyType(ACompanyType:string): TCompanyType;
var Li: TCompanyType;
begin
  for Li := ctNull to ctFinal do
  begin
    if R_CompanyType[Li].Description = ACompanyType then
    begin
      Result := R_CompanyType[Li].Value;
      exit;
    end;
  end;
end;

function String2CompanyType2(ACompanyType:string): TCompanyType2;
var Li: TCompanyType2;
begin
  for Li := ct2Null to ct2Final do
  begin
    if R_CompanyType2[Li].Description = ACompanyType then
    begin
      Result := R_CompanyType2[Li].Value;
      exit;
    end;
  end;
end;

procedure CompanyType2Combo(AComboBox:TComboBox);
var Li: TCompanyType;
begin
  AComboBox.Clear;

  for Li := ctNull to Pred(ctFinal) do
  begin
    AComboBox.Items.Add(R_CompanyType[Li].Description);
  end;
end;

function TCompanyType_SetToInt(ss : TCompanyTypes) : integer;
var intset : TIntegerSet;
    s : TCompanyType;
begin
  intSet := [];
  for s in ss do
    include(intSet, ord(s));
  result := integer(intSet);
end;

function IntToTCompanyType_Set(mask : integer) : TCompanyTypes;
var intSet : TIntegerSet;
    b : byte;
begin
  intSet := TIntegerSet(mask);
  result := [];
  for b in intSet do
    include(result, TCompanyType(b));
end;

function TCompanyType2_SetToInt(ss : TCompanyTypes2) : integer;
var intset : TIntegerSet;
    s : TCompanyType2;
begin
  intSet := [];
  for s in ss do
    include(intSet, ord(s));
  result := integer(intSet);
end;

function IntToTCompanyType2_Set(mask : integer) : TCompanyTypes2;
var intSet : TIntegerSet;
    b : byte;
begin
  intSet := TIntegerSet(mask);
  result := [];
  for b in intSet do
    include(result, TCompanyType2(b));
end;

function IsInFromInt2TCompanyType(mask : integer; ss: TCompanyType): Boolean;
var intSet : TIntegerSet;
    b : byte;
begin
  intSet := TIntegerSet(mask);

  for b in intSet do
  begin
    Result := TCompanyType(b) = ss;

    if Result then
      break;
  end;
end;

function IsInFromCompanyTypes2TCompanyType(mask : TCompanyTypes; ss: TCompanyType): Boolean;
var
  i: integer;
begin
  i := TCompanyType_SetToInt(mask);
  Result := IsInFromInt2TCompanyType(i, ss);
end;

function GetCompanyTypes2String(ACompanyTypes: TCompanyTypes): string;
var
  LCt: TCompanyType;
begin
  Result := '';

  for LCt in ACompanyTypes do
  begin
    Result := Result + CompanyType2String(LCt) + ';';
  end;

  Delete(Result, Length(Result), 1); //������ ';' ����
end;

function GetCompanyTypesFromCommaString(ACommaStr:string): TCompanyTypes;
var
  LStrList: TStringList;
  LCompanyType: TCompanyType;
  i: integer;
begin
  Result := [];
  LStrList := TStringList.Create;
  try
    ACommaStr := StringReplace(ACommaStr, ';', ',',  [rfReplaceAll]);
    LStrList.CommaText := ACommaStr;

    for i := 0 to LStrList.Count - 1 do
    begin
      LCompanyType := String2CompanyType(LStrList.Strings[i]);
      Result := Result + [LCompanyType];
    end;
  finally
    LStrList.Free;
  end;
end;

function GetCompanyTypes2FromCommaString(ACommaStr:string): TCompanyTypes2;
var
  LStrList: TStringList;
  LCompanyType: TCompanyTypes2;
  i,j: integer;
begin
  Result := [];
  LStrList := TStringList.Create;
  try
    ACommaStr := StringReplace(ACommaStr, ';', ',',  [rfReplaceAll]);
    LStrList.CommaText := ACommaStr;

    for i := 0 to LStrList.Count - 1 do
    begin
      j := StrToIntDef(LStrList.Strings[i],0);
      LCompanyType := IntToTCompanyType2_Set(j);
      Result := Result + LCompanyType;
    end;
  finally
    LStrList.Free;
  end;
end;

//ACommaStrOfIntValue : '1,2,3'
//Result : 'ct2OurCompany, ct2Licensor, ct2Partner'
function GetCommaStringFromSetOfIntValueByCompanyTypes2(ACommaStrOfIntValue:string): string;
var
  LStrList: TStringList;
  i,j: integer;
  LStr: string;
begin
  Result := '';
  LStrList := TStringList.Create;
  try
    ACommaStrOfIntValue := StringReplace(ACommaStrOfIntValue, ';', ',',  [rfReplaceAll]);
    LStrList.CommaText := ACommaStrOfIntValue;

    for i := 0 to LStrList.Count - 1 do
    begin
      LStr := LStrList.Strings[i];

      if StrIsNumeric(LStr) then
        j := StrToIntDef(LStr,0)
      else
        j := HexToInt(LStr);

      if Result <> '' then
        Result := Result + ',';

      Result := Result + TRttiEnumerationType.GetName<TCompanyType2>(TCompanyType2(j));//Ord(R_CompanyType2[j].Value)
    end;
  finally
    LStrList.Free;
  end;
end;

function String2TCompanyType_Set(AStr:string): TCompanyTypes;
var
  LStr:string;
begin
  Result := [];

  while true do
  begin
    if AStr = '' then
      break;

    LStr := StrToken(AStr, ';');
    Result := Result + [String2CompanyType(LStr)];
  end;
end;

function HVCodes2TCompanyType_Set(ASepecialConfig:string): TCompanyTypes;
var
  LStr: string;
  i: integer;
begin
  Result := [];

  for i := 1 to Length(ASepecialConfig) do
  begin
    LStr := LeftStr(ASepecialConfig, i);
    if LStr <> '' then
    begin
      System.Delete(ASepecialConfig, 1, 1);
//      Result := Result + [HVCode2CompanyType(LStr)];
    end;
  end;
end;

function GetFirstCompanyTypeIndex(ss: TCompanyTypes) : integer;
var s : TCompanyType;
begin
  for s in ss do
  begin
    result := ord(s);
    break;
  end;
end;

function TBusinessArea_SetToInt(ss : TBusinessAreas) : integer;
var intset : TIntegerSet;
    s : TBusinessArea;
begin
//  intSet := [];
//  for s in ss do
//    include(intSet, ord(s));
//  result := integer(intSet);
  Result := SetToInt(ss, SizeOf(ss));
end;

function IntToTBusinessArea_Set(mask : integer) : TBusinessAreas;
var intSet : TIntegerSet;
    b : byte;
begin
  intSet := TIntegerSet(mask);
  result := [];
  for b in intSet do
    include(result, TBusinessArea(b));
end;

function GetBusinessAreasFromCommaString(ACommaStr:string): TBusinessAreas;
var
  LStrList: TStringList;
  LBusinessArea: TBusinessArea;
  i: integer;
begin
  Result := [];
  LStrList := TStringList.Create;
  try
    ACommaStr := StringReplace(ACommaStr, ';', ',',  [rfReplaceAll]);
    LStrList.CommaText := ACommaStr;

    for i := 0 to LStrList.Count - 1 do
    begin
      LBusinessArea := String2BusinessArea(LStrList.Strings[i]);
      Result := Result + [LBusinessArea];
    end;
  finally
    LStrList.Free;
  end;
end;

//mask�ȿ� ss�� ���� �Ǵ��� Ȯ��
function IsInFromInt2TBusinessArea(mask : integer; ss: TBusinessArea): Boolean;
var intSet : TIntegerSet;
    b : byte;
begin
  intSet := TIntegerSet(mask);

  for b in intSet do
  begin
    Result := TBusinessArea(b) = ss;

    if Result then
      break;
  end;
end;

//mask: DB�� ����, ss: �˻�â���� ������ ����
function IsInFromTBusinessAreas2TBusinessAreas(mask : TBusinessAreas; ss: TBusinessAreas): Boolean;
var
  intSet : TIntegerSet;
  b : byte;
  LBa, LBa2: TBusinessArea;
begin
//  i := TBusinessArea_SetToInt(mask);
//  intSet := TIntegerSet(i);

  Result := False;

  for LBa in ss do
  begin
    for LBa2 in mask do
    begin
      Result := LBa2 = LBa;

      if Result then
        exit;
    end;
  end;
end;

function GetBusinessAreas2String(ABusinessAreas: TBusinessAreas): string;
var
  LBa: TBusinessArea;
begin
  Result := '';
//  i := TBusinessArea_SetToInt(mask);
//  intSet := TIntegerSet(i);
  for LBa in ABusinessAreas do
  begin
    Result := Result + BusinessArea2String(LBa) + ',';
  end;

  Delete(Result, Length(Result), 1); //������ ',' ����
end;

function BusinessArea2String(ABusinessArea:TBusinessArea) : string;
begin
  if ABusinessArea <= High(TBusinessArea) then
    Result := R_BusinessArea[ABusinessArea].Description;
end;

function String2BusinessArea(ABusinessArea:string): TBusinessArea;
var Li: TBusinessArea;
begin
  for Li := baNull to baFinal do
  begin
    if R_BusinessArea[Li].Description = ABusinessArea then
    begin
      Result := R_BusinessArea[Li].Value;
      exit;
    end;
  end;
end;

//function GSInvoiceItemType2String(AGSInvoiceItemType: TGSInvoiceItemType) : string;
//begin
//  if AGSInvoiceItemType <= High(TGSInvoiceItemType) then
//    Result := R_GSInvoiceItemType[AGSInvoiceItemType].Description;
//end;
//
//function String2GSInvoiceItemType(AGSInvoiceItemType: string): TGSInvoiceItemType;
//var Li: TGSInvoiceItemType;
//begin
//  for Li := iitNull to iitFinal do
//  begin
//    if R_GSInvoiceItemType[Li].Description = AGSInvoiceItemType then
//    begin
//      Result := R_GSInvoiceItemType[Li].Value;
//      exit;
//    end;
//  end;
//end;
//
//procedure GSInvoiceItemType2Combo(AComboBox: TComboBox);
//var Li: TGSInvoiceItemType;
//begin
//  AComboBox.Clear;
//
//  for Li := iitNull to Pred(iitFinal) do
//  begin
//    AComboBox.Items.Add(R_GSInvoiceItemType[Li].Description);
//  end;
//end;

function CurrencyKind2String(ACurrencyKind:TCurrencyKind) : string;
begin
  if ACurrencyKind <= High(TCurrencyKind) then
    Result := R_CurrencyKind[ACurrencyKind].Description;
end;

function String2CurrencyKind(ACurrencyKind:string): TCurrencyKind;
var Li: TCurrencyKind;
begin
  for Li := ckNone to ckEUR do
  begin
    if R_CurrencyKind[Li].Description = ACurrencyKind then
    begin
      Result := R_CurrencyKind[Li].Value;
      exit;
    end;
  end;
end;

procedure CurrencyKind2Combo(AComboBox:TComboBox);
var Li: TCurrencyKind;
begin
  AComboBox.Clear;

  for Li := ckNone to ckEUR do
  begin
    AComboBox.Items.Add(R_CurrencyKind[Li].Description);
  end;
end;

initialization
  g_TierStep.InitArrayRecord(R_TierStep);

end.
