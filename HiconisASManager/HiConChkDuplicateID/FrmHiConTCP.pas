unit FrmHiConTCP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RegularExpressions, Vcl.Menus,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, NxScrollControl,
  NxCustomGridControl, NxCustomGrid, NxGrid, NxColumnClasses, NxColumns,
  AdvOfficeTabSet,

  OtlCommon, OtlComm, OtlTaskControl, OtlContainerObserver, otlTask, OtlParallel,
  OtlSync,
  mormot.core.base, mormot.core.os, mormot.core.text,
  mormot.core.collections, mormot.core.variants, mormot.core.json,
  mormot.net.client, mormot.core.unicode, mormot.net.server,

  PngBitBtn, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdIOHandler,
  IdGlobal, IdHTTP, UnitTaskDialogMB,
  UnitChkDupIdData, HtmlParser, UnitTRegExUtil, UnitHtmlUtil, Kit
  ;

type
  TIDList = IList<TDupIDListRec>;
  TIDDic = IKeyValue<string, TIDListRec>;

  THiconisTCPF = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    ConsoleMemo: TMemo;
    Splitter1: TSplitter;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Close1: TMenuItem;
    N1: TMenuItem;
    SaveIPListToFile1: TMenuItem;
    SaveDialog1: TSaveDialog;
    LoadIPListFromFile1: TMenuItem;
    OpenDialog1: TOpenDialog;
    PngBitBtn1: TPngBitBtn;
    PngBitBtn2: TPngBitBtn;
    Splitter2: TSplitter;
    Panel3: TPanel;
    Panel4: TPanel;
    IPAddrGrid: TNextGrid;
    RES_NAME: TNxTextColumn;
    PMPM_PIP: TNxTextColumn;
    PMPM_SIP: TNxTextColumn;
    Port: TNxTextColumn;
    BitBtn4: TBitBtn;
    Panel5: TPanel;
    TaskTab: TAdvOfficeTabSet;
    TagAddrGrid: TNextGrid;
    NxIncrementColumn1: TNxIncrementColumn;
    MMAddress: TNxTextColumn;
    TagId: TNxTextColumn;
    IPGridPopup: TPopupMenu;
    CheckDuplicatedID1: TMenuItem;
    GetPortPrint1: TMenuItem;
    IdTCPClient1: TIdTCPClient;
    CheckDuplicatedIDFromAll1: TMenuItem;
    N2: TMenuItem;
    MPMBackup1: TMenuItem;
    BitBtn1: TBitBtn;
    MPMName: TNxTextColumn;
    LoadDupIdCheckResultFile1: TMenuItem;
    N3: TMenuItem;
    ShowProgress1: TMenuItem;
    Kit1: TKit;
    CheckConnection1: TMenuItem;
    BitBtn3: TBitBtn;
    N4: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn4Click(Sender: TObject);
    procedure SaveIPListToFile1Click(Sender: TObject);
    procedure LoadIPListFromFile1Click(Sender: TObject);
    procedure TaskTabChange(Sender: TObject);
    procedure PngBitBtn1Click(Sender: TObject);
    procedure PngBitBtn2Click(Sender: TObject);
//    procedure IPAddrGridSelectCell(Sender: TObject; ACol, ARow: Integer);
    procedure GetPortPrint1Click(Sender: TObject);
    procedure CheckDuplicatedID1Click(Sender: TObject);
    procedure MPMBackup1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure LoadDupIdCheckResultFile1Click(Sender: TObject);
    procedure ShowProgress1Click(Sender: TObject);
    procedure CheckConnection1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    //Key: IPName
    FIpAddrDic: IKeyValue<string, TIpListRec>;
    //Key: IPName
    FIDListDic: IKeyValue<string, TStringList>;
    //Key: MM Address
//    FAddrIdListDic: IKeyValue<string, TIDListRec>;
    //MM Address
//    FDupIdList: IList<TDupIDListRec>;
    //Key: IP Address
    FIpNDupIdList: IKeyValue<string, TIDList>;
    //Key: IP Address, TIDDic Key: MM Address
    FIpNIdList: IKeyValue<string, TIDDic>;

    FTCPResponse: TStringList;

    FCancelToken: IOmniCancellationToken;
    FWorker  : IOmniParallelLoop<integer>;
    FIpList,
    FMPMBackupResultList: TStringList;

    procedure SetIdList2GridByTagText(AIpAddr: string; ATagText: string);
    procedure SaveIpListToFile(AFileName: string);
    procedure LoadIpListFromFile(AFileName: string);
    procedure SetIdList2Grid(AIpAddr: string);
    procedure SetIdList2GridFromIpNIdList(AIpAddr: string);
    procedure SetIdList2GridFromIpNDupIdList(AIpAddr: string);

    function GetSelectedIpAddrList(AIsMaster: Boolean=true): string;
    //AIpAddrList: ';'로 구분됨
    function BackupMPM(AIpAddrList: string): string;
    //AIpAddr: IP 한개임
    function DownloadBackupMPMAsync(AIpAddr: string): string;
    //AIpList: ';'로 구분됨
    function DownloadBackupMPMForEach(AIpList: string): string;
    function GetMPMNameFromIpAddrDic(AIpAddr: string): string;

  public
    function GetIdFromMPM(ARec: TIpListRec): integer;
    procedure GetIdFromMPM_Async(ARec: TIpListRec);
    procedure GetIdsFromIpListDic;
    procedure GetIdsFromIpSelected;
    procedure HtmlParseFunc();
    procedure GetPreTagTextFromHtml();

    function GetFileNameFromIpAddr(AIpAddr: string): string;
    function GetUrlFromIpRec(AIpAddr: string): string;
    function GetIpListRecByIp(AIpAddr: string): TIpListRec;
    function GetIpListRecByResName(AResName: string): TIpListRec;

    procedure SetConnectStatus2IpAddrGridBySelected(AIdx: integer; AIsResetStatus: Boolean=false);
    procedure SetGridByConnectStatusByIp(AIdx: integer; AIpAddr: string=''; AIsResetStatus: Boolean=false);

    procedure SaveDupIdCheckResult2File(AIpAddr: string);
    procedure LoadDupIdCheckResultFromFile(AIpAddr: string);

    procedure DisplayDuplicatedAddr();
    procedure SetVisibleAllGridRow(AIsShow: Boolean);

    function GetPortPrintDebug(AIpAddr, AMode: string): string;
    procedure Log(const AMsg: string);
    procedure ShowTD(const ATDRec: TMsgBox);
  end;

var
  HiconisTCPF: THiconisTCPF;

implementation

uses System.TimeSpan, System.Diagnostics,
  UnitStringUtil, FrmIpList, UnitExcelUtil, UnitNextGridUtil2,
  UnitAnimationThread, UnitCryptUtil3, pingsend, FrmElapsedTime
  ;

{$R *.dfm}

procedure THiconisTCPF.SetGridByConnectStatusByIp(AIdx: integer; AIpAddr: string;
  AIsResetStatus: Boolean);
begin
  if PingHost(AIpAddr) = -1 then
//      ChangeRowColorByIndex(IPAddrGrid, AIdx, clYellow)
    ChangeRowFontColorByIndex(IPAddrGrid, AIdx, clRed)
  else
//      ChangeRowColorByIndex(IPAddrGrid, AIdx, clGreen)
    ChangeRowFontColorByIndex(IPAddrGrid, AIdx, clBlack);
end;

function THiconisTCPF.BackupMPM(AIpAddrList: string): string;
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

procedure THiconisTCPF.BitBtn1Click(Sender: TObject);
begin
  TagAddrGrid.BeginUpdate;
  try
    TagAddrGrid.ClearRows;
  finally
    TagAddrGrid.EndUpdate();
  end;
end;

procedure THiconisTCPF.BitBtn3Click(Sender: TObject);
begin
  SetConnectStatus2IpAddrGridBySelected(IpAddrGrid.SelectedRow);
end;

procedure THiconisTCPF.BitBtn4Click(Sender: TObject);
var
  LJson:string;
  LIpListRec: TIpListRec;
begin
  LJson := Utf8ToString(FIpAddrDic.Data.SaveToJson());

  if ShowIPAddressListForm(LJson) = mrOK then
  begin
    FIpAddrDic.Clear;
    FIpAddrDic.Data.LoadFromJson(StringToUtf8(LJson));

    LJson := Utf8ToString(GetIPListJsonFromIpList(FIpAddrDic));
    IPAddrGrid.ClearRows;
    SetIpListFromJson2Grid(LJson, IPAddrGrid);
  end;
end;

procedure THiconisTCPF.CheckConnection1Click(Sender: TObject);
begin
  if IpAddrGrid.SelectedRow = -1 then
  begin
    ShowMessage('IP를 선택하세요.');
    exit;
  end;

  SetConnectStatus2IpAddrGridBySelected(IpAddrGrid.SelectedRow);
end;

procedure THiconisTCPF.CheckDuplicatedID1Click(Sender: TObject);
begin
//  GetIdsFromIpListDic();
  GetIdsFromIpSelected();
end;

procedure THiconisTCPF.DisplayDuplicatedAddr;
var
  LIDList: TIDList;
  LRec: TDupIDListRec;
  i: integer;
begin
  SetVisibleAllGridRow(False);

  LIDList := FIpNDupIdList.Value[IPAddrGrid.SelectedRow];

  for LRec in LIDList do
  begin
    for i := 0 to TagAddrGrid.RowCount - 1 do
    begin
      if LRec.DupIdRec.MMAddress = TagAddrGrid.CellsByName['MMAddress', i] then
        TagAddrGrid.Row[i].Visible := True;
    end;
  end;
end;

function THiconisTCPF.DownloadBackupMPMAsync(AIpAddr: string): string;
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
            LUrl := 'http://' + AIpAddr + '/';
            //IP 마지막 주소값을 가져옴
            LBackupFileSufix := strTokenRev(AIpAddr, '.');
            LFN := 'MPM' + LBackupFileSufix + '.tgz';
            LQuery := '&=Download+Backup';
            LFullUrl := LUrl + '/' + LFN;// + '?' + LQuery;

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
    Parallel.TaskConfig.OnMessage(Self).OnTerminated(
      procedure (const ATask: IOmniTaskControl)
      begin
        Log('Backup file is downloaded to ' + LResult);
      end
    )
  );
end;

function THiconisTCPF.DownloadBackupMPMForEach(AIpList: string): string;
var
  LStr: string;
begin
  if not Assigned(FIpList) then
    FIpList := TStringList.Create
  else
    FIpList.Clear;

  while AIpList <> '' do
  begin
    LStr := StrToken(AIpList, ';');
    FIpList.Add(LStr);
  end;

  if not Assigned(FMPMBackupResultList) then
    FMPMBackupResultList := TStringList.Create
  else
    FMPMBackupResultList.Clear;

  ShowElapsedTimeForm();

  FWorker := Parallel.ForEach(0, FIpList.Count - 1)
    .CancelWith(FCancelToken)
    .NumTasks(FIpList.Count)
    .PreserveOrder
    .NoWait
    .OnStop(
        procedure (const task: IOmniTask)
        begin
          // because of NoWait, OnStop delegate is invoked from the worker code;
          //we must not destroy the worker at that point or the program will block
          task.Invoke(
            procedure
            begin
              ElapsedTimeF.Hide;
              ElapsedTimeF.Free;
              FMPMBackupResultList.SaveToFile('c:\temp\FMPMBackupResultList.txt');
              ShowMessage(FMPMBackupResultList.Text);
            end

          );//Invoke
        end
    ); //OnStop

    FWorker.Execute(
      procedure (const task: IOmniTask; const i: integer)
      var
        LHttp: TIdHttp;
        LIpAddr, Lurl, LQuery, LFullUrl, LBackupFileSufix, LFN: string;
        LStream: TMemoryStream;
        LStopWatch: TStopWatch;
      begin
        LIpAddr := FIpList.Strings[i];

        if PingHost(LIpAddr) = -1 then
        begin
          FMPMBackupResultList.Add(LiPAddr + ' : bad connection!');
        end
        else
        begin
          LStopWatch := TStopWatch.StartNew;
          LHttp := TIdHttp.Create(nil);
          try
            LUrl := 'http://' + LIpAddr + '/Backup';
            LQuery := '&=Make%20Backup';
            LFullUrl := LUrl + '?' + LQuery;

            LFullUrl := LHttp.Get(LFullUrl);

            if Pos('Download Backup', LFullUrl) > 0  then
            begin
              LStream := TMemoryStream.Create;
              try
                LUrl := 'http://' + LIpAddr + '/';
                //IP 마지막 주소값을 가져옴
                LBackupFileSufix := strTokenRev(LIpAddr, '.');
                LFN := 'MPM' + LBackupFileSufix + '.tgz';
                LQuery := '&=Download+Backup';
                LFullUrl := LUrl + '/' + LFN;// + '?' + LQuery;

                LHttp.Get(LFullUrl, LStream);
                LFN := 'c:\temp\' + LFN;
                LStream.SaveToFile(LFN);

                LFN := LFN + ' => Elapsed Time : ' +
                  IntToStr(LStopWatch.Elapsed.Minutes) + '분 ' +
                  IntToStr(LStopWatch.Elapsed.Seconds) + '초';
                FMPMBackupResultList.Add(LFN);
              finally
                LStream.Free;
              end;
            end;
    //          ShowMessage(Lurl);
          finally
            LHttp.Free;
            LStopWatch.Stop;
          end;
        end;//if ping
      end
    );
end;

procedure THiconisTCPF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FTCPResponse.Free;

  if Assigned(FIpList) then
    FIpList.Free;

  if Assigned(FMPMBackupResultList) then
    FMPMBackupResultList.Free;
end;

procedure THiconisTCPF.FormCreate(Sender: TObject);
begin
  FIpAddrDic := Collections.NewKeyValue<string, TIpListRec>;
//  FIpAddrDic := Collections.NewList<TIpListRec>;
//  FAddrIdListDic := Collections.NewKeyValue<string, TIDListRec>;
  FIDListDic := Collections.NewKeyValue<string, TStringList>;
//  FDupIdList := Collections.NewList<TDupIDListRec>;
  FIpNIdList := Collections.NewKeyValue<string, TIDDic>;
  FIpNDupIdList := Collections.NewKeyValue<string, TIDList>;

  FTCPResponse := TStringList.Create;
end;

function THiconisTCPF.GetFileNameFromIpAddr(AIpAddr: string): string;
begin
  EnsureDirectoryExists('c:\temp\');
  Result := 'c:\temp\' + replaceString(AIpAddr, '.', '_') + '.pjh';
end;

function THiconisTCPF.GetIdFromMPM(ARec: TIpListRec): integer;
var
  LCon: RawByteString;
  LUrl, LIpAddr: string;
begin
  if ARec.PMPM_PIP = '127.0.0.1' then
    exit;

  LIpAddr := ARec.PMPM_PIP;

  Result := PingHost(LIpAddr);

  if Result = -1 then
  begin
    Log('Host not connected : <' + LIpAddr + '>');
    exit;
  end;

  LUrl := GetUrlFromIpRec(LIpAddr);

  LCon := HttpGet(LUrl, nil, False, nil, 5000);

  if LCon = '' then
  begin
    LIpAddr := ARec.PMPM_SIP;
    LUrl := GetUrlFromIpRec(LIpAddr);
    LCon := HttpGet(LUrl);

    if LCon <> '' then
    begin
      ConsoleMemo.Lines.Clear;
      ConsoleMemo.Lines.Text := LCon;
      SetIdList2GridByTagText(LIpAddr, ConsoleMemo.Lines.Text);
    end;
  end
  else
  begin
    ConsoleMemo.Lines.Clear;
    ConsoleMemo.Lines.Text := LCon;
    SetIdList2GridByTagText(LIpAddr, ConsoleMemo.Lines.Text);
  end;
end;

procedure THiconisTCPF.GetIdFromMPM_Async(ARec: TIpListRec);
var
  LIpAddr: string;
  LCon: RawByteString;
begin
  if ARec.PMPM_PIP = '127.0.0.1' then
    exit;

  LIpAddr := ARec.PMPM_PIP;

  Parallel.Async(
    procedure (const task: IOmniTask)
    var
      LHttp: TIdHttp;
      Lurl, LQuery, LFullUrl: string;
    begin
      LUrl := GetUrlFromIpRec(LIpAddr);
      LCon := HttpGet(LUrl);

      if LCon = '' then
      begin
        LIpAddr := ARec.PMPM_SIP;
        LUrl := GetUrlFromIpRec(LIpAddr);
        LCon := HttpGet(LUrl);
      end;
    end,

    Parallel.TaskConfig.OnMessage(Self).OnTerminated(
      procedure
      begin
        if LCon <> '' then
        begin
          ConsoleMemo.Lines.Clear;
          ConsoleMemo.Lines.Text := LCon;
          SetIdList2GridByTagText(LIpAddr, ConsoleMemo.Lines.Text);
        end;
      end
    )
  );
end;

procedure THiconisTCPF.GetIdsFromIpListDic;
var
  LIpListRec: TIpListRec;
  i: integer;
begin
  TagAddrGrid.ClearRows;
  FIpNIdList.Clear;
  FIpNDupIdList.Clear;

  for i := 0 to FIpAddrDic.Count - 1 do
//  for LIpListRec in FIpAddrDic do
  begin
    LIpListRec := FIpAddrDic.Value[i];
//    GetIdFromMPM(LIpListRec);
    GetIdFromMPM_Async(LIpListRec);
  end;
end;

procedure THiconisTCPF.GetIdsFromIpSelected;
var
  i: integer;
  LIp, LResName: string;
  LIpListRec: TIpListRec;
begin
  TagAddrGrid.ClearRows;
  FIpNIdList.Clear;
  FIpNDupIdList.Clear;

  for i := 0 to IPAddrGrid.RowCount - 1 do
  begin
    if IPAddrGrid.Row[i].Selected then
    begin
      LResName := IPAddrGrid.CellsByName['RES_NAME', i];
      LIp := IPAddrGrid.CellsByName['PMPM_PIP', i];
      LIpListRec := GetIpListRecByResName(LResName);

      if GetIdFromMPM(LIpListRec) = -1 then
        ShowMessage('Host not connected : <' + LIpListRec.PMPM_PIP + '>')
      else
        SaveDupIdCheckResult2File(LIp);
    end;
  end;
end;

function THiconisTCPF.GetIpListRecByIp(AIpAddr: string): TIpListRec;
begin
  if not FIpAddrDic.TryGetValue(AIpAddr, Result) then
    Result := Default(TIpListRec);
end;

function THiconisTCPF.GetIpListRecByResName(AResName: string): TIpListRec;
begin
  if not FIpAddrDic.TryGetValue(AResName, Result) then
    Result := Default(TIpListRec);
end;

function THiconisTCPF.GetMPMNameFromIpAddrDic(AIpAddr: string): string;
var
  i: Integer;
  LIpListRec: TIpListRec;
begin
  Result := '';

  for i := 0 to FIpAddrDic.Count - 1 do
  begin
    LIpListRec := FIpAddrDic.Value[i];

    if LIpListRec.PMPM_PIP = AIpAddr then
    begin
      Result := LIpListRec.RES_NAME;
    end;
  end;
end;

procedure THiconisTCPF.GetPortPrint1Click(Sender: TObject);
var
  LIpAddrList: string;
begin
  //';'로 구분됨
  LIpAddrList := GetSelectedIpAddrList();

  GetPortPrintDebug(LIpAddrList, '0');
end;

function THiconisTCPF.GetPortPrintDebug(AIpAddr, AMode: string): string;
var
  LIOHandler: TIdIOHandler;
begin
  FTCPResponse.Clear;

  if IdTCPClient1.Connected then
    IdTCPClient1.Disconnect;

  IdTCPClient1.Host := AIpAddr;
  IdTCPClient1.Port := 23;

  IdTCPClient1.Connect;
  LIOHandler := IdTCPClient1.IOHandler;

  LIOHandler.WaitFor('login:');
  LIOHandler.WriteLn('root');
  LIOHandler.WaitFor('$');
  LIOHandler.WriteLn('pp 01');
  LIOHandler.WaitFor('Select>>');
  LIOHandler.WriteLn('0');
  LIOHandler.WaitFor('Choice: 0');
//  LIOHandler.WaitFor('------------------------Debug Mode----------------------');

  repeat
    FTCPResponse.Add(LIOHandler.ReadLn(LF, 100));
  until LIOHandler.ReadLnTimedout;

  ConsoleMemo.Lines.Assign(FTCPResponse);
  Result := FTCPResponse.Text;
end;

procedure THiconisTCPF.GetPreTagTextFromHtml;
var
  LStr: string;
  LStrList: TStringList;
begin
//  LStr := ConsoleMemo.Lines.Text;//'<pre>0xa001ffc0 : AI04101_16'#$A'0xa001ffd8 : AI04101_02</pre>';
//  ConsoleMemo.Lines.Text := ExtractTextInsideGivenTagEx('pre', LStr);
//  LStrList := ExtractTextBetweenTags(LStr);
//  ConsoleMemo.Lines.Text := LStrList.Text;
//  LStrList.Free;
//  ConsoleMemo.Lines.Text := TRegEx.Match(LStr, '(?si)<pre>.*?</pre>').Value;
end;

function THiconisTCPF.GetSelectedIpAddrList(AIsMaster: Boolean): string;
var
  i: integer;
  LList: string;
begin
  Result := '';
  LList := '';

  for i := 0 to IPAddrGrid.RowCount - 1 do
  begin
    if IPAddrGrid.Row[i].Selected then
    begin
      if AIsMaster then
        LList := LList + IPAddrGrid.CellsByName['PMPM_PIP', i] + ';'
      else
        LList := LList + IPAddrGrid.CellsByName['PMPM_SIP', i] + ';';
    end;
  end;

  Result := LList;
end;

function THiconisTCPF.GetUrlFromIpRec(AIpAddr: string): string;
begin
  Result := 'http://' + AIpAddr + '/channelstr';
end;

procedure THiconisTCPF.HtmlParseFunc;
var
//  HtmlParser: THtmlParser;
//  HtmlDoc: TDocument;
//  Formatter: TBaseFormatter;
  LStr: string;
begin
//  HtmlParser := THtmlParser.Create;
  try
    LStr := ConsoleMemo.Lines.Text;
//    HtmlDoc := THtmlParser.parse(LStr)

  finally
//    HtmlParser.Free
  end;

end;

//procedure THiconisTCPF.IPAddrGridSelectCell(Sender: TObject; ACol,
//  ARow: Integer);
//var
//  LIpAddr: string;
//begin
//  LIpAddr := IPAddrGrid.CellsByName['PMPM_PIP', ARow];
//  SetIdList2Grid(LIpAddr);
//end;

procedure THiconisTCPF.LoadDupIdCheckResultFile1Click(Sender: TObject);
var
  LIp: string;
begin
  if IPAddrGrid.SelectedRow = -1 then
    exit;

    LIp := IPAddrGrid.CellsByName['PMPM_PIP', IPAddrGrid.SelectedRow];
//    LIp := IPAddrGrid.CellsByName['RES_NAME', IPAddrGrid.SelectedRow];
    LoadDupIdCheckResultFromFile(LIp);
end;

procedure THiconisTCPF.LoadDupIdCheckResultFromFile(AIpAddr: string);
var
  LResultRec: TResultCheckDupIDRec;
  LUtf8: RawUtf8;
  LFileName: string;
begin
  LFileName := GetFileNameFromIpAddr(AIpAddr);

  if not FileExists(LFileName) then
  begin
    ShowMessage('File Not Found => ' + LFileName);
  end;

  LUtf8 := StringFromFile(LFileName);
  LUtf8 := MakeDecryptNBase64String(LUtf8);

  LUtf8 := JSONReformat(LUtf8, jsonHumanReadable);
  ShowMessage(Utf8ToString(LUtf8));
end;

procedure THiconisTCPF.LoadIpListFromFile(AFileName: string);
var
  LRawStr: RawByteString;
  LJson: string;
begin
  LRawStr := StringFromFile(AFileName);

  FIpAddrDic.Data.LoadFromJson(LRawStr);

  LJson := Utf8ToString(GetIPListJsonFromIpList(FIpAddrDic));
  SetIpListFromJson2Grid(LJson, IPAddrGrid);
end;

procedure THiconisTCPF.LoadIPListFromFile1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    LoadIPListFromFile(OpenDialog1.FileName);
  end;
end;

procedure THiconisTCPF.Log(const AMsg: string);
begin
  ConsoleMemo.Lines.Add(AMsg);
end;

procedure THiconisTCPF.MPMBackup1Click(Sender: TObject);
var
  LIpAddr: string;
begin
  //';'로 구분됨
  LIpAddr := GetSelectedIpAddrList();
  DownloadBackupMPMForEach(LIpAddr);
//  BackupMPM(LIpAddr);
end;

procedure THiconisTCPF.PngBitBtn1Click(Sender: TObject);
begin
  NextGridToExcel(TagAddrGrid);
end;

procedure THiconisTCPF.PngBitBtn2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    NextGridToCsv(OpenDialog1.FileName, TagAddrGrid);
  end;
end;

procedure THiconisTCPF.SaveDupIdCheckResult2File(AIpAddr: string);
var
  LIDList: TIDList;
  LResultRec: TResultCheckDupIDRec;
  LUtf8: RawUtf8;
  LFileName: string;
begin
  LResultRec := Default(TResultCheckDupIDRec);
  LResultRec.ResourceInfoRec.PMPM_PIP := AIpAddr;

  if FIpNDupIdList.TryGetValue(AIpAddr, LIDList) then
    LResultRec.DupIdCount := IntToStr(LIDList.Count);
  LResultRec.CheckDate := FormatDateTime('yyyy-mm-dd hh:nn:ss', now);

  LUtf8 := RecordSaveJson(LResultRec, TypeInfo(TResultCheckDupIDRec));
  LUtf8 := MakeBase64NEncrypString(LUtf8);
  LFileName := GetFileNameFromIpAddr(AIpAddr);

  if FileFromString(LUtf8, LFileName) then
  begin
//    ShowMessage('File is saved successfully => ' + LFileName);
    ShowMessage('Duplicated ID 검사가 완료 되었습니다.' + #13#10 + 'Duplicated ID 건수 : [' + LResultRec.DupIdCount + ']');
  end;
end;

procedure THiconisTCPF.SaveIpListToFile(AFileName: string);
var
  LJson: string;
begin
  LJson := Utf8ToString(FIpAddrDic.Data.SaveToJson());
  FileFromString(LJson, AFileName);
end;

procedure THiconisTCPF.SaveIPListToFile1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    SaveIpListToFile(SaveDialog1.FileName);
  end;
end;

procedure THiconisTCPF.SetConnectStatus2IpAddrGridBySelected(AIdx: integer;
  AIsResetStatus: Boolean);
var
  LIp: string;
  LIsAll: Boolean;
  i: integer;
begin
  LIsAll := AIdx = -1;

  if LIsAll then
  begin
    for i := 0 to IPAddrGrid.RowCount - 1 do
    begin
      LIp := IPAddrGrid.CellsByName['PMPM_PIP', i];
      SetGridByConnectStatusByIp(i, LIp);
    end;
  end
  else
  begin
    LIp := IPAddrGrid.CellsByName['PMPM_PIP', AIdx];
    SetGridByConnectStatusByIp(AIdx, LIp);
  end;
end;

procedure THiconisTCPF.SetIdList2Grid(AIpAddr: string);
begin
  if TaskTab.ActiveTabIndex = 0 then//전체
    SetIdList2GridFromIpNIdList(AIpAddr)
  else
    SetIdList2GridFromIpNDupIdList(AIpAddr);
end;

procedure THiconisTCPF.SetIdList2GridByTagText(AIpAddr: string; ATagText: string);
var
  LStrList: TStringList;
  LStr, LId, LAddr: string;
  LRec: TIDListRec;
  LRow: integer;
  LDupIDListRec: TDupIDListRec;
  LDupList: IList<TDupIDListRec>;
  LIdDic: TIDDic;
begin
  LStrList := TStringList.Create;
  LStrList.Text := ExtractTextInsideGivenTagEx('pre', ATagText);
  TagAddrGrid.BeginUpdate;
  try
    LDupList := Collections.NewList<TDupIDListRec>;
    LIdDic := Collections.NewKeyValue<string, TIDListRec>;

    for LStr in LStrList do
    begin
      LId := LStr;
      LAddr := StrToken(LId, ':');
      LRec.MMAddress := Trim(LAddr);
      LRec.TagId := Trim(StrToken(LId, ':'));

      if not LIdDic.TryAdd(LRec.MMAddress, LRec) then
      begin
        LDupIDListRec.IpRec.PMPM_PIP := AIpAddr;
        LDupIDListRec.DupIdRec := LRec;
        LDupList.Add(LDupIDListRec);
      end;
  //    FIDListDic.Add(AIpName, LStrList);

      LRow := TagAddrGrid.AddRow();
//      TagAddrGrid.CellsByName['RES_NAME', LRow] := AIpRec.RES_NAME;
//      TagAddrGrid.CellsByName['PMPM_PIP', LRow] := AIpRec.PMPM_PIP;
      TagAddrGrid.CellsByName['MMAddress', LRow] := LRec.MMAddress;
      TagAddrGrid.CellsByName['TagId', LRow] := LRec.TagId;
      TagAddrGrid.CellsByName['MPMName', LRow] := GetMPMNameFromIpAddrDic(AIpAddr);
    end;//for

    FIpNIdList.Add(AIpAddr, LIdDic);

    if LDupList.Count > 0 then
      FIpNDupIdList.Add(AIpAddr, LDupList);
  finally
    TagAddrGrid.EndUpdate();
    LStrList.Free;
  end;
end;

procedure THiconisTCPF.SetIdList2GridFromIpNDupIdList(AIpAddr: string);
var
  LIDList: TIDList;
  LDupRec: TDupIDListRec;
  i, LRow: integer;
  LIpAddr: string;
begin
  TagAddrGrid.BeginUpdate;
  try
    TagAddrGrid.ClearRows;


    while AIpAddr <> '' do
    begin
      LIpAddr := StrToken(AIpAddr, ';');
      if FIpNDupIdList.TryGetValue(LIpAddr, LIDList) then
      begin
        for i := 0 to LIDList.Count - 1 do
        begin
          LDupRec := LIDList.Items[i];

          LRow := TagAddrGrid.AddRow();
          TagAddrGrid.CellsByName['MMAddress', LRow] := LDupRec.DupIdRec.MMAddress;
          TagAddrGrid.CellsByName['TagId', LRow] := LDupRec.DupIdRec.TagId;
          TagAddrGrid.CellsByName['MPMName', LRow] := GetMPMNameFromIpAddrDic(LIpAddr);
        end;
      end;
    end;//while
  finally
    TagAddrGrid.EndUpdate();
  end;
end;

procedure THiconisTCPF.SetIdList2GridFromIpNIdList(AIpAddr: string);
var
  LIDDic: TIDDic;
  LRec: TIDListRec;
  i, LRow: integer;
  LIpAddr: string;
begin
  TagAddrGrid.BeginUpdate;
  try
    TagAddrGrid.ClearRows;

    while AIpAddr <> '' do
    begin
      LIpAddr := StrToken(AIpAddr, ';');

      LIDDic := FIpNIdList.Items[LIpAddr];

      for i := 0 to LIDDic.Count - 1 do
      begin
        LRec := LIDDic.Value[i];

        LRow := TagAddrGrid.AddRow();
        TagAddrGrid.CellsByName['MMAddress', LRow] := LRec.MMAddress;
        TagAddrGrid.CellsByName['TagId', LRow] := LRec.TagId;
        TagAddrGrid.CellsByName['MPMName', LRow] := GetMPMNameFromIpAddrDic(LIpAddr);
      end;
    end;//while
  finally
    TagAddrGrid.EndUpdate();
  end;
end;

procedure THiconisTCPF.SetVisibleAllGridRow(AIsShow: Boolean);
var
  i: integer;
begin
  TagAddrGrid.BeginUpdate;
  try
    for i := 0 to TagAddrGrid.RowCount - 1 do
      TagAddrGrid.Row[i].Visible := AIsShow;
  finally
    TagAddrGrid.EndUpdate();
  end;
end;

procedure THiconisTCPF.ShowProgress1Click(Sender: TObject);
//var
//  ani : TAnimationThread;
//  r : TRect;
begin
//  r := panel1.clientrect;
//  InflateRect(r, - panel1.bevelwidth, - panel1.bevelwidth);
//  ani := TanimationThread.Create(panel1, r, panel1.color, clBlue, 25);
//  BitBtn1.Enabled := False;
//  Application.ProcessMessages;
//  Sleep(30000);  // replace with query.Open or such
//  BitBtn1.Enabled := True;
//  ani.Terminate;
//  ShowMessage('Done');

  ShowModalElapsedTimeForm();
end;


procedure THiconisTCPF.ShowTD(const ATDRec: TMsgBox);
begin
  TD('').WindowCaption(ATDRec.FCaption).Execute(Self);
end;

procedure THiconisTCPF.TaskTabChange(Sender: TObject);
var
  LIpAddr: string;
begin
  LIpAddr := GetSelectedIpAddrList();
  SetIdList2Grid(LIpAddr);
end;

end.
