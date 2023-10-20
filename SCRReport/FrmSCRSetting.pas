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
    procedure JvTransparentButton2Click(Sender: TObject);
    procedure JvTransparentButton1Click(Sender: TObject);
    procedure JvTransparentButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SCRSettingF: TSCRSettingF;

implementation

uses FrmSCRMESetting, FrmSCRAppSetting, FrmSCRGESetting;

{$R *.dfm}

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
