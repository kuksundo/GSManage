unit UnitHiASSubConRecord;

interface

uses SysUtils, Classes, Generics.Collections,
  mormot.core.base, mormot.orm.core, mormot.rest.client, mormot.core.os,
  mormot.rest.sqlite3, mormot.orm.base, mormot.core.data, mormot.core.variants,
  mormot.core.datetime, mormot.core.json,

  UnitHiconisMasterRecord, CommonData2
  ;

type
  TSQLSubCon = class(TSQLCompany)
  private
//    fSubConID: TID;
    fUniqueSubConID,
    fSubConQuotePrice, //협력사 견적 금액
    fSubConInvoicePrice, //협력사 청구 금액
    fSubConInvoiceNo, //협력사 InvoiceNo
    fServicePO,
    fSubConSEList, //파견 엔지니어 명단(';'으로 복수 가능)
    fSubConExchangeRate //환율
    : RawUTF8;
    fSubConSECount: integer; //파견 엔지니어 수
    fSubConCurrencyKind: integer;//TCurrencyKind; //청구 화폐 종류

    fInvoiceItems,
    fInvoiceFiles: variant; //TRawUtf8DynArray를 사용하여 저장함

    FSubConInvoiceIssueDate,
    FSubConWorkBeginDate,
    FSubConWorkEndDate,
    FSRRecvDate
    : TTimeLog;
  public
    property InvoiceItems: variant read fInvoiceItems write fInvoiceItems;
    property InvoiceFiles: variant read fInvoiceFiles write fInvoiceFiles;
  published
//    property SubConID: TID read fSubConID write fSubConID;
    property UniqueSubConID: RawUTF8 read fUniqueSubConID write fUniqueSubConID;
    property ServicePO: RawUTF8 read fServicePO write fServicePO;
    property SubConQuotePrice: RawUTF8 read fSubConQuotePrice write fSubConQuotePrice;
    property SubConInvoicePrice: RawUTF8 read fSubConInvoicePrice write fSubConInvoicePrice;
    property SubConInvoiceNo: RawUTF8 read fSubConInvoiceNo write fSubConInvoiceNo;
    property SubConSEList: RawUTF8 read fSubConSEList write fSubConSEList;
    property SubConExchangeRate: RawUTF8 read fSubConExchangeRate write fSubConExchangeRate;
    property SubConCurrencyKind: integer read fSubConCurrencyKind write fSubConCurrencyKind;
    property SubConSECount: integer read fSubConSECount write fSubConSECount;

    property SRRecvDate: TTimeLog read FSRRecvDate write FSRRecvDate;
    property SubConInvoiceIssueDate: TTimeLog read FSubConInvoiceIssueDate write FSubConInvoiceIssueDate;
    property SubConWorkBeginDate: TTimeLog read FSubConWorkBeginDate write FSubConWorkBeginDate;
    property SubConWorkEndDate: TTimeLog read FSubConWorkEndDate write FSubConWorkEndDate;
  end;

  function CreateModel_HiASSubCon: TSQLModel;
  procedure InitHiASSubConClient(AExeName: string; ADBFileName: string='');
  procedure DestroyHiASSubConClient();

  procedure AddOrUpdateSubCon(AOrm: TSQLSubCon);
  procedure DeleteSubConFromTask(ATaskID: TID);

  function GetSubConFromTask(ATask: TOrmHiconisASTask): TSQLSubCon;
  function GetSubConFromTaskID(ATaskID: TID): TSQLSubCon;
  function GetSubConFromTaskIDNSubConID(ATaskID, ASubConID: TID): TSQLSubCon;
  //TaskID로 조회하면 복수개의 협력사(SubCon)이 조회 됨
  procedure GetSubConFromTaskIDWithInvoiceItems(ATaskID: TID; var ASubConList: TObjectList<TSQLSubCon>);
  function GetSubConFromTaskIDNSubConIDWithInvoiceItems(ATaskID, ASubConID: TID): TSQLSubCon;
  function GetSubConFromSubConID(ASubConID: TID): TSQLSubCon;
  function GetSubConFromUniqueSubConID(AUniqueSubConID: RawUTF8): TSQLSubCon;
  function GetSubConFromSubConIDWithInvoiceItems(ASubConID: TID): TSQLSubCon;
  function GetSubConFromUniqueSubConIDWithInvoiceItems(AUniqueSubConID: RawUTF8): TSQLSubCon;
  function GetSubConFromCompanyCode(ACode: string): TSQLSubCon;
  function CreateSubConFromVariant(ADoc: Variant): TSQLSubCon;
  //Remote에서 조회시 사용됨
  function CreateSubConFromVariant2(ADoc: Variant): TSQLSubCon;
  procedure LoadSubConFromVariant(ASubCon: TSQLSubCon; ADoc: variant;
    ADocIsFromInvoiceManage: Boolean);
  procedure LoadSubConFromVariant2(ASubCon: TSQLSubCon; ADoc: variant);

var
  g_HiASSubConDB: TSQLRestClientURI;
  HiASSubConModel: TSQLModel;

implementation

uses UnitFolderUtil2, UnitHiconisASVarJsonUtil, Forms;

function CreateModel_HiASSubCon: TSQLModel;
begin
  result := TSQLModel.Create([TSQLSubCon]);
end;

procedure InitHiASSubConClient(AExeName, ADBFileName: string);
var
  LStr, LFileName, LFilePath: string;
begin
  if Assigned(g_HiASSubConDB) then
    exit;

  if AExeName = '' then
    AExeName := Application.ExeName;

  LStr := ExtractFileExt(AExeName);
  LFileName := ExtractFileName(AExeName);
  LFilePath := ExtractFilePath(AExeName);

  if LStr = '.exe' then
  begin
    LFileName := ChangeFileExt(ExtractFileName(AExeName),'.sqlite');
    LFileName := LFileName.Replace('.sqlite', '_SubCon.sqlite');
    LFilePath := GetSubFolderPath(LFilePath, 'db');
  end;

  LFilePath := EnsureDirectoryExists(LFilePath);

  if ADBFileName = '' then
    LStr := LFilePath + LFileName
  else
    LStr := ADBFileName;

  HiASSubConModel:= CreateModel_HiASSubCon;

  g_HiASSubConDB:= TSQLRestClientDB.Create(HiASSubConModel, CreateModel_HiASSubCon,
    LStr, TSQLRestServerDB);
  TSQLRestClientDB(g_HiASSubConDB).Server.CreateMissingTables;
end;

procedure DestroyHiASSubConClient();
begin
  if Assigned(g_HiASSubConDB) then
    FreeAndNil(g_HiASSubConDB);

  if Assigned(HiASSubConModel) then
    FreeAndNil(HiASSubConModel);
end;

procedure AddOrUpdateSubCon(AOrm: TSQLSubCon);
begin
  if AOrm.IsUpdate then
  begin
    g_HiASSubConDB.Update(AOrm);
  end
  else
  begin
    g_HiASSubConDB.Add(AOrm, true);
  end;
end;

procedure DeleteSubConFromTask(ATaskID: TID);
begin
  g_HiASSubConDB.Delete(TSQLSubCon, 'TaskID = ?', [ATaskID]);
end;

function GetSubConFromTask(ATask: TOrmHiconisASTask): TSQLSubCon;
begin
  Result := TSQLSubCon.CreateAndFillPrepare(g_HiASSubConDB.orm, 'TaskID = ?', [ATask.ID]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetSubConFromSubConIDWithInvoiceItems(ASubConID: TID): TSQLSubCon;
var
  LSQLSubConInvoiceItem: TSQLSubConInvoiceItem;
  LSQLSubConInvoiceFile: TSQLSubConInvoiceFile;
begin
  //ASubConID는 협력사 CompanyCode가 아니며 TaskID와 연동되어 Unique함
  Result := GetSubConFromSubConID(ASubConID);

  if Result.IsUpdate then
  begin
    LSQLSubConInvoiceItem := GetSubConInvoiceItemFromSubConID(Result.ID);
    LSQLSubConInvoiceFile := GetSubConInvoiceFileFromSubConIDNItemID(Result.ID,1);
    Result.InvoiceItems := LSQLSubConInvoiceItem.GetJSONValues(true, true, soSelect);
    Result.InvoiceFiles := LSQLSubConInvoiceFile.GetJSONValues(true, true, soSelect);
  end
  else
  begin

  end
end;

function GetSubConFromUniqueSubConIDWithInvoiceItems(AUniqueSubConID: RawUTF8): TSQLSubCon;
var
  LSQLSubConInvoiceItem: TSQLSubConInvoiceItem;
  LSQLSubConInvoiceFile: TSQLSubConInvoiceFile;
begin
  Result := GetSubConFromUniqueSubConID(AUniqueSubConID);

  if Result.IsUpdate then
  begin
    LSQLSubConInvoiceItem := GetSubConInvoiceItemFromSubConID(Result.ID);
    LSQLSubConInvoiceFile := GetSubConInvoiceFileFromSubConIDNItemID(Result.ID,1);
    Result.InvoiceItems := LSQLSubConInvoiceItem.GetJSONValues(true, true, soSelect);
    Result.InvoiceFiles := LSQLSubConInvoiceFile.GetJSONValues(true, true, soSelect);
  end
  else
  begin

  end
end;

procedure GetSubConFromTaskIDWithInvoiceItems(ATaskID: TID; var ASubConList: TObjectList<TSQLSubCon>);
var
  LSQLSubConInvoiceItem: TSQLSubConInvoiceItem;
  LSQLSubConInvoiceFile: TSQLSubConInvoiceFile;
  LSQLSubCon, LSQLSubCon2: TSQLSubCon;
  LDynUtf8: TRawUTF8DynArray;
  LDynArr: TDynArray;
  LUtf8: RawUTF8;
  LDoc, LDoc2: Variant;
begin
  LSQLSubCon := GetSubConFromTaskID(ATaskID);
  try
    //기 존재 SubCon은 복수개일 가능성
    if LSQLSubCon.IsUpdate then
    begin
      TDocVariant.New(LDoc);
      TDocVariant.New(LDoc2);
      LSQLSubCon.FillRewind;

      while LSQLSubCon.FillOne do
      begin
        LSQLSubConInvoiceItem := GetSubConInvoiceItemFromUniqueSubConID(LSQLSubCon.UniqueSubConID);
        LSQLSubConInvoiceFile := GetSubConInvoiceFileFromUniqueSubConID(LSQLSubCon.UniqueSubConID);
        try
          if LSQLSubConInvoiceItem.IsUpdate then
            LoadSubConInvoiceItems2Variant(LSQLSubConInvoiceItem, LDoc);

          if LSQLSubConInvoiceFile.IsUpdate then
            LoadSubConInvoiceFiles2Variant(LSQLSubConInvoiceFile, LDoc2);

          if Assigned(ASubConList) then
          begin
            LSQLSubCon2 := TSQLSubCon(LSQLSubCon.CreateCopy);
            try
              LSQLSubCon2.InvoiceItems := LDoc;
              LSQLSubCon2.InvoiceFiles := LDoc2;
              ASubConList.Add(LSQLSubCon2);
            finally
//              LSQLSubCon2.Free; => ASubConList Free시에 자동 해제됨
            end;
          end;
        finally
          LSQLSubConInvoiceItem.Free;
          LSQLSubConInvoiceFile.Free;
        end;
      end;//while
    end
    else//신규일 경우 SubCon은 1개이며 InvoiceItems와 InvoiceFiles가 없음
    begin

    end;
  finally
    LSQLSubCon.Free;
  end;
end;

function GetSubConFromTaskIDNSubConIDWithInvoiceItems(ATaskID, ASubConID: TID): TSQLSubCon;
var
  LSQLSubConInvoiceItem: TSQLSubConInvoiceItem;
  LSQLSubConInvoiceFile: TSQLSubConInvoiceFile;
  LDynUtf8: TRawUTF8DynArray;
  LDynArr: TDynArray;
  LUtf8: RawUTF8;
  LDoc, LDoc2: Variant;
begin
  Result := GetSubConFromTaskIDNSubConID(ATaskID, ASubConID);

  if Result.IsUpdate then
  begin
    TDocVariant.New(LDoc);
    TDocVariant.New(LDoc2);
    LSQLSubConInvoiceItem := GetSubConInvoiceItemFromSubConID(Result.ID);
    LSQLSubConInvoiceFile := GetSubConInvoiceFileFromSubConIDNItemID(Result.ID,1);

    LoadSubConInvoiceItems2Variant(LSQLSubConInvoiceItem, LDoc);
    Result.InvoiceItems := LDoc;
    LoadSubConInvoiceFiles2Variant(LSQLSubConInvoiceFile, LDoc2);
    Result.InvoiceFiles := LDoc2;
  end
  else//신규일 경우
  begin

  end;
end;

function GetSubConFromTaskID(ATaskID: TID): TSQLSubCon;
begin
  Result := TSQLSubCon.CreateAndFillPrepare(g_HiASSubConDB.orm, 'TaskID = ?', [ATaskID]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetSubConFromTaskIDNSubConID(ATaskID, ASubConID: TID): TSQLSubCon;
begin
  Result := TSQLSubCon.CreateAndFillPrepare(g_HiASSubConDB.orm, 'TaskID = ? and ID = ?', [ATaskID, ASubConID]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetSubConFromSubConID(ASubConID: TID): TSQLSubCon;
begin
  Result := TSQLSubCon.CreateAndFillPrepare(g_HiASSubConDB.orm, 'ID = ?', [ASubConID]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetSubConFromUniqueSubConID(AUniqueSubConID: RawUTF8): TSQLSubCon;
begin
  Result := TSQLSubCon.CreateAndFillPrepare(g_HiASSubConDB.orm, 'UniqueSubConID = ?', [AUniqueSubConID]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetSubConFromCompanyCode(ACode: string): TSQLSubCon;
begin
  Result := TSQLSubCon.CreateAndFillPrepare(g_HiASSubConDB.orm, 'CompanyCode = ?', [ACode]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function CreateSubConFromVariant(ADoc: Variant): TSQLSubCon;
var
  LRawUtf8, LSubConCompanyCode: RawUTF8;
  LDoc: TDocVariantData;
begin
  if ADoc = null then
    exit;

//  LSubConCompanyCode := ADoc.Task.SubConCompanyCode;

  Result := TSQLSubCon.Create;

  Result.CompanyName := ADoc.Task.SubConCompanyName;
  Result.CompanyCode := ADoc.Task.SubConCompanyCode;
  Result.ManagerName := ADoc.Task.SubConManagerName;
  Result.EMail := ADoc.Task.SubConEMail;
  Result.CompanyAddress := ADoc.Task.SubConCompanyAddress;
  Result.OfficePhone := ADoc.Task.SubConOfficePhone;
  Result.MobilePhone := ADoc.Task.SubConMobilePhone;
  Result.Position := ADoc.Task.SubConPosition;
  Result.Nation := ADoc.Task.SubConPosition;
  Result.SubConSEList := ADoc.Task.SEList;

  Result.SubConInvoiceNo := ADoc.Task.SubConInvoiceNo;
  Result.UniqueSubConID := ADoc.Task.UniqueSubConID;
//  Result.ServicePO := ADoc.Task.SubConInvoiceNo;
  Result.SubConExchangeRate := ADoc.Task.ExchangeRate;
  Result.SubConInvoicePrice := ADoc.Task.InvoicePrice;
  Result.SubConInvoiceIssueDate := ADoc.Task.InvoiceIssueDate;
  Result.SubConWorkBeginDate := ADoc.Task.WorkBeginDate;
  Result.SubConWorkEndDate := ADoc.Task.WorkEndDate;
  LDoc.InitJSON(ADoc.InvoiceItem);
  Result.InvoiceItems := LDoc.ToJSON;// TRawUtf8DynArrayFrom(LRawUtf8);
//  LRawUtf8 := ADoc.InvoiceFile;
  LDoc.InitJSON(ADoc.InvoiceFile);
  Result.InvoiceFiles := LDoc.ToJSON;//TRawUtf8DynArrayFrom(LRawUtf8);

//  Result.SubConQuotePrice := ADoc.Task.InvoicePrice;
//  Result.SubConCurrencyKind := ADoc.Task.CurrencyKind;
//  Result.SubConSECount: integer read fSubConSECount write fSubConSECount;
//  Result.SRRecvDate: TTimeLog read FSRRecvDate write FSRRecvDate;
end;

function CreateSubConFromVariant2(ADoc: Variant): TSQLSubCon;
begin
  if ADoc = null then
    exit;

  Result := TSQLSubCon.Create;

  Result.TaskID := ADoc.TaskID;
  Result.FirstName := ADoc.FirstName;
  Result.Surname := ADoc.Surname;
  Result.CompanyName := ADoc.CompanyName;
  Result.CompanyName2 := ADoc.CompanyName2;
  Result.CompanyCode := ADoc.CompanyCode;
  Result.ManagerName := ADoc.ManagerName;
  Result.EMail := ADoc.EMail;
  Result.CompanyAddress := ADoc.CompanyAddress;
  Result.OfficePhone := ADoc.OfficePhone;
  Result.MobilePhone := ADoc.MobilePhone;
  Result.Position := ADoc.Position;
  Result.Nation := ADoc.Position;
  Result.City := ADoc.City;
  Result.Notes := ADoc.Notes;
  Result.CompanyTypes := IntToTCompanyType_Set(ADoc.CompanyTypes);
  Result.BusinessAreas := IntToTBusinessArea_Set(ADoc.BusinessAreas);

  Result.SubConInvoiceNo := ADoc.SubConInvoiceNo;
//  Result.SubConID := ADoc.SubConID;
  Result.UniqueSubConID := ADoc.UniqueSubConID;
  Result.ServicePO := ADoc.ServicePO;
  Result.SubConQuotePrice := ADoc.SubConQuotePrice;
  Result.SubConSEList := ADoc.SubConSEList;
  Result.SubConCurrencyKind := ADoc.SubConCurrencyKind;
  Result.SubConSECount := ADoc.SubConSECount;
  Result.SRRecvDate := ADoc.SRRecvDate;
  Result.SubConExchangeRate := ADoc.SubConExchangeRate;
  Result.SubConInvoicePrice := ADoc.SubConInvoicePrice;
  Result.SubConInvoiceIssueDate := ADoc.SubConInvoiceIssueDate;
  Result.SubConWorkBeginDate := ADoc.SubConWorkBeginDate;
  Result.SubConWorkEndDate := ADoc.SubConWorkEndDate;

  if ADoc.InvoiceItems <> null then
    Result.InvoiceItems := _JSON(ADoc.InvoiceItems);

  if ADoc.InvoiceFiles <> null then
    Result.InvoiceFiles := _JSON(ADoc.InvoiceFiles);
end;

procedure LoadSubConFromVariant(ASubCon: TSQLSubCon; ADoc: variant;
  ADocIsFromInvoiceManage: Boolean);
var
//  LRawUtf8Arr: TRawUtf8DynArray;
  LRawUtf8, LSubConCompanyCode: RawUTF8;
  LDocData: TDocVariantData;
  LVar: variant;
  i: integer;
begin
  if ADoc = null then
    exit;

  i := 0;

  if ADocIsFromInvoiceManage then
  begin
    LSubConCompanyCode := ADoc.Task.SubConCompanyCode;
//    lDocData.InitJSON(LRawUtf8);

//    LRawUtf8Arr := TRawUtf8DynArrayFrom(LRawUtf8);
    ASubCon.FillRewind;
    while ASubCon.FillOne do
    begin
      if ASubCon.CompanyCode = LSubConCompanyCode then
      begin
//        LVar := _JsonFast(LRawUtf8Arr[i]);
        ASubCon.ServicePO := ADoc.Task.SubConInvoiceNo;
//        ASubCon.SubConSECount := ADoc.Task.
        ASubCon.SubConExchangeRate := ADoc.Task.ExchangeRate;
        ASubCon.SubConInvoicePrice := ADoc.Task.InvoicePrice;
        ASubCon.SubConInvoiceIssueDate := ADoc.Task.InvoiceIssueDate;//TimeLogFromDateTime(StrToDateTime(
        ASubCon.SubConWorkBeginDate := ADoc.Task.WorkBeginDate;//TimeLogFromDateTime(StrToDateTime(
        ASubCon.SubConWorkEndDate := ADoc.Task.WorkEndDate;//TimeLogFromDateTime(StrToDateTime(
        LRawUtf8 := ADoc.InvoiceItem;
        ASubCon.InvoiceItems := LRawUtf8;//TRawUtf8DynArrayFrom(
        LRawUtf8 := ADoc.InvoiceFile;
        ASubCon.InvoiceFiles := LRawUtf8;//TRawUtf8DynArrayFrom(
        break;
      end;
    end;
  end
  else//이 경우 ADoc = 1개 레코드임
  begin
//    LDocData.InitJSON(ADoc);
//    for i := 0 to LDocData.Count - 1 do
//    begin
      LVar := _JSON(ADoc);//LDocData.Value[i]);
      LoadSubConFromVariant2(ASubCon, LVar);
//      Break;
//    end;
  end;
end;

procedure LoadSubConFromVariant2(ASubCon: TSQLSubCon; ADoc: variant);
begin
  ASubCon.Action := ADoc.Action;
  ASubCon.TaskID := ADoc.TaskID;
  ASubCon.FirstName := ADoc.FirstName;
  ASubCon.Surname := ADoc.Surname;
  ASubCon.CompanyCode := ADoc.CompanyCode;
  ASubCon.EMail := ADoc.EMail;
  ASubCon.CompanyName := ADoc.CompanyName;
  ASubCon.MobilePhone := ADoc.MobilePhone;
  ASubCon.OfficePhone := ADoc.OfficePhone;
  ASubCon.CompanyAddress := ADoc.CompanyAddress;
  ASubCon.Position := ADoc.Position;
  ASubCon.ManagerName := ADoc.ManagerName;
  ASubCon.Nation := ADoc.Nation;
  ASubCon.CompanyTypes := IntToTCompanyType_Set(ADoc.CompanyTypes);
  ASubCon.UniqueSubConID := ADoc.UniqueSubConID;
  ASubCon.InvoiceItems := ADoc.InvoiceItems;
  ASubCon.InvoiceFiles := ADoc.InvoiceFiles;
end;

initialization
finalization
  DestroyHiASSubConClient();
end.
