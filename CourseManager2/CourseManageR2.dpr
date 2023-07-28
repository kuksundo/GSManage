program CourseManageR2;

uses
  Vcl.Forms,
  mormot.db.raw.sqlite3.static,
  FrmFileSelect in '..\..\..\..\..\..\project\util\GSManage\FrmFileSelect.pas',
  UnitElecServiceData in '..\..\..\..\..\..\project\util\GSManage\UnitElecServiceData.pas',
  FrmCourseManage2 in 'FrmCourseManage2.pas' {CourseManageF},
  FrmCourseEdit2 in 'FrmCourseEdit2.pas' {CourseEditF},
  UnitHGSCurriculumRecord2 in '..\Common\UnitHGSCurriculumRecord2.pas',
  UnitHGSCurriculumData2 in '..\UnitHGSCurriculumData2.pas',
  UnitVesselData2 in '..\VesselList\UnitVesselData2.pas',
  CommonData2 in '..\Common\CommonData2.pas',
  UnitGSFileData2 in '..\Common\UnitGSFileData2.pas',
  UnitGSFileRecord2 in '..\Common\UnitGSFileRecord2.pas',
  UnitFrameFileList2 in '..\..\..\Common\Frame\UnitFrameFileList2.pas' {JHPFileListFrame: TFrame},
  UnitCryptUtil2 in '..\..\..\NoGitHub\Util\UnitCryptUtil2.pas',
  ArrayHelper in '..\..\..\OpenSrc\lib\ArrayHelper-master\ArrayHelper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TCourseManageF, CourseManageF);
  Application.CreateForm(TCourseEditF, CourseEditF);
  Application.Run;
end.
