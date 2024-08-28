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
    WorkItemBeginTime: TDateTimePicker;
    Label2: TLabel;
    JvLabel37: TJvLabel;
    WorkItemEndTime: TDateTimePicker;
    JvLabel1: TJvLabel;
    JvLabel2: TJvLabel;
    WorkHours: TEdit;
    WorkCode: TComboBox;
    JvLabel16: TJvLabel;
    JvLabel38: TJvLabel;
    WorkDetailRemark: TMemo;
    WorkDetail: TEdit;
    CurvyPanel1: TCurvyPanel;
    btn_Close: TAeroButton;
    AeroButton1: TAeroButton;
    ReportKey4Item: TEdit;
    WorkItemKey: TEdit;
    procedure FormCreate(Sender: TObject);
  private
    procedure InitEnum();
  public
    procedure LoadRptWorkItemVar2Form(AVar: variant);
    procedure LoadRptWorkItemVarFromForm(var AVar: variant);
  end;

  function DisplayRptWorkItemEditForm(var ADoc: variant): integer;

var
  RptWorkItemF: TRptWorkItemF;

implementation

uses UnitRttiUtil2, UnitStringUtil, UnitHiConReportMgrData;

{$R *.dfm}

function DisplayRptWorkItemEditForm(var ADoc: variant): integer;
var
  LRptWorkItemF: TRptWorkItemF;
  LJson: string;
  LVar: variant;
begin
  Result := -1;

  LRptWorkItemF := TRptWorkItemF.Create(nil);
  try
    with LRptWorkItemF do
    begin
      LoadRptWorkItemVar2Form(ADoc);

      Result := ShowModal;

      //"저장" 버튼을 누른 경우
      if Result = mrOK then
      begin
//        LJson := GetCompNameValue2JsonFromFormByClassType(LRptWorkItemF);

//        ADoc.WorkCode := WorkCode.Text;
//        ADoc.WorkHours := WorkHours.Text;
//        ADoc.WorkBeginTime := WorkBeginTime.DateTime;
//        ADoc.WorkEndTime := WorkEndTime.DateTime;
//        ADoc.ModifyDate := DateTimeToStr(now);

//        LVar := _Json(LJson);
        LoadRptWorkItemVarFromForm(ADoc);
      end;
    end;//with
  finally
    LRptWorkItemF.Free;
  end;
end;

{ TRptWorkItemF }

procedure TRptWorkItemF.FormCreate(Sender: TObject);
begin
  InitEnum();
end;

procedure TRptWorkItemF.InitEnum;
begin
  g_HiRptWorkCode.SetType2Combo(WorkCode);
end;

procedure TRptWorkItemF.LoadRptWorkItemVar2Form(AVar: variant);
var
  LJson: string;
begin
  LJson := VariantToString(AVar);
  SetCompNameValueFromJson2FormByClassType(Self, LJson);
end;

procedure TRptWorkItemF.LoadRptWorkItemVarFromForm(var AVar: variant);
var
  LJson: string;
begin
  LJson := GetCompNameValue2JsonFromFormByClassType(Self);
  AVar := _JSON(StringToUtf8(LJson));
end;

end.
