unit FrmTagInputEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  JvBaseDlg, JvSelectDirectory;

type
  TTagEditF = class(TForm)
    Label1: TLabel;
    InputEdit: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    InputEdit2: TEdit;
    RadioGroup1: TRadioGroup;
    BitBtn3: TBitBtn;
    JvSelectDirectory1: TJvSelectDirectory;
    Label3: TLabel;
    procedure RadioGroup1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function CreateTagInputEdit(const ACaption, ALabel, ADefault, ALabel2, ADefault2: string): string;

var
  TagEditF: TTagEditF;

implementation

{$R *.dfm}

function CreateTagInputEdit(const ACaption, ALabel, ADefault, ALabel2, ADefault2: string): string;
begin
  Result := '';

  if Assigned(TagEditF) then
    FreeAndNil(TagEditF);

  TagEditF := TTagEditF.Create(nil);
  try
    with TagEditF do
    begin
      if ACaption <> '' then
        Caption := ACaption;

      if ALabel <> '' then
        Label1.Caption := ALabel;

      InputEdit.Text := ADefault;

      if ALabel2 <> '' then
        Label2.Caption := ALabel2;

      InputEdit2.Text := ADefault2;

      if ShowModal = mrOK then
      begin
        Result := InputEdit.Text + ';' + IntToStr(RadioGroup1.ItemIndex) + ';' + InputEdit2.Text;
      end;
    end;
  finally
    FreeAndNil(TagEditF);
  end;
end;

procedure TTagEditF.BitBtn3Click(Sender: TObject);
begin
  if JvSelectDirectory1.Execute then
  begin
    InputEdit2.Text := JvSelectDirectory1.Directory;
  end;
end;

procedure TTagEditF.RadioGroup1Click(Sender: TObject);
begin
  case RadioGroup1.ItemIndex of
    0,
    1: begin
      Label2.Caption := 'Base Dir';
      BitBtn3.Visible := True;
    end;
    2: begin
      Label2.Caption := 'IP Address';
      BitBtn3.Visible := False;
    end;
  end;
end;

end.
