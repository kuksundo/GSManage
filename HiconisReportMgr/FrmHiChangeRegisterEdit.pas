unit FrmHiChangeRegisterEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FrameHiReportInfo, FrameVesselInfo,
  Vcl.StdCtrls, CurvyControls, UnitFrameFileList2, NxColumnClasses, NxColumns,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid, AeroButtons,
  Vcl.ExtCtrls, AdvGroupBox, AdvOfficeButtons, JvExControls, JvLabel,
  Vcl.ComCtrls, NxCollection, NxEdit, Vcl.Buttons, AdvEdit, AdvEdBtn,

  mormot.core.base, mormot.core.variants, mormot.core.buffers, mormot.core.unicode,
  mormot.core.data, mormot.orm.base, mormot.core.os, mormot.core.text,
  mormot.core.datetime, mormot.core.rtti, mormot.core.collections, mormot.rest.sqlite3,

  UnitHiConChgRegItemOrm, UnitHiConReportListOrm, UnitHiConReportMgrData
  ;

type
  THiChgRegItemF = class(TForm)
    CurvyPanel2: TCurvyPanel;
    ReportKey4ChgReg: TEdit;
    PageControl1: TPageControl;
    TabSheet5: TTabSheet;
    JvLabel38: TJvLabel;
    JvLabel16: TJvLabel;
    JvLabel19: TJvLabel;
    ModDetail: TMemo;
    Modification: TMemo;
    Involves: TAdvOfficeCheckGroup;
    SubConTS: TTabSheet;
    TabSheet3: TTabSheet;
    JHPFileFr4ChgRegItem: TJHPFileListFrame;
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
    NxHeaderPanel2: TNxHeaderPanel;
    NxHeaderPanel3: TNxHeaderPanel;
    NxHeaderPanel4: TNxHeaderPanel;
    JvLabel3: TJvLabel;
    Open_PIC: TEdit;
    JvLabel4: TJvLabel;
    ChgRegOpenDate: TDateTimePicker;
    JvLabel5: TJvLabel;
    Test_PIC: TEdit;
    JvLabel6: TJvLabel;
    ChgRegTestDate: TDateTimePicker;
    JvLabel11: TJvLabel;
    Close_PIC: TEdit;
    JvLabel12: TJvLabel;
    ChgRegCloseDate: TDateTimePicker;
    CurvyPanel1: TCurvyPanel;
    btn_Close: TAeroButton;
    AeroButton1: TAeroButton;
    JvLabel2: TJvLabel;
    Plan_Finish: TEdit;
    ChgRegRptNo: TNxButtonEdit;
    Panel5: TPanel;
    JvLabel31: TJvLabel;
    JvLabel49: TJvLabel;
    JvLabel30: TJvLabel;
    ChgRegSubject: TEdit;
    ChgRegRptAuthorID: TEdit;
    ChgRegRptAuthorName: TEdit;
    JvLabel15: TJvLabel;
    Button1: TButton;
    Button2: TButton;
    NxFlipPanel1: TNxFlipPanel;
    VesselInfoFr: TVesselInfoFr;
    JvLabel17: TJvLabel;
    SystemName: TEdit;
    JvLabel18: TJvLabel;
    DocRef: TEdit;
    JvLabel20: TJvLabel;
    Chapter: TEdit;
    JvLabel21: TJvLabel;
    JvLabel13: TJvLabel;
    ChgRegDate: TDateTimePicker;
    JvLabel14: TJvLabel;
    ReportKind: TComboBox;
    JvLabel24: TJvLabel;
    RegisteredBy: TEdit;
    Importance: TRadioGroup;
    Priority: TRadioGroup;
    NxHeaderPanel5: TNxHeaderPanel;
    JvLabel22: TJvLabel;
    JvLabel23: TJvLabel;
    OpenStatus: TRadioGroup;
    Distinction: TRadioGroup;
    InitiatedDuring: TComboBox;
    JvLabel25: TJvLabel;
    ChgRegCompany: TEdit;

    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure InitEnum();

    function CheckRequiredInput4Report(): TWinControl;
    function CheckExistHangulInput4Report(): TWinControl;
    function CheckInputLengthOver4Report(): TWinControl;
  public
    procedure SetVesselInfo2FormByRptKey(const ARptKey: TTimeLog);
    //TagNo=10����: 0, 20����: 1...
    function GetPageIndexFromTagNo(ATagNo: integer): integer;
  end;

  //AFromDocDict : True = DB�� �������� ����
  function DisplayHiChgRegEditForm(const ARptKey: TTimeLog; var AChgRegItemJson: RawUtf8;
    AFromDocDict: Boolean; AJHPFileDB4HiChgReg: TRestClientDB): integer;

var
  HiChgRegItemF: THiChgRegItemF;

implementation

uses UnitRttiUtil2, UnitComponentUtil;

{$R *.dfm}

function DisplayHiChgRegEditForm(const ARptKey: TTimeLog;
  var AChgRegItemJson: RawUtf8; AFromDocDict: Boolean; AJHPFileDB4HiChgReg: TRestClientDB): integer;
var
  LHiChgRegItemF: THiChgRegItemF;
  LJson: string;
  LVar: variant;
  LControl: TWinControl;
  LPageIdx: integer;
begin
  LHiChgRegItemF := THiChgRegItemF.Create(nil);
  try
    with LHiChgRegItemF do
    begin
      JHPFileFr4ChgRegItem.FJHPFileDB4Fr := AJHPFileDB4HiChgReg;
      SetVesselInfo2FormByRptKey(ARptKey);
      ReportKind.ItemIndex := Ord(hrkCHR)-1;

      LJson := Utf8ToString(AChgRegItemJson);
      SetCompNameValueFromJson2FormByClassType(LHiChgRegItemF, LJson);
      PageControl1.ActivePageIndex := 0;
      JHPFileFr4ChgRegItem.LoadFiles2GridByTaskID(ARptKey);

      //�ۼ��� ID ��ſ� ���� ������ ������
      ChgRegRptAuthorID.Text := VesselInfoFr.ClassSociety.Text;

      while True do
      begin
        Result := ShowModal;

        if Result = mrOK then
        begin
          //�ʼ� �Է� �׸� �� �Է� �ȵ� �ʵ尡 ������ ��� ShowModal
          LControl := CheckRequiredInput4Report();

          if Assigned(LControl) then
          begin
            LPageIdx := GetPageIndexFromTagNo(LControl.Tag);
            PageControl1.ActivePageIndex := LPageIdx;
            ActiveControl := LControl;
            Continue;
          end;

          //�ѱ� �Է� �� �ʵ尡 ������ ��� ShowModal
//          LControl := CheckExistHangulInput4Report();
//
//          if Assigned(LControl) then
//          begin
//            LPageIdx := GetPageIndexFromTagNo(LControl.Tag);
//            PageControl1.ActivePageIndex := LPageIdx;
//            ActiveControl := LControl;
//            Continue;
//          end;

          //���̰� 70�� �̻��� �ʵ尡 ������ ��� ShowModal
          LControl := CheckInputLengthOver4Report();

          if Assigned(LControl) then
          begin
            LPageIdx := GetPageIndexFromTagNo(LControl.Tag);
            PageControl1.ActivePageIndex := LPageIdx;
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
          JHPFileFr4ChgRegItem.ApplyFileFromGrid2DB(ARptKey);
        end;//if

        Break;
      end;//while
    end;//with

  finally
    LHiChgRegItemF.Free;
  end;
end;

{ THiChgRegItemF }

procedure THiChgRegItemF.Button1Click(Sender: TObject);
begin
  InputHint2Component(Self);
end;

procedure THiChgRegItemF.Button2Click(Sender: TObject);
var
  LStrList: TStringList;
begin
  LStrList := GetNameNHint2Strlist(Self);
  try
    LStrList.SaveToFile('c:\temp\NameNHintList.txt');
  finally
    LStrList.Free;
  end;
end;

function THiChgRegItemF.CheckExistHangulInput4Report: TWinControl;
begin
  //�ѱ��� ���Ե� Component Value�� ������ �ش� Component ��ȯ��
  Result := CheckInputExistHangulByTagOnForm(Self);

  //True = �Է°��� �ѱ��� ���� �� Component ����
  if Assigned(Result) then
  begin
    //Component Color ����
    ChangeCompColorByPropertyName(Result, clYellow);
    ShowMessage('�ѱ� ����ϸ� �ȵ�: [' + Result.Hint + ']' );
  end
end;

function THiChgRegItemF.CheckInputLengthOver4Report: TWinControl;
begin
  Result := CheckInputLengthOver(Self, 70);
end;

function THiChgRegItemF.CheckRequiredInput4Report: TWinControl;
begin
  Result := CheckRequiredInput(Self);
end;

procedure THiChgRegItemF.FormCreate(Sender: TObject);
begin
  JHPFileFr4ChgRegItem.FIgnoreFileTypePrompt := True;
  InitEnum();
end;

function THiChgRegItemF.GetPageIndexFromTagNo(ATagNo: integer): integer;
begin
  case ATagNo of
    10..19: Result := 0;
    20..29: Result := 1;
    else
      Result := 0;
  end;
end;

procedure THiChgRegItemF.InitEnum;
begin
  g_HiRptModifyReqSrc.InitArrayRecord(R_HiRptModifyReqSrc);
  g_HiRptImportance.InitArrayRecord(R_HiRptImportance);
  g_HiRptPriority.InitArrayRecord(R_HiRptPriority);
  g_HiRptOpenStatus.InitArrayRecord(R_HiRptOpenStatus);
  g_HiRptDistinction.InitArrayRecord(R_HiRptDistinction);
  g_HiRptInitiatedDuring.InitArrayRecord(R_HiRptInitiatedDuring);

  g_HiRptModifyReqSrc.SetType2List(ReqSrc.Items);
  g_HiRptModifiedItem.SetType2List(Involves.Items);
  g_HiRptImportance.SetType2List(Importance.Items);
  g_HiRptPriority.SetType2List(Priority.Items);

  g_HiRptKind.SetType2List(ReportKind.Items);
  ReportKind.ItemIndex:= Ord(hrkCHR);

  g_HiRptInitiatedDuring.SetType2List(InitiatedDuring.Items);
end;

procedure THiChgRegItemF.SetVesselInfo2FormByRptKey(const ARptKey: TTimeLog);
var
  LOrmHiconReportList: TOrmHiconReportList;
  LJson: string;
begin
  LOrmHiconReportList := GetHiconReportListByKeyID(ARptKey);
  try
    if LOrmHiconReportList.IsUpdate then
    begin
      VesselInfoFr.HullNo.Text := LOrmHiconReportList.HullNo;
      VesselInfoFr.ShipName.Text := LOrmHiconReportList.ShipName;
      VesselInfoFr.ShipOwner.Text := LOrmHiconReportList.ShipOwner;
      VesselInfoFr.ClassSociety.Text := LOrmHiconReportList.ClassSociety;
      VesselInfoFr.ShipType.Text := LOrmHiconReportList.ShipType;
      VesselInfoFr.ProjectNo.Text := LOrmHiconReportList.ProjectNo;

      //      LJson := Utf8ToString(LOrmHiconReportList.GetJsonValues(True, False, soSelect));
//      SetCompNameValueFromJson2FormByClassType(Self, LJson);
    end;
  finally
    LOrmHiconReportList.Free;
  end;
end;

end.
