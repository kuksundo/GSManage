unit FrmCertManage2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvBaseDlg, JvSelectDirectory,
  Vcl.ExtCtrls, AdvSmoothSplashScreen, Vcl.Menus, Vcl.ImgList, NxColumnClasses,
  NxColumns, NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid, SBPro,
  AdvOfficeTabSet, Vcl.StdCtrls, AeroButtons, Vcl.ComCtrls, JvExControls,
  JvLabel, CurvyControls, AdvGroupBox,
  AdvOfficeButtons, NxEdit, AdvEdit, AdvEdBtn, iComponent, iVCLComponent,
  iCustomComponent, iSwitchLed, Vcl.AppEvnts, PJAbout, PJVersionInfo,
  mormot.core.base, mormot.core.data, mormot.core.variants, mormot.core.unicode,
  mormot.core.json, mormot.core.datetime, mormot.orm.base, mormot.core.zip,
  UnitGSTariffRecord2, FrmDisplayTariff2,
  UnitVesselData2, UnitHGSCertRecord2, UnitHGSCertData2, Generics.Collections,
  UnitCertManager2, UnitJHPFileData, UnitCertManageConfigClass2, FrmCertManageConfig,
  UnitVesselMasterRecord2, UnitElecMasterData, UnitHGSLicenseRecord,
  FormAboutDefs, EasterEgg, UnitCertManagerCLO, UnitQRCodeFrame, ArrayHelper;

type
  TCertManageF = class(TForm)
    Splitter1: TSplitter;
    CurvyPanel1: TCurvyPanel;
    Panel1: TPanel;
    btn_Search: TAeroButton;
    btn_Close: TAeroButton;
    AeroButton1: TAeroButton;
    TaskTab: TAdvOfficeTabSet;
    StatusBarPro1: TStatusBarPro;
    CertListGrid: TNextGrid;
    NxIncrementColumn1: TNxIncrementColumn;
    TrainedCourse: TNxTextColumn;
    UntilValidity: TNxTextColumn;
    ProductType: TNxTextColumn;
    CertNo: TNxTextColumn;
    TraineeName: TNxTextColumn;
    CompanyName: TNxTextColumn;
    TrainedSubject: TNxTextColumn;
    TrainedBeginDate: TNxTextColumn;
    TrainedEndDate: TNxTextColumn;
    imagelist24x24: TImageList;
    ImageList16x16: TImageList;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    CreateNewCert: TMenuItem;
    N2: TMenuItem;
    Close1: TMenuItem;
    View1: TMenuItem;
    DataBase1: TMenuItem;
    ools1: TMenuItem;
    OpenDialog1: TOpenDialog;
    PopupMenu1: TPopupMenu;
    Add1: TMenuItem;
    ImageList32x32: TImageList;
    SplashScreen1: TAdvSmoothSplashScreen;
    Timer1: TTimer;
    JvSelectDirectory1: TJvSelectDirectory;
    CertFileDBPath: TNxTextColumn;
    CertFileDBName: TNxTextColumn;
    UpdateDate: TNxTextColumn;
    N1: TMenuItem;
    DeleteSelectedCert1: TMenuItem;
    Attachments: TNxButtonColumn;
    CreateCertDocument2: TMenuItem;
    CertType: TNxTextColumn;
    CreateAPTCert1: TMenuItem;
    CompanyCode: TNxTextColumn;
    CreateAPTApprovalCert1: TMenuItem;
    CompanyNation: TNxTextColumn;
    ImportVDRMasterFromXlsFile1: TMenuItem;
    N3: TMenuItem;
    CertNoFormat1: TMenuItem;
    ReportNo: TNxTextColumn;
    VDRSerialNo: TNxTextColumn;
    PlaceOfSurvey: TNxTextColumn;
    VDRType: TNxTextColumn;
    ClassSociety: TNxTextColumn;
    OwnerName: TNxTextColumn;
    ShipName: TNxTextColumn;
    IMONo: TNxTextColumn;
    HullNo: TNxTextColumn;
    PICEmail: TNxTextColumn;
    PICPhone: TNxTextColumn;
    APTServiceDate: TNxTextColumn;
    OrderNo: TNxTextColumn;
    SalesAmount: TNxTextColumn;
    N4: TMenuItem;
    Panel3: TPanel;
    JvLabel2: TJvLabel;
    PeriodPanel: TCurvyPanel;
    Label4: TLabel;
    rg_period: TAdvOfficeRadioGroup;
    dt_begin: TDateTimePicker;
    dt_end: TDateTimePicker;
    ComboBox1: TComboBox;
    Panel4: TPanel;
    Panel2: TPanel;
    JvLabel1: TJvLabel;
    JvLabel5: TJvLabel;
    JvLabel4: TJvLabel;
    ProdTypeCB: TComboBox;
    CertNoEdit: TEdit;
    CompanyNameEdit: TAdvEditBtn;
    EducationPanel: TPanel;
    JvLabel6: TJvLabel;
    JvLabel3: TJvLabel;
    JvLabel7: TJvLabel;
    TraineeNameEdit: TEdit;
    CourseEdit: TNxButtonEdit;
    Panel5: TPanel;
    JvLabel23: TJvLabel;
    IMONoEdit: TNxButtonEdit;
    JvLabel19: TJvLabel;
    ShipNameEdit: TNxButtonEdit;
    JvLabel21: TJvLabel;
    HullNoEdit: TNxButtonEdit;
    IsIgnoreInvoice: TNxCheckBoxColumn;
    Panel6: TPanel;
    InvoiceIssueDate: TNxDateColumn;
    BillPaidDate: TNxDateColumn;
    Notes: TNxTextColumn;
    CreateAPTServiceCertWithIMO1: TMenuItem;
    CreateInvoceFromSelected1: TMenuItem;
    N5: TMenuItem;
    iSwitchLed3: TiSwitchLed;
    APTResultGrp: TGroupBox;
    SuccessedCheck: TCheckBox;
    CancelledCheck: TCheckBox;
    FailedCheck: TCheckBox;
    NoResultCheck: TCheckBox;
    atiff1: TMenuItem;
    ViewTariff1: TMenuItem;
    EditTariff1: TMenuItem;
    AsPDF1: TMenuItem;
    AsXls1: TMenuItem;
    SetInvoiceNo1: TMenuItem;
    SetConfig1: TMenuItem;
    EmailCount: TNxButtonColumn;
    InvoiceConfirmDate: TNxDateColumn;
    Panel7: TPanel;
    InoiceConfirmGroup: TGroupBox;
    InvoiceConfirmedCheck: TCheckBox;
    InvoiceNotConfirmedCheck: TCheckBox;
    iSwitchLed4: TiSwitchLed;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    GroupBox1: TGroupBox;
    EducationCheck: TCheckBox;
    APTServiceCheck: TCheckBox;
    APTApprovalCheck: TCheckBox;
    JvLabel8: TJvLabel;
    SetFildCondCB: TComboBox;
    iSwitchLed1: TiSwitchLed;
    InvoiceGrp: TGroupBox;
    InvoiceIssuedCheck: TCheckBox;
    InvoiceNotIssuedCheck: TCheckBox;
    InvoiceIgnoreCheck: TCheckBox;
    iSwitchLed2: TiSwitchLed;
    BillGrp: TGroupBox;
    BillPaidCheck: TCheckBox;
    IsNotBillPaidCheck: TCheckBox;
    PopupMenu2: TPopupMenu;
    CreateAPTServiceCertWithIMO2: TMenuItem;
    SetInvoiceIssueDateFromSelected1: TMenuItem;
    Button1: TButton;
    SetInvoiceConfirmDateFromSelected1: TMenuItem;
    N6: TMenuItem;
    SetNotesFromSelected1: TMenuItem;
    Help1: TMenuItem;
    Abou1: TMenuItem;
    AdjustMailCountFromDB1: TMenuItem;
    UpdateShipNameFromVesselMasterToVDRList1: TMenuItem;
    APTResult: TNxTextColumn;
    SendEmail1: TMenuItem;
    N7: TMenuItem;
    CheckAPTServiceOnTime1: TMenuItem;
    Backup1: TMenuItem;
    CertDBTo1: TMenuItem;
    InvoiceCompanyName: TNxTextColumn;
    InvoiceCompanyCode: TNxTextColumn;
    InvoiceCompanyNatoin: TNxTextColumn;
    SetPaidBillDateFromSelected1: TMenuItem;
    ReturnCertListFromSelected1: TMenuItem;
    N8: TMenuItem;
    InvoiceEmail: TNxTextColumn;
    PopupMenu3: TPopupMenu;
    F21: TMenuItem;
    EducationEntrustCheck: TCheckBox;
    FormAbout1: TFormAbout;
    CreateLicenseFromSelected1: TMenuItem;
    LicenseCheckGrp: TAdvOfficeCheckGroup;
    TraineeNation: TNxTextColumn;
    IssueDate: TNxTextColumn;
    Within1Year: TNxTextColumn;
    Within6Month: TNxTextColumn;
    TraineeEmail: TNxTextColumn;
    MakePPTCertFromSelectd1: TMenuItem;
    N9: TMenuItem;
    Merge1: TMenuItem;
    Splite1: TMenuItem;
    SubjectEdit: TNxButtonEdit;
    ExpiredCB: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure rg_periodClick(Sender: TObject);
    procedure AeroButton1Click(Sender: TObject);
    procedure CertListGridCellDblClick(Sender: TObject; ACol, ARow: Integer);
    procedure Close1Click(Sender: TObject);
    procedure CompanyNameEditKeyPress(Sender: TObject; var Key: Char);
    procedure TraineeNameEditKeyPress(Sender: TObject; var Key: Char);
    procedure SubjectEditKeyPress(Sender: TObject; var Key: Char);
    procedure CourseEditKeyPress(Sender: TObject; var Key: Char);
    procedure CertNoEditKeyPress(Sender: TObject; var Key: Char);
    procedure Add1Click(Sender: TObject);
    procedure DeleteSelectedCert1Click(Sender: TObject);
    procedure AttachmentsButtonClick(Sender: TObject);
    procedure ImportVDRMasterFromXlsFile1Click(Sender: TObject);
    procedure CertNoFormat1Click(Sender: TObject);
    procedure CreateCertDocument2Click(Sender: TObject);
    procedure CreateAPTCert1Click(Sender: TObject);
    procedure CreateAPTApprovalCert1Click(Sender: TObject);
    procedure CompanyNameEditClickBtn(Sender: TObject);
    procedure SubjectEditButtonDown(Sender: TObject);
    procedure IMONoEditButtonClick(Sender: TObject);
    procedure ShipNameEditButtonClick(Sender: TObject);
    procedure HullNoEditButtonClick(Sender: TObject);
    procedure CourseEditButtonClick(Sender: TObject);
    procedure IMONoEditKeyPress(Sender: TObject; var Key: Char);
    procedure ShipNameEditKeyPress(Sender: TObject; var Key: Char);
    procedure HullNoEditKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox1Change(Sender: TObject);
    procedure iSwitchLed1Change(Sender: TObject);
    procedure iSwitchLed2Change(Sender: TObject);
    procedure CreateAPTServiceCertWithIMO1Click(Sender: TObject);
    procedure iSwitchLed3Change(Sender: TObject);
    procedure EditTariff1Click(Sender: TObject);
    procedure ViewTariff1Click(Sender: TObject);
    procedure AsPDF1Click(Sender: TObject);
    procedure AsXls1Click(Sender: TObject);
    procedure SetInvoiceNo1Click(Sender: TObject);
    procedure EmailCountButtonClick(Sender: TObject);
    procedure SetConfig1Click(Sender: TObject);
    procedure CreateNewCertClick(Sender: TObject);
    procedure iSwitchLed4Change(Sender: TObject);
    procedure SetFildCondCBChange(Sender: TObject);
    procedure CreateAPTServiceCertWithIMO2Click(Sender: TObject);
    procedure SetInvoiceIssueDateFromSelected1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SetInvoiceConfirmDateFromSelected1Click(Sender: TObject);
    procedure SetNotesFromSelected1Click(Sender: TObject);
    procedure Abou1Click(Sender: TObject);
    procedure AdjustMailCountFromDB1Click(Sender: TObject);
    procedure UpdateShipNameFromVesselMasterToVDRList1Click(Sender: TObject);
    procedure SetPaidBillDateFromSelected1Click(Sender: TObject);
    procedure ReturnCertListFromSelected1Click(Sender: TObject);
    procedure CompanyNameEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure CertListGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LicenseCheckGrpGroupCheckClick(Sender: TObject);
    procedure CreateLicenseFromSelected1Click(Sender: TObject);
    procedure Merge1Click(Sender: TObject);
    procedure Splite1Click(Sender: TObject);
    procedure EducationCheckClick(Sender: TObject);
  private
    FIniFileName: string;
    FDisplayCreateInvoceMenuItem: Boolean;
    FEgg: TEasternEgg;

    procedure InitEnum;
    procedure OnEasterEgg(msg: string);
    procedure ShowCertEditFormFromGrid(ARow: integer; AAttachPageView: Boolean=false);
    procedure GetCertList2Grid(AIsFromRemote: Boolean = False);
    procedure GetCertListFromVariant2Grid(ADoc: Variant);
    procedure GetLIcListFromVariant2Grid(ADoc: Variant);
    procedure SetCertListVisibleColumn;
    function GetCertSearchParam2Rec(var ACertSearchParamRec: TCertSearchParamRec): Boolean;
    procedure GetCertListFromLocal(ACertSearchParamRec: TCertSearchParamRec);
    procedure DeleteHGSFileDB(ARow: integer);
    procedure ExecuteSearch(Key: Char);
    procedure MakeCertXls(ARow: integer);
    procedure ShowCertNoFormat;
    procedure ShowSearchVesselForm(Sender: TObject);
    procedure GetVesselListByExcludeAPTDate(ACertSearchParamRec: TCertSearchParamRec);
    procedure GetVesselListFromVariant2Grid(ADoc: TDictionary<string, string>);
    procedure GetCertListWithinValidDate(ACertSearchParamRec: TCertSearchParamRec);

    procedure SetDefaultCond;
    procedure ClearCond;
    procedure SetNoServResltReplyCond;
    procedure SetNoInvoiceConfirmCond;
    procedure SetNoPaidCond;
    procedure SetLastQAPTListOnSuccess;
    procedure SetVesselListWithNoAPTInPeriod;
    procedure SetLicListBeforeExpired;

    procedure LoadConfigFromFile(AFileName: string = '');
    procedure LoadConfig2Form(AForm: TCertManageConfigF);
    procedure LoadConfigForm2Object(AForm: TCertManageConfigF);
    procedure SetConfig;

    procedure AdjustMailCountFromVDREmailDB;

    function UpdateShipNameFromVesselMasterToVDRList: integer;
  public
    FIsPopMode: Boolean;//다른 프로그램에서 Cert List를 조회하여 가져오기 위한 Mode

    class function GetDefaultInvoiceNo(ACompanyCode: string; AAPTDate: TDateTime): string;
    procedure CreateInvoice4VDRAPT(AFileKind: TJHPFileFormat; AIsOnlySelected: Boolean=False);
    procedure ShowInvoiceNoEditForm;
    procedure SetInvoiceNoFromSelected(AInvoiceNo: string);
    procedure ShowNoteEditForm;
    procedure SetNoteFromSelected(ANote: string);
    function ShowDateEditForm: TDate;
    procedure SetInvoiceIssueDateFromSelected;
    procedure SetInvoiceConfirmDateFromSelected;
    procedure SetPaidBillDateFromSelected;
    function GetCustInfoFromVar(ADoc: variant): string;
    function GetVDRAPTCertListFromGrid2StrList(AIsOnlySelected: Boolean): TStringList;
    //마지막 Select된 Item의 Company Name을 반환 함(Zip File Name에 사용함)
    function GetLicListFromGrid2StrList(var AList: TStringList): string;
    procedure GetCertFilesFromDocType2Grid;
    function GetEduCertTypeFromForm:THGSCertType;
    function IsLicenseCheckedFromForm: Boolean;
    procedure CreateZipFile4LicenseFromSelected;
    procedure SaveImageQRCodeFromFrame(AFileName: string; AOrm: TOrmHGSTrainLicense);
    function GetRemainedValidity(ADate: TDate): integer;
    procedure NextGridToExcel4License(ANextGrid: TNextGrid);
    procedure SetColIndexAry4License(var AColIndexAry: TArrayRecord<integer>);

    procedure MakeCertFromSelected(AIsMerge: Boolean);
  end;

function CreateCertManagerFormFromDB: string;

var
  CertManageF: TCertManageF;

implementation

uses DateUtils, UnitEnumHelper, FrmCertEdit2, UnitExcelUtil, UnitCryptUtil2,
  UnitMakeXls2, FrmCertNoFormat2, UnitHGSVDRRecord2, FrmSearchCustomer2, CommonData2,
  FrmCourseManage2, FrmSearchVessel2, UnitHGSVDRData, UnitDateUtil, UnitMakeReport2,
  UnitHGSCurriculumData2,
  {$IFDEF GAMANAGER}
  UnitGAMasterRecord2, UnitJHPFileRecord,
  {$ELSE}
  UElecDataRecord2, UElecDataRecord2,
  {$ENDIF}
  FrmEditTariff2, FrmInvoiceNoEdit, UnitOLEmailRecord2, FrmInvoiceIssueDateEdit,
  FrmNoteEdit, FrmAboutF, UnitFolderUtil2, UnitNextGridUtil2, FrmEmailListView2,
  UnitGAServiceData;

{$R *.dfm}

function CreateCertManagerFormFromDB: string;
var
  LCertManageF: TCertManageF;
  LCompanyList, LCertList: TStringList;
  i, j, LCount, LCount2, LMonth, LPrice: integer;
  LStr: string;
  LDoc_Invoice_Rec: Doc_Invoice_Rec;
  LUtf8: RawUTF8;
  LDynUtf8: TRawUTF8DynArray;
  LDynArr: TDynArray;
  LDoc: Variant;
begin
  Result := '';
  LCertManageF := TCertManageF.Create(nil);
  try
    with LCertManageF do
    begin
      FIsPopMode := True;

      if ShowModal = mrOK then
      begin
        InitCompanyMasterClient(Application.ExeName);
        LCompanyList := GetVDRAPTCertListFromGrid2StrList(True);
        LDynArr.Init(TypeInfo(TRawUTF8DynArray), LDynUtf8);
        TDocVariant.New(LDoc);

        for i := 0 to LCompanyList.Count - 1 do
        begin
          LCertList := LCompanyList.Objects[i] as TStringList;

          for j := 0 to LCertList.Count - 1 do
          begin
            LDoc_Invoice_Rec := Default(Doc_Invoice_Rec);
            LUtf8 := StringToUTF8(LCertList.Strings[j]);
            RecordLoadJSON(LDoc_Invoice_Rec, LUtf8, TypeInfo(Doc_Invoice_Rec));
            LDoc.CertNo := LDoc_Invoice_Rec.FSubject;
            LDoc.HullNo := LDoc_Invoice_Rec.FHullNo;
            LDoc.APTServiceDate := FormatDateTime('yyyy-mm-dd',LDoc_Invoice_Rec.FOnboardDate);
            LDoc.CompanyName_2 := LDoc_Invoice_Rec.FCustomerInfo;
            LDoc.CompanyCode_2 := LDoc_Invoice_Rec.FCompanyCode;

            LDoc.IMONo := LDoc_Invoice_Rec.FIMONo;
            LDoc.VDRSerialNo := LDoc_Invoice_Rec.FVDRSerialNo;
            LDoc.VDRType := LDoc_Invoice_Rec.FVDRType;
            LDoc.PlaceOfSurvey := LDoc_Invoice_Rec.FAPTPlace;
            LDoc.APTResult := LDoc_Invoice_Rec.FAPTResult;
            LDoc.ShipName := LDoc_Invoice_Rec.FShipName;
            LDoc.Email := LDoc_Invoice_Rec.FEmail;
            LDoc.InvoiceNo := LDoc_Invoice_Rec.FInvNo;

            LUtf8 := LDoc;
            LDynArr.Add(LUtf8);
          end;
        end;

        Result := LDynArr.SaveToJSON;;
      end;
    end;
  finally
    for i := 0 to LCompanyList.Count - 1 do
      TStringList(LCompanyList.Objects[i]).Free;
    LCompanyList.Free;
    LCertManageF.Free;
  end;
end;

procedure TCertManageF.Abou1Click(Sender: TObject);
begin
  FormAbout1.Show(False);
//  CreateNShowAboutForm;
end;

procedure TCertManageF.Add1Click(Sender: TObject);
var
  LMailList: string;
begin
  if CreateCertEditFormFromDB('','',True, LMailList, GetEduCertTypeFromForm()) = mrOK then
    GetCertList2Grid;
end;

procedure TCertManageF.AdjustMailCountFromDB1Click(Sender: TObject);
begin
  AdjustMailCountFromVDREmailDB;
end;

procedure TCertManageF.AdjustMailCountFromVDREmailDB;
var
  LProdCode, LEMailDBName, LCertNo: string;
  i, LProdType, LMailCount, LOrigMailCount: integer;//LCertType,
begin
  if CertListGrid.RowCount = 0 then
    exit;

  if ProdTypeCB.ItemIndex = -1 then
  begin
    ShowMessage('Please select the product type first.');
    exit;
  end;

//  if EducationCheck.Checked then
//    LCertType := Ord(hctEducation)
//  else
//  if APTServiceCheck.Checked then
//    LCertType := Ord(hctAPTService);

  LProdCode := ProdTypeCB.Text;
  LProdCode := GetProdCodeFromProdType(LProdCode);
  LEMailDBName := GetEMailDBName(Application.ExeName, LProdCode);
  InitOLEmailMsgClient(LEMailDBName);
  try
    for i := 0 to CertListGrid.RowCount - 1 do
    begin
      if LProdCode = CertListGrid.CellsByName['ProductType', i] then
      begin
        LCertNo := CertListGrid.CellsByName['CertNo', i];
        LOrigMailCount := StrToIntDef(CertListGrid.CellsByName['Email', i],0);
        LMailCount := GetEmailCountFromDBKey(LCertNo);

        if LMailCount <> LOrigMailCount then
        begin
          UpdateMailCountFromCertNo(LCertNo, LMailCount);
          TNxButtonColumn(CertListGrid.ColumnByName['Email']).Editor.Text := IntToStr(LMailCount);
        end;
      end;
    end;
  finally
    DestroyOLEmailMsg;
    ShowMessage('Complete Update MailCount Successfully!');
  end;
end;

procedure TCertManageF.AeroButton1Click(Sender: TObject);
begin
  if IsLicenseCheckedFromForm() then
    NextGridToExcel4License(CertListGrid)
  else
    NextGridToExcel(CertListGrid);
end;

procedure TCertManageF.AsPDF1Click(Sender: TObject);
begin
  CreateInvoice4VDRAPT(gfkPDF, True);
end;

procedure TCertManageF.AsXls1Click(Sender: TObject);
begin
  CreateInvoice4VDRAPT(gfkEXCEL, True);
end;

procedure TCertManageF.AttachmentsButtonClick(Sender: TObject);
begin
  if CertListGrid.SelectedRow = -1 then
    Exit;

  ShowCertEditFormFromGrid(CertListGrid.SelectedRow, True);
end;

procedure TCertManageF.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TCertManageF.btn_SearchClick(Sender: TObject);
begin
  GetCertList2Grid;
end;

procedure TCertManageF.Button1Click(Sender: TObject);
begin
  ClearCond;
end;

procedure TCertManageF.CertListGridCellDblClick(Sender: TObject; ACol,
  ARow: Integer);
begin
  if ARow = -1 then
    Exit;

  if FIsPopMode then
    ModalResult := mrOK
  else
    ShowCertEditFormFromGrid(ARow);
end;

procedure TCertManageF.CertListGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FEgg.CheckKeydown(Key, Shift);
end;

procedure TCertManageF.CertNoEditKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteSearch(Key);
end;

procedure TCertManageF.CertNoFormat1Click(Sender: TObject);
begin
  ShowCertNoFormat;
end;

procedure TCertManageF.ClearCond;
begin
  SetFildCondCB.ItemIndex := -1;
  ComboBox1.ItemIndex := -1;
  ProdTypeCB.ItemIndex := -1;
  ExpiredCB.ItemIndex := -1;
  CompanyNameEdit.Text := '';
  CertNoEdit.Text := '';
  SubjectEdit.Text := '';
  CourseEdit.Text := '';
  TraineeNameEdit.Text := '';
  IMONoEdit.Text := '';
  ShipNameEdit.Text := '';
  HullNoEdit.Text := '';

  SetDefaultCond;
end;

procedure TCertManageF.Close1Click(Sender: TObject);
begin
  Close;
end;

procedure TCertManageF.ComboBox1Change(Sender: TObject);
begin
  if ComboBox1.ItemIndex > 0 then
    rg_periodClick(nil);
end;

procedure TCertManageF.CompanyNameEditClickBtn(Sender: TObject);
var
  LSearchCustomerF: TSearchCustomerF;
begin
  LSearchCustomerF := TSearchCustomerF.Create(nil);
  try
    with LSearchCustomerF do
    begin
      FCompanyType := [ctAgent];

      if ShowModal = mrOk then
      begin
        if NextGrid1.SelectedRow <> -1 then
        begin
          Self.CompanyNameEdit.Text := NextGrid1.CellByName['CompanyName', NextGrid1.SelectedRow].AsString;
        end;
      end;
    end;
  finally
    LSearchCustomerF.Free;
  end;
end;

procedure TCertManageF.CompanyNameEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //Create Invoice Menu Show Toggle
  if Key = VK_F2 then
  begin
    FDisplayCreateInvoceMenuItem := not FDisplayCreateInvoceMenuItem;
  end;
end;

procedure TCertManageF.CompanyNameEditKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteSearch(Key);
end;

procedure TCertManageF.CourseEditButtonClick(Sender: TObject);
var
  LSubject, LCourseName, LContents: string;
begin
  if CreateCourseManageForm(LSubject, LCourseName, LContents) = mrOK then
  begin
    if LContents = '' then
      SubjectEdit.Text := LSubject
    else
      SubjectEdit.Text := LContents;

    CourseEdit.Text := LCourseName;
  end;
end;

procedure TCertManageF.CourseEditKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteSearch(Key);
end;

procedure TCertManageF.CreateAPTApprovalCert1Click(Sender: TObject);
var
  LMailList: string;
begin
  if CreateCertEditFormFromDB('', '', True,LMailList, hctProductApproval) = mrOK then
    GetCertList2Grid;
end;

procedure TCertManageF.CreateAPTCert1Click(Sender: TObject);
var
  LMailList: string;
begin
  if CreateCertEditFormFromDB('', '', True,LMailList, hctAPTService) = mrOK then
    GetCertList2Grid;
end;

procedure TCertManageF.CreateAPTServiceCertWithIMO1Click(Sender: TObject);
var
  LMailList: string;
begin
  if IMONoEdit.Text = '' then
  begin
    ShowMessage('IMO No. is empty.');
    exit;
  end;

  IMONoEdit.Text := System.SysUtils.Trim(IMONoEdit.Text);

  if CreateCertEditFormFromDB('', IMONoEdit.Text, True, LMailList, hctAPTService) = mrOK then
    GetCertList2Grid;
end;

procedure TCertManageF.CreateAPTServiceCertWithIMO2Click(Sender: TObject);
begin
  CreateAPTServiceCertWithIMO1Click(nil);
end;

procedure TCertManageF.CreateCertDocument2Click(Sender: TObject);
var
  LMailList: string;
  LHGSCertType: THGSCertType;
begin
  LHGSCertType := GetEduCertTypeFromForm();

  if CreateCertEditFormFromDB('', '', True,LMailList, LHGSCertType) = mrOK then
    GetCertList2Grid;
end;

procedure TCertManageF.CreateInvoice4VDRAPT(AFileKind: TJHPFileFormat;
  AIsOnlySelected: Boolean);
var
  LCompanyList: TStringList;
  i: integer;
begin
  DOC_DIR := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)+ 'db\files');
  {$IFDEF GAMANAGER}
  InitCompanyMasterClient('CompanyMaster.sqlite');
  {$ELSE}
  InitMasterClient(Application.ExeName);
  {$ENDIF}
  try
    LCompanyList := GetVDRAPTCertListFromGrid2StrList(AIsOnlySelected);
    MakeDocInvoice4VDRAPT(LCompanyList, AFileKind);
  finally
    for i := 0 to LCompanyList.Count - 1 do
      TStringList(LCompanyList.Objects[i]).Free;

    LCompanyList.Free;
  end;
end;

procedure TCertManageF.CreateLicenseFromSelected1Click(Sender: TObject);
begin
  CreateZipFile4LicenseFromSelected;
end;

procedure TCertManageF.CreateNewCertClick(Sender: TObject);
var
  LMailList: string;
begin
  CreateCertEditFormFromDB('', '', True, LMailList);
end;

procedure TCertManageF.CreateZipFile4LicenseFromSelected;
var
  LZip, LSubZip: TZipWrite;
  LZipFileName, LSubZipFileName, LPhotoFileName, LQRFileName, LXlsFileName, LCertNo, LCompanyName: string;
  LHGSLicRecord: TOrmHGSTrainLicense;
  LLicDataList: TStringList;
  i: integer;
  LVar: variant;
  LNextGrid: TNextGrid;
begin
  DOC_DIR := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)+ 'db\files');
  InitHGSLicenseClient(HGS_LIC_DB_NAME);
  LCompanyName := GetLicListFromGrid2StrList(LLicDataList);

  LZipFileName := GetZipFileName4Doc(LCompanyName);
  LNextGrid := TNextGrid.Create(Self);
  LNextGrid.Visible := False;
  LNextGrid.Parent := TWinControl(Self);
  LVar := GetGridColNames4LicenseList;
  //Grid에 Column Name 생성
  AddNextGridColumnFromVariant(LNextGrid, LVar, False, True);

  LZip := TZipWrite.Create(LZipFileName);//LTempDir+
  try
    for i := 0 to LLicDataList.Count - 1 do
    begin
      LVar := _JSON(LLicDataList.Strings[i]);
      AddNextGridRowFromVariant2(LNextGrid, LVar);
      LCertNo := VariantToString(TDocVariantData(LVar).Names[6]);
      LHGSLicRecord := GetHGSLicenseFromCertNo(LCertNo);

      if LHGSLicRecord.IsUpdate then
      begin
        LPhotoFileName := GetTempPhotoFileName(LCertNo);
        SaveImagePhotoFromHGSLicenseRecord(LPhotoFileName, LHGSLicRecord);

        LQRFileName := GetTempQRFileName(LCertNo);
        SaveImageQRCodeFromFrame(LQRFileName, LHGSLicRecord);


        LXlsFileName := GetTempAttendantListFN(LCertNo);
        NextGridToExcel(LNextGrid, '', LXlsFileName);

        if LLicDataList.Count = 1 then
        begin
          if FileExists(LPhotoFileName) then
            LZip.AddDeflated(LPhotoFileName);

          if FileExists(LQRFileName) then
            LZip.AddDeflated(LQRFileName);

          if FileExists(LXlsFileName) then
            LZip.AddDeflated(LXlsFileName);
        end
        else
        begin
          LSubZipFileName := ChangeFileExt(LXlsFileName, '.zip');
          LSubZip := TZipWrite.Create(LSubZipFileName);//LTempDir+
          try
            if FileExists(LPhotoFileName) then
              LSubZip.AddDeflated(LPhotoFileName);

            if FileExists(LQRFileName) then
              LSubZip.AddDeflated(LQRFileName);

            if FileExists(LXlsFileName) then
              LSubZip.AddDeflated(LXlsFileName);
          finally
            LSubZip.Free;

            if FileExists(LSubZipFileName) then
              LZip.AddDeflated(LSubZipFileName);

            DeleteFile(LSubZipFileName);
          end;
        end;

        if True then
        begin
          DeleteFile(GetTempPhotoFileName(LCertNo));
          DeleteFile(GetTempQRFileName(LCertNo));
          DeleteFile(GetTempAttendantListFN(LCertNo));
        end;
      end;
    end;//for
  finally
    FreeAndNil(LZip);
    LNextGrid.Free;
  end;
end;

procedure TCertManageF.DeleteHGSFileDB(ARow: integer);
var
  LDBFileName: string;
begin
  LDBFileName := CertListGrid.CellsByName['CertFileDBPath', ARow] +
    CertListGrid.CellsByName['CertFileDBName', ARow];

  if FileExists(LDBFileName) then
    DeleteFile(LDBFileName);
end;

procedure TCertManageF.DeleteSelectedCert1Click(Sender: TObject);
var
  LCertNo,
  LProdCode,
  LEMailDBName: string;
  LCertType: THGSCertType;
begin
  if CertListGrid.SelectedRow = -1 then
    exit;

  if MessageDlg('Selected Cert. will be deleted.' + #13#10 + 'Are you sure?',
    mtConfirmation, [mbYes, mbNo], 0)= mrNo then
    exit;

  LCertNo := CertListGrid.CellsByName['CertNo', CertListGrid.SelectedRow];

  if LCertNo <> '' then
  begin
    LCertType := GetEduCertTypeFromForm;

    if LCertType = hctNull then
    begin
      DeleteHGSCert(LCertNo);
    end
    else
    begin
      DeleteHGSLicense(LCertNo);
    end;

    DeleteHGSFileDB(CertListGrid.SelectedRow);

    LProdCode := CertListGrid.CellsByName['ProductType', CertListGrid.SelectedRow];
    LProdCode := GetProdCodeFromProdType(LProdCode);
    LEMailDBName := GetEMailDBName(Application.ExeName, LProdCode);
//    LEMailDBName := LEMailDBName.Replace('.exe', '_' + LProdCode + '.exe');
    InitOLEmailMsgClient(LEMailDBName);
    try
      DeleteOLMail2DBFromDBKey(LCertNo);
    finally
      DestroyOLEmailMsg;
    end;

    GetCertList2Grid;
    CertListGrid.ScrollToRow(CertListGrid.SelectedRow);
  end;
end;

procedure TCertManageF.EditTariff1Click(Sender: TObject);
begin
  DisplayTariffEditF;
end;

procedure TCertManageF.EducationCheckClick(Sender: TObject);
begin
//  LicenseCheckGrp.Enabled := EducationCheck.Checked;
end;

procedure TCertManageF.EmailCountButtonClick(Sender: TObject);
var
  LCertNo, LStr, LHullNo, LProdType: string;
  LUpdateMailCount,
  LOldMailCount: integer;
  LMailList: string;
begin
  LCertNo := CertListGrid.CellsByName['CertNo', CertListGrid.SelectedRow];
  LStr := CertListGrid.CellsByName['EmailCount', CertListGrid.SelectedRow];
  LOldMailCount := StrToIntDef(LStr, 0);
  LHullNo := CertListGrid.CellsByName['HullNo', CertListGrid.SelectedRow];
  LProdType := CertListGrid.CellsByName['ProductType', CertListGrid.SelectedRow];
//  LUpdateMailCount := CreateCertEditFormFromDB(LCertNo, '', False, LMailList);
  LUpdateMailCount := ShowEMailListFromCertNo(LCertNo, LHullNo, LProdType, FSettings.OLFolderListFileName);

  if (LUpdateMailCount > -1) and (LOldMailCount <> LUpdateMailCount) then
    TNxButtonColumn(CertListGrid.ColumnByName['Email']).Editor.Text := IntToStr(LUpdateMailCount);


//  ShowEMailListFromCertNo(CertListGrid.CellsByName['CertNo', CertListGrid.SelectedRow],
//    CertListGrid.CellsByName['HullNo', CertListGrid.SelectedRow],
//    CertListGrid.CellsByName['ProductType', CertListGrid.SelectedRow]
//    );
end;

procedure TCertManageF.ExecuteSearch(Key: Char);
begin
  if Key = Chr(VK_RETURN) then
    btn_SearchClick(nil);
end;

procedure TCertManageF.FormCreate(Sender: TObject);
begin
  InitEnum;
  InitHGSCertClient(HGS_CERT_DB_NAME);
  InitHGSLicenseClient(HGS_LIC_DB_NAME);
  InitClient4GSTariff(Application.ExeName);

  FIniFileName := ChangeFileExt(Application.ExeName, '.ini');
  FSettings := TCertManageConfig.create(FIniFileName);
  LoadConfigFromFile(FIniFileName);

  g_ShipProductType.SetType2Combo(ProdTypeCB);
//  g_RemainExpireDate.SetType2Combo(ExpiredCB);
  g_CertQueryDateType.SetType2Combo(ComboBox1);
  g_CertFindCondition.SetType2Combo(SetFildCondCB);

  dt_begin.Date := Date;
  dt_end.Date := Date;

  FEgg := TEasternEgg.Create('Reg',[ssCtrl],'REG',Self, OnEasterEgg);
//  FEgg.FOnEasterEgg := OnEasterEgg;
end;

procedure TCertManageF.FormDestroy(Sender: TObject);
begin
  FSettings.Free;
  FEgg.Free;
end;

procedure TCertManageF.GetCertFilesFromDocType2Grid;
begin

end;

procedure TCertManageF.GetCertList2Grid(AIsFromRemote: Boolean);
var
  LSQLHGSCertRecord: TSQLHGSCertRecord;
  LCertSearchParamRec: TCertSearchParamRec;
  LDoc: Variant;
begin
  CertListGrid.BeginUpdate;
  try
    SetCertListVisibleColumn;
    CertListGrid.ClearRows;
    if GetCertSearchParam2Rec(LCertSearchParamRec) then
    begin
      if LCertSearchParamRec.fQueryDate = cqdtExcludeAPTDate then
        GetVesselListByExcludeAPTDate(LCertSearchParamRec)
      else
      if (LCertSearchParamRec.fQueryDate = cqdtValidityUntilDate) and
        (LCertSearchParamRec.fFindCondition = cfcValidityUntilLicDate) then
        GetCertListWithinValidDate(LCertSearchParamRec)
      else

//    if AIsFromRemote then
//      GetVesselListFromRemote(LCertSearchParamRec)
//    else
      GetCertListFromLocal(LCertSearchParamRec);
    end;
  finally
    CertListGrid.EndUpdate;
  end;
end;

function TCertManageF.GetVDRAPTCertListFromGrid2StrList(
  AIsOnlySelected: Boolean): TStringList;
var
  i, LIdx, LCount, LMonth: integer;
  LDoc_Invoice_Rec: Doc_Invoice_Rec;
  LStr, LInvoiceNo, LCompanyName, LCompanyCode: string;
  LDoc: variant;
  LUtf8: RawUTF8;
  LAPTDate: TDateTime;
begin
  Result := TStringList.Create;

  for i := 0 to CertListGrid.RowCount - 1 do
  begin
    if AIsOnlySelected then
      if not CertListGrid.Row[i].Selected then
        continue;

    if (CertListGrid.CellsByName['ProductType', i] = 'VDR') and
      (CertListGrid.CellsByName['CertType', i] = 'APT Service') then
    begin
      LInvoiceNo := CertListGrid.CellsByName['OrderNo', i];

      LCompanyCode := CertListGrid.CellsByName['InvoiceCompanyCode', i];

      if LCompanyCode = '' then
        LCompanyCode := CertListGrid.CellsByName['CompanyCode', i];

      if LInvoiceNo = '' then
      begin
//          if MessageDlg('"Invoice No" is empty.' + #13#10 + 'Are you stop the process?',
//            mtConfirmation, [mbYes, mbNo],
//            0) = mrYes then
//          begin
//            ShowMessage('Invoice Creation is stopped!');
//            exit;
//          end;
        LAPTDate := StrToDate(CertListGrid.CellsByName['APTServiceDate', i]);
        LInvoiceNo := GetDefaultInvoiceNo(LCompanyCode, LAPTDate);
      end;

      LCompanyName := CertListGrid.CellsByName['InvoiceCompanyName', i];

      if LCompanyName = '' then
        LCompanyName := CertListGrid.CellsByName['CompanyName', i];

      LDoc := GetMasterCustomerFromCompanyCodeNName2Var(LCompanyCode, LCompanyName);

      if LDOC = null then
      begin
        ShowMessage('Company name(Code) : ' + LCompanyName + '(' + LCompanyCode + ')' + #13#10 +
          'is not exist in the CustomerMaster.sqlite!');
        continue;
      end;

      LIdx := Result.IndexOf(LCompanyName);

      if LIdx >= 0 then
      begin
//          LCount := TStringList(LCompanyList.Objects[LIdx]).Count;
//          Inc(LCount);
//          LCompanyList.Strings[LIdx] := LStr + '=' + IntToStr(LCount);
      end
      else
      begin
        LIdx := Result.Add(LCompanyName);
        Result.Objects[LIdx] := TStringList.Create;
      end;

      LDoc_Invoice_Rec.FCustomerInfo := GetCustInfoFromVar(LDoc);
      LDoc_Invoice_Rec.FCompanyCode := CertListGrid.CellsByName['CompanyCode', i];
      LDoc_Invoice_Rec.FCompanyName := CertListGrid.CellsByName['CompanyName', i];
      LDoc_Invoice_Rec.FInvNo := LInvoiceNo;
      LMonth := MonthOf(now);
      LDoc_Invoice_Rec.FInvDate := pjhShortMonthNames[LMonth] + '.' + FormatDateTime('dd, yyyy', now);
      LDoc_Invoice_Rec.FSubject := CertListGrid.CellsByName['CertNo', i];
      LDoc_Invoice_Rec.FHullNo := CertListGrid.CellsByName['HullNo', i];
      LDoc_Invoice_Rec.FShipName := CertListGrid.CellsByName['ShipName', i];
      LDoc_Invoice_Rec.FOnboardDate := StrToDate(CertListGrid.CellsByName['APTServiceDate', i]);

      LDoc_Invoice_Rec.FIMONo := CertListGrid.CellsByName['IMONo', i];
      LDoc_Invoice_Rec.FVDRSerialNo := CertListGrid.CellsByName['VDRSerialNo', i];
      LDoc_Invoice_Rec.FVDRType := CertListGrid.CellsByName['VDRType', i];
      LDoc_Invoice_Rec.FAPTPlace := CertListGrid.CellsByName['PlaceOfSurvey', i];
      LDoc_Invoice_Rec.FAPTResult := CertListGrid.CellsByName['APTResult', i];
      LDoc_Invoice_Rec.FEmail := CertListGrid.CellsByName['InvoiceEmail', i];

      LUtf8 := RecordSaveJson(LDoc_Invoice_Rec, TypeInfo(Doc_Invoice_Rec));
      LStr := UTF8ToString(LUtf8);
      TStringList(Result.Objects[LIdx]).Add(LStr);
      LDoc_Invoice_Rec := Default(Doc_Invoice_Rec);
    end;
  end;//for
end;

procedure TCertManageF.GetCertListFromLocal(
  ACertSearchParamRec: TCertSearchParamRec);
var
  LSQLHGSCertRecord: TSQLHGSCertRecord;
  LSQLHGSLicRecord: TOrmHGSTrainLicense;
  LDoc: Variant;
  LIsLicense: Boolean;
begin
  LIsLicense := IsLicenseCheckedFromCertTypes(ACertSearchParamRec.fCertTypes);

  if LIsLicense then
  begin
    LSQLHGSLicRecord := GetHGSLicenseRecordFromSearchRec(ACertSearchParamRec);
    try
      if LSQLHGSLicRecord.IsUpdate then
      begin
        LSQLHGSLicRecord.FillRewind;

        while LSQLHGSLicRecord.FillOne do
        begin
          LDoc := GetVariantFromHGSLicenseRecord(LSQLHGSLicRecord);
          GetLIcListFromVariant2Grid(LDoc);
        end;//while
      end;
    finally
      LSQLHGSLicRecord.Free;
    end;
  end
  else
  begin
    LSQLHGSCertRecord := GetHGSCertRecordFromSearchRec(ACertSearchParamRec);
    try
      if LSQLHGSCertRecord.IsUpdate then
      begin
        LSQLHGSCertRecord.FillRewind;

        while LSQLHGSCertRecord.FillOne do
        begin
          LDoc := GetVariantFromHGSCertRecord(LSQLHGSCertRecord);
  //        LDoc.EmailCount := GetEmailCountFromDBKey(LDoc.CertNo);
          GetCertListFromVariant2Grid(LDoc);
        end;//while
      end;
    finally
      LSQLHGSCertRecord.Free;
    end;
  end;

  StatusBarPro1.Panels[1].Text := IntToStr(CertListGrid.RowCount);
end;

procedure TCertManageF.GetCertListFromVariant2Grid(ADoc: Variant);
var
  LRow: integer;
  LShipProductTypes,
  LAPTResult: integer;
begin
  with CertListGrid do
  begin
    LRow := AddRow;

    CellsByName['CertNo', LRow] := ADoc.CertNo;
    CellsByName['TraineeName', LRow] := ADoc.TraineeName;
    CellsByName['CompanyName', LRow] := ADoc.CompanyName;
    CellsByName['CompanyCode', LRow] := ADoc.CompanyCode;
    CellsByName['CompanyNation', LRow] := ADoc.CompanyNatoin;
    CellsByName['OrderNo', LRow] := ADoc.OrderNo;
    CellsByName['SalesAmount', LRow] := ADoc.SalesAmount;
    CellsByName['TrainedSubject', LRow] := ADoc.TrainedSubject;
    CellsByName['TrainedCourse', LRow] := ADoc.TrainedCourse;
    CellsByName['CertFileDBPath', LRow] := ADoc.CertFileDBPath;
    CellsByName['CertFileDBName', LRow] := ADoc.CertFileDBName;
    CellByName['IsIgnoreInvoice', LRow].AsBoolean := StrToBool(ADoc.IsIgnoreInvoice);
    CellsByName['Notes', LRow] := ADoc.Notes;

    CellsByName['ReportNo', LRow] := ADoc.ReportNo;
    CellsByName['PlaceOfSurvey', LRow] := ADoc.PlaceOfSurvey;
    CellsByName['VDRType', LRow] := ADoc.VDRType;
    CellsByName['VDRSerialNo', LRow] := ADoc.VDRSerialNo;
    CellsByName['ClassSociety', LRow] := ADoc.ClassSociety;
    CellsByName['OwnerName', LRow] := ADoc.OwnerName;
    CellsByName['ShipName', LRow] := ADoc.ShipName;
    CellsByName['IMONo', LRow] := ADoc.IMONo;
    CellsByName['HullNo', LRow] := ADoc.HullNo;
    CellsByName['PICEmail', LRow] := ADoc.PICEmail;
    CellsByName['PICPhone', LRow] := ADoc.PICPhone;
    CellsByName['OrderNo', LRow] := ADoc.OrderNo;
    CellsByName['SalesAmount', LRow] := ADoc.SalesAmount;

    CellsByName['InvoiceCompanyName', LRow] := ADoc.InvoiceCompanyName;
    CellsByName['InvoiceCompanyCode', LRow] := ADoc.InvoiceCompanyCode;
    CellsByName['InvoiceCompanyNatoin', LRow] := ADoc.InvoiceCompanyNatoin;

    if ADoc.MailCount > 0 then
      CellByName['EmailCount', LRow].AsInteger := ADoc.MailCount;

    LAPTResult := ADoc.APTResult;
    CellsByName['APTResult', LRow] := g_VDRAPTResult.ToString(LAPTResult);

    if ADoc.APTServiceDate > 127489752310 then
      CellsByName['APTServiceDate', LRow] := DateToStr(TimeLogToDateTime(ADoc.APTServiceDate));

    if ADoc.InvoiceIssueDate > 127489752310 then
      CellsByName['InvoiceIssueDate', LRow] := DateToStr(TimeLogToDateTime(ADoc.InvoiceIssueDate));

    if ADoc.InvoiceConfirmDate > 127489752310 then
      CellsByName['InvoiceConfirmDate', LRow] := DateToStr(TimeLogToDateTime(ADoc.InvoiceConfirmDate));

    if ADoc.BillPaidDate > 127489752310 then
      CellsByName['BillPaidDate', LRow] := DateToStr(TimeLogToDateTime(ADoc.BillPaidDate));

    LShipProductTypes := ADoc.ProductType;
    CellsByName['ProductType', LRow] := g_ShipProductType.ToString(LShipProductTypes);
    CellsByName['CertType', LRow] := g_HGSCertType.ToString(ADoc.CertType);

    if ADoc.TrainedBeginDate > 127489752310 then
      CellsByName['TrainedBeginDate', LRow] := DateToStr(TimeLogToDateTime(ADoc.TrainedBeginDate));
    if ADoc.TrainedEndDate > 127489752310 then
      CellsByName['TrainedEndDate', LRow] := DateToStr(TimeLogToDateTime(ADoc.TrainedEndDate));
    if ADoc.UntilValidity > 127489752310 then
      CellsByName['UntilValidity', LRow] := DateToStr(TimeLogToDateTime(ADoc.UntilValidity));
    if ADoc.UpdateDate > 127489752310 then
      CellsByName['UpdateDate', LRow] := DateToStr(TimeLogToDateTime(ADoc.UpdateDate));

    CellByName['Attachments', LRow].AsInteger := ADoc.FileCount;
//    High(TIDList4Invoice(AGrid.Row[i].Data).fInvoiceFile.Files)+1;
  end;
end;

procedure TCertManageF.GetCertListWithinValidDate(
  ACertSearchParamRec: TCertSearchParamRec);
var
  LSQLHGSLicRecord: TOrmHGSTrainLicense;
  LDoc: Variant;
  LUtf8: RawUTF8;
begin
//  ACertSearchParamRec.fQueryDate := cqdtValidityUntilLicDate;
  LSQLHGSLicRecord := GetHGSLicenseRecordFromSearchRec(ACertSearchParamRec);
  try
    if LSQLHGSLicRecord.IsUpdate then
    begin
      LSQLHGSLicRecord.FillRewind;

      while LSQLHGSLicRecord.FillOne do
      begin
        LDoc := GetVariantFromHGSLicenseRecord(LSQLHGSLicRecord);
        GetLIcListFromVariant2Grid(LDoc);
      end;//while
    end;
  finally
    LSQLHGSLicRecord.Free;
  end;
end;

function TCertManageF.GetCertSearchParam2Rec(
  var ACertSearchParamRec: TCertSearchParamRec): Boolean;
var
  LCertQueryDateType: TCertQueryDateType;
  LCertFindCondition: TCertFindCondition;
begin
  Result := (InvoiceIssuedCheck.Checked) or (InvoiceNotIssuedCheck.Checked);

  if not Result then
  begin
    ShowMessage('Invoice check shoulde be checked at least one');
    exit;
  end;

  Result := (BillPaidCheck.Checked) or (IsNotBillPaidCheck.Checked);

  if not Result then
  begin
    ShowMessage('(BillPaid check shoulde be checked at least one');
    exit;
  end;

  ACertSearchParamRec := Default(TCertSearchParamRec);

  if ComboBox1.ItemIndex = -1 then
    LCertQueryDateType := cqdtNull
  else
    LCertQueryDateType := g_CertQueryDateType.ToType(ComboBox1.ItemIndex);

  if SetFildCondCB.ItemIndex = -1 then
    LCertFindCondition := cfcNull
  else
    LCertFindCondition := g_CertFindCondition.ToType(SetFildCondCB.ItemIndex);

  ACertSearchParamRec.fQueryDate := LCertQueryDateType;
  ACertSearchParamRec.fFindCondition := LCertFindCondition;
  ACertSearchParamRec.FFrom := DateOf(dt_Begin.Date);//DateOf() : 시간 부분을 0으로
  ACertSearchParamRec.FTo := GetEndTimeOfTheDay(dt_end.Date);
  ACertSearchParamRec.fCertNo := System.SysUtils.Trim(CertNoEdit.Text);
  ACertSearchParamRec.fTraineeName := TraineeNameEdit.Text;
  ACertSearchParamRec.fCompanyName := CompanyNameEdit.Text;
  ACertSearchParamRec.fTrainedSubject := SubjectEdit.Text;
  ACertSearchParamRec.fTrainedCourse := CourseEdit.Text;
  ACertSearchParamRec.fIMONo := System.SysUtils.Trim(IMONoEdit.Text);
  ACertSearchParamRec.fShipName := System.SysUtils.Trim(ShipNameEdit.Text);
  ACertSearchParamRec.fHullNo := System.SysUtils.Trim(HullNoEdit.Text);

  ACertSearchParamRec.fIsInvoiceIssued := InvoiceIssuedCheck.Checked;
  ACertSearchParamRec.fIsNotInvoiceIssued := InvoiceNotIssuedCheck.Checked;
  ACertSearchParamRec.fIsInvoiceConfirmed := InvoiceConfirmedCheck.Checked;
  ACertSearchParamRec.fIsNotInvoiceConfirmed := InvoiceNotConfirmedCheck.Checked;
  ACertSearchParamRec.fIsBillPaid := BillPaidCheck.Checked;
  ACertSearchParamRec.fIsNotBillPaid := IsNotBillPaidCheck.Checked;
  ACertSearchParamRec.fIsAPTResult_NoResult := NoResultCheck.Checked;
  ACertSearchParamRec.fIsAPTResult_Successed := SuccessedCheck.Checked;
  ACertSearchParamRec.fIsAPTResult_Canceled := CancelledCheck.Checked;
  ACertSearchParamRec.fIsAPTResult_Failed := FailedCheck.Checked;
  ACertSearchParamRec.fIsIgnoreInvoice := InvoiceIgnoreCheck.Checked;

//  if not(EducationCheck.Checked and APTServiceCheck.Checked and APTApprovalCheck.Checked and
//    EducationEntrustCheck.Checked and LicBasicCheck.Checked and LicIntCheck.Checked and LicAdvCheck.Checked) then
//  begin
//    if EducationCheck.Checked then
//      ACertSearchParamRec.fCertType := hctEducation
//    else
//    if APTServiceCheck.Checked then
//      ACertSearchParamRec.fCertType := hctAPTService
//    else
//    if APTApprovalCheck.Checked then
//      ACertSearchParamRec.fCertType := hctProductApproval
//    else
//    if EducationEntrustCheck.Checked then
//      ACertSearchParamRec.fCertType := hctEducation_Entrust
//    else
//    if LicBasicCheck.Checked then
//      ACertSearchParamRec.fCertType := hctLicBasic
//    else
//    if LicIntCheck.Checked then
//      ACertSearchParamRec.fCertType := hctLicInter
//    else
//    if LicAdvCheck.Checked then
//      ACertSearchParamRec.fCertType := hctLicAdv;
//  end;

  if EducationCheck.Checked then
    Include(ACertSearchParamRec.fCertTypes, hctEducation);
//    ACertSearchParamRec.fCertTypes := ACertSearchParamRec.fCertTypes + hctEducation;

  if APTServiceCheck.Checked then
    Include(ACertSearchParamRec.fCertTypes, hctAPTService);

  if APTApprovalCheck.Checked then
    Include(ACertSearchParamRec.fCertTypes, hctProductApproval);

  if EducationEntrustCheck.Checked then
    Include(ACertSearchParamRec.fCertTypes, hctEducation_Entrust);

  if LicenseCheckGrp.Checked[0] then
    Include(ACertSearchParamRec.fCertTypes, hctLicBasic);

  if LicenseCheckGrp.Checked[1] then
    Include(ACertSearchParamRec.fCertTypes, hctLicInter);

  if LicenseCheckGrp.Checked[2] then
    Include(ACertSearchParamRec.fCertTypes, hctLicAdv);

  if ProdTypeCB.ItemIndex = -1 then
    ACertSearchParamRec.fProductType := g_ShipProductType.ToType(0)
  else
    ACertSearchParamRec.fProductType := g_ShipProductType.ToType(ProdTypeCB.ItemIndex);

  Result := True;
end;

function TCertManageF.GetCustInfoFromVar(ADoc: variant): string;
begin
  Result := ADoc.CompanyName + #13#10 + #13#10;
  Result := Result + ADoc.CompanyAddress;// + #13#10;
//  Result := Result + ADoc.CompanyAddress + #13#10;
end;

class function TCertManageF.GetDefaultInvoiceNo(ACompanyCode: string; AAPTDate: TDateTime): string;
var
  LQuarter: Word;
begin
  LQuarter := QuarterOf(AAPTDate);
  Result := ACompanyCode + '_' + IntToStr(YearOf(AAPTDate)) + 'Q' + IntToStr(LQuarter);
end;

function TCertManageF.GetEduCertTypeFromForm: THGSCertType;
begin
  if EducationCheck.Checked then
    Result := hctEducation
  else if EducationEntrustCheck.Checked then
    Result := hctEducation_Entrust
  else
  if LicenseCheckGrp.Checked[0] then
    Result := hctLicBasic
  else
  if LicenseCheckGrp.Checked[1] then
    Result := hctLicInter
  else
  if LicenseCheckGrp.Checked[2] then
    Result := hctLicAdv
  else
    Result := hctNull;
end;

function TCertManageF.GetLicListFromGrid2StrList(var AList: TStringList): string;
var
  i: integer;
  LCertNo: string;
  LLicData4Xls: variant;
begin
  Result := '';
  AList := TStringList.Create;

  for i := 0 to CertListGrid.RowCount - 1 do
  begin
    if not CertListGrid.Row[i].Selected then
      continue;

    LCertNo := CertListGrid.CellsByName['CertNo', i];

    if CheckIsLicenseFromLicNo(LCertNo) then
    begin
      LLicData4Xls := GetLicenseData4XlsFromCertNo(LCertNo);
      AList.Add(VariantToString(LLicData4Xls));
      Result := CertListGrid.CellsByName['CompanyName', i];
    end;
  end;
end;

procedure TCertManageF.GetLIcListFromVariant2Grid(ADoc: Variant);
var
  LRow: integer;
  LShipProductTypes,
  LValidity: integer;
begin
  with CertListGrid do
  begin
    LRow := AddRow;

    CellsByName['CertNo', LRow] := ADoc.CertNo;
    CellsByName['TraineeName', LRow] := ADoc.TraineeName;
    CellsByName['TraineeNation', LRow] := ADoc.TraineeNation;
    CellsByName['CompanyName', LRow] := ADoc.CompanyName;
    CellsByName['CompanyCode', LRow] := ADoc.CompanyCode;
    CellsByName['CompanyNation', LRow] := ADoc.CompanyNatoin;
    CellsByName['OrderNo', LRow] := ADoc.OrderNo;
    CellsByName['SalesAmount', LRow] := ADoc.SalesAmount;
    CellsByName['TrainedSubject', LRow] := ADoc.TrainedSubject;
    CellsByName['TrainedCourse', LRow] := ADoc.TrainedCourse;
    CellsByName['CertFileDBPath', LRow] := ADoc.CertFileDBPath;
    CellsByName['CertFileDBName', LRow] := ADoc.CertFileDBName;
    CellByName['IsIgnoreInvoice', LRow].AsBoolean := StrToBool(ADoc.IsIgnoreInvoice);
    CellsByName['Notes', LRow] := ADoc.Notes;

//    CellsByName['PICEmail', LRow] := ADoc.PICEmail;
//    CellsByName['PICPhone', LRow] := ADoc.PICPhone;
    CellsByName['OrderNo', LRow] := ADoc.OrderNo;
    CellsByName['SalesAmount', LRow] := ADoc.SalesAmount;

    CellsByName['InvoiceCompanyName', LRow] := ADoc.InvoiceCompanyName;
    CellsByName['InvoiceCompanyCode', LRow] := ADoc.InvoiceCompanyCode;
    CellsByName['InvoiceCompanyNatoin', LRow] := ADoc.InvoiceCompanyNatoin;

    if ADoc.MailCount > 0 then
      CellByName['EmailCount', LRow].AsInteger := ADoc.MailCount;

    if ADoc.InvoiceIssueDate > 127489752310 then
      CellsByName['InvoiceIssueDate', LRow] := DateToStr(TimeLogToDateTime(ADoc.InvoiceIssueDate));

    if ADoc.InvoiceConfirmDate > 127489752310 then
      CellsByName['InvoiceConfirmDate', LRow] := DateToStr(TimeLogToDateTime(ADoc.InvoiceConfirmDate));

    if ADoc.BillPaidDate > 127489752310 then
      CellsByName['BillPaidDate', LRow] := DateToStr(TimeLogToDateTime(ADoc.BillPaidDate));

    LShipProductTypes := ADoc.ProductType;
    CellsByName['ProductType', LRow] := g_ShipProductType.ToString(LShipProductTypes);
    CellsByName['CertType', LRow] := g_AcademyCourseLevelDesc.ToString(ADoc.CourseLevel);// g_HGSCertType.ToString(ADoc.CertType);

    if ADoc.TrainedBeginDate > 127489752310 then
      CellsByName['TrainedBeginDate', LRow] := DateToStr(TimeLogToDateTime(ADoc.TrainedBeginDate));

    if ADoc.TrainedEndDate > 127489752310 then
      CellsByName['TrainedEndDate', LRow] := DateToStr(TimeLogToDateTime(ADoc.TrainedEndDate));

    if ADoc.UntilValidity > 127489752310 then
      CellsByName['UntilValidity', LRow] := DateToStr(TimeLogToDateTime(ADoc.UntilValidity));

    if ADoc.IssueDate > 127489752310 then
      CellsByName['IssueDate', LRow] := DateToStr(TimeLogToDateTime(ADoc.IssueDate));

    if ADoc.UpdateDate > 127489752310 then
      CellsByName['UpdateDate', LRow] := DateToStr(TimeLogToDateTime(ADoc.UpdateDate));

    CellByName['Attachments', LRow].AsInteger := ADoc.FileCount;
//    High(TIDList4Invoice(AGrid.Row[i].Data).fInvoiceFile.Files)+1;

    LValidity := GetRemainedValidity(TimeLogToDateTime(ADoc.UntilValidity));

    if LValidity > 0 then
    begin
      if LValidity < 180 then
        CellsByName['Within6Month', LRow] := 'O';
//        CellByName['Within6Month', LRow].AsInteger := 1;

      if LValidity < 365 then
        CellsByName['Within1Year', LRow] := 'O';
//        CellByName['Within1Year', LRow].AsInteger := 1;
    end;
  end;
end;

function TCertManageF.GetRemainedValidity(ADate: TDate): integer;
begin
  Result := DaysBetween(now, ADate);
end;

procedure TCertManageF.GetVesselListByExcludeAPTDate(ACertSearchParamRec: TCertSearchParamRec);
var
  LSQLHGSCertRecord: TSQLHGSCertRecord;
  LSQLHGSVDRRecord: TSQLHGSVDRRecord;
  LVDRSearchParamRec: TVDRSearchParamRec;
  LDoc: Variant;
  LUtf8: RawUTF8;
  LDic: TDictionary<string, string>;
begin
  ACertSearchParamRec.fQueryDate := cqdtAPTServiceDate;
  LSQLHGSCertRecord := GetHGSCertRecordFromSearchRec(ACertSearchParamRec);
  LDic := TDictionary<string, string>.Create;
  try
    if LSQLHGSCertRecord.IsUpdate then
    begin
      LSQLHGSCertRecord.FillRewind;
      InitHGSVDRClient(HGS_VDRLIST_DB_NAME);
      try
        LVDRSearchParamRec := Default(TVDRSearchParamRec);
        LSQLHGSVDRRecord := GetHGSVDRRecordFromSearchRec(LVDRSearchParamRec);
        LSQLHGSVDRRecord.FillRewind;

        //VDR List를 TDictionary에 저장함
        while LSQLHGSVDRRecord.FillOne do
        begin
          LUtf8 := LSQLHGSVDRRecord.GetJSONValues(true, true, soSelect);

          if LSQLHGSVDRRecord.IMONo <> '' then
            LDic.Add(LSQLHGSVDRRecord.IMONo, UTF8ToString(LUtf8));
        end;//while
      finally
        DestroyHGSVDR;
      end;

      StatusBarPro1.Panels[1].Text := IntToStr(LDic.Count);

      while LSQLHGSCertRecord.FillOne do
      begin
        //해당 기간에 APT 수행 이력(NoResult, Succeed)이 있으면 Dictionary에서 삭제
        if LDic.ContainsKey(LSQLHGSCertRecord.IMONo) then
          LDic.Remove(LSQLHGSCertRecord.IMONo);
      end;//while

      GetVesselListFromVariant2Grid(LDic);
//      StatusBarPro1.Panels[1].Text := IntToStr(CertListGrid.RowCount);
    end;
  finally
    LSQLHGSCertRecord.Free;
    LDic.Free;
  end;
end;

procedure TCertManageF.GetVesselListFromVariant2Grid(ADoc: TDictionary<string, string>);
var
  LJson: string;
  LDoc: variant;
  LRow: integer;
  LSQLVesselMaster: TSQLVesselMaster;
  LSQLHGSCertRecord: TSQLHGSCertRecord;
  LCertSearchParamRec: TCertSearchParamRec;
begin
  TDocVariant.New(LDoc);
  InitVesselMasterClient(GetDefaultDBPath+HGS_VESSELMASTER_DB_NAME);
  LCertSearchParamRec := Default(TCertSearchParamRec);

  with CertListGrid do
  begin
    ClearRows();

    for LJson in ADoc.Values do
    begin
      LRow := AddRow();
      LDoc := _Json(StringToUtf8(LJson));
      CellsByName['VDRType', LRow] := LDoc.VDRType;
      CellsByName['VDRSerialNo', LRow] := LDoc.VDRSerialNo;
      CellsByName['IMONo', LRow] := LDoc.IMONo;

      if LDoc.IMONo <> '' then
      begin
        LSQLVesselMaster := GetVesselMasterFromIMONo(LDoc.IMONo);
        try
          if LSQLVesselMaster.IsUpdate then
          begin
            CellsByName['ShipName', LRow] := LSQLVesselMaster.ShipName;
            CellsByName['HullNo', LRow] := LSQLVesselMaster.HullNo;
            CellsByName['OwnerName', LRow] := LSQLVesselMaster.OwnerName;
            CellsByName['ClassSociety', LRow] := LSQLVesselMaster.SClass1;
          end;
        finally
          LSQLVesselMaster.Free;
        end;

        LCertSearchParamRec.fIMONo := LDoc.IMONo;
        LCertSearchParamRec.fOrderBy := 'Order by APTServiceDate Desc';
        LSQLHGSCertRecord := GetHGSCertRecordFromSearchRec(LCertSearchParamRec);
        try
          if LSQLHGSCertRecord.IsUpdate then
          begin
//            if LSQLHGSCertRecord.FillTable.RowCount > 1 then
//            begin
//              LSQLHGSCertRecord.FillRewind;
//              LSQLHGSCertRecord.FillOne();
//            end;

            CellsByName['APTServiceDate', LRow] := DateToStr(TimeLogToDateTime(LSQLHGSCertRecord.APTServiceDate));
            CellsByName['CompanyName', LRow] := LSQLHGSCertRecord.CompanyName;
            CellsByName['CompanyCode', LRow] := LSQLHGSCertRecord.CompanyCode;
            CellsByName['CompanyNation', LRow] := LSQLHGSCertRecord.CompanyNatoin;
            CellsByName['APTResult', LRow] := g_VDRAPTResult.ToString(LSQLHGSCertRecord.APTResult);
          end;
        finally
          LSQLHGSCertRecord.Free;
        end;
      end
      else
      begin
        CellsByName['ShipName', LRow] := LDoc.ShipName;
        CellsByName['HullNo', LRow] := LDoc.HullNo;
      end;
    end;
  end;
end;

procedure TCertManageF.HullNoEditButtonClick(Sender: TObject);
begin
  ShowSearchVesselForm(Sender);
end;

procedure TCertManageF.HullNoEditKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteSearch(Key);
end;

procedure TCertManageF.IMONoEditButtonClick(Sender: TObject);
begin
  ShowSearchVesselForm(Sender);
end;

procedure TCertManageF.IMONoEditKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteSearch(Key);
end;

procedure TCertManageF.ImportVDRMasterFromXlsFile1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    if FileExists(OpenDialog1.FileName) then
    begin
      InitHGSVDRClient(HGS_VDRLIST_DB_NAME);
      try
        ImportVDRMasterFromXlsFile(OpenDialog1.FileName);
      finally
        DestroyHGSVDR;
      end;
    end;
  end;
end;

procedure TCertManageF.InitEnum;
begin
  g_ElecProductType.InitArrayRecord(R_ElecProductType);
  g_ElecProductDetailType.InitArrayRecord(R_ElecProductDetailType);
  g_ShipProductType.InitArrayRecord(R_ShipProductType);
  g_ShipProductCode.InitArrayRecord(R_ShipProductCode);
  g_CertQueryDateType.InitArrayRecord(R_CertQueryDateType);
  g_HGSCertType.InitArrayRecord(R_HGSCertType);
  g_HGSCertTypeCode.InitArrayRecord(R_HGSCertTypeCode);
  g_CertFindCondition.InitArrayRecord(R_CertFindCondition);
  g_HGSCertDocType.InitArrayRecord(R_HGSCertDocType);
  g_VDRAPTResult.InitArrayRecord(R_VDRAPTResult);
  g_ContainData4Mail.InitArrayRecord(R_ContainData4Mail);
  g_ProcessDirection.InitArrayRecord(R_ProcessDirection);
  g_AcademyCourseLevelDesc.InitArrayRecord(R_AcademyCourseLevelDesc);
//  g_RemainExpireDate.InitArrayRecord(R_RemainExpireDate);
end;

function TCertManageF.IsLicenseCheckedFromForm: Boolean;
var
  LHGSCertType: THGSCertType;
begin
  LHGSCertType := GetEduCertTypeFromForm;

  Result := IsLicenseCheckedFromCertType(LHGSCertType);
end;

procedure TCertManageF.iSwitchLed1Change(Sender: TObject);
begin
  InvoiceGrp.Enabled := iSwitchLed1.Active;
end;

procedure TCertManageF.iSwitchLed2Change(Sender: TObject);
begin
  BillGrp.Enabled := iSwitchLed2.Active;
end;

procedure TCertManageF.iSwitchLed3Change(Sender: TObject);
begin
  APTResultGrp.Enabled := iSwitchLed3.Active;
end;

procedure TCertManageF.iSwitchLed4Change(Sender: TObject);
begin
  InoiceConfirmGroup.Enabled := iSwitchLed4.Active;
end;

procedure TCertManageF.LicenseCheckGrpGroupCheckClick(Sender: TObject);
begin
  if LicenseCheckGrp.CheckBox.Checked then
  begin
    LicenseCheckGrp.Checked[0] := True;
    LicenseCheckGrp.Checked[1] := True;
    LicenseCheckGrp.Checked[2] := True;
  end
  else
  begin
    LicenseCheckGrp.Checked[0] := False;
    LicenseCheckGrp.Checked[1] := False;
    LicenseCheckGrp.Checked[2] := False;
  end;
end;

procedure TCertManageF.LoadConfig2Form(AForm: TCertManageConfigF);
begin
  FSettings.LoadConfig2Form(AForm, FSettings);
end;

procedure TCertManageF.LoadConfigForm2Object(AForm: TCertManageConfigF);
begin
  FSettings.LoadConfigForm2Object(AForm, FSettings);
end;

procedure TCertManageF.LoadConfigFromFile(AFileName: string);
begin
  FSettings.Load(AFileName);
end;

procedure TCertManageF.MakeCertFromSelected(AIsMerge: Boolean);
var
  LCertNo, LCertType: string;
  i: integer;
  LStrList: TStringList;
begin
  LStrList := TStringList.Create;
  try
    for i := CertListGrid.RowCount - 1 downto 0 do
    begin
      if CertListGrid.Selected[i] then
      begin
        LCertNo := CertListGrid.CellsByName['CertNo', i];
        LCertType := CertListGrid.CellsByName['CertType', i];

        LStrList.Add(LCertNo + '=' + LCertType);
      end;
    end;//for

    i := CreateCertEditFormFromDB4MakeCert(LStrList, AIsMerge);

    if AIsMerge then
      i := 1;

    ShowMessage(IntToStr(i) + ' files are created at "c:\temp\"');
  finally
    LStrList.Free;
  end;
end;

procedure TCertManageF.MakeCertXls(ARow: integer);
//var
//  LExcel: OleVariant;
//  LWorkBook: OleVariant;
//  LRange: OleVariant;
//  LWorksheet: OleVariant;
//  LPicture: OleVariant;
//  LStr, LStr2: string;
begin
//  LStr := CertListGrid.CellsByName['CertFileDBPath', ARow];
//
//  LExcel := GetActiveExcelOleObject(True);
//  try
//    LWorkBook := LExcel.Workbooks.Open(LStr + 'Cert.xls');
//    LWorksheet := LExcel.ActiveSheet;
//
//    LStr := CertListGrid.CellsByName['CertNo', ARow];
//    strToken(LStr, '-'); //CertNo에서 HGA 제거
//    LStr2 := strToken(LStr, '-'); //년도
//    LRange := LWorksheet.range['Q2'];
//    LRange.FormulaR1C1 := LStr2;
//    LRange := LWorksheet.range['U2'];
//    LRange.FormulaR1C1 := LStr;
//    LRange := LWorksheet.range['Z29'];
//    LRange.FormulaR1C1 := CertListGrid.CellsByName['TrainedSubject', ARow];
//    LRange := LWorksheet.range['Z34'];
//    LRange.FormulaR1C1 := CertListGrid.CellsByName['TraineeName', ARow];
//    LRange := LWorksheet.range['Z38'];
//    LRange.FormulaR1C1 := CertListGrid.CellsByName['CompanyName', ARow];
//    LRange := LWorksheet.range['Z41'];
//    LRange.FormulaR1C1 := CertListGrid.CellsByName['TrainedBeginDate', ARow] + ' ~ ' +
//      CertListGrid.CellsByName['TrainedEndDate', ARow];
//    LRange := LWorksheet.range['Z45'];
//    LRange.FormulaR1C1 := CertListGrid.CellsByName['TrainedSubject', ARow];
//    LRange := LWorksheet.range['Z48'];
//    LRange.FormulaR1C1 := CertListGrid.CellsByName['TrainedCourse', ARow];
//    LRange := LWorksheet.range['AP52'];
//    LRange.FormulaR1C1 := CertListGrid.CellsByName['UntilValidity', ARow];
//    LRange := LWorksheet.range['AT52'];
//    LRange.FormulaR1C1 := CertListGrid.CellsByName['UntilValidity', ARow];
//    LRange := LWorksheet.range['AS55'];
//    LRange.Left;
//  finally
//    LWorkBook.Close;
//    LExcel.Quit;
//  end;
end;

procedure TCertManageF.Merge1Click(Sender: TObject);
begin
  MakeCertFromSelected(True);
end;

procedure TCertManageF.NextGridToExcel4License(ANextGrid: TNextGrid);
var
  LTempNextGrid: TNextGrid;
  LAryColIndex: TArrayRecord<integer>;
  LVar: Variant;
begin
  SetColIndexAry4License(LAryColIndex);
  //LAryColIndex에 있는 Column Index Data만 LVar에 가져옴
  LVar := NextGrid2VariantFromColIndexAry(ANextGrid, LAryColIndex);

  LTempNextGrid := TNextGrid.Create(nil);
  LTempNextGrid.Visible := False;

  try
    LTempNextGrid.Parent := TWinControl(Self);
    AddNextGridRowsFromVariant2(LTempNextGrid, LVar, True);
    NextGridToExcel(LTempNextGrid);
  finally
    LTempNextGrid.Free;
  end;
end;

procedure TCertManageF.OnEasterEgg(msg: string);
begin
  FormAbout1.LicenseText.Text := GetRegisterInfoFromRegistry;
  Abou1Click(nil);
end;

procedure TCertManageF.PopupMenu1Popup(Sender: TObject);
begin
  CreateInvoceFromSelected1.Visible := FDisplayCreateInvoceMenuItem;
end;

procedure TCertManageF.ReturnCertListFromSelected1Click(Sender: TObject);
begin
  if FIsPopMode then
  begin
    ModalResult := mrOK;
  end;
end;

procedure TCertManageF.rg_periodClick(Sender: TObject);
var
  Ly,Lm,Ld,Lq: word;
begin
  dt_begin.Enabled := False;
  dt_end.Enabled := False;

  case rg_period.ItemIndex of
    0://1 Year
      begin
        dt_begin.Date := now;
        DecodeDate(dt_begin.Date-365,Ly,Lm,Ld);
//        Ly := Ly - 1;
//        Ld := Ld - 1;
        dt_begin.Date := EncodeDate(Ly,Lm,Ld);
        dt_end.Date := now;
      end;
    1://Last Quarter
      begin
        Lq := QuarterOf(now);
        Ly := YearOf(now);
        dt_begin.Date := GetBeginDateFromQuarter(GetPrevYearFromQuarter(Ly,Lq), GetPrevQuarterFromQuarter(Lq));
        dt_end.Date := GetEndDateFromQuarter(GetPrevYearFromQuarter(Ly,Lq),GetPrevQuarterFromQuarter(Lq));;
      end;
    2://this Quarter
      begin
        Lq := QuarterOf(now);
        Ly := YearOf(now);
        dt_begin.Date := GetBeginDateFromQuarter(Ly, Lq);
        dt_end.Date := GetEndDateFromQuarter(Ly,Lq);;
      end;
    3://Select
      begin
        dt_begin.Enabled := True;
        dt_end.Enabled := True;
      end;
  end;
end;

procedure TCertManageF.SaveImageQRCodeFromFrame(AFileName: string;
  AOrm: TOrmHGSTrainLicense);
var
  LFrame: TQRCodeFrame;
  LJson: string;
begin
  LFrame := TQRCodeFrame.Create(nil);
  try
    with LFrame do
    begin
      LJson := TCertEditF.GetCertInfo2Json2(AOrm.CertNo, AOrm.TraineeName);
      LJson := UnitCryptUtil2.EncryptString_Syn3(LJson);
      mmoText.Text := LJson;
      RemakeQR;
      SaveToFile(AFileName);
    end;
  finally
    LFrame.Free;
  end;
end;

procedure TCertManageF.SetCertListVisibleColumn;
var
  LBool: Boolean;
begin
  LBool := IsLicenseCheckedFromForm();

//  if LBool then
//    ShowOrHideAllColumn4NextGrid(CertListGrid, False);

  CertListGrid.ColumnByName['TraineeNation'].Visible := LBool;
  CertListGrid.ColumnByName['IssueDate'].Visible := LBool;
  CertListGrid.ColumnByName['Within1Year'].Visible := LBool;
  CertListGrid.ColumnByName['Within6Month'].Visible := LBool;

  LBool := EducationCheck.Checked or IsLicenseCheckedFromForm();
  CertListGrid.ColumnByName['TrainedSubject'].Visible := LBool;
  CertListGrid.ColumnByName['TrainedCourse'].Visible := LBool;
  CertListGrid.ColumnByName['TraineeName'].Visible := LBool;
  CertListGrid.ColumnByName['TrainedBeginDate'].Visible := LBool;
  CertListGrid.ColumnByName['TrainedEndDate'].Visible := LBool;

  LBool := APTServiceCheck.Checked;
  CertListGrid.ColumnByName['ReportNo'].Visible := LBool;
  CertListGrid.ColumnByName['VDRSerialNo'].Visible := LBool;
  CertListGrid.ColumnByName['PlaceOfSurvey'].Visible := LBool;
  CertListGrid.ColumnByName['VDRType'].Visible := LBool;
  CertListGrid.ColumnByName['ClassSociety'].Visible := LBool;
  CertListGrid.ColumnByName['OwnerName'].Visible := LBool;
  CertListGrid.ColumnByName['ShipName'].Visible := LBool;
  CertListGrid.ColumnByName['IMONo'].Visible := LBool;
  CertListGrid.ColumnByName['HullNo'].Visible := LBool;
  CertListGrid.ColumnByName['PICEmail'].Visible := LBool;
  CertListGrid.ColumnByName['PICPhone'].Visible := LBool;
  CertListGrid.ColumnByName['APTServiceDate'].Visible := LBool;
end;

procedure TCertManageF.SetColIndexAry4License(
  var AColIndexAry: TArrayRecord<integer>);
begin
  AColIndexAry.Add(CertListGrid.ColumnByName['CertNo'].Index);
  AColIndexAry.Add(CertListGrid.ColumnByName['ProductType'].Index);
  AColIndexAry.Add(CertListGrid.ColumnByName['CompanyName'].Index);
  AColIndexAry.Add(CertListGrid.ColumnByName['CompanyNation'].Index);
  AColIndexAry.Add(CertListGrid.ColumnByName['TraineeEmail'].Index);
  AColIndexAry.Add(CertListGrid.ColumnByName['TraineeName'].Index);
  AColIndexAry.Add(CertListGrid.ColumnByName['TraineeNation'].Index);
  AColIndexAry.Add(CertListGrid.ColumnByName['CertType'].Index);
  AColIndexAry.Add(CertListGrid.ColumnByName['IssueDate'].Index);
  AColIndexAry.Add(CertListGrid.ColumnByName['UntilValidity'].Index);
  AColIndexAry.Add(CertListGrid.ColumnByName['Within1Year'].Index);
  AColIndexAry.Add(CertListGrid.ColumnByName['Within6Month'].Index);
  AColIndexAry.Add(CertListGrid.ColumnByName['Attachments'].Index);
  AColIndexAry.Add(CertListGrid.ColumnByName['UpdateDate'].Index);
  AColIndexAry.Add(CertListGrid.ColumnByName['Notes'].Index);
end;

procedure TCertManageF.SetConfig;
var
  LConfigF: TCertManageConfigF;
  LParamFileName: string;
begin
  LConfigF := TCertManageConfigF.Create(Self);

  try
//    LParamFileName := FSettings.ParamFileName;
    LoadConfig2Form(LConfigF);

    if LConfigF.ShowModal = mrOK then
    begin
      LoadConfigForm2Object(LConfigF);
      FSettings.Save();

//      ApplyConfigChanged;
    end;
  finally
    LConfigF.Free;
  end;
end;

procedure TCertManageF.SetConfig1Click(Sender: TObject);
begin
  SetConfig;
end;

procedure TCertManageF.SetDefaultCond;
begin
  NoResultCheck.Checked := True;
  SuccessedCheck.Checked := True;
  CancelledCheck.Checked := True;
  FailedCheck.Checked := True;

  InvoiceIssuedCheck.Checked := True;
  InvoiceNotIssuedCheck.Checked := True;
  InvoiceIgnoreCheck.Checked := False;

  InvoiceConfirmedCheck.Checked := True;
  InvoiceNotConfirmedCheck.Checked := True;

  BillPaidCheck.Checked := True;
  IsNotBillPaidCheck.Checked := True;
end;

procedure TCertManageF.SetFildCondCBChange(Sender: TObject);
begin
  case TCertFindCondition(SetFildCondCB.ItemIndex) of
    cfcNull: SetDefaultCond;
    cfcNoResultRelpy: SetNoServResltReplyCond;
    cfcNoInvConfirm: SetNoInvoiceConfirmCond;
    cfcNoPaied: SetNoPaidCond;
    cfcLastQAPTListOnSuccess: SetLastQAPTListOnSuccess;
    cfcVesselListWithNoAPTInPeriod: SetVesselListWithNoAPTInPeriod;
    cfcValidityUntilLicDate: SetLicListBeforeExpired;
  end;
end;

procedure TCertManageF.SetInvoiceConfirmDateFromSelected;
var
  i, LCount: integer;
  LCertNo: string;
  LInvConfirmDate: TDate;
begin
  LInvConfirmDate := ShowDateEditForm;

  if LInvConfirmDate <> 0.0 then
  begin
    LCount := 0;

    for i := 0 to CertListGrid.RowCount - 1 do
    begin
      if CertListGrid.Row[i].Selected then
      begin
        LCertNo := CertListGrid.CellsByName['CertNo', i];
        UpdateInvoiceConfirmDateFromCertNo(LCertNo, LInvConfirmDate);
        Inc(LCount);
      end;
    end;

    GetCertList2Grid;
    CertListGrid.ScrollToRow(CertListGrid.SelectedRow);
    ShowMessage('( ' + IntToStr(LCount) + ' ) Updates are completed!' + #13#10 + 'Invoice Confirm Date = ' + DateToStr(LInvConfirmDate));
  end;
end;

procedure TCertManageF.SetInvoiceConfirmDateFromSelected1Click(Sender: TObject);
begin
  SetInvoiceConfirmDateFromSelected;
end;

procedure TCertManageF.SetInvoiceIssueDateFromSelected;
var
  i, LCount: integer;
  LCertNo: string;
  LInvoiceDate: TDate;
begin
  LInvoiceDate := ShowDateEditForm;

  if LInvoiceDate <> 0.0 then
  begin
    LCount := 0;

    for i := 0 to CertListGrid.RowCount - 1 do
    begin
      if CertListGrid.Row[i].Selected then
      begin
        LCertNo := CertListGrid.CellsByName['CertNo', i];
        UpdateInvoiceIssueDateFromCertNo(LCertNo, LInvoiceDate);
        Inc(LCount);
      end;
    end;

    GetCertList2Grid;
    CertListGrid.ScrollToRow(CertListGrid.SelectedRow);
    ShowMessage('( ' + IntToStr(LCount) + ' ) Updates are completed!' + #13#10 + 'Invoice Issue Date = ' + DateToStr(LInvoiceDate));
  end;
end;

procedure TCertManageF.SetInvoiceIssueDateFromSelected1Click(Sender: TObject);
begin
  SetInvoiceIssueDateFromSelected;
end;

procedure TCertManageF.SetInvoiceNo1Click(Sender: TObject);
begin
  ShowInvoiceNoEditForm;
end;

procedure TCertManageF.SetInvoiceNoFromSelected(AInvoiceNo: string);
var
  i, LCount: integer;
  LCertNo: string;
begin
  for i := 0 to CertListGrid.RowCount - 1 do
  begin
    LCount := 0;

    if CertListGrid.Row[i].Selected then
    begin
      LCertNo := CertListGrid.CellsByName['CertNo', i];
      UpdateInvoiceNoFromCertNo(AInvoiceNo, LCertNo);
      Inc(LCount);
    end;
  end;

  ShowMessage('( ' + IntToStr(LCount) + ' ) Updates are completed!' + #13#10 + 'Invoice No = ' + AInvoiceNo);
end;

procedure TCertManageF.SetLastQAPTListOnSuccess;
begin
  ComboBox1.ItemIndex := Ord(cqdtAPTServiceDate);
  rg_period.ItemIndex := 1;
  rg_periodClick(nil);

  NoResultCheck.Checked := False;
  SuccessedCheck.Checked := True;
  CancelledCheck.Checked := False;
  FailedCheck.Checked := False;

  InvoiceIssuedCheck.Checked := True;
  InvoiceNotIssuedCheck.Checked := True;
  InvoiceIgnoreCheck.Checked := False;

  InvoiceConfirmedCheck.Checked := True;
  InvoiceNotConfirmedCheck.Checked := True;
end;

procedure TCertManageF.SetLicListBeforeExpired;
begin
  ComboBox1.ItemIndex := Ord(cqdtValidityUntilDate);
  rg_period.ItemIndex := 3;
  rg_periodClick(nil);
  dt_begin.Date := GetBeginTimeOfTheDay(IncMonth(date, 6));
  dt_end.Date := GetEndTimeOfTheDay(IncMonth(date, 6));

  NoResultCheck.Checked := True;
  SuccessedCheck.Checked := True;
  CancelledCheck.Checked := False;
  FailedCheck.Checked := False;

  InvoiceIssuedCheck.Checked := True;
  InvoiceNotIssuedCheck.Checked := True;
  InvoiceIgnoreCheck.Checked := False;

  InvoiceConfirmedCheck.Checked := True;
  InvoiceNotConfirmedCheck.Checked := True;
end;

procedure TCertManageF.SetNoInvoiceConfirmCond;
begin
  ComboBox1.ItemIndex := Ord(cqdtInvoiceIssueDate);
  rg_periodClick(nil);
  dt_begin.Date := date - 90;
  dt_end.Date := date - 2;

  NoResultCheck.Checked := True;
  SuccessedCheck.Checked := True;
  CancelledCheck.Checked := False;
  FailedCheck.Checked := False;

  InvoiceIssuedCheck.Checked := True;
  InvoiceNotIssuedCheck.Checked := False;
  InvoiceIgnoreCheck.Checked := False;

  InvoiceConfirmedCheck.Checked := False;
  InvoiceNotConfirmedCheck.Checked := True;
end;

procedure TCertManageF.SetNoPaidCond;
begin
  ComboBox1.ItemIndex := Ord(cqdtInvoiceConfirmDate);
  rg_periodClick(nil);
  dt_begin.Date := date - 90;
  dt_end.Date := date - 7;

  InvoiceIssuedCheck.Checked := True;
  InvoiceNotIssuedCheck.Checked := False;
  InvoiceIgnoreCheck.Checked := False;

  InvoiceConfirmedCheck.Checked := True;
  InvoiceNotConfirmedCheck.Checked := False;
end;

procedure TCertManageF.SetNoServResltReplyCond;
begin
  ComboBox1.ItemIndex := Ord(cqdtAPTServiceDate);
  rg_periodClick(nil);
//  dt_begin.Date := date - 90;
  dt_end.Date := date - 2;

  NoResultCheck.Checked := True;
  SuccessedCheck.Checked := False;
  CancelledCheck.Checked := False;
  FailedCheck.Checked := False;
end;

procedure TCertManageF.SetNoteFromSelected(ANote: string);
var
  i, LCount: integer;
  LCertNo: string;
begin
  for i := 0 to CertListGrid.RowCount - 1 do
  begin
    LCount := 0;

    if CertListGrid.Row[i].Selected then
    begin
      LCertNo := CertListGrid.CellsByName['CertNo', i];
      UpdateNoteFromCertNo(ANote, LCertNo);
      Inc(LCount);
    end;
  end;

  ShowMessage('( ' + IntToStr(LCount) + ' ) Updates are completed!' + #13#10 + 'Note = ' + ANote);
end;

procedure TCertManageF.SetNotesFromSelected1Click(Sender: TObject);
begin
  ShowNoteEditForm;
end;

procedure TCertManageF.SetPaidBillDateFromSelected;
var
  i, LCount: integer;
  LCertNo: string;
  LPaidBillDate: TDate;
begin
  LPaidBillDate := ShowDateEditForm;

  if LPaidBillDate <> 0.0 then
  begin
    LCount := 0;

    for i := 0 to CertListGrid.RowCount - 1 do
    begin
      if CertListGrid.Row[i].Selected then
      begin
        LCertNo := CertListGrid.CellsByName['CertNo', i];
        UpdatePaidBillDateFromCertNo(LCertNo, LPaidBillDate);
        Inc(LCount);
      end;
    end;

    GetCertList2Grid;
    CertListGrid.ScrollToRow(CertListGrid.SelectedRow);
    ShowMessage('( ' + IntToStr(LCount) + ' ) Updates are completed!' + #13#10 + 'Paid Bill Date = ' + DateToStr(LPaidBillDate));
  end;
end;

procedure TCertManageF.SetPaidBillDateFromSelected1Click(Sender: TObject);
begin
  SetPaidBillDateFromSelected;
end;

procedure TCertManageF.SetVesselListWithNoAPTInPeriod;
begin
  ComboBox1.ItemIndex := Ord(cqdtExcludeAPTDate);
  rg_period.ItemIndex := 3;
  rg_periodClick(nil);

  NoResultCheck.Checked := True;
  SuccessedCheck.Checked := True;
  CancelledCheck.Checked := False;
  FailedCheck.Checked := False;

  InvoiceIssuedCheck.Checked := True;
  InvoiceNotIssuedCheck.Checked := True;
  InvoiceIgnoreCheck.Checked := False;

  InvoiceConfirmedCheck.Checked := True;
  InvoiceNotConfirmedCheck.Checked := True;
end;

procedure TCertManageF.ShipNameEditButtonClick(Sender: TObject);
begin
  ShowSearchVesselForm(Sender);
end;

procedure TCertManageF.ShipNameEditKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteSearch(Key);
end;

procedure TCertManageF.ShowCertEditFormFromGrid(ARow: integer; AAttachPageView: Boolean);
var
  LCertNo, LMailList: string;
  LResult: integer;
begin
  LCertNo := CertListGrid.CellsByName['CertNo', ARow];

  LResult := CreateCertEditFormFromDB(LCertNo, '', True, LMailList, GetEduCertTypeFromForm(), AAttachPageView);

  if (LResult = mrOK) or (LResult = mrYes) then
  begin
    GetCertList2Grid;
    NextGridScrollToRow(CertListGrid);
//    CertListGrid.ScrollToRow(ARow);
//    CertListGrid.Row[ARow].Selected := True;
  end;
end;

procedure TCertManageF.ShowCertNoFormat;
begin
  CreateCertNoFormat;
end;

function TCertManageF.ShowDateEditForm: TDate;
var
  LInvoiceIssueDateEditF: TInvoiceIssueDateEditF;
begin
  LInvoiceIssueDateEditF := TInvoiceIssueDateEditF.Create(nil);
  try
    if LInvoiceIssueDateEditF.ShowModal = mrOK then
    begin
      Result := LInvoiceIssueDateEditF.IssueIssueDatePicker.Date;
    end
    else
      Result := 0.0;
  finally
    LInvoiceIssueDateEditF.Free;
  end;
end;

procedure TCertManageF.ShowInvoiceNoEditForm;
var
  LInvoiceNoEditF: TInvoiceNoEditF;
  LInvoiceNo: string;
begin
  LInvoiceNoEditF := TInvoiceNoEditF.Create(nil);
  try
    if LInvoiceNoEditF.ShowModal = mrOK then
    begin
      LInvoiceNo := LInvoiceNoEditF.InvoiceNoEdit.Text;

//      if LInvoiceNo <> '' then
//      begin
      SetInvoiceNoFromSelected(LInvoiceNo);
      GetCertList2Grid;
      CertListGrid.ScrollToRow(CertListGrid.SelectedRow);
//      end;
    end;
  finally
    LInvoiceNoEditF.Free;
  end;
end;

procedure TCertManageF.ShowNoteEditForm;
var
  LNoteEditF: TNoteEditF;
  LNote: string;
begin
  LNoteEditF := TNoteEditF.Create(nil);
  try
    if LNoteEditF.ShowModal = mrOK then
    begin
      LNote := LNoteEditF.NoteMemo.Text;

      SetNoteFromSelected(LNote);
      GetCertList2Grid;
      CertListGrid.ScrollToRow(CertListGrid.SelectedRow);
    end;
  finally
    LNoteEditF.Free;
  end;
end;

procedure TCertManageF.ShowSearchVesselForm(Sender: TObject);
var
  LSearchVesselF: TSearchVesselF;
begin
  LSearchVesselF := TSearchVesselF.Create(nil);
  try
    if TNxButtonEdit(Sender).Name = 'IMONoEdit' then
      LSearchVesselF.ImoNoEdit.Text := Self.IMONoEdit.Text
    else
    if TNxButtonEdit(Sender).Name = 'ShipNameEdit' then
      LSearchVesselF.ShipNameEdit.Text := Self.ShipNameEdit.Text
    else
    if TNxButtonEdit(Sender).Name = 'HullNoEdit' then
      LSearchVesselF.HullNoEdit.Text := Self.HullNoEdit.Text;

    if (Self.IMONoEdit.Text <> '') or (Self.ShipNameEdit.Text <> '')
                                      or (Self.HullNoEdit.Text <> '') then
      LSearchVesselF.SearchButtonClick(nil);

    if LSearchVesselF.ShowModal = mrOK then
    begin
      if LSearchVesselF.VesselListGrid.SelectedRow <> -1 then
      begin
        HullNoEdit.Text := LSearchVesselF.VesselListGrid.CellsByName['HullNo',LSearchVesselF.VesselListGrid.SelectedRow];
        ShipNameEdit.Text := LSearchVesselF.VesselListGrid.CellsByName['ShipName',LSearchVesselF.VesselListGrid.SelectedRow];
        ImoNoEdit.Text := LSearchVesselF.VesselListGrid.CellsByName['ImoNo',LSearchVesselF.VesselListGrid.SelectedRow];
      end;
    end;
  finally
    LSearchVesselF.Free;
  end;
end;

procedure TCertManageF.Splite1Click(Sender: TObject);
begin
  MakeCertFromSelected(False);
end;

procedure TCertManageF.SubjectEditButtonDown(Sender: TObject);
var
  LSubject, LCourseName, LContents: string;
begin
  if CreateCourseManageForm(LSubject, LCourseName, LContents) = mrOK then
  begin
    if LContents = '' then
      SubjectEdit.Text := LSubject
    else
      SubjectEdit.Text := LContents;

    CourseEdit.Text := LCourseName;
  end;
end;

procedure TCertManageF.SubjectEditKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteSearch(Key);
end;

procedure TCertManageF.TraineeNameEditKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteSearch(Key);
end;

function TCertManageF.UpdateShipNameFromVesselMasterToVDRList: integer;
var
  LSQLHGSVDRRecord: TSQLHGSVDRRecord;
  LVDRSearchParamRec: TVDRSearchParamRec;
  LSQLVesselMaster: TSQLVesselMaster;
begin
  Result := 0;
  LVDRSearchParamRec := Default(TVDRSearchParamRec);

  LSQLHGSVDRRecord := GetHGSVDRRecordFromSearchRec(LVDRSearchParamRec);
  try
    LSQLHGSVDRRecord.FillRewind;

    while LSQLHGSVDRRecord.FillOne do
    begin
      if LSQLHGSVDRRecord.IMONo <> '' then
      begin
        LSQLVesselMaster := GetVesselMasterFromIMONo(LSQLHGSVDRRecord.IMONo);
        try
          if LSQLVesselMaster.IsUpdate then
          begin
            LSQLHGSVDRRecord.ShipName := LSQLVesselMaster.ShipName;
            LSQLHGSVDRRecord.HullNo := LSQLVesselMaster.HullNo;
            inc(Result);
          end;
        finally
          LSQLVesselMaster.Free;
        end;
      end;
    end;
  finally
    DestroyHGSVDR;
  end;
end;

procedure TCertManageF.UpdateShipNameFromVesselMasterToVDRList1Click(
  Sender: TObject);
var
  i: integer;
begin
  i := UpdateShipNameFromVesselMasterToVDRList();
  ShowMessage(IntToStr(i) + ' is Complete Update for ShipName, HullNo, Owner etc.');
end;

procedure TCertManageF.ViewTariff1Click(Sender: TObject);
var
  LDoc: variant;
begin
  LDoc := LoadGSTariff2VariantFromCompanyCodeNYear('0001056374', YearOf(now)-1);
  //LDoc: [] 배열 형식임
  DisplayTariff(LDoc);
end;

end.
