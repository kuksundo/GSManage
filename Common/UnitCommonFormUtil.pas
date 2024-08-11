unit UnitCommonFormUtil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  JvExMask, JvToolEdit, JvCombobox
  ;

function ShowCheckGrp4Claim(AClaimTypeKind, ACheckValueList: integer): integer;
function ShowCheckGrp4EmailContainData(ACheckValueList: integer): integer;

implementation

uses FrmSelectCheckBox, UnitElecServiceData2, UnitHiconisASData;

function ShowCheckGrp4Claim(AClaimTypeKind, ACheckValueList: integer): integer;
var
  LStrList: TStringList;
begin
  LStrList := TStringList.Create;
  try
    case TClaimTypeKind(AClaimTypeKind) of
      ctkCatetory: g_ClaimCategory.SetType2List(LStrList);
      ctkLocation: g_ClaimLocation.SetType2List(LStrList);
      ctkCauseKind: g_ClaimCauseKind.SetType2List(LStrList);
      ctkCauseHW: g_ClaimCauseHW.SetType2List(LStrList);
      ctkCauseSW: g_ClaimCauseSW.SetType2List(LStrList);
    end;

    Result := GetSetFromCheckBoxGrp(LStrList, ACheckValueList, g_ClaimTypeKind.ToString(AClaimTypeKind));
  finally
    LStrList.Free;
  end;
end;

function ShowCheckGrp4EmailContainData(ACheckValueList: integer): integer;
var
  LStrList: TStringList;
begin
  LStrList := TStringList.Create;
  try
    g_ContainData4Mail.SetType2List(LStrList);
    Result := GetSetFromCheckBoxGrp(LStrList, ACheckValueList, 'Email Contained File');
  finally
    LStrList.Free;
  end;
end;

end.
