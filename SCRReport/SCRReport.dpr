program SCRReport;

uses
  Vcl.Forms,
  DomSCRParameterType in 'Dom\DomSCRParameterType.pas',
  UStartUp in 'Unit\UStartUp.pas',
  IntfNotifier in 'Unit\IntfNotifier.pas',
  UStatusBarMgrBase in '..\..\..\Template\Dabbler\Unit\UStatusBarMgrBase.pas',
  UStatusBarMgr in 'Unit\UStatusBarMgr.pas',
  FrmSCRAppSetting in 'FrmSCRAppSetting.pas' {SCRAppSettingF},
  FrmSCRGESetting in 'FrmSCRGESetting.pas' {SCRGESettingF},
  FrmSCRMESetting in 'FrmSCRMESetting.pas' {SCRMESettingF},
  FrmSCRSetting in 'FrmSCRSetting.pas' {SCRSettingF},
  FrmSCRReportMain in 'FrmSCRReportMain.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  if not TStartUp.Execute then
  begin
    Application.Terminate;
    Exit;
  end;

  Application.CreateForm(TSCRSettingF, SCRSettingF);
  Application.Run;
end.
