program HiconisASManageR;

uses
  Vcl.Forms,
  mormot.db.raw.sqlite3.static,
  FrmHiconisASTaskEdit in 'FrmHiconisASTaskEdit.pas' {TaskEditF},
  FrmFileSelect in '..\..\..\..\..\..\project\util\GSManage\FrmFileSelect.pas' {FileSelectF},
  FrmEditSubCon2 in '..\FrmEditSubCon2.pas' {Form2},
  UnitStringUtil in '..\..\..\..\..\..\project\common\UnitStringUtil.pas',
  FrmTodo_Detail in '..\Common\FrmTodo_Detail.pas' {ToDoDetailF},
  UnitDateUtil in '..\..\..\..\..\..\project\common\UnitDateUtil.pas',
  UnitTodoCollect2 in '..\..\..\common\UnitTodoCollect2.pas',
  UnitRegistryUtil in '..\..\..\..\..\..\project\common\UnitRegistryUtil.pas',
  UnitNextGridFrame in '..\..\..\..\..\..\project\common\Frames\UnitNextGridFrame.pas' {Frame1: TFrame},
  getIp in '..\..\..\..\..\..\project\common\getIp.pas',
  FrmInqManageConfig in '..\..\..\..\..\..\project\util\GSManage\FrmInqManageConfig.pas' {ConfigF},
  UnitAdvComponentUtil2 in '..\Common\UnitAdvComponentUtil2.pas',
  UnitHiconisASVarJsonUtil in 'UnitHiconisASVarJsonUtil.pas',
  UnitHiconisASWSInterface in '..\Common\UnitHiconisASWSInterface.pas',
  UnitUserDataRecord2 in '..\UnitUserDataRecord2.pas',
  UnitMAPSMacro2 in '..\Common\UnitMAPSMacro2.pas',
  JvgXMLSerializer_pjh in '..\..\..\..\..\..\project\common\JvgXMLSerializer_pjh.pas',
  UnitHiconisMasterRecord in '..\..\..\NoGitHub\RecordUnit2\HiconisASManager\UnitHiconisMasterRecord.pas',
  UnitDFMUtil in '..\..\..\..\..\..\project\common\UnitDFMUtil.pas',
  UnitVesselMasterRecord2 in '..\VesselList\UnitVesselMasterRecord2.pas',
  UnitVesselData2 in '..\VesselList\UnitVesselData2.pas',
  UnitEngineMasterData in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitEngineMasterData.pas',
  UnitElecMasterData in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitElecMasterData.pas',
  FrmEditEmailInfo2 in '..\FrmEditEmailInfo2.pas' {EmailInfoF},
  FrmSelectCheckBox in '..\..\..\common\Form\FrmSelectCheckBox.pas' {SelectChcekBoxF},
  UnitGSTriffData in '..\..\..\..\..\..\project\util\GSManage\UnitGSTriffData.pas',
  FrmASMaterialEdit in 'FrmASMaterialEdit.pas' {ASMaterialF},
  FrmOLEmailList in '..\..\RPA\Outlook\Util\FrmOLEmailList.pas' {OLEmailListF},
  UnitOutlookUtil2 in '..\..\..\Common\UnitOutlookUtil2.pas',
  UnitOLControlWorker in '..\..\RPA\Outlook\Util\UnitOLControlWorker.pas',
  FrameOLEmailList4Ole in '..\..\..\Common\Frame\FrameOLEmailList4Ole.pas' {OutlookEmailListFr: TFrame},
  FrmStringsEdit in '..\..\..\..\..\..\project\common\Forms\FrmStringsEdit.pas',
  FrmSerialCommConfig in '..\..\..\..\..\..\project\util\MacroManagement\FrmSerialCommConfig.pas' {SerialCommConfigF},
  UnitNameEdit in '..\..\..\..\..\..\project\util\MacroManagement\UnitNameEdit.pas' {NameEditF},
  UnitHiASMaterialRecord in 'UnitHiASMaterialRecord.pas',
  UnitHiASSubConRecord in 'UnitHiASSubConRecord.pas',
  UnitHiASToDoRecord in 'UnitHiASToDoRecord.pas',
  FrmToDoList2 in '..\..\..\Common\Form\FrmToDoList2.pas' {ToDoListF2},
  UnitToDoList in '..\..\..\Common\UnitToDoList.pas',
  UnitHiASMaterialDetailRecord in 'UnitHiASMaterialDetailRecord.pas',
  UnitStateMachineUtil in '..\..\..\Common\UnitStateMachineUtil.pas',
  FrmASMaterialDetailEdit in 'FrmASMaterialDetailEdit.pas' {MaterialDetailF},
  FrmHiconisASManage in 'FrmHiconisASManage.pas' {HiconisAsManageF},
  UnitCommonFormUtil in '..\Common\UnitCommonFormUtil.pas',
  UnitImportFromXls in '..\Common\UnitImportFromXls.pas',
  UnitHiASMaterialCodeRecord in 'UnitHiASMaterialCodeRecord.pas',
  UnitIniAttriPersist in '..\..\..\Common\UnitIniAttriPersist.pas',
  UnitHiASIniConfig in 'UnitHiASIniConfig.pas',
  UnitIPCMsgQUtil in '..\..\..\Common\UnitIPCMsgQUtil.pas',
  UnitJsonUtil in '..\..\..\Common\UnitJsonUtil.pas',
  UnitHiASOLUtil in 'UnitHiASOLUtil.pas';

{$R *.res}

const
  IM_ROOT_NAME_4_WS = 'root';
  IM_PORT_NAME_4_WS = '710';

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(THiconisAsManageF, HiconisAsManageF);
  //  GAManageF.Caption := GAManageF.Caption + ' (For Technical Sales Team)';
//  GAManageF.TDTF.SetNetworkInfo(IM_ROOT_NAME_4_WS,IM_PORT_NAME_4_WS, Application.ExeName);
  Application.Run;
end.
