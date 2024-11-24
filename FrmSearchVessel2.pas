unit FrmSearchVessel2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, NxColumnClasses, NxColumns,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid, Vcl.StdCtrls,
  JvExControls, JvLabel, Vcl.Buttons, Vcl.ExtCtrls,
  mormot.core.datetime,
  UnitVesselMasterRecord2;

type
  TSearchVesselF = class(TForm)
    Panel1: TPanel;
    SearchButton: TButton;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    JvLabel5: TJvLabel;
    HullNoEdit: TEdit;
    JvLabel6: TJvLabel;
    ShipNameEdit: TEdit;
    JvLabel9: TJvLabel;
    ImoNoEdit: TEdit;
    VesselListGrid: TNextGrid;
    NxIncrementColumn1: TNxIncrementColumn;
    HullNo: TNxTextColumn;
    ShipName: TNxTextColumn;
    ImoNo: TNxTextColumn;
    SClass1: TNxTextColumn;
    ShipType: TNxTextColumn;
    OwnerName: TNxTextColumn;
    DeliveryDate: TNxTextColumn;
    ShipBuilderName: TNxTextColumn;
    ShipTypeDesc: TNxTextColumn;
    VesselStatus: TNxTextColumn;
    DockingSurveyDueDate: TNxDateColumn;
    SpecialSurveyDueDate: TNxDateColumn;
    LastDryDockDate: TNxTextColumn;
    SClass2: TNxTextColumn;
    OwnerID: TNxTextColumn;
    TechManagerCountry: TNxTextColumn;
    TechManagerID: TNxTextColumn;
    OperatorID: TNxTextColumn;
    BuyingCompanyCountry: TNxTextColumn;
    BuyingCompanyID: TNxTextColumn;
    procedure VesselListGridCellDblClick(Sender: TObject; ACol, ARow: Integer);
    procedure SearchButtonClick(Sender: TObject);
    procedure HullNoEditKeyPress(Sender: TObject; var Key: Char);
    procedure ShipNameEditKeyPress(Sender: TObject; var Key: Char);
    procedure ImoNoEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
  private
    procedure DestroyList4VesselMaster;
    procedure ExecuteSearch(Key: Char);
  public
    procedure GetVesselListFromVariant2Grid(ADoc: Variant);
    procedure GetVesselSearchParam2Rec(var AVesselSearchParamRec: TVesselSearchParamRec);
    procedure GetVesselList2Grid;
  end;

  function ShowSearchVesselForm(var AVesselSearchParamRec: TVesselSearchParamRec): integer;

var
  SearchVesselF: TSearchVesselF;

implementation

uses CommonData2, UnitVesselData2, UnitFolderUtil2;

{$R *.dfm}

function ShowSearchVesselForm(var AVesselSearchParamRec: TVesselSearchParamRec): integer;
var
  LSearchVesselF: TSearchVesselF;
begin
  Result := mrNone;

  LSearchVesselF := TSearchVesselF.Create(nil);
  try
    LSearchVesselF.HullNoEdit.Text := AVesselSearchParamRec.fHullNo;
    LSearchVesselF.ShipNameEdit.Text := AVesselSearchParamRec.fShipName;

    Result := LSearchVesselF.ShowModal;

    if Result = mrOK then
    begin
      if LSearchVesselF.VesselListGrid.SelectedRow <> -1 then
      begin
        AVesselSearchParamRec.fHullNo := LSearchVesselF.VesselListGrid.CellsByName['HullNo',LSearchVesselF.VesselListGrid.SelectedRow];
        AVesselSearchParamRec.fShipName := LSearchVesselF.VesselListGrid.CellsByName['ShipName',LSearchVesselF.VesselListGrid.SelectedRow];
        AVesselSearchParamRec.fShipType := LSearchVesselF.VesselListGrid.CellsByName['ShipType',LSearchVesselF.VesselListGrid.SelectedRow];
        AVesselSearchParamRec.fShipBuilderName := LSearchVesselF.VesselListGrid.CellsByName['ShipBuilderName',LSearchVesselF.VesselListGrid.SelectedRow];
      end;
    end;
  finally
    LSearchVesselF.Free;
  end;
end;

{ TSearchVesselF }

procedure TSearchVesselF.DestroyList4VesselMaster;
var
  LRow: integer;
begin
  for LRow := 0 to VesselListGrid.RowCount - 1 do
  begin
    TList4VesselMaster(VesselListGrid.Row[LRow].Data).Free;
  end;
end;

procedure TSearchVesselF.ExecuteSearch(Key: Char);
begin
  if Key = Chr(VK_RETURN) then
    SearchButtonClick(nil);
end;

procedure TSearchVesselF.FormDestroy(Sender: TObject);
begin
  DestroyList4VesselMaster;
end;

procedure TSearchVesselF.GetVesselList2Grid;
var
  LSQLVesselMaster: TSQLVesselMaster;
  LVesselSearchParamRec: TVesselSearchParamRec;
  LDoc: Variant;
  LStr: string;
begin
  if not Assigned(g_VesselMasterDB) then
  begin
    LStr := GetSubFolderPath(ExtractFilePath(Application.ExeName), 'db');
    InitVesselMasterClient(LStr+'VesselList.sqlite');
  end;

  VesselListGrid.BeginUpdate;
  try
    VesselListGrid.ClearRows;
    GetVesselSearchParam2Rec(LVesselSearchParamRec);
    LSQLVesselMaster := GetVesselMasterFromSearchRec(LVesselSearchParamRec);
    try
      if LSQLVesselMaster.IsUpdate then
      begin
        DestroyList4VesselMaster;

//        LDoc := GetVariantFromVesselMaster(LSQLVesselMaster);
//        GetVesselListFromVariant2Grid(LDoc);
        LSQLVesselMaster.FillRewind;

        while LSQLVesselMaster.FillOne do
        begin
          LDoc := GetVariantFromVesselMaster(LSQLVesselMaster);
          GetVesselListFromVariant2Grid(LDoc);
        end;//while
      end;
    finally
      LSQLVesselMaster.Free;
    end;
  finally
    VesselListGrid.EndUpdate;
  end;
end;

procedure TSearchVesselF.GetVesselListFromVariant2Grid(ADoc: Variant);
var
  LRow: integer;
begin
  LRow := VesselListGrid.AddRow;

  VesselListGrid.Row[LRow].Data := TList4VesselMaster.Create;
  TList4VesselMaster(VesselListGrid.Row[LRow].Data).TaskId := ADoc.TaskID;
  TList4VesselMaster(VesselListGrid.Row[LRow].Data).HullNo := ADoc.HullNo;
  TList4VesselMaster(VesselListGrid.Row[LRow].Data).ShipName := ADoc.ShipName;
  TList4VesselMaster(VesselListGrid.Row[LRow].Data).ImoNo := ADoc.ImoNo;

  VesselListGrid.CellsByName['HullNo', LRow] := ADoc.HullNo;
  VesselListGrid.CellsByName['ShipName', LRow] := ADoc.ShipName;
  VesselListGrid.CellsByName['ImoNo', LRow] := ADoc.ImoNo;
  VesselListGrid.CellsByName['SClass1', LRow] := ADoc.SClass1;
  VesselListGrid.CellsByName['ShipType', LRow] := ADoc.ShipType;
  VesselListGrid.CellsByName['OwnerName', LRow] := ADoc.OwnerName;
  VesselListGrid.CellsByName['ShipBuilderName', LRow] := ADoc.ShipBuilderName;
  VesselListGrid.CellsByName['VesselStatus', LRow] := ADoc.VesselStatus;
  VesselListGrid.CellsByName['SClass2', LRow] := ADoc.SClass2;
  VesselListGrid.CellsByName['OwnerID', LRow] := ADoc.OwnerID;
  VesselListGrid.CellsByName['TechManagerCountry', LRow] := ADoc.TechManagerCountry;
  VesselListGrid.CellsByName['TechManagerID', LRow] := ADoc.TechManagerID;
  VesselListGrid.CellsByName['OperatorID', LRow] := ADoc.OperatorID;
  VesselListGrid.CellsByName['BuyingCompanyCountry', LRow] := ADoc.BuyingCompanyCountry;
  VesselListGrid.CellsByName['BuyingCompanyID', LRow] := ADoc.BuyingCompanyID;
  VesselListGrid.CellsByName['DeliveryDate', LRow] := DateTimeToStr(TimeLogToDateTime(ADoc.DeliveryDate));
  VesselListGrid.CellsByName['LastDryDockDate', LRow] := ADoc.LastDryDockDate;
  VesselListGrid.CellsByName['ShipTypeDesc', LRow] := ADoc.ShipTypeDesc;
  VesselListGrid.CellByName['SpecialSurveyDueDate', LRow].AsDateTime := TimeLogToDateTime(ADoc.SpecialSurveyDueDate);
  VesselListGrid.CellByName['DockingSurveyDueDate', LRow].AsDateTime := TimeLogToDateTime(ADoc.DockingSurveyDueDate);
end;

procedure TSearchVesselF.GetVesselSearchParam2Rec(
  var AVesselSearchParamRec: TVesselSearchParamRec);
begin
  AVesselSearchParamRec.fQueryDate := vqdtNull;
  AVesselSearchParamRec.fHullNo := Trim(HullNoEdit.Text);
  AVesselSearchParamRec.fShipName := Trim(ShipNameEdit.Text);
  AVesselSearchParamRec.fIMONo := Trim(ImoNoEdit.Text);
end;

procedure TSearchVesselF.HullNoEditKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteSearch(Key);
end;

procedure TSearchVesselF.ImoNoEditKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteSearch(Key);
end;

procedure TSearchVesselF.SearchButtonClick(Sender: TObject);
begin
  GetVesselList2Grid;
end;

procedure TSearchVesselF.ShipNameEditKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteSearch(Key);
end;

procedure TSearchVesselF.VesselListGridCellDblClick(Sender: TObject; ACol,
  ARow: Integer);
begin
  ModalResult := mrOK;
end;

end.
