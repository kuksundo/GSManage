unit UnitHGSBaseRecord;

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
    fCompanyName2, //ȸ�� �̸� ���
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
    fQRCodeImage: TSQLRawBlob;//Cert ������ ��ȣȭ �Ͽ� ������
    fPhoto: TSQLRawBlob;//���� ������
    fIsCryptSerial,           //�ø��� ��ȣ ��ȣȭ ����
    fIsIgnoreInvoice: Boolean;//Invoice ���� �� �ƴ�
    fProductType: TShipProductType;
    fCertType: THGSCertType; //������ ���� ����

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


    property CompanyName: RawUTF8 read fCompanyName write fCompanyName;
    property CompanyName2: RawUTF8 read fCompanyName2 write fCompanyName2;
    property CompanyCode: RawUTF8 read fCompanyCode write fCompanyCode;


    property InvoiceCompanyCode: RawUTF8 read fInvoiceCompanyCode write fInvoiceCompanyCode;


    property OrderNo: RawUTF8 read fOrderNo write fOrderNo;
    property SalesAmount: RawUTF8 read fSalesAmount write fSalesAmount;
    property CertFileDBPath: RawUTF8 read fCertFileDBPath write fCertFileDBPath;
    property CertFileDBName: RawUTF8 read fCertFileDBName write fCertFileDBName;





    property IssueDate: TTimeLog read fIssueDate write fIssueDate;






    property Notes: RawUTF8 read fNotes write fNotes;
  end;

implementation

end.