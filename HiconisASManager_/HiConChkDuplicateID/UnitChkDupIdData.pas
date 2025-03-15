unit UnitChkDupIdData;

interface

uses System.Classes, UnitEnumHelper;

type
  TIpListRec = packed record
    RES_NAME,
    PMPM_PIP,
    PMPM_SIP,
    Port,
    DESCRIPTION
    : string;
  end;

  TIDListRec = packed record
    MMAddress,
    TagId
    : string;
  end;

  TDupIDListRec = packed record
    IpRec: TIpListRec;
    DupIdRec: TIDListRec;
  end;

  TSVRInfoRec = packed record
    SVR_NAME,
    DESCRIPTION,
    PIP,
    SIP
    : string;
  end;

  TEngineerInfoRec = packed record
    EngineerId,
    EngineerName
    : string;
  end;

  TVesselInfoRec = packed record
    HullNo,
    ShipName,
    IMONo
    : string;
  end;

  TResourceInfoRec = packed record
    RES_NAME,
    DESCRIPTION,
    PMPMName,
    PMPM_PIP,
    PMPM_SIP,
    SMPMName,
    SMPMPIP,
    SMPMSIP,
    ResID
    : string;
  end;

  TResultCheckDupIDRec = packed record
//    SVRInfoRec: TSVRInfoRec;
//    EngineerInfoRec: TEngineerInfoRec;
    VesselInfoRec: TVesselInfoRec;
    ResourceInfoRec: TResourceInfoRec;
    DupIdCount,
    CheckDate,
    CreateDate
    : string;
  end;

implementation

end.
