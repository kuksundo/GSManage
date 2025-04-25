unit FrmHiConMPMAppDown;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, JvExControls, JvComCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, HTMLabel,

  mormot.core.buffers;

type
  THiConMPMAppDownF = class(TForm)
    Splitter1: TSplitter;
    HTMLabel1: THTMLabel;
    Panel1: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    DefaultFolderEdit: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    IPAddress: TJvIPAddress;
    Panel2: TPanel;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    DownloadFileEdit: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure WMCopyData(var Msg: TMessage); message WM_COPYDATA;

    procedure ProcessAsyncResult(const AMsg: string; const AMsgKind: integer);
  public
    procedure Log(const AMsg: string; const AMsgKind: integer=1);
  end;

function CreateHiConMPMAppDownForm(AIpAddr: string): integer;

implementation

uses UnitHiConMPMWebUtil, UnitStringUtil;

{$R *.dfm}

{ TForm1 }

function CreateHiConMPMAppDownForm(AIpAddr: string): integer;
var
  HiConMPMAppDownF: THiConMPMAppDownF;
begin
  Result := -1;

  HiConMPMAppDownF := THiConMPMAppDownF.Create(nil);
  try
    with HiConMPMAppDownF do
    begin
      IPAddress.Text := StrToken(AIpAddr, ';');;

      Result := ShowModal;

      if Result = mrOK then
      begin
      end;
    end;
  finally
    FreeAndNil(HiConMPMAppDownF);
  end;
end;

procedure THiConMPMAppDownF.BitBtn1Click(Sender: TObject);
var
  LFileName, LIPList: string;
begin
  LIPList := IPAddress.Text + ';';
  LFileName := DefaultFolderEdit.Text + DownloadFileEdit.Text;

  THiConMPMWeb.AppDownMPM(LIPList, LFileName);
end;

procedure THiConMPMAppDownF.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure THiConMPMAppDownF.Log(const AMsg: string; const AMsgKind: integer);
begin

end;

procedure THiConMPMAppDownF.ProcessAsyncResult(const AMsg: string;
  const AMsgKind: integer);
begin

end;

procedure THiConMPMAppDownF.WMCopyData(var Msg: TMessage);
begin

end;

end.
