program HiconisASManageR;

uses
  Vcl.Forms,
  mormot.db.raw.sqlite3.static,
  FrmHiconisASManage in 'FrmHiconisASManage.pas' {HiconisASManageF},
  FrmHiconisASTaskEdit in 'FrmHiconisASTaskEdit.pas' {TaskEditF},
  FrameDisplayTaskInfo2 in '..\Common\FrameDisplayTaskInfo2.pas' {DisplayTaskF: TFrame},
  FrmFileSelect in '..\..\..\..\..\..\project\util\GSManage\FrmFileSelect.pas' {FileSelectF},
  FrmEditSubCon2 in '..\FrmEditSubCon2.pas' {Form2},
  UnitStringUtil in '..\..\..\..\..\..\project\common\UnitStringUtil.pas',
  FrmTodo_Detail in '..\Common\FrmTodo_Detail.pas' {ToDoDetailF},
  FrmTodoList in '..\FrmTodoList.pas' {ToDoListF},
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
  UnitCmdExecService in '..\Common\UnitCmdExecService.pas',
  UnitMAPSMacro2 in '..\Common\UnitMAPSMacro2.pas',
  JvgXMLSerializer_pjh in '..\..\..\..\..\..\project\common\JvgXMLSerializer_pjh.pas',
  UnitStrategy4OLEmailInterface2 in '..\..\OutlookAddIn2\UnitStrategy4OLEmailInterface2.pas',
  UnitHiconisMasterRecord in '..\..\..\NoGitHub\RecordUnit2\HiconisASManager\UnitHiconisMasterRecord.pas',
  UnitDFMUtil in '..\..\..\..\..\..\project\common\UnitDFMUtil.pas',
  UnitMacroListClass2 in '..\..\MacroManage\UnitMacroListClass2.pas',
  UnitVesselMasterRecord2 in '..\VesselList\UnitVesselMasterRecord2.pas',
  UnitVesselData2 in '..\VesselList\UnitVesselData2.pas',
  UnitEngineMasterData in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitEngineMasterData.pas',
  UnitElecMasterData in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitElecMasterData.pas',
  FrmEmailListView2 in '..\FrmEmailListView2.pas' {EmailListViewF},
  FrameOLEmailList2 in '..\..\..\common\Frame\FrameOLEmailList2.pas' {Frame2: TFrame},
  FrmEditEmailInfo2 in '..\FrmEditEmailInfo2.pas' {EmailInfoF},
  UnitOLDataType in '..\..\OutlookAddIn2\UnitOLDataType.pas',
  FrmSelectProductType2 in '..\FrmSelectProductType2.pas' {SelectProductTypeF},
  UnitMacroRecorderMain2 in '..\..\MacroManage\UnitMacroRecorderMain2.pas' {MacroManageF},
  UnitGSTriffData in '..\..\..\..\..\..\project\util\GSManage\UnitGSTriffData.pas';

{$R *.res}

const
  IM_ROOT_NAME_4_WS = 'root';
  IM_PORT_NAME_4_WS = '710';

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(THiconisASManageF, HiconisASManageF);
  //  GAManageF.Caption := GAManageF.Caption + ' (For Technical Sales Team)';
//  GAManageF.TDTF.SetNetworkInfo(IM_ROOT_NAME_4_WS,IM_PORT_NAME_4_WS, Application.ExeName);
  Application.Run;
end.
