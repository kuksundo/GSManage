unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  IdTelnet, IdGlobal, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdIOHandler,

  UnitProcessUtil;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    LogMemo: TMemo;
    ConsoleMemo: TMemo;
    Button3: TButton;
    IdTCPClient1: TIdTCPClient;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure OnResponse(Sender: TIdTelnet; const Buffer: TIdBytes);
  public
    FTCPResponse: TStringList;
  end;

const
  MPM_IP_1 = '10.8.1.11';
var
  Form2: TForm2;

implementation

uses UnitIndyUtil;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  LOutput, LError: TStringList;
begin
  LOutput := TStringList.Create;
  LError := TStringList.Create;
  try
//    GetConsoleOutput2('telnet 10.8.1.41', );
  finally
    LOutput.Free;
    LError.Free;
  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
var
  LTelnet: TIdTelnet;
begin
  LTelnet := TIdTelnet.Create(nil);
  try
    LTelnet.ReadTimeout := 30000;
    LTelnet.OnDataAvailable := OnResponse;
//    LTelnet.OnDisconnected := OnResponse;
//    TIdBytes.OnStatus := OnStatus;
    LTelnet.ThreadedEvent := True;

    LTelnet.Connect('10.8.1.11', 23);
    try
      if not LTelnet.Connected then
        raise Exception.Create('10.8.1.11 telnet connection failed');

      Sleep(2000);

      LTelnet.SendString('root' + #13);
      Sleep(2000);

      LTelnet.SendString('pp 01' + #13);
      Sleep(2000);

    finally
      if LTelnet.Connected then
        LTelnet.Disconnect();
    end;
  finally
    LTelnet.Free;
  end;
end;

procedure TForm2.Button3Click(Sender: TObject);
var
  LIOHandler: TIdIOHandler;
begin
  IdTCPClient1.Connect;
  LIOHandler := IdTCPClient1.IOHandler;

  LIOHandler.WaitFor('login:');
  LIOHandler.WriteLn('root');
  LIOHandler.WaitFor('$');
  LIOHandler.WriteLn('pp 01');
  LIOHandler.WaitFor('Select>>');
  LIOHandler.WriteLn('0');
  LIOHandler.WaitFor('Choice: 0');
//  LIOHandler.WaitFor('------------------------Debug Mode----------------------');

  repeat
    FTCPResponse.Add(LIOHandler.ReadLn(LF, 100));
  until LIOHandler.ReadLnTimedout;

  ConsoleMemo.Lines.Assign(FTCPResponse);
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FTCPResponse.Free;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  IdTCPClient1.Host := MPM_IP_1;
  IdTCPClient1.Port := 23;

  FTCPResponse := TStringList.Create;
end;

procedure TForm2.OnResponse(Sender: TIdTelnet; const Buffer: TIdBytes);
begin
  LogMemo.Lines.Add(IdBytesToString(Buffer));
end;

end.
