unit FrmSCRSetting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  JvExExtCtrls, JvImage, JvExControls, JvButton, JvTransparentButton,
  mormot.core.data, mormot.core.text, mormot.core.unicode, mormot.core.base,
  USCRParamClass;

type
  TSCRSettingF = class(TForm)
    JvImage1: TJvImage;
    JvTransparentButton1: TJvTransparentButton;
    JvTransparentButton2: TJvTransparentButton;
    JvTransparentButton3: TJvTransparentButton;
    JvTransparentButton4: TJvTransparentButton;
    JvTransparentButton5: TJvTransparentButton;
    JvTransparentButton8: TJvTransparentButton;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure JvTransparentButton2Click(Sender: TObject);
    procedure JvTransparentButton1Click(Sender: TObject);
    procedure JvTransparentButton3Click(Sender: TObject);
    procedure JvTransparentButton5Click(Sender: TObject);
    procedure JvTransparentButton4Click(Sender: TObject);
    procedure JvTransparentButton8Click(Sender: TObject);
  private
    FSCRRecipe: TSCRRecipeInfoObjArray;
    FSCRRecipeAry: TDynArray;

    FSCRAppParam: TSCRAppParam;
    FSCRMEHPParam: TSCRMEHPParam;
    FSCRMELPParam: TSCRMELPParam;
    FSCRAEParam_1: TSCRAEParam_1;
    FSCRAEParam_2: TSCRAEParam_2;
    FSCRAEParam_3: TSCRAEParam_3;
    FSCRAEParam_4: TSCRAEParam_4;
    FSCRAEParam_5: TSCRAEParam_5;
    FSCRAEParam_6: TSCRAEParam_6;
    FSCRAEParam_7: TSCRAEParam_7;
    FSCRAEParam_8: TSCRAEParam_8;

    FSCRAEParamList: TStringList;

    procedure AssignObjAryValue2SCRParamClass();
  public
    procedure InitVar;
    procedure DestroyVar;

    procedure LoadFromJsonFile2ObjAry(out AObjAry: TSCRRecipeInfoObjArray);
    function LoadFromRecipeFile2ParamClass(): integer;
    procedure Save2RecipeFileFromParamClass();
  end;

  function CreateNShowSCRSetting(AOwner: TComponent): string;
  function CreateNShowSCRSetting2(AOwner: TComponent): TForm;

var
  SCRSettingF: TSCRSettingF;

implementation

uses FrmSCRMESetting, FrmSCRAppSetting, FrmSCRGESetting, UnitDialogUtil,
  UAppInfo, USettingsConst;

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

procedure TSCRSettingF.AssignObjAryValue2SCRParamClass;
begin
  AssignSCRRecipe2SCRParamClass(FSCRRecipe, FSCRAppParam as TObject);
  AssignSCRRecipe2SCRParamClass(FSCRRecipe, FSCRMEHPParam as TObject);
  AssignSCRRecipe2SCRParamClass(FSCRRecipe, FSCRAEParam_1 as TObject);
  AssignSCRRecipe2SCRParamClass(FSCRRecipe, FSCRAEParam_2 as TObject);
  AssignSCRRecipe2SCRParamClass(FSCRRecipe, FSCRAEParam_3 as TObject);
  AssignSCRRecipe2SCRParamClass(FSCRRecipe, FSCRAEParam_4 as TObject);
  AssignSCRRecipe2SCRParamClass(FSCRRecipe, FSCRAEParam_5 as TObject);
  AssignSCRRecipe2SCRParamClass(FSCRRecipe, FSCRAEParam_6 as TObject);
  AssignSCRRecipe2SCRParamClass(FSCRRecipe, FSCRAEParam_7 as TObject);
  AssignSCRRecipe2SCRParamClass(FSCRRecipe, FSCRAEParam_8 as TObject);
end;

procedure TSCRSettingF.DestroyVar;
begin
  FSCRRecipeAry.Clear;

  FSCRAppParam.Free;
  FSCRMEHPParam.Free;
  FSCRMELPParam.Free;
  FSCRAEParam_1.Free;
  FSCRAEParam_2.Free;
  FSCRAEParam_3.Free;
  FSCRAEParam_4.Free;
  FSCRAEParam_5.Free;
  FSCRAEParam_6.Free;
  FSCRAEParam_7.Free;
  FSCRAEParam_8.Free;

  FSCRAEParamList.Free;
end;

procedure TSCRSettingF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DestroyVar;
end;

procedure TSCRSettingF.FormCreate(Sender: TObject);
begin
  InitVar;
end;

procedure TSCRSettingF.InitVar;
begin
  FSCRAppParam := TSCRAppParam.Create('');
  FSCRMEHPParam := TSCRMEHPParam.Create('');
  FSCRMELPParam := TSCRMELPParam.Create('');
  FSCRAEParam_1 := TSCRAEParam_1.Create('');
  FSCRAEParam_2 := TSCRAEParam_2.Create('');
  FSCRAEParam_3 := TSCRAEParam_3.Create('');
  FSCRAEParam_4 := TSCRAEParam_4.Create('');
  FSCRAEParam_5 := TSCRAEParam_5.Create('');
  FSCRAEParam_6 := TSCRAEParam_6.Create('');
  FSCRAEParam_7 := TSCRAEParam_7.Create('');
  FSCRAEParam_8 := TSCRAEParam_8.Create('');

  FSCRAEParamList := TStringList.Create;
  FSCRAEParamList.AddObject('1', FSCRAEParam_1);
  FSCRAEParamList.AddObject('2', FSCRAEParam_2);
  FSCRAEParamList.AddObject('3', FSCRAEParam_3);
  FSCRAEParamList.AddObject('4', FSCRAEParam_4);
  FSCRAEParamList.AddObject('5', FSCRAEParam_5);
  FSCRAEParamList.AddObject('6', FSCRAEParam_6);
  FSCRAEParamList.AddObject('7', FSCRAEParam_7);
  FSCRAEParamList.AddObject('8', FSCRAEParam_8);

  FSCRRecipeAry.Init(TypeInfo(TSCRRecipeInfoObjArray), FSCRRecipe);
  LoadSCRRecipeInfoObjArrayFromJsonFile(TAppInfo.AppExeDir + DEFAULT_RECIPE_INFO_FILENAME, FSCRRecipe);
end;

procedure TSCRSettingF.JvTransparentButton1Click(Sender: TObject);
begin
  CreateNShowSCRMESetting_HP(Self as TComponent, FSCRMEHPParam, FSCRRecipe);
end;

procedure TSCRSettingF.JvTransparentButton2Click(Sender: TObject);
begin
  CreateNShowSCRAppSetting(Self as TComponent, FSCRAppParam, FSCRRecipe);
end;

procedure TSCRSettingF.JvTransparentButton3Click(Sender: TObject);
begin
  CreateNShowSCRGESetting(Self as TComponent, FSCRAEParamList, FSCRRecipe);
end;

procedure TSCRSettingF.JvTransparentButton4Click(Sender: TObject);
begin
  Save2RecipeFileFromParamClass();
end;

procedure TSCRSettingF.JvTransparentButton5Click(Sender: TObject);
begin
  LoadFromRecipeFile2ParamClass();
//  LoadFromJsonFile2ObjAry(FSCRRecipe);
end;

procedure TSCRSettingF.JvTransparentButton8Click(Sender: TObject);
begin
  Close;
end;

procedure TSCRSettingF.LoadFromJsonFile2ObjAry(
  out AObjAry: TSCRRecipeInfoObjArray);
var
  LFileName: string;
begin
  LFileName := GetFileNameFromDialog();
  LoadSCRRecipeInfoObjArrayFromJsonFile(LFileName, AObjAry);
end;

function TSCRSettingF.LoadFromRecipeFile2ParamClass: integer;
var
  LFileName: string;
begin
  LFileName := GetFileNameFromDialog();

  if LFileName = '' then
    exit;
//  Result := High(FSCRRecipe);
//  ShowMessage(IntToStr(Result));
  LoadSCRRecipeValueFromRecipeFile(LFileName, FSCRRecipe);
  AssignObjAryValue2SCRParamClass();;
end;

procedure TSCRSettingF.Save2RecipeFileFromParamClass;
var
  LFileName: string;
begin
  LFileName := GetFileNameFromSaveDialog();

  if LFileName = '' then
    exit;

  if SaveSCRRecipeValue2RecipeFile(LFileName, FSCRRecipe) then
    ShowMessage('Success file save : ' + LFileName);
end;

end.
