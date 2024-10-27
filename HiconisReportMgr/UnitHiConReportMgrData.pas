unit UnitHiConReportMgrData;

interface

uses System.Classes, UnitEnumHelper, Vcl.StdCtrls;

const
  MAX_REPORT_WORKITEM = 14;
  HIRPT_FILE_EXT = '.hirpt';
  KN_REPORT = 'Report';//Json KeyName
  KN_WORKITEM = 'WorkItem';

type
  THiconReportRec = packed record
    FReportKind: integer; //THiRptKind
    FCommissionRptKind: integer; //THiCommissionRptKind
    FReportListJson,
    FReportDetailJsonAry //JsonAry Çü½ÄÀÓ
    : string;
  end;

  THiRptMgrQueryDateType = (hrmqdtNull,
    hrmqdtFinal);

  THiRptWorkCode = (hrwcNull,
    hrwcA, hrwcB_1, hrwcB_2, hrwcB_3, hrwcB_4, hrwcC_1, hrwcC_2, hrwcD,
    hrwcFinal);

  THiRptKind = (hrkNull,
    hrkCR, hrkSR,
    hrkFinal);

  THiCommissionRptKind = (hcrkNull,
    hcrkTotal, hcrkSummary, hcrkCode, hcrkSummaryByCode,
    hcrkFinal);

  THiRptModifiedItem = (
    hrmiStraton, hrmiDB, hrmiHMI, hrmiSystem, hrmiIOList, hrmiDrawing, hrmiCnEChart,
    hrmiFinal);

const
{$REGION 'R_HiRptMgrQueryDateType'}
  R_HiRptMgrQueryDateType : array[Low(THiRptMgrQueryDateType)..High(THiRptMgrQueryDateType)] of string =
    ('',
     '');
{$ENDREGION}

{$REGION 'R_HiRptWorkCode'}
  R_HiRptWorkCode : array[Low(THiRptWorkCode)..High(THiRptWorkCode)] of string =
    ('',
     'A',
     'B-1',
     'B-2',
     'B-3',
     'B-4',
     'C-1',
     'C-2',
     'D',
     '');

  R_HiRptWorkCodeDesc : array[Low(THiRptWorkCode)..High(THiRptWorkCode)] of string =
    ('',
     'A: Normal Commissioning - Attending test, Technical support, Simple troubleshooting, Tuning parameter, System check',
     'B-1: Internal Modification(Software/Design) - Wrong IO setup, Mimic, Logic, Sequence, Configuration of system',
     'B-2: Internal Modification(Hardware/Design) - Missing parts, Wrong wiring, Difference against Master DW',
     'B-3: Internal Modification(Platform/R&D) - Upgrade of Tools and component, Patch, Troubleshooting based on platform issue',
     'B-4: Internal Modification(Truble Shooting/Commissioning) - Trouble shooting with other vendors, internal issue(more than one day)',
     'C-1: External Modification(Request by yard/Owner side) - All the change request against IO list, FDS, Master DW without cost',
     'C-2: External Modification(Request by yard/Owner side) - All the change request against IO list, FDS, Master DW with cost',
     'D: Waiting time(by yard/other venders) - Standby on board or in office based on yard or other vender issue',
     '');

{$ENDREGION}

{$REGION 'R_HiRptKind'}
  R_HiRptKind : array[Low(THiRptKind)..High(THiRptKind)] of string =
    ('',
     'Commissioning Report',
     'Service Report',
     '');
{$ENDREGION}

{$REGION 'R_HiRptModifiedItem'}
  R_HiRptModifiedItem : array[Low(THiRptModifiedItem)..High(THiRptModifiedItem)] of string =
    (
      'Straton', 'DB', 'HMI(HiView)', 'System(HiCONIS)', 'I/O List', 'Drawing', 'C & E Chart',
     '');
{$ENDREGION}

var
  g_HiRptMgrQueryDateType: TLabelledEnum<THiRptMgrQueryDateType>;
  g_HiRptWorkCode: TLabelledEnum<THiRptWorkCode>;
  g_HiRptWorkCodeDesc: TLabelledEnum<THiRptWorkCode>;
  g_HiRptKind: TLabelledEnum<THiRptKind>;
  g_HiRptModifiedItem: TLabelledEnum<THiRptModifiedItem>;

implementation

initialization
//  g_HiRptMgrQueryDateType.InitArrayRecord(R_HiRptMgrQueryDateType);
//  g_HiRptWorkCode.InitArrayRecord(R_HiRptWorkCode);
//  g_HiRptWorkCodeDesc.InitArrayRecord(R_HiRptWorkCodeDesc);
//  g_HiRptKind.InitArrayRecord(R_HiRptKind);
//  g_HiRptModifiedItem.InitArrayRecord(R_HiRptModifiedItem);

end.
