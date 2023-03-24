program CertManageR2;

uses
  Vcl.Forms,
  mormot.db.raw.sqlite3.static,
  FrmCertManage2 in 'FrmCertManage2.pas' {CertManageF},
  Vcl.Themes,
  Vcl.Styles,
  UnitEnumHelper in '..\..\..\..\..\..\project\common\UnitEnumHelper.pas',
  UnitHGSCertRecord2 in 'UnitHGSCertRecord2.pas',
  UnitHGSCertData2 in '..\UnitHGSCertData2.pas',
  FrmCertEdit2 in 'FrmCertEdit2.pas',
  FrmFileSelect in '..\..\..\..\..\..\project\util\GSManage\FrmFileSelect.pas',
  UnitStringUtil in '..\..\..\..\..\..\project\common\UnitStringUtil.pas',
  UnitHGSSerialRecord2 in '..\Common\UnitHGSSerialRecord2.pas',
  UnitQRCodeFrame in '..\..\..\..\..\..\project\Template\UnitQRCodeFrame.pas' {QRCodeFrame},
  UnitGSCommonUtil in '..\..\..\..\..\..\project\util\GSManage\UnitGSCommonUtil.pas',
  UnitHGSCurriculumRecord2 in '..\Common\UnitHGSCurriculumRecord2.pas',
  UnitMakeXls2 in '..\Common\UnitMakeXls2.pas',
  UnitExcelUtil in '..\..\..\..\..\..\project\common\UnitExcelUtil.pas',
  FrmCourseManage2 in '..\CourseManager2\FrmCourseManage2.pas' {CourseManageF},
  UnitHGSCurriculumData2 in '..\UnitHGSCurriculumData2.pas',
  FrmCourseEdit2 in '..\CourseManager2\FrmCourseEdit2.pas',
  UnitMSWordUtil in '..\..\..\..\..\..\project\common\UnitMSWordUtil.pas',
  FrmSearchCustomer2 in '..\FrmSearchCustomer2.pas',
  CommonData2 in '..\Common\CommonData2.pas',
  UnitEngineMasterData in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitEngineMasterData.pas',
  UnitElecServiceData in '..\..\..\..\..\..\project\util\GSManage\UnitElecServiceData.pas',
  FrmSelectProductType2 in '..\FrmSelectProductType2.pas',
  UnitTodoCollect2 in '..\Common\UnitTodoCollect2.pas',
  UnitMakeReport2 in '..\UnitMakeReport2.pas',
  UnitHGSVDRRecord2 in '..\VDRManager2\UnitHGSVDRRecord2.pas',
  UnitHGSVDRData in '..\..\..\..\..\..\project\util\GSManage\VDRManage\UnitHGSVDRData.pas',
  FrmCertNoFormat2 in 'FrmCertNoFormat2.pas' {CertNoFormatF},
  FrmSearchVessel2 in '..\FrmSearchVessel2.pas',
  UnitVesselMasterRecord2 in '..\VesselList\UnitVesselMasterRecord2.pas',
  FrmSearchVDR2 in 'FrmSearchVDR2.pas' {SearchVDRF},
  UnitFormUtil in '..\..\..\..\..\..\project\common\UnitFormUtil.pas',
  FrmGSFileList2 in '..\FrmGSFileList2.pas',
  DelphiZXIngQRCode in '..\..\..\..\..\..\project\OpenSrc\lib\DelphiZXingQRCodeEx-master\DelphiZXingQRCodeEx-master\Source\DelphiZXIngQRCode.pas',
  QR_URL in '..\..\..\..\..\..\project\OpenSrc\lib\DelphiZXingQRCodeEx-master\DelphiZXingQRCodeEx-master\Source\QR_URL.pas',
  QR_Win1251 in '..\..\..\..\..\..\project\OpenSrc\lib\DelphiZXingQRCodeEx-master\DelphiZXingQRCodeEx-master\Source\QR_Win1251.pas',
  QRGraphics in '..\..\..\..\..\..\project\OpenSrc\lib\DelphiZXingQRCodeEx-master\DelphiZXingQRCodeEx-master\Source\QRGraphics.pas',
  FrmEditTariff2 in '..\TariffManager2\FrmEditTariff2.pas',
  UnitGSTariffRecord2 in '..\Common\UnitGSTariffRecord2.pas',
  fFrmEditTariffItem2 in '..\TariffManager2\fFrmEditTariffItem2.pas',
  FrmDisplayTariff2 in '..\TariffManager2\FrmDisplayTariff2.pas',
  UnitGSTriffData in '..\..\..\..\..\..\project\util\GSManage\UnitGSTriffData.pas',
  FrmInvoiceNoEdit in '..\..\..\..\..\..\project\util\GSManage\InvoiceManage\FrmInvoiceNoEdit.pas' {InvoiceNoEditF},
  UnitWebSocketServer2 in '..\..\..\Common\UnitWebSocketServer2.pas',
  UnitWebSocketClient2 in '..\..\..\Common\UnitWebSocketClient2.pas',
  OLMailWSCallbackInterface2 in '..\..\OutlookAddIn2\OLMailWSCallbackInterface2.pas',
  UnitGAConfigClass2 in '..\Common\UnitGAConfigClass2.pas',
  UnitHttpModule4InqManageServer2 in '..\Common\UnitHttpModule4InqManageServer2.pas',
  FrmEmailListView2 in '..\FrmEmailListView2.pas' {EmailListViewF},
  UnitOLEmailRecord2 in '..\..\..\Common\UnitOLEmailRecord2.pas',
  UnitGAServiceData in '..\..\..\..\..\..\project\util\GSManage\GAManageR\UnitGAServiceData.pas',
  UnitStrategy4OLEmailInterface2 in '..\Common\UnitStrategy4OLEmailInterface2.pas',
  UnitStrategy4VDRAPTCert2 in '..\UnitStrategy4VDRAPTCert2.pas',
  FrmInvoiceIssueDateEdit in '..\..\..\..\..\..\project\util\GSManage\InvoiceManage\FrmInvoiceIssueDateEdit.pas' {InvoiceIssueDateEditF},
  FrmNoteEdit in '..\..\..\..\..\..\project\util\GSManage\CertManage\FrmNoteEdit.pas' {NoteEditF},
  UnitMQData in '..\..\..\..\..\..\project\common\UnitMQData.pas',
  FrmAboutF in '..\..\..\..\..\..\project\util\GSManage\FrmAboutF.pas' {AboutF},
  UnitIPCModule2 in '..\Common\UnitIPCModule2.pas',
  UnitDateUtil in '..\..\..\..\..\..\project\common\UnitDateUtil.pas',
  UnitElecMasterData in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitElecMasterData.pas',
  UnitGAMasterRecord2 in '..\Common\UnitGAMasterRecord2.pas',
  UnitOutlookIPCUtil2 in '..\Common\UnitOutlookIPCUtil2.pas',
  FrmCertManageConfig in '..\..\..\..\..\..\project\util\GSManage\CertManage\FrmCertManageConfig.pas',
  UnitCertManageConfigClass2 in 'UnitCertManageConfigClass2.pas',
  FrameOLEmailList2 in '..\..\..\Common\Frame\FrameOLEmailList2.pas',
  UnitServerConfigBase2 in '..\Common\UnitServerConfigBase2.pas',
  HiMECSConst in '..\..\..\..\..\..\project\util\HiMECS\Application\Source\Common\HiMECSConst.pas',
  UnitMSPPTUtil in '..\..\..\..\..\..\project\common\UnitMSPPTUtil.pas',
  UnitCertManager2 in '..\..\..\NoGitHub\RecordUnit2\CertManager2\UnitCertManager2.pas',
  EasterEgg in '..\..\..\..\..\..\project\common\EasterEgg.pas',
  uSMBIOS in '..\..\..\..\..\..\project\OpenSrc\lib\TSmBios\Common\uSMBIOS.pas',
  UnitFrameFileList2 in '..\..\..\Common\Frame\UnitFrameFileList2.pas',
  UnitJHPFileData in '..\..\..\Common\DataType\UnitJHPFileData.pas',
  UnitJHPFileRecord in '..\..\..\Common\DataType\UnitJHPFileRecord.pas',
  UnitOrmFileClient in '..\..\HiMECS2\Utility\HiMECS_Watch2\UnitOrmFileClient.pas',
  UnitCertManagerCLO in 'UnitCertManagerCLO.pas',
  UnitHGSLicenseRecord in 'UnitHGSLicenseRecord.pas',
  UnitHGSBaseRecord in 'UnitHGSBaseRecord.pas';

{$R *.res}

//const
  //UnitCryptUtil.EncryptString_Syn3('{AF700786-5B91-4FB5-A506-C12C0BC44339}')
//  OriginalProductCode = '1J/fftLlv4d035HPSC3FFEDaRLtt/q/28oOO9GUQIi7oQWfd+Ryez8cNm7NWnsTe';

begin
  {$IfDef USE_REGCODE}
    //UnitCryptUtil.EncryptString_Syn('{AF700786-5B91-4FB5-A506-C12C0BC44339}', False)
//    CheckRegistration2('p8T1JIJrPK31RFmN2mM9HbHvTazn58KBLG+PezClaRcCWfoBc/LB2UyxxvZmEr1h', [crmHTTP], True, False);
  {$EndIf USE_REGCODE}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TCertManageF, CertManageF);
  Application.Run;
end.
