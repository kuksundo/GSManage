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
  FrmElapsedTime in '..\..\..\..\Common\Form\FrmElapsedTime.pas' {ElapsedTimeF};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(THiconisTCPF, HiconisTCPF);
  Application.Run;
end.
