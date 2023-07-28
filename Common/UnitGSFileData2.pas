unit UnitGSFileData2;

interface

uses
  Classes, System.SysUtils,
  mormot.core.base, mormot.core.data, mormot.core.json, mormot.core.variants,
  UnitEnumHelper;

type
  PSQLGSFileRec = ^TSQLGSFileRec;
  TSQLGSFileRec = Packed Record
    fFilename: RawUTF8;
    fGSDocType: integer;//TGSDocType;
    fFileSize: integer;
    fData: RawByteString;
  end;

  TSQLGSFileRecs = array of TSQLGSFileRec;

  TGSFileKind = (gfkNull, gfkPDF, gfkEXCEL, gfkWORD, gfkPPT, gfkPJH, gfkPJH2, gfkFinal);

const
  R_GSFileKind : array[Low(TGSFileKind)..High(TGSFileKind)] of string =
    ('', 'PDF', 'MSEXCEL', 'MSWORD', 'MSPPT', 'PJH', 'PJH2', '');

var
  g_GSFileKind: TLabelledEnum<TGSFileKind>;

function MakeGSFileRecs2JSON(ASQLGSFiles: TSQLGSFileRecs): RawUTF8;
function GetGSFileKindFromFileName(const AFileName: string): TGSFileKind;

implementation

function MakeGSFileRecs2JSON(ASQLGSFiles: TSQLGSFileRecs): RawUTF8;
var
  LRow: integer;
  LSQLGSFileRec: TSQLGSFileRec;
  LUtf8: RawUTF8;
  LVar: variant;
  LDynUtf8File: TRawUTF8DynArray;
  LDynArrFile: TDynArray;
begin
  LDynArrFile.Init(TypeInfo(TRawUTF8DynArray), LDynUtf8File);

  for LRow := Low(ASQLGSFiles) to High(ASQLGSFiles) do
  begin
    LSQLGSFileRec := ASQLGSFiles[LRow];
    LUtf8 := RecordSaveJson(LSQLGSFileRec, TypeInfo(TSQLGSFileRec));
    LDynArrFile.Add(LUtf8);
  end;

  LVar := _JSON(LDynArrFile.SaveToJSON);
  Result := LVar;
//  Result := '{"Files":' + LUtf8 + '}';
end;

function GetGSFileKindFromFileName(const AFileName: string): TGSFileKind;
var
  LExt: string;
begin
  LExt := System.SysUtils.UpperCase(ExtractFileExt(AFileName));

  if POS('.DOC', LExt) <> 0 then
    result := gfkWORD
  else
  if POS('.PPT', LExt) <> 0 then
    result := gfkPPT
  else
  if POS('.XLS', LExt) <> 0 then
    result := gfkEXCEL
  else
  if POS('.PDF', LExt) <> 0 then
    result := gfkPDF
  else
  if LExt = '.PJH' then
    result := gfkPJH
  else
  if LExt = '.PJH2' then
    result := gfkPJH2;
end;

//initialization
//  g_GSFileKind.InitArrayRecord(R_GSFileKind);

end.
