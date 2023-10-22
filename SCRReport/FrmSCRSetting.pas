unit FrmSCRSetting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  JvExExtCtrls, JvImage, JvExControls, JvButton, JvTransparentButton;

type
  TSCRSettingF = class(TForm)
    JvImage1: TJvImage;
    JvTransparentButton1: TJvTransparentButton;
    JvTransparentButton2: TJvTransparentButton;
    JvTransparentButton3: TJvTransparentButton;
    JvTransparentButton4: TJvTransparentButton;
    JvTransparentButton5: TJvTransparentButton;
    procedure JvTransparentButton2Click(Sender: TObject);
    procedure JvTransparentButton1Click(Sender: TObject);
    procedure JvTransparentButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function CreateNShowSCRSetting(AOwner: TComponent): string;
  function CreateNShowSCRSetting2(AOwner: TComponent): TForm;

var
  SCRSettingF: TSCRSettingF;

implementation

uses FrmSCRMESetting, FrmSCRAppSetting, FrmSCRGESetting;

{$R *.dfm}

function CreateNShowSCRSetting(AOwner: TComponent): string;
begin
  Result := '';

  if Assigned(SCRSettingF) then
    FreeAndNil(SCRSettingF);

  SCRSettingF := TSCRSettingF.Create(AOwner);

  try
    if SCRSettingF.ShowModal = mrOK then
    begin
      Result := '';
    end;
  finally
    FreeAndNil(SCRSettingF);
  end;
end;

function CreateNShowSCRSetting2(AOwner: TComponent): TForm;
begin
  if Assigned(SCRSettingF) then
    FreeAndNil(SCRSettingF);

  SCRSettingF := TSCRSettingF.Create(AOwner);
  SCRSettingF.Show;
  Result := SCRSettingF as TForm;
end;

procedure TSCRSettingF.JvTransparentButton1Click(Sender: TObject);
begin
  CreateNShowSCRMESetting(Self as TComponent);
end;

procedure TSCRSettingF.JvTransparentButton2Click(Sender: TObject);
begin
  CreateNShowSCRAppSetting(Self as TComponent);
end;

procedure TSCRSettingF.JvTransparentButton3Click(Sender: TObject);
begin
  CreateNShowSCRGESetting(Self as TComponent);
end;

end.
