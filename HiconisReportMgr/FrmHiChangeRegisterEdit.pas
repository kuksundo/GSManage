unit FrmHiChangeRegisterEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FrameHiReportInfo, FrameVesselInfo,
  Vcl.StdCtrls, CurvyControls, UnitFrameFileList2, NxColumnClasses, NxColumns,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid, AeroButtons,
  Vcl.ExtCtrls, AdvGroupBox, AdvOfficeButtons, JvExControls, JvLabel,
  Vcl.ComCtrls, NxCollection,

  mormot.core.base, mormot.core.variants, mormot.core.buffers, mormot.core.unicode,
  mormot.core.data, mormot.orm.base, mormot.core.os, mormot.core.text,
  mormot.core.datetime, mormot.core.rtti, mormot.core.collections,

  UnitHiConChgRegItemOrm, NxEdit
  ;

type
  THiChgRegItemF = class(TForm)
    CurvyPanel2: TCurvyPanel;
    ReportKey: TEdit;
    PageControl1: TPageControl;
    TabSheet5: TTabSheet;
    JvLabel38: TJvLabel;
    JvLabel16: TJvLabel;
    JvLabel19: TJvLabel;
    ModDetail: TMemo;
    Modification: TMemo;
    ModifyItems: TAdvOfficeCheckGroup;
    SubConTS: TTabSheet;
    TabSheet3: TTabSheet;
    TJHPFileListFrame1: TJHPFileListFrame;
    JvLabel1: TJvLabel;
    ReqSrc: TAdvOfficeCheckGroup;
    NxHeaderPanel1: TNxHeaderPanel;
    JvLabel9: TJvLabel;
    Plan_Engineer: TEdit;
    JvLabel10: TJvLabel;
    Plan_ClosePIC: TEdit;
    JvLabel7: TJvLabel;
    EstimatedWorkHour: TEdit;
    JvLabel8: TJvLabel;
    Importance: TAdvOfficeCheckGroup;
    NxHeaderPanel2: TNxHeaderPanel;
    NxHeaderPanel3: TNxHeaderPanel;
    NxHeaderPanel4: TNxHeaderPanel;
    JvLabel3: TJvLabel;
    Open_PIC: TEdit;
    JvLabel4: TJvLabel;
    Open_Date: TDateTimePicker;
    JvLabel5: TJvLabel;
    Test_PIC: TEdit;
    JvLabel6: TJvLabel;
    Test_Date: TDateTimePicker;
    JvLabel11: TJvLabel;
    Close_PIC: TEdit;
    JvLabel12: TJvLabel;
    CLose_Date: TDateTimePicker;
    TVesselInfoFr1: TVesselInfoFr;
    THiRptInfoFr1: THiRptInfoFr;
    CurvyPanel1: TCurvyPanel;
    btn_Close: TAeroButton;
    AeroButton1: TAeroButton;
    JvLabel2: TJvLabel;
    Plan_Finish: TEdit;
    ChgRegRptNo: TNxButtonEdit;
  private
    function CheckRequiredInput4Report(): TWinControl;
    function CheckExistHangulInput4Report(): TWinControl;
    function CheckInputLengthOver4Report(): TWinControl;
  public
    { Public declarations }
  end;

  //AFromDocDict : True = DB에 저장하지 않음
  function DisplayHiChgRegEditForm(var AChgRegItemJson: RawUtf8; AFromDocDict: Boolean): integer;

var
  HiChgRegItemF: THiChgRegItemF;

implementation

uses UnitRttiUtil2;

{$R *.dfm}

function DisplayHiChgRegEditForm(var AChgRegItemJson: RawUtf8; AFromDocDict: Boolean): integer;
var
  LHiChgRegItemF: THiChgRegItemF;
  LJson: string;
  LVar: variant;
  LControl: TWinControl;
begin
  LHiChgRegItemF := THiChgRegItemF.Create(nil);
  try
    with LHiChgRegItemF do
    begin
      LJson := Utf8ToString(AChgRegItemJson);
      SetCompNameValueFromJson2FormByClassType(LHiChgRegItemF, LJson);
      PageControl1.ActivePageIndex := 0;

      while True do
      begin
        Result := ShowModal;

        if Result = mrOK then
        begin
          //필수 입력 항목 중 입력 안된 필드가 있으면 계속 ShowModal
          LControl := CheckRequiredInput4Report();

          if Assigned(LControl) then
          begin
            PageControl1.ActivePageIndex := 0;
            ActiveControl := LControl;
            Continue;
          end;

          //한글 입력 된 필드가 있으면 계속 ShowModal
          LControl := CheckExistHangulInput4Report();

          if Assigned(LControl) then
          begin
            PageControl1.ActivePageIndex := 0;
            ActiveControl := LControl;
            Continue;
          end;

          //길이가 70자 이상인 필드가 있으면 계속 ShowModal
          LControl := CheckInputLengthOver4Report();

          if Assigned(LControl) then
          begin
            PageControl1.ActivePageIndex := 0;
            ActiveControl := LControl;
            Continue;
          end;

          LJson := GetCompNameValue2JsonFromFormByClassType(LHiChgRegItemF);

          if not AFromDocDict then
          begin
            LVar := _Json(LJson);
            AddHiChgRegItemFromVariant(LVar, False);
          end;

          AChgRegItemJson := StringToUtf8(LJson);
        end;//if

        Break;
      end;//while
    end;//with

  finally
    LHiChgRegItemF.Free;
  end;
end;

{ THiChgRegItemF }

function THiChgRegItemF.CheckExistHangulInput4Report: TWinControl;
begin
  Result := nil;
end;

function THiChgRegItemF.CheckInputLengthOver4Report: TWinControl;
begin
  Result := nil;
end;

function THiChgRegItemF.CheckRequiredInput4Report: TWinControl;
begin
  Result := nil;
end;

end.
