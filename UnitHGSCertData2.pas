unit UnitHGSCertData2;

interface

uses System.Classes, UnitEnumHelper;

type
  TCertQueryDateType = (cqdtNull, cqdtTrainedPeriod, cqdtValidityUntilDate,
    cqdtCertIssueDate, cqdtAPTServiceDate, cqdtInvoiceIssueDate,



    hctLicBasic, hctLicInter, hctLicAdv, hctFinal);
  THGSCertTypes = set of THGSCertType;
  TCertFindCondition = (cfcNull, cfcNoResultRelpy, cfcNoInvConfirm, cfcNoPaied,
    cfcLastQAPTListOnSuccess, cfcVesselListWithNoAPTInPeriod, cfcFinal);
  THGSCertDocType = (hcdtNull, hcdtEducation, hcdtAPTCoC, hcdtAPTCheckList, hcdtServiceReport,
    hcdtProductApproval, hcdtEducation_Entrust, hcdtFinal);

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

  R_CertQueryDateType : array[Low(TCertQueryDateType)..High(TCertQueryDateType)] of string =
    ('', 'Trained Period', 'Validity Until Date', 'Cert. Issue Date',



    ('', 'Education', 'APT Service', 'Product Approval', 'Entrust Education',


    ('', 'E', 'S', 'A', 'ETE','LB','LI','LA','');

    ('',






    ('',








var
  g_CertQueryDateType: TLabelledEnum<TCertQueryDateType>;
  g_HGSCertType: TLabelledEnum<THGSCertType>;
  g_HGSCertTypeCode: TLabelledEnum<THGSCertType>;
  g_CertFindCondition: TLabelledEnum<TCertFindCondition>;
  g_HGSCertDocType: TLabelledEnum<THGSCertDocType>;

implementation

initialization
//  g_CertQueryDateType.InitArrayRecord(R_CertQueryDateType);
//  g_HGSCertType.InitArrayRecord(R_HGSCertType);
//  g_HGSCertTypeCode.InitArrayRecord(R_HGSCertTypeCode);
//  g_CertFindCondition.InitArrayRecord(R_CertFindCondition);
//  g_HGSCertDocType.InitArrayRecord(R_HGSCertDocType);

end.