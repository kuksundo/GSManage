unit UnitHiconisASWSInterface;

interface

uses
  SysUtils,
  mormot.soa.core, mormot.core.base, mormot.core.interfaces;

type
  IHiconisASCallback = interface(IInvokable)
    ['{3353F04E-3AFA-4E23-A8C7-64FA51374270}']
    procedure ClientExecute(const command, msg: string);
  end;

  IHiconisASService = interface(IServiceWithCallbackReleased)
    ['{FF0AEF1B-4389-4911-A9D7-233EEB9E0FA6}']
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
