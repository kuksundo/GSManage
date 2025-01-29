unit UnitHiConMPMWebUtil;

interface

uses System.SysUtils, Vcl.Forms, Vcl.Dialogs, Registry, Windows, Classes,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdIOHandler,
  IdGlobal, IdHTTP,
  OtlCommon, OtlComm, OtlTaskControl, OtlContainerObserver, otlTask, OtlParallel,
  OtlSync,
  mormot.core.base, mormot.core.os, mormot.core.text, mormot.net.client,
  mormot.core.collections, mormot.core.variants, mormot.core.json,
  UnitChkDupIdData
  ;

type
  THiConMPMWeb = class
  public
    class procedure Log2CopyData(const AMsg: string; const AMsgKind: integer);
    class function GetLResFromMPM_Async(ARec: TIpListRec): string;
    class function GetLResUrlFromIpRec(AIpAddr: string): string;
  end;

implementation

uses UnitCopyData, pingsend;

{ THiConMPMWeb }

class function THiConMPMWeb.GetLResFromMPM_Async(ARec: TIpListRec): string;
var
  LCon: RawByteString;
  LIpAddr: string;
begin
  Result := '';

  Parallel.Async(
    procedure (const task: IOmniTask)
    var
      LHttp: TIdHttp;
      Lurl, LQuery, LFullUrl: string;
    begin
      if ARec.PMPM_PIP = '127.0.0.1' then
        exit;

      LIpAddr := ARec.PMPM_PIP;

      if PingHost(LIpAddr) = -1 then
      begin
        Log2CopyData('Host not connected : <' + LIpAddr + '>', 1);
        exit;
      end;

      LUrl := GetLResUrlFromIpRec(LIpAddr);

      LCon := HttpGet(LUrl, nil, False, nil, 5000);
    end,

    Parallel.TaskConfig.OnMessage(nil).OnTerminated(
      procedure
      begin
        if LCon <> '' then
        begin
          Log2CopyData(LIpAddr, 2);
          Log2CopyData(LCon, 3);
        end;
      end
    )
  );
end;

class function THiConMPMWeb.GetLResUrlFromIpRec(AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + '/lres';
end;

class procedure THiConMPMWeb.Log2CopyData(const AMsg: string; const AMsgKind: integer);
begin
  SendCopyData4(msgHandle4CopyData, AMsg, AMsgKind);
end;

end.
