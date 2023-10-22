unit FrmSCRMESetting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  JvExExtCtrls, JvImage, JvExControls, JvButton, JvTransparentButton,
  AdvGraphicCheckLabel, AdvPageControl, Vcl.ComCtrls, iComponent, iVCLComponent,
  iCustomComponent, iEditCustom, iAnalogOutput, Vcl.Menus, DragDrop, DropTarget,
  DragDropText, UDragDropFormat_SCRParam;

type
  TSCRMESettingF = class(TForm)
    JvImage1: TJvImage;
    AdvPageControl1: TAdvPageControl;
    AdvTabSheet1: TAdvTabSheet;
    JvImage2: TJvImage;
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
    AdvTabSheet2: TAdvTabSheet;
    JvImage3: TJvImage;
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
    AdvTabSheet3: TAdvTabSheet;
    JvTransparentButton1: TJvTransparentButton;
    AdvPageControl2: TAdvPageControl;
    AdvTabSheet4: TAdvTabSheet;
    JvImage4: TJvImage;
    AdvTabSheet5: TAdvTabSheet;
    JvImage5: TJvImage;
    AdvTabSheet6: TAdvTabSheet;
    JvImage6: TJvImage;
    JvTransparentButton2: TJvTransparentButton;
    JvTransparentButton3: TJvTransparentButton;
    JvTransparentButton4: TJvTransparentButton;
    JvTransparentButton5: TJvTransparentButton;
    JvTransparentButton6: TJvTransparentButton;
    JvTransparentButton7: TJvTransparentButton;
    JvTransparentButton8: TJvTransparentButton;
    JvTransparentButton9: TJvTransparentButton;
    JvTransparentButton10: TJvTransparentButton;
    iAnalogOutput1: TiAnalogOutput;
    iAnalogOutput2: TiAnalogOutput;
    iAnalogOutput3: TiAnalogOutput;
    iAnalogOutput4: TiAnalogOutput;
    iAnalogOutput5: TiAnalogOutput;
    iAnalogOutput6: TiAnalogOutput;
    iAnalogOutput7: TiAnalogOutput;
    iAnalogOutput8: TiAnalogOutput;
    iAnalogOutput9: TiAnalogOutput;
    iAnalogOutput10: TiAnalogOutput;
    iAnalogOutput11: TiAnalogOutput;
    iAnalogOutput12: TiAnalogOutput;
    iAnalogOutput13: TiAnalogOutput;
    iAnalogOutput14: TiAnalogOutput;
    iAnalogOutput15: TiAnalogOutput;
    iAnalogOutput16: TiAnalogOutput;
    iAnalogOutput17: TiAnalogOutput;
    iAnalogOutput18: TiAnalogOutput;
    iAnalogOutput19: TiAnalogOutput;
    iAnalogOutput20: TiAnalogOutput;
    iAnalogOutput21: TiAnalogOutput;
    iAnalogOutput22: TiAnalogOutput;
    iAnalogOutput23: TiAnalogOutput;
    iAnalogOutput24: TiAnalogOutput;
    iAnalogOutput25: TiAnalogOutput;
    iAnalogOutput26: TiAnalogOutput;
    iAnalogOutput27: TiAnalogOutput;
    iAnalogOutput28: TiAnalogOutput;
    iAnalogOutput29: TiAnalogOutput;
    iAnalogOutput30: TiAnalogOutput;
    iAnalogOutput31: TiAnalogOutput;
    iAnalogOutput32: TiAnalogOutput;
    iAnalogOutput33: TiAnalogOutput;
    iAnalogOutput34: TiAnalogOutput;
    iAnalogOutput35: TiAnalogOutput;
    iAnalogOutput36: TiAnalogOutput;
    iAnalogOutput37: TiAnalogOutput;
    iAnalogOutput38: TiAnalogOutput;
    iAnalogOutput39: TiAnalogOutput;
    DropTextTarget1: TDropTextTarget;
    PopupMenu1: TPopupMenu;
    Save2DFM1: TMenuItem;
    JvTransparentButton11: TJvTransparentButton;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure JvTransparentButton3Click(Sender: TObject);
    procedure JvTransparentButton4Click(Sender: TObject);
    procedure JvTransparentButton2Click(Sender: TObject);
    procedure Save2DFM1Click(Sender: TObject);
    procedure DropTextTarget1Drop(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
  private
    FSCRParameterTarget: TSCRParamDataFormat;

    procedure InitVar;
    procedure DestroyVar;
  public
    { Public declarations }
  end;

  function CreateNShowSCRMESetting(AOwner: TComponent): string;
  function CreateNShowSCRMESetting2(AOwner: TComponent): TForm;

var
  SCRMESettingF: TSCRMESettingF;

implementation

uses UnitMouseUtil, UCommonUtil;

{$R *.dfm}

function CreateNShowSCRMESetting(AOwner: TComponent): string;
begin
  Result := '';

  if Assigned(SCRMESettingF) then
    FreeAndNil(SCRMESettingF);

  SCRMESettingF := TSCRMESettingF.Create(AOwner);

  try
    if SCRMESettingF.ShowModal = mrOK then
    begin
      Result := '';
    end;
  finally
    FreeAndNil(SCRMESettingF);
  end;
end;

function CreateNShowSCRMESetting2(AOwner: TComponent): TForm;
begin
  if Assigned(SCRMESettingF) then
    FreeAndNil(SCRMESettingF);

  SCRMESettingF := TSCRMESettingF.Create(AOwner);
  SCRMESettingF.Show;

  Result := SCRMESettingF;
end;

procedure TSCRMESettingF.DestroyVar;
begin
  FSCRParameterTarget.Free;
end;

procedure TSCRMESettingF.DropTextTarget1Drop(Sender: TObject;
  ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
var
  LControl: TControl;
begin
  if (FSCRParameterTarget.HasData) then
  begin
    LControl := GetComponentUnderMouseCursor();

    if Assigned(LControl) then
    begin
      if LControl.ClassType = TAdvGraphicCheckLabel then
      begin
//        TAdvGraphicCheckLabel(LControl).Checked := FSCRParameterTarget.SCRD.FSCRParam.F4S_LPSCR_Enable;
        TAdvGraphicCheckLabel(LControl).Tag := FSCRParameterTarget.SCRD.FTagID;
      end
      else
      if LControl.ClassType = TiAnalogOutput then
      begin
        TiAnalogOutput(LControl).Tag := FSCRParameterTarget.SCRD.FTagID;
      end;
    end;
  end;
end;

procedure TSCRMESettingF.FormCreate(Sender: TObject);
begin
  InitVar;
end;

procedure TSCRMESettingF.FormDestroy(Sender: TObject);
begin
  DestroyVar;
end;

procedure TSCRMESettingF.InitVar;
begin
  FSCRParameterTarget := TSCRParamDataFormat.Create(DropTextTarget1);
end;

procedure TSCRMESettingF.JvTransparentButton2Click(Sender: TObject);
begin
  AdvPageControl2.ActivePageIndex := 0;
end;

procedure TSCRMESettingF.JvTransparentButton3Click(Sender: TObject);
begin
  AdvPageControl2.ActivePageIndex := 1;
end;

procedure TSCRMESettingF.JvTransparentButton4Click(Sender: TObject);
begin
  AdvPageControl2.ActivePageIndex := 2;
end;

procedure TSCRMESettingF.Save2DFM1Click(Sender: TObject);
begin
  SaveSCRForm2DFM(Self as TForm);
end;

end.
