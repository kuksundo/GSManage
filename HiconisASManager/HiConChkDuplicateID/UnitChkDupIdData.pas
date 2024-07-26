unit UnitChkDupIdData;

interface

uses System.Classes, UnitEnumHelper;

type
  TIpListRec = record
    RES_NAME,
    PMPM_PIP,
    PMPM_SIP,
    Port
    : string;
  end;

  TIDListRec = record
    MMAddress,
    TagId
    : string;
  end;

  TDupIDListRec = record
    IpRec: TIpListRec;
    DupIdRec: TIDListRec;
  end;

implementation

end.
