unit FrmHiConChkDuplicateID;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RegularExpressions, Vcl.Menus,

  mormot.core.collections, mormot.core.variants,

  UnitChkDupIdData, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, NxScrollControl,
  NxCustomGridControl, NxCustomGrid, NxGrid, NxColumnClasses, NxColumns,
  AdvOfficeTabSet,

  PngBitBtn, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdIOHandler,
  IdGlobal,

  mormot.net.client, mormot.core.unicode, mormot.core.os,

  HtmlParser, UnitTRegExUtil, UnitHtmlUtil
  ;

type
  TIDList = IList<TDupIDListRec>;
  TIDDic = IKeyValue<string, TIDListRec>;

  THiconisTCPF = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
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
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure SaveIPListToFile1Click(Sender: TObject);
    procedure LoadIPListFromFile1Click(Sender: TObject);
    procedure TaskTabChange(Sender: TObject);
    procedure PngBitBtn1Click(Sender: TObject);
    procedure PngBitBtn2Click(Sender: TObject);
//    procedure IPAddrGridSelectCell(Sender: TObject; ACol, ARow: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GetPortPrint1Click(Sender: TObject);
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

    procedure SetIdList2GridByTagText(AIpAddr: string; ATagText: string);
    procedure SaveIpListToFile(AFileName: string);
    procedure LoadIpListFromFile(AFileName: string);
    procedure SetIdList2Grid(AIpAddr: string);
    procedure SetIdList2GridFromIpNIdList(AIpAddr: string);
    procedure SetIdList2GridFromIpNDupIdList(AIpAddr: string);

    function GetSelectedIpAddr(AIsMaster: Boolean=true): string;
  public
    procedure GetIdFromMPM(ARec: TIpListRec);
    procedure GetIdsFromIpListDic;
    procedure HtmlParseFunc();
    procedure GetPreTagTextFromHtml();

    function GetUrlFromIpRec(AIpAddr: string): string;

    procedure DisplayDuplicatedAddr();
    procedure SetVisibleAllGridRow(AIsShow: Boolean);

    function GetPortPrintDebug(AIpAddr, AMode: string): string;
  end;

var
  HiconisTCPF: THiconisTCPF;

implementation

uses UnitStringUtil, FrmIpList, UnitExcelUtil, UnitNextGridUtil2;
//  DomCore, Formatter;

{$R *.dfm}

procedure THiconisTCPF.BitBtn1Click(Sender: TObject);
begin
  TagAddrGrid.ClearRows;
  FIpNIdList.Clear;
  FIpNDupIdList.Clear;

  GetIdsFromIpListDic();
//  GetIdFromMPM('http://10.8.1.41/channelstr');
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
    SetIpListFromJson2Grid(LJson, IPAddrGrid);
  end;
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

procedure THiconisTCPF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FTCPResponse.Free;
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

procedure THiconisTCPF.GetIdFromMPM(ARec: TIpListRec);
var
  LCon: RawByteString;
  LUrl, LIpAddr: string;
begin
  if ARec.PMPM_PIP = '127.0.0.1' then
    exit;

  LIpAddr := ARec.PMPM_PIP;
  LUrl := GetUrlFromIpRec(LIpAddr);
  LCon := HttpGet(LUrl);

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

procedure THiconisTCPF.GetIdsFromIpListDic;
var
  LIpListRec: TIpListRec;
  i: integer;
begin
  for i := 0 to FIpAddrDic.Count - 1 do
//  for LIpListRec in FIpAddrDic do
  begin
    LIpListRec := FIpAddrDic.Value[i];
    GetIdFromMPM(LIpListRec);
  end;
end;

procedure THiconisTCPF.GetPortPrint1Click(Sender: TObject);
var
  LIpAddr: string;
begin
  LIpAddr := GetSelectedIpAddr();

  GetPortPrintDebug(LIpAddr, '0');
end;

function THiconisTCPF.GetPortPrintDebug(AIpAddr, AMode: string): string;
var
  LIOHandler: TIdIOHandler;
begin
  FTCPResponse.Clear;

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

function THiconisTCPF.GetSelectedIpAddr(AIsMaster: Boolean): string;
begin
  if AIsMaster then
    Result := IPAddrGrid.CellsByName['PMPM_PIP', IPAddrGrid.SelectedRow]
  else
    Result := IPAddrGrid.CellsByName['PMPM_SIP', IPAddrGrid.SelectedRow]
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

procedure THiconisTCPF.SetIdList2Grid(AIpAddr: string);
begin
  if TaskTab.ActiveTabIndex = 0 then//ÀüÃ¼
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
    end;//for

    FIpNIdList.Add(AIpAddr, LIdDic);
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
begin
  LIDList := FIpNDupIdList.Items[AIpAddr];

  TagAddrGrid.BeginUpdate;
  try
    TagAddrGrid.ClearRows;

    for i := 0 to LIDList.Count - 1 do
    begin
      LDupRec := LIDList.Items[i];

      LRow := TagAddrGrid.AddRow();
      TagAddrGrid.CellsByName['MMAddress', LRow] := LDupRec.DupIdRec.MMAddress;
      TagAddrGrid.CellsByName['TagId', LRow] := LDupRec.DupIdRec.TagId;
    end;
  finally
    TagAddrGrid.EndUpdate();
  end;
end;

procedure THiconisTCPF.SetIdList2GridFromIpNIdList(AIpAddr: string);
var
  LIDDic: TIDDic;
  LRec: TIDListRec;
  i, LRow: integer;
begin
  LIDDic := FIpNIdList.Items[AIpAddr];

  TagAddrGrid.BeginUpdate;
  try
    TagAddrGrid.ClearRows;

    for i := 0 to LIDDic.Count - 1 do
    begin
      LRec := LIDDic.Value[i];

      LRow := TagAddrGrid.AddRow();
      TagAddrGrid.CellsByName['MMAddress', LRow] := LRec.MMAddress;
      TagAddrGrid.CellsByName['TagId', LRow] := LRec.TagId;
    end;
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

procedure THiconisTCPF.TaskTabChange(Sender: TObject);
var
  LIpAddr: string;
begin
  LIpAddr := GetSelectedIPAddr();
  SetIdList2Grid(LIpAddr);
end;

end.
