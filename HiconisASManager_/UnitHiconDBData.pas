unit UnitHiconDBData;

interface

uses System.Classes, System.SysUtils, UnitEnumHelper,
  mormot.core.variants, mormot.core.unicode, mormot.core.json, mormot.core.base;

{$REGION 'THiSysDB_InOut'}
type
  THiSysDB_InOut = (
    hsdbioInput,//INPUT
    hsdbioOutput,//OUTPUT
    hsdbioLinkMap,//LINK_MAP
    hsdbioFinal);
const
  R_HiSysDB_InOut : array[Low(THiSysDB_InOut)..High(THiSysDB_InOut)] of string =
    ('INPUT', 'OUTPUT', 'LINK_MAP', '');
{$ENDREGION}

{$REGION 'THiSysDB_ALM_SV'}
type
  THiSysDB_ALM_SV = (
    hsdbasvNone,//None
    hsdbasvCritical,//Critical
    hsdbasvHigh,//High
    hsdbasvMedium,//Medium
    hsdbasvLow,//Low
    hsdbasvFinal);
const
  R_HiSysDB_ALM_SV : array[Low(THiSysDB_ALM_SV)..High(THiSysDB_ALM_SV)] of string =
    ('None', 'Critical', 'High', 'Medium', 'Low', '');
{$ENDREGION}

var
  g_HiSysDB_InOut: TLabelledEnum<THiSysDB_InOut>;
  g_HiSysDB_ALM_SV: TLabelledEnum<THiSysDB_ALM_SV>;

implementation

initialization
//  g_HiSysDB_InOut.InitArrayRecord(R_HiSysDB_InOut);
//  g_HiSysDB_ALM_SV.InitArrayRecord(R_HiSysDB_ALM_SV);

end.
