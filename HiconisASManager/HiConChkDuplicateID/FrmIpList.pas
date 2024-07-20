unit FrmIpList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, NxColumnClasses, NxColumns,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls,

  mormot.core.variants, mormot.core.unicode, mormot.core.collections,
  UnitChkDupIdData;

type
  TIPListF = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    IPAddrGrid: TNextGrid;
    IPName: TNxTextColumn;
    IPAddress: TNxTextColumn;
    Port: TNxTextColumn;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FIpAddr, FPort, FName: string;
  public
    FIpAddrDic: IKeyValue<string, TIpListRec>;

    function GetIpList2JsonFromGrid(): string;
    procedure SetIpListFromJson2Grid(AJson: string);
    function GetIPListJsonFromIpList: string;
    function GetIPListFromJson(AJson: string): IList<TIpListRec>;
  end;

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
      LJson := Utf8ToString(GetIPListJsonFromIpList());

      SetIpListFromJson2Grid(LJson);

      Result := ShowModal;

      if Result = mrOK then
      begin
        LJson := GetIpList2JsonFromGrid();
        LList := GetIPListFromJson(LJson);

        FIpAddrDic.Clear;

        for LRec in LList do
        begin
          FIpAddrDic.Add(LRec.IPName, LRec);
        end;
        AJson := FIpAddrDic.Data.SaveToJson();
      end;
    end;
  finally
    IPListF.Free;
  end;
end;

procedure TIPListF.BitBtn1Click(Sender: TObject);
var
  LRow: integer;
begin
  if ShowInputIPAddressForm(FIpAddr, FPort, FName) = mrOK then
  begin
    LRow := IpAddrGrid.AddRow();
    IpAddrGrid.CellsByName['IPAddress', LRow] := FIpAddr;
    IpAddrGrid.CellsByName['IPName', LRow] := FName;
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

function TIPListF.GetIpList2JsonFromGrid: string;
var
  LVar: variant;
begin
  LVar := NextGrid2Variant(IPAddrGrid);
  Result := Utf8ToString(LVar);
end;

function TIPListF.GetIPListFromJson(AJson: string): IList<TIpListRec>;
begin
  Result := Collections.NewList<TIpListRec>;
  Result.Data.LoadFromJson(AJson);
end;

function TIPListF.GetIPListJsonFromIpList: string;
var
  LIpAddrList: IList<TIpListRec>;
  i: integer;
begin
  Result := '';
  LIpAddrList := Collections.NewList<TIpListRec>;

  for i := 0 to FIpAddrDic.Count - 1 do
  begin
    LIpAddrList.Add(FIpAddrDic.Value[i]);
  end;

  Result := LIpAddrList.Data.SaveToJson();
end;

procedure TIPListF.SetIpListFromJson2Grid(AJson: string);
var
  LVar: variant;
begin
  LVar := _JSON(StringToUtf8(AJson));
  AddNextGridRowsFromVariant2(IPAddrGrid, LVar);
end;

end.
