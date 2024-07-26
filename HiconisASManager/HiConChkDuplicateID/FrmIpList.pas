unit FrmIpList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, NxColumnClasses, NxColumns,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls,

  mormot.core.variants, mormot.core.unicode, mormot.core.collections,
  mormot.db.sql.oledb, mormot.db.sql, mormot.core.base,
  UnitChkDupIdData;

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
    BitBtn5: TBitBtn;
    PMPM_SIP: TNxTextColumn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
  private
    FIpAddr, FPort, FName: string;
  public
    FIpAddrDic: IKeyValue<string, TIpListRec>;

    function GetIpList2JsonFromGrid(): string;
    function GetIPListFromJson(AJson: string): IList<TIpListRec>;
    function GetIpList2JsonFromDB(ADBFileName: string=''): string;
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

procedure TIPListF.BitBtn5Click(Sender: TObject);
begin
  GetIpList2JsonFromDB();
end;

procedure TIPListF.FormCreate(Sender: TObject);
begin
  FIpAddrDic := Collections.NewKeyValue<string, TIpListRec>;
end;

function TIPListF.GetIpList2JsonFromDB(ADBFileName: string): string;
var
  LProps: TOleDBConnectionProperties;
  LConn: TSQLDBConnection;
  LQuery: TSQLDBStatement;
  LUtf8: RawUtf8;
  LVar: variant;
begin
  if ADBFileName = '' then
    ADBFileName := 'D:\ACONIS-NX\DB\system_bak.accdb';

  LProps := TSqlDBOleDBACEConnectionProperties.Create(ADBFileName,'', '','');//'e:\temp\system_bak.accdb'
  try
    LConn := LProps.NewConnection;
    try
      LConn.Connect;

      LQuery := LConn.NewStatement;
      try
        LQuery.Execute('select RES_NAME, PMPM_PIP, PMPM_SIP from RESOURCE', True);
        LUtf8 := LQuery.FetchAllAsJson(True);
        LVar := _JSON(LUtf8);
        AddNextGridRowsFromVariant2(IPAddrGrid, LVar, True);
      finally
        LQuery.Free;
      end;
    finally
      LConn.Free;
    end;
  finally
    LProps.Free;
  end;
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

end.
