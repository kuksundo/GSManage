unit UnitHiConJsonUtil;

interface

uses
  Winapi.Windows, System.SysUtils, System.Variants, System.Classes, System.Zip,
  mormot.core.base, mormot.core.os, mormot.core.text, mormot.core.collections,
  mormot.core.variants, mormot.core.json, mormot.core.unicode, mormot.lib.z;

//ptc_profibus.tgz file에서 json 파일을 추출하여  System_Bak.accdb->INF Table과 비교함
function CompareProfibusJsonFromTgzByZip(const ATgzFileName, AAccDBFileName: string): string;
function CompareProfibusJsonFromTgzByAbbr(const ATgzFileName, AAccDBFileName: string): string;

implementation

uses AbGzTyp, AbTarTyp, AbZipper, AbUtils;

function CompareProfibusJsonFromTgzByAbbr(const ATgzFileName, AAccDBFileName: string): string;
var
  LGZipper: TAbGzipArchive;
  LTarArchive: TAbTarArchive;
  LAbArchiveType: TAbArchiveType;
  LTempTarFile: string;
  LFileStream,//: TFileStream;
  LTempStream: TMemoryStream;
  LSize: integer;
begin
  LTempTarFile := ChangeFileExt(ATgzFileName, '.tar');

//  LGZipper := TAbGzipArchive.Create(ATgzFileName, fmOpenRead);
  LFileStream := TMemoryStream.Create;
  LFileStream.LoadFromFile(ATgzFileName);//, fmOpenRead);
  LTempStream := TMemoryStream.Create;
  try
//    LGZipper.ExtractAt(0,LTempTarFile);
//    if LGZipper.IsGzippedTar then
//      LGZipper.ExtractFiles('*.tar');

//    LAbArchiveType := VerifyGZip(LGZipper.FStream);

    LSize := UncompressStream(LFileStream.Memory, LFileStream.Size, LTempStream, nil, True, LFileStream.Size);

//    if LGZipper.Count > 0 then
//      LGZipper.ExtractAt(0,LTempTarFile);
  finally
//    LGZipper.Free;
    LFileStream.Free;
  end;
end;

function CompareProfibusJsonFromTgzByZip(const ATgzFileName, AAccDBFileName: string): string;
var
  LZipStream: TFileStream;
  LocalHeader: TZipHeader;
  LZip: TZipFile;
  LZipFileName: string;
  i: integer;
begin
  LZip := TZipFile.Create;
  LZipStream := TFileStream.Create(ATgzFileName, fmOpenRead);
  try
    LZip.Open(LZipStream, zmRead);

    for i := 0 to LZip.FileCount - 1 do
    begin
      Result := LZip.FileNames[i];
    end;

  finally
    LZipStream.Free;
    FreeAndNil(LZip);
  end;
end;

end.
