unit FrmSCRAppSetting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  JvExExtCtrls, JvImage, AdvGraphicCheckLabel, AdvPageControl, Vcl.ComCtrls,
  JvExControls, JvButton, JvTransparentButton, DragDrop, DropTarget,
  DragDropText, UDragDropFormat_SCRParam, Vcl.Menus;

type
  TSCRAppSettingF = class(TForm)
    JvImage1: TJvImage;
    AdvPageControl1: TAdvPageControl;
    AdvTabSheet1: TAdvTabSheet;
    AdvTabSheet2: TAdvTabSheet;
    JvImage2: TJvImage;
    JvImage3: TJvImage;
    AdvTabSheet3: TAdvTabSheet;
    JvImage4: TJvImage;
    AdvTabSheet4: TAdvTabSheet;
    AdvTabSheet5: TAdvTabSheet;
    AdvTabSheet6: TAdvTabSheet;
    JvImage5: TJvImage;
    JvImage6: TJvImage;
    JvImage7: TJvImage;
    AdvGraphicCheckLabel1: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel2: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel3: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel4: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel5: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel6: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel7: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel8: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel9: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel10: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel11: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel12: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel13: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel14: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel15: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel16: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel17: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel18: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel19: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel20: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel21: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel22: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel23: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel24: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel25: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel26: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel27: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel28: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel29: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel30: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel31: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel32: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel33: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel34: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel35: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel36: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel37: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel38: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel39: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel40: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel41: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel42: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel43: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel44: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel45: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel46: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel47: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel48: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel49: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel50: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel51: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel52: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel53: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel54: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel55: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel56: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel57: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel58: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel59: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel60: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel61: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel62: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel63: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel64: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel65: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel66: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel67: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel68: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel69: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel70: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel71: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel72: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel73: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel74: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel75: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel76: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel77: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel78: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel79: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel80: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel81: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel82: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel83: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel84: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel85: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel86: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel87: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel88: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel89: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel90: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel91: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel92: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel93: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel94: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel95: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel96: TAdvGraphicCheckLabel;
    JvTransparentButton1: TJvTransparentButton;
    DropTextTarget1: TDropTextTarget;
    PopupMenu1: TPopupMenu;
    Save2DFM1: TMenuItem;
    JvTransparentButton4: TJvTransparentButton;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DropTextTarget1Drop(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
    procedure Save2DFM1Click(Sender: TObject);
  private
    FSCRParameterTarget: TSCRParamDataFormat;

    procedure InitVar;
    procedure DestroyVar;

  public
    { Public declarations }
  end;

  function CreateNShowSCRAppSetting(AOwner: TComponent): string;
  function CreateNShowSCRAppSetting2(AOwner: TComponent): TForm;

var
  SCRAppSettingF: TSCRAppSettingF;

implementation

uses UnitMouseUtil, UCommonUtil;

{$R *.dfm}

function CreateNShowSCRAppSetting(AOwner: TComponent): string;
begin
  Result := '';

  if Assigned(SCRAppSettingF) then
    FreeAndNil(SCRAppSettingF);

  SCRAppSettingF := TSCRAppSettingF.Create(AOwner);

  try
    if SCRAppSettingF.ShowModal = mrOK then
    begin
      Result := '';
    end;
  finally
    FreeAndNil(SCRAppSettingF);
  end;
end;

function CreateNShowSCRAppSetting2(AOwner: TComponent): TForm;
begin
  if Assigned(SCRAppSettingF) then
    FreeAndNil(SCRAppSettingF);

  SCRAppSettingF := TSCRAppSettingF.Create(AOwner);
  SCRAppSettingF.Show;
  Result := SCRAppSettingF as TForm;
end;

{ TSCRAppSettingF }

procedure TSCRAppSettingF.DestroyVar;
begin
  FSCRParameterTarget.Free;
end;

procedure TSCRAppSettingF.DropTextTarget1Drop(Sender: TObject;
  ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
var
  LControl: TControl;
begin
  if (FSCRParameterTarget.HasData) then
  begin
    LControl := GetComponentUnderMouseCursor();

    if Assigned(LControl) then
    begin
//      ShowMessage(LControl.Name);
      if LControl.ClassType = TAdvGraphicCheckLabel then
      begin
//        TAdvGraphicCheckLabel(LControl).Checked := FSCRParameterTarget.SCRD.FSCRParam.F4S_LPSCR_Enable;
        TAdvGraphicCheckLabel(LControl).Tag := FSCRParameterTarget.SCRD.FTagID;
      end;
    end;
  end;
end;

procedure TSCRAppSettingF.FormCreate(Sender: TObject);
begin
  InitVar;
end;

procedure TSCRAppSettingF.FormDestroy(Sender: TObject);
begin
  DestroyVar;
end;

procedure TSCRAppSettingF.InitVar;
begin
  FSCRParameterTarget := TSCRParamDataFormat.Create(DropTextTarget1);
end;

procedure TSCRAppSettingF.Save2DFM1Click(Sender: TObject);
begin
  SaveSCRForm2DFM(Self as TForm);
end;

end.
