unit UStartUp;

interface

uses SysUtils;

type
  TStartUp = record
  strict private
    class procedure ErrorMessage(const Msg: string); static;
  public
    class function Execute: Boolean; static;
  end;

implementation

uses Windows, UConsts;

{ TStartUp }

class procedure TStartUp.ErrorMessage(const Msg: string);
resourcestring
  sTitle = 'SCR Report';
  sPrefix = 'SCRReport CANNOT START!';
begin
  MessageBeep(MB_ICONERROR);
  MessageBox(0, PChar(sPrefix + EOL2 + Msg), PChar(sTitle), MB_OK);
end;

class function TStartUp.Execute: Boolean;
begin
  Result := True;
end;

end.
