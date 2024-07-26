unit UnitHiASOLUtil;

interface

uses UnitHiASIniConfig;

function GetRecvEmailAddress(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
function GetEmailSubject(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
function GetEmailBody(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;

implementation

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

function GetEmailSubject(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
begin

end;

function GetEmailBody(AMailType: integer; AHiASIniConfig: THiASIniConfig): string;
begin

end;

end.
