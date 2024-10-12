unit FrmHiReportWorkItemEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, DateUtils,
  JvExControls, JvLabel, AeroButtons, CurvyControls,
  mormot.core.variants, mormot.core.unicode, Vcl.Buttons, AdvDateTimePicker
  ;

type
  TRptWorkItemF = class(TForm)
    JvLabel36: TJvLabel;
    Label2: TLabel;
    JvLabel37: TJvLabel;
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
    BitBtn1: TBitBtn;
    WorkItemBeginTime: TAdvDateTimePicker;
    WorkItemEndTime: TAdvDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    procedure InitEnum();
  public
    function CheckRequiredInput4WorkItem(): TWinControl;
    function CheckExistHangulInput4WorkItem(): TWinControl;
    function CheckInputLengthOver4WorkItem(): TWinControl;

    procedure LoadRptWorkItemVar2Form(AVar: variant);
    procedure LoadRptWorkItemVarFromForm(var AVar: variant);
  end;

  function DisplayRptWorkItemEditForm(var ADoc: variant): integer;

var
  RptWorkItemF: TRptWorkItemF;

implementation

uses UnitRttiUtil2, UnitStringUtil, UnitHiConReportMgrData, UnitComponentUtil,
  UnitDateUtil, UnitTRegExUtil;

{$R *.dfm}

function DisplayRptWorkItemEditForm(var ADoc: variant): integer;
var
  LRptWorkItemF: TRptWorkItemF;
  LJson: string;
  LVar: variant;
  LControl: TWinControl;
begin
  Result := -1;

  LRptWorkItemF := TRptWorkItemF.Create(nil);
  try
    with LRptWorkItemF do
    begin
      LoadRptWorkItemVar2Form(ADoc);

      while True do
      begin
        Result := ShowModal;

        //"저장" 버튼을 누른 경우
        if Result = mrOK then
        begin
          //필수 입력 항목 중 입력 안된 필드가 있으면 계속 ShowModal
          LControl := CheckRequiredInput4WorkItem();

          if Assigned(LControl) then
          begin
            ActiveControl := LControl;
            Continue;
          end;

          //한글 입력 된 필드가 있으면 계속 ShowModal
          LControl := CheckExistHangulInput4WorkItem();

          if Assigned(LControl) then
          begin
            ActiveControl := LControl;
            Continue;
          end;

          //길이가 70자 이상인 필드가 있으면 계속 ShowModal
          LControl := CheckInputLengthOver4WorkItem();

          if Assigned(LControl) then
          begin
            ActiveControl := LControl;
            Continue;
          end;

  //        LJson := GetCompNameValue2JsonFromFormByClassType(LRptWorkItemF);

  //        ADoc.WorkCode := WorkCode.Text;
  //        ADoc.WorkHours := WorkHours.Text;
  //        ADoc.WorkBeginTime := WorkBeginTime.DateTime;
  //        ADoc.WorkEndTime := WorkEndTime.DateTime;
  //        ADoc.ModifyDate := DateTimeToStr(now);

  //        LVar := _Json(LJson);
          LoadRptWorkItemVarFromForm(ADoc);
        end;

        Break;
      end;//while
    end;//with
  finally
    LRptWorkItemF.Free;
  end;
end;

{ TRptWorkItemF }

procedure TRptWorkItemF.BitBtn1Click(Sender: TObject);
var
  LMin: Int64;
begin
  LMin := MinutesBetween(WorkItemBeginTime.DateTime, WorkItemEndTime.DateTime);

  WorkHours.Text := GetHhCommannFromMinute(LMin);
end;

function TRptWorkItemF.CheckExistHangulInput4WorkItem: TWinControl;
begin
  //한글이 포함된 Component Value가 있으면 해당 Component 반환함
  Result := CheckInputExistHangulByTagOnForm(Self);

  //True = 입력값에 한글이 포함 된 Component 존재
  if Assigned(Result) then
  begin
    //Component Color 변경
    ChangeCompColorByPropertyName(Result, clYellow);
    ShowMessage('한글 사용하면 안됨: [' + Result.Hint + ']' );
  end
end;

function TRptWorkItemF.CheckInputLengthOver4WorkItem: TWinControl;
begin
  //Component Value가 70자 이상이면 해당 Component 반환함
  Result := CheckInputLengthByTagOnForm(Self, 70);

    //True = 입력값 길이가 70자 이상인 Component 존재
  if Assigned(Result) then
  begin
    //작업상세는 70자 제한 없음
    if Result.Name = 'WorkDetailRemark' then
      exit;

    //Component Color 변경
    ChangeCompColorByPropertyName(Result, clYellow);
    ShowMessage('길이가 70자 이내여야 함: [' + Result.Hint + ']' );
  end
end;

function TRptWorkItemF.CheckRequiredInput4WorkItem: TWinControl;
begin
  //입력 안된 Component Value가 있으면 해당 Component 반환함
  Result := CheckRequiredInputByTagOnForm(Self);

  //True = 입력 안된 Component 존재
  if Assigned(Result) then
  begin
    if Result.ClassName = 'TAdvOfficeCheckGroup' then
      ChangeCompColorByPropertyName(Result, clRed, 'BorderColor')
    else
      //Component Color 변경
      ChangeCompColorByPropertyName(Result, clYellow);
      ShowMessage('필수 항목: [' + Result.Hint + '] 을 입력하세요' );
  end
  else //WorkItemGrid Check
  begin

  end;
end;

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
