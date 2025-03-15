program HiConTCP_Bug;

uses
  Vcl.Forms,
  mormot.db.raw.sqlite3.static,
  FrmHiConTCP in 'FrmHiConTCP.pas' {HiconisTCPF},
  FrmInputIpAddress in '..\..\..\..\Common\Form\FrmInputIpAddress.pas',
  UnitTRegExUtil in '..\..\..\..\Common\UnitTRegExUtil.pas',
  UnitHtmlUtil in '..\..\..\..\Common\UnitHtmlUtil.pas',
  UnitCryptUtil3 in '..\..\..\..\NoGitHub\Util\UnitCryptUtil3.pas',
  UnitHiconSystemDBUtil in '..\UnitHiconSystemDBUtil.pas',
  UnitAnimationThread in '..\..\..\..\Common\Dom\UnitAnimationThread.pas',
  FrmElapsedTime in '..\..\..\..\Common\Form\FrmElapsedTime.pas' {ElapsedTimeF},
  FrmTagInputEdit in '..\..\Common\FrmTagInputEdit.pas' {TagEditF},
  UnitNICUtil in '..\..\..\..\Common\UnitNICUtil.pas',
  UnitHiconMariaDBUtil in '..\UnitHiconMariaDBUtil.pas',
  UnitHiconMPMData in '..\UnitHiconMPMData.pas',
  FrmTwoInputEdit in '..\..\..\..\Common\Form\FrmTwoInputEdit.pas' {TwoInputEditF},
  FrmNextGrid in '..\..\..\..\Common\Form\FrmNextGrid.pas',
  UnitHiconDBData in '..\UnitHiconDBData.pas',
  UnitHiconOWSUtil in '..\UnitHiconOWSUtil.pas',
  FrmLogInWithIPAddr in '..\..\..\..\Common\Form\FrmLogInWithIPAddr.pas' {LogInWithIPAddrF},
  UnitMakeHiconDBUtil in '..\UnitMakeHiconDBUtil.pas',
  FrmJHPWaitForm in '..\..\..\..\Common\Form\FrmJHPWaitForm.pas' {WaitForm},
  UnitElfReader in '..\..\..\..\Common\UnitElfReader.pas',
  PJVersionInfo in '..\..\..\..\OpenSrc\lib\DelphiDabbler\dd-versioninfo\PJVersionInfo.pas',
  UnitWMIUtil in '..\..\..\..\Common\UnitWMIUtil.pas',
  UnitRegAppUtil in '..\..\..\..\NoGitHub\RegCodeManager2\Common\UnitRegAppUtil.pas',
  UnitOLEVarUtil in '..\..\..\..\Common\UnitOLEVarUtil.pas',
  UnitLanUtil2 in '..\..\..\..\Common\UnitLanUtil2.pas';

{$R *.res}

//{51C38D1E-7304-4CDB-82FE-365B23A49649}=Prod Code -> Version Info -> InternalName에 Encrypted로 저장됨
//UnitCryptUtil2.EncryptString_Syn3()를 이용하여 암호화 함
//Encrypted: g3hwVr4cMXsdkmV/GWcDabv273kmtoJPJvN+tvPQl1EgBb1Ki0GH4nM/lNWxHe1N

begin
//  if not UnitRegAppUtil.CheckRegByAppSigUsingRegistry('') then
//    exit;

//  if not TLogin4OTP.ShowLogin then
//    exit;

  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(THiconisTCPF, HiconisTCPF);
  Application.Run;
end.
