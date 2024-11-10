unit FrmHiConTgzFileExtract;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFrameFileList2, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Mask, JvExMask, JvToolEdit,
  mormot.core.os, sevenzip, mormot.lib.win7zip;

type
  THiConTgzExtractF = class(TForm)
    Panel1: TPanel;
    JHPFileListFr: TJHPFileListFrame;
    Button1: TButton;
    TargetDirEdit: TJvDirectoryEdit;
    Label1: TLabel;
    CreateDirCheck: TCheckBox;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    F7zDllName: string;

    procedure InitVar();
    procedure ExtractTgz2Dir;
  public
    procedure ExtractTgzIncludeTar2Dir(ATgzFileName, ADestDir: string);
  end;

var
  HiConTgzExtractF: THiConTgzExtractF;

implementation

uses UnitGZipJclUtil, UnitGZipWin7zUtil;

{$R *.dfm}

procedure THiConTgzExtractF.Button1Click(Sender: TObject);
var
  LFileName, LDestDir, LTarFileName, LDecompressedFileName: string;
  i: integer;
begin
  for i := 0 to JHPFileListFr.fileGrid.RowCount - 1 do
  begin
    if JHPFileListFr.fileGrid.Row[i].Selected then
    begin
      LFileName := JHPFileListFr.fileGrid.CellsByName['FileName', i];

      if CheckIfTgzFile(LFileName) then
      begin
        LDestDir := JHPFileListFr.fileGrid.CellsByName['FilePath', i];
        LFileName := LDestDir + LFileName;
        LDestDir := IncludeTrailingPathDelimiter(TargetDirEdit.Text) + ChangeFileExt(ExtractFileName(LFileName), '');

        ExtractTgzIncludeTar2Dir(LFileName, LDestDir);

//        LDestDir := EnsureDirectoryExists(LDestDir);
//
//        DeCompressFileUsingJcl(LFileName, LDestDir);
//
//        LDecompressedFileName := LDestDir + ChangeFileExt(ExtractFileName(LFileName), '');
//        LTarFileName := LDestDir + ChangeFileExt(ExtractFileName(LFileName), '.tar');
//
//        if FileExists(LTarFileName) then
//          DeleteFile(LTarFileName);
//
//        //MPM11 파일을 MPM11.tar 파일로 이름 변경함
//        if RenameFile(LDecompressedFileName, LTarFileName) then
//        begin
//          DeCompressFileWithWin7zip(LTarFileName, LDestDir, F7zDllName, False);
//          DeleteFile(LTarFileName);
//        end;

//        ExtractFromTgz2DirByPackedNameWin7Zip(LFileName, LDestDir, F7zDllName);
//        ExtractFromTgz2DirByPackedName(LFileName, LDestDir, '');
      end;
    end;
  end;//for

  ShowMessage('Extract file from tgz finished');
end;

procedure THiConTgzExtractF.Button2Click(Sender: TObject);
var
  L7zip: I7zReader;
  LStr: RawByteString;
  LStrList: TStringList;
begin
//  L7zip := New7zReader('c:\temp\test2.tgz', fhUndefined, F7zDllName);
//  LStr := L7Zip.Extract('Test2.tar');
//  DeCompressFileUsingJcl('c:\temp\test2.tgz', 'c:\temp\test2');
//  ShowMessage(LStr);
//  L7Zip.Extract('/home/app/do1', 'c:\temp\test');
//  L7Zip.ExtractAll('c:\temp\test', True);
//  L7Zip.ExtractAll;

//  LStrList := TStringList.Create;
//  try
//    LStrList.Add('home\db\interface.json');
//    LStrList.Add('home\db\channel.json');
//    DeCompressFileListFromTgzUsingJcl('c:\temp\MPM13.tgz', 'c:\temp\test2',LStrList);
//  finally
//    LStrList.Free;
//  end;

//  DeCompressTgz2TarUsingJcl('c:\temp\mpm13.tgz', 'c:\temp\mpm13');
  ExtractTgzIncludeTar2Dir('c:\temp\mpm13.tgz', 'c:\temp\mpm13');
  CopyFile('c:\temp\interface.json', 'c:\temp\mpm13\home\db\interface.json', False);
  UpdateFile2TarUsingJcl('c:\temp\mpm13\mpm13.tar', 'c:\temp\interface.json', 'home\db\interface.json');
end;

procedure THiConTgzExtractF.ExtractTgz2Dir;
begin

end;

procedure THiConTgzExtractF.ExtractTgzIncludeTar2Dir(ATgzFileName,
  ADestDir: string);
var
  LTarFileName, LDecompressedFileName: string;
begin
  ADestDir := EnsureDirectoryExists(ADestDir);

  DeCompressFileUsingJcl(ATgzFileName, ADestDir);

  LDecompressedFileName := ADestDir + ChangeFileExt(ExtractFileName(ATgzFileName), '');
  LTarFileName := ADestDir + ChangeFileExt(ExtractFileName(ATgzFileName), '.tar');

  if FileExists(LTarFileName) then
    DeleteFile(LTarFileName);

  //MPM11 파일을 MPM11.tar 파일로 이름 변경함
  if RenameFile(LDecompressedFileName, LTarFileName) then
  begin
    DeCompressFileWithWin7zip(LTarFileName, ADestDir, F7zDllName, False);
    DeleteFile(LTarFileName);
  end;
end;

procedure THiConTgzExtractF.FormCreate(Sender: TObject);
begin
  InitVar();
end;

procedure THiConTgzExtractF.InitVar;
begin
  JHPFileListFr.FIgnoreFileTypePrompt := True;
  SevenzipLibraryDir := ExtractFilePath(Application.ExeName) + 'lib\';
  F7zDllName := ExtractFilePath(Application.ExeName) + 'lib\7z.dll';
end;

end.
