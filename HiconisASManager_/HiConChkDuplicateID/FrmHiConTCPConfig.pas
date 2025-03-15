unit FrmHiConTCPConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  THiConTCPConfigF = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    TagNameEdit: TEdit;
    SystemDBEdit: TEdit;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    ComboBox1: TComboBox;
    Label3: TLabel;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HiConTCPConfigF: THiConTCPConfigF;

implementation

{$R *.dfm}

end.
