unit FrmHiSvcManage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses FrmWinServiceEdit, UnitServiceUtil, uServiceManager, SvcUtils.Types, SvcUtils.Contract, SvcUtils.IntF;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  LServiceState: TServiceState;
  LJson: string;
begin
//  LServiceState := GetServiceStateByName('W32Time');
//  ShowMessage(LServiceState.ToString);
  LJson := GetServiceInfo2JsonByName('W32Time');
  ShowWinServiceEditForm(LJson);
end;

end.
