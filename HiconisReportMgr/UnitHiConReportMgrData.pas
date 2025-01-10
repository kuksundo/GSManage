unit UnitHiConReportMgrData;

interface

uses System.Classes, UnitEnumHelper, Vcl.StdCtrls;

const
  MAX_REPORT_WORKITEM = 14;
  HIRPT_FILE_EXT = '.hirpt';
  KN_REPORT = 'Report';//Json KeyName
  KN_WORKITEM = 'WorkItem';
  KN_REPORT_FILES = 'Report_Files';
  KN_CHGREGRPT = 'ChgRegRpt';
  KN_CHGREGRPT_FILES = 'ChgRegRpt_Files';

type
  THiconReportRec = packed record
    FReportKind: integer; //THiRptKind
    FCommissionRptKind: integer; //THiCommissionRptKind
    FReportListJson,
    FReportDetailJsonAry //JsonAry Çü½ÄÀÓ
    : string;
  end;

type
  THiCommissionRptKind = (hcrkNull,
    hcrkTotal, hcrkSummary, hcrkCode, hcrkSummaryByCode,
    hcrkFinal);

{$REGION 'R_HiRptMgrQueryDateType'}
type
  THiRptMgrQueryDateType = (hrmqdtNull,
    hrmqdtFinal);
const
  R_HiRptMgrQueryDateType : array[Low(THiRptMgrQueryDateType)..High(THiRptMgrQueryDateType)] of string =
    ('',
     '');
{$ENDREGION}

{$REGION 'R_HiRptWorkCode'}
type
  THiRptWorkCode = (hrwcNull,
    hrwcA, hrwcB_1, hrwcB_2, hrwcB_3, hrwcB_4, hrwcC_1, hrwcC_2, hrwcD,
    hrwcFinal);
const
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
type
  THiRptKind = (hrkNull,
    hrkCOM, hrkSVR, hrkCHR,
    hrkFinal);

const
  R_HiRptKind : array[Low(THiRptKind)..High(THiRptKind)] of string =
    ('',
     'Commissioning Report',
     'Service Report',
     'Change Register Report',
     '');

  R_HiRptKind2 : array[Low(THiRptKind)..High(THiRptKind)] of string =
    ('',
     'COM',
     'SVR',
     'CHR',
     '');
{$ENDREGION}

{$REGION 'R_HiRptSystemKind'}
type
  THiRptSystemKind = (hrcNull,
    hrcIAS, hrcFGSS, hrcLFSS, hrcSCR, hrcALS,
    hrcFinal);

const
  R_HiRptSystemKind : array[Low(THiRptSystemKind)..High(THiRptSystemKind)] of string =
    ('',
     'IAS',
     'FGSS',
     'LFSS',
     'SCR',
     'ALS',
     '');
{$ENDREGION}

{$REGION 'R_HiRptModifiedItem'}
type
  THiRptModifiedItem = (
    hrmiStraton, hrmiDB, hrmiHMI, hrmiSystem, hrmiIOList, hrmiDrawing, hrmiCnEChart,
    hrmiFinal);

const
  R_HiRptModifiedItem : array[Low(THiRptModifiedItem)..High(THiRptModifiedItem)] of string =
    (
      'Straton', 'DB', 'HMI(HiView)', 'System(HiCONIS)', 'I/O List', 'Drawing', 'C & E Chart',
     '');
{$ENDREGION}

{$REGION 'R_HiRptModifyReqSrc'}
type
  THiRptModifyReqSrc = (
    hrmrsYard, hrmrsOwner, hrmrsClass, hrmrsHMS, hrmrsOther,
    hrmrsFinal);

const
  R_HiRptModifyReqSrc : array[Low(THiRptModifyReqSrc)..High(THiRptModifyReqSrc)] of string =
    (
      'Yard', 'Owner', 'Class', 'HMS', 'Other',
     '');
{$ENDREGION}

{$REGION 'R_HiRptModifyReqSrc'}
type
  THiRptImportance = (
    hriMinorChg, hriMajorChg,
    hriFinal);

  THiRptPriority = (
    hrpLowPriority, hrpHighPriority,
    hrpFinal);
const
  R_HiRptImportance : array[Low(THiRptImportance)..High(THiRptImportance)] of string =
    (
      'Minor Change', 'Major Change',
     '');

  R_HiRptPriority : array[Low(THiRptPriority)..High(THiRptPriority)] of string =
    (
      'Low Priority', 'High Priority',
     '');
{$ENDREGION}

function GetYardNameByHullNo(AHullNo: string): string;

var
  g_HiRptMgrQueryDateType: TLabelledEnum<THiRptMgrQueryDateType>;
  g_HiRptWorkCode: TLabelledEnum<THiRptWorkCode>;
  g_HiRptWorkCodeDesc: TLabelledEnum<THiRptWorkCode>;
  g_HiRptKind: TLabelledEnum<THiRptKind>;
  g_HiRptKind2: TLabelledEnum<THiRptKind>;
  g_HiRptSystemKind: TLabelledEnum<THiRptSystemKind>;
  g_HiRptModifiedItem: TLabelledEnum<THiRptModifiedItem>;
  g_HiRptModifyReqSrc: TLabelledEnum<THiRptModifyReqSrc>;
  g_HiRptImportance: TLabelledEnum<THiRptImportance>;
  g_HiRptPriority: TLabelledEnum<THiRptPriority>;

implementation

uses UnitStringUtil;

function GetYardNameByHullNo(AHullNo: string): string;
begin
  if Pos('HHI', AHullNo) > 0 then
    Result := 'HHI'
  else
  if Pos('SHI', AHullNo) > 0 then
    Result := 'SHI'
  else
  if Pos('HMD', AHullNo) > 0 then
    Result := 'HMD'
  else
  if Pos('DW', AHullNo) > 0 then
    Result := 'Hanwa'
  else
    Result := RemoveNumbersBetweenString(AHullNo);
end;

initialization
//  g_HiRptMgrQueryDateType.InitArrayRecord(R_HiRptMgrQueryDateType);
//  g_HiRptWorkCode.InitArrayRecord(R_HiRptWorkCode);
//  g_HiRptWorkCodeDesc.InitArrayRecord(R_HiRptWorkCodeDesc);
//  g_HiRptKind.InitArrayRecord(R_HiRptKind);
//  g_HiRptKind2.InitArrayRecord(R_HiRptKind2);
//  g_HiRptSystemKind.InitArrayRecord(R_HiRptSystemKind);
//  g_HiRptModifiedItem.InitArrayRecord(R_HiRptModifiedItem);
//  g_HiRptModifyReqSrc.InitArrayRecord(R_HiRptModifyReqSrc);
//  g_HiRptImportance.InitArrayRecord(R_HiRptImportance);
//  g_HiRptPriority.InitArrayRecord(R_HiRptPriority);

end.
