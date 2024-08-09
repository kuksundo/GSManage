unit UnitHiASOLUtil;

interface

uses mormot.core.base, mormot.core.os,
  UnitHiASIniConfig;

function GetRecvEmailAddress(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
function GetCCEmailAddress(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
function GetEmailSubject(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
function GetEmailBody(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
//APicEmailAddr : email;���� -> ���� ��ȯ��
function GetPICNameFromConfig(APicEmailAddr: string): string;

implementation

uses UnitStringUtil;

function GetRecvEmailAddress(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
begin
  case AMailType of
    1: begin
      Result := AHiASIniConfig.BudgetPIC;
      Result := StrToken(Result,';');//��ǰ�������� ��û
    end;
    2: begin
      Result := AHiASIniConfig.InputPIC;
      Result := StrToken(Result,';');//�����԰� ��û
    end;
    3: begin
      Result := AHiASIniConfig.DirectDeliverPIC;
      Result := StrToken(Result,';');//���������� ��û
    end;
    4: begin
      Result := AHiASIniConfig.ShippingPIC;
      Result := StrToken(Result,';');//�������� ��û
    end;
    5: begin
      Result := AHiASIniConfig.ServicePIC;
      Result := StrToken(Result,';');//�ʵ弭���� ��û
    end;
//    6: Result := PO_REQ_EMAIL_ADDR; //PO ��û
//    7: Result := FSettings.ShippingReqEmailAddr;//���� ��û
//    8: Result := FSettings.FieldServiceReqEmailAddr;//�ʵ弭���� ��û
  end;
end;

function GetCCEmailAddress(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
var
  LStr: string;
begin
  case AMailType of
    1: begin//��ǰ�������� ��û
      Result := AHiASIniConfig.FPurchasePIC;//���Ŵ����
      Result := StrToken(Result,';');
    end;
    2: begin
      Result := AHiASIniConfig.InputPIC;
      Result := StrToken(Result,';');//�����԰� ��û
    end;
    3: begin
      Result := AHiASIniConfig.DirectDeliverPIC;
      Result := StrToken(Result,';');//���������� ��û
    end;
    4: begin
      Result := AHiASIniConfig.ShippingPIC;
      Result := StrToken(Result,';');//�������� ��û
    end;
    5: begin
      Result := AHiASIniConfig.ServicePIC;
      Result := StrToken(Result,';');//�ʵ弭���� ��û
    end;
//    6: Result := PO_REQ_EMAIL_ADDR; //PO ��û
//    7: Result := FSettings.ShippingReqEmailAddr;//���� ��û
//    8: Result := FSettings.FieldServiceReqEmailAddr;//�ʵ弭���� ��û
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
      LStr := Utf8ToString(LUtf8);//��ǰ�������� ��ûMail
      Result := replaceString(LStr, '_BudgetPIC_', GetPICNameFromConfig(AHiASIniConfig.FBudgetPIC));
      Result := replaceString(Result, '_HullNo_', AHiASIniConfig.FHullNo);
      Result := replaceString(Result, '_ProjNo_', AHiASIniConfig.FProjNo);
      Result := replaceString(Result, '_ClaimNo_', AHiASIniConfig.FClaimNo);
      Result := replaceString(Result, '_Reason_', AHiASIniConfig.FText);
    end;
    2: Result := AHiASIniConfig.InputPIC;//�����԰� ��û
    3: Result := AHiASIniConfig.DirectDeliverPIC;//���������� ��û
    4: Result := AHiASIniConfig.ShippingPIC;//�������� ��û
    5: Result := AHiASIniConfig.ServicePIC;//�ʵ弭���� ��û
//    6: Result := PO_REQ_EMAIL_ADDR; //PO ��û
//    7: Result := FSettings.ShippingReqEmailAddr;//���� ��û
//    8: Result := FSettings.FieldServiceReqEmailAddr;//�ʵ弭���� ��û
  end;
end;

function GetPICNameFromConfig(APicEmailAddr: string): string;
begin
  StrToken(APicEmailAddr, ';');
  Result := StrToken(APicEmailAddr, ';');
end;

end.
