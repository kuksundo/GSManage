program ACONISSystemInfo2;

uses
  Vcl.Forms,
  FrmEASAlarm in 'FrmEASAlarm.pas' {SetACONISF},
  UnitIniFileUtil in '..\..\..\..\..\..\project\common\UnitIniFileUtil.pas',
  FrmSystemInfo in 'FrmSystemInfo.pas' {AconisSysInfoF},
  UnitTreeListUtil in '..\..\..\Common\UnitTreeListUtil.pas',
  FrameIniTreeList in '..\..\..\Common\Frame\FrameIniTreeList.pas' {IniTreeListFr: TFrame},
  FrmInputEdit in '..\..\..\..\..\..\project\common\Forms\FrmInputEdit.pas' {InputEditF};

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TAconisSysInfoF, AconisSysInfoF);
  Application.CreateForm(TInputEditF, InputEditF);
  Application.Run;
end.
