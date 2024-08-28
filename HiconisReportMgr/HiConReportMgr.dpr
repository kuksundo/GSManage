program HiConReportMgr;

uses
  Vcl.Forms,
  mormot.db.raw.sqlite3.static,
  FrmHiconReportList in 'FrmHiconReportList.pas' {HiConReportListF},
  UnitCheckGrpAdvUtil in '..\..\..\Common\UnitCheckGrpAdvUtil.pas',
  UnitHiConReportListOrm in 'UnitHiConReportListOrm.pas',
  UnitHiConReportWorkItemOrm in 'UnitHiConReportWorkItemOrm.pas',
  UnitHiConReportMgrData in 'UnitHiConReportMgrData.pas',
  FrmHiconReportEdit in 'FrmHiconReportEdit.pas' {HiConReportEditF},
  FrmHiReportWorkItemEdit in 'FrmHiReportWorkItemEdit.pas' {RptWorkItemF},
  UnitHiConReportMakeUtil in 'UnitHiConReportMakeUtil.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(THiConReportListF, HiConReportListF);
  Application.CreateForm(THiConReportEditF, HiConReportEditF);
  Application.CreateForm(TRptWorkItemF, RptWorkItemF);
  Application.Run;
end.
