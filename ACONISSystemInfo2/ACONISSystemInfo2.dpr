program ACONISSystemInfo2;

uses
  Vcl.Forms,
  FrmEASAlarm in 'FrmEASAlarm.pas' {SetACONISF},
  UnitIniFileUtil in '..\..\..\Common\UnitIniFileUtil.pas',
  FrmSystemInfo in 'FrmSystemInfo.pas' {AconisSysInfoF},
  UnitTreeListUtil in '..\..\..\Common\UnitTreeListUtil.pas',
  FrameIniTreeList in '..\..\..\Common\Frame\FrameIniTreeList.pas' {IniTreeListFr: TFrame},
  FrmInputEdit in '..\..\..\..\..\..\project\common\Forms\FrmInputEdit.pas' {InputEditF},
  FrmInfluxDBConf in 'FrmInfluxDBConf.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TAconisSysInfoF, AconisSysInfoF);
  Application.CreateForm(TInputEditF, InputEditF);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
