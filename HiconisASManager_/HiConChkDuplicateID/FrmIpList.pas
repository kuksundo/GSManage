unit FrmIpList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, NxColumnClasses, NxColumns,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls,

  mormot.core.variants, mormot.core.unicode, mormot.core.collections,
  mormot.core.base,
  UnitChkDupIdData, UnitHiconSystemDBUtil, Vcl.Menus, AdvMenus, AdvToolBtn;

type
  TIPListF = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    IPAddrGrid: TNextGrid;
    RES_NAME: TNxTextColumn;
    PMPM_PIP: TNxTextColumn;
    Port: TNxTextColumn;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    PMPM_SIP: TNxTextColumn;
    AdvToolButton1: TAdvToolButton;
    AdvPopupMenu1: TAdvPopupMenu;
    FromResourceDB1: TMenuItem;
    FromServerDB1: TMenuItem;
    DESCRIPTION: TNxTextColumn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FromResourceDB1Click(Sender: TObject);
    procedure FromServerDB1Click(Sender: TObject);
    procedure AdvToolButton1Click(Sender: TObject);
  private
    FIpAddr, FPort, FName: string;

    procedure GetIpListFromDB(const ADBName: string);
  public
    FIpAddrDic: IKeyValue<string, TIpListRec>;

    function GetIpList2JsonFromGrid(): string;
    function GetIPListFromJson(AJson: string): IList<TIpListRec>;
  end;

  procedure SetIpListFromJson2Grid(AJson: string; AGrid: TNextGrid);
  function GetIPListJsonFromIpList(AIpAddrDic: IKeyValue<string, TIpListRec>): string;
  function ShowIPAddressListForm(var AJson: string): integer;

implementation

uses FrmInputIpAddress, UnitNextGridUtil2;

{$R *.dfm}

function ShowIPAddressListForm(var AJson: string): integer;
var
  IPListF: TIPListF;
  LJson: string;
  LList: IList<TIpListRec>;
  LRec: TIpListRec;
begin
  IPListF := TIPListF.Create(nil);
  try
    with IPListF do
    begin
      FIpAddrDic.Data.LoadFromJson(StringToUtf8(AJson));
      LJson := Utf8ToString(GetIPListJsonFromIpList(FIpAddrDic));

      SetIpListFromJson2Grid(LJson, IPAddrGrid);

      Result := ShowModal;

      if Result = mrOK then
      begin
        LJson := GetIpList2JsonFromGrid();
        LList := GetIPListFromJson(LJson);

        FIpAddrDic.Clear;

        for LRec in LList do
        begin
          FIpAddrDic.Add(LRec.RES_NAME, LRec);
        end;
        AJson := FIpAddrDic.Data.SaveToJson();
      end;
    end;
  finally
    IPListF.Free;
  end;
end;

procedure SetIpListFromJson2Grid(AJson: string; AGrid: TNextGrid);
var
  LVar: variant;
begin
  LVar := _JSON(StringToUtf8(AJson));

  if AGrid.RowCount > 0 then
  begin
    if MessageDlg('기존 Data에 추가할까요?' + #13#10 +
      '"No" 를 선택하면 덮어쓰기를 합니다.' , mtConfirmation, [mbYes, mbNo],0) = mrNo then
      AGrid.ClearRows;
  end;

  AddNextGridRowsFromVariant2(AGrid, LVar);
end;

function GetIPListJsonFromIpList(AIpAddrDic: IKeyValue<string, TIpListRec>): string;
var
  LIpAddrList: IList<TIpListRec>;
  i: integer;
begin
  Result := '';
  LIpAddrList := Collections.NewList<TIpListRec>;

  for i := 0 to AIpAddrDic.Count - 1 do
  begin
    LIpAddrList.Add(AIpAddrDic.Value[i]);
  end;

  Result := LIpAddrList.Data.SaveToJson();
end;

procedure TIPListF.AdvToolButton1Click(Sender: TObject);
begin
  AdvToolButton1.ShowDropDownMenu;
end;

procedure TIPListF.BitBtn1Click(Sender: TObject);
var
  LRow: integer;
begin
  if ShowInputIPAddressForm(FIpAddr, FPort, FName) = mrOK then
  begin
    LRow := IpAddrGrid.AddRow();
    IpAddrGrid.CellsByName['PMPM_PIP', LRow] := FIpAddr;
    IpAddrGrid.CellsByName['RES_NAME', LRow] := FName;
    IpAddrGrid.CellsByName['Port', LRow] := FPort;
  end;
end;

procedure TIPListF.BitBtn3Click(Sender: TObject);
begin
  if IPAddrGrid.SelectedRow <> -1 then
  begin
    IPAddrGrid.DeleteRow(IPAddrGrid.SelectedRow);
  end;
end;

procedure TIPListF.FormCreate(Sender: TObject);
begin
  FIpAddrDic := Collections.NewKeyValue<string, TIpListRec>;
end;

procedure TIPListF.FromResourceDB1Click(Sender: TObject);
begin
  GetIpListFromDB('Resource');
end;

procedure TIPListF.FromServerDB1Click(Sender: TObject);
begin
  GetIpListFromDB('Server');
end;

function TIPListF.GetIpList2JsonFromGrid: string;
var
  LVar: variant;
begin
  LVar := NextGrid2Variant(IPAddrGrid);
  Result := Utf8ToString(LVar);
end;

procedure TIPListF.GetIpListFromDB(const ADBName: string);
var
  LUtf8: RawUtf8;
  LVar: variant;
begin
  if ADBName = 'Resource' then
    LUtf8 := THiConSystemDB.GetResourceList2JsonFromDB()
  else
  if ADBName = 'Server' then
    LUtf8 := THiConSystemDB.GetSVRList2JsonFromDB();

  LVar := _JSON(LUtf8);
  AddNextGridRowsFromVariant2(IPAddrGrid, LVar, True);
end;

function TIPListF.GetIPListFromJson(AJson: string): IList<TIpListRec>;
begin
  Result := Collections.NewList<TIpListRec>;
  Result.Data.LoadFromJson(AJson);
end;

end.
