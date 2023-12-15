unit UnitHGSCertData2;

interface

uses System.Classes, UnitEnumHelper;

type
  TCertQueryDateType = (cqdtNull, cqdtTrainedPeriod, cqdtValidityUntilDate,
    cqdtCertIssueDate, cqdtAPTServiceDate, cqdtInvoiceIssueDate,
    cqdtInvoiceConfirmDate, cqdtBillPaidDate, cqdtExcludeAPTDate, cqdtFinal);
  //hctEducation_Entrust: ¿ß≈π±≥¿∞¡ıº≠
  THGSCertType = (hctNull, hctEducation, hctAPTService, hctProductApproval, hctEducation_Entrust,
    hctLicBasic, hctLicInter, hctLicAdv, hctFinal);
  THGSCertTypes = set of THGSCertType;
  TCertFindCondition = (cfcNull, cfcValidityUntilLicDate, cfcNoResultRelpy, cfcNoInvConfirm, cfcNoPaied,
    cfcLastQAPTListOnSuccess, cfcVesselListWithNoAPTInPeriod, cfcFinal);
  THGSCertDocType = (hcdtNull, hcdtEducation, hcdtAPTCoC, hcdtAPTCheckList, hcdtServiceReport,
    hcdtProductApproval, hcdtEducation_Entrust, hcdtFinal);
//  TRamainExpireDate = (redNull, red6Month, red1Year);

const
  HGS_CERT_DB_NAME = 'HGSCertMaster.sqlite';
  HGS_LIC_DB_NAME = 'HGSLicMaster.sqlite';
  HGS_VDRLIST_DB_NAME = 'HGSVDRList.sqlite';

  ATR_FILENAME = 'ANNUAL_TEST_REPORT.pjh';
  COC_FILENAME = 'Certificate_of_compliance_with_field.pjh';
  EDU_FILENAME = 'Education_Cert.pjh';
  EDU_FILENAME2 = 'Education_Cert.pjh2';
  PROD_APPROVAL_FILENAME = 'APT_Approval_Certificate.pjh';
  VDRConfigFileName = 'VDRConfig.ini';
  LRCHECKLISTFileName = 'LR_Survey_Checklist_VDR.pjh';
  ABSCHECKLISTFileName = 'ABS_Check_List_VDR.pjh';
  LICLIST_FILENAME = 'LicenseList.ods';
  PHOTO_FILENAME = 'Photo.jpg';
  QRCODE_FILENAME = 'QRCode.png';
  LICCARD_BASIC_FILENAME = 'LicenseCard_Basic.pjh2';
  LICCARD_INTERM_FILENAME = 'LicenseCard_Interm.pjh2';
  LICCARD_ADVANCED_FILENAME = 'LicenseCard_Advanced.pjh2';

  R_CertQueryDateType : array[Low(TCertQueryDateType)..High(TCertQueryDateType)] of string =
    ('', 'Trained Period', 'Validity Until Date', 'Cert. Issue Date',
      'APT Service Date', 'Invoice Issue Date', 'Invoice Confirm Date',
      'Bill Paid Date', 'Exclude APT Date', '');
  R_HGSCertType : array[Low(THGSCertType)..High(THGSCertType)] of string =
    ('', 'Education', 'APT Service', 'Product Approval', 'Entrust Education',
      'Licence Basic', 'Licence Intermediate', 'Licence Advanced', '');
  R_HGSCertTypeCode : array[Low(THGSCertType)..High(THGSCertType)] of string =
    ('', 'E', 'S', 'A', 'ETE','LB','LI','LA','');
  R_CertFindCondition : array[Low(TCertFindCondition)..High(TCertFindCondition)] of string =
    ('',
      'Validity Until Licence Date',
      'No service result reply list ',
      'No invoice confirm list',
      'No paid list', 'Last Quarter APT List on successed',
      'Vessel List With No APT In Period',
    '');
  R_HGSCertDocType : array[Low(THGSCertDocType)..High(THGSCertDocType)] of string =
    ('',
      '±≥¿∞ ºˆ∑·¡ı',
      'APT Cert of Compliance',
      'APT Check List',
      'Service Report',
      'Product Approval',
      '±≥¿∞ ºˆ∑·¡ı(¿ß≈π)',
    '');
//  R_RemainExpireDate : array[Low(TRamainExpireDate)..High(TRamainExpireDate)] of string =
//    ('', '6 Month', '1 Year');

function GetLicCardColorFromCertType(ACertType: THGSCertType): string;
function IsLicenseCheckedFromCertType(ACertType: THGSCertType): Boolean;
function IsLicenseCheckedFromCertTypes(ACertTypes: THGSCertTypes): Boolean;

var
  g_CertQueryDateType: TLabelledEnum<TCertQueryDateType>;
  g_HGSCertType: TLabelledEnum<THGSCertType>;
  g_HGSCertTypeCode: TLabelledEnum<THGSCertType>;
  g_CertFindCondition: TLabelledEnum<TCertFindCondition>;
  g_HGSCertDocType: TLabelledEnum<THGSCertDocType>;
//  g_RemainExpireDate: TLabelledEnum<TRamainExpireDate>;

implementation

function GetLicCardColorFromCertType(ACertType: THGSCertType): string;
begin
  case ACertType of
    hctLicBasic: Result := '≥Î∂˚';
    hctLicInter: Result := '√ ∑œ';
    hctLicAdv: Result := '¡÷»≤';
  else
    Result := '';
  end;
end;

function IsLicenseCheckedFromCertType(ACertType: THGSCertType): Boolean;
begin
  Result := (hctLicBasic = ACertType) or
            (hctLicInter = ACertType) or
            (hctLicAdv = ACertType);
end;

function IsLicenseCheckedFromCertTypes(ACertTypes: THGSCertTypes): Boolean;
begin
 Result := (hctLicBasic in ACertTypes) or
           (hctLicInter in ACertTypes) or
           (hctLicAdv in ACertTypes);
end;

initialization
//  g_CertQueryDateType.InitArrayRecord(R_CertQueryDateType);
//  g_HGSCertType.InitArrayRecord(R_HGSCertType);
//  g_HGSCertTypeCode.InitArrayRecord(R_HGSCertTypeCode);
//  g_CertFindCondition.InitArrayRecord(R_CertFindCondition);
//  g_HGSCertDocType.InitArrayRecord(R_HGSCertDocType);
//  g_RemainExpireDate.InitArrayRecord(R_RemainExpireDate);

end.
