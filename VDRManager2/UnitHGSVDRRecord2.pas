unit UnitHGSVDRRecord2;

interface

uses
  Classes,
  mormot.core.base, mormot.core.datetime, mormot.orm.core, mormot.rest.sqlite3,
  mormot.core.variants, mormot.core.data, mormot.core.json,
  UnitHGSVDRData, UnitVesselData2, UnitJHPFileData;

type
  TVDRSearchParamRec = record
    fIMONo,
    fShipName,
    fHullNo,
    fProjectNo,
    fVDRSerialNo,
    fMainBoard,
    fVideo,
    fHDD,
    fHINEI,
    fVDRType,
    fVCSType,
    fVDRConfig,
    fCapsuleType,
    fReplacedModel
    : RawUTF8;
    FFrom, FTo: TDateTime;
  end;

  TSQLHGSVDRRecord = class(TSQLRecord)
  private
    fIMONo,
    fHullNo,
    fShipName,
    fProjectNo,
    fVDRSerialNo,
    fMainBoard,
    fVideo,
    fHDD,
    fHINEI,
    fRemark,
    fVDRType,
    fVCSType,
    fCapsuleType,
    fVDRConfig,
    fReplacedModel
    : RawUTF8;

    fAttachments: TSQLGSFileRecs;
    fFileCount: integer;

    fIsIMO: Boolean;
    fDeliveryDate: TTimeLog;
    fUpdateDate: TTimeLog;
  public
    FIsUpdate: Boolean;
    property IsUpdate: Boolean read FIsUpdate write FIsUpdate;
  published
    property IMONo: RawUTF8 read fIMONo write fIMONo;
    property HullNo: RawUTF8 read fHullNo write fHullNo;
    property ShipName: RawUTF8 read fShipName write fShipName;
    property ProjectNo: RawUTF8 read fProjectNo write fProjectNo;
    property VDRSerialNo: RawUTF8 read fVDRSerialNo write fVDRSerialNo;
    property MainBoard: RawUTF8 read fMainBoard write fMainBoard;
    property Video: RawUTF8 read fVideo write fVideo;
    property HDD: RawUTF8 read fHDD write fHDD;
    property HINEI: RawUTF8 read fHINEI write fHINEI;
    property VDRType: RawUTF8 read fVDRType write fVDRType;
    property Remark: RawUTF8 read fRemark write fRemark;
    property VCSType: RawUTF8 read fVCSType write fVCSType;
    property CapsuleType: RawUTF8 read fCapsuleType write fCapsuleType;
    property VDRConfig: RawUTF8 read fVDRConfig write fVDRConfig;
    property IsIMO: Boolean read fIsIMO write fIsIMO;
    property DeliveryDate: TTimeLog read fDeliveryDate write fDeliveryDate;
    property UpdateDate: TTimeLog read fUpdateDate write fUpdateDate;
    property FileCount: integer read fFileCount write fFileCount;
    property Attachments: TSQLGSFileRecs read fAttachments write fAttachments;
    property ReplacedModel: RawUTF8 read fReplacedModel write fReplacedModel;
  end;

procedure InitHGSVDRClient(AHGSVDRVDRDBName: string = '');
function CreateHGSVDRModel: TSQLModel;
procedure DestroyHGSVDR;

function GetHGSVDRRecordFromSearchRec(AVDRSearchParamRec: TVDRSearchParamRec): TSQLHGSVDRRecord;
function GetVariantFromHGSVDRRecord(ASQLHGSVDRRecord:TSQLHGSVDRRecord): variant;
function GetHGSVDRFromIMONo(const AIMONo: string): TSQLHGSVDRRecord;
function GetHGSVDRFromHullNo(const AHullNo: string): TSQLHGSVDRRecord;

procedure AddOrUpdateHGSVDR(ASQLHGSVDRRecord: TSQLHGSVDRRecord);
function AddOrUpdateHGSVDRFromVariant(ADoc: variant; AIsOnlyAdd: Boolean = False): integer;
procedure LoadHGSVDRFromVariant(ASQLHGSVDRRecord: TSQLHGSVDRRecord; ADoc: variant);
procedure UpdateHGSVDRAttachments(AImoNo, AGSFileRecsJson: string);
procedure DeleteHGSVDR(const AIMONo: string);

var
  g_HGSVDRDB: TRestClientDB;
  HGSVDRModel: TSQLModel;

implementation

uses SysUtils, Forms, VarRecUtils, Vcl.Dialogs, UnitStringUtil,
  UnitFolderUtil2, UnitRttiUtil2;

procedure InitHGSVDRClient(AHGSVDRVDRDBName: string = '');
var
  LStr: string;
begin
  if AHGSVDRVDRDBName = '' then
    AHGSVDRVDRDBName := ChangeFileExt(ExtractFilePath(Application.ExeName),'.sqlite');

  LStr := GetSubFolderPath(ExtractFilePath(Application.ExeName), 'db');
  LStr := LStr + AHGSVDRVDRDBName;
  HGSVDRModel:= CreateHGSVDRModel;
  g_HGSVDRDB:= TSQLRestClientDB.Create(HGSVDRModel, CreateHGSVDRModel,
    LStr, TSQLRestServerDB);
  TSQLRestClientDB(g_HGSVDRDB).Server.CreateMissingTables;
end;

function CreateHGSVDRModel: TSQLModel;
begin
  result := TSQLModel.Create([TSQLHGSVDRRecord]);
end;

procedure DestroyHGSVDR;
begin
  if Assigned(HGSVDRModel) then
    FreeAndNil(HGSVDRModel);

  if Assigned(g_HGSVDRDB) then
    FreeAndNil(g_HGSVDRDB);
end;

function GetHGSVDRRecordFromSearchRec(
  AVDRSearchParamRec: TVDRSearchParamRec): TSQLHGSVDRRecord;
var
  ConstArray: TConstArray;
  LWhere, LStr: string;
  LFrom, LTo: TTimeLog;
begin
  LWhere := '';
  ConstArray := CreateConstArray([]);
  try
    if AVDRSearchParamRec.FFrom < AVDRSearchParamRec.FTo then
    begin
      LFrom := TimeLogFromDateTime(AVDRSearchParamRec.FFrom);
      LTo := TimeLogFromDateTime(AVDRSearchParamRec.FTo);

      LWhere := 'DeliveryDate >= ? and DeliveryDate <= ? ';
      if LWhere <> '' then
        AddConstArray(ConstArray, [LFrom, LTo]);
    end;

    if AVDRSearchParamRec.fIMONo <> '' then
    begin
      AddConstArray(ConstArray, ['%'+AVDRSearchParamRec.fIMONo+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'IMONo LIKE ? ';
    end;

    if AVDRSearchParamRec.fHullNo <> '' then
    begin
      AddConstArray(ConstArray, ['%'+AVDRSearchParamRec.fHullNo+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'HullNo LIKE ? ';
    end;

    if AVDRSearchParamRec.fShipName <> '' then
    begin
      AddConstArray(ConstArray, ['%'+AVDRSearchParamRec.fShipName+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'ShipName LIKE ? ';
    end;

    if AVDRSearchParamRec.fProjectNo <> '' then
    begin
      AddConstArray(ConstArray, ['%'+AVDRSearchParamRec.fProjectNo+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'ProjectNo LIKE ? ';
    end;

    if AVDRSearchParamRec.fVDRSerialNo <> '' then
    begin
      AddConstArray(ConstArray, ['%'+AVDRSearchParamRec.fVDRSerialNo+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'VDRSerialNo LIKE ? ';
    end;

    if AVDRSearchParamRec.fVDRType <> '' then
    begin
      AddConstArray(ConstArray, ['%'+AVDRSearchParamRec.fVDRType+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'VDRType LIKE ? ';
    end;

    if AVDRSearchParamRec.fMainBoard <> '' then
    begin
      AddConstArray(ConstArray, ['%'+AVDRSearchParamRec.fMainBoard+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'MainBoard LIKE ? ';
    end;

    if AVDRSearchParamRec.fVideo <> '' then
    begin
      AddConstArray(ConstArray, ['%'+AVDRSearchParamRec.fVideo+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'Video LIKE ? ';
    end;

    if AVDRSearchParamRec.fHDD <> '' then
    begin
      AddConstArray(ConstArray, ['%'+AVDRSearchParamRec.fHDD+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'HDD LIKE ? ';
    end;

    if AVDRSearchParamRec.fHINEI <> '' then
    begin
      AddConstArray(ConstArray, ['%'+AVDRSearchParamRec.fHINEI+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'HINEI LIKE ? ';
    end;

    if AVDRSearchParamRec.fVDRType <> '' then
    begin
      AddConstArray(ConstArray, ['%'+AVDRSearchParamRec.fVDRType+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'VDRType LIKE ? ';
    end;

    if AVDRSearchParamRec.fVCSType <> '' then
    begin
      AddConstArray(ConstArray, ['%'+AVDRSearchParamRec.fVCSType+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'VCSType LIKE ? ';
    end;

    if AVDRSearchParamRec.fCapsuleType <> '' then
    begin
      AddConstArray(ConstArray, ['%'+AVDRSearchParamRec.fCapsuleType+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'CapsuleType LIKE ? ';
    end;

    if LWhere = '' then
    begin
      AddConstArray(ConstArray, [-1]);
      LWhere := 'ID <> ? ';
    end;

    Result := TSQLHGSVDRRecord.CreateAndFillPrepare(g_HGSVDRDB.Orm, Lwhere, ConstArray);

    if Result.FillOne then
    begin
//      Result.FillRewind;
      Result.IsUpdate := True;
    end;
  finally
    FinalizeConstArray(ConstArray);
  end;
end;

function GetVariantFromHGSVDRRecord(ASQLHGSVDRRecord:TSQLHGSVDRRecord): variant;
begin
  TDocVariant.New(Result);
  LoadRecordPropertyToVariant(ASQLHGSVDRRecord, Result);
end;

function GetHGSVDRFromIMONo(const AIMONo: string): TSQLHGSVDRRecord;
var
  LVDRRec: TVDRSearchParamRec;
begin
  LVDRRec := Default(TVDRSearchParamRec);
  LVDRRec.fIMONo := AIMONo;

  Result := GetHGSVDRRecordFromSearchRec(LVDRRec);
end;

function GetHGSVDRFromHullNo(const AHullNo: string): TSQLHGSVDRRecord;
var
  LVDRRec: TVDRSearchParamRec;
begin
  LVDRRec := Default(TVDRSearchParamRec);
  LVDRRec.fHullNo := AHullNo;

  Result := GetHGSVDRRecordFromSearchRec(LVDRRec);
end;

procedure AddOrUpdateHGSVDR(ASQLHGSVDRRecord: TSQLHGSVDRRecord);
begin
  if ASQLHGSVDRRecord.IsUpdate then
  begin
    g_HGSVDRDB.Update(ASQLHGSVDRRecord);
  end
  else
  begin
    g_HGSVDRDB.Add(ASQLHGSVDRRecord, true);
  end;
end;

function AddOrUpdateHGSVDRFromVariant(ADoc: variant; AIsOnlyAdd: Boolean = False): integer;
var
  LSQLHGSVDRRecord: TSQLHGSVDRRecord;
  LIsUpdate: Boolean;
begin
  if ADoc.IMONo <> '' then
    LSQLHGSVDRRecord := GetHGSVDRFromIMONo(ADoc.IMONo)
  else
  if ADoc.HullNo <> '' then
    LSQLHGSVDRRecord := GetHGSVDRFromHullNo(ADoc.HullNo);

  LIsUpdate := LSQLHGSVDRRecord.IsUpdate;
  try
    if AIsOnlyAdd then
    begin
      if not LSQLHGSVDRRecord.IsUpdate then
      begin
        LoadHGSVDRFromVariant(LSQLHGSVDRRecord, ADoc);
        LSQLHGSVDRRecord.IsUpdate := LIsUpdate;

        AddOrUpdateHGSVDR(LSQLHGSVDRRecord);
        Inc(Result);
      end;
    end
    else
    begin
      if LSQLHGSVDRRecord.IsUpdate then
        Inc(Result);

      LoadHGSVDRFromVariant(LSQLHGSVDRRecord, ADoc);
      LSQLHGSVDRRecord.IsUpdate := LIsUpdate;

      AddOrUpdateHGSVDR(LSQLHGSVDRRecord);
    end;
  finally
    FreeAndNil(LSQLHGSVDRRecord);
  end;
end;

procedure LoadHGSVDRFromVariant(ASQLHGSVDRRecord: TSQLHGSVDRRecord; ADoc: variant);
begin
  if ADoc = null then
    exit;

  LoadRecordPropertyFromVariant(ASQLHGSVDRRecord, ADoc);
end;

procedure UpdateHGSVDRAttachments(AImoNo, AGSFileRecsJson: string);
var
  LSQLHGSVDRRecord: TSQLHGSVDRRecord;
  LSQLGSFileRec: TSQLGSFileRec;
  LSQLGSFileRecs: TSQLGSFileRecs;
  LDocData: TDocVariantData;
  LVar: variant;
  LUtf8: RawUTF8;
  i: integer;
  LDynArr: TDynArray;
begin
  LSQLHGSVDRRecord := GetHGSVDRFromIMONo(AImoNo);

  if LSQLHGSVDRRecord.IsUpdate then
  begin
    //AGSFileRecsJson = [] 형식의 배열 임
    LDocData.InitJSON(AGSFileRecsJson);
    for i := 0 to LDocData.Count - 1 do
    begin
      LVar := _JSON(LDocData.Value[i]);
      LUtf8 := LVar;
      RecordLoadJson(LSQLGSFileRec, LUtf8, TypeInfo(TJHPFileRec));
      if (LSQLGSFileRec.fFilename <> '') and (LSQLGSFileRec.fData <> '') then
      begin
        LDynArr.Init(TypeInfo(TJHPFileRecs), LSQLGSFileRecs);
        LDynArr.Add(LSQLGSFileRec);
      end;
    end;

//    BinToBase64WithMagic(DynArraySave());
    LSQLHGSVDRRecord.Attachments := LSQLGSFileRecs;
//    g_HGSVDRDB.UpdateField(TSQLHGSVDRRecord, LSQLHGSVDRRecord.ID, 'Attachments', LSQLGSFileRecs);
    g_HGSVDRDB.Update(LSQLHGSVDRRecord);
  end;
end;

procedure DeleteHGSVDR(const AIMONo: string);
var
  LVDRRecord: TSQLHGSVDRRecord;
begin
  LVDRRecord := GetHGSVDRFromIMONo(AIMONo);
  try
    if LVDRRecord.IsUpdate then
      g_HGSVDRDB.Delete(TSQLHGSVDRRecord, LVDRRecord.ID);
  finally
    LVDRRecord.Free;
  end;
end;

initialization

finalization
  DestroyHGSVDR;

end.
