unit UnitHiConMPMWebInfUtil;

interface

uses System.SysUtils, Vcl.Forms, Vcl.Dialogs, Registry, Windows, Classes, Vcl.Controls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdIOHandler,
  IdGlobal, IdHTTP,
  OtlCommon, OtlComm, OtlTaskControl, OtlContainerObserver, otlTask, OtlParallel,
  OtlSync,
  mormot.core.base, mormot.core.os, mormot.core.text, mormot.net.client,
  mormot.core.collections, mormot.core.variants, mormot.core.json,
  UnitChkDupIdData, UnitHiconMPMData
  ;

type
  THiConCOMWeb_Header = packed record
    FName,  //COM Name
    FIndex, //Index
    FCOM,   //Master or Slave
    FRTU    //Master or Slave
    : string;
  end;

  THiConMPMWeb_Inf = class
  private
    class function GetCOMNameFromHtml(AHtml: string): string; static;
  public
    class var FCOMWebHeader: THiConCOMWeb_Header;
    class var FCOMSWVersionRec: THiConSWVersionRec;
    ///RUN state Command
    class function GetHeaderFromCOM_Async(AIpAddr: string): string;
    class function GetHeaderFromCOM(AIpAddr: string): string;
    class function GetHeaderUrlFromIpAddr(AIpAddr: string): string;
    //Result : Web Header에 표시된 COM Name
    class function GetNameNHeader2ClassRecFromHtml(AIpAddr, AHtml: string): string;
    class function GetLocalNameFromCOM(AIpAddr: string): string;

    class function GetRunDiagFromCOM_Async(AIpAddr: string): string;
    class function GetRunDiagUrlFromIpAddr(AIpAddr: string): string;
    class function GetHiscm_imVersionFromRunDiagHtml(AIpAddr, AHtml: string): string;

    class function GetVersionFromCOM_Async(AIpAddr: string): string;
    class function GetVersionFromCOM(AIpAddr: string): string;
    class function GetVersionUrlFromIpAddr(AIpAddr: string): string;
    class function GetVersion2JsonAryFromVersionHtml(AIpAddr, AHtml: string): string;
    class function GetVersion2SWRecfFromVersionHtml(const AHtml: string; out ASWVersionRec: THiConSWVersionRec): integer;

  end;

implementation

uses UnitCopyData, pingsend, UnitHtmlUtil, UnitStringUtil, UnitLanUtil2;

{ THiConMPMWeb_Inf }

class function THiConMPMWeb_Inf.GetCOMNameFromHtml(AHtml: string): string;
begin

end;

class function THiConMPMWeb_Inf.GetHeaderFromCOM(AIpAddr: string): string;
var
  Lurl: string;
begin
  Result := '';

  if PingHost(AIpAddr) = -1 then
  begin
    TGPCopyData.Log2CopyData('Host not connected : <' + AIpAddr + '>', 1, msgHandle4CopyData);
    exit;
  end;

  LUrl := GetHeaderUrlFromIpAddr(AIpAddr);

  Result := HttpGet(LUrl, nil, False, nil, 5000);
end;

class function THiConMPMWeb_Inf.GetHeaderFromCOM_Async(AIpAddr: string): string;
var
  LResult: string;
begin
  Result := '';

  Parallel.Async(
    procedure (const task: IOmniTask)
    begin
      LResult := GetHeaderFromCOM(AIpAddr);
    end,

    Parallel.TaskConfig.OnMessage(nil).OnTerminated(
      procedure
      begin
        if LResult <> '' then
        begin
          TGPCopyData.Log2CopyData(AIpAddr, 2, msgHandle4CopyData);
          TGPCopyData.Log2CopyData(LResult, 8, msgHandle4CopyData);
        end;
      end
    )
  );
end;

class function THiConMPMWeb_Inf.GetHeaderUrlFromIpAddr(AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + ':8000/header';
end;

class function THiConMPMWeb_Inf.GetHiscm_imVersionFromRunDiagHtml(AIpAddr,
  AHtml: string): string;
var
  LStr, LHiscm_imVersion: string;
begin
  AHtml := StringReplace(AHtml, #13#10, '', [rfReplaceAll]);
  LHiscm_imVersion := ExtractTextInsideGivenTagEx('table', AHtml);
//  LHiscm_imVersion := ExtractTextInsideGivenTagEx('pre', LHiscm_imVersion);
  Result := Trim(ExtractTextBetweenDelim(LHiscm_imVersion, 'Ver', '#'));
end;

class function THiConMPMWeb_Inf.GetLocalNameFromCOM(AIpAddr: string): string;
begin
  Result := GetHeaderFromCOM(AIpAddr);

  if Result <> '' then
  begin
    Result := GetNameNHeader2ClassRecFromHtml(AIpAddr, Result);
  end;
end;

class function THiConMPMWeb_Inf.GetNameNHeader2ClassRecFromHtml(AIpAddr,
  AHtml: string): string;
var
  LStr, LHeader: string;
begin
  AHtml := StringReplace(AHtml, #13#10, '', [rfReplaceAll]);
  //COM01121(CAN ID:165) #Slave #Invalid Logic.
  LHeader := ExtractTextInsideGivenTagEx('h3', AHtml);

  FCOMWebHeader.FName := Trim(StrToken(LHeader, '('));
  StrToken(LHeader, ':');
  FCOMWebHeader.FIndex := Trim(StrToken(LHeader, ')'));

  StrToken(LHeader, '#');
  FCOMWebHeader.FCOM := StrToken(LHeader, '#'); //Master
  FCOMWebHeader.FRTU := StrToken(LHeader, '#'); //Master
  Result := FCOMWebHeader.FName;
end;

class function THiConMPMWeb_Inf.GetRunDiagFromCOM_Async(
  AIpAddr: string): string;
var
  LCon: RawByteString;
begin
  Result := '';

  Parallel.Async(
    procedure (const task: IOmniTask)
    var
      Lurl, LQuery, LFullUrl: string;
    begin
      AIpAddr := StrToken(AIpAddr, ';');

      if PingHost(AIpAddr) = -1 then
      begin
        TGPCopyData.Log2CopyData('Host not connected : <' + AIpAddr + '>', 1, msgHandle4CopyData);
        exit;
      end;

      LUrl := GetRunDiagUrlFromIpAddr(AIpAddr);

      LCon := HttpGet(LUrl, nil, False, nil, 5000);
    end,

    Parallel.TaskConfig.OnMessage(nil).OnTerminated(
      procedure
      begin
        if LCon <> '' then
        begin
          TGPCopyData.Log2CopyData(AIpAddr, 2, msgHandle4CopyData);
          TGPCopyData.Log2CopyData(LCon, 9, msgHandle4CopyData);
        end;
      end
    )
  );
end;

class function THiConMPMWeb_Inf.GetRunDiagUrlFromIpAddr(
  AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + ':8000/rundiag';
end;

class function THiConMPMWeb_Inf.GetVersionFromCOM(AIpAddr: string): string;
var
  Lurl: string;
begin
  LUrl := GetVersionUrlFromIpAddr(AIpAddr);
  Result := HttpGet(LUrl, nil, False, nil, 5000);
end;

class function THiConMPMWeb_Inf.GetVersionFromCOM_Async(
  AIpAddr: string): string;
var
  LCon: RawByteString;
begin
  Result := '';

  Parallel.Async(
    procedure (const task: IOmniTask)
    var
      LQuery, LFullUrl: string;
    begin
      AIpAddr := StrToken(AIpAddr, ';');

      if PingHost(AIpAddr) = -1 then
      begin
        TGPCopyData.Log2CopyData('Host not connected : <' + AIpAddr + '>', 1, msgHandle4CopyData);
        exit;
      end;

      LCon := GetVersionFromCOM(AIpAddr)
    end,

    Parallel.TaskConfig.OnMessage(nil).OnTerminated(
      procedure
      begin
        if LCon <> '' then
        begin
          //THiconisTCPF.FCurrentIpAddr 변수에 현재 IP Addr 저장
          TGPCopyData.Log2CopyData(AIpAddr, 2, msgHandle4CopyData);
          TGPCopyData.Log2CopyData(LCon, 10, msgHandle4CopyData);
        end;
      end
    )
  );
end;

class function THiConMPMWeb_Inf.GetVersion2JsonAryFromVersionHtml(AIpAddr,
  AHtml: string): string;
var
  LVersionHtml, LData: string;
  LDocList: IDocList;
begin
  Result := '';

  AHtml := StringReplace(AHtml, #13#10, '', [rfReplaceAll]);
  LVersionHtml := ExtractTextInsideGivenTagEx('table', AHtml);

  LData := ExtractTextInsideGivenTagNth('td', LVersionHtml,1);

  if LData <> ''  then
  begin
    LDocList := DocList('[]');

    LDocList.Append(LData);//Program

    LData := ExtractTextInsideGivenTagNth('td', LVersionHtml,2);
    LDocList.Append(LData);//Version

    LData := ExtractTextInsideGivenTagNth('td', LVersionHtml,3);
    LDocList.Append(LData);//hiscm_im

    LData := ExtractTextInsideGivenTagNth('td', LVersionHtml,4);
    LDocList.Append(LData);//4.1.0.5

    LData := ExtractTextInsideGivenTagNth('td', LVersionHtml,5);
    LDocList.Append(LData);//interface-a

    LData := ExtractTextInsideGivenTagNth('td', LVersionHtml,6);
    LDocList.Append(LData);//0.0.0.0
  end;

  Result := Utf8ToString(LDocList.Json);
end;

class function THiConMPMWeb_Inf.GetVersion2SWRecfFromVersionHtml(const AHtml: string;
  out ASWVersionRec: THiConSWVersionRec): integer;
var
  LStr, LName, LVer: string;
  LRow: integer;
begin
  LStr := ExtractTextInsideGivenTagEx('table', AHtml);
  LName := ExtractTextInsideGivenTagNth('td', LStr, 1);
  LVer := ExtractTextInsideGivenTagNth('td', LStr, 2);

  LName := ExtractTextInsideGivenTagNth('td', LStr, 3);
  LVer := ExtractTextInsideGivenTagNth('td', LStr, 4);

  if LName = 'hiscm_im' then
    ASWVersionRec.FHiscm_Im := LVer;

  LName := ExtractTextInsideGivenTagNth('td', LStr, 5);
  LVer := ExtractTextInsideGivenTagNth('td', LStr, 6);

  if LName = 'interface-a' then
    ASWVersionRec.FInterface_a := LVer;
end;

class function THiConMPMWeb_Inf.GetVersionUrlFromIpAddr(
  AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + ':8000/version';
end;

end.
