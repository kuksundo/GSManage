unit FrmHiReportWorkItemEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  JvExControls, JvLabel, AeroButtons, CurvyControls,
  mormot.core.variants, mormot.core.unicode
  ;

type
  TRptWorkItemF = class(TForm)
    JvLabel36: TJvLabel;
    WorkBeginTime: TDateTimePicker;
    Label2: TLabel;
    JvLabel37: TJvLabel;
    WorkEndTime: TDateTimePicker;
    JvLabel1: TJvLabel;
    JvLabel2: TJvLabel;
    WorkHours: TEdit;
    WorkCode: TComboBox;
    JvLabel16: TJvLabel;
    JvLabel38: TJvLabel;
    NextWorkDesc: TMemo;
    Edit1: TEdit;
    CurvyPanel1: TCurvyPanel;
    btn_Close: TAeroButton;
    AeroButton1: TAeroButton;
  private
    { Private declarations }
  public
    procedure LoadRptWorkItemVar2Form(AVar: variant);
    procedure LoadRptWorkItemVarFromForm(var AVar: variant);
  end;

  function DisplayRptWorkItemEditForm(var ADoc: variant): integer;

var
  RptWorkItemF: TRptWorkItemF;

implementation

uses UnitRttiUtil2, UnitStringUtil;

{$R *.dfm}

function DisplayRptWorkItemEditForm(var ADoc: variant): integer;
var
  LRptWorkItemF: TRptWorkItemF;
begin
  Result := -1;

  LRptWorkItemF := TRptWorkItemF.Create(nil);
  try
    with LRptWorkItemF do
    begin
      if ADoc.KeyID = '' then
      begin
        Caption := Caption + ' (New)';
      end
      else
      begin
        Caption := Caption + ' (Update)';
        LoadRptWorkItemVar2Form(ADoc);
      end;

      Result := ShowModal;

      //"저장" 버튼을 누른 경우
      if Result = mrOK then
      begin
        if ADoc.KeyID = '' then
          ADoc.KeyID := NewGUID;

        ADoc.WorkCode := WorkCode.Text;
        ADoc.WorkHours := WorkHours.Text;
        ADoc.WorkBeginTime := WorkBeginTime.DateTime;
        ADoc.WorkEndTime := WorkEndTime.DateTime;
        ADoc.ModifyDate := DateTimeToStr(now);

        LoadRptWorkItemVarFromForm(ADoc);
      end;
    end;//with
  finally
    LRptWorkItemF.Free;
  end;
end;

{ TRptWorkItemF }

procedure TRptWorkItemF.LoadRptWorkItemVar2Form(AVar: variant);
var
  LJson: string;
begin
  LJson := VariantToString(AVar);
  SetCompNameValueFromJson2Form(Self, LJson);
end;

procedure TRptWorkItemF.LoadRptWorkItemVarFromForm(var AVar: variant);
var
  LJson: string;
begin
  LJson := GetCompNameValue2JsonFromForm(Self);
  AVar := _JSON(StringToUtf8(LJson));
end;

end.
