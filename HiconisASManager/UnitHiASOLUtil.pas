unit UnitHiASOLUtil;

interface

uses mormot.core.base, mormot.core.os,
  UnitHiASIniConfig;

function GetRecvEmailAddress(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
function GetCCEmailAddress(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
function GetEmailSubject(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
function GetEmailBody(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;

implementation

uses UnitStringUtil;

function GetRecvEmailAddress(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
begin
  case AMailType of
    1: Result := AHiASIniConfig.BudgetPIC;//부품예산증액 요청
    2: Result := AHiASIniConfig.InputPIC;//자재입고 요청
    3: Result := AHiASIniConfig.DirectDeliverPIC;//자재직투입 요청
    4: Result := AHiASIniConfig.ShippingPIC;//출하지시 요청
    5: Result := AHiASIniConfig.ServicePIC;//필드서비스팀 요청
//    6: Result := PO_REQ_EMAIL_ADDR; //PO 요청
//    7: Result := FSettings.ShippingReqEmailAddr;//출하 요청
//    8: Result := FSettings.FieldServiceReqEmailAddr;//필드서비스팀 요청
  end;
end;

function GetCCEmailAddress(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
begin

end;

function GetEmailSubject(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
begin

end;

function GetEmailBody(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
var
  LUtf8: RawByteString;
  LStr: string;
begin
  case AMailType of
    1: begin
      LUtf8 := StringFromFile(AHiASIniConfig.ReqBudgetIncreaseMailFN);
      LStr := Utf8ToString(LUtf8);//부품예산증액 요청Mail
      Result := replaceString(LStr, '_projNo_', AHiASIniConfig.FProjNo);
    end;
    2: Result := AHiASIniConfig.InputPIC;//자재입고 요청
    3: Result := AHiASIniConfig.DirectDeliverPIC;//자재직투입 요청
    4: Result := AHiASIniConfig.ShippingPIC;//출하지시 요청
    5: Result := AHiASIniConfig.ServicePIC;//필드서비스팀 요청
//    6: Result := PO_REQ_EMAIL_ADDR; //PO 요청
//    7: Result := FSettings.ShippingReqEmailAddr;//출하 요청
//    8: Result := FSettings.FieldServiceReqEmailAddr;//필드서비스팀 요청
  end;
end;

end.
