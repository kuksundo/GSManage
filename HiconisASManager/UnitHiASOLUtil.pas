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
    1: Result := AHiASIniConfig.BudgetPIC;//��ǰ�������� ��û
    2: Result := AHiASIniConfig.InputPIC;//�����԰� ��û
    3: Result := AHiASIniConfig.DirectDeliverPIC;//���������� ��û
    4: Result := AHiASIniConfig.ShippingPIC;//�������� ��û
    5: Result := AHiASIniConfig.ServicePIC;//�ʵ弭���� ��û
//    6: Result := PO_REQ_EMAIL_ADDR; //PO ��û
//    7: Result := FSettings.ShippingReqEmailAddr;//���� ��û
//    8: Result := FSettings.FieldServiceReqEmailAddr;//�ʵ弭���� ��û
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
      LStr := Utf8ToString(LUtf8);//��ǰ�������� ��ûMail
      Result := replaceString(LStr, '_projNo_', AHiASIniConfig.FProjNo);
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

end.
