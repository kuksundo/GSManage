unit UnitHiASMaterialRecord;

interface

uses SysUtils, Classes, Generics.Collections,
  mormot.core.base, mormot.orm.core, mormot.rest.client, mormot.core.os,
  mormot.rest.sqlite3, mormot.orm.base, mormot.core.data, mormot.core.variants,
  mormot.core.datetime, mormot.core.json,

  UnitHiconisMasterRecord, CommonData2, UnitArrayUtil
  ;

type
  TSQLMaterial4Project = class(TSQLRecord)
  private
    fTaskID: TID;
    fMaterialName, //자재명
    fPORNo: RawUTF8;
    fSupplyCount,//공급수량
    fUnitPrice, //단가
    fPriceAmount, //총금액 : 단가 x 공급수량
    fFreeOrCharge //해외운송의뢰서의 유/무환 구분
    : integer;
    FPORIssueDate,
    fReqDeliveryDate, //운송요청일자
    fReqArriveDate  //도착요청일자
    : TTimeLog;
    fShippingNo, //출하지시번호
    fStoreAddress, //보관처
    fDeliveryAddress,//배송지 주소
    fPortName, //Port of Loading
    fAirWayBill //AWB
    : RawUTF8;
    fDeliveryKind: integer;//운송방법 : 국내택배,
    fDeliveryCharge, //운송비용
    fDeliveryCompany, //운송회사
    fTermOfDelivery, //FOB(국내) or DDP(선박)
    fNetWeight,  //순중량(Kg)
    fGrossWeight, //총중량(Kg)
    fMeasurement, //Box치수(LxWxH/mm)
    fCBM, //Cubic Meter
    fNumOfPkg, //포장수량
    fDirectInputReqNo //자재직투입번호 : 공란이 아니면 직투입한 자재라는 의미
    : RawUTF8;
    FIsUpdate: Boolean;
  public
    //True : DB Update, False: DB Add
    property IsUpdate: Boolean read FIsUpdate write FIsUpdate;
  published
    property TaskID: TID read fTaskID write fTaskID;
    property PORNo: RawUTF8 read fPORNo write fPORNo;
    property MaterialName: RawUTF8 read fMaterialName write fMaterialName;
    property SupplyCount: integer read fSupplyCount write fSupplyCount;
    property UnitPrice: integer read fUnitPrice write fUnitPrice;
    property PriceAmount: integer read fPriceAmount write fPriceAmount;
    property FreeOrCharge: integer read fFreeOrCharge write fFreeOrCharge;
    property PORIssueDate: TTimeLog read FPORIssueDate write FPORIssueDate;
    property ReqDeliveryDate: TTimeLog read fReqDeliveryDate write fReqDeliveryDate;
    property ReqArriveDate: TTimeLog read fReqArriveDate write fReqArriveDate;
    property ShippingNo: RawUTF8 read fShippingNo write fShippingNo;
    property StoreAddress: RawUTF8 read fStoreAddress write fStoreAddress;
    property DeliveryAddress: RawUTF8 read fDeliveryAddress write fDeliveryAddress;
    property AirWayBill: RawUTF8 read fAirWayBill write fAirWayBill;
    property DeliveryKind: integer read fDeliveryKind write fDeliveryKind;
    property DeliveryCharge: RawUTF8 read fDeliveryCharge write fDeliveryCharge;
    property DeliveryCompany: RawUTF8 read fDeliveryCompany write fDeliveryCompany;
    property TermOfDelivery: RawUTF8 read fTermOfDelivery write fTermOfDelivery;
    property PortName: RawUTF8 read fPortName write fPortName;
    property NetWeight: RawUTF8 read fNetWeight write fNetWeight;
    property GrossWeight: RawUTF8 read fGrossWeight write fGrossWeight;
    property Measurement: RawUTF8 read fMeasurement write fMeasurement;
    property CBM: RawUTF8 read fCBM write fCBM;
    property NumOfPkg: RawUTF8 read fNumOfPkg write fNumOfPkg;
    property DirectInputReqNo: RawUTF8 read fDirectInputReqNo write fDirectInputReqNo;
  end;

  function CreateModel_HiASMaterial: TSQLModel;
  procedure InitHiASMaterialClient(AExeName: string; ADBFileName: string='');
  procedure DestroyHiASMaterialClient();

  function GetMaterial4ProjFromTask(ATask: TOrmHiconisASTask): TSQLMaterial4Project;
  function GetMaterial4ProjFromTaskID(const ATaskID: TID): TSQLMaterial4Project;
  function GetMaterial4ProjFromTaskIDNPORNo(const ATaskID: TID; const APorNo: string): TSQLMaterial4Project;
  function GetMaterial4ProjFromShippingNo(const AShippingNo: RawUTF8): TSQLMaterial4Project;
  function GetTaskIDAryFromMaterial4ProjByShippingNo(const AShippingNo: RawUTF8): TpjhArray<TID>;

  procedure AddOrUpdateMaterial4Project(AMaterial4Project: TSQLMaterial4Project);

  procedure DeleteMaterial4ProjFromTask(ATask: TOrmHiconisASTask);
  procedure DeleteMaterial4ProjectFromIDNPorNo(const ATaskID: TID; const APorNo: string);

  procedure LoadMaterial4ProjectFromVariant(AMat4Proj: TSQLMaterial4Project;
    ADoc: variant);
  function SaveMaterial4Project2DBFromJson(ADoc: variant): Boolean;

var
  g_HiASMaterialDB: TSQLRestClientURI;
  HiASMaterialModel: TSQLModel;

implementation

uses UnitFolderUtil2, UnitHiconisASVarJsonUtil, UnitRttiUtil2, Forms;

function CreateModel_HiASMaterial: TSQLModel;
begin
  result := TSQLModel.Create([TSQLMaterial4Project]);
end;

procedure InitHiASMaterialClient(AExeName, ADBFileName: string);
var
  LStr, LFileName, LFilePath: string;
begin
  if Assigned(g_HiASMaterialDB) then
    exit;

  if AExeName = '' then
    AExeName := Application.ExeName;

  LStr := ExtractFileExt(AExeName);
  LFileName := ExtractFileName(AExeName);
  LFilePath := ExtractFilePath(AExeName);

  if LStr = '.exe' then
  begin
    LFileName := ChangeFileExt(ExtractFileName(AExeName),'.sqlite');
    LFileName := LFileName.Replace('.sqlite', '_Material.sqlite');
    LFilePath := GetSubFolderPath(LFilePath, 'db');
  end;

  LFilePath := EnsureDirectoryExists(LFilePath);

  if ADBFileName = '' then
    LStr := LFilePath + LFileName
  else
    LStr := ADBFileName;

  HiASMaterialModel:= CreateModel_HiASMaterial;

  g_HiASMaterialDB:= TSQLRestClientDB.Create(HiASMaterialModel, CreateModel_HiASMaterial,
    LStr, TSQLRestServerDB);
  TSQLRestClientDB(g_HiASMaterialDB).Server.CreateMissingTables;
end;

procedure DestroyHiASMaterialClient();
begin
  if Assigned(g_HiASMaterialDB) then
    FreeAndNil(g_HiASMaterialDB);

  if Assigned(HiASMaterialModel) then
    FreeAndNil(HiASMaterialModel);
end;

function GetMaterial4ProjFromTask(ATask: TOrmHiconisASTask): TSQLMaterial4Project;
begin
  Result := GetMaterial4ProjFromTaskID(ATask.ID);
end;

function GetMaterial4ProjFromTaskID(const ATaskID: TID): TSQLMaterial4Project;
begin
  Result := TSQLMaterial4Project.CreateAndFillPrepare(g_HiASMaterialDB.orm, 'TaskID = ?', [ATaskID]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetMaterial4ProjFromTaskIDNPORNo(const ATaskID: TID; const APorNo: string): TSQLMaterial4Project;
begin
  if ATaskID = 0 then
    Result := TSQLMaterial4Project.CreateAndFillPrepare(g_HiASMaterialDB.orm, 'PorNo = ?', [APorNo])
  else
    Result := TSQLMaterial4Project.CreateAndFillPrepare(g_HiASMaterialDB.orm, 'TaskID = ? AND PorNo = ?', [ATaskID, APorNo]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetMaterial4ProjFromShippingNo(const AShippingNo: RawUTF8): TSQLMaterial4Project;
begin
  Result := TSQLMaterial4Project.CreateAndFillPrepare(g_HiASMaterialDB.orm, 'ShippingNo LIKE ?', ['%'+AShippingNo+'%']);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetTaskIDAryFromMaterial4ProjByShippingNo(const AShippingNo: RawUTF8): TpjhArray<TID>;
var
  LOrm: TSQLMaterial4Project;
begin
  Result := Default(TpjhArray<TID>);

  LOrm := GetMaterial4ProjFromShippingNo(AShippingNo);
  try
    if LOrm.IsUpdate then
    begin
      if LOrm.FillRewind then
      begin
        while LOrm.FillOne do
        begin
          Result.Append(LOrm.TaskID);
        end;//while
      end;
    end;
  finally
    LOrm.Free;
  end;
end;

procedure DeleteMaterial4ProjFromTask(ATask: TOrmHiconisASTask);
var
  LSQLMaterial4Project: TSQLMaterial4Project;
begin
  LSQLMaterial4Project := GetMaterial4ProjFromTask(ATask);
  try
    g_HiASMaterialDB.Delete(TSQLMaterial4Project, LSQLMaterial4Project.ID);
  finally
    FreeAndNil(LSQLMaterial4Project);
  end;
end;

procedure DeleteMaterial4ProjectFromIDNPorNo(const ATaskID: TID; const APorNo: string);
var
  LSQLMaterial4Project: TSQLMaterial4Project;
begin
  LSQLMaterial4Project := GetMaterial4ProjFromTaskIDNPORNo(ATaskID, APorNo);
  try
    if LSQLMaterial4Project.FillOne then
      g_HiASMaterialDB.Delete(TSQLMaterial4Project, LSQLMaterial4Project.ID);
  finally
    FreeAndNil(LSQLMaterial4Project);
  end;
end;

procedure AddOrUpdateMaterial4Project(
  AMaterial4Project: TSQLMaterial4Project);
begin
  if AMaterial4Project.IsUpdate then
  begin
    g_HiASMaterialDB.Update(AMaterial4Project);
//    ShowMessage('자재 Update 완료');
  end
  else
  begin
    g_HiASMaterialDB.Add(AMaterial4Project, true);
//    ShowMessage('자재 Add 완료');
  end;
end;

procedure LoadMaterial4ProjectFromVariant(AMat4Proj: TSQLMaterial4Project; ADoc: variant);
begin
  if ADoc = null then
    exit;

  LoadRecordPropertyFromVariant(AMat4Proj, ADoc);

//  AMat4Proj.PORNo :=ADoc.PORNo;
//  AMat4Proj.SupplyCount :=ADoc.SupplyCount;
//  AMat4Proj.PORIssueDate :=ADoc.PORIssueDate;
//  AMat4Proj.DeliveryAddress :=ADoc.DeliveryAddress;
//  AMat4Proj.AirWayBill :=ADoc.AirWayBill;
//  AMat4Proj.DeliveryCharge :=ADoc.DeliveryCharge;
//  AMat4Proj.DeliveryCompany :=ADoc.DeliveryCompany;
end;

function SaveMaterial4Project2DBFromJson(ADoc: variant): Boolean;
var
  LMat4Proj: TSQLMaterial4Project;
begin
  LMat4Proj := GetMaterial4ProjFromTaskID(ADoc.TaskID);
  try
    LoadMaterial4ProjectFromVariant(LMat4Proj, ADoc);
    AddOrUpdateMaterial4Project(LMat4Proj);
  finally
    LMat4Proj.Free;
  end;
end;

initialization
finalization
  DestroyHiASMaterialClient();

end.
