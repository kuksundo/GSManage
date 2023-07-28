unit UnitGSFileRecord2;

interface

uses
  Classes, System.SysUtils,
  mormot.core.base, mormot.orm.core, mormot.rest.client, mormot.core.os, mormot.rest.sqlite3,
  UnitGSFileData2;

type
  TSQLGSFile = class;

  TIDList4GSFile = class
    fTaskId  : TID;
    fGSAction,
    fGSDocType: integer;
    fGSFile: TSQLGSFile;
  public
    property GSAction: integer read fGSAction write fGSAction;
  published
    property TaskId: TID read fTaskId write fTaskId;
    property GSDocType: integer read fGSDocType write fGSDocType;
    property GSFile: TSQLGSFile read fGSFile write fGSFile;
  end;

  TSQLGSFile = class(TSQLRecord)
  private
    fTaskID: TID;
    fFiles: TSQLGSFileRecs;
  public
    fIsUpdate: Boolean;
    property IsUpdate: Boolean read fIsUpdate write fIsUpdate;
  published
    property TaskID: TID read fTaskID write fTaskID;
    property Files: TSQLGSFileRecs read fFiles write fFiles;
  end;

procedure InitGSFileClient(AExeName: string = '');
procedure InitGSFileClient2(ADBName: string = '');
function CreateFilesModel: TSQLModel;
procedure DestroyGSFile;

function GetGSFilesFromID(const AID: TID): TSQLGSFile;
function GetGSFiles: TSQLGSFile;
//procedure LoadGSFileRecFromVariant(var ASQLGSFileRec: TSQLGSFileRec; ADoc: variant);
procedure AddOrUpdateGSFiles(ASQLGSFile: TSQLGSFile);
function DeleteGSFilesFromTaskID(const AID: TID): Boolean;
function SaveGSFile2DefaultDB(ADBName, ASaveFileName: string; AID: TID;
  ADocType: integer): Boolean;
function GetDefaultInvoiceFileName(AFileKind: TGSFileKind; AInvNo: string): string;

var
  g_FileDB: TSQLRestClientURI;
  FileModel: TSQLModel;

implementation

uses UnitFolderUtil2, Forms;

function GetDefaultInvoiceFileName(AFileKind: TGSFileKind; AInvNo: string): string;
begin
  case AFileKind of
    gfkEXCEL: Result := 'c:\temp\Invoice_VDR_APT_' + AInvNo + '.ods';
    gfkPDF: Result := 'c:\temp\Invoice_VDR_APT_' + AInvNo + '.pdf';
  end;
end;

procedure InitGSFileClient(AExeName: string);
var
  LStr: string;
begin
  LStr := ChangeFileExt(ExtractFileName(AExeName),'.sqlite');
  LStr := LStr.Replace('.sqlite', '_Files.sqlite');
  AExeName := GetSubFolderPath(ExtractFilePath(AExeName), 'db');
  AExeName := EnsureDirectoryExists(AExeName);
  LStr := AExeName + LStr;
  FileModel := CreateFilesModel;
  g_FileDB:= TRestClientDB.Create(FileModel, CreateFilesModel,
    LStr, TRestServerDB);
  TRestClientDB(g_FileDB).Server.CreateMissingTables;
end;

procedure InitGSFileClient2(ADBName: string = '');
var
  LStr: string;
begin
  if Assigned(g_FileDB) then
    FreeAndNil(g_FileDB);
  if Assigned(FileModel) then
    FreeAndNil(FileModel);

  if ADBName = '' then
  begin
    ADBName := ChangeFileExt(ExtractFileName(Application.ExeName),'_Files.sqlite');
    LStr := GetSubFolderPath(ExtractFilePath(Application.ExeName), 'db');
    ADBName := LStr + ADBName;
  end
  else
  begin
    LStr := ExtractFilePath(ADBName);

    if LStr = '' then
      ADBName := GetSubFolderPath(ExtractFilePath(Application.ExeName), 'db') + ADBName;
  end;

  FileModel:= CreateFilesModel;
  g_FileDB:= TSQLRestClientDB.Create(FileModel, CreateFilesModel,
    ADBName, TSQLRestServerDB);
  TSQLRestClientDB(g_FileDB).Server.CreateMissingTables;
end;

function CreateFilesModel: TSQLModel;
begin
  result := TSQLModel.Create([TSQLGSFile]);
end;

procedure DestroyGSFile;
begin
  if Assigned(g_FileDB) then
    FreeAndNil(g_FileDB);
  if Assigned(FileModel) then
    FreeAndNil(FileModel);
end;

function GetGSFilesFromID(const AID: TID): TSQLGSFile;
begin
  Result := TSQLGSFile.CreateAndFillPrepare(g_FileDB.Orm, 'TaskID = ?', [AID]);
  Result.IsUpdate := Result.FillOne;

  if not Result.IsUpdate then
    Result.fTaskID := AID;
end;

function GetGSFiles: TSQLGSFile;
begin
  Result := TSQLGSFile.CreateAndFillPrepare(g_FileDB.Orm, 'TaskID <> ?', [-1]);
  Result.IsUpdate := Result.FillOne;
end;

//procedure LoadGSFileRecFromVariant(var ASQLGSFileRec: TSQLGSFileRec; ADoc: variant);
//begin
//  if ADoc <> '[]' then
//  begin
//    ASQLGSFileRec.fFilename := ADoc.fFilename;
//    ASQLGSFileRec.fFileSize := ADoc.fFileSize;
//    ASQLGSFileRec.fGSDocType := ADoc.fGSDocType;
//    ASQLGSFileRec.fData := ADoc.fData;
//  end;
//end;

procedure AddOrUpdateGSFiles(ASQLGSFile: TSQLGSFile);
begin
  if ASQLGSFile.IsUpdate then
  begin
    g_FileDB.Update(ASQLGSFile);
  end
  else
  begin
    g_FileDB.Add(ASQLGSFile, true);
//    ASQLGSFile.TaskID := ASQLGSFile.ID;
//    g_FileDB.Update(ASQLGSFile);
  end;
end;

function DeleteGSFilesFromTaskID(const AID: TID): Boolean;
begin
  g_FileDB.ExecuteFmt('Delete from % where TaskID = ?',[TSQLGSFile.SQLTableName],[AID]);
end;

function SaveGSFile2DefaultDB(ADBName, ASaveFileName: string; AID: TID;
  ADocType: integer): Boolean;
var
  LDBFile: string;
  LGSFiles: TSQLGSFile;
  LSQLGSFileRec: TSQLGSFileRec;
  LDoc: RawByteString;
begin
  if not FileExists(ASaveFileName) then
    exit;

  ADBName := GetSubFolderPath(ExtractFilePath(Application.ExeName), 'db') + ADBName;
  InitGSFileClient2(ADBName);
  try
    LGSFiles := GetGSFilesFromID(AID);
    LDoc := StringFromFile(ASaveFileName);
    ASaveFileName := ExtractFileName(ASaveFileName);

    LSQLGSFileRec.fData := LDoc;
    LSQLGSFileRec.fGSDocType := ADocType;
    LSQLGSFileRec.fFilename := ASaveFileName;
    LSQLGSFileRec.fFileSize := Length(LDoc);
    LGSFiles.DynArray('Files').Add(LSQLGSFileRec);

    if High(LGSFiles.Files) >= 0 then
    begin
      g_FileDB.Delete(TSQLGSFile, LGSFiles.ID);
      LGSFiles.TaskID := AID;
      g_FileDB.Add(LGSFiles, true);
    end;
  finally
    DestroyGSFile;
  end;
end;

initialization

finalization
  DestroyGSFile;

end.
