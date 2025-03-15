unit UnitHiConMPMWebUtil;

interface

uses System.SysUtils, Vcl.Forms, Vcl.Dialogs, Registry, Windows, Classes, Vcl.Controls,
  System.Variants,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdIOHandler,
  IdGlobal, IdHTTP,
  OtlCommon, OtlComm, OtlTaskControl, OtlContainerObserver, otlTask, OtlParallel,
  OtlSync,
  mormot.core.base, mormot.core.os, mormot.core.text, mormot.net.client,
  mormot.core.collections, mormot.core.variants, mormot.core.json,
  UnitChkDupIdData, UnitHiconMPMData
  ;

const
  HIRS_VER_LATEAST = '4.0.1.58'; //4
  HIRS_VER_V1 = 1;//hirs version: 4.0.0.8
  HIRS_VER_V2 = 5;//hirs version: 4.0.1.0

type
  THiConMPMWeb_Header = packed record
    FName,  //MPM Name
    FIndex, //Index
    FMPM,   //Master or Slave
    FRTU    //Master or Slave
    : string;
  end;

  THiConMPMWeb_lres = packed record
    FIndex,
    FPrimary,
    FSecondary,
    FMaster,
    FTime
    : string;
  end;

  THiConMPMWeb_CFInput = packed record
    FLocalName,  //MPM Name
    FEth0IP,
    FEth0NetMask,
    FEth0GateWay,
    FEth1IP,
    FEth1NetMask,
    FEth1GateWay
    : string;
  end;

  THiConMPMWeb = class
  private
    class function GetMPMNameFromHtml(AHtml: string): string; static;
  public
    class var FHirsVersion: string;
    class var FMPMWebHeader: THiConMPMWeb_Header;

    ///DB Information Command
    class function GetHeaderFromMPM_Async(AIpAddr: string): string;
    class function GetHeaderFromMPM(AIpAddr: string): string;
    class function GetHeaderUrlFromIpAddr(AIpAddr: string): string;
    //Result : Web Header에 표시된 MPM Name
    class function GetNameNHeader2ClassRecFromHtml(AIpAddr, AHtml: string): string;
    class function GetLocalNameFromMPM(AIpAddr: string): string;

    class function GetCommandFromMPM_Async(AIpAddr: string): string;
    class function GetCommandFromMPM(AIpAddr: string): string;
    class function GetCommandUrlFromIpAddr(AIpAddr: string): string;
    class function GetCommandList2JsonAryFromHtml(AIpAddr, AHtml: string): string;

    class function GetLResFromMPM_Async(ARec: TIpListRec): string;
    class function GetLResUrlFromIpRec(AIpAddr: string): string;
    class function GetLResRecList2JsonAryFromHtml(AIpAddr, AHtml: string; AHirsVersion: string=''): string;
    class function GetLResRecList2JsonAryFromHtmlByHirsV1(AIpAddr, AHtml: string): string;
    class function GetLResRecList2JsonAryFromHtmlByHirsV2(AIpAddr, AHtml: string): string;

    class function GetLMPMFromMPM_Async(ARec: TIpListRec): integer;
    class function GetLMPMFromMPM(AIpAddr: string): string;
    class function GetLMPMUrlFromIpRec(AIpAddr: string): string;
    class function GetLMPMList2JsonAryFromHtml(AIpAddr, AHtml: string; AHirsVersion: string=''): string;
    class function GetLMPMList2JsonAryFromHtmlByHirsV1(AIpAddr, AHtml: string): string;
    class function GetLMPMList2JsonAryFromHtmlByHirsV2(AIpAddr, AHtml: string): string;
    class function GetLMPMListFromHtmlByHirsV2(AIpAddr, AHtml: string): IKeyValue<string, string>;

    class function GetLVerFromMPM_Async(ARec: TIpListRec): integer;
    class function GetLVerFromMPM(AIpAddr: string): string;
    class function GetLVerUrlFromIpRec(AIpAddr: string): string;
    class procedure GetLVerListFromHtml(AHtml: string; out ADesc, AHirsVer, ALogicVer: string);

    class function GetVersionFromMPM_Async(ARec: TIpListRec): integer;
    class function GetVersionUrlFromMPM(AIpAddr: string): string;
    class function GetVersionFromMPM(AIpAddr: string): string;
    class function GetVersionList2JsonAryFromHtml(AIpAddr, AHtml: string): string;

    class function GetFBVerFromMPM_Async(ARec: TIpListRec): integer;
    class function GetFBVerUrlFromMPM(AIpAddr: string): string;
    class function GetFBVerFromMPM(AIpAddr: string): string;
    class function GetFBVerList2JsonAryFromHtml(AIpAddr, AHtml: string): string;

    class function GetRetainMapFromMPM_Async(ARec: TIpListRec): integer;
    class function GetRetainMapFromMPM(AIpAddr: string): string;
    class function GetRetainMapUrlFromMPM(AIpAddr: string): string;
    class function GetRetainMapList2JsonAryFromHtml(AIpAddr, AHtml: string): string;

    class function GetVersionIntfUrlFromIpRec(AIpAddr: string): string;

    ///Maintenance Command

    //AIpAddrList: ';'로 구분됨
    class function BackupMPM(AIpAddrList: string): string;
    //AIpAddr: IP 한개임
    class function DownloadBackupMPMAsync(AIpAddr: string): string;

    class function GetRestoreUrlFromIpAddr(AIpAddr: string): string;
    //AIpAddrList: ';'로 구분됨
    //ABakupFileName: 'MPM11P.tgz'
    class function RestoreMPM(AFormHandle: THandle; AIpAddrList, ABakupFileName: string): string;
    //AIpAddr: IP 한개임
    class function RestoreMPMAsync_Indy(AIpAddr, ABakupFileName: string): string;
    //AIpAddr: IP 한개임
    //*.tgz file을 MPM의 /tmp에 복사하는 함수 Web "Upload" Button
    class function PostRestoreFile2MPMAsync_mORMot(AFormHandle: THandle; AIpAddr, ABakupFileName: string): string;
    //AHtml 내에 '200' 이 존재 하는지 Check
    //정상 = 'PostRestoreFile2MPMAsync_mORMot = 200' Return 됨
    //Error 발생 시 = 'PostRestoreFile2MPMAsync_mORMot = 0' Return 됨
    class function CheckIfValid4PostRestoreFileReturnHtml(AHtml: string): Boolean;
    class function GetHtmlAfterPostRestoreMPMAsync(AFormHandle: THandle; AIpAddr: string): string;
    //AHtml 내에 ARestoreFileName이 존재 하는지 Check
    class function CheckIfValid4AfterPostRestoreReturnHtml(AHtml, ARestoreFileName: string): Boolean;
    //MPM의 /tmp/*.tgz file을 /home에 복사함
    class function UpdatePostedFileFromHtmlMPMAsync(AFormHandle: THandle; AIpAddr, AHtml: string): string;
    //AHtml 내에 'System reboot will stop logic and io control!' 이 존재 하는지 Check
    class function CheckIfValid4UpdatePostedFileReturnHtml(AHtml: string): Boolean;
    //Restore 후에 Reboot 함
    class function Reboot4RestoreMPMAsync(AFormHandle: THandle; AIpAddr, AHtml: string): string;

    //AIpAddrList: ';'로 구분됨
    //ABakupFileName: 'MPM11P.tgz'
    class function AppUpMPM(AIpAddrList, ABakupFileName: string): string;
    //AIpAddr: IP 한개임
    class function AppUpMPMAsync(AIpAddr, ABakupFileName: string): string;

    //AIpAddrList: ';'로 구분됨
    class function CFCmd2MPM(AIpAddrList: string): string;
    //AIpAddr: IP 한개임
    class function CFCmd2MPMAsync(AIpAddr: string; ARec: THiConMPMWeb_CFInput): string;
    //AIpAddr: IP 한개임
    class function GetCF2HtmlFromMPM(AIpAddr: string): string;
    //AIsAttrValue: True = AHtml에서 Attribute Name = Value에서 값을 가져옴
    class function GetCFRecFromHtml(AHtml: string; AIsAttrValue: Boolean): THiConMPMWeb_CFInput;
    class function GetCFUrlFromIpAddr(AIpAddr: string): string;

    //AIpAddrList: ';'로 구분됨
    class function RebootMPM(AIpAddrList: string): string;
    //AIpAddr: IP 한개임
    class function RebootMPMAsync(AIpAddr: string): string;
  end;

implementation

uses UnitCopyData, pingsend, UnitHtmlUtil, UnitStringUtil, UnitLanUtil2,
  FrmHiConCFInput;

{ THiConMPMWeb }

class function THiConMPMWeb.AppUpMPM(AIpAddrList,
  ABakupFileName: string): string;
begin

end;

class function THiConMPMWeb.AppUpMPMAsync(AIpAddr,
  ABakupFileName: string): string;
begin

end;

class function THiConMPMWeb.BackupMPM(AIpAddrList: string): string;
var
  LIpAddr: string;
//  LProgress: IProgress;
begin
//  LProgress := ShowProgress('Downloading MPM...', False);
//  LProgress.EnableAbort := True;
//  LProgress.Marquee := True;
//
//  LProgress.UpdateMessage('Changing...');
//
//  while (not LProgress.Aborted) do
//  begin
    while AIpAddrList <> '' do
    begin
      LIpAddr := StrToken(AIpAddrList, ';');
      DownloadBackupMPMAsync(LIpAddr);
    end;//while
//  end;
end;

class function THiConMPMWeb.CFCmd2MPM(AIpAddrList: string): string;
var
  LIpAddr, LHtml: string;
  LRec: THiConMPMWeb_CFInput;
begin
  while AIpAddrList <> '' do
  begin
    LIpAddr := StrToken(AIpAddrList, ';');

    LHtml := THiConMPMWeb.GetCF2HtmlFromMPM(LIpAddr);
    LRec := THiConMPMWeb.GetCFRecFromHtml(LHtml, True);

    if CreateCFInputForm(LRec) = mrOk then
    begin
      CFCmd2MPMAsync(LIpAddr, LRec);
    end;
  end;//while
end;

class function THiConMPMWeb.CFCmd2MPMAsync(AIpAddr: string; ARec: THiConMPMWeb_CFInput): string;
var
  LResult, LFullUrl: string;
begin
  Parallel.Async(
    procedure (const task: IOmniTask)
    var
      LHttp: TIdHttp;
      Lurl, LQuery: string;
    begin
//      LMPMName := GetLocalNameFromMPM(AIpAddr);

//      if LMPMName = '' then
//        exit;

      LHttp := TIdHttp.Create(nil);
      try
        LUrl := 'http://' + AIpAddr + '/cf';
        LQuery := '%26=' + ARec.FLocalName + '&ip0=' + ARec.FEth0IP +
          '&nm0=' + ARec.FEth0NetMask + '&gw0=' + ARec.FEth0GateWay +
          '&ip1=' + ARec.FEth1IP + '&nm1=' + ARec.FEth1NetMask +
          '&gw1=' + ARec.FEth1GateWay + '&%26=Submit';
        LFullUrl := LUrl + '?' + LQuery;

        //http://10.8.1.254/cf?%26=MPM11P&ip0=10.8.1.254&nm0=255.255.0.0&gw0=10.8.1.1&ip1=11.8.1.11&nm1=255.255.0.0&gw1=11.8.1.1&%26=Submit
        LResult := LHttp.Get(LFullUrl);
      finally
        LHttp.Free;
      end;
    end,

    //Main thread에서 실행됨
    Parallel.TaskConfig.OnMessage(nil).OnTerminated(
      procedure (const ATask: IOmniTaskControl)
      begin
        TGPCopyData.Log2CopyData('MPM is configured!' + LFullUrl, 1, msgHandle4CopyData);
        TGPCopyData.Log2CopyData(LResult, 7, msgHandle4CopyData);
      end
    )
  );
end;

class function THiConMPMWeb.CheckIfValid4AfterPostRestoreReturnHtml(AHtml,
  ARestoreFileName: string): Boolean;
begin
  Result := Pos(ARestoreFileName, AHtml) > 0;
end;

class function THiConMPMWeb.CheckIfValid4PostRestoreFileReturnHtml(
  AHtml: string): Boolean;
begin
  Result := Pos('200', AHtml) > 0;
end;

class function THiConMPMWeb.CheckIfValid4UpdatePostedFileReturnHtml(
  AHtml: string): Boolean;
begin
  Result := Pos('System reboot will stop logic and io control!', AHtml) > 0;
end;

class function THiConMPMWeb.DownloadBackupMPMAsync(AIpAddr: string): string;
var
  LResult: string;
begin
  Parallel.Async(
    procedure (const task: IOmniTask)
    var
      LHttp: TIdHttp;
      Lurl, LQuery, LFullUrl, LBackupFileSufix, LFN: string;
      LStream: TMemoryStream;
    begin
      LHttp := TIdHttp.Create(nil);
      try
        LUrl := 'http://' + AIpAddr + '/Backup';
        LQuery := '&=Make%20Backup';
        LFullUrl := LUrl + '?' + LQuery;

        LFullUrl := LHttp.Get(LFullUrl);

        if Pos('Download Backup', LFullUrl) > 0  then
        begin
          LStream := TMemoryStream.Create;
          try
//            LUrl := 'http://' + AIpAddr + '/';
//            //IP 마지막 주소값을 가져옴
//            LBackupFileSufix := strTokenRev(AIpAddr, '.');
//            LFN := 'MPM' + LBackupFileSufix + '.tgz';
//            LQuery := '&=Download+Backup';
//            LFullUrl := LUrl + '/' + LFN;// + '?' + LQuery;

            LFullUrl := ExtractTextInsideGivenTagEx('pre', LFullUrl);
            LFullUrl := ExtractTextInsideGivenTagNth('tr', LFullUrl, 2);
            LFullUrl := ExtractTagAndTextInsideGivenTagEx('form', LFullUrl);
            LFN := GetAttrValueInHtmlTagByAttrName(LFullUrl, 'action', '"');
            LUrl := 'http://' + AIpAddr + '/' + LFN;
            LQuery := '&=Download%20Backup';
            LFullUrl := LUrl + '?' + LQuery;

            LHttp.Get(LFullUrl, LStream);
            LFN := 'c:\temp\' + LFN;
            LStream.SaveToFile(LFN);
            LResult := LFN;
          finally
            LStream.Free;
          end;
        end;
//          ShowMessage(Lurl);
      finally
        LHttp.Free;
      end;
    end,

    //Main thread에서 실행됨
    Parallel.TaskConfig.OnMessage(nil).OnTerminated(
      procedure (const ATask: IOmniTaskControl)
      begin
        TGPCopyData.Log2CopyData('Backup file is downloaded to ' + LResult, 1, msgHandle4CopyData);
      end
    )
  );
end;

class function THiConMPMWeb.GetCFRecFromHtml(AHtml: string; AIsAttrValue: Boolean): THiConMPMWeb_CFInput;
var
  LStr, LCfData: string;
begin
  AHtml := StringReplace(AHtml, #13#10, '', [rfReplaceAll]);
  LStr := ExtractTextInsideGivenTagEx('table', AHtml);

  LCfData := ExtractTextInsideGivenTagNth('td', LStr, 1);

  if LCfData = 'Local Name' then
  begin
    Result.FLocalName := ExtractTextInsideGivenTagNth('td', LStr, 2);

    if AIsAttrValue then
      Result.FLocalName := GetAttrValueInHtmlTagByAttrName(Result.FLocalName, 'value', '''');
  end;

  LCfData := ExtractTextInsideGivenTagNth('td', LStr, 3);

  if LCfData = 'Eth0. IP' then
  begin
    Result.FEth0IP := ExtractTextInsideGivenTagNth('td', LStr, 4);

    if AIsAttrValue then
      Result.FEth0IP := GetAttrValueInHtmlTagByAttrName(Result.FEth0IP, 'value', '''');
  end;

  LCfData := ExtractTextInsideGivenTagNth('td', LStr, 5);

  if LCfData = 'Eth0. Netmask' then
  begin
    Result.FEth0NetMask := ExtractTextInsideGivenTagNth('td', LStr, 6);

    if AIsAttrValue then
      Result.FEth0NetMask := GetAttrValueInHtmlTagByAttrName(Result.FEth0NetMask, 'value', '''');
  end;

  LCfData := ExtractTextInsideGivenTagNth('td', LStr, 7);

  if AIsAttrValue then
  begin
    if LCfData = 'Eth0. Gateway IP' then
    begin
      Result.FEth0GateWay := ExtractTextInsideGivenTagNth('td', LStr, 8);
      Result.FEth0GateWay := GetAttrValueInHtmlTagByAttrName(Result.FEth0GateWay, 'value', '''');
    end;
  end
  else
  begin
    if LCfData = 'Eth0. Gateway' then
    begin
      Result.FEth0GateWay := ExtractTextInsideGivenTagNth('td', LStr, 8);
    end;
  end;

  LCfData := ExtractTextInsideGivenTagNth('td', LStr, 9);

  if LCfData = 'Eth1. IP' then
  begin
    Result.FEth1IP := ExtractTextInsideGivenTagNth('td', LStr, 10);

    if AIsAttrValue then
      Result.FEth1IP := GetAttrValueInHtmlTagByAttrName(Result.FEth1IP, 'value', '''');
  end;

  LCfData := ExtractTextInsideGivenTagNth('td', LStr, 11);

  if LCfData = 'Eth1. Netmask' then
  begin
    Result.FEth1NetMask := ExtractTextInsideGivenTagNth('td', LStr, 12);

    if AIsAttrValue then
      Result.FEth1NetMask := GetAttrValueInHtmlTagByAttrName(Result.FEth1NetMask, 'value', '''');
  end;

  LCfData := ExtractTextInsideGivenTagNth('td', LStr, 13);

  if AIsAttrValue then
  begin
    if LCfData = 'Eth1. Gateway IP' then
    begin
      Result.FEth1GateWay := ExtractTextInsideGivenTagNth('td', LStr, 14);
      Result.FEth1GateWay := GetAttrValueInHtmlTagByAttrName(Result.FEth1GateWay, 'value', '''');
    end;
  end
  else
  begin
    if LCfData = 'Eth1. Gateway' then
    begin
      Result.FEth1GateWay := ExtractTextInsideGivenTagNth('td', LStr, 14);
    end;
  end;
end;

class function THiConMPMWeb.GetCF2HtmlFromMPM(AIpAddr: string): string;
var
  LCon: RawByteString;
  LUrl: string;
begin
  if PingHost(AIpAddr) = -1 then
  begin
    TGPCopyData.Log2CopyData('Host not connected : <' + AIpAddr + '>', 1, msgHandle4CopyData);
    exit;
  end;

  LUrl := GetCFUrlFromIpAddr(AIpAddr);

  LCon := HttpGet(LUrl, nil, False, nil, 5000);
  Result := LCon;
end;

class function THiConMPMWeb.GetCFUrlFromIpAddr(AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + '/cf';
end;

class function THiConMPMWeb.GetCommandFromMPM(AIpAddr: string): string;
var
  Lurl: string;
begin
  Result := '';

  if PingHost(AIpAddr) = -1 then
  begin
    TGPCopyData.Log2CopyData('Host not connected : <' + AIpAddr + '>', 1, msgHandle4CopyData);
    exit;
  end;

  LUrl := GetCommandUrlFromIpAddr(AIpAddr);

  Result := HttpGet(LUrl, nil, False, nil, 5000);
end;

class function THiConMPMWeb.GetCommandFromMPM_Async(AIpAddr: string): string;
var
  LCon: RawByteString;
begin
  Result := '';

  Parallel.Async(
    procedure (const task: IOmniTask)
    var
      Lurl, LQuery, LFullUrl: string;
    begin
      if AIpAddr = '127.0.0.1' then
        exit;

      if PingHost(AIpAddr) = -1 then
      begin
        TGPCopyData.Log2CopyData('Host not connected : <' + AIpAddr + '>', 1, msgHandle4CopyData);
        exit;
      end;

      LUrl := GetCommandUrlFromIpAddr(AIpAddr);

      LCon := HttpGet(LUrl, nil, False, nil, 5000);

      if LCon <> '' then
      begin
        LCon := GetCommandList2JsonAryFromHtml(AIpAddr, LCon);
      end;
    end,

    Parallel.TaskConfig.OnMessage(nil).OnTerminated(
      procedure
      begin
        if LCon <> '' then
        begin
          TGPCopyData.Log2CopyData(AIpAddr, 2, msgHandle4CopyData);
          TGPCopyData.Log2CopyData(LCon, 13, msgHandle4CopyData);
        end;
      end
    )
  );
end;

class function THiConMPMWeb.GetCommandList2JsonAryFromHtml(AIpAddr,
  AHtml: string): string;
var
  LList: IDocList;
  LDict: IDocDict;
  LStr, Ltr, Lli, LParent, Ltd: string;
  i, j: integer;
begin
  LList := DocList('[]');
  LDict := DocDict('{}');

  LStr := ExtractTextInsideGivenTagEx('table', AHtml);

  i := 1;

  Ltr := ExtractTextInsideGivenTagNth('tr', LStr, i);

  while Ltr <> '' do
  begin
    j := 1;

    if Odd(i) then
    begin
      //parent : DB Information/ACONIS-NX Information...
      LParent := ExtractTextInsideGivenTagEx('td', Ltr);
    end
    else
    begin
      Ltd := ExtractTextInsideGivenTagEx('td', Ltr);
      Ltd := StringReplace(Ltd, '</a>'#$D#$A'', '</a></li>', [rfReplaceAll]);
      Lli := ExtractTextInsideGivenTagNth('li', Ltd, j);

      while Lli <> '' do
      begin
        LDict.S['parent'] := ExtractTextInsideGivenTagEx('a', Lli);
        LDict.S['name'] := ExtractTextInsideGivenTagEx('a', Lli);
        LDict.S['url'] := GetAttrValueInHtmlTagByAttrName(Lli, 'href', '"');
        LDict.S['desc'] := LDict.S['name'];
        inc(j);
        Lli := ExtractTextInsideGivenTagNth('li', Ltd, j);
        LList.Append(LDict.Json);
        LDict.Clear();
      end;
    end;

    inc(i);
    Ltr := ExtractTextInsideGivenTagNth('tr', LStr, i);
  end;//while

  Result := LList.Json;
end;

class function THiConMPMWeb.GetCommandUrlFromIpAddr(AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + '/command';
end;

class function THiConMPMWeb.GetFBVerFromMPM(AIpAddr: string): string;
var
  LCon: RawByteString;
  LUrl: string;
begin
  if AIpAddr = '127.0.0.1' then
    exit;

  if PingHost(AIpAddr) = -1 then
  begin
    TGPCopyData.Log2CopyData('Host not connected : <' + AIpAddr + '>', 1, msgHandle4CopyData);
    exit;
  end;

  LUrl := GetFBVerUrlFromMPM(AIpAddr);

  LCon := HttpGet(LUrl, nil, False, nil, 5000);
  Result := LCon;
end;

class function THiConMPMWeb.GetFBVerFromMPM_Async(
  ARec: TIpListRec): integer;
var
  LIpAddr: string;
  LResult: string;
begin
  Parallel.Async(
    procedure (const task: IOmniTask)
    begin
      if ARec.PMPM_PIP = '127.0.0.1' then
        exit;

      LIpAddr := ARec.PMPM_PIP;
      LResult := GetFBVerFromMPM(LIpAddr);

      if LResult <> '' then
      begin
        LResult := GetFBVerList2JsonAryFromHtml(LIpAddr, LResult);
      end;
    end,

    Parallel.TaskConfig.OnMessage(nil).OnTerminated(
      procedure
      begin
        if LResult <> '' then
        begin
          TGPCopyData.Log2CopyData(LIpAddr, 2, msgHandle4CopyData);
          TGPCopyData.Log2CopyData(LResult, 12, msgHandle4CopyData);
        end;
      end
    )
  );
end;

class function THiConMPMWeb.GetFBVerList2JsonAryFromHtml(AIpAddr,
  AHtml: string): string;
var
  LStr, LIdx, LFN, LFBName, LVer: string;
  LRow, i: integer;
//  LList, LList2: IDocList;
  Lvar, LVar2: variant;
  LUtf8: RawUtf8;
begin
  AHtml := StringReplace(AHtml, #13#10, '', [rfReplaceAll]);
  LStr := ExtractTextInsideGivenTagEx('table', AHtml);
  LStr := ExtractTextInsideGivenTagEx('script', LStr);
  AHtml := StrToken(LStr, '=');
  Result := StrToken(LStr, ';');
end;

class function THiConMPMWeb.GetFBVerUrlFromMPM(AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + '/fbver';
end;

class function THiConMPMWeb.GetHeaderFromMPM(AIpAddr: string): string;
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

class function THiConMPMWeb.GetHeaderFromMPM_Async(AIpAddr: string): string;
var
  LResult: string;
begin
  Result := '';

  Parallel.Async(
    procedure (const task: IOmniTask)
    begin
      LResult := GetHeaderFromMPM(AIpAddr);
    end,

    Parallel.TaskConfig.OnMessage(nil).OnTerminated(
      procedure
      begin
        if LResult <> '' then
        begin
          TGPCopyData.Log2CopyData(AIpAddr, 2, msgHandle4CopyData);
          TGPCopyData.Log2CopyData(LResult, 6, msgHandle4CopyData);
        end;
      end
    )
  );
end;

class function THiConMPMWeb.GetHeaderUrlFromIpAddr(AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + '/header';
end;

class function THiConMPMWeb.GetHtmlAfterPostRestoreMPMAsync(AFormHandle: THandle;
  AIpAddr: string): string;
var
  LCon: RawByteString;
//  LIpAddr: string;
begin
  Result := '';

  Parallel.Async(
    procedure (const task: IOmniTask)
    var
      Lurl, LQuery, LFullUrl: string;
    begin
      if PingHost(AIpAddr) = -1 then
      begin
        TGPCopyData.Log2CopyData('Host not connected : <' + AIpAddr + '>', 1, AFormHandle);
        exit;
      end;

      LUrl := GetRestoreUrlFromIpAddr(AIpAddr);

      LCon := HttpGet(LUrl, nil, False, nil, 5000);
    end,

    Parallel.TaskConfig.OnMessage(nil).OnTerminated(
      procedure
      begin
        if LCon <> '' then
        begin
          TGPCopyData.Log2CopyData(LCon, 1, AFormHandle);
          //THiConMPMRestoreF Form에서 THiConMPMWeb.UpdatePostedFileFromHtmlMPMAsync() 함수 호출함
          TGPCopyData.Log2CopyData(LCon, 3, AFormHandle);
        end;
      end
    )
  );
end;

class function THiConMPMWeb.GetLMPMFromMPM(AIpAddr: string): string;
var
  LCon: RawByteString;
  LUrl: string;
begin
  if PingHost(AIpAddr) = -1 then
  begin
    TGPCopyData.Log2CopyData('Host not connected : <' + AIpAddr + '>', 1, msgHandle4CopyData);
    exit;
  end;

  LUrl := GetLMPMUrlFromIpRec(AIpAddr);

  LCon := HttpGet(LUrl, nil, False, nil, 5000);
  Result := LCon;
end;

class function THiConMPMWeb.GetLMPMFromMPM_Async(ARec: TIpListRec): integer;
var
  LIpAddr: string;
  LResult: string;
begin
  Parallel.Async(
    procedure (const task: IOmniTask)
    begin
      if ARec.PMPM_PIP = '127.0.0.1' then
        exit;

      LIpAddr := ARec.PMPM_PIP;
      LResult := GetLMPMFromMPM(LIpAddr);
    end,

    Parallel.TaskConfig.OnMessage(nil).OnTerminated(
      procedure
      begin
        if LResult <> '' then
        begin
          TGPCopyData.Log2CopyData(LIpAddr, 2, msgHandle4CopyData);
          TGPCopyData.Log2CopyData(LResult, 5, msgHandle4CopyData);
        end;
      end
    )
  );
end;

class function THiConMPMWeb.GetLMPMList2JsonAryFromHtml(AIpAddr, AHtml,
  AHirsVersion: string): string;
var
  LHirsVer: UInt32;
begin
  Result := '';

  if AHirsVersion = '' then
    AHirsVersion := HIRS_VER_LATEAST;

  AHirsVersion := StrToken(AHirsVersion, '#');
  LHirsVer := IPAddr2Long(AHirsVersion);

  if LHirsVer < HIRS_VER_V1 then
    Result := GetLMPMList2JsonAryFromHtmlByHirsV1(AIpAddr, AHtml)
  else
  if (AHirsVersion = '') or (LHirsVer < HIRS_VER_V2) then
    Result := GetLMPMList2JsonAryFromHtmlByHirsV2(AIpAddr, AHtml)
end;

class function THiConMPMWeb.GetLMPMList2JsonAryFromHtmlByHirsV1(AIpAddr,
  AHtml: string): string;
var
  LStr, LTotalCountStr, LTable, LIOCard, LDelim: string;//LScript,
  i, LTotalCount: integer;
begin
  AHtml := StringReplace(AHtml, #13#10, '', [rfReplaceAll]);
  LStr := ExtractTextInsideGivenTagEx('pre', AHtml);

  if Pos('Total RTU No =', LStr) > 0 then
  begin
    LTotalCountStr := StrToken(LStr, '=');
    LTotalCountStr := StrToken(LStr, '<');

    if not StrIsNumeric(LTotalCountStr) then
    begin
      ShowMessage('Please check "Total RTU No"');
      exit;
    end;
  end;
end;

class function THiConMPMWeb.GetLMPMList2JsonAryFromHtmlByHirsV2(AIpAddr,
  AHtml: string): string;
var
  LMPMListDic: IKeyValue<string, string>;
begin
  LMPMListDic := GetLMPMListFromHtmlByHirsV2(AIpAddr, AHtml);
  Result := LMPMListDic.Data.SaveToJson();
end;

class function THiConMPMWeb.GetLMPMListFromHtmlByHirsV2(AIpAddr,
  AHtml: string): IKeyValue<string, string>;
var
  LStr, LTotalCountStr, LTable, LIOCard, LDelim: string;//LScript,
  i, LTotalCount: integer;
begin
  AHtml := StringReplace(AHtml, #13#10, '', [rfReplaceAll]);
  LStr := ExtractTextInsideGivenTagEx('pre', AHtml);

  if Pos('Total RTU No =', LStr) > 0 then
  begin
    LTotalCountStr := ExtractTextBetweenDelim(LStr, 'Total RTU No =', #10);
    LTotalCountStr := StrToken(LTotalCountStr, #10);

    if not StrIsNumeric(LTotalCountStr) then
    begin
      ShowMessage('Please check "Total RTU No"');
      exit;
    end;
  end;

  LTotalCount := StrToIntDef(LTotalCountStr, 0);
  Result := Collections.NewKeyValue<string, string>;

  if LTotalCount = 0 then
    LTotalCount := GetTagCountFromHtml('</table>', LStr);

  //"4. "을 검색하면 "14. "이 검색되는 문제 회피를 위해 downto로 수정함
  for i := LTotalCount downto 1 do
  begin
    LDelim := IntToStr(i) + '. ';
    //"1. AI (16) : 100 mSec" 가져옴
    LIOCard := ExtractTextBetweenDelim(LStr, LDelim, '<');

    if LIOCard = '' then
    begin
      Continue;
    end
    else
      LStr := ReplaceString(LStr, LDelim + LIOCard, '');

    LIOCard := LDelim + LIOCard;

    //LTotalCount 중에 없는 숫자가 존재하므로 일부 오류 발생하여 ExtractTextBetweenDelim()로 변경함
//    LTable := ExtractTextInsideGivenTagNth('table', LStr, i);
//    LScript := ExtractTextInsideGivenTagNth('script', LTable, 1);

    LDelim := 'ta' + IntToStr(i) + ' = ';
    LTable := ExtractTextBetweenDelim(LStr, LDelim, ';');
//    LTable := StrToken(LScript, '=');
//    LTable := StrToken(LScript, ';');

    Result.Add(LIOCard, LTable);
//    if i = 1 then
//      SetLMPMFromMPMList2GridByKey(AIpAddr, LIOCard);
  end;//for
end;

class function THiConMPMWeb.GetLMPMUrlFromIpRec(AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + '/lmpm';
end;

class function THiConMPMWeb.GetLocalNameFromMPM(AIpAddr: string): string;
begin
  Result := GetHeaderFromMPM(AIpAddr);

  if Result <> '' then
  begin
    Result := GetNameNHeader2ClassRecFromHtml(AIpAddr, Result);
  end;
end;

class function THiConMPMWeb.GetLResFromMPM_Async(ARec: TIpListRec): string;
var
  LCon: RawByteString;
  LIpAddr: string;
begin
  Result := '';

  Parallel.Async(
    procedure (const task: IOmniTask)
    var
      Lurl, LQuery, LFullUrl: string;
    begin
      if ARec.PMPM_PIP = '127.0.0.1' then
        exit;

      LIpAddr := ARec.PMPM_PIP;

      if PingHost(LIpAddr) = -1 then
      begin
        TGPCopyData.Log2CopyData('Host not connected : <' + LIpAddr + '>', 1, msgHandle4CopyData);
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
          TGPCopyData.Log2CopyData(LIpAddr, 2, msgHandle4CopyData);
          TGPCopyData.Log2CopyData(LCon, 3, msgHandle4CopyData);
        end;
      end
    )
  );
end;

class function THiConMPMWeb.GetLResRecList2JsonAryFromHtml(
  AIpAddr, AHtml, AHirsVersion: string): string;
var
  LHirsVer: UInt32;
begin
  Result := '';

  if AHirsVersion = '' then
    AHirsVersion := HIRS_VER_LATEAST;

  AHirsVersion := StrToken(AHirsVersion, '#');
  LHirsVer := IPAddr2Long(AHirsVersion);

  if LHirsVer < HIRS_VER_V1 then
    Result := GetLResRecList2JsonAryFromHtmlByHirsV1(AIpAddr, AHtml)
  else
  if (AHirsVersion = '') or (LHirsVer < HIRS_VER_V2) then
    Result := GetLResRecList2JsonAryFromHtmlByHirsV2(AIpAddr, AHtml)
end;

class function THiConMPMWeb.GetLResRecList2JsonAryFromHtmlByHirsV1(AIpAddr,
  AHtml: string): string;
begin
end;

class function THiConMPMWeb.GetLResRecList2JsonAryFromHtmlByHirsV2(AIpAddr,
  AHtml: string): string;
var
  LJsonAry, LStr, LData, LTotalCountStr,
  LIndex,	LPrimary,	LSecondary,	LMaster,	LTime: string;
  i, LCount: integer;
  LDocList, LDocList2: IDocList;
begin
  Result := '';

  LStr := ExtractTextInsideGivenTagEx('pre', AHtml);

  if Pos('Total Resource No. =', LStr) > 0 then
  begin
    LTotalCountStr := ExtractTextBetweenDelim(LStr, 'Total Resource No. =', #10);
    LTotalCountStr := StrToken(LTotalCountStr, #10);
  end;

  LCount := StrToIntDef(LTotalCountStr, 0);

  if LCount > 0 then
  begin
    LDocList := DocList('[]');
    LDocList2 := DocList('[]');
  end
  else
    exit;

  LDocList.Append('IPAddr');

  LData := ExtractTextInsideGivenTagNth('tr', LStr, 1);
  LTotalCountStr := ExtractTextInsideGivenTagNth('td', LData, 1);
  LDocList.Append(LTotalCountStr);//LIndex;
  LTotalCountStr := ExtractTextInsideGivenTagNth('td', LData, 2);
  LDocList.Append(LTotalCountStr);//LPrimary;
  LTotalCountStr := ExtractTextInsideGivenTagNth('td', LData, 3);
  LDocList.Append(LTotalCountStr);//LSecondary;
  LTotalCountStr := ExtractTextInsideGivenTagNth('td', LData, 4);
  LDocList.Append(LTotalCountStr);//LMaster;
  LTotalCountStr := ExtractTextInsideGivenTagNth('td', LData, 5);
  LDocList.Append(LTotalCountStr);//LTime;

  LDocList2.AppendDoc(LDocList);
  LDocList.Clear;

  for i := 1 to LCount do
  begin
    LData := ExtractTextInsideGivenTagNth('tr', LStr, 3+i);
    LIndex := ExtractTextInsideGivenTagNth('td', LData, 1);

    if Trim(LIndex) = '' then
      Continue;

    LPrimary := Trim(ExtractTextInsideGivenTagNth('td', LData, 2));
    LPrimary := Trim(ExtractTextInsideGivenTagNth('a', LPrimary, 1));
    LSecondary := Trim(ExtractTextInsideGivenTagNth('td', LData, 3));
    LSecondary := Trim(ExtractTextInsideGivenTagNth('a', LSecondary, 1));
    LMaster := Trim(ExtractTextInsideGivenTagNth('td', LData, 4));
    LTime := Trim(ExtractTextInsideGivenTagNth('td', LData, 5));

    LDocList.Append(AIpAddr);
    LDocList.Append(LIndex);
    LDocList.Append(LPrimary);
    LDocList.Append(LSecondary);
    LDocList.Append(LMaster);
    LDocList.Append(LTime);

    LDocList2.AppendDoc(LDocList);
    LDocList.Clear;
  end;

  Result := Utf8ToString(LDocList2.Json);
end;

class function THiConMPMWeb.GetLResUrlFromIpRec(AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + '/lres';
end;

class function THiConMPMWeb.GetLVerFromMPM(AIpAddr: string): string;
var
  LCon: RawByteString;
  LUrl: string;
begin
  if PingHost(AIpAddr) = -1 then
  begin
    TGPCopyData.Log2CopyData('Host not connected : <' + AIpAddr + '>', 1, msgHandle4CopyData);
    exit;
  end;

  LUrl := GetLVerUrlFromIpRec(AIpAddr);

  LCon := HttpGet(LUrl, nil, False, nil, 5000);
  Result := LCon;
end;

class function THiConMPMWeb.GetLVerFromMPM_Async(ARec: TIpListRec): integer;
var
  LIpAddr: string;
  LResult: string;
begin
  Parallel.Async(
    procedure (const task: IOmniTask)
    begin
      if ARec.PMPM_PIP = '127.0.0.1' then
        exit;

      LIpAddr := ARec.PMPM_PIP;
      LResult := GetLVerFromMPM(LIpAddr);
    end,

    Parallel.TaskConfig.OnMessage(nil).OnTerminated(
      procedure
      begin
        if LResult <> '' then
        begin
          TGPCopyData.Log2CopyData(LIpAddr, 2, msgHandle4CopyData);
          TGPCopyData.Log2CopyData(LResult, 4, msgHandle4CopyData);
        end;
      end
    )
  );
end;

class procedure THiConMPMWeb.GetLVerListFromHtml(AHtml: string; out ADesc,
  AHirsVer, ALogicVer: string);
var
  LStr, LLogic, LHirs: string;
  LRow, i: integer;
begin
  AHtml := StringReplace(AHtml, #13#10, '', [rfReplaceAll]);
  LStr := ExtractTextInsideGivenTagEx('pre', AHtml);
  LHirs := ExtractTextInsideGivenTagNth('table', LStr, 1);
  LLogic := ExtractTextInsideGivenTagNth('table', LStr, 5);

//  LStr := ExtractTextInsideGivenTagEx('pre', LHirs);
  LStr := ExtractTextBetweenDelim(LHirs, 'Ver', 'Copyright');
  LStr := StringReplace(LStr, #13#10, '', [rfReplaceAll]);

  AHirsVer := Trim(LStr);
  ADesc := ExtractTextInsideGivenTagNth('td', LLogic, 1);
  ALogicVer := ExtractTextInsideGivenTagNth('td', LLogic, 2);
end;

class function THiConMPMWeb.GetLVerUrlFromIpRec(AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + '/lver';
end;

class function THiConMPMWeb.GetMPMNameFromHtml(AHtml: string): string;
begin

end;

class function THiConMPMWeb.GetNameNHeader2ClassRecFromHtml(
  AIpAddr, AHtml: string): string;
var
  LStr, LHeader: string;
begin
  AHtml := StringReplace(AHtml, #13#10, '', [rfReplaceAll]);
  LStr := ExtractTextInsideGivenTagEx('table', AHtml);
  LHeader := ExtractTextInsideGivenTagNth('td', LStr, 1); //MPM11P (Index:127) MPM :

  FMPMWebHeader.FName := Trim(StrToken(LHeader, '('));
  StrToken(LHeader, ':');
  FMPMWebHeader.FIndex := Trim(StrToken(LHeader, ')'));

  FMPMWebHeader.FMPM := ExtractTextInsideGivenTagNth('td', LStr, 2); //Master
//  LHirs := ExtractTextInsideGivenTagNth('td', LStr, 3); //RTU :
  FMPMWebHeader.FRTU := ExtractTextInsideGivenTagNth('td', LStr, 4); //Master
  Result := FMPMWebHeader.FName;
end;

class function THiConMPMWeb.GetRestoreUrlFromIpAddr(AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + '/Restore';
end;

class function THiConMPMWeb.GetRetainMapFromMPM(AIpAddr: string): string;
var
  LCon: RawByteString;
  LUrl: string;
begin
  if AIpAddr = '127.0.0.1' then
    exit;

  if PingHost(AIpAddr) = -1 then
  begin
    TGPCopyData.Log2CopyData('Host not connected : <' + AIpAddr + '>', 1, msgHandle4CopyData);
    exit;
  end;

  LUrl := GetRetainMapUrlFromMPM(AIpAddr);

  LCon := HttpGet(LUrl, nil, False, nil, 5000);
  Result := LCon;
end;

class function THiConMPMWeb.GetRetainMapFromMPM_Async(
  ARec: TIpListRec): integer;
begin

end;

class function THiConMPMWeb.GetRetainMapList2JsonAryFromHtml(AIpAddr,
  AHtml: string): string;
var
  LStr, LIdx, LFN, LFBName, LVer: string;
  LRow, i: integer;
  Lvar, LVar2: variant;
  LUtf8: RawUtf8;
begin
  AHtml := StringReplace(AHtml, #13#10, '', [rfReplaceAll]);
  LStr := ExtractTextInsideGivenTagEx('table', AHtml);
  LStr := ExtractTextInsideGivenTagEx('script', LStr);
  AHtml := StrToken(LStr, '=');
  Result := StrToken(LStr, ';');
end;

class function THiConMPMWeb.GetRetainMapUrlFromMPM(AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + '/retainmap';
end;

class function THiConMPMWeb.GetVersionIntfUrlFromIpRec(AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + ':8000/version';
end;

class function THiConMPMWeb.GetVersionList2JsonAryFromHtml(AIpAddr,
  AHtml: string): string;
var
  LList: IDocList;
  LDoc: TDocVariantData;
  LStr, Ltr, Ltd: string;
  i, j: integer;
begin
  LList := DocList('[]');
  LDoc.InitArray([], mFast); //Json 배열 초기화
  LStr := ExtractTextInsideGivenTagEx('pre', AHtml);
  LStr := ExtractTextInsideGivenTagEx('table', LStr);

  i := 1;

  Ltr := ExtractTextInsideGivenTagNth('tr', LStr, i);

  while Ltr <> '' do
  begin
    j := 1;
    Ltd := ExtractTextInsideGivenTagNth('td', Ltr, j);

    while Ltd <> '' do
    begin
      LDoc.AddItemText(Ltd);
      inc(j);
      Ltd := ExtractTextInsideGivenTagNth('td', Ltr, j);
    end;

    LList.Append(LDoc.ToJson);
    LDoc.Clear();
    inc(i);
    Ltr := ExtractTextInsideGivenTagNth('tr', LStr, i);
  end;//while

  Result := LList.Json;
end;

class function THiConMPMWeb.GetVersionFromMPM(AIpAddr: string): string;
var
  LCon: RawByteString;
  LUrl: string;
begin
  if AIpAddr = '127.0.0.1' then
    exit;

  if PingHost(AIpAddr) = -1 then
  begin
    TGPCopyData.Log2CopyData('Host not connected : <' + AIpAddr + '>', 1, msgHandle4CopyData);
    exit;
  end;

  LUrl := GetVersionUrlFromMPM(AIpAddr);

  LCon := HttpGet(LUrl, nil, False, nil, 5000);
  Result := LCon;
end;

class function THiConMPMWeb.GetVersionFromMPM_Async(ARec: TIpListRec): integer;
var
  LIpAddr: string;
  LResult: string;
begin
  Parallel.Async(
    procedure (const task: IOmniTask)
    begin
      if ARec.PMPM_PIP = '127.0.0.1' then
        exit;

      LIpAddr := ARec.PMPM_PIP;
      LResult := GetVersionFromMPM(LIpAddr);
    end,

    Parallel.TaskConfig.OnMessage(nil).OnTerminated(
      procedure
      begin
        if LResult <> '' then
        begin
          TGPCopyData.Log2CopyData(LIpAddr, 2, msgHandle4CopyData);
          TGPCopyData.Log2CopyData(LResult, 11, msgHandle4CopyData);
        end;
      end
    )
  );
end;

class function THiConMPMWeb.GetVersionUrlFromMPM(AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + '/version';
end;

class function THiConMPMWeb.Reboot4RestoreMPMAsync(AFormHandle: THandle;
  AIpAddr, AHtml: string): string;
var
  LResult: string;
begin
  Parallel.Async(
    procedure (const task: IOmniTask)
    var
      LHttp: TIdHttp;
      Lurl, LFullUrl, LFN: string;
    begin
      LFullUrl := ExtractTextInsideGivenTagEx('pre', AHtml);
      LFullUrl := ExtractTagAndTextInsideGivenTagNth('form', LFullUrl, 2);
      LFN := GetAttrValueInHtmlTagByAttrName(LFullUrl, 'action', '"');
      LUrl := 'http://' + AIpAddr + '/' + LFN;
      LFullUrl := LUrl + '?' + '&=Restore ?';

      LHttp := TIdHttp.Create(nil);
      try
        LResult := LHttp.Get(LFullUrl);
      finally
        LHttp.Free;
      end;
    end,

    //Main thread에서 실행됨
    Parallel.TaskConfig.OnMessage(nil).OnTerminated(
      procedure (const ATask: IOmniTaskControl)
      begin
        TGPCopyData.Log2CopyData('Rebooted! ' + LResult, 1, AFormHandle);
      end
    )
  );
end;

class function THiConMPMWeb.RebootMPM(AIpAddrList: string): string;
var
  LIpAddr: string;
begin
  while AIpAddrList <> '' do
  begin
    LIpAddr := StrToken(AIpAddrList, ';');
    RebootMPMAsync(LIpAddr);
  end;//while
end;

class function THiConMPMWeb.RebootMPMAsync(AIpAddr: string): string;
var
  LResult, LFullUrl: string;
begin
  Parallel.Async(
    procedure (const task: IOmniTask)
    var
      LHttp: TIdHttp;
      Lurl, LQuery, LFullUrl: string;
    begin
      LHttp := TIdHttp.Create(nil);
      try
        LUrl := 'http://' + AIpAddr + '/reboot';
        LQuery := '&=ReBoot';
        LFullUrl := LUrl + '?' + LQuery;

        // http://10.8.1.254/reboot?&=ReBoot
        LResult := LHttp.Get(LFullUrl);
//        LResult := LResult + ' ===> ' + LFullUrl;
      finally
        LHttp.Free;
      end;
    end,

    //Main thread에서 실행됨
    Parallel.TaskConfig.OnMessage(nil).OnTerminated(
      procedure (const ATask: IOmniTaskControl)
      begin
        TGPCopyData.Log2CopyData('MPM is rebooted!' + LFullUrl, 1, msgHandle4CopyData);
      end
    )
  );
end;

class function THiConMPMWeb.RestoreMPM(AFormHandle: THandle;
  AIpAddrList, ABakupFileName: string): string;
var
  LIpAddr: string;
begin
  while AIpAddrList <> '' do
  begin
    LIpAddr := StrToken(AIpAddrList, ';');
    PostRestoreFile2MPMAsync_mORMot(AFormHandle, LIpAddr, ABakupFileName);
  end;//while
end;

class function THiConMPMWeb.RestoreMPMAsync_Indy(AIpAddr,
  ABakupFileName: string): string;
var
  LResult: string;
begin
  Parallel.Async(
    procedure (const task: IOmniTask)
    var
      LHttp: TIdHttp;
      Lurl, LQuery, LFullUrl, LBackupFileSufix, LFN: string;
      LStream: TMemoryStream;
    begin
      LHttp := TIdHttp.Create(nil);
      try
//        LUrl := 'http://' + AIpAddr + '/Restore';
//        LFullUrl := LUrl + '?' + LQuery;
//
//        LFullUrl := LHttp.Get(LFullUrl);
//
//        if Pos('Download Backup', LFullUrl) > 0  then
//        begin
//          LStream := TMemoryStream.Create;
//          try
//            LUrl := 'http://' + AIpAddr + '/';
//            //IP 마지막 주소값을 가져옴
//            LBackupFileSufix := strTokenRev(AIpAddr, '.');
//            LFN := 'MPM' + LBackupFileSufix + '.tgz';
//            LQuery := '&=Download+Backup';
//            LFullUrl := LUrl + '/' + LFN;// + '?' + LQuery;
//
//            LHttp.Get(LFullUrl, LStream);
//            LFN := 'c:\temp\' + LFN;
//            LStream.SaveToFile(LFN);
//            LResult := LFN;
//          finally
//            LStream.Free;
//          end;
//        end;
      finally
        LHttp.Free;
      end;
    end,

    //Main thread에서 실행됨
    Parallel.TaskConfig.OnMessage(nil).OnTerminated(
      procedure (const ATask: IOmniTaskControl)
      begin
        TGPCopyData.Log2CopyData('Backup file is downloaded to ' + LResult, 1, msgHandle4CopyData);
      end
    )
  );
end;

class function THiConMPMWeb.UpdatePostedFileFromHtmlMPMAsync(
  AFormHandle: THandle; AIpAddr, AHtml: string): string;
var
  LResult: string;
begin
  Parallel.Async(
    procedure (const task: IOmniTask)
    var
      LHttp: TIdHttp;
      Lurl, LFullUrl, LFN: string;
    begin
      LFullUrl := ExtractTextInsideGivenTagEx('table', AHtml);
      LFullUrl := ExtractTextInsideGivenTagNth('tr', LFullUrl, 2);
      LFullUrl := ExtractTagAndTextInsideGivenTagEx('form', LFullUrl);
      LFN := GetAttrValueInHtmlTagByAttrName(LFullUrl, 'action', '"');
      LUrl := 'http://' + AIpAddr + '/' + LFN;
      LFullUrl := LUrl + '?' + '&=Restore ?';

      LHttp := TIdHttp.Create(nil);
      try
        LResult := LHttp.Get(LFullUrl);
      finally
        LHttp.Free;
      end;
    end,

    //Main thread에서 실행됨
    Parallel.TaskConfig.OnMessage(nil).OnTerminated(
      procedure (const ATask: IOmniTaskControl)
      begin
        TGPCopyData.Log2CopyData('Restore is successful! ' + LResult, 1, AFormHandle);
        TGPCopyData.Log2CopyData(LResult, 4, AFormHandle);
      end
    )
  );
end;

class function THiConMPMWeb.PostRestoreFile2MPMAsync_mORMot(AFormHandle: THandle;
  AIpAddr, ABakupFileName: string): string;
var
  LResult: integer;
begin
  Parallel.Async(
    procedure (const task: IOmniTask)
    var
      LHttp: THttpClientSocket;
      LMultiPart: THttpMultiPartStream;
      Lurl: string;
      LContent: RawByteString;
    begin
      if not FileExists(ABakupFileName) then
        exit;

      LContent := StringFromFile(ABakupFileName);

      LMultiPart := THttpMultiPartStream.Create();
      try
//        LUrl := 'http://' + AIpAddr;

        LMultiPart.AddFileContent('dir=/tmp', ABakupFileName, LContent, 'application/x-compressed', 'binary');
        LMultiPart.Flush();

        LHttp := THttpClientSocket.Open(AIpAddr, '');//, nlTcp, 5000, False);
        try
          LResult := LHttp.Post('/Restore', LMultiPart, LMultiPart.MultipartContentType);
        finally
          LHttp.Free();
        end;
      finally
        LMultiPart.Free;
      end;
    end,

    //Main thread에서 실행됨
    Parallel.TaskConfig.OnMessage(nil).OnTerminated(
      procedure (const ATask: IOmniTaskControl)
      begin
        TGPCopyData.Log2CopyData('PostRestoreFile2MPMAsync_mORMot = ' + IntToStr(LResult), 1, AFormHandle);
        //THiConMPMRestoreF Form에서 THiConMPMWeb.GetHtmlAfterPostRestoreMPMAsync() 호출함
        TGPCopyData.Log2CopyData('PostRestoreFile2MPMAsync_mORMot = ' + IntToStr(LResult), 2, AFormHandle);
      end
    )
  );
end;

end.
