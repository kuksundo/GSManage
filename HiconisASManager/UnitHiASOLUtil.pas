unit UnitHiASOLUtil;

interface

uses mormot.core.base, mormot.core.os,
  UnitHiASIniConfig;

function GetRecvEmailAddress(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
function GetCCEmailAddress(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
function GetEmailSubject(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
function GetEmailBody(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
//APicEmailAddr : email;성명 -> 성명만 반환함
function GetPICNameFromConfig(APicEmailAddr: string): string;

implementation

uses UnitStringUtil;

function GetRecvEmailAddress(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
begin
  case AMailType of
    1: begin
      Result := AHiASIniConfig.BudgetPIC;
      Result := StrToken(Result,';');//부품예산증액 요청
    end;
    2: begin
      Result := AHiASIniConfig.InputPIC;
      Result := StrToken(Result,';');//자재입고 요청
    end;
    3: begin
      Result := AHiASIniConfig.DirectDeliverPIC;
      Result := StrToken(Result,';');//자재직투입 요청
    end;
    4: begin
      Result := AHiASIniConfig.ShippingPIC;
      Result := StrToken(Result,';');//출하지시 요청
    end;
    5: begin
      Result := AHiASIniConfig.ServicePIC;
      Result := StrToken(Result,';');//필드서비스팀 요청
    end;
//    6: Result := PO_REQ_EMAIL_ADDR; //PO 요청
//    7: Result := FSettings.ShippingReqEmailAddr;//출하 요청
//    8: Result := FSettings.FieldServiceReqEmailAddr;//필드서비스팀 요청
  end;
end;

function GetCCEmailAddress(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
var
  LStr: string;
begin
  case AMailType of
    1: begin//부품예산증액 요청
      Result := AHiASIniConfig.FPurchasePIC;//구매담당자
      Result := StrToken(Result,';');
    end;
    2: begin
      Result := AHiASIniConfig.InputPIC;
      Result := StrToken(Result,';');//자재입고 요청
    end;
    3: begin
      Result := AHiASIniConfig.DirectDeliverPIC;
      Result := StrToken(Result,';');//자재직투입 요청
    end;
    4: begin
      Result := AHiASIniConfig.ShippingPIC;
      Result := StrToken(Result,';');//출하지시 요청
    end;
    5: begin
      Result := AHiASIniConfig.ServicePIC;
      Result := StrToken(Result,';');//필드서비스팀 요청
    end;
//    6: Result := PO_REQ_EMAIL_ADDR; //PO 요청
//    7: Result := FSettings.ShippingReqEmailAddr;//출하 요청
//    8: Result := FSettings.FieldServiceReqEmailAddr;//필드서비스팀 요청
  end;

  LStr := AHiASIniConfig.FTechnicalPIC;
  Result := Result + ';' + StrToken(LStr, ';');
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
      Result := replaceString(LStr, '_BudgetPIC_', GetPICNameFromConfig(AHiASIniConfig.FBudgetPIC));
      Result := replaceString(Result, '_HullNo_', AHiASIniConfig.FHullNo);
      Result := replaceString(Result, '_ProjNo_', AHiASIniConfig.FProjNo);
      Result := replaceString(Result, '_ClaimNo_', AHiASIniConfig.FClaimNo);
      Result := replaceString(Result, '_Reason_', AHiASIniConfig.FText);
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

function GetPICNameFromConfig(APicEmailAddr: string): string;
begin
  StrToken(APicEmailAddr, ';');
  Result := StrToken(APicEmailAddr, ';');
end;

end.
