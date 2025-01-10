program HiConTCP;

uses
  Vcl.Forms,
  FrmHiConTCP in 'FrmHiConTCP.pas' {HiconisTCPF},
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
  FrmTagInputEdit in '..\..\Common\FrmTagInputEdit.pas' {TagEditF},
  UnitNICUtil in '..\..\..\..\Common\UnitNICUtil.pas',
  UnitHiconMariaDBUtil in '..\UnitHiconMariaDBUtil.pas',
  UnitHiConJsonUtil in 'UnitHiConJsonUtil.pas',
  UnitHiconMPMData in '..\UnitHiconMPMData.pas',
  FrmTwoInputEdit in '..\..\..\..\Common\Form\FrmTwoInputEdit.pas' {TwoInputEditF},
  FrmHiConTCPConfig in 'FrmHiConTCPConfig.pas' {HiConTCPConfigF},
  FrmResPortInfo4INFTag in 'FrmResPortInfo4INFTag.pas' {ResPortInfo4INFTagF},
  FrmNextGrid in '..\..\..\..\Common\Form\FrmNextGrid.pas',
  FrmSearchModuleByTagName in 'FrmSearchModuleByTagName.pas' {SrchModuleByTagF},
  UnitHiconDBData in '..\UnitHiconDBData.pas',
  UnitHiconOWSUtil in '..\UnitHiconOWSUtil.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(THiconisTCPF, HiconisTCPF);
  Application.Run;
end.
