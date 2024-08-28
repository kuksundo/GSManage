unit FrmASMaterialDetailEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  JvExControls, JvLabel, AeroButtons, CurvyControls,
  mormot.core.variants, mormot.core.unicode, AdvEdit, AdvEdBtn
  ;

type
  TMaterialDetailF = class(TForm)
    JvLabel25: TJvLabel;
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
    JvLabel3: TJvLabel;
    CreateDate: TDateTimePicker;
    MaterialCode: TAdvEditBtn;
    IsReclaim: TCheckBox;
    procedure MaterialCodeClickBtn(Sender: TObject);
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

uses UnitRttiUtil2, FrmSearchMaterialCode;

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
      begin
//        ADoc.MaterialCode := MaterialCode.Text;
//        ADoc.MaterialName := MaterialName.Text;
//        ADoc.NeedCount := NeedCount.Text;
//        ADoc.UnitPrice := UnitPrice.Text;
//        ADoc.NeedDate := DateTimeToStr(NeedDate.Date);
//        ADoc.CreateDate := DateTimeToStr(CreateDate.Date);
//        ADoc.IsReclaim := IsReclaim.Checked;

        LoadMaterialDetailVarFromForm(ADoc);
      end;
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
  LJson := GetCompNameValue2JsonFromFormByClassType(Self);// GetCompNameValue2JsonFromForm(Self);
  AVar := _JSON(StringToUtf8(LJson));
end;

procedure TMaterialDetailF.MaterialCodeClickBtn(Sender: TObject);
var
  LMatCode, LMatName: string;
begin
  if DisplayMaterialCode2EditForm(LMatCode, LMatName) = mrOK then
  begin
    MaterialCode.Text := LMatCode;
    MaterialName.Text := LMatName;
  end;
end;

end.
