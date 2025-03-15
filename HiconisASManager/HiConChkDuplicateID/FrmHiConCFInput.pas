unit FrmHiConCFInput;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  UnitHiConMPMWebUtil;

type
  TCFInputF = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    LocalNameEdit: TEdit;
    Eth0IPEdit: TEdit;
    Eth1GateWayEdit: TEdit;
    Eth0GateWayEdit: TEdit;
    Eth1IPEdit: TEdit;
    Eth1NetMaskEdit: TEdit;
    Eth0NetMaskEdit: TEdit;
    BitBtn5: TBitBtn;
    procedure BitBtn5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function CreateCFInputForm(var ARec: THiConMPMWeb_CFInput): integer;

implementation

{$R *.dfm}

function CreateCFInputForm(var ARec: THiConMPMWeb_CFInput): integer;
var
  CFInputF: TCFInputF;
begin
  Result := -1;

  CFInputF := TCFInputF.Create(nil);
  try
    with CFInputF do
    begin
      LocalNameEdit.Text := ARec.FLocalName;
      Eth0IPEdit.Text := ARec.FEth0IP;
      Eth0NetMaskEdit.Text := ARec.FEth0NetMask;
      Eth0GateWayEdit.Text := ARec.FEth0GateWay;
      Eth1IPEdit.Text := ARec.FEth1IP;
      Eth1GateWayEdit.Text := ARec.FEth1GateWay;
      Eth1NetMaskEdit.Text := ARec.FEth1NetMask;

      Result := ShowModal;

      if Result = mrOK then
      begin
        ARec.FLocalName := LocalNameEdit.Text;
        ARec.FEth0IP := Eth0IPEdit.Text;
        ARec.FEth0NetMask := Eth0NetMaskEdit.Text;
        ARec.FEth0GateWay := Eth0GateWayEdit.Text;
        ARec.FEth1IP := Eth1IPEdit.Text;
        ARec.FEth1GateWay := Eth1GateWayEdit.Text;
        ARec.FEth1NetMask := Eth1NetMaskEdit.Text;
      end;
    end;
  finally
    FreeAndNil(CFInputF);
  end;
end;

procedure TCFInputF.BitBtn5Click(Sender: TObject);
var
  LIP, LGateWay: string;
  LOctetAry: TArray<string>;
begin
  LIP := Eth0IPEdit.Text;

  LOctetAry := LIP.Split(['.']);

  //유효성 검사 : IPv4 주소는 4개의 Octet으로 구성됨
  if Length(LOctetAry)  = 4 then
  begin
    LIP := LOctetAry[0];

    //첫번째 Octet을 변경함
    LOctetAry[0] := IntToStr(StrToIntDef(LIP, 0) + 1);

    //변경된 주소를 다시 조합하여 반환
    Eth1IPEdit.Text := String.Join('.', LOctetAry);

    LOctetAry[3] := '1';
    Eth1GateWayEdit.Text := String.Join('.', LOctetAry);

    LOctetAry[0] := LIP;
    Eth0GateWayEdit.Text := String.Join('.', LOctetAry);

    Eth0NetMaskEdit.Text := '255.255.0.0';
    Eth1NetMaskEdit.Text := '255.255.0.0';
  end;
end;

end.
