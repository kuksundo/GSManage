unit FrmASMaterialDetailEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  JvExControls, JvLabel, AeroButtons, CurvyControls,
  mormot.core.variants, mormot.core.unicode
  ;

type
  TMaterialDetailF = class(TForm)
    JvLabel25: TJvLabel;
    MaterialCode: TEdit;
    JvLabel17: TJvLabel;
    MaterialName: TEdit;
    JvLabel18: TJvLabel;
    NeedCount: TEdit;
    JvLabel1: TJvLabel;
    UnitPrice: TEdit;
    JvLabel29: TJvLabel;
    NeedDate: TDateTimePicker;
    CurvyPanel1: TCurvyPanel;
    btn_Close: TAeroButton;
    AeroButton1: TAeroButton;
    JvLabel2: TJvLabel;
    PORNo: TEdit;
  private
    { Private declarations }
  public
    procedure LoadMaterialDetailVar2Form(AVar: variant);
    procedure LoadMaterialDetailVarFromForm(var AVar: variant);
  end;

  function DisplayMaterialDetail2EditForm(var ADoc: variant): integer;

var
  MaterialDetailF: TMaterialDetailF;

implementation

uses UnitRttiUtil2;

{$R *.dfm}

function DisplayMaterialDetail2EditForm(var ADoc: variant): integer;
var
  LASMaterialF: TMaterialDetailF;
begin
  Result := -1;
  
  LASMaterialF := TMaterialDetailF.Create(nil);
  try
    with LASMaterialF do
    begin
      if ADoc.PorNo = '' then
      begin
        Caption := Caption + ' (New)';
      end
      else
      begin
        Caption := Caption + ' (Update)';
        LoadMaterialDetailVar2Form(ADoc);
      end;

      Result := ShowModal;
      
      //"저장" 버튼을 누른 경우
      if Result = mrOK then
        LoadMaterialDetailVarFromForm(ADoc);
    end;
  finally
    LASMaterialF.Free;
  end;
end;

{ TMaterialDetailF }

procedure TMaterialDetailF.LoadMaterialDetailVar2Form(AVar: variant);
var
  LJson: string;
begin
  LJson :=  VariantToString(AVar);
  SetCompNameValueFromJson2Form(Self, LJson);
end;

procedure TMaterialDetailF.LoadMaterialDetailVarFromForm(var AVar: variant);
var
  LJson: string;  
begin
  LJson := GetCompNameValue2JsonFromForm(Self);
  AVar := _JSON(StringToUtf8(LJson));
end;

end.
