program HiconisASManageR;

uses
  Vcl.Forms,
  mormot.db.raw.sqlite3.static,
  FrmHiconisASManage in 'FrmHiconisASManage.pas' {HiconisASManageF},
  UnitRegistrationUtil,
  FrmHiconisASTaskEdit in 'FrmHiconisASTaskEdit.pas' {TaskEditF},
  FrameDisplayTaskInfo2 in '..\Common\FrameDisplayTaskInfo2.pas' {DisplayTaskF: TFrame},
  FrmDisplayTaskInfo in '..\..\..\..\..\..\project\util\GSManage\FrmDisplayTaskInfo.pas' {DisplayTaskInfoF},
  FrmFileSelect in '..\..\..\..\..\..\project\util\GSManage\FrmFileSelect.pas' {FileSelectF},
  FSMClass_Dic in '..\..\..\..\..\..\project\common\FSMClass_Dic.pas',
  FSMState in '..\..\..\..\..\..\project\common\FSMState.pas',
  FrmEditSubCon in '..\..\..\..\..\..\project\util\GSManage\FrmEditSubCon.pas' {Form2},
  UnitStringUtil in '..\..\..\..\..\..\project\common\UnitStringUtil.pas',
  UnitIPCModule in '..\..\..\..\..\..\project\util\GSManage\common\Unit\UnitIPCModule.pas',
  FrmTodo_Detail in '..\Common\FrmTodo_Detail.pas' {ToDoDetailF},
  FrmTodoList in '..\FrmTodoList.pas' {ToDoListF},
  UnitDateUtil in '..\..\..\..\..\..\project\common\UnitDateUtil.pas',
  UnitTodoCollect2 in '..\..\..\common\UnitTodoCollect2.pas',
  UnitRegistryUtil in '..\..\..\..\..\..\project\common\UnitRegistryUtil.pas',
  UnitHttpModule4RegServer in '..\..\..\..\..\..\project\util\RegCodeManager\UnitHttpModule4RegServer.pas',
  UnitRegCodeServerInterface in '..\..\..\..\..\..\project\util\RegCodeManager\Common\UnitRegCodeServerInterface.pas',
  UnitNextGridFrame in '..\..\..\..\..\..\project\common\Frames\UnitNextGridFrame.pas' {Frame1: TFrame},
  getIp in '..\..\..\..\..\..\project\common\getIp.pas',
  FrmInqManageConfig in '..\..\..\..\..\..\project\util\GSManage\FrmInqManageConfig.pas' {ConfigF},
  OLMailWSCallbackInterface in '..\..\..\..\..\..\project\util\OutLookAddIn\OLMail4InqManage\OLMailWSCallbackInterface.pas',
  FrmEditProduct in '..\..\..\..\..\..\project\util\RegCodeManager\FrmEditProduct.pas' {ProdEditF},
  UnitBase64Util in '..\..\..\..\..\..\project\common\UnitBase64Util.pas',
  UnitAdvComponentUtil2 in '..\Common\UnitAdvComponentUtil2.pas',
  UnitGSTriffData in '..\..\..\..\..\..\project\util\GSManage\UnitGSTriffData.pas',
  UnitGSTariffRecord in '..\..\..\..\..\..\project\util\GSManage\UnitGSTariffRecord.pas',
  FrmEditTariff in '..\..\..\..\..\..\project\util\GSManage\TariffManage\FrmEditTariff.pas' {TariffEditF},
  fFrmEditTariffItem in '..\..\..\..\..\..\project\util\GSManage\TariffManage\fFrmEditTariffItem.pas' {EditTariffItemF},
  FrmSearchVessel in '..\..\..\..\..\..\project\util\GSManage\FrmSearchVessel.pas' {SearchVesselF},
  FrmDisplayTariff in '..\..\..\..\..\..\project\util\GSManage\TariffManage\FrmDisplayTariff.pas' {DisplayTariffF},
  UnitGAServiceData in '..\..\..\..\..\..\project\util\GSManage\GAManageR\UnitGAServiceData.pas',
  UnitHiconisASVarJsonUtil in 'UnitHiconisASVarJsonUtil.pas',
  UnitHiconisASMakeReport in 'UnitHiconisASMakeReport.pas',
  UnitHiconisASWSInterface in '..\Common\UnitHiconisASWSInterface.pas',
  UnitUserDataRecord2 in '..\UnitUserDataRecord2.pas',
  UnitHttpModule4InqManageServer2 in '..\UnitHttpModule4InqManageServer2.pas',
  UnitMAPSMacro2 in '..\Common\UnitMAPSMacro2.pas',
  AsyncCallsHelper in '..\..\..\..\..\..\project\common\AsyncCallsHelper.pas',
  AsyncCalls in '..\..\..\..\..\..\project\common\AsyncCalls.pas',
  JvgXMLSerializer_pjh in '..\..\..\..\..\..\project\common\JvgXMLSerializer_pjh.pas',
  UnitStrategy4OLEmailInterface in '..\..\..\..\..\..\project\util\GSManage\UnitStrategy4OLEmailInterface.pas',
  UnitHiconisMasterRecord in '..\..\..\NoGitHub\RecordUnit2\HiconisASManager\UnitHiconisMasterRecord.pas',
  FrmGAEdit in '..\..\..\..\..\..\project\util\GSManage\GlobalAcademy\FrmGAEdit.pas',
  UnitDFMUtil in '..\..\..\..\..\..\project\common\UnitDFMUtil.pas',
  FrameNextGridOnly in '..\..\..\..\..\..\project\common\Frames\FrameNextGridOnly.pas' {FrameNGOnly: TFrame},
  UnitMacroListClass2 in '..\..\MacroManage\UnitMacroListClass2.pas',
  UnitVesselMasterRecord2 in '..\VesselList\UnitVesselMasterRecord2.pas',
  UnitVesselData2 in '..\VesselList\UnitVesselData2.pas',
  UnitEngineMasterData in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitEngineMasterData.pas',
  UnitElecMasterData in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitElecMasterData.pas',
  FrmEmailListView2 in '..\FrmEmailListView2.pas' {EmailListViewF},
  FrameDragDropOutlook in '..\..\..\..\..\..\project\common\Frames\FrameDragDropOutlook.pas' {DragOutlookFrame: TFrame},
  FrameOLEmailList2 in '..\..\..\common\Frame\FrameOLEmailList2.pas' {Frame2: TFrame},
  FrmEditEmailInfo2 in '..\FrmEditEmailInfo2.pas' {EmailInfoF},
  UnitOLDataType in '..\..\OutlookAddIn2\UnitOLDataType.pas',
  FrmSelectProductType2 in '..\FrmSelectProductType2.pas' {SelectProductTypeF},
  UnitMacroRecorderMain2 in '..\..\MacroManage\UnitMacroRecorderMain2.pas' {MacroManageF};

{$R *.res}

const
  IM_ROOT_NAME_4_WS = 'root';
  IM_PORT_NAME_4_WS = '710';

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(THiconisASManageF, HiconisASManageF);
  Application.CreateForm(TEmailListViewF, EmailListViewF);
  Application.CreateForm(TEmailInfoF, EmailInfoF);
  Application.CreateForm(TSelectProductTypeF, SelectProductTypeF);
  Application.CreateForm(TMacroManageF, MacroManageF);
  //  GAManageF.Caption := GAManageF.Caption + ' (For Technical Sales Team)';
//  GAManageF.TDTF.SetNetworkInfo(IM_ROOT_NAME_4_WS,IM_PORT_NAME_4_WS, Application.ExeName);
  Application.Run;
end.
