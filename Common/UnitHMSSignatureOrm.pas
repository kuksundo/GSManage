unit UnitHMSSignatureOrm;

interface

uses Classes, SysUtils, Forms,
  mormot.orm.core, mormot.core.datetime, mormot.core.base, mormot.core.os,
  mormot.rest.sqlite3, mormot.core.json, mormot.core.unicode;

type
  TOrmHMSSignature = class(TOrm)
  private
    fSigKey,
    fSignature
    : RawUtf8;

    fUpdateDate: TTimeLog;
  public
    FIsUpdate: Boolean;
    property IsUpdate: Boolean read FIsUpdate write FIsUpdate;
  published
    property SigKey: RawUtf8 read fSigKey write fSigKey;
    property Signature: RawUtf8 read fSignature write fSignature;
    property UpdateDate: TTimeLog read fUpdateDate write fUpdateDate;
  end;

function GetHMSSignatureBySigKey(const ASigKey: RawUtf8; ADB: TRestClientDB): TOrmHMSSignature;
function GetHMSSignature2JsonBySigKey(ASigKey: RawUtf8; ADB: TRestClientDB): RawUtf8;
function GetHMSSignature2Base64BySigKey(ASigKey: RawUtf8; ADB: TRestClientDB): RawUtf8;

procedure AddOrUpdateHMSSignatureBySigKey(const ASigKey: RawUtf8;
  AOrm: TOrmHMSSignature; ADB: TRestClientDB);
procedure AddOrUpdateHMSSignature(AOrm: TOrmHMSSignature; ADB: TRestClientDB);
procedure AdddOrUpdateSignatureFieldByBase64(const ABase64: RawUtf8; ASigKey: RawUtf8; ADB: TRestClientDB);

implementation

uses UnitCryptUtil3;

procedure AdddOrUpdateSignatureFieldByBase64(const ABase64: RawUtf8; ASigKey: RawUtf8; ADB: TRestClientDB);
var
  LOrmHMSSignature: TOrmHMSSignature;
begin
  if ASigKey = '' then
    ASigKey := ChangeFileExt(ExtractFileName(Application.ExeName),'');

  LOrmHMSSignature := GetHMSSignatureBySigKey(ASigKey, ADB);
  try
    if not LOrmHMSSignature.IsUpdate then
      LOrmHMSSignature.SigKey := ASigKey;

    LOrmHMSSignature.Signature := ABase64;
    AddOrUpdateHMSSignature(LOrmHMSSignature, ADB);
  finally
    LOrmHMSSignature.Free;
  end;
end;

function GetHMSSignatureBySigKey(const ASigKey: RawUtf8; ADB: TRestClientDB): TOrmHMSSignature;
begin
  Result := TOrmHMSSignature.CreateAndFillPrepare(ADB.Orm, 'SigKey = ?', [ASigKey]);

  Result.IsUpdate := Result.FillOne;
end;

function GetHMSSignature2JsonBySigKey(ASigKey: RawUtf8; ADB: TRestClientDB): RawUtf8;
begin
  Result := GetHMSSignature2Base64BySigKey(ASigKey, ADB);

  if Result <> '' then
    Result := MakeUnBase64NDecrypt(Result);
end;

function GetHMSSignature2Base64BySigKey(ASigKey: RawUtf8; ADB: TRestClientDB): RawUtf8;
var
  LOrmHMSSignature: TOrmHMSSignature;
begin
  Result := '';

  if ASigKey = '' then
    ASigKey := ChangeFileExt(ExtractFileName(Application.ExeName),'');

  LOrmHMSSignature := GetHMSSignatureBySigKey(ASigKey, ADB);
  try
    if LOrmHMSSignature.IsUpdate then
    begin
      Result := LOrmHMSSignature.Signature;
    end;
  finally
    LOrmHMSSignature.Free;
  end;
end;

procedure AddOrUpdateHMSSignatureBySigKey(const ASigKey: RawUtf8;
  AOrm: TOrmHMSSignature; ADB: TRestClientDB);
var
  LOrmHMSSignature: TOrmHMSSignature;
begin
  LOrmHMSSignature := GetHMSSignatureBySigKey(ASigKey, ADB);
  try
    if LOrmHMSSignature.IsUpdate then
    begin

    end
    else
    begin
      LOrmHMSSignature.SigKey := ASigKey;
    end;

    LOrmHMSSignature.Signature := AOrm.Signature;

    AddOrUpdateHMSSignature(LOrmHMSSignature, ADB);
  finally
    LOrmHMSSignature.Free;
  end;
end;

procedure AddOrUpdateHMSSignature(AOrm: TOrmHMSSignature; ADB: TRestClientDB);
begin
  if AOrm.IsUpdate then
  begin
    ADB.Update(AOrm);
  end
  else
  begin
    ADB.Add(AOrm, true);
  end;
end;

procedure AddOrUpdateHMSSignatureByBase64(ABase64: RawUtf8; ADB: TRestClientDB=nil);
begin

end;

end.
