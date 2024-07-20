unit CommonData2;

interface

uses System.Classes, System.SysUtils, System.StrUtils, Vcl.StdCtrls,
{$IFDEF USE_OUTLOOK2016}
  Outlook2016_TLB,
{$ELSE}
  Outlook2010,
{$ENDIF}
  UnitEnumHelper, UnitOLDataType;

type

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

  DOC_CIPL_Rec = record
    FHullNo,
    FShipName,
    //Commercial Invoice Info
    FAccount,
    FAccountAddr,
    FPortOfLoading,
    FInvoieNo,
    FTermOfDelivery,
    FRemark,
    FClaimNo,
    FDescription,
    FQty,
    FUnitPrice,
    FAmount,

    //Packing List Info
    FNumOfPkgs,
    FNewWeight,
    FGrossWeight,
    FMeasurement,
    FCMB: string;
  end;

  DOC_SHIPMARK_Rec = record
    FHullNo,
    FShipName,
    FClaimNo,
    FQty,
    FDescription,
    FNumOfPkgs
    : string;
  end;

  DOC_RECEIPTACCPT_Rec = record
    FHullNo,
    FShipName,
    FClaimNo,
    FProjectNo,
    FProjectName,
    FPICName,
    FPORNo,
    FMatName,
    FMatDesc,
    FQty,
    FReciptDate,
    FRecvCompany,
    FSpec,
    FRemark,
    FDepartment
    : string;
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
  TBusinessArea = (baNull, baShip, baEngine, baElectric, baFinal);  //조선,엔진,전기전자
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
         (Description : 'B.법인';             Value : ctCorporation),
         (Description : '협력사';             Value : ctSubContractor),
         (Description : '';                   Value : ctFinal)
         );

  R_CompanyType2 : array[ct2Null..ct2Final] of record
    Description : string;
    Value       : TCompanyType2;
  end = ((Description : '';                   Value : ct2Null),
         (Description : '1.당사';             Value : ct2OurCompany),
         (Description : '2.라이센서';         Value : ct2Licensor),
         (Description : '3.협력업체';         Value : ct2Partner),
         (Description : '4.고객사';           Value : ct2Client),
         (Description : '5.조선소';           Value : ct2ShipBuilder),
         (Description : '6.딜러(대리점)';     Value : ct2Dealer),
         (Description : '7.수리업체';         Value : ct2Agent),
         (Description : '8.선급';             Value : ct2Class),
         (Description : '9.물류업체';         Value : ct2Logistic),
         (Description : 'A.기타';             Value : ct2Etc),
         (Description : 'B.법인';             Value : ct2Corporation),
         (Description : 'C.용역발주업체';     Value : ct2SubContractor),
         (Description : '';                   Value : ct2Final)
         );

  R_BusinessArea : array[baNull..baFinal] of record
    Description : string;
    Value       : TBusinessArea;
  end = ((Description : '';           Value : baNull),
         (Description : '조선';       Value : baShip),
         (Description : '엔진';       Value : baEngine),
         (Description : '전전';       Value : baElectric),
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

//  SALES_DIRECTOR_EMAIL_ADDR = 'shjeon@hyundai-gs.com';//매출처리담당자
  SALES_DIRECTOR_EMAIL_ADDR = 'seonyunshin@hyundai-gs.com';//매출처리담당자
  MATERIAL_INPUT_EMAIL_ADDR = 'geunhyuk.lim@pantos.com';//자재직투입요청
  FOREIGN_INPUT_EMAIL_ADDR = 'seryeongkim@hyundai-gs.com';//해외고객업체등록
  ELEC_HULL_REG_EMAIL_ADDR = 'seryeongkim@hyundai-gs.com';//전전비표준공사 생성 요청
  PO_REQ_EMAIL_ADDR = 'seryeongkim@hyundai-gs.com';//PO 요청
  SHIPPING_REQ_EMAIL_ADDR = 'yungem.kim@pantos.com';//출하 요청
  FIELDSERVICE_REQ_EMAIL_ADDR = 'yongjunelee@hyundai-gs.com';//필드서비스 팀장

  MY_EMAIL_SIG = '부품서비스2팀 박정현 차장';
  SHIPPING_MANAGER_SIG = '판토스 김윤겸 주임님';
//  SALES_MANAGER_SIG = '부품서비스1팀 전선희 사원님';
  SALES_MANAGER_SIG = '부품서비스2팀 신선윤씨';
  FIELDSERVICE_MANAGER_SIG = '필드서비스팀 이용준 부장님';

  //Task를 Outlook 첨부파일로 만들때 인식하기 위한 문자열
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

  Delete(Result, Length(Result), 1); //마지막 ';' 삭제
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

//mask안에 ss가 포함 되는지 확인
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

//mask: DB의 내용, ss: 검색창에서 선택한 내용
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

  Delete(Result, Length(Result), 1); //마지막 ',' 삭제
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
