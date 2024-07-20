unit UnitHiconisASWSInterface;

interface

uses
  SysUtils,
  mormot.soa.core, mormot.core.base, mormot.core.interfaces;

type
  IHiconisASCallback = interface(IInvokable)
    ['{7948C89E-6F46-47EC-845E-B99DA68E093E}']
    procedure ClientExecute(const command, msg: string);
  end;

  IHiconisASService = interface(IServiceWithCallbackReleased)
    ['{6F31F4EE-B8A4-4308-A62B-F29A0A5842B1}']
    procedure Join(const pseudo: string; const callback: IHiconisASCallback);
    function ServerExecute(const Acommand: RawUTF8): RawUTF8;
  end;

implementation

{$IFDEF USE_MORMOT_WS}
initialization
  TInterfaceFactory.RegisterInterfaces([
    TypeInfo(IHiconisASService),TypeInfo(IHiconisASCallback)]);
{$ENDIF}
end.
