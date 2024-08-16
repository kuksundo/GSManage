program HiConReportMgr;

uses
  Vcl.Forms,
  FrmHiconReportList in 'FrmHiconReportList.pas' {Form2},
  UnitCheckGrpAdvUtil in '..\..\..\Common\UnitCheckGrpAdvUtil.pas',
  UnitHiConReportListOrm in 'UnitHiConReportListOrm.pas',
  UnitHiConReportWorkItemOrm in 'UnitHiConReportWorkItemOrm.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
