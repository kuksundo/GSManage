unit FrmResPortInfo4INFTag;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, JvExControls, JvLabel,
  Vcl.Buttons, Vcl.ExtCtrls,
  mormot.core.variants;

type
  TResPortInfo4INFTagF = class(TForm)
    JvLabel18: TJvLabel;
    RESOURCE: TEdit;
    JvLabel1: TJvLabel;
    Port: TEdit;
    JvLabel2: TJvLabel;
    ADDR: TEdit;
    JvLabel3: TJvLabel;
    SUB_POS: TEdit;
    JvLabel4: TJvLabel;
    SLOT: TEdit;
    JvLabel5: TJvLabel;
    IPAddr1: TEdit;
    IPAddr2: TEdit;
    JvLabel6: TJvLabel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    JvLabel7: TJvLabel;
    DIR: TEdit;
    JvLabel8: TJvLabel;
    FTYPE: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function CreateNShowDateSeletForm(AResPortInfoJson: string): integer;

var
  ResPortInfo4INFTagF: TResPortInfo4INFTagF;

implementation

uses UnitRttiUtil2;

{$R *.dfm}

function CreateNShowDateSeletForm(AResPortInfoJson: string): integer;
var
  LResPortInfo4INFTagF: TResPortInfo4INFTagF;
begin
  LResPortInfo4INFTagF := TResPortInfo4INFTagF.Create(nil);
  SetCompNameValueFromJson2FormByClassType(LResPortInfo4INFTagF, AResPortInfoJson);

  with LResPortInfo4INFTagF do
  begin
    Result := ShowModal;

    if Result = mrOK then
    begin
    end;

    Free;
  end;
end;

end.
