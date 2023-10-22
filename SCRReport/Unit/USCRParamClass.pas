unit USCRParamClass;

interface

uses IniPersist, UnitConfigIniClass2;

type
  TSCRParameterRecord = record
  {$I SCRParamFieldList.txt}
  end;

  TSCRParameter = class(TINIConfigBase)
  private
  {$I SCRParamFieldList.txt}
  public
    //Section Name, Key Name, Default Key Value  (Control.hint = SectionName;KeyName 으로 저장 함)
    [IniValue('Application Setting','System', 'False', 10)]
    property FourS_LPSCR_Enable : Boolean read F4S_LPSCR_Enable write F4S_LPSCR_Enable;
  end;

implementation

end.
