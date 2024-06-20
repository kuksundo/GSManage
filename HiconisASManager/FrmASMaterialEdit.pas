unit FrmASMaterialEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  JvExControls, JvLabel, CurvyControls,
  mormot.core.datetime,

  UnitHiconisMasterRecord, AeroButtons, UnitElecServiceData2;

type
  TASMaterialF = class(TForm)
    JvLabel25: TJvLabel;
    JvLabel28: TJvLabel;
    JvLabel29: TJvLabel;
    JvLabel32: TJvLabel;
    JvLabel33: TJvLabel;
    JvLabel57: TJvLabel;
    PORNoEdit: TEdit;
    AWBEdit: TEdit;
    PORIssuePicker: TDateTimePicker;
    DeliveryCompanyEdit: TEdit;
    DeliveryChargeEdit: TEdit;
    ShippingNoEdit: TEdit;
    JvLabel17: TJvLabel;
    MaterialNameEdit: TEdit;
    JvLabel18: TJvLabel;
    SupplyCountEdit: TEdit;
    JvLabel1: TJvLabel;
    UnitPriceEdit: TEdit;
    JvLabel2: TJvLabel;
    LeadTimeEdit: TEdit;
    JvLabel3: TJvLabel;
    PriceAmountEdit: TEdit;
    JvLabel4: TJvLabel;
    FreeOrChargeCB: TComboBox;
    JvLabel5: TJvLabel;
    ReqDeliveryDatePicker: TDateTimePicker;
    JvLabel6: TJvLabel;
    ReqArriveDatePicker: TDateTimePicker;
    JvLabel7: TJvLabel;
    StoreAddressEdit: TEdit;
    JvLabel8: TJvLabel;
    PortNameEdit: TEdit;
    JvLabel9: TJvLabel;
    DeliveryKindCB: TComboBox;
    JvLabel10: TJvLabel;
    TermOfDeliveryEdit: TEdit;
    JvLabel11: TJvLabel;
    NetWeightEdit: TEdit;
    JvLabel12: TJvLabel;
    GrossWeightEdit: TEdit;
    JvLabel13: TJvLabel;
    MeasurementEdit: TEdit;
    JvLabel14: TJvLabel;
    CBMEdit: TEdit;
    JvLabel15: TJvLabel;
    NumOfPkgEdit: TEdit;
    JvLabel26: TJvLabel;
    JvLabel27: TJvLabel;
    MaterialCodeListMemo: TMemo;
    DeliveryAddressMemo: TMemo;
    CurvyPanel1: TCurvyPanel;
    btn_Close: TAeroButton;
    AeroButton1: TAeroButton;

    procedure FormCreate(Sender: TObject);
  private
    procedure InitEnum;
    procedure InitCombo;
  public
    procedure LoadMaterialOrm2Form(AMaterial4Project: TSQLMaterial4Project);
    procedure LoadMaterialOrmFromForm(AMaterial4Project: TSQLMaterial4Project);
    procedure LoadMaterialVar2Form(AVar: variant);
    procedure LoadMaterialVarFromForm(var AVar: variant);
  end;

  function DisplayMaterial2EditForm(var ADoc: variant): Boolean;

var
  ASMaterialF: TASMaterialF;

implementation

{$R *.dfm}

function DisplayMaterial2EditForm(var ADoc: variant): Boolean;
var
  LASMaterialF: TASMaterialF;
begin
  LASMaterialF := TASMaterialF.Create(nil);
  try
    with LASMaterialF do
    begin
      if ADoc.PorNo = '' then
      begin
        Caption := Caption + ' (New)';
      end
      else
      begin
        Caption := Caption + ' (Update)';
        LoadMaterialVar2Form(ADoc);
      end;

      //"저장" 버튼을 누른 경우
      if ShowModal = mrOK then
      begin
        LoadMaterialVarFromForm(ADoc);

        Result := True;
      end;
    end;
  finally
    LASMaterialF.Free;
  end;

end;

{ TASMaterialF }

procedure TASMaterialF.FormCreate(Sender: TObject);
begin
  InitEnum();
  InitCombo();
end;

procedure TASMaterialF.InitCombo;
begin
  g_FreeOrCharge.SetType2Combo(FreeOrChargeCB);
  g_DeliveryKind.SetType2Combo(DeliveryKindCB);
end;

procedure TASMaterialF.InitEnum;
begin
  g_FreeOrCharge.InitArrayRecord(R_FreeOrCharge);
  g_DeliveryKind.InitArrayRecord(R_DeliveryKind);
end;

procedure TASMaterialF.LoadMaterialOrm2Form(
  AMaterial4Project: TSQLMaterial4Project);
begin
  PORNoEdit.Text := AMaterial4Project.PORNo;
  MaterialNameEdit.Text := AMaterial4Project.MaterialName;
  PORIssuePicker.Date := TimeLogToDateTime(AMaterial4Project.PORIssueDate);
  LeadTimeEdit.Text := IntToStr(AMaterial4Project.LeadTime);
  FreeOrChargeCB.ItemIndex := AMaterial4Project.FreeOrCharge;
  SupplyCountEdit.Text := IntToStr(AMaterial4Project.SupplyCount);
  UnitPriceEdit.Text := AMaterial4Project.UnitPrice;
  PriceAmountEdit.Text := IntToStr(AMaterial4Project.PriceAmount);
  ReqDeliveryDatePicker.Date := TimeLogToDateTime(AMaterial4Project.ReqDeliveryDate);
  ReqArriveDatePicker.Date := TimeLogToDateTime(AMaterial4Project.ReqArriveDate);
  DeliveryKindCB.ItemIndex := AMaterial4Project.DeliveryKind;
  StoreAddressEdit.Text := AMaterial4Project.StoreAddress;
  PortNameEdit.Text := AMaterial4Project.PortName;
  ShippingNoEdit.Text := AMaterial4Project.ShippingNo;
  DeliveryChargeEdit.Text := AMaterial4Project.DeliveryCharge;
  DeliveryCompanyEdit.Text := AMaterial4Project.DeliveryCompany;
  TermOfDeliveryEdit.Text := AMaterial4Project.TermOfDelivery;
  NetWeightEdit.Text := AMaterial4Project.NetWeight;
  GrossWeightEdit.Text := AMaterial4Project.GrossWeight;
  MeasurementEdit.Text := AMaterial4Project.Measurement;
  CBMEdit.Text := AMaterial4Project.CBM;
  AWBEdit.Text := AMaterial4Project.AirWayBill;
  NumOfPkgEdit.Text := AMaterial4Project.NumOfPkg;
  MaterialCodeListMemo.Text := AMaterial4Project.MaterialCodeList;
  DeliveryAddressMemo.Text := AMaterial4Project.DeliveryAddress;
end;

procedure TASMaterialF.LoadMaterialOrmFromForm(
  AMaterial4Project: TSQLMaterial4Project);
begin
  AMaterial4Project.PORNo := PORNoEdit.Text;
  AMaterial4Project.MaterialName := MaterialNameEdit.Text;
  AMaterial4Project.PORIssueDate := TimeLogFromDateTime(PORIssuePicker.Date);
  AMaterial4Project.LeadTime := StrToIntDef(LeadTimeEdit.Text, 0);
  AMaterial4Project.FreeOrCharge := FreeOrChargeCB.ItemIndex;
  AMaterial4Project.SupplyCount := StrToIntDef(SupplyCountEdit.Text, 0);
  AMaterial4Project.UnitPrice := UnitPriceEdit.Text;
  AMaterial4Project.PriceAmount := StrToIntDef(PriceAmountEdit.Text, 0);
  AMaterial4Project.ReqDeliveryDate := TimeLogFromDateTime(ReqDeliveryDatePicker.Date);
  AMaterial4Project.ReqArriveDate := TimeLogFromDateTime(ReqArriveDatePicker.Date);
  AMaterial4Project.DeliveryKind := DeliveryKindCB.ItemIndex;
  AMaterial4Project.StoreAddress := StoreAddressEdit.Text;
  AMaterial4Project.PortName := PortNameEdit.Text;
  AMaterial4Project.ShippingNo := ShippingNoEdit.Text;
  AMaterial4Project.DeliveryCharge := DeliveryChargeEdit.Text;
  AMaterial4Project.DeliveryCompany := DeliveryCompanyEdit.Text;
  AMaterial4Project.TermOfDelivery := TermOfDeliveryEdit.Text;
  AMaterial4Project.NetWeight := NetWeightEdit.Text;
  AMaterial4Project.GrossWeight := GrossWeightEdit.Text;
  AMaterial4Project.Measurement := MeasurementEdit.Text;
  AMaterial4Project.CBM := CBMEdit.Text;
  AMaterial4Project.AirWayBill := AWBEdit.Text;
  AMaterial4Project.NumOfPkg := NumOfPkgEdit.Text;
  AMaterial4Project.MaterialCodeList := MaterialCodeListMemo.Text;
  AMaterial4Project.DeliveryAddress := DeliveryAddressMemo.Text;
end;

procedure TASMaterialF.LoadMaterialVar2Form(AVar: variant);
begin
  PORNoEdit.Text := AVar.PORNo;
  MaterialNameEdit.Text := AVar.MaterialName;
  PORIssuePicker.Date := TimeLogToDateTime(AVar.PORIssueDate);//VarToDateTime(AVar.PORIssueDate);
  LeadTimeEdit.Text := IntToStr(AVar.LeadTime);
  FreeOrChargeCB.ItemIndex := g_FreeOrCharge.ToOrdinal(AVar.FreeOrCharge);
  SupplyCountEdit.Text := IntToStr(AVar.SupplyCount);
  UnitPriceEdit.Text := AVar.UnitPrice;
  PriceAmountEdit.Text := AVar.PriceAmount;
  ReqDeliveryDatePicker.Date := TimeLogToDateTime(AVar.ReqDeliveryDate);//VarToDateTime(AVar.ReqDeliveryDate);
  ReqArriveDatePicker.Date := TimeLogToDateTime(AVar.ReqArriveDate);
  DeliveryKindCB.ItemIndex := g_DeliveryKind.ToOrdinal(AVar.DeliveryKind);
  StoreAddressEdit.Text := AVar.StoreAddress;
  PortNameEdit.Text := AVar.PortName;
  ShippingNoEdit.Text := AVar.ShippingNo;
  DeliveryChargeEdit.Text := AVar.DeliveryCharge;
  DeliveryCompanyEdit.Text := AVar.DeliveryCompany;
  TermOfDeliveryEdit.Text := AVar.TermOfDelivery;
  NetWeightEdit.Text := AVar.NetWeight;
  GrossWeightEdit.Text := AVar.GrossWeight;
  MeasurementEdit.Text := AVar.Measurement;
  CBMEdit.Text := AVar.CBM;
  AWBEdit.Text := AVar.AirWayBill;
  NumOfPkgEdit.Text := AVar.NumOfPkg;
  MaterialCodeListMemo.Text := AVar.MaterialCodeList;
  DeliveryAddressMemo.Text := AVar.DeliveryAddress;
end;

procedure TASMaterialF.LoadMaterialVarFromForm(var AVar: variant);
begin
  AVar.PORNo := PORNoEdit.Text;
  AVar.MaterialName := MaterialNameEdit.Text;
  AVar.PORIssueDate := TimeLogFromDateTime(PORIssuePicker.Date);
  AVar.LeadTime := StrToIntDef(LeadTimeEdit.Text, 0);
  AVar.FreeOrCharge := g_FreeOrCharge.ToString(FreeOrChargeCB.ItemIndex);
  AVar.SupplyCount := StrToIntDef(SupplyCountEdit.Text, 0);
  AVar.UnitPrice := UnitPriceEdit.Text;
  AVar.PriceAmount := PriceAmountEdit.Text;
  AVar.ReqDeliveryDate := TimeLogFromDateTime(ReqDeliveryDatePicker.Date);
  AVar.ReqArriveDate := TimeLogFromDateTime(ReqArriveDatePicker.Date);
  AVar.DeliveryKind := g_DeliveryKind.ToString(DeliveryKindCB.ItemIndex);
  AVar.StoreAddress := StoreAddressEdit.Text;
  AVar.PortName := PortNameEdit.Text;
  AVar.ShippingNo := ShippingNoEdit.Text;
  AVar.DeliveryCharge := DeliveryChargeEdit.Text;
  AVar.DeliveryCompany := DeliveryCompanyEdit.Text;
  AVar.TermOfDelivery := TermOfDeliveryEdit.Text;
  AVar.NetWeight := NetWeightEdit.Text;
  AVar.GrossWeight := GrossWeightEdit.Text;
  AVar.Measurement := MeasurementEdit.Text;
  AVar.CBM := CBMEdit.Text;
  AVar.AirWayBill := AWBEdit.Text;
  AVar.NumOfPkg := NumOfPkgEdit.Text;
  AVar.MaterialCodeList := MaterialCodeListMemo.Text;
  AVar.DeliveryAddress := DeliveryAddressMemo.Text;
end;

end.
