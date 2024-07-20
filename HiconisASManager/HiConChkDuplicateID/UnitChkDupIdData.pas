unit UnitChkDupIdData;

interface

uses System.Classes, UnitEnumHelper;

type
  TIpListRec = record
    IPName,
    IPAddress,
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
