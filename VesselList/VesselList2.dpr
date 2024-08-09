program VesselList2;

uses
  Vcl.Forms,
  SynSqlite3Static,
  frmHiMAPDetail in '..\..\..\..\..\..\project\util\GSManage\HiMAPManage\frmHiMAPDetail.pas' {HiMAPDetailF},
  UnitHiMAPData in '..\..\..\..\..\..\project\util\GSManage\HiMAPManage\UnitHiMAPData.pas',
  FrmVesselList2 in 'FrmVesselList2.pas' {VesselListF},
  UnitVesselMasterRecord2 in '..\UnitVesselMasterRecord2.pas',
  CommonData in '..\..\..\..\..\..\project\util\GSManage\CommonData.pas',
  UnitMakeHgsDB2 in '..\UnitMakeHgsDB2.pas',
  UnitLogUtil in '..\..\..\..\..\..\project\common\UnitLogUtil.pas',
  UnitHiMAPRecord in '..\..\..\..\..\..\project\util\GSManage\UnitHiMAPRecord.pas',
  FrmHiMAPSelect in '..\..\..\..\..\..\project\util\GSManage\HiMAPManage\FrmHiMAPSelect.pas' {HiMAPSelectF},
  UnitMSBDData in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitMSBDData.pas',
  UnitStringUtil in '..\..\..\..\..\..\project\common\UnitStringUtil.pas',
  FrmFileSelect in '..\..\..\..\..\..\project\util\GSManage\FrmFileSelect.pas',
  UnitGSFileRecord in '..\..\..\..\..\..\project\util\GSManage\UnitGSFileRecord.pas',
  FrmDisplayAnsiDeviceDesc in '..\..\..\..\..\..\project\util\GSManage\FrmDisplayAnsiDeviceDesc.pas' {AnsiDeviceDescF},
  UnitAnsiDeviceRecord in '..\..\..\..\..\..\project\util\GSManage\UnitAnsiDeviceRecord.pas',
  UnitMakeAnsiDeviceDB in '..\..\..\..\..\..\project\util\GSManage\UnitMakeAnsiDeviceDB.pas',
  FrmAnsiDeviceNoList in '..\..\..\..\..\..\project\util\GSManage\FrmAnsiDeviceNoList.pas' {AnsiDeviceNoF},
  FrmEditVesselInfo in '..\..\..\..\..\..\project\util\GSManage\VesselList\FrmEditVesselInfo.pas' {EditVesselInfoF},
  UnitNationRecord in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitNationRecord.pas',
  UnitNationData in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitNationData.pas',
  FrmViewNationCode in '..\..\..\..\..\..\project\util\GSManage\VesselList\FrmViewNationCode.pas' {ViewNationCodeF},
  FrmViewFlag in '..\..\..\..\..\..\project\util\GSManage\VesselList\FrmViewFlag.pas' {FlagViewF},
  UnitEngineMasterRecord in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitEngineMasterRecord.pas',
  FrmViewEngineMaster in '..\..\..\..\..\..\project\util\GSManage\VesselList\FrmViewEngineMaster.pas' {ViewEngineMasterF},
  FrmVesselAdvancedSearch in '..\..\..\..\..\..\project\util\GSManage\VesselList\FrmVesselAdvancedSearch.pas' {VesselAdvancedSearchF},
  UnitElecMasterRecord in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitElecMasterRecord.pas',
  frmGeneratorDetail in '..\..\..\..\..\..\project\util\GSManage\GeneratorManage\frmGeneratorDetail.pas' {GeneratorDetailF},
  UnitGeneratorRecord in '..\..\..\..\..\..\project\util\GSManage\GeneratorManage\UnitGeneratorRecord.pas',
  UnitVariantFormUtil in '..\..\..\..\..\..\project\common\UnitVariantFormUtil.pas',
  UnitRttiUtil in '..\..\..\..\..\..\project\common\UnitRttiUtil.pas',
  frmViewGeneratorMaster in '..\..\..\..\..\..\project\util\GSManage\GeneratorManage\frmViewGeneratorMaster.pas' {ViewGenMasterF},
  UnitVesselData in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitVesselData.pas',
  FrameDragDropOutlook in '..\..\..\..\..\..\project\common\Frames\FrameDragDropOutlook.pas' {DragOutlookFrame: TFrame},
  UnitCBData in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitCBData.pas',
  UnitEnumHelper in '..\..\..\..\..\..\project\common\UnitEnumHelper.pas',
  FrameGSFileList in '..\..\..\..\..\..\project\common\Frames\FrameGSFileList.pas',
  UnitSimpleGenericEnum in '..\..\..\..\..\..\project\common\UnitSimpleGenericEnum.pas',
  UnitCBRecord in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitCBRecord.pas',
  UnitElecServiceData in '..\..\..\..\..\..\project\util\GSManage\UnitElecServiceData.pas',
  UnitEngineMasterData in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitEngineMasterData.pas',
  UnitElecMasterData in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitElecMasterData.pas',
  UnitBaseRecord in '..\..\..\..\..\..\project\common\UnitBaseRecord.pas',
  UnitHttpModule4CommonWS in '..\..\..\..\..\..\project\common\UnitHttpModule4CommonWS.pas',
  UnitCommonWSInterface in '..\..\..\..\..\..\project\common\UnitCommonWSInterface.pas',
  UnitOutlookIPCUtil in '..\..\..\..\..\..\project\util\GSManage\common\Unit\UnitOutlookIPCUtil.pas',
  UnitCryptUtil in '..\..\..\..\..\..\project\NoGitHub\Util\UnitCryptUtil.pas',
  OLMailWSCallbackInterface in '..\..\..\..\..\..\project\util\OutLookAddIn\OLMail4InqManage\OLMailWSCallbackInterface.pas',
  UnitGAServiceData in '..\..\..\..\..\..\project\util\GSManage\GAManageR\UnitGAServiceData.pas',
  UnitGAVarJsonUtil in '..\..\..\..\..\..\project\util\GSManage\GAManageR\UnitGAVarJsonUtil.pas',
  UnitGAMakeReport in '..\..\..\..\..\..\project\util\GSManage\GAManageR\UnitGAMakeReport.pas',
  UnitGAMasterRecord in '..\..\..\..\..\..\project\NoGitHub\RecordUnits\GAManager\UnitGAMasterRecord.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TVesselListF, VesselListF);
  Application.Run;
end.
