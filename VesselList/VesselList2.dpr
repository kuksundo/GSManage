program VesselList2;

uses
  Vcl.Forms,
  mormot.db.raw.sqlite3.static,
  frmHiMAPDetail2 in '..\HiMapManage\frmHiMAPDetail2.pas' {HiMAPDetailF},
  UnitHiMAPData in '..\..\..\..\..\..\project\util\GSManage\HiMAPManage\UnitHiMAPData.pas',
  FrmVesselList2 in 'FrmVesselList2.pas' {VesselListF},
  UnitVesselMasterRecord2 in '..\UnitVesselMasterRecord2.pas',
  UnitMakeHgsDB2 in '..\UnitMakeHgsDB2.pas',
  FrmHiMAPSelect2 in '..\HiMapManage\FrmHiMAPSelect2.pas' {HiMAPSelectF},
  UnitMSBDData in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitMSBDData.pas',
  FrmFileSelect in '..\..\..\..\..\..\project\util\GSManage\FrmFileSelect.pas',
  FrmDisplayAnsiDeviceDesc in '..\..\..\..\..\..\project\util\GSManage\FrmDisplayAnsiDeviceDesc.pas' {AnsiDeviceDescF},
  UnitAnsiDeviceRecord2 in '..\UnitAnsiDeviceRecord2.pas',
  UnitMakeAnsiDeviceDB2 in '..\UnitMakeAnsiDeviceDB2.pas',
  FrmAnsiDeviceNoList2 in '..\FrmAnsiDeviceNoList2.pas' {AnsiDeviceNoF},
  FrmEditVesselInfo2 in 'FrmEditVesselInfo2.pas' {EditVesselInfoF},
  UnitNationRecord2 in 'UnitNationRecord2.pas',
  UnitNationData in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitNationData.pas',
  FrmViewNationCode2 in 'FrmViewNationCode2.pas' {ViewNationCodeF},
  FrmViewFlag2 in 'FrmViewFlag2.pas' {FlagViewF},
  UnitEngineMasterRecord2 in 'UnitEngineMasterRecord2.pas',
  FrmViewEngineMaster2 in 'FrmViewEngineMaster2.pas' {ViewEngineMasterF},
  FrmVesselAdvancedSearch in '..\..\..\..\..\..\project\util\GSManage\VesselList\FrmVesselAdvancedSearch.pas' {VesselAdvancedSearchF},
  UnitElecMasterRecord2 in 'UnitElecMasterRecord2.pas',
  frmGeneratorDetail2 in '..\GeneratorManage\frmGeneratorDetail2.pas' {GeneratorDetailF},
  UnitGeneratorRecord2 in '..\GeneratorManage\UnitGeneratorRecord2.pas',
  UnitVariantFormUtil2 in '..\..\..\Common\UnitVariantFormUtil2.pas',
  frmViewGeneratorMaster in '..\..\..\..\..\..\project\util\GSManage\GeneratorManage\frmViewGeneratorMaster.pas' {ViewGenMasterF},
  UnitCBData in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitCBData.pas',
  UnitEngineMasterData in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitEngineMasterData.pas',
  UnitElecMasterData in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitElecMasterData.pas',
  UnitGAServiceData in '..\..\..\..\..\..\project\util\GSManage\GAManageR\UnitGAServiceData.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TVesselListF, VesselListF);
  Application.Run;
end.
