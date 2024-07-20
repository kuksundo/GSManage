program HiConChkDuplicateID;

uses
  Vcl.Forms,
  FrmHiConChkDuplicateID in 'FrmHiConChkDuplicateID.pas' {CheckDupIdF},
  FrmIpList in 'FrmIpList.pas' {IPListF},
  FrmInputIpAddress in '..\..\..\..\Common\Form\FrmInputIpAddress.pas',
  UnitChkDupIdData in 'UnitChkDupIdData.pas',
  UnitTRegExUtil in '..\..\..\..\Common\UnitTRegExUtil.pas',
  UnitHtmlUtil in '..\..\..\..\Common\UnitHtmlUtil.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TCheckDupIdF, CheckDupIdF);
  Application.Run;
end.
