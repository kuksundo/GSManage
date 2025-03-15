unit UnitHiconTCPIniConfig;

interface

uses TypInfo, UnitIniAttriPersist, UnitIniConfigBase;

type
  THiconTCPIniConfig = class(TJHPIniConfigBase)
    FHiconBaseDir,//H:\HiCONIS\
    FHiconHullNo, //HMD8310
    FEquipKind    //ICMS/ALS/ISS
    : string;
  public
  published
    //Section Name, Key Name, Default Key Value  (Control.hint = SectionName;KeyName 으로 저장 함)
    [JHPIni('File','Hicon Base Dir','H:\','1', tkString)]
    property HiconBaseDir : string read FHiconBaseDir write FHiconBaseDir;
    [JHPIni('File','Equipment Kind','ICMS','2', tkString)]
    property EquipKind : string read FEquipKind write FEquipKind;
    [JHPIni('File','Hicon Hull No','HMD8310','3', tkString)]
    property HiconHullNo : string read FHiconHullNo write FHiconHullNo;
  end;

implementation

end.
