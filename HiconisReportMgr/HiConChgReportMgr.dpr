program HiConChgReportMgr;

uses
  Vcl.Forms,
  mormot.db.raw.sqlite3.static,
  UnitCheckGrpAdvUtil in '..\..\..\Common\UnitCheckGrpAdvUtil.pas',
  UnitHiConReportListOrm in 'UnitHiConReportListOrm.pas',
  UnitHiConReportWorkItemOrm in 'UnitHiConReportWorkItemOrm.pas',
  UnitHiConReportMgrData in 'UnitHiConReportMgrData.pas',
  UnitHiConReportMakeUtil in 'UnitHiConReportMakeUtil.pas',
  UnitFrameFileList2 in '..\..\..\Common\Frame\UnitFrameFileList2.pas' {JHPFileListFrame: TFrame},
  FrmHiChangeRegisterEdit in 'FrmHiChangeRegisterEdit.pas' {HiChgRegItemF},
  FrameVesselInfo in '..\Common\FrameVesselInfo.pas' {VesselInfoFr: TFrame},
  UnitHiConChgRegItemOrm in 'UnitHiConChgRegItemOrm.pas',
  FrmHiChgRegList in 'FrmHiChgRegList.pas' {ChgRegListF},
  UnitHiConRptDM in 'UnitHiConRptDM.pas' {DataModule1: TDataModule},
  UnitHiConChgReportMgR in '..\..\..\NoGitHub\RecordUnit2\HiconisReportMgr\UnitHiConChgReportMgR.pas',
  UnitRegAppUtil in '..\..\..\NoGitHub\RegCodeManager2\Common\UnitRegAppUtil.pas',
  UnitHMSSignatureOrm in '..\Common\UnitHMSSignatureOrm.pas',
  UnitFileInfoUtil in '..\..\..\Common\UnitFileInfoUtil.pas',
  UnitHiConChgReportMgR2 in '..\..\..\NoGitHub\RecordUnit2\HiconisReportMgr\UnitHiConChgReportMgR2.pas',
  UnitLicRegInfoClass in '..\..\..\NoGitHub\RegCodeManager2\Common\UnitLicRegInfoClass.pas',
  UnitSetUtil in '..\..\..\Common\UnitSetUtil.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TChgRegListF, ChgRegListF);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
