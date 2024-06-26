unit UnitHGSBaseRecord;

interface

uses
  Classes,
  mormot.core.base, mormot.core.variants, mormot.core.datetime, mormot.orm.core,
  mormot.orm.base, mormot.rest.sqlite3,
  UnitCertManager2, UnitVesselData2, UnitHGSCertData2, UnitHGSCurriculumData2,
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

    fFileCount,
    fReNewalCount: integer;
    fQRCodeImage: TSQLRawBlob;//Cert 정보를 암호화 하여 저장함
    fPhoto: TSQLRawBlob;//사진 저장함
    fIsRenewal,//Cert Renewal 여부 (유효기간 지난 후 재발급할 경우 True)
    fIsCryptSerial,           //시리얼 번호 암호화 여부
    fIsIgnoreInvoice: Boolean;//Invoice 발행 건 아님
    fProductType: TShipProductType;
    fCertType: THGSCertType; //유무상 구분 가능

    fUntilValidity,
    fIssueDate,
    fInvoiceIssueDate,
    fInvoiceConfirmDate,
    fBillPaidDate,
    fRenewalDate,
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
    property IsRenewal: Boolean read fIsRenewal write fIsRenewal;
    property IsCryptSerial: Boolean read fIsCryptSerial write fIsCryptSerial;
    property IsIgnoreInvoice: Boolean read fIsIgnoreInvoice write fIsIgnoreInvoice;
    property ProductType: TShipProductType read fProductType write fProductType;
    property CertType: THGSCertType read fCertType write fCertType;
    property UntilValidity: TTimeLog read fUntilValidity write fUntilValidity;
    property IssueDate: TTimeLog read fIssueDate write fIssueDate;
    property InvoiceIssueDate: TTimeLog read fInvoiceIssueDate write fInvoiceIssueDate;
    property InvoiceConfirmDate: TTimeLog read fInvoiceConfirmDate write fInvoiceConfirmDate;
    property BillPaidDate: TTimeLog read fBillPaidDate write fBillPaidDate;
    property RenewalDate: TTimeLog read fRenewalDate write fRenewalDate;
    property UpdateDate: TTimeLog read fUpdateDate write fUpdateDate;
    property QRCodeImage: TSQLRawBlob read fQRCodeImage write fQRCodeImage;
    property FileCount: integer read fFileCount write fFileCount;
    property ReNewalCount: integer read fReNewalCount write fReNewalCount;
    property Notes: RawUTF8 read fNotes write fNotes;
  end;

implementation

//uses VarRecUtils, UnitStringUtil, UnitFolderUtil2, UnitRttiUtil2, DateUtils, UnitGSCommonUtil;

end.
