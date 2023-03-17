unit UnitHGSCertRecord2;
{
  *) 필드 추가 시 수정 내용
  1. FrmCertEdit.pas Form에 추가된 필드용 컴포넌트 추가
  2. TCertSearchParamRec에 검색 필드 추가
  3. UnitHGSCertRecord.pas의 GetHGSCertRecordFromSearchRec()에 검색 루틴 추가
  4. FrmCertManage.pas의 CertListGrid에 필드 추가
  5. FrmCertManage.pas의 GetCertSearchParam2Rec()에 값 할당 추가
  6. FrmCertManage.pas의 GetCertListFromVariant2Grid()에 값 할당 추가
  7. FrmCertEdit.pas의 GetCertDetailFromCertRecord()에 값 할당 추가
  8. FrmCertEdit.pas의 LoadCertDetail2CertRecordFromForm()에 값 할당 추가
}
interface

uses
  Classes,
  mormot.core.base, mormot.core.variants, mormot.core.datetime, mormot.orm.core,
  mormot.orm.base, mormot.rest.sqlite3,
  UnitCertManager2, UnitVesselData2, UnitHGSCertData, UnitHGSCurriculumData,
  UnitHGSVDRData, UnitJHPFileData;

type
  TSQLHGSCertBasic = class(TSQLRecord)
  private
    fCertNo,
    fPrevCertNo,
    fCompanyName,
    fCompanyName2, //회사 이름 약어
    fCompanyCode,
    fCompanyNatoin,
    fInvoiceCompanyName,
    fInvoiceCompanyCode,
    fInvoiceCompanyNatoin,
    fInvoiceEmail,
    fOrderNo,
    fSalesAmount,
    fCertFileDBPath,
    fCertFileDBName,
    fProjectNo,
    fNotes
    : RawUTF8;

    fFileCount: integer;
    fQRCodeImage: TSQLRawBlob;//Cert 정보를 암호화 하여 저장함
    fPhoto: TSQLRawBlob;//사진 저장함
    fIsCryptSerial,           //시리얼 번호 암호화 여부
    fIsIgnoreInvoice: Boolean;//Invoice 발행 건 아님
    fProductType: TShipProductType;
    fCertType: THGSCertType; //유무상 구분 가능

    fUntilValidity,
    fIssueDate,
    fInvoiceIssueDate,
    fInvoiceConfirmDate,
    fBillPaidDate,
    fUpdateDate: TTimeLog;
  public
    FIsUpdate: Boolean;
    fNextSerialNo: RawUTF8;
    property IsUpdate: Boolean read FIsUpdate write FIsUpdate;
    property NextSerialNo: RawUTF8 read fNextSerialNo write fNextSerialNo;
  published
    property CertNo: RawUTF8 read fCertNo write fCertNo stored AS_UNIQUE;
    property PrevCertNo: RawUTF8 read fPrevCertNo write fPrevCertNo;
    property ProjectNo: RawUTF8 read fProjectNo write fProjectNo;

    property CompanyName: RawUTF8 read fCompanyName write fCompanyName;
    property CompanyName2: RawUTF8 read fCompanyName2 write fCompanyName2;
    property CompanyCode: RawUTF8 read fCompanyCode write fCompanyCode;
    property CompanyNatoin: RawUTF8 read fCompanyNatoin write fCompanyNatoin;
    property InvoiceCompanyName: RawUTF8 read fInvoiceCompanyName write fInvoiceCompanyName;
    property InvoiceCompanyCode: RawUTF8 read fInvoiceCompanyCode write fInvoiceCompanyCode;
    property InvoiceCompanyNatoin: RawUTF8 read fInvoiceCompanyNatoin write fInvoiceCompanyNatoin;
    property InvoiceEmail: RawUTF8 read fInvoiceEmail write fInvoiceEmail;
    property OrderNo: RawUTF8 read fOrderNo write fOrderNo;
    property SalesAmount: RawUTF8 read fSalesAmount write fSalesAmount;
    property CertFileDBPath: RawUTF8 read fCertFileDBPath write fCertFileDBPath;
    property CertFileDBName: RawUTF8 read fCertFileDBName write fCertFileDBName;
    property IsCryptSerial: Boolean read fIsCryptSerial write fIsCryptSerial;
    property IsIgnoreInvoice: Boolean read fIsIgnoreInvoice write fIsIgnoreInvoice;
    property ProductType: TShipProductType read fProductType write fProductType;
    property CertType: THGSCertType read fCertType write fCertType;
    property UntilValidity: TTimeLog read fUntilValidity write fUntilValidity;
    property IssueDate: TTimeLog read fIssueDate write fIssueDate;
    property InvoiceIssueDate: TTimeLog read fInvoiceIssueDate write fInvoiceIssueDate;
    property InvoiceConfirmDate: TTimeLog read fInvoiceConfirmDate write fInvoiceConfirmDate;
    property BillPaidDate: TTimeLog read fBillPaidDate write fBillPaidDate;
    property UpdateDate: TTimeLog read fUpdateDate write fUpdateDate;
    property QRCodeImage: TSQLRawBlob read fQRCodeImage write fQRCodeImage;
    property FileCount: integer read fFileCount write fFileCount;
    property Notes: RawUTF8 read fNotes write fNotes;
  end;

  TOrmHGSTrainCert = class(TSQLHGSCertBasic)
    //Education
    fTraineeName,
    fTraineeNation,
    fTrainedSubject,
    fTrainedCourse
    : RawUTF8;
    fCourseLevel: TAcademyCourseLevel;
    fTrainedBeginDate,
    fTrainedEndDate
    :TTimeLog;

    fMailCount: integer;
    FImageData: RawBlob;//교육생 사진
  published
    property TraineeName: RawUTF8 read fTraineeName write fTraineeName;
    property TraineeNation: RawUTF8 read fTraineeNation write fTraineeNation;
    property TrainedSubject: RawUTF8 read fTrainedSubject write fTrainedSubject;
    property TrainedCourse: RawUTF8 read fTrainedCourse write fTrainedCourse;
    property CourseLevel: TAcademyCourseLevel read fCourseLevel write fCourseLevel;
    property TrainedBeginDate: TTimeLog read fTrainedBeginDate write fTrainedBeginDate;
    property TrainedEndDate: TTimeLog read fTrainedEndDate write fTrainedEndDate;
  end;

  TSQLHGSCertRecord = class(TOrmHGSTrainCert)
  private
    //APT Service
    fReportNo,
    fPlaceOfSurvey,
    fVDRType,
    fVDRSerialNo,
    fClassSociety,
    fOwnerName,
    fShipName,
    fIMONo,
    fHullNo,
    fPICEmail,
    fPICPhone
    : RawUTF8;
    fAPTResult: TVDRAPTResult;  //APT 수행 성공 여부 : 취소 될 경우가 있음

    fAPTServiceDate
    : TTimeLog;
  published
    property ReportNo: RawUTF8 read fReportNo write fReportNo;
    property PlaceOfSurvey: RawUTF8 read fPlaceOfSurvey write fPlaceOfSurvey;
    property VDRType: RawUTF8 read fVDRType write fVDRType;
    property VDRSerialNo: RawUTF8 read fVDRSerialNo write fVDRSerialNo;
    property ClassSociety: RawUTF8 read fClassSociety write fClassSociety;
    property OwnerName: RawUTF8 read fOwnerName write fOwnerName;
    property ShipName: RawUTF8 read fShipName write fShipName;
    property IMONo: RawUTF8 read fIMONo write fIMONo;
    property HullNo: RawUTF8 read fHullNo write fHullNo;
    property PICEmail: RawUTF8 read fPICEmail write fPICEmail;
    property PICPhone: RawUTF8 read fPICPhone write fPICPhone;
    property MailCount: integer read fMailCount write fMailCount;
    property APTServiceDate: TTimeLog read fAPTServiceDate write fAPTServiceDate;
    property APTResult: TVDRAPTResult read fAPTResult write fAPTResult;
    property ImageData: RawBlob read FImageData write FImageData;
  end;

  TSQLHGSCertFiles = class(TSQLRecord)
  private
    fTaskId  : TID;
    fGSDocType, //UnitHGSCertData.THGSCertDocType
    fFileCount: integer;
    fFiles: TJHPFileRecs;
    fUpdateDate: TTimeLog;
  public
    fIsUpdate: Boolean;
  published
    property TaskId: TID read fTaskId write fTaskId;
    property GSDocType: integer read fGSDocType write fGSDocType;
    property FileCount: integer read fFileCount write fFileCount;
    property Files: TJHPFileRecs read fFiles write fFiles;
    property UpdateDate: TTimeLog read fUpdateDate write fUpdateDate;
  end;

procedure InitHGSCertClient(AHGSCertDBName: string = '');
function CreateHGSCertModel: TSQLModel;
procedure DestroyHGSCertClient;

function GetDefaultDBName(const ACertNo: string): string;
function GetHGSCertFromCertNo(const ACertNo: string): TSQLHGSCertRecord;
function GetHGSCertFromReportNo(const AReportNo: string): TSQLHGSCertRecord;
function GetHGSCertFromIMONo(const AIMONo: string): TSQLHGSCertRecord;
function GetHGSCertFromHullNo(const AHullNo: string): TSQLHGSCertRecord;
function GetHGSCertFromShipName(const AShipName: string): TSQLHGSCertRecord;
function GetHGSCertFromPlaceOfSurvey(const APlaceOfSurvey: string): TSQLHGSCertRecord;
function GetVariantFromHGSCertRecord(AHGSCertRecord:TSQLHGSCertRecord): variant;
function GetHGSCertRecordFromSearchRec(ACertSearchParamRec: TCertSearchParamRec): TSQLHGSCertRecord;
function CheckIfExistHGSCertNo(const ACertNo: string): Boolean;
function GetImagePhotoFromHGSCertRecord(AImage: TStream; const AHGSCertRecord:TSQLHGSCertRecord): Boolean;

procedure AddOrUpdateHGSCert(ASQLHGSCertRecord: TSQLHGSCertRecord);
procedure AddOrUpdateHGSCertPhoto(const AImageData: RawBlob; ASQLHGSCertRecord: TSQLHGSCertRecord);
function AddOrUpdateHGSCertFromVariant(ADoc: variant; AIsOnlyAdd: Boolean = False): integer;
procedure LoadHGSCertFromVariant(ASQLHGSCertRecord: TSQLHGSCertRecord; ADoc: variant);
function UpdateInvoiceNoFromCertNo(AInvoiceNo, ACertNo: string): boolean;
function UpdateMailCountFromCertNo(ACertNo: string; AMailCount: integer): boolean;
function UpdateInvoiceIssueDateFromCertNo(ACertNo: string; AInvIssueDate: TDate): boolean;
function UpdateInvoiceConfirmDateFromCertNo(ACertNo: string; AInvConfirmDate: TDate): boolean;
function UpdatePaidBillDateFromCertNo(ACertNo: string; APaidBillDate: TDate): boolean;
function UpdateNoteFromCertNo(ANote, ACertNo: string): boolean;

procedure DeleteHGSCert(const ACertNo: string);

function GetGSFileRecsFromDocType(const ADocType: THGSCertDocType): TJHPFileRecs;
function GetHGSCertFilesFromDocType(const ADocType: THGSCertDocType;
  AHGSCertFilesDB: TRestClientDB = nil): TSQLHGSCertFiles;

var
  g_HGSCertDB: TRestClientDB;
  HGSCertModel: TSQLModel;

implementation

uses SysUtils, Forms, VarRecUtils, Vcl.Dialogs,
  UnitStringUtil,
  UnitFolderUtil2, UnitRttiUtil2, DateUtils, UnitGSCommonUtil;

procedure InitHGSCertClient(AHGSCertDBName: string = '');
var
  LStr: string;
begin
  if Assigned(g_HGSCertDB) then
    exit;

  if AHGSCertDBName = '' then
    AHGSCertDBName := ChangeFileExt(ExtractFilePath(Application.ExeName),'.sqlite');

  LStr := GetDefaultDBPath;
  LStr := LStr + AHGSCertDBName;
  HGSCertModel:= CreateHGSCertModel;
  g_HGSCertDB:= TSQLRestClientDB.Create(HGSCertModel, CreateHGSCertModel,
    LStr, TSQLRestServerDB);
  TSQLRestClientDB(g_HGSCertDB).Server.CreateMissingTables;
end;

function CreateHGSCertModel: TSQLModel;
begin
  result := TSQLModel.Create([TSQLHGSCertRecord, TSQLHGSCertFiles]);
end;

procedure DestroyHGSCertClient;
begin
  if Assigned(HGSCertModel) then
    FreeAndNil(HGSCertModel);

  if Assigned(g_HGSCertDB) then
    FreeAndNil(g_HGSCertDB);
end;

function GetDefaultDBName(const ACertNo: string): string;
begin
  if ACertNo <> '' then
  begin
    Result := StringReplace(ACertNo, '-', '_', [rfReplaceAll, rfIgnoreCase]);
    Result := StringReplace(Result, ' ', '', [rfReplaceAll, rfIgnoreCase]) + '.sqlite';
  end;
end;

function GetHGSCertFromCertNo(const ACertNo: string): TSQLHGSCertRecord;
begin
  if ACertNo = '' then
  begin
    Result := TSQLHGSCertRecord.Create;
    Result.IsUpdate := False;
  end
  else
  begin
    Result := TSQLHGSCertRecord.CreateAndFillPrepare(g_HGSCertDB.Orm,
      'CertNo LIKE ?', ['%'+ACertNo+'%']);

    if Result.FillOne then
      Result.IsUpdate := True
    else
      Result.IsUpdate := False;
  end;
end;

function GetHGSCertFromReportNo(const AReportNo: string): TSQLHGSCertRecord;
var
  LCertSearchRec: TCertSearchParamRec;
begin
  LCertSearchRec := Default(TCertSearchParamRec);
  LCertSearchRec.fReportNo := AReportNo;

  Result := GetHGSCertRecordFromSearchRec(LCertSearchRec);
end;

function GetHGSCertFromIMONo(const AIMONo: string): TSQLHGSCertRecord;
var
  LCertSearchRec: TCertSearchParamRec;
begin
  LCertSearchRec := Default(TCertSearchParamRec);
  LCertSearchRec.fIMONo := AIMONo;

  Result := GetHGSCertRecordFromSearchRec(LCertSearchRec);
end;

function GetHGSCertFromHullNo(const AHullNo: string): TSQLHGSCertRecord;
var
  LCertSearchRec: TCertSearchParamRec;
begin
  LCertSearchRec := Default(TCertSearchParamRec);
  LCertSearchRec.fHullNo := AHullNo;

  Result := GetHGSCertRecordFromSearchRec(LCertSearchRec);
end;

function GetHGSCertFromShipName(const AShipName: string): TSQLHGSCertRecord;
var
  LCertSearchRec: TCertSearchParamRec;
begin
  LCertSearchRec := Default(TCertSearchParamRec);
  LCertSearchRec.fShipName := AShipName;

  Result := GetHGSCertRecordFromSearchRec(LCertSearchRec);
end;

function GetHGSCertFromPlaceOfSurvey(const APlaceOfSurvey: string): TSQLHGSCertRecord;
var
  LCertSearchRec: TCertSearchParamRec;
begin
  LCertSearchRec := Default(TCertSearchParamRec);
  LCertSearchRec.fPlaceOfSurvey := APlaceOfSurvey;

  Result := GetHGSCertRecordFromSearchRec(LCertSearchRec);
end;

function CheckIfExistHGSCertNo(const ACertNo: string): Boolean;
var
  LCertSearchRec: TCertSearchParamRec;
  LSQLHGSCertRecord: TSQLHGSCertRecord;
begin
  LCertSearchRec := Default(TCertSearchParamRec);
  LCertSearchRec.fCertNo := ACertNo;
  LSQLHGSCertRecord := GetHGSCertRecordFromSearchRec(LCertSearchRec);

  try
    Result := LSQLHGSCertRecord.IsUpdate;
  finally
    LSQLHGSCertRecord.Free;
  end;
end;

function GetImagePhotoFromHGSCertRecord(AImage: TStream; const AHGSCertRecord:TSQLHGSCertRecord): Boolean;
var
  tmpData: RawBlob;
begin
  Result := False;

  if g_HGSCertDB.RetrieveBlob(TSQLHGSCertRecord, AHGSCertRecord.ID, 'ImageData', tmpData) then
    Result := (AImage.Write(Pointer(tmpData)^, Length(tmpData)) = Length(tmpData));
end;

function GetVariantFromHGSCertRecord(AHGSCertRecord:TSQLHGSCertRecord): variant;
begin
  TDocVariant.New(Result);
  LoadRecordPropertyToVariant(AHGSCertRecord, Result);
end;

function GetHGSCertRecordFromSearchRec(ACertSearchParamRec: TCertSearchParamRec): TSQLHGSCertRecord;
var
  ConstArray: TConstArray;
  LWhere, LStr: string;
  LFrom, LTo: TTimeLog;
  LStrList: TStringList;
  i: integer;
  LIsAPTResult: Boolean;
begin
  LWhere := '';
  LIsAPTResult := False;
  ConstArray := CreateConstArray([]);
  LStrList := TStringList.Create;
  try
    if ACertSearchParamRec.fQueryDate <> cqdtNull then
    begin
      if ACertSearchParamRec.FFrom <= ACertSearchParamRec.FTo then
      begin
        LFrom := TimeLogFromDateTime(ACertSearchParamRec.FFrom);
        LTo := TimeLogFromDateTime(ACertSearchParamRec.FTo);

//        if ACertSearchParamRec.FQueryDate <> cqdtNull then
//        begin
          case ACertSearchParamRec.FQueryDate of
            cqdtTrainedPeriod: LWhere := 'TrainedBeginDate >= ? and TrainedEndDate <= ? ';
            cqdtValidityUntilDate: LWhere := 'UntilValidity  >= ? and UntilValidity <= ? ';
            cqdtCertIssueDate: LWhere := 'IssueDate  >= ? and IssueDate <= ? ';
            cqdtAPTServiceDate: LWhere := 'APTServiceDate  >= ? and APTServiceDate <= ? ';
            cqdtInvoiceIssueDate: LWhere := 'InvoiceIssueDate  >= ? and InvoiceIssueDate <= ? ';
            cqdtInvoiceConfirmDate: LWhere := 'InvoiceConfirmDate  >= ? and InvoiceConfirmDate <= ? ';
            cqdtBillPaidDate: LWhere := 'BillPaidDate  >= ? and BillPaidDate <= ? ';
          end;

          if LWhere <> '' then
            AddConstArray(ConstArray, [LFrom, LTo]);
//        end;
      end;
    end;

    if ACertSearchParamRec.fCertNo <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ACertSearchParamRec.fCertNo+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'CertNo LIKE ? ';
    end;

    if ACertSearchParamRec.fTraineeName <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ACertSearchParamRec.fTraineeName+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'TraineeName LIKE ? ';
    end;

    if ACertSearchParamRec.fCompanyName <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ACertSearchParamRec.fCompanyName+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'CompanyName LIKE ? ';
    end;

    if ACertSearchParamRec.fTrainedSubject <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ACertSearchParamRec.fTrainedSubject+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'TrainedSubject LIKE ? ';
    end;

    if ACertSearchParamRec.fTrainedCourse <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ACertSearchParamRec.fTrainedCourse+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'TrainedCourse LIKE ? ';
    end;

    if ACertSearchParamRec.fReportNo <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ACertSearchParamRec.fReportNo+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'ReportNo LIKE ? ';
    end;

    if ACertSearchParamRec.fPlaceOfSurvey <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ACertSearchParamRec.fPlaceOfSurvey+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'PlaceOfSurvey LIKE ? ';
    end;

    if ACertSearchParamRec.fVDRSerialNo <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ACertSearchParamRec.fVDRSerialNo+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'VDRSerialNo LIKE ? ';
    end;

    if ACertSearchParamRec.fClassSociety <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ACertSearchParamRec.fClassSociety+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'ClassSociety LIKE ? ';
    end;

    if ACertSearchParamRec.fOwnerName <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ACertSearchParamRec.fOwnerName+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'OwnerName LIKE ? ';
    end;

    if ACertSearchParamRec.fShipName <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ACertSearchParamRec.fShipName+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'ShipName LIKE ? ';
    end;

    if ACertSearchParamRec.fHullNo <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ACertSearchParamRec.fHullNo+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'HullNo LIKE ? ';
    end;

    if ACertSearchParamRec.fIMONo <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ACertSearchParamRec.fIMONo+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'IMONo LIKE ? ';
    end;

    if ACertSearchParamRec.fPICEmail <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ACertSearchParamRec.fPICEmail+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'PICEmail LIKE ? ';
    end;

    if ACertSearchParamRec.fPICPhone <> '' then
    begin
      AddConstArray(ConstArray, ['%'+ACertSearchParamRec.fPICPhone+'%']);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'PICPhone LIKE ? ';
    end;

    if ACertSearchParamRec.fProductType <> shptNull then
    begin
      AddConstArray(ConstArray, [Ord(ACertSearchParamRec.fProductType)]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'ProductType = ? ';
    end;

    if ACertSearchParamRec.fCertType <> hctNull then
    begin
      AddConstArray(ConstArray, [Ord(ACertSearchParamRec.fCertType)]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'CertType = ? ';
    end;

    if ACertSearchParamRec.fIsAPTResult_NoResult then
    begin
      AddConstArray(ConstArray, [Ord(vdrarNull)]);
      LStrList.Add('((APTResult IS NULL) or (APTResult = ?)) ');
      LIsAPTResult := True;
//      if LWhere <> '' then
//        LWhere := LWhere + ' and ';
//      LWhere := LWhere + 'APTResult IS NULL ';
    end;

    if ACertSearchParamRec.fIsAPTResult_Successed then
    begin
      AddConstArray(ConstArray, [Ord(vdrarSuccessed)]);
      LStrList.Add('APTResult = ? ');
      LIsAPTResult := True;
//      if LWhere <> '' then
//        LWhere := LWhere + ' and ';
//      LWhere := LWhere + 'APTResult = ? ';
    end;

    if ACertSearchParamRec.fIsAPTResult_Canceled then
    begin
      AddConstArray(ConstArray, [Ord(vdrarCancelled)]);
      LStrList.Add('APTResult = ? ');
      LIsAPTResult := True;
//      if LWhere <> '' then
//        LWhere := LWhere + ' and ';
//      LWhere := LWhere + 'APTResult = ? ';
    end;

    if ACertSearchParamRec.fIsAPTResult_Failed then
    begin
      AddConstArray(ConstArray, [Ord(vdrarFailed)]);
      LStrList.Add('APTResult = ? ');
      LIsAPTResult := True;
//      if LWhere <> '' then
//        LWhere := LWhere + ' and ';
//      LWhere := LWhere + 'APTResult = ? ';
    end;

    if LIsAPTResult then
    begin
      if LWhere <> '' then
        LWhere := LWhere + ' and ';

      LWhere := LWhere + ' (' ;
      for i := 0 to LStrList.Count - 2 do
        LWhere := LWhere + LStrList.Strings[i] + ' or ';
      LWhere := LWhere + LStrList.Strings[LStrList.Count - 1] + ') ';
    end;

    if ACertSearchParamRec.fIsIgnoreInvoice then
    begin
      AddConstArray(ConstArray, [Ord(ACertSearchParamRec.fIsIgnoreInvoice)]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'IsIgnoreInvoice = ? ';
    end
    else
    begin
      AddConstArray(ConstArray, [Ord(ACertSearchParamRec.fIsIgnoreInvoice)]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + '((IsIgnoreInvoice IS NULL) or (IsIgnoreInvoice = ?)) ';
    end;

    if (ACertSearchParamRec.fIsInvoiceIssued) and
      (ACertSearchParamRec.fIsNotInvoiceIssued) then
    begin
    end
    else
    if ACertSearchParamRec.fIsInvoiceIssued then
    begin
      AddConstArray(ConstArray, [127489752310]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'InvoiceIssueDate > ? ';
    end
    else
    if ACertSearchParamRec.fIsNotInvoiceIssued then
    begin
      AddConstArray(ConstArray, [127489800000]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + '((InvoiceIssueDate IS NULL) or (InvoiceIssueDate < ?)) ';
    end;

//    if (ACertSearchParamRec.fIsInvoiceIssued) and
//      (ACertSearchParamRec.fIsNotInvoiceIssued) and
//      (ACertSearchParamRec.fIsIgnoreInvoice) then
//    begin
//
//    end
//    else
//    if (ACertSearchParamRec.fIsInvoiceIssued) and
//      (ACertSearchParamRec.fIsNotInvoiceIssued) then
//    begin
//      AddConstArray(ConstArray, [Ord(ACertSearchParamRec.fIsIgnoreInvoice)]);
//      if LWhere <> '' then
//        LWhere := LWhere + ' and ';
//      LWhere := LWhere + '((IsIgnoreInvoice IS NULL) or (IsIgnoreInvoice = ?)) ';
//    end
//    else
//    if (ACertSearchParamRec.fIsInvoiceIssued) and
//      (ACertSearchParamRec.fIsIgnoreInvoice) then
//    begin
//      AddConstArray(ConstArray, [127489752310, Ord(ACertSearchParamRec.fIsIgnoreInvoice)]);
//      if LWhere <> '' then
//        LWhere := LWhere + ' and ';
//      LWhere := LWhere + '((InvoiceIssueDate > ?) or (IsIgnoreInvoice = ?)) ';
//
//    end
//    else
//    if (ACertSearchParamRec.fIsNotInvoiceIssued) and
//      (ACertSearchParamRec.fIsIgnoreInvoice) then
//    begin
//      AddConstArray(ConstArray, [127489800000, Ord(ACertSearchParamRec.fIsIgnoreInvoice)]);
//      if LWhere <> '' then
//        LWhere := LWhere + ' and ';
//      LWhere := LWhere + '(((InvoiceIssueDate IS NULL) or (InvoiceIssueDate < ?))  or (IsIgnoreInvoice = ?)) ';
//    end
//    else
//    if ACertSearchParamRec.fIsInvoiceIssued then
//    begin
//      AddConstArray(ConstArray, [127489752310]);
//      if LWhere <> '' then
//        LWhere := LWhere + ' and ';
//      LWhere := LWhere + '((InvoiceIssueDate > ?) and ((IsIgnoreInvoice IS NULL) or (IsIgnoreInvoice = ?))) ';
//    end
//    else
//    if ACertSearchParamRec.fIsNotInvoiceIssued then
//    begin
//      AddConstArray(ConstArray, [127489800000]);
//      if LWhere <> '' then
//        LWhere := LWhere + ' and ';
//      LWhere := LWhere + '(((InvoiceIssueDate IS NULL) or (InvoiceIssueDate < ?)) and ((IsIgnoreInvoice IS NULL) or (IsIgnoreInvoice = ?))) ';
//    end
//    else
//    if ACertSearchParamRec.fIsIgnoreInvoice then
//    begin
//      AddConstArray(ConstArray, [Ord(ACertSearchParamRec.fIsIgnoreInvoice)]);
//      if LWhere <> '' then
//        LWhere := LWhere + ' and ';
//      LWhere := LWhere + 'IsIgnoreInvoice = ? ';
//    end;

    if (ACertSearchParamRec.fIsInvoiceConfirmed) and
      (ACertSearchParamRec.fIsNotInvoiceConfirmed) then
    begin

    end
    else
    if ACertSearchParamRec.fIsInvoiceConfirmed then
    begin
      AddConstArray(ConstArray, [127489752310]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'InvoiceConfirmDate > ? ';
    end
    else
    if ACertSearchParamRec.fIsNotInvoiceConfirmed then
    begin
      AddConstArray(ConstArray, [127489800000]);//SQLITE_NULL
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + '((InvoiceConfirmDate IS NULL) or (InvoiceConfirmDate < ?)) ';
    end;

    if (ACertSearchParamRec.fIsBillPaid) and
      (ACertSearchParamRec.fIsNotBillPaid) then
    begin
//      AddConstArray(ConstArray, [127489752310]);
//      if LWhere <> '' then
//        LWhere := LWhere + ' and ';
//      LWhere := LWhere + '(BillPaidDate > ? ';
//
//      AddConstArray(ConstArray, [127489752310]);
//      if LWhere <> '' then
//        LWhere := LWhere + ' or ';
//      LWhere := LWhere + 'BillPaidDate <= ?) ';
    end
    else
    if ACertSearchParamRec.fIsBillPaid then
    begin
      AddConstArray(ConstArray, [127489752310]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'BillPaidDate > ? ';
    end
    else
    if ACertSearchParamRec.fIsNotBillPaid then
    begin
      AddConstArray(ConstArray, [127489800000]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + '((BillPaidDate IS NULL) or (BillPaidDate < ?)) ';
    end;

    if LWhere = '' then
    begin
      AddConstArray(ConstArray, [-1]);
      LWhere := 'ID <> ? ';
    end;

    if ACertSearchParamRec.fOrderBy <> '' then
      LWhere := LWhere + ' ' + ACertSearchParamRec.fOrderBy;

    Result := TSQLHGSCertRecord.CreateAndFillPrepare(g_HGSCertDB.Orm, Lwhere, ConstArray);

    if Result.FillOne then
    begin
//      Result.FillRewind;
      Result.IsUpdate := True;
    end
    else
    begin
//      Result := TSQLHGSCertRecord.Create;
      Result.IsUpdate := False;
    end
  finally
    LStrList.Free;
    FinalizeConstArray(ConstArray);
  end;
end;

procedure LoadHGSCertFromVariant(ASQLHGSCertRecord: TSQLHGSCertRecord; ADoc: variant);
begin
  if ADoc = null then
    exit;

  LoadRecordPropertyFromVariant(ASQLHGSCertRecord, ADoc);
end;

procedure DeleteHGSCert(const ACertNo: string);
var
  LSQLHGSCertRecord: TSQLHGSCertRecord;
begin
  LSQLHGSCertRecord := GetHGSCertFromCertNo(ACertNo);
  try
    if LSQLHGSCertRecord.IsUpdate then
      g_HGSCertDB.Delete(TSQLHGSCertRecord, LSQLHGSCertRecord.ID);
  finally
    LSQLHGSCertRecord.Free;
  end;
end;

procedure AddOrUpdateHGSCert(ASQLHGSCertRecord: TSQLHGSCertRecord);
begin
  if ASQLHGSCertRecord.IsUpdate then
  begin
    g_HGSCertDB.Update(ASQLHGSCertRecord);
  end
  else
  begin
    g_HGSCertDB.Add(ASQLHGSCertRecord, true);
  end;
end;

procedure AddOrUpdateHGSCertPhoto(const AImageData: RawBlob;
  ASQLHGSCertRecord: TSQLHGSCertRecord);
begin
  g_HGSCertDB.UpdateBlob(TSQLHGSCertRecord, ASQLHGSCertRecord.ID, 'ImageData', AImageData);
end;

function AddOrUpdateHGSCertFromVariant(ADoc: variant; AIsOnlyAdd: Boolean = False): integer;
var
  LSQLHGSCertRecord: TSQLHGSCertRecord;
  LIsUpdate: Boolean;
begin
  LSQLHGSCertRecord := GetHGSCertFromCertNo(ADoc.CertNo);
  LIsUpdate := LSQLHGSCertRecord.IsUpdate;
  try
    if AIsOnlyAdd then
    begin
      if not LSQLHGSCertRecord.IsUpdate then
      begin
        LoadHGSCertFromVariant(LSQLHGSCertRecord, ADoc);
        LSQLHGSCertRecord.IsUpdate := LIsUpdate;

        AddOrUpdateHGSCert(LSQLHGSCertRecord);
        Inc(Result);
      end;
    end
    else
    begin
      if LSQLHGSCertRecord.IsUpdate then
        Inc(Result);

      LoadHGSCertFromVariant(LSQLHGSCertRecord, ADoc);
      LSQLHGSCertRecord.IsUpdate := LIsUpdate;

      AddOrUpdateHGSCert(LSQLHGSCertRecord);
    end;
  finally
    FreeAndNil(LSQLHGSCertRecord);
  end;
end;

function UpdateInvoiceNoFromCertNo(AInvoiceNo, ACertNo: string): Boolean;
var
  LSQLHGSCertRecord: TSQLHGSCertRecord;
begin
  LSQLHGSCertRecord := GetHGSCertFromCertNo(ACertNo);

  try
    if LSQLHGSCertRecord.IsUpdate then
    begin
      LSQLHGSCertRecord.OrderNo := AInvoiceNo;
      Result := g_HGSCertDB.Update(LSQLHGSCertRecord);
    end;
  finally
    LSQLHGSCertRecord.Free;
  end;
end;

function UpdateMailCountFromCertNo(ACertNo: string; AMailCount: integer): boolean;
var
  LSQLHGSCertRecord: TSQLHGSCertRecord;
begin
  LSQLHGSCertRecord := GetHGSCertFromCertNo(ACertNo);

  try
    if LSQLHGSCertRecord.IsUpdate then
    begin
      LSQLHGSCertRecord.MailCount := AMailCount;
      Result := g_HGSCertDB.Update(LSQLHGSCertRecord);
    end;
  finally
    LSQLHGSCertRecord.Free;
  end;
end;

function UpdateInvoiceIssueDateFromCertNo(ACertNo: string; AInvIssueDate: TDate): boolean;
var
  LSQLHGSCertRecord: TSQLHGSCertRecord;
begin
  LSQLHGSCertRecord := GetHGSCertFromCertNo(ACertNo);

  try
    if LSQLHGSCertRecord.IsUpdate then
    begin
      LSQLHGSCertRecord.InvoiceIssueDate := TimeLogFromDateTime(AInvIssueDate);
      Result := g_HGSCertDB.Update(LSQLHGSCertRecord);
    end;
  finally
    LSQLHGSCertRecord.Free;
  end;
end;

function UpdateInvoiceConfirmDateFromCertNo(ACertNo: string; AInvConfirmDate: TDate): boolean;
var
  LSQLHGSCertRecord: TSQLHGSCertRecord;
begin
  LSQLHGSCertRecord := GetHGSCertFromCertNo(ACertNo);

  try
    if LSQLHGSCertRecord.IsUpdate then
    begin
      LSQLHGSCertRecord.InvoiceConfirmDate := TimeLogFromDateTime(AInvConfirmDate);
      Result := g_HGSCertDB.Update(LSQLHGSCertRecord);
    end;
  finally
    LSQLHGSCertRecord.Free;
  end;
end;

function UpdatePaidBillDateFromCertNo(ACertNo: string; APaidBillDate: TDate): boolean;
var
  LSQLHGSCertRecord: TSQLHGSCertRecord;
begin
  LSQLHGSCertRecord := GetHGSCertFromCertNo(ACertNo);

  try
    if LSQLHGSCertRecord.IsUpdate then
    begin
      LSQLHGSCertRecord.BillPaidDate := TimeLogFromDateTime(APaidBillDate);
      Result := g_HGSCertDB.Update(LSQLHGSCertRecord);
    end;
  finally
    LSQLHGSCertRecord.Free;
  end;
end;

function UpdateNoteFromCertNo(ANote, ACertNo: string): boolean;
var
  LSQLHGSCertRecord: TSQLHGSCertRecord;
begin
  LSQLHGSCertRecord := GetHGSCertFromCertNo(ACertNo);

  try
    if LSQLHGSCertRecord.IsUpdate then
    begin
      LSQLHGSCertRecord.Notes := ANote;
      Result := g_HGSCertDB.Update(LSQLHGSCertRecord);
    end;
  finally
    LSQLHGSCertRecord.Free;
  end;
end;

function GetGSFileRecsFromDocType(const ADocType: THGSCertDocType): TJHPFileRecs;
var
  LHGSCertFiles: TSQLHGSCertFiles;
begin
  LHGSCertFiles := GetHGSCertFilesFromDocType(ADocType);

  if LHGSCertFiles.fIsUpdate then
    Result := LHGSCertFiles.fFiles;
end;

function GetHGSCertFilesFromDocType(const ADocType: THGSCertDocType; AHGSCertFilesDB: TRestClientDB): TSQLHGSCertFiles;
begin
  if AHGSCertFilesDB = nil then
    AHGSCertFilesDB := g_HGSCertDB;

  Result := TSQLHGSCertFiles.CreateAndFillPrepare(AHGSCertFilesDB.Orm,
      'GSDocType = ?', [Ord(ADocType)]); //ORDER BY TagName, StateValue

  if Result.FillOne then
    Result.fIsUpdate := True
  else
    Result.fIsUpdate := False;
end;

initialization

finalization
  DestroyHGSCertClient;

end.

