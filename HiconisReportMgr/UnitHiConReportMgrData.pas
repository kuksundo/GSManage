unit UnitHiConReportMgrData;

interface

uses System.Classes, UnitEnumHelper, Vcl.StdCtrls;

type
  THiRptMgrQueryDateType = (hrmqdtNull,
    hrmqdtFinal);

  THiRptMgrSearchCondRec = record
    FFrom, FTo
    : TDateTime;
    FQueryDate
    : THiRptMgrQueryDateType;
    FHullNo, FShipName, FShipOwner, FProjNo, FSubject,
    FClassSociety, FReportAuthorID, FReportAuthorName
    : string;
    FReportKind, FModifyItems, FWorkCode
    : integer;
    FIncludeClosed //Closed 된 Task도 포함하여 표시함
    : Boolean;
  end;

  THiRptWorkCode = (hrwcNull,
    hrwcA, hrwcB, hrwcC, hrwcD, hrwcE,
    hrwcFinal);

  THiRptKind = (hrkNull,
    hrkSR, hrkCR,
    hrkFinal);

  THiRptModifiedItem = (hrmiNull,
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
     'B',
     'C',
     'D',
     'E',
     '');
{$ENDREGION}

{$REGION 'R_HiRptKind'}
  R_HiRptKind : array[Low(THiRptKind)..High(THiRptKind)] of string =
    ('',
     'Service Report',
     'Commissioning Report',
     '');
{$ENDREGION}

{$REGION 'R_HiRptModifiedItem'}
  R_HiRptModifiedItem : array[Low(THiRptModifiedItem)..High(THiRptModifiedItem)] of string =
    ('',
     '');
{$ENDREGION}

var
  g_HiRptMgrQueryDateType: TLabelledEnum<THiRptMgrQueryDateType>;
  g_HiRptWorkCode: TLabelledEnum<THiRptWorkCode>;
  g_HiRptKind: TLabelledEnum<THiRptKind>;
  g_HiRptModifiedItem: TLabelledEnum<THiRptModifiedItem>;

implementation

initialization
//  g_HiRptMgrQueryDateType.InitArrayRecord(R_HiRptMgrQueryDateType);
//  g_HiRptWorkCode.InitArrayRecord(R_HiRptWorkCode);
//  g_HiRptKind.InitArrayRecord(R_HiRptKind);
//  g_HiRptModifiedItem.InitArrayRecord(R_HiRptModifiedItem);

end.
