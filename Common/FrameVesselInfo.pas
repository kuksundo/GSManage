unit FrameVesselInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  AdvEdit, AdvEdBtn, JvExControls, JvLabel, Vcl.ExtCtrls,
  UnitVesselMasterRecord2;

type
  TVesselInfoFr = class(TFrame)
    Panel4: TPanel;
    JvLabel7: TJvLabel;
    JvLabel6: TJvLabel;
    JvLabel3: TJvLabel;
    JvLabel4: TJvLabel;
    JvLabel5: TJvLabel;
    JvLabel8: TJvLabel;
    ShipOwner: TEdit;
    HullNo: TAdvEditBtn;
    ShipName: TEdit;
    ProjectNo: TAdvEditBtn;
    BitBtn1: TBitBtn;
    ClassSociety: TEdit;
    ShipType: TEdit;
    procedure HullNoClickBtn(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses UnitClipBoardUtil,
  FrmSearchVessel2;

{$R *.dfm}

procedure TVesselInfoFr.BitBtn1Click(Sender: TObject);
begin
  Content2Clipboard(HullNo.Text);
end;

procedure TVesselInfoFr.HullNoClickBtn(Sender: TObject);
var
  LVesselSearchParamRec: TVesselSearchParamRec;
begin
  LVesselSearchParamRec.fHullNo := HullNo.Text;
  LVesselSearchParamRec.fShipName := ShipName.Text;

  if ShowSearchVesselForm(LVesselSearchParamRec) = mrOK then
  begin
    HullNo.Text := LVesselSearchParamRec.fHullNo;
    ShipName.Text := LVesselSearchParamRec.fShipName;
    ShipType.Text := LVesselSearchParamRec.fShipType;
  end;
end;

end.
