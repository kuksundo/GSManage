unit FrmSCRAppSetting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  JvExExtCtrls, JvImage, AdvGraphicCheckLabel, AdvPageControl, Vcl.ComCtrls,
  JvExControls, JvButton, JvTransparentButton, DragDrop, DropTarget,
  DragDropText, UDragDropFormat_SCRParam, Vcl.Menus, AdvFocusHelper, USCRParamClass;

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
    AdvGraphicCheckLabel23: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel24: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel30: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel31: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel32: TAdvGraphicCheckLabel;
    AdvGraphicCheckLabel78: TAdvGraphicCheckLabel;
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
    JvTransparentButton2: TJvTransparentButton;
    JvTransparentButton3: TJvTransparentButton;
    JvTransparentButton4: TJvTransparentButton;
    JvTransparentButton5: TJvTransparentButton;
    JvTransparentButton6: TJvTransparentButton;
    JvTransparentButton7: TJvTransparentButton;
    AdvFocusHelper1: TAdvFocusHelper;
    JvTransparentButton8: TJvTransparentButton;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DropTextTarget1Drop(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
    procedure Save2DFM1Click(Sender: TObject);
    procedure JvTransparentButton2Click(Sender: TObject);
    procedure JvTransparentButton8Click(Sender: TObject);
    procedure JvTransparentButton1Click(Sender: TObject);
  private
    FSCRParameterTarget: TSCRParamDataFormat;
    FSCRAppParam: TSCRAppParam;
    FSCRRecipe: TSCRRecipeInfoObjArray;

    procedure InitVar;
    procedure DestroyVar;

    procedure ShowTagNoAll();
  public
    function ApplySettings(): integer;
  end;

  function CreateNShowSCRAppSetting(AOwner: TComponent;
    var ASCRAppParam: TSCRAppParam; var ASCRRecipe: TSCRRecipeInfoObjArray): string;
  function CreateNShowSCRAppSetting2(AOwner: TComponent): TForm;

var
  SCRAppSettingF: TSCRAppSettingF;

implementation

uses UnitMouseUtil, UCommonUtil;

{$R *.dfm}

function CreateNShowSCRAppSetting(AOwner: TComponent; var ASCRAppParam: TSCRAppParam;
  var ASCRRecipe: TSCRRecipeInfoObjArray): string;
begin
  Result := '';

  if Assigned(SCRAppSettingF) then
    FreeAndNil(SCRAppSettingF);

  SCRAppSettingF := TSCRAppSettingF.Create(AOwner);

  try
    SCRAppSettingF.FSCRAppParam := ASCRAppParam;
    SCRAppSettingF.FSCRRecipe := ASCRRecipe;
    SCRAppSettingF.FSCRAppParam.LoadObject2Form(SCRAppSettingF, SCRAppSettingF.FSCRAppParam, True);

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

function TSCRAppSettingF.ApplySettings: integer;
var
  i: integer;
begin
  FSCRAppParam.LoadForm2Object(Self as TObject, FSCRAppParam, True);
//  ShowMessage(IntToStr(High(FSCRRecipe)));
//  Result := High(FSCRRecipe);
  SetSCRRecipeInfoValueFromSCRParam(FSCRAppParam, FSCRRecipe);

//  FSCRAppParam.Save('c:\temp\SCRAppParam.txt');
  ShowMessage('Setting has applied to the Application parameter!');
end;

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
        TAdvGraphicCheckLabel(LControl).Tag := FSCRParameterTarget.SCRD.FTagID;
        TAdvGraphicCheckLabel(LControl).SetFocus;
        TAdvGraphicCheckLabel(LControl).SetFocus;
      end;

//      LControl.Name := FSCRParameterTarget.SCRD.FTagName;
      LControl.Hint := 'Checked';
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
  DropTextTarget1.Target := AdvPageControl1;
  FSCRParameterTarget := TSCRParamDataFormat.Create(DropTextTarget1);
end;

procedure TSCRAppSettingF.JvTransparentButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TSCRAppSettingF.JvTransparentButton2Click(Sender: TObject);
begin
  ApplySettings();
end;

procedure TSCRAppSettingF.JvTransparentButton8Click(Sender: TObject);
begin
  Close;
end;

procedure TSCRAppSettingF.Save2DFM1Click(Sender: TObject);
begin
  SaveSCRForm2DFM(Self as TForm);
end;

procedure TSCRAppSettingF.ShowTagNoAll;
begin

end;

end.
