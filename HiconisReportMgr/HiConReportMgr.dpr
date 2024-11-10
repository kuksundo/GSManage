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
  UnitHiConReportMakeUtil in 'UnitHiConReportMakeUtil.pas',
  UnitFrameFileList2 in '..\..\..\Common\Frame\UnitFrameFileList2.pas' {JHPFileListFrame: TFrame},
  FrmHiChangeRegisterEdit in 'FrmHiChangeRegisterEdit.pas' {HiChgRegItemF},
  FrameVesselInfo in '..\Common\FrameVesselInfo.pas' {VesselInfoFr: TFrame},
  UnitHiConChgRegItemOrm in 'UnitHiConChgRegItemOrm.pas',
  FrmHiChgRegList in 'FrmHiChgRegList.pas' {ChgRegListF},
  UnitHiConRptDM in 'UnitHiConRptDM.pas' {DataModule1: TDataModule},
  UnitHiConReportMgR in '..\..\..\NoGitHub\RecordUnit2\HiconisReportMgr\UnitHiConReportMgR.pas',
  UnitRegAppUtil in '..\..\..\NoGitHub\RegCodeManager2\Common\UnitRegAppUtil.pas',
  UnitHMSSignatureOrm in '..\Common\UnitHMSSignatureOrm.pas',
  UnitFileInfoUtil in '..\..\..\Common\UnitFileInfoUtil.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(THiConReportListF, HiConReportListF);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
