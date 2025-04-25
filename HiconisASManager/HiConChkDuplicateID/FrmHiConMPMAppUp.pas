unit FrmHiConMPMAppUp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, JvExControls, JvComCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, HTMLabel;

type
  THiConMPMAppUpF = class(TForm)
    Splitter1: TSplitter;
    HTMLabel1: THTMLabel;
    Panel1: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    FileNameEdit: TEdit;
    BitBtn1: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn5: TBitBtn;
    IPAddress: TJvIPAddress;
    Panel2: TPanel;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Label3: TLabel;
    ServerFolderEdit: TEdit;
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HiConMPMAppUpF: THiConMPMAppUpF;

implementation

uses UnitHiConMPMWebUtil;

{$R *.dfm}

procedure THiConMPMAppUpF.BitBtn1Click(Sender: TObject);
var
  LFileName: string;
begin
  LFileName := FileNameEdit.Text;

  if FileExists(LFileName) then
  begin
      THiConMPMWeb.AppUpMPM(IPAddress.Text, LFileName, ServerFolderEdit.Text);
  end
  else
    ShowMessage('File not found : [' + LFileName + ']');
end;

procedure THiConMPMAppUpF.BitBtn4Click(Sender: TObject);
begin
  OpenDialog1.Filter := 'Any file(*.*)|*.*';

  if OpenDialog1.Execute then
    FileNameEdit.Text := OpenDialog1.FileName;
end;

end.
