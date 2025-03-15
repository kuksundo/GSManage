program HiConSvcManager;

uses
  Vcl.Forms,
  FrmHiSvcManage in 'FrmHiSvcManage.pas' {Form2},
  FrmWinServiceEdit in '..\..\..\..\Common\Form\FrmWinServiceEdit.pas' {WinServiceEditF},
  FrmElapsedTime in '..\..\..\..\Common\Form\FrmElapsedTime.pas' {ElapsedTimeF};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
