unit UnitHGSLicenseRecord;

interface

uses
  Classes, SysUtils, Forms,
  mormot.core.base, mormot.core.variants, mormot.core.datetime, mormot.orm.core,
  mormot.orm.base, mormot.rest.sqlite3, mormot.core.os,
  UnitCertManager2, UnitVesselData2, UnitHGSCertData2, UnitHGSCurriculumData2,
  UnitHGSVDRData, UnitJHPFileData, UnitHGSBaseRecord;

type
  TOrmHGSTrainLicense = class(TSQLHGSCertBasic)
  private
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
  public
    fIsLicense: Boolean;
    property IsLicense: Boolean read fIsLicense write fIsLicense;
  published
    property TraineeName: RawUTF8 read fTraineeName write fTraineeName;
    property TraineeNation: RawUTF8 read fTraineeNation write fTraineeNation;
    property TrainedSubject: RawUTF8 read fTrainedSubject write fTrainedSubject;
    property TrainedCourse: RawUTF8 read fTrainedCourse write fTrainedCourse;
    property CourseLevel: TAcademyCourseLevel read fCourseLevel write fCourseLevel;
    property TrainedBeginDate: TTimeLog read fTrainedBeginDate write fTrainedBeginDate;
    property TrainedEndDate: TTimeLog read fTrainedEndDate write fTrainedEndDate;
    property MailCount: integer read fMailCount write fMailCount;
    property ImageData: RawBlob read FImageData write FImageData;
  end;

  TOrmHGSLicenseFiles = class(TSQLRecord)
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

procedure InitHGSLicenseClient(ADBName: string = '');
function CreateHGSLicenseModel: TSQLModel;
procedure DestroyHGSLicenseClient;

procedure AddOrUpdateHGSLicense(AOrm: TOrmHGSTrainLicense);
procedure AddOrUpdateHGSLicensePhoto(const AImageData: RawBlob; AOrm: TOrmHGSTrainLicense);
function AddOrUpdateHGSLicenseFromVariant(ADoc: variant; AIsOnlyAdd: Boolean = False): integer;

procedure DeleteHGSLicense(const ACertNo: string);

procedure LoadHGSLicenseFromVariant(AOrm: TOrmHGSTrainLicense; ADoc: variant);

function GetHGSLicenseFromCertNo(const ACertNo: string): TOrmHGSTrainLicense;
function GetVariantFromHGSLicenseRecord(AOrm:TOrmHGSTrainLicense): variant;
function GetLicenseData4XlsFromCertNo(const ACertNo: string): variant;
function GetHGSLicenseRecordFromSearchRec(ACertSearchParamRec: TCertSearchParamRec): TOrmHGSTrainLicense;
function GetImagePhotoFromHGSLicenseRecord(AImage: TStream; const AOrm:TOrmHGSTrainLicense): Boolean;
function GetZipFileName4Doc(ACertNo: string=''): string;
function GetFormattedTrainedPeriod(const ABeginDate, AEndDate: TDate): string;
function GetGridColNames4LicenseList: variant;

function CheckIfExistHGSLicenseNo(const ACertNo: string): Boolean;
function CheckIsLicenseFromLicNo(const ACertNo: string): Boolean;

///////////////////////////
function GetTempPhotoFileName(ACertNo: string; ASaveFileKind: TJHPFileFormat=gfkNull): string;//증명사진 파일 이름
function GetTempQRFileName(ACertNo: string; ASaveFileKind: TJHPFileFormat=gfkNull): string;//QRCode 파일 이름
function GetTempAttendantListFN(ACompanyName: string; ASaveFileKind: TJHPFileFormat=gfkNull): string;//참석자 명단 리스트 파일 이름(xls)

var
  g_HGSLicenseDB: TRestClientDB;
  HGSLicenseModel: TSQLModel;

implementation

uses VarRecUtils, UnitStringUtil, UnitFolderUtil2, UnitRttiUtil2, DateUtils, UnitGSCommonUtil;

function GetTempPhotoFileName(ACertNo: string;
  ASaveFileKind: TJHPFileFormat=gfkNull): string;//증명사진 파일 이름
var
  LExt: string;
begin
  Result := 'c:\temp\'+ ACertNo + '_' + PHOTO_FILENAME;

  case ASaveFileKind of
    gfkPng: LExt := '.png';
    gfkJpg : LExt := '.jpg';
  else
    Lext := '';
  end;

  if Lext <> '' then
    Result := ChangeFileExt(Result, Lext);
end;

function GetTempQRFileName(ACertNo: string; ASaveFileKind:
  TJHPFileFormat=gfkNull): string;//QRCode 파일 이름
var
  LExt: string;
begin
  Result := 'c:\temp\'+ ACertNo +'_'+QRCODE_FILENAME;

  case ASaveFileKind of
    gfkPng: LExt := '.png';
    gfkJpg : LExt := '.jpg';
  else
    Lext := '';
  end;

  if Lext <> '' then
    Result := ChangeFileExt(Result, Lext);
end;

function GetTempAttendantListFN(ACompanyName: string;
  ASaveFileKind: TJHPFileFormat=gfkNull): string;//참석자 명단 리스트 파일 이름(xls)
var
  LExt: string;
begin
  Result := 'c:\temp\'+ACompanyName+'_'+LICLIST_FILENAME;

  case ASaveFileKind of
    gfkEXCEL: LExt := '.ods';
    gfkPDF : LExt := '.pdf';
  else
    Lext := '';
  end;

  if Lext <> '' then
    Result := ChangeFileExt(Result, Lext);
end;

procedure InitHGSLicenseClient(ADBName: string = '');
var
  LStr: string;
begin
  if Assigned(g_HGSLicenseDB) then
    exit;

  if ADBName = '' then
    ADBName := ChangeFileExt(ExtractFilePath(Application.ExeName),'.sqlite');

  LStr := GetDefaultDBPath;
  LStr := LStr + ADBName;
  HGSLicenseModel:= CreateHGSLicenseModel;
  g_HGSLicenseDB:= TSQLRestClientDB.Create(HGSLicenseModel, CreateHGSLicenseModel,
    LStr, TSQLRestServerDB);
  TSQLRestClientDB(g_HGSLicenseDB).Server.CreateMissingTables;
end;

function CreateHGSLicenseModel: TSQLModel;
begin
  result := TSQLModel.Create([TOrmHGSTrainLicense, TOrmHGSLicenseFiles]);
end;

procedure DestroyHGSLicenseClient;
begin
  if Assigned(HGSLicenseModel) then
    FreeAndNil(HGSLicenseModel);

  if Assigned(g_HGSLicenseDB) then
    FreeAndNil(g_HGSLicenseDB);
end;

procedure AddOrUpdateHGSLicense(AOrm: TOrmHGSTrainLicense);
begin
  if AOrm.IsUpdate then
  begin
    g_HGSLicenseDB.Update(AOrm);
  end
  else
  begin
    g_HGSLicenseDB.Add(AOrm, true);
  end;
end;

procedure AddOrUpdateHGSLicensePhoto(const AImageData: RawBlob; AOrm: TOrmHGSTrainLicense);
begin
  g_HGSLicenseDB.UpdateBlob(TOrmHGSTrainLicense, AOrm.ID, 'ImageData', AImageData);
end;

function AddOrUpdateHGSLicenseFromVariant(ADoc: variant; AIsOnlyAdd: Boolean = False): integer;
var
  LSQLHGSLicenseRecord: TOrmHGSTrainLicense;
  LIsUpdate: Boolean;
begin
  LSQLHGSLicenseRecord := GetHGSLicenseFromCertNo(ADoc.CertNo);
  LIsUpdate := LSQLHGSLicenseRecord.IsUpdate;
  try
    if AIsOnlyAdd then
    begin
      if not LSQLHGSLicenseRecord.IsUpdate then
      begin
        LoadHGSLicenseFromVariant(LSQLHGSLicenseRecord, ADoc);
        LSQLHGSLicenseRecord.IsUpdate := LIsUpdate;

        AddOrUpdateHGSLicense(LSQLHGSLicenseRecord);
        Inc(Result);
      end;
    end
    else
    begin
      if LSQLHGSLicenseRecord.IsUpdate then
        Inc(Result);

      LoadHGSLicenseFromVariant(LSQLHGSLicenseRecord, ADoc);
      LSQLHGSLicenseRecord.IsUpdate := LIsUpdate;

      AddOrUpdateHGSLicense(LSQLHGSLicenseRecord);
    end;
  finally
    FreeAndNil(LSQLHGSLicenseRecord);
  end;
end;

procedure DeleteHGSLicense(const ACertNo: string);
var
  LOrm: TOrmHGSTrainLicense;
begin
  LOrm := GetHGSLicenseFromCertNo(ACertNo);
  try
    if LOrm.IsUpdate then
      g_HGSLicenseDB.Delete(TOrmHGSTrainLicense, LOrm.ID);
  finally
    LOrm.Free;
  end;
end;

procedure LoadHGSLicenseFromVariant(AOrm: TOrmHGSTrainLicense; ADoc: variant);
begin
  if ADoc = null then
    exit;

  LoadRecordPropertyFromVariant(AOrm, ADoc);
end;

function GetHGSLicenseFromCertNo(const ACertNo: string): TOrmHGSTrainLicense;
begin
  if ACertNo = '' then
  begin
    Result := TOrmHGSTrainLicense.Create;
    Result.IsUpdate := False;
  end
  else
  begin
    Result := TOrmHGSTrainLicense.CreateAndFillPrepare(g_HGSLicenseDB.Orm,
      'CertNo LIKE ?', ['%'+ACertNo+'%']);

    if Result.FillOne then
      Result.IsUpdate := True
    else
      Result.IsUpdate := False;
  end;

  Result.IsLicense := True;
end;

function GetVariantFromHGSLicenseRecord(AOrm:TOrmHGSTrainLicense): variant;
begin
  TDocVariant.New(Result);
  LoadRecordPropertyToVariant(AOrm, Result);
end;

function GetLicenseData4XlsFromCertNo(const ACertNo: string): variant;
var
  LOrm: TOrmHGSTrainLicense;
begin
  LOrm := GetHGSLicenseFromCertNo(ACertNo);
  try
    if LOrm.IsUpdate then
    begin
      TDocVariant.New(Result);

      TDocVariantData(Result).AddValue(GetLicCardColorFromCertType(LOrm.CertType), '1');
      TDocVariantData(Result).AddValue(LOrm.TraineeName, '2');
      TDocVariantData(Result).AddValue(LOrm.TraineeNation, '3');
      TDocVariantData(Result).AddValue(LOrm.CompanyName, '4');
      TDocVariantData(Result).AddValue(GetFormattedTrainedPeriod(TimelogToDateTime(LOrm.TrainedBeginDate), TimelogToDateTime(LOrm.TrainedEndDate)), '5');
      TDocVariantData(Result).AddValue(LOrm.TrainedCourse, '6');
      TDocVariantData(Result).AddValue(LOrm.CertNo, '7');
      TDocVariantData(Result).AddValue(FormatDateTime('Until mmm. dd, yyyy', TimeLogToDateTime(LOrm.UntilValidity)), '8');
      TDocVariantData(Result).AddValue(ExtractFileName(GetTempPhotoFileName(LOrm.CertNo)), '9');
      TDocVariantData(Result).AddValue(ExtractFileName(GetTempQRFileName(LOrm.CertNo)), '10');
    end;
  finally
    LOrm.Free;
  end;
end;

function GetHGSLicenseRecordFromSearchRec(ACertSearchParamRec: TCertSearchParamRec): TOrmHGSTrainLicense;
var
  ConstArray: TConstArray;
  LWhere, LStr: string;
  LFrom, LTo: TTimeLog;
  LStrList: TStringList;
  i: integer;
  LIsCertTypesIncluded: Boolean;
begin
  LWhere := '';
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

    if ACertSearchParamRec.fCertTypes <> [] then
    begin
      if LWhere <> '' then
        LWhere := LWhere + ' and (';

      if hctLicBasic in ACertSearchParamRec.fCertTypes then
      begin
        if not LIsCertTypesIncluded then
        begin
          if LWhere <> '' then
            LWhere := LWhere + ' and ('
          else
            LWhere := ' ( ';
        end
        else
        begin
          if LWhere <> '' then
            LWhere := LWhere + ' or '
          else
            LWhere := ' or ';
        end;

        LWhere := LWhere + ' CertType = ? ';

        AddConstArray(ConstArray, [Ord(hctLicBasic)]);
        LIsCertTypesIncluded := True;
      end;

      if hctLicInter in ACertSearchParamRec.fCertTypes then
      begin
        if not LIsCertTypesIncluded then
        begin
          if LWhere <> '' then
            LWhere := LWhere + ' and ('
          else
            LWhere := ' ( ';
        end
        else
        begin
          if LWhere <> '' then
            LWhere := LWhere + ' or '
          else
            LWhere := ' or ';
        end;

        LWhere := LWhere + ' CertType = ? ';

        AddConstArray(ConstArray, [Ord(hctLicInter)]);
        LIsCertTypesIncluded := True;
      end;

      if hctLicAdv in ACertSearchParamRec.fCertTypes then
      begin
        if not LIsCertTypesIncluded then
        begin
          if LWhere <> '' then
            LWhere := LWhere + ' and ('
          else
            LWhere := ' ( ';
        end
        else
        begin
          if LWhere <> '' then
            LWhere := LWhere + ' or '
          else
            LWhere := ' or ';
        end;

        LWhere := LWhere + ' CertType = ? ';

        AddConstArray(ConstArray, [Ord(hctLicAdv)]);
        LIsCertTypesIncluded := True;
      end;

      LWhere := LWhere + ' ) ';
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

    Result := TOrmHGSTrainLicense.CreateAndFillPrepare(g_HGSLicenseDB.Orm, Lwhere, ConstArray);

    if Result.FillOne then
    begin
      Result.IsUpdate := True;
    end
    else
    begin
      Result.IsUpdate := False;
    end
  finally
    LStrList.Free;
    FinalizeConstArray(ConstArray);
  end;
end;

function CheckIfExistHGSLicenseNo(const ACertNo: string): Boolean;
var
  LCertSearchRec: TCertSearchParamRec;
  LSQLHGSLicenseRecord: TOrmHGSTrainLicense;
begin
  LCertSearchRec := Default(TCertSearchParamRec);
  LCertSearchRec.fCertNo := ACertNo;
  LSQLHGSLicenseRecord := GetHGSLicenseRecordFromSearchRec(LCertSearchRec);

  try
    Result := LSQLHGSLicenseRecord.IsUpdate;
  finally
    LSQLHGSLicenseRecord.Free;
  end;
end;

function CheckIsLicenseFromLicNo(const ACertNo: string): Boolean;
var
  LCode: string;
begin//
  Result := False;

  g_HGSCertTypeCode.InitArrayRecord(R_HGSCertTypeCode);

  LCode := '-' + g_HGSCertTypeCode.ToString(hctLicBasic) + '-';
  Result := Pos(LCode, ACertNo) > 0;

  if Result then
    exit;

  LCode := '-' + g_HGSCertTypeCode.ToString(hctLicInter) + '-';
  Result := Pos(LCode, ACertNo) > 0;

  if Result then
    exit;

  LCode := '-' + g_HGSCertTypeCode.ToString(hctLicAdv) + '-';
  Result := Pos(LCode, ACertNo) > 0;

  if Result then
    exit;
end;

function GetImagePhotoFromHGSLicenseRecord(AImage: TStream; const AOrm:TOrmHGSTrainLicense): Boolean;
var
  tmpData: RawBlob;
begin
  Result := False;

  if g_HGSLicenseDB.RetrieveBlob(TOrmHGSTrainLicense, AOrm.ID, 'ImageData', tmpData) then
    Result := (AImage.Write(Pointer(tmpData)^, Length(tmpData)) = Length(tmpData));
end;

function GetZipFileName4Doc(ACertNo: string): string;
var
  LTempDir: string;
begin
  LTempDir := 'c:\temp\';
  EnsureDirectoryExists(LTempDir);
  Result := LTempDir+ACertNo;
  Result := ChangeFileExt(Result, '.zip');
end;

function GetFormattedTrainedPeriod(const ABeginDate, AEndDate: TDate): string;
var
  Lyear: string;
begin
  if AEndDate = 0 then
    Result := FormatDateTime('mmm. dd, yyyy' ,ABeginDate)
  else
  begin
    LYear := FormatDateTime('yyyy' ,ABeginDate);

    if LYear <> FormatDateTime('yyyy' ,AEndDate) then
      Result := FormatDateTime('mmm. dd, yyyy' ,ABeginDate)
    else
      Result := FormatDateTime('mmm. dd' ,ABeginDate);

    Result := Result + FormatDateTime(' ~ mmm. dd, yyyy' ,AEndDate);
  end;
end;

function GetGridColNames4LicenseList: variant;
begin
  TDocVariant.New(Result);

  TDocVariantData(Result).AddValue('카드색상', '1');
  TDocVariantData(Result).AddValue('Name', '2');
  TDocVariantData(Result).AddValue('Nationality', '3');
  TDocVariantData(Result).AddValue('Company', '4');
  TDocVariantData(Result).AddValue('Trained Period', '5');
  TDocVariantData(Result).AddValue('Course', '6');
  TDocVariantData(Result).AddValue('Cert. No.', '7');
  TDocVariantData(Result).AddValue('Validity Date', '8');
  TDocVariantData(Result).AddValue('사진파일명', '9');
  TDocVariantData(Result).AddValue('QRCode 파일명', '10');
end;

initialization

finalization
  DestroyHGSLicenseClient;
end.
