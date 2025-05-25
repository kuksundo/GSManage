program HiconFBLogic;

uses
  Vcl.Forms,
  mormot.db.raw.sqlite3.static,
  FrmIpList in '..\HiConChkDuplicateID\FrmIpList.pas' {IPListF},
  FrmInputIpAddress in '..\..\..\..\Common\Form\FrmInputIpAddress.pas',
  UnitChkDupIdData in '..\HiConChkDuplicateID\UnitChkDupIdData.pas',
  UnitTRegExUtil in '..\..\..\..\Common\UnitTRegExUtil.pas',
  UnitHtmlUtil in '..\..\..\..\Common\UnitHtmlUtil.pas',
  UnitHiConTCPWorker in '..\HiConChkDuplicateID\UnitHiConTCPWorker.pas',
  UnitCryptUtil3 in '..\..\..\..\NoGitHub\Util\UnitCryptUtil3.pas',
  UnitHiconSystemDBUtil in '..\UnitHiconSystemDBUtil.pas',
  UnitAnimationThread in '..\..\..\..\Common\Dom\UnitAnimationThread.pas',
  FrmElapsedTime in '..\..\..\..\Common\Form\FrmElapsedTime.pas' {ElapsedTimeF},
  UnitHiConInfluxDBUtil in '..\HiConChkDuplicateID\UnitHiConInfluxDBUtil.pas',
  UnitNICUtil in '..\..\..\..\Common\UnitNICUtil.pas',
  UnitHiconMariaDBUtil in '..\UnitHiconMariaDBUtil.pas',
  UnitHiConJsonUtil in '..\HiConChkDuplicateID\UnitHiConJsonUtil.pas',
  UnitHiconMPMData in '..\UnitHiconMPMData.pas',
  FrmTwoInputEdit in '..\..\..\..\Common\Form\FrmTwoInputEdit.pas' {TwoInputEditF},
  FrmHiConTCPConfig in '..\HiConChkDuplicateID\FrmHiConTCPConfig.pas' {HiConTCPConfigF},
  FrmNextGrid in '..\..\..\..\Common\Form\FrmNextGrid.pas',
  FrmSearchModuleByTagName in '..\HiConChkDuplicateID\FrmSearchModuleByTagName.pas' {SrchModuleByTagF},
  UnitHiconDBData in '..\UnitHiconDBData.pas',
  UnitHiconOWSUtil in '..\UnitHiconOWSUtil.pas',
  FrmLogInWithIPAddr in '..\..\..\..\Common\Form\FrmLogInWithIPAddr.pas' {LogInWithIPAddrF},
  UnitHiConFuncCodeOrm in '..\HiConChkDuplicateID\UnitHiConFuncCodeOrm.pas',
  UnitMakeHiconDBUtil in '..\UnitMakeHiconDBUtil.pas',
  FrmJHPWaitForm in '..\..\..\..\Common\Form\FrmJHPWaitForm.pas' {WaitForm},
  UnitHiConMPMWebUtil in '..\HiConChkDuplicateID\UnitHiConMPMWebUtil.pas',
  UnitHiConMPMFileUtil in '..\HiConChkDuplicateID\UnitHiConMPMFileUtil.pas',
  UnitElfReader in '..\..\..\..\Common\UnitElfReader.pas',
  PJVersionInfo in '..\..\..\..\OpenSrc\lib\DelphiDabbler\dd-versioninfo\PJVersionInfo.pas',
  UnitWMIUtil in '..\..\..\..\Common\UnitWMIUtil.pas',
  UnitRegAppUtil in '..\..\..\..\NoGitHub\RegCodeManager2\Common\UnitRegAppUtil.pas',
  UnitOLEVarUtil in '..\..\..\..\Common\UnitOLEVarUtil.pas',
  UnitLanUtil2 in '..\..\..\..\Common\UnitLanUtil2.pas',
  UnitHiConMPMWebInfUtil in '..\HiConChkDuplicateID\UnitHiConMPMWebInfUtil.pas',
  UnitMenuItemUtil in '..\..\..\..\Common\UnitMenuItemUtil.pas',
  FrmHiCONFBLogic in 'FrmHiCONFBLogic.pas' {HiCONFBLogicF},
  UnitSQLUtil in '..\..\..\..\Common\UnitSQLUtil.pas',
  UnitDynamicFormManager in '..\..\..\..\Common\UnitDynamicFormManager.pas',
  FrmTagInputEdit in '..\..\Common\FrmTagInputEdit.pas' {TagEditF},
  UnitControlMoveResize in '..\..\..\..\Common\UnitControlMoveResize.pas',
  GpCommandLineParser in '..\..\..\..\..\..\..\project\OpenSrc\lib\GpDelphiUnit\src\GpCommandLineParser.pas',
  UnitFBLogicCLO in 'UnitFBLogicCLO.pas',
  UnitFileInfoUtil in '..\..\..\..\Common\UnitFileInfoUtil.pas',
  mormot.core.base in '..\..\..\..\OpenSrc\lib\mORMot2-master\src\core\mormot.core.base.pas',
  mormot.core.os in '..\..\..\..\OpenSrc\lib\mORMot2-master\src\core\mormot.core.os.pas';

{$R *.res}

//{C0F5DD8A-BEA6-4666-826C-6F4A45E606B9}=Prod Code -> Version Info -> InternalName에 Encrypted로 저장됨
//UnitCryptUtil2.EncryptString_Syn3()를 이용하여 암호화 함
//Encrypted: 37OO333NvHzZRzjjztCSwBHCxJivxybdg/1PLN1CGNpROcUdpu+8p+bajn/WtKwh

function GetCommandLineParameter: boolean;
var
  LCommandLine: TCLO4FBLogic;
  LMsg: string;
begin
  Result := False;

  TCLO4FBLogic.CommandLineParse(LCommandLine, LMsg);
  try
    //AppSigInfo를 Delete하는 Option
    if LCommandLine.DeleteAppSigInfo then
    begin
      //비교할 AppSigInfo가 공란이 아닌 경우
      //저장된 AppSigInof와 AppSigInfo64가 같은 경우에만 Delete가 수행됨
      if LCommandLine.AppSigInfo64 <> '' then
      begin
        TgpAppSigInfo.DeleteAppSigInfo2RegistryByBase64(LCommandLine.AppSigInfo64, '');
      end;
    end;

    //AppSigInfo를 c:\temp\gpappinfo.txt파일에 저장하는 Option
    if LCommandLine.CreateAppSigInfoFile then
    begin
      //Product Code를 Base64로 입력 받음
      if LCommandLine.ProdCode64 <> '' then
      begin
        if UnitFileInfoUtil.GetInternalNameByPJVerInfo('') = LCommandLine.ProdCode64 then
        begin
          LMsg := TgpAppSigInfo.GetAppSigInfo2Base64ByRegPath('');
          FileFromString(LMsg, 'c:\temp\gpappinfo.txt');
        end;
      end;
    end;

    if LCommandLine.ExitApp then
      Halt(0);
  finally
    LCommandLine.Free;
  end;
end;

begin
  GetCommandLineParameter();

  if UnitRegAppUtil.TgpAppSigInfo.CheckRegByAppSigUsingRegistry('') <> -1 then
  begin
    TgpAppSigInfo.FCheckStrResult := 'CheckRegByAppSigUsingRegistry Result : ' + TgpAppSigInfo.FCheckStrResult;
    FileFromString(TgpAppSigInfo.FCheckStrResult, 'c:\temp\gpappinfo.txt');
    exit;
  end;

  TCLO4FBLogic.FRegAppInfoB64 := TgpAppSigInfo.GetAppSigInfo2Base64ByRegPath('');

//  if not TLogin4OTP.ShowLogin then
//    exit;

  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(THiCONFBLogicF, HiCONFBLogicF);
  Application.Run;
end.
