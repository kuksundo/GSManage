program FBLogic;

uses
  Vcl.Forms,
  mormot.db.raw.sqlite3.static,
  FrmIpList in 'FrmIpList.pas' {IPListF},
  FrmInputIpAddress in '..\..\..\..\Common\Form\FrmInputIpAddress.pas',
  UnitChkDupIdData in 'UnitChkDupIdData.pas',
  UnitTRegExUtil in '..\..\..\..\Common\UnitTRegExUtil.pas',
  UnitHtmlUtil in '..\..\..\..\Common\UnitHtmlUtil.pas',
  UnitHiConTCPWorker in 'UnitHiConTCPWorker.pas',
  UnitCryptUtil3 in '..\..\..\..\NoGitHub\Util\UnitCryptUtil3.pas',
  UnitHiconSystemDBUtil in '..\UnitHiconSystemDBUtil.pas',
  UnitAnimationThread in '..\..\..\..\Common\Dom\UnitAnimationThread.pas',
  FrmElapsedTime in '..\..\..\..\Common\Form\FrmElapsedTime.pas' {ElapsedTimeF},
  UnitHiConInfluxDBUtil in 'UnitHiConInfluxDBUtil.pas',
  UnitNICUtil in '..\..\..\..\Common\UnitNICUtil.pas',
  UnitHiconMariaDBUtil in '..\UnitHiconMariaDBUtil.pas',
  UnitHiConJsonUtil in 'UnitHiConJsonUtil.pas',
  UnitHiconMPMData in '..\UnitHiconMPMData.pas',
  FrmTwoInputEdit in '..\..\..\..\Common\Form\FrmTwoInputEdit.pas' {TwoInputEditF},
  FrmHiConTCPConfig in 'FrmHiConTCPConfig.pas' {HiConTCPConfigF},
  FrmNextGrid in '..\..\..\..\Common\Form\FrmNextGrid.pas',
  FrmSearchModuleByTagName in 'FrmSearchModuleByTagName.pas' {SrchModuleByTagF},
  UnitHiconDBData in '..\UnitHiconDBData.pas',
  UnitHiconOWSUtil in '..\UnitHiconOWSUtil.pas',
  FrmLogInWithIPAddr in '..\..\..\..\Common\Form\FrmLogInWithIPAddr.pas' {LogInWithIPAddrF},
  UnitHiConFuncCodeOrm in 'UnitHiConFuncCodeOrm.pas',
  UnitMakeHiconDBUtil in '..\UnitMakeHiconDBUtil.pas',
  FrmJHPWaitForm in '..\..\..\..\Common\Form\FrmJHPWaitForm.pas' {WaitForm},
  UnitHiConMPMWebUtil in 'UnitHiConMPMWebUtil.pas',
  UnitHiConMPMFileUtil in 'UnitHiConMPMFileUtil.pas',
  UnitElfReader in '..\..\..\..\Common\UnitElfReader.pas',
  PJVersionInfo in '..\..\..\..\OpenSrc\lib\DelphiDabbler\dd-versioninfo\PJVersionInfo.pas',
  UnitWMIUtil in '..\..\..\..\Common\UnitWMIUtil.pas',
  UnitRegAppUtil in '..\..\..\..\NoGitHub\RegCodeManager2\Common\UnitRegAppUtil.pas',
  UnitOLEVarUtil in '..\..\..\..\Common\UnitOLEVarUtil.pas',
  UnitLanUtil2 in '..\..\..\..\Common\UnitLanUtil2.pas',
  UnitHiConMPMWebInfUtil in 'UnitHiConMPMWebInfUtil.pas',
  UnitMenuItemUtil in '..\..\..\..\Common\UnitMenuItemUtil.pas',
  FrmHiCONFBLogic in 'FrmHiCONFBLogic.pas' {HiCONFBLogicF},
  UnitSQLUtil in '..\..\..\..\Common\UnitSQLUtil.pas',
  UnitDynamicFormManager in '..\..\..\..\Common\UnitDynamicFormManager.pas',
  FrmTagInputEdit in '..\..\Common\FrmTagInputEdit.pas' {TagEditF},
  UnitControlMoveResize in '..\..\..\..\Common\UnitControlMoveResize.pas',
  GpCommandLineParser in '..\..\..\..\..\..\..\project\OpenSrc\lib\GpDelphiUnit\src\GpCommandLineParser.pas';

{$R *.res}

//{C0F5DD8A-BEA6-4666-826C-6F4A45E606B9}=Prod Code -> Version Info -> InternalName에 Encrypted로 저장됨
//UnitCryptUtil2.EncryptString_Syn3()를 이용하여 암호화 함
//Encrypted: 37OO333NvHzZRzjjztCSwBHCxJivxybdg/1PLN1CGNpROcUdpu+8p+bajn/WtKwh

begin
  if not UnitRegAppUtil.TgpAppSigInfo.CheckRegByAppSigUsingRegistry('') then
    exit;

//  if not TLogin4OTP.ShowLogin then
//    exit;

  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(THiCONFBLogicF, HiCONFBLogicF);
  Application.Run;
end.
