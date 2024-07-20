unit FrmHiConChkDuplicateID;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RegularExpressions, Vcl.Menus,

  mormot.core.collections,
  UnitChkDupIdData, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, NxScrollControl,
  NxCustomGridControl, NxCustomGrid, NxGrid, NxColumnClasses, NxColumns,
  AdvOfficeTabSet,

  mormot.net.client, mormot.core.unicode, mormot.core.os,

  HtmlParser, UnitTRegExUtil, UnitHtmlUtil
  ;

type
  TCheckDupIdF = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    TaskTab: TAdvOfficeTabSet;
    Memo1: TMemo;
    Splitter1: TSplitter;
    IPAddrGrid: TNextGrid;
    NxIncrementColumn1: TNxIncrementColumn;
    IPName: TNxTextColumn;
    IPAddress: TNxTextColumn;
    MMAddress: TNxTextColumn;
    TagId: TNxTextColumn;
    BitBtn4: TBitBtn;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Close1: TMenuItem;
    N1: TMenuItem;
    SaveIPListToFile1: TMenuItem;
    SaveDialog1: TSaveDialog;
    LoadIPListFromFile1: TMenuItem;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure SaveIPListToFile1Click(Sender: TObject);
    procedure LoadIPListFromFile1Click(Sender: TObject);
    procedure TaskTabChange(Sender: TObject);
  private
    //Key: IPName
    FIpAddrDic: IKeyValue<string, TIpListRec>;
    //Key: IPName
    FIDListDic: IKeyValue<string, TStringList>;
    //Key: MM Address
    FAddrIdListDic: IKeyValue<string, TIDListRec>;
    //MM Address
    FDupIdList: IList<TDupIDListRec>;

    procedure SetIdList2Grid(AIpRec: TIpListRec; ATagText: string);
    procedure SaveIpListToFile(AFileName: string);
    procedure LoadIpListFromFile(AFileName: string);
  public
    procedure GetIdFromMPM(ARec: TIpListRec);
    procedure GetIdsFromIpListDic;
    procedure HtmlParseFunc();
    procedure GetPreTagTextFromHtml();

    function GetUrlFromIpRec(ARec: TIpListRec): string;

    procedure DisplayDuplicatedAddr();
    procedure SetVisibleAllGridRow(AIsShow: Boolean);
  end;

var
  CheckDupIdF: TCheckDupIdF;

implementation

uses UnitStringUtil, FrmIpList;
//  DomCore, Formatter;

{$R *.dfm}

procedure TCheckDupIdF.BitBtn1Click(Sender: TObject);
begin
  IPAddrGrid.ClearRows;

  GetIdsFromIpListDic();
//  GetIdFromMPM('http://10.8.1.41/channelstr');
end;

procedure TCheckDupIdF.BitBtn3Click(Sender: TObject);
begin
//  HtmlParseFunc();
  GetPreTagTextFromHtml();
end;

procedure TCheckDupIdF.BitBtn4Click(Sender: TObject);
var
  LJson:string;
  LIpListRec: TIpListRec;
begin
//  LIpListRec.IPName := 'MPM-1';
//  LIpListRec.IPAddress := '10.8.1.41';

//  if FIpAddrDic.TryAdd(LIpListRec.IPName, LIpListRec) then
//  begin
    LJson := Utf8ToString(FIpAddrDic.Data.SaveToJson());

    if ShowIPAddressListForm(LJson) = mrOK then
    begin
      FIpAddrDic.Clear;
      FIpAddrDic.Data.LoadFromJson(StringToUtf8(LJson));
    end;
//  end;
end;

procedure TCheckDupIdF.DisplayDuplicatedAddr;
var
  LRec: TDupIDListRec;
  i: integer;
begin
  SetVisibleAllGridRow(False);

  for LRec in FDupIdList do
  begin
    for i := 0 to IPAddrGrid.RowCount - 1 do
    begin
      if LRec.DupIdRec.MMAddress = IPAddrGrid.CellsByName['MMAddress', i] then
        IPAddrGrid.Row[i].Visible := True;
    end;
  end;
end;

procedure TCheckDupIdF.FormCreate(Sender: TObject);
begin
  FIpAddrDic := Collections.NewKeyValue<string, TIpListRec>;
//  FIpAddrDic := Collections.NewList<TIpListRec>;
  FAddrIdListDic := Collections.NewKeyValue<string, TIDListRec>;
  FIDListDic := Collections.NewKeyValue<string, TStringList>;
  FDupIdList := Collections.NewList<TDupIDListRec>;
end;

procedure TCheckDupIdF.GetIdFromMPM(ARec: TIpListRec);
var
  LCon: RawByteString;
  LUrl: string;
begin
  LUrl := GetUrlFromIpRec(ARec);
  LCon := HttpGet(LUrl);

  if LCon <> '' then
  begin
    Memo1.Lines.Text := LCon;
    SetIdList2Grid(ARec, Memo1.Lines.Text);
  end;
end;

procedure TCheckDupIdF.GetIdsFromIpListDic;
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

procedure TCheckDupIdF.GetPreTagTextFromHtml;
var
  LStr: string;
  LStrList: TStringList;
begin
//  LStr := Memo1.Lines.Text;//'<pre>0xa001ffc0 : AI04101_16'#$A'0xa001ffd8 : AI04101_02</pre>';
//  Memo1.Lines.Text := ExtractTextInsideGivenTagEx('pre', LStr);
//  LStrList := ExtractTextBetweenTags(LStr);
//  Memo1.Lines.Text := LStrList.Text;
//  LStrList.Free;
//  Memo1.Lines.Text := TRegEx.Match(LStr, '(?si)<pre>.*?</pre>').Value;
end;

function TCheckDupIdF.GetUrlFromIpRec(ARec: TIpListRec): string;
begin
  Result := 'http://' + ARec.IPAddress + '/channelstr';
end;

procedure TCheckDupIdF.HtmlParseFunc;
var
//  HtmlParser: THtmlParser;
//  HtmlDoc: TDocument;
//  Formatter: TBaseFormatter;
  LStr: string;
begin
//  HtmlParser := THtmlParser.Create;
  try
    LStr := Memo1.Lines.Text;
//    HtmlDoc := THtmlParser.parse(LStr)

  finally
//    HtmlParser.Free
  end;

end;

procedure TCheckDupIdF.LoadIpListFromFile(AFileName: string);
var
  LRawStr: RawByteString;
begin
  LRawStr := StringFromFile(AFileName);

  FIpAddrDic.Data.LoadFromJson(LRawStr);
end;

procedure TCheckDupIdF.LoadIPListFromFile1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    LoadIPListFromFile(OpenDialog1.FileName);
  end;
end;

procedure TCheckDupIdF.SaveIpListToFile(AFileName: string);
var
  LJson: string;
begin
  LJson := Utf8ToString(FIpAddrDic.Data.SaveToJson());
  FileFromString(LJson, AFileName);
end;

procedure TCheckDupIdF.SaveIPListToFile1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    SaveIpListToFile(SaveDialog1.FileName);
  end;
end;

procedure TCheckDupIdF.SetIdList2Grid(AIpRec: TIpListRec; ATagText: string);
var
  LStrList: TStringList;
  LStr, LId, LAddr: string;
  LRec: TIDListRec;
  LRow: integer;
  LDupIDListRec: TDupIDListRec;
begin
  LStrList := TStringList.Create;
  LStrList.Text := ExtractTextInsideGivenTagEx('pre', ATagText);
  IPAddrGrid.BeginUpdate;
  try
    FDupIdList.Clear;

    for LStr in LStrList do
    begin
      LId := LStr;
      LAddr := StrToken(LId, ':');
      LRec.MMAddress := Trim(LAddr);
      LRec.TagId := Trim(StrToken(LId, ':'));

      if not FAddrIdListDic.TryAdd(LRec.MMAddress, LRec) then
      begin
        LDupIDListRec.IpRec := AIpRec;
        LDupIDListRec.DupIdRec := LRec;
        FDupIdList.Add(LDupIDListRec);
      end;
  //    FIDListDic.Add(AIpName, LStrList);

      LRow := IPAddrGrid.AddRow();
      IPAddrGrid.CellsByName['IPName', LRow] := AIpRec.IPName;
      IPAddrGrid.CellsByName['IPAddress', LRow] := AIpRec.IPAddress;
      IPAddrGrid.CellsByName['MMAddress', LRow] := LRec.MMAddress;
      IPAddrGrid.CellsByName['TagId', LRow] := LRec.TagId;
    end;
  finally
    IPAddrGrid.EndUpdate();
    LStrList.Free;
  end;
end;

procedure TCheckDupIdF.SetVisibleAllGridRow(AIsShow: Boolean);
var
  i: integer;
begin
  IPAddrGrid.BeginUpdate;
  try
    for i := 0 to IPAddrGrid.RowCount - 1 do
      IPAddrGrid.Row[i].Visible := AIsShow;
  finally
    IPAddrGrid.EndUpdate();
  end;
end;

procedure TCheckDupIdF.TaskTabChange(Sender: TObject);
begin
  case TaskTab.ActiveTabIndex of
    0: SetVisibleAllGridRow(True);
    1: begin
      DisplayDuplicatedAddr();
    end;
  end;
end;

end.
