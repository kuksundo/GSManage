unit UnitStrategy4VDRAPTCert2;

interface

uses SysUtils,
  mormot.core.mustache, mormot.core.base, mormot.core.variants,
  UnitStrategy4OLEmailInterface2, UnitBase64Util2,
  UnitMustacheUtil2, UnitHGSCertRecord2, UnitMakeReport2, UnitJHPFileData;

type
  TOLEmail4VDRAPTCert = class(TInterfacedObject, IStrategy4OLEmail)
  public
    FCertNo: string;

    constructor Create(ACertNo: string);

    function MakeEmailHTMLBody(AContext: TContext4OLEmail): string;
    function MakeAttachFile(AContext: TContext4OLEmail): string;
  end;

implementation

uses FrmCertEdit2;

{ TOLEmail4VDRAPTCert }

constructor TOLEmail4VDRAPTCert.Create(ACertNo: string);
begin
  FCertNo := ACertNo;
end;

function TOLEmail4VDRAPTCert.MakeAttachFile(AContext: TContext4OLEmail): string;
begin
  Result := '';

  if AContext.FOLEmailActionRec.FMailKind = MAILKIND_VDRAPT_REPLY_WITHMAKEZIP then
    Result := g_CertEditF.MakeZip4APTDoc(g_JHPFileFormat.ToType(AContext.FOLEmailActionRec.FFileKind), True)//gfkPDF
  else
  if AContext.FOLEmailActionRec.FMailKind = MAILKIND_VDRAPT_REPLY_WITHNOMAKEZIP then
    Result := g_CertEditF.GetZipFileName4Doc
  else
  if AContext.FOLEmailActionRec.FMailKind = MAILKIND_VDRAPT_REPLY_IFZIPEXIST then
  begin
    Result := g_CertEditF.GetZipFileName4Doc;

    if Result <> '' then
    begin
      if not FileExists(Result) then
        Result := g_CertEditF.MakeZip4APTDoc(
          g_JHPFileFormat.ToType(AContext.FOLEmailActionRec.FFileKind), True)//gfkPDF
    end;
  end;
end;

function TOLEmail4VDRAPTCert.MakeEmailHTMLBody(
  AContext: TContext4OLEmail): string;
var
  LDoc: variant;
  LJSON: RawUTF8;
  LMustache: TSynMustache;
  LFile: RawByteString;
  LSQLCert: TSQLHGSCertRecord;
begin
  if (AContext.FOLEmailActionRec.FMailKind = MAILKIND_VDRAPT_REPLY_WITHMAKEZIP) or
    (AContext.FOLEmailActionRec.FMailKind = MAILKIND_VDRAPT_REPLY_WITHNOMAKEZIP) then
  begin
    TDocVariant.New(LDoc);
    LDoc.CertNo := FCertNo;
    LDoc.Summary := 'VDR APT CoC';
    LDoc.ProductType := 'VDR APT';
    LDoc.MySig := '';

    LSQLCert := GetHGSCertFromCertNo(FCertNo);
    try
      if LSQLCert.IsUpdate then
      begin
        LDoc.HullNo := LSQLCert.HullNo;
        LDoc.CustomerName := LSQLCert.CompanyName;
        LDoc.CompanyCode := LSQLCert.CompanyCode;
      end;
    finally
      FreeAndNil(LSQLCert);
    end;

    Result := GetMustacheJSONFromFile(LDoc, AContext.FOLEmailActionRec.FTemplateFileName);
  end
  else
  begin
  end;
end;

end.
