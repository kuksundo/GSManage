unit FrmHiConMPMRestore;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, JvExStdCtrls, JvRichEdit,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid, Vcl.Menus,
  mormot.core.base, mormot.core.variants, mormot.core.unicode,
  UnitHiconDBData, UnitHiconTCPIniConfig, JvExControls, JvComCtrls, HTMLabel;

type
  THiConMPMRestoreF = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    FileNameEdit: TEdit;
    BitBtn1: TBitBtn;
    BitBtn4: TBitBtn;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn5: TBitBtn;
    IPAddress: TJvIPAddress;
    Label1: TLabel;
    HTMLabel1: THTMLabel;
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure WMCopyData(var Msg: TMessage); message WM_COPYDATA;

    procedure ProcessAsyncResult(const AMsg: string; const AMsgKind: integer);
  public
    procedure Log(const AMsg: string; const AMsgKind: integer=1);
  end;

function CreateHiConMPMRestoreForm(AIpAddr: string): integer;

implementation

uses UnitComponentUtil, UnitHiconSystemDBUtil, UnitHiConMPMWebUtil,
  UnitCopyData, UnitStringUtil,
  FrmElapsedTime;

{$R *.dfm}

function CreateHiConMPMRestoreForm(AIpAddr: string): integer;
var
  HiConMPMRestoreF: THiConMPMRestoreF;
begin
  Result := -1;

  HiConMPMRestoreF := THiConMPMRestoreF.Create(nil);
  try
    with HiConMPMRestoreF do
    begin
      IPAddress.Text := StrToken(AIpAddr, ';');;

      Result := ShowModal;

      if Result = mrOK then
      begin
      end;
    end;
  finally
    FreeAndNil(HiConMPMRestoreF);
  end;
end;

procedure THiConMPMRestoreF.BitBtn1Click(Sender: TObject);
var
  LFileName: string;
begin
  LFileName := FileNameEdit.Text;

  if FileExists(LFileName) then
  begin
    if UpperCase(ExtractFileExt(LFileName)) = '.TGZ'  then
      THiConMPMWeb.PostRestoreFile2MPMAsync_mORMot(Handle, IPAddress.Text, LFileName)
    else
      ShowMessage('File extention is not *.tgz');
  end
  else
    ShowMessage('File not found : [' + LFileName + ']');
end;

procedure THiConMPMRestoreF.BitBtn4Click(Sender: TObject);
begin
  OpenDialog1.Filter := 'tgz files(*.tgz)|*.tgz|Any file(*.*)|*.*';

  if OpenDialog1.Execute then
    FileNameEdit.Text := OpenDialog1.FileName;
end;

procedure THiConMPMRestoreF.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure THiConMPMRestoreF.Log(const AMsg: string; const AMsgKind: integer);
begin
  case AMsgKind of
    1: HTMLabel1.HTMLText.Text := AMsg;
  end;
end;

procedure THiConMPMRestoreF.ProcessAsyncResult(const AMsg: string;
  const AMsgKind: integer);
begin
  case AMsgKind of
    1: begin
      Log(AMsg,1);
    end;
    //THiConMPMWeb.PostRestoreFile2MPMAsync_xx 결과 처리
    //Restore File(*.tgz)이 MPM-> /tmp에 복사된 상태임
    2: begin
      if AMsg <> '' then
      begin
        //AMsg 내에 '200' 이 존재하면 Next Step 을 진행 함
        if THiConMPMWeb.CheckIfValid4PostRestoreFileReturnHtml(AMsg) then
          THiConMPMWeb.GetHtmlAfterPostRestoreMPMAsync(Handle, IPAddress.Text)
        else
          Log('Invalid Html is returned from PostRestoreFile2MPMAsync_mORMot : ' + #13#10 + AMsg,1);
      end;
    end;
    //THiConMPMWeb.GetHtmlAfterPostRestoreMPMAsync 결과 처리
    //AMsg : Backup File : /tmp/COM01121.tgz
    //       Warning !!!
    //       Restore will stop logic and io control!
    //       and Mastership role will be changed to Slave.!
    3: begin
      if AMsg <> '' then
      begin
        //AMsg 내에 COM01121.tgz 이 존재 하면 Next Step 을 진행 함
        if THiConMPMWeb.CheckIfValid4AfterPostRestoreReturnHtml(AMsg, ExtractFileName(FileNameEdit.Text)) then
          THiConMPMWeb.UpdatePostedFileFromHtmlMPMAsync(Handle, IPAddress.Text, AMsg)
        else
          Log('Invalid Html is returned from GetHtmlAfterPostRestoreMPMAsync : ' + #13#10 + AMsg,1);
      end;
    end;
    //THiConMPMWeb.UpdatePostedFileFromHtmlMPMAsync 결과 처리
    4: begin
      if AMsg <> '' then
      begin
         //AMsg 내에 'System reboot will stop logic and io control!' 이 존재하면 True
        if THiConMPMWeb.CheckIfValid4UpdatePostedFileReturnHtml(AMsg) then
          THiConMPMWeb.Reboot4RestoreMPMAsync(Handle, IPAddress.Text, AMsg)
        else
          Log('Invalid Html is returned from UpdatePostedFileFromHtmlMPMAsync : ' + #13#10 + AMsg,1);
      end;
    end;
  end;
end;

procedure THiConMPMRestoreF.WMCopyData(var Msg: TMessage);
var
  LMsg: string;
begin
  LMsg := PChar(PCopyDataStruct(Msg.LParam)^.lpData);

  ProcessAsyncResult(LMsg, Msg.WParam);
end;

end.
