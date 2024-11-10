program HiConTgzFileExtractor;

uses
  Vcl.Forms,
  FrmHiConTgzFileExtract in 'FrmHiConTgzFileExtract.pas' {Form2},
  UnitFrameFileList2 in '..\..\..\Common\Frame\UnitFrameFileList2.pas' {JHPFileListFrame: TFrame},
  UnitGZipWin7zUtil in '..\..\..\Common\UnitGZipWin7zUtil.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(THiConTgzExtractF, HiConTgzExtractF);
  Application.Run;
end.
