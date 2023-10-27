program SCRReport_Dev;

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
  FrmSCRReportMain in 'FrmSCRReportMain.pas' {SCRReportF},
  UnitDialogUtil in '..\..\..\Common\UnitDialogUtil.pas',
  IniPersist in '..\..\..\..\..\..\project\OpenSrc\lib\robstechcorner\rtti\IniPersist.pas',
  USCRParamClass in 'Unit\USCRParamClass.pas',
  UnitNextGridUtil2 in '..\..\..\Common\UnitNextGridUtil2.pas',
  UDragDropFormat_SCRParam in 'Unit\UDragDropFormat_SCRParam.pas',
  UCommonUtil in 'Unit\UCommonUtil.pas',
  UAppInfo in 'Unit\UAppInfo.pas',
  USettings in '..\..\..\Template\Dabbler\Unit\USettings.pas',
  USettingsConst in 'Unit\USettingsConst.pas',
  FrmSCRSetting in 'FrmSCRSetting.pas' {SCRSettingF};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  if not TStartUp.Execute then
  begin
    Application.Terminate;
    Exit;
  end;

  Application.CreateForm(TSCRReportF, SCRReportF);
  Application.Run;
end.
