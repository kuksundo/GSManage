unit FrmCertEdit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Winapi.ActiveX,
  TypInfo, Vcl.ImgList, Vcl.Mask, Vcl.ComCtrls, Vcl.ExtCtrls, Word2010, PowerPoint2010,
  NxColumnClasses, NxColumns, NxScrollControl,
  NxCustomGridControl, NxCustomGrid, NxGrid, AdvGlowButton,
  NxEdit, JvExControls, JvLabel, AdvOfficePager, AeroButtons,
  Vcl.Menus, AdvEdit, AdvEdBtn,
  JvDatePickerEdit, JvExMask, JvToolEdit, JvMaskEdit, JvCheckedMaskEdit,
  DropSource, DragDrop, DropTarget, DragDropFile,
  mormot.core.zip, mormot.core.variants, mormot.core.base, mormot.core.json,
  mormot.core.os, mormot.core.datetime, mormot.core.text,
  UnitHGSCertData, UnitHGSVDRRecord2, UnitQRCodeFrame, UnitHGSCertRecord2,
  UnitJHPFileRecord, UnitFrameFileList2, UnitHGSSerialRecord2,
  UnitJHPFileData, AdvToolBtn, W7Classes, W7Buttons, FrameOLEmailList2, UnitOLEmailRecord2,
  AdvOfficeImage;

const
  ATR_FILENAME = 'ANNUAL_TEST_REPORT.pjh';
  COC_FILENAME = 'Certificate_of_compliance_with_field.pjh';
  EDU_FILENAME = 'Education_Cert.pjh';
  EDU_FILENAME2 = 'Education_Cert.pjh2';
  PROD_APPROVAL_FILENAME = 'APT_Approval_Certificate.pjh';
  VDRConfigFileName = 'VDRConfig.ini';
  LRCHECKLISTFileName = 'LR_Survey_Checklist_VDR.pjh';
  ABSCHECKLISTFileName = 'ABS_Check_List_VDR.pjh';
  LICLIST_FILENAME = 'LicenseList.ods';
  PHOTO_FILENAME = 'Photo.jpg';
  QRCODE_FILENAME = 'QRCode.png';

type
  TCertEditF = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    AdvOfficePage1: TAdvOfficePager;
    CertInfoPage: TAdvOfficePage;
    AttachmentPage: TAdvOfficePage;
    ImageList16x16: TImageList;
    Imglist16x16: TImageList;
    CheckBox1: TCheckBox;
    IsCryptSerialCheck: TCheckBox;
    QRCodePage: TAdvOfficePage;
    QRCodeFrame1: TQRCodeFrame;
    btnCopy: TButton;
    Button1: TButton;
    HashStringEdit: TEdit;
    AeroButton3: TAeroButton;
    AeroButton1: TAeroButton;
    btn_Close: TAeroButton;
    JvLabel8: TJvLabel;
    CertTypeCB: TComboBox;
    EducationPanel: TPanel;
    APTPanel: TPanel;
    JvLabel4: TJvLabel;
    TrainedSubjectEdit: TNxButtonEdit;
    JvLabel7: TJvLabel;
    CourseLevelCB: TComboBox;
    JvLabel31: TJvLabel;
    TrainedCourseEdit: TNxButtonEdit;
    JvLabel1: TJvLabel;
    TraineeNameEdit: TEdit;
    JvLabel20: TJvLabel;
    Label1: TLabel;
    CommonPanel: TPanel;
    JvLabel3: TJvLabel;
    JvLabel5: TJvLabel;
    JvLabel49: TJvLabel;
    JvLabel15: TJvLabel;
    JvLabel9: TJvLabel;
    JvLabel2: TJvLabel;
    JvLabel10: TJvLabel;
    ProductTypeCB: TComboBox;
    CertNoButtonEdit: TNxButtonEdit;
    CertFileDBPathEdit: TNxButtonEdit;
    CertFileDBNameEdit: TNxButtonEdit;
    PrevCertNoEdit: TEdit;
    JvLabel13: TJvLabel;
    JvLabel6: TJvLabel;
    ReportNoEdit: TNxButtonEdit;
    JvLabel12: TJvLabel;
    CompanyNationEdit: TEdit;
    JvLabel11: TJvLabel;
    CompanyCodeEdit: TEdit;
    JvLabel14: TJvLabel;
    OwnerNameEdit: TEdit;
    JvLabel16: TJvLabel;
    JvLabel17: TJvLabel;
    VDRSerialNoEdit: TNxButtonEdit;
    JvLabel18: TJvLabel;
    IMONoEdit: TNxButtonEdit;
    JvLabel19: TJvLabel;
    JvLabel21: TJvLabel;
    JvLabel22: TJvLabel;
    JvLabel23: TJvLabel;
    JvLabel24: TJvLabel;
    ShipNameEdit: TNxButtonEdit;
    HullNoEdit: TNxButtonEdit;
    PlaceOfSurveyEdit: TEdit;
    ClassSocietyEdit: TEdit;
    PICEmailEdit: TEdit;
    PICPhoneEdit: TEdit;
    JvLabel25: TJvLabel;
    VDRTypeEdit: TEdit;
    JvLabel26: TJvLabel;
    VDRConfigMemo: TMemo;
    JvLabel27: TJvLabel;
    OrderNoEdit: TEdit;
    JvLabel28: TJvLabel;
    SalesAmountEdit: TEdit;
    APTServiceDatePicker: TJvDatePickerEdit;
    TrainedBeginDatePicker: TJvDatePickerEdit;
    TrainedEndDatePicker: TJvDatePickerEdit;
    IssueDatePicker: TJvDatePickerEdit;
    UntilValidityDatePicker: TJvDatePickerEdit;
    APTResultRG: TRadioGroup;
    IgnoreInvoice: TCheckBox;
    JvLabel29: TJvLabel;
    InvoiceIssueDatePicker: TJvDatePickerEdit;
    JvLabel30: TJvLabel;
    BillPaidDatePicker: TJvDatePickerEdit;
    JvLabel32: TJvLabel;
    NotesMemo: TMemo;
    JvLabel33: TJvLabel;
    JvLabel34: TJvLabel;
    InvoiceCompanyEdit: TAdvEditBtn;
    SubCompanyEdit: TAdvEditBtn;
    EmailPage: TAdvOfficePage;
    MakeZipPopup: TPopupMenu;
    asPDF1: TMenuItem;
    AsDoc1: TMenuItem;
    MakeZipButton: TAdvToolButton;
    JvLabel35: TJvLabel;
    InvoiceConfirmDatePicker: TJvDatePickerEdit;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MakeCertButton: TAdvToolButton;
    SubCompanyEdit2: TEdit;
    InvoiceCompanyCodeEdit: TEdit;
    InvoiceCompanyNationEdit: TEdit;
    FrameOLEmailList: TFrame2;
    JvLabel36: TJvLabel;
    InvoiceEmailEdit: TEdit;
    Label2: TLabel;
    Button2: TButton;
    Button3: TButton;
    GSFileFrame: TJHPFileListFrame;
    AdvOfficePage2: TAdvOfficePage;
    Button4: TButton;
    Panel2: TPanel;
    Panel4: TPanel;
    StretchCheck: TCheckBox;
    PhotoImage: TAdvOfficeImage;
    AdvToolButton1: TAdvToolButton;
    MakeLicZipPopup: TPopupMenu;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    JvLabel37: TJvLabel;
    TraineeNationEdit: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CertNoButtonEditButtonClick(Sender: TObject);
    procedure QRCodeFrame1pbPreviewPaint(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure CertFileDBPathEditButtonClick(Sender: TObject);
    procedure CertFileDBNameEditButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TrainedSubjectEditButtonClick(Sender: TObject);
    procedure TrainedCourseEditButtonClick(Sender: TObject);
    procedure SubCompanyEditClickBtn(Sender: TObject);
    procedure ReportNoEditButtonClick(Sender: TObject);
    procedure CertTypeCBChange(Sender: TObject);
    procedure IMONoEditButtonClick(Sender: TObject);
    procedure ShipNameEditButtonClick(Sender: TObject);
    procedure HullNoEditButtonClick(Sender: TObject);
    procedure VDRSerialNoEditButtonClick(Sender: TObject);
    procedure IssueDatePickerChange(Sender: TObject);
    procedure UntilValidityDatePickerChange(Sender: TObject);
    procedure APTServiceDatePickerChange(Sender: TObject);
    procedure CourseLevelCBChange(Sender: TObject);
    procedure ProductTypeCBChange(Sender: TObject);
    procedure PlaceOfSurveyEditKeyPress(Sender: TObject; var Key: Char);
    procedure ClassSocietyEditKeyPress(Sender: TObject; var Key: Char);
    procedure TraineeNameEditKeyPress(Sender: TObject; var Key: Char);
    procedure TrainedBeginDatePickerChange(Sender: TObject);
    procedure TrainedEndDatePickerChange(Sender: TObject);
    procedure InvoiceCompanyEditClickBtn(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure asPDF1Click(Sender: TObject);
    procedure AsDoc1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure CertNoButtonEditChange(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure StretchCheckClick(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
  private
    FGSFileDBName,
    FGSFileDBPath: string;
    FActiveControl: TWinControl;
    FPrevInactiveColor: TColor;
    FDisableEditPosition: Boolean;
    FTempFileList: TStringList;

    procedure InitEnum;
    procedure InitNetwork;
    procedure GetCertDetailFromCertRecord(ASQLHGSCertRecord: TSQLHGSCertRecord);
    procedure GetCertFileList2FileGrid(const AFileDBName: string);
    procedure GetCertEmailList2EmailGrid(const ADBName: string);
    procedure GetPhotoImageFromDB(AOrm: TSQLHGSCertRecord);
    procedure SaveGSFile2DB;
    function SaveEmail2DB: string;
    procedure SavePhotoImage2DB(AOrm: TSQLHGSCertRecord);
    function LoadCertDetail2CertRecordFromForm(var ACertRecord: TSQLHGSCertRecord): Boolean;
    procedure CreateQRCode;
    procedure CreateVDRTestReportNo;
    function CheckQRCodeIsValid: Boolean;
    function GetJsonFromQRCode: string;
    procedure ShowJsonFromQRCode;
    function CheckCertInfoFromAESCBC(const AOriginalStr, AEncryptedStr: string; AHGSCertType:THGSCertType): Boolean;
    function CheckCertInfoFromJson(const AJson1, AJson2: string; AHGSCertType:THGSCertType): Boolean;
    function GetCertInfo2Json(AHGSCertType:THGSCertType=hctNull): string;
    function GetSerialNoFromCertNo(ACertNo: string; var AYear: integer): string;
    function GetVDRConfigFromIMONo(AIMONo: string): string;
    procedure ShowSearchVesselForm(Sender: TObject);
    procedure ShowSearchVDRForm;
    procedure DisplayEditPosition;
    procedure RestoreColorExceptComponent(ATag: integer);
    procedure ScreenActiveControlChange(Sender: TObject);
    procedure SetVesselInfoFromIMONo(AIMONo: string);

    function GetTempATRFileName(ASaveFileKind: TJHPFileFormat=gfkNull): string;
    function GetTempCOCFileName(ASaveFileKind: TJHPFileFormat=gfkNull): string;
    function GetTempZipFileName: string;
    function GetTempVDRConfigFileName: string;
    function GetLRCheckListFileName: string;
    function GetABSCheckListFileName: string;
    function GetTempPhotoFileName(ASaveFileKind: TJHPFileFormat=gfkNull): string;//�������� ���� �̸�
    function GetTempQRFileName(ASaveFileKind: TJHPFileFormat=gfkNull): string;//QRCode ���� �̸�
    function GetTempAttendantListFN(ASaveFileKind: TJHPFileFormat=gfkNull): string;//������ ���� ����Ʈ ���� �̸�(xls)

    //Variant array return
    function GetGridColNamesFromForm4LicenseList: variant;
    function GetGridRowDataFromForm4LicenseList: variant;
  public
    function CreateCertNo(AProdType, ACertType: integer; IsCryptSerial: Boolean): string;
    procedure MakeCertXls;
    procedure MakeCertDoc(ACertType: integer; AIsSaveFile: Boolean=False;
      ASaveFileKind: TJHPFileFormat=gfkNull; AIsWordClose: Boolean=False);
    procedure MakeCert2MSWord(ACertType: integer; AOriginalFileName: string; ASaveFileKind: TJHPFileFormat=gfkNull;
      AIsSaveFile: Boolean=False; AIsWordClose: Boolean=False);
    procedure MakeCert2MSPPT(ACertType: integer; AOriginalFileName: string; ASaveFileKind: TJHPFileFormat=gfkNull;
      AIsSaveFile: Boolean=False; AIsWordClose: Boolean=False);
    function MakeZip4APTDoc(AFileKind: TJHPFileFormat; ADeleteTempFile: Boolean;
      AShowCompletionMsg: Boolean=false): string;
    function MakeZip4LicDoc(AFileKind: TJHPFileFormat; ADeleteTempFile: Boolean;
      AShowCompletionMsg: Boolean=false): string;
    procedure MakeLicenseListXls;
    procedure MakeLicenseDoc(ACertType: integer; AIsSaveFile: Boolean=False;
      ASaveFileKind: TJHPFileFormat=gfkNull; AIsWordClose: Boolean=False);
    function CheckIfExistATRFileFromDB(AImoNo: string; var AFilName: string):Boolean;
    function GetZipFileName4Doc: string;
  end;

function CreateCertEditFormFromDB(ACertNo, AIMONo: string; AIsShowForm: Boolean;
  out AEmailList: string; ACertType: THGSCertType=hctNull; AAttachPageView:
  Boolean=false): integer;

var
  g_CertEditF: TCertEditF;

implementation

uses UnitVesselData2,  DragDropInternet, DragDropFormats, DateUtils,
  UnitCryptUtil2, QRGraphics, System.StrUtils, iniFiles,
  UnitFolderUtil2, UnitExcelUtil,
  UnitStringUtil, UnitHGSCurriculumData, FrmCourseManage2, UnitMSPPTUtil,
  UnitMSWordUtil, FrmSearchCustomer2, CommonData2, FrmSearchVessel2, FrmSearchVDR2,
  UnitFormUtil, UnitHGSVDRData, UnitVesselMasterRecord2, UnitGAServiceData,
  FrmEmailListView2, UnitStrategy4VDRAPTCert2, UnitCertManageConfigClass2;

{$R *.dfm}

function CreateCertEditFormFromDB(ACertNo, AIMONo: string; AIsShowForm: Boolean;
  out AEmailList: string; ACertType: THGSCertType; AAttachPageView: Boolean): integer;
var
//  LCertEditF: TCertEditF;
  LSQLHGSCertRecord,
  LSQLHGSCertRecord2: TSQLHGSCertRecord;
  LDoc: variant;
  LYear: integer;
begin
  g_CertEditF := TCertEditF.Create(nil);
  try
    with g_CertEditF do
    begin
//      GSFileFrame.InitDragDrop; //��ü Ÿ�̸ӿ��� ������
      GSFileFrame.InitDocTypeList2Combo(g_HGSCertDocType.GetTypeLabels);
      GSFileFrame.AddButton.Align :=alLeft;
      GSFileFrame.ApplyButton.Visible := False;
      GSFileFrame.CloseButton.Visible := False;

      LSQLHGSCertRecord := GetHGSCertFromCertNo(ACertNo);

      try
        GetCertDetailFromCertRecord(LSQLHGSCertRecord);

        if AAttachPageView then
          AdvOfficePage1.ActivePageIndex := 2
        else
          AdvOfficePage1.ActivePageIndex := 0;

        if ACertType <> hctNull then
        begin
          CertTypeCB.ItemIndex := Ord(ACertType);
          CertTypeCBChange(nil);

          if ACertType = hctAPTService then
          begin
            ProductTypeCB.ItemIndex := ORd(shptVDR);
            ProductTypeCBChange(nil);
          end;
        end;

        if AIMONo <> '' then
        begin
          SetVesselInfoFromIMONo(AIMONo);
        end;

        if AIsShowForm then
        begin
          while True do
          begin
            Result := ShowModal;

            if Result = mrOK then
            begin
              //CertNo <> ''�̸� DB�� ����
              if LoadCertDetail2CertRecordFromForm(LSQLHGSCertRecord) then
              begin
                if not FrameOLEmailList.FIsSaveEmail2DBWhenDropped then
                begin
                  AEmailList := SaveEmail2DB;
                  LSQLHGSCertRecord.InvoiceEmail := AEmailList + LSQLHGSCertRecord.InvoiceEmail;
                end;

                AddOrUpdateHGSCert(LSQLHGSCertRecord);
                SavePhotoImage2DB(LSQLHGSCertRecord);
                SaveGSFile2DB();


                if not LSQLHGSCertRecord.IsUpdate then
                begin
                  LSQLHGSCertRecord.NextSerialNo := GetSerialNoFromCertNo(LSQLHGSCertRecord.CertNo, LYear);
                  AddOrUpdateNextHGSSerial(LYear, Ord(LSQLHGSCertRecord.ProductType),
                    Ord(LSQLHGSCertRecord.CertType), StrToIntDef(LSQLHGSCertRecord.NextSerialNo, 0));

                  ShowMessage('Data Save(Add) Is OK!');
                end
                else
                  ShowMessage('Data Save(Update) Is OK!');
              end;
            end
            else
            if Result = mrYes then
            begin
              if not CheckBox1.Checked then
              begin
                ShowMessage('Please Change Cert. No.');
                Continue;
              end;

              LSQLHGSCertRecord2 := TSQLHGSCertRecord.Create;
              try
                if LoadCertDetail2CertRecordFromForm(LSQLHGSCertRecord2) then
                begin
                  if CheckIfExistHGSCertNo(LSQLHGSCertRecord2.CertNo) then
                  begin
                    ShowMessage('Please Change Cert. No.');
                    Continue;
                  end;

                  AddOrUpdateHGSCert(LSQLHGSCertRecord2);
                  LSQLHGSCertRecord2.NextSerialNo := GetSerialNoFromCertNo(LSQLHGSCertRecord2.CertNo, LYear);
                  AddOrUpdateNextHGSSerial(LYear,Ord(LSQLHGSCertRecord2.ProductType),
                    Ord(LSQLHGSCertRecord2.CertType), StrToIntDef(LSQLHGSCertRecord2.NextSerialNo, 0));

                  SaveGSFile2DB();

                  ShowMessage('Data Add is successful!');
                end;
              finally
                LSQLHGSCertRecord2.Free;
              end;
            end;

            System.Break;
          end;//while true
        end
        else
        begin
          Result := ShowEMailListFromCertNo(ACertNo, HullNoEdit.Text, ProductTypeCB.Text, FSettings.OLFolderListFileName);
        end;
      finally
        LSQLHGSCertRecord.Free;
      end;
    end;
  finally
    g_CertEditF.Free;
  end;
end;

{ TCertEditF }

procedure TCertEditF.PlaceOfSurveyEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(VK_RETURN) then
    DisplayEditPosition;
end;

procedure TCertEditF.ProductTypeCBChange(Sender: TObject);
begin
  DisplayEditPosition;
end;

procedure TCertEditF.APTServiceDatePickerChange(Sender: TObject);
begin
  DisplayEditPosition;
end;

procedure TCertEditF.AsDoc1Click(Sender: TObject);
begin
  MakeZip4APTDoc(gfkWORD, True);
end;

procedure TCertEditF.asPDF1Click(Sender: TObject);
begin
  MakeZip4APTDoc(gfkPDF, True);
end;

procedure TCertEditF.btnCopyClick(Sender: TObject);
begin
  QRCodeFrame1.CopyBitmapToClipboard;
end;

procedure TCertEditF.Button1Click(Sender: TObject);
var
  LIsValid: Boolean;
begin
  LIsValid := CheckQRCodeIsValid;

  if LIsValid then
    ShowMessage('QR Code is OK!')
  else
    ShowMessage('QR Code is invalid!');
end;

procedure TCertEditF.Button2Click(Sender: TObject);
begin
  HashStringEdit.Text := QRCodeFrame1.edtText.Text;
end;

procedure TCertEditF.Button3Click(Sender: TObject);
begin
  ShowJsonFromQRCode;
end;

procedure TCertEditF.Button4Click(Sender: TObject);
begin
  with TOpenDialog.Create(Nil) do
  try
    Options := [ofHideReadOnly, ofFileMustExist, ofEnableSizing];
    InitialDir := Executable.ProgramFilePath;
    DefaultExt := GraphicExtension(TGraphic);
    Filter := GraphicFilter(TGraphic);

    if Execute then
      PhotoImage.Picture.LoadFromFile(FileName);
  finally
    Free;
  end;
end;

procedure TCertEditF.CertFileDBNameEditButtonClick(Sender: TObject);
begin
  if CertNoButtonEdit.Text = '' then
  begin
    ShowMessage('Please check cert. no. first!');
    exit;
  end;

  CertFileDBNameEdit.Text := GetDefaultDBName(CertNoButtonEdit.Text);
end;

procedure TCertEditF.CertFileDBPathEditButtonClick(Sender: TObject);
var
  LPath: string;
begin
  LPath := GetDefaultDBPath + 'files\';
  LPath := ExtractRelativePathBaseApplication(ExtractFilePath(Application.ExeName), LPath);
  CertFileDBPathEdit.Text := LPath;
end;

procedure TCertEditF.CertNoButtonEditButtonClick(Sender: TObject);
var
  LProdType, LCertType: integer;
begin
  LProdType := ProductTypeCB.ItemIndex;
  LCertType := CertTypeCB.ItemIndex;

  if LProdType < 1 then
  begin
    ShowMessage('Please select the product type!');
    exit;
  end;

  if LCertType < 1 then
  begin
    ShowMessage('Please select the Cert type!');
    exit;
  end;

  CertNoButtonEdit.Text := CreateCertNo(LProdType, LCertType, False);

  if CertNoButtonEdit.Text <> '' then
  begin
    CreateQRCode;

//    if CertFileDBNameEdit.Text = '' then
//      CertFileDBNameEditButtonClick(nil);

    DisplayEditPosition;
  end;
end;

procedure TCertEditF.CertNoButtonEditChange(Sender: TObject);
begin
  FrameOLEmailList.SetDBKey4Email(CertNoButtonEdit.Text);
end;

procedure TCertEditF.CertTypeCBChange(Sender: TObject);
const
  DefaultHeight = 744;//650;
begin
  case g_HGSCertType.ToType(CertTypeCB.ItemIndex) of
    hctEducation, hctEducation_Entrust: begin
      EducationPanel.Visible := True;
      APTPanel.Visible := False;
      Self.Height := DefaultHeight - APTPanel.Height;
      MakeZipButton.Visible := False;
    end;
    hctAPTService: begin
      EducationPanel.Visible := False;
      APTPanel.Visible := True;
      Self.Height := DefaultHeight - EducationPanel.Height;
      MakeZipButton.Visible := True;
    end;
    hctProductApproval: begin
      EducationPanel.Visible := False;
      APTPanel.Visible := False;
      Self.Height := DefaultHeight - EducationPanel.Height - APTPanel.Height;
      MakeZipButton.Visible := False;
    end;
  end;

  DisplayEditPosition;
end;

procedure TCertEditF.CheckBox1Click(Sender: TObject);
begin
  CertNoButtonEdit.Enabled := CheckBox1.Checked;
end;

procedure TCertEditF.StretchCheckClick(Sender: TObject);
begin
  PhotoImage.Stretch := StretchCheck.Checked;
end;

function TCertEditF.CheckCertInfoFromAESCBC(const AOriginalStr, AEncryptedStr: string;
  AHGSCertType:THGSCertType): Boolean;
var
  LDecryptedStr: string;
begin
  LDecryptedStr := DecryptString_Syn3(AEncryptedStr);
  Result := CheckCertInfoFromJson(AOriginalStr,LDecryptedStr, AHGSCertType);
end;

function TCertEditF.CheckCertInfoFromJson(const AJson1,
  AJson2: string; AHGSCertType:THGSCertType): Boolean;
var
  LDoc1, LDoc2: variant;
begin
  Result := False;

  LDoc1 := _JSON(AJson1);
  LDoc2 := _JSON(AJson2);

  if LDoc1.CertNo = LDoc2.CertNo then
  begin
    case AHGSCertType of
      hctAPTService: begin
        if LDoc1.ReportNo = LDoc2.ReportNo then
          if LDoc1.VDRSerialNo = LDoc2.VDRSerialNo then
            if LDoc1.IMONo = LDoc2.IMONo then
              Result := True;
      end;

      hctEducation, hctEducation_Entrust: begin
        if LDoc1.CertNo = LDoc2.CertNo then
          if LDoc1.TraineeName = LDoc2.TraineeName then
            if LDoc1.UntilValidity = LDoc2.UntilValidity then
              Result := True;
      end;
    end;
  end;
end;

function TCertEditF.CheckIfExistATRFileFromDB(AImoNo: string; var AFilName: string): Boolean;
var
  LSQLHGSVDRRecord: TSQLHGSVDRRecord;
  LSQLGSFileRec: TJHPFileRec;
  LDocData: TDocVariantData;
  LVar: Variant;
  LJsonFileList, LStr: string;
  LUtf8: RawUTF8;
  i: integer;
begin
  Result := False;

  if not Assigned(g_HGSVDRDB) then
    InitHGSVDRClient('HGSVDRList.sqlite');

  LSQLHGSVDRRecord := GetHGSVDRFromIMONo(AImoNo);
  try
    if LSQLHGSVDRRecord.IsUpdate then
    begin
//      LDoc := GetVariantFromHGSVDRRecord(LSQLHGSVDRRecord);
      LJsonFileList := MakeJHPFileRecs2JSON(LSQLHGSVDRRecord.Attachments);
//      LDoc.FileCount := High(LSQLHGSVDRRecord.Attachments) + 1;
      LDocData.InitJSON(LJsonFileList);
      for i := 0 to LDocData.Count - 1 do
      begin

        LUtf8 := LVar;
        RecordLoadJson(LSQLGSFileRec, LUtf8, TypeInfo(TJHPFileRec));

        if (LSQLGSFileRec.fData <> '') then//(LSQLGSFileRec.fFilename = ATR_FILENAME) and
        begin
          AFilName := 'C:\Temp\'+LSQLGSFileRec.fFilename;
          FTempFileList.Add(AFilName);
          FileFromString(LSQLGSFileRec.fData, AFilName, True);
          Result := True;
          System.Break;
        end;
      end;
    end;
  finally
    LSQLHGSVDRRecord.Free;
  end;
end;

function TCertEditF.CheckQRCodeIsValid: Boolean;
var
  LJson: string;
  LDocType: THGSCertType;
begin
  LDocType := g_HGSCertType.ToType(CertTypeCB.ItemIndex);
  LJson := GetCertInfo2Json(LDocType);
//  LJson := UnitCryptUtil.GetHashStringFromSCrypt(LJson);

  if HashStringEdit.Text = '' then
    ShowMessage('Please enter "Hash String"')
  else
    Result := CheckCertInfoFromAESCBC(LJson, HashStringEdit.Text, LDocType);
//    Result := CheckHashStringFromSCrypt(LJson, HashStringEdit.Text);
end;

procedure TCertEditF.ClassSocietyEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(VK_RETURN) then
    DisplayEditPosition;
end;

procedure TCertEditF.CourseLevelCBChange(Sender: TObject);
begin
  DisplayEditPosition;
end;

function TCertEditF.CreateCertNo(AProdType, ACertType: integer; IsCryptSerial: Boolean): string;
var
  LSerialNo: integer;
  LIssuedYear: string;
begin
  LIssuedYear :=FormatDateTime('yy', Now);
  LSerialNo := GetNextHGSSerialFromProductType(StrToInt(LIssuedYear), AProdType, ACertType);

  if IsCryptSerial then
  begin

  end;

  Result := 'HGA-'+ LIssuedYear + '-' +
//    LeftStr(g_ShipProductCode.ToString(ProductTypeCB.ItemIndex),2) + '-' +
    g_ShipProductCode.ToString(AProdType) + '-' +
    g_HGSCertTypeCode.ToString(ACertType) + '-' +
    format('%.4d', [LSerialNo]);

  if CheckIfExistHGSCertNo(Result) then
  begin
    ShowMessage('Cert No (' + Result + ') is already exist!');
    Result := '';
    Exit;
  end;
end;

procedure TCertEditF.CreateQRCode;
var
  LJson: string;
  LDocType: THGSCertType;
begin
  LDocType := g_HGSCertType.ToType(CertTypeCB.ItemIndex);
  LJson := GetCertInfo2Json(LDocType);

//  LJson := UnitCryptUtil.GetHashStringFromSCrypt(LJson);
  LJson := UnitCryptUtil2.EncryptString_Syn3(LJson);
  QRCodeFrame1.edtText.Text := LJson;
  QRCodeFrame1.RemakeQR;
end;

procedure TCertEditF.CreateVDRTestReportNo;
var
  LYear: string;
begin
  if HullNoEdit.Text = '' then
  begin
    ShowMessage('Please select Hull no. First!');
    exit;
  end;

  LYear := FormatDateTime('yy', APTServiceDatePicker.Date);

  ReportNoEdit.Text := 'VDR-TR' + LYear + '-' + HullNoEdit.Text;
  DisplayEditPosition;
end;

procedure TCertEditF.DisplayEditPosition;
begin
  if FDisableEditPosition then
    exit;

  if CertTypeCB.ItemIndex = -1 then
  begin
    CertTypeCB.Color := clYellow;
    RestoreColorExceptComponent(CertTypeCB.Tag);
    exit;
  end;

  if ProductTypeCB.ItemIndex = -1 then
  begin
    ProductTypeCB.Color := clYellow;
    RestoreColorExceptComponent(ProductTypeCB.Tag);
    exit;
  end;

  if SubCompanyEdit.Text = '' then
  begin
    SubCompanyEdit.Color := clYellow;
    RestoreColorExceptComponent(SubCompanyEdit.Tag);
    exit;
  end;

  case g_HGSCertType.ToType(CertTypeCB.ItemIndex) of
    hctEducation, hctEducation_Entrust: begin
      if TrainedSubjectEdit.Text = '' then
      begin
        TrainedSubjectEdit.Color := clYellow;
        RestoreColorExceptComponent(TrainedSubjectEdit.Tag);
        exit;
      end;

      if TrainedCourseEdit.Text = '' then
      begin
        TrainedCourseEdit.Color := clYellow;
        RestoreColorExceptComponent(TrainedCourseEdit.Tag);
        exit;
      end;

      if CourseLevelCB.ItemIndex = -1 then
      begin
        CourseLevelCB.Color := clYellow;
        RestoreColorExceptComponent(CourseLevelCB.Tag);
        exit;
      end;

      if TraineeNameEdit.Text = '' then
      begin
        TraineeNameEdit.Color := clYellow;
        RestoreColorExceptComponent(TraineeNameEdit.Tag);
        exit;
      end;

      if TrainedBeginDatePicker.Color = clWindow then
      begin
        TrainedBeginDatePicker.Color := clYellow;
        RestoreColorExceptComponent(TrainedBeginDatePicker.Tag);
        exit;
      end;

      if TrainedEndDatePicker.Color = clWindow then
      begin
        TrainedEndDatePicker.Color := clYellow;
        RestoreColorExceptComponent(TrainedEndDatePicker.Tag);
        exit;
      end;

      if UntilValidityDatePicker.Color = clWindow then
      begin
        UntilValidityDatePicker.Color := clYellow;
        RestoreColorExceptComponent(UntilValidityDatePicker.Tag);
        exit;
      end;

      if CertNoButtonEdit.Text = '' then
      begin
        CertNoButtonEdit.Color := clYellow;
        RestoreColorExceptComponent(CertNoButtonEdit.Tag);
        exit;
      end;
    end;
    hctAPTService: begin
      if CertNoButtonEdit.Text = '' then
      begin
        CertNoButtonEdit.Color := clYellow;
        RestoreColorExceptComponent(CertNoButtonEdit.Tag);
        exit;
      end;

      if IMONoEdit.Text = '' then
      begin
        IMONoEdit.Color := clYellow;
        RestoreColorExceptComponent(IMONoEdit.Tag);
        exit;
      end;

      if ShipNameEdit.Text = '' then
      begin
        ShipNameEdit.Color := clYellow;
        RestoreColorExceptComponent(ShipNameEdit.Tag);
        exit;
      end;

      if HullNoEdit.Text = '' then
      begin
        HullNoEdit.Color := clYellow;
        RestoreColorExceptComponent(HullNoEdit.Tag);
        exit;
      end;

      if VDRSerialNoEdit.Text = '' then
      begin
        VDRSerialNoEdit.Color := clYellow;
        RestoreColorExceptComponent(VDRSerialNoEdit.Tag);
        exit;
      end;

      if ReportNoEdit.Text = '' then
      begin
        ReportNoEdit.Color := clYellow;
        RestoreColorExceptComponent(ReportNoEdit.Tag);
        exit;
      end;

      if PlaceOfSurveyEdit.Text = '' then
      begin
        PlaceOfSurveyEdit.Color := clYellow;
        RestoreColorExceptComponent(PlaceOfSurveyEdit.Tag);
        exit;
      end;

      if ClassSocietyEdit.Text = '' then
      begin
        ClassSocietyEdit.Color := clYellow;
        RestoreColorExceptComponent(ClassSocietyEdit.Tag);
        exit;
      end;

      if VDRTypeEdit.Text = '' then
      begin
        VDRTypeEdit.Color := clYellow;
        RestoreColorExceptComponent(VDRTypeEdit.Tag);
        exit;
      end;

      if (PlaceOfSurveyEdit.Text <> '') and (ClassSocietyEdit.Text <> '') then
        if APTServiceDatePicker.Color = clWindow then
        begin
          APTServiceDatePicker.Color := clYellow;
          RestoreColorExceptComponent(APTServiceDatePicker.Tag);
          exit;
        end;
    end;
    hctProductApproval: begin

    end;
  end;
end;

procedure TCertEditF.FormCreate(Sender: TObject);
begin
  InitEnum;
  InitNetwork;
  g_CertEditF := Self;
  QRCodeFrame1.Panel1.Visible := False;
  g_ShipProductType.SetType2Combo(ProductTypeCB);
  g_AcademyCourseLevelDesc.SetType2Combo(CourseLevelCB);
  g_HGSCertType.SetType2Combo(CertTypeCB);
  InitHGSSerialClient('HGSSerial.sqlite');
  FGSFileDBName := '';
  FTempFileList := TStringList.Create;

//  Screen.OnActiveControlChange := ScreenActiveControlChange;
end;

procedure TCertEditF.FormDestroy(Sender: TObject);
var
  i: integer;
begin
//  Screen.OnActiveControlChange := nil;
  DestroyHGSSerial;
  DestroyJHPFile;

  try
    for i := 0 to FTempFileList.Count - 1 do
    begin
      try
        DeleteFile(FTempFileList.Strings[i]);
      except
      end;
    end;
  finally
    FTempFileList.Free;
  end;
end;

function TCertEditF.GetTempATRFileName(ASaveFileKind: TJHPFileFormat): string;
var
  LExt: string;
begin
  Result := 'c:\temp\'+HullNoEdit.Text+'_'+ATR_FILENAME;

  case ASaveFileKind of
    gfkWORD: LExt := '.doc';
    gfkPDF : LExt := '.pdf';
  else
    Lext := '';
  end;

  if Lext <> '' then
    Result := ChangeFileExt(Result, Lext);
end;

function TCertEditF.GetTempAttendantListFN(
  ASaveFileKind: TJHPFileFormat): string;
var
  LExt: string;
begin
  Result := 'c:\temp\'+CertNoButtonEdit.Text+'_'+LICLIST_FILENAME;

  case ASaveFileKind of
    gfkEXCEL: LExt := '.xls';
    gfkPDF : LExt := '.pdf';
  else
    Lext := '';
  end;

  if Lext <> '' then
    Result := ChangeFileExt(Result, Lext);
end;

function TCertEditF.GetABSCheckListFileName: string;
begin
  Result := '.\db\files\' + ABSCHECKLISTFileName;
end;

procedure TCertEditF.GetCertDetailFromCertRecord(
  ASQLHGSCertRecord: TSQLHGSCertRecord);
var
  LEmailDBName: string;
begin
  FDisableEditPosition := True;
  try
    if ASQLHGSCertRecord.IsUpdate then
    begin
      with ASQLHGSCertRecord do
      begin
        CertTypeCB.ItemIndex := Ord(CertType);
        CertTypeCBChange(nil);
        CertNoButtonEdit.Text := CertNo;
        SubCompanyEdit.Text := CompanyName;
        SubCompanyEdit2.Text := CompanyName2;
        CompanyCodeEdit.Text := CompanyCode;
        CompanyNationEdit.Text := CompanyNatoin;
        OrderNoEdit.Text := OrderNo;
        SalesAmountEdit.Text := SalesAmount;

        CertFileDBPathEdit.Text := CertFileDBPath;
        CertFileDBNameEdit.Text := CertFileDBName;
        NotesMemo.Text := Notes;

        PrevCertNoEdit.Text := PrevCertNo;
        ProductTypeCB.ItemIndex := Ord(ProductType);
        IssueDatePicker.Date := TimeLogToDateTime(IssueDate);
        UntilValidityDatePicker.Date := TimeLogToDateTime(UntilValidity);
        IgnoreInvoice.Checked := IsIgnoreInvoice;
        InvoiceCompanyEdit.Text := InvoiceCompanyName;
        InvoiceCompanyCodeEdit.Text := InvoiceCompanyCode;
        InvoiceCompanyNationEdit.Text := InvoiceCompanyNatoin;
        InvoiceEmailEdit.Text := InvoiceEmail;
        InvoiceIssueDatePicker.Date := TimeLogToDateTime(InvoiceIssueDate);
        InvoiceConfirmDatePicker.Date := TimeLogToDateTime(InvoiceConfirmDate);
        BillPaidDatePicker.Date := TimeLogToDateTime(BillPaidDate);

        TrainedSubjectEdit.Text := TrainedSubject;
        TrainedCourseEdit.Text := TrainedCourse;
        TraineeNameEdit.Text := TraineeName;
        TraineeNationEdit.Text := TraineeNation;
        CourseLevelCB.ItemIndex := Ord(CourseLevel);
        TrainedBeginDatePicker.Date := TimeLogToDateTime(TrainedBeginDate);
        TrainedEndDatePicker.Date := TimeLogToDateTime(TrainedEndDate);

        ReportNoEdit.Text := ReportNo;
        VDRSerialNoEdit.Text := VDRSerialNo;
        PlaceOfSurveyEdit.Text := PlaceOfSurvey;
        PICEmailEdit.Text := PICEmail;
        PICPhoneEdit.Text := PICPhone;
        IMONoEdit.Text := IMONo;
        ShipNameEdit.Text := ShipName;
        HullNoEdit.Text := HullNo;
        OwnerNameEdit.Text := OwnerName;
        VDRTypeEdit.Text := VDRType;
        ClassSocietyEdit.Text := ClassSociety;
        APTServiceDatePicker.Date := TimeLogToDateTime(APTServiceDate);
        VDRConfigMemo.Text := GetVDRConfigFromIMONo(IMONo);
        APTResultRG.ItemIndex := Ord(APTResult);

        if CertFileDBName <> '' then
        begin
          FGSFileDBName := 'files\'+CertFileDBName;
          FGSFileDBPath := CertFileDBPath;

          if FileExists(FGSFileDBName) then
            GetCertFileList2FileGrid(FGSFileDBName);
//          else
//            ShowMessage('FileDB('+FGSFileDBName+' is not exist');
        end;

        LEmailDBName := GetEMailDBName(Application.ExeName, ProductTypeCB.Text);
        GetCertEmailList2EmailGrid(LEmailDBName);
        CreateQRCode;
        GetPhotoImageFromDB(ASQLHGSCertRecord);
      end;
    end
    else
    begin//Create Cert.(�ű�) �� ���
      CertFileDBPathEditButtonClick(nil);
      CertNoButtonEdit.Enabled := True;
      CheckBox1.Checked := True;
      IssueDatePicker.Date := now;
      APTServiceDatePicker.Date := now;
    end;
  finally
    FDisableEditPosition := False;
  end;
end;

procedure TCertEditF.GetCertEmailList2EmailGrid(const ADBName: string);
begin
  InitOLEmailMsgClient(ADBName);
  FrameOLEmailList.ShowEmailListFromDBKey(FrameOLEmailList.grid_Mail, FrameOLEmailList.FDBKey);
end;

procedure TCertEditF.GetCertFileList2FileGrid(const AFileDBName: string);
//var
//  LSQLGSFile: TSQLGSFile;
begin
  InitJHPFileClient(AFileDBName);
  try
    if Assigned(GSFileFrame.FJHPFiles_) then
      FreeAndNil(GSFileFrame.FJHPFiles_);

    GSFileFrame.FJHPFiles_ := GetJHPFiles;
    try
      if GSFileFrame.FJHPFiles_.IsUpdate then
      begin
        GSFileFrame.LoadFiles2Grid;
      end;
    finally
//      FreeAndNil(GSFileFrame.FJHPFiles_);
    end;
  finally
    DestroyJHPFile;
  end;
end;

function TCertEditF.GetCertInfo2Json(AHGSCertType:THGSCertType): string;
var
  LDoc: Variant;
begin
  if CertNoButtonEdit.Text = '' then
  begin
    ShowMessage('Cert. No. is invalid!');
    exit;
  end;

  TDocVariant.New(LDoc);

  LDoc.CertNo := CertNoButtonEdit.Text;
  LDoc.ProductType := ProductTypeCB.ItemIndex;
  LDoc.CertType := CertTypeCB.ItemIndex;
//  LDoc.CompanyName := SubCompanyEdit.Text;
//  LDoc.CompanyName2 := SubCompanyEdit2.Text;
  LDoc.CompanyCode := CompanyCodeEdit.Text;
//  LDoc.CompanyNatoin := CompanyNationEdit.Text;
//  LDoc.OrderNo := OrderNoEdit.Text;
//  LDoc.SalesAmount := SalesAmountEdit.Text;
//  LDoc.CertFileDBName := CertFileDBNameEdit.Text;

  if (AHGSCertType = hctEducation) or (AHGSCertType = hctEducation_Entrust) then
  begin
    LDoc.TrainedCourse := TrainedCourseEdit.Text;
    LDoc.TrainedSubject := TrainedSubjectEdit.Text;
    LDoc.CourseLevel := CourseLevelCB.ItemIndex;
    LDoc.TraineeName := TraineeNameEdit.Text;
    LDoc.TraineeNation := TraineeNationEdit.Text;
    LDoc.TrainedBeginDate := TrainedBeginDatePicker.Date;
    LDoc.TrainedEndDate := TrainedEndDatePicker.Date;
    LDoc.UntilValidity := UntilValidityDatePicker.Date;
  end
  else
  if AHGSCertType = hctAPTService then
  begin
    LDoc.ReportNo := ReportNoEdit.Text;
    LDoc.VDRSerialNo := VDRSerialNoEdit.Text;
//    LDoc.PlaceOfSurvey := PlaceOfSurveyEdit.Text;
//    LDoc.PICEmail := PICEmailEdit.Text;
//    LDoc.PICPhone := PICPhoneEdit.Text;
    LDoc.IMONo := IMONoEdit.Text;
//    LDoc.ShipName := ShipNameEdit.Text;
    LDoc.HullNo := HullNoEdit.Text;
//    LDoc.OwnerName := OwnerNameEdit.Text;
//    LDoc.ClassSociety := ClassSocietyEdit.Text;
//    LDoc.APTServiceDate := APTServiceDatePicker.Date;
  end
  else
  if AHGSCertType = hctProductApproval then
  begin

  end
  else
  begin

  end;
//  LDoc.CertFileDBPath := CertFileDBPathEdit.Text;

  Result := _JSON(LDoc);
end;

function TCertEditF.GetJsonFromQRCode: string;
var
  LDocType: THGSCertType;
begin
  LDocType := g_HGSCertType.ToType(CertTypeCB.ItemIndex);
  Result := GetCertInfo2Json(LDocType);
end;

function TCertEditF.GetLRCheckListFileName: string;
begin
  Result := '.\db\files\' + LRCHECKLISTFileName;
end;

procedure TCertEditF.GetPhotoImageFromDB(AOrm: TSQLHGSCertRecord);
var
  LStream: TMemoryStream;
begin
  LStream := TMemoryStream.Create;
  try
    if GetImagePhotoFromHGSCertRecord(LStream, AOrm) then
    begin
      LStream.Position := 0;
      try
        PhotoImage.Picture.LoadFromStream(LStream);
      except
      end;
    end;
  finally
    LStream.Free;
  end;
end;

procedure TCertEditF.SavePhotoImage2DB(AOrm: TSQLHGSCertRecord);
var
  LImgData: RawBlob;
  LStream: TRawByteStringStream;
begin
  if PhotoImage.Picture = nil then
    exit;

  LStream := TRawByteStringStream.Create;
  try
    PhotoImage.Picture.SaveToStream(LStream);

    AddOrUpdateHGSCertPhoto(LStream.DataString, AOrm);
  finally
    LStream.Free;
  end;

end;

function TCertEditF.GetTempCOCFileName(ASaveFileKind: TJHPFileFormat): string;
var
  LExt: string;
begin
  Result := 'c:\temp\'+HullNoEdit.Text+'_' + COC_FILENAME;

  case ASaveFileKind of
    gfkWORD: LExt := '.doc';
    gfkPDF : LExt := '.pdf';
  else
    Lext := '';
  end;

  if Lext <> '' then
    Result := ChangeFileExt(Result, Lext);
end;

function TCertEditF.GetTempPhotoFileName(ASaveFileKind: TJHPFileFormat): string;
var
  LExt: string;
begin
  Result := 'c:\temp\'+CertNoButtonEdit.Text+'_'+PHOTO_FILENAME;

  case ASaveFileKind of
    gfkPng: LExt := '.png';
    gfkJpg : LExt := '.jpg';
  else
    Lext := '';
  end;

  if Lext <> '' then
    Result := ChangeFileExt(Result, Lext);
end;

function TCertEditF.GetTempQRFileName(ASaveFileKind: TJHPFileFormat): string;
var
  LExt: string;
begin
  Result := 'c:\temp\'+CertNoButtonEdit.Text+'_'+QRCODE_FILENAME;

  case ASaveFileKind of
    gfkPng: LExt := '.png';
    gfkJpg : LExt := '.jpg';
  else
    Lext := '';
  end;

  if Lext <> '' then
    Result := ChangeFileExt(Result, Lext);
end;

function TCertEditF.GetTempVDRConfigFileName: string;
begin
  Result := 'c:\temp\'+VDRConfigFileName;
end;

function TCertEditF.GetTempZipFileName: string;
begin

end;

function TCertEditF.GetGridColNamesFromForm4LicenseList: variant;
begin
  TDocVariant.New(Result);

  TDocVariantData(Result).AddValue('ī�����', '1');
  TDocVariantData(Result).AddValue('Name', '2');
  TDocVariantData(Result).AddValue('Nationality', '3');
  TDocVariantData(Result).AddValue('Company', '4');
  TDocVariantData(Result).AddValue('Trained Period', '5');
  TDocVariantData(Result).AddValue('Course', '6');
  TDocVariantData(Result).AddValue('Cert. No.', '7');
  TDocVariantData(Result).AddValue('Validity Date', '8');
  TDocVariantData(Result).AddValue('�������ϸ�', '9');
  TDocVariantData(Result).AddValue('QRCode ���ϸ�', '10');
end;

function TCertEditF.GetGridRowDataFromForm4LicenseList: variant;
begin
  TDocVariant.New(Result);

  TDocVariantData(Result).AddValue('ī�����', '1');
  TDocVariantData(Result).AddValue(TraineeNameEdit.Text, '2');
  TDocVariantData(Result).AddValue(TraineeNationEdit.Text, '3');
  TDocVariantData(Result).AddValue('Company', '4');
  TDocVariantData(Result).AddValue('Trained Period', '5');
  TDocVariantData(Result).AddValue('Course', '6');
  TDocVariantData(Result).AddValue('Cert. No.', '7');
  TDocVariantData(Result).AddValue('Validity Date', '8');
  TDocVariantData(Result).AddValue('�������ϸ�', '9');
  TDocVariantData(Result).AddValue('QRCode ���ϸ�', '10');
end;

function TCertEditF.GetVDRConfigFromIMONo(AIMONo: string): string;
var
  LSQLHGSVDRRecord: TSQLHGSVDRRecord;
begin
  Result := '';

  InitHGSVDRClient(HGS_VDRLIST_DB_NAME);
  try
    LSQLHGSVDRRecord := GetHGSVDRFromIMONo(AIMONo);

    if LSQLHGSVDRRecord.IsUpdate then
    begin
      Result := LSQLHGSVDRRecord.VDRConfig;
      Result := StringReplace(Result, #10, #13#10, [rfReplaceAll]);
    end;
  finally
    DestroyHGSVDR;
  end;
end;

function TCertEditF.GetZipFileName4Doc: string;
var
  LTempDir: string;
begin
  Result := ReportNoEdit.Text;

  if Result = '' then
  begin
    ShowMessage('Please check the Report No.');
    exit;
  end;

  LTempDir := 'c:\temp\';
  EnsureDirectoryExists(LTempDir);
  Result := LTempDir+Result;
  Result := ChangeFileExt(Result, '.zip');
end;

function TCertEditF.GetSerialNoFromCertNo(ACertNo: string; var AYear: integer): string;
var
  LStr: string;
begin
  Result := '';

//  if Length(ACertNo) = 17 then
//  begin
    LStr := ACertNo;
    strToken(LStr, '-');
    LStr := strToken(LStr, '-');
    AYear := StrToIntDef(LStr,0);
    Result := RightStr(ACertNo,4);
//  end;
end;

procedure TCertEditF.HullNoEditButtonClick(Sender: TObject);
begin
  ShowSearchVesselForm(Sender);
  DisplayEditPosition;
end;

procedure TCertEditF.IMONoEditButtonClick(Sender: TObject);
begin
  ShowSearchVesselForm(Sender);
  DisplayEditPosition;
end;

procedure TCertEditF.InitEnum;
begin
  g_AcademyCourseLevel.InitArrayRecord(R_AcademyCourseLevel);
  g_AcademyCourseLevelDesc.InitArrayRecord(R_AcademyCourseLevelDesc);
  g_CertQueryDateType.InitArrayRecord(R_CertQueryDateType);
  g_HGSCertType.InitArrayRecord(R_HGSCertType);
  g_HGSCertTypeCode.InitArrayRecord(R_HGSCertTypeCode);
  g_CertFindCondition.InitArrayRecord(R_CertFindCondition);
  g_HGSCertDocType.InitArrayRecord(R_HGSCertDocType);
end;

procedure TCertEditF.InitNetwork;
begin
  FrameOLEmailList.SetWSInfoRec4OL(FSettings.WSServerIPAddr, FSettings.WSServerPort,
    FSettings.WSServerTransmissionKey, FSettings.WSEnabled);
  FrameOLEmailList.SetNamedPipeInfoRec4OL(FSettings.NamedPipeComputerName, FSettings.NamedPipeServerName,
    FSettings.NamedPipeEnabled);
  FrameOLEmailList.SetMQInfoRec4OL(FSettings.MQServerIP, FSettings.MQServerPort,
    FSettings.MQServerUserId, FSettings.MQServerPasswd,
    FSettings.MQServerTopic, FSettings.MQServerEnable);
end;

procedure TCertEditF.InvoiceCompanyEditClickBtn(Sender: TObject);
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
          Self.InvoiceCompanyEdit.Text := NextGrid1.CellByName['CompanyName', NextGrid1.SelectedRow].AsString;
          Self.InvoiceCompanyCodeEdit.Text := NextGrid1.CellByName['CompanyCode', NextGrid1.SelectedRow].AsString;
          Self.InvoiceCompanyNationEdit.Text := NextGrid1.CellByName['Nation', NextGrid1.SelectedRow].AsString;
        end;
      end;
    end;
  finally
    LSearchCustomerF.Free;
    DisplayEditPosition;
  end;
end;

procedure TCertEditF.IssueDatePickerChange(Sender: TObject);
begin
  DisplayEditPosition;
end;

function TCertEditF.LoadCertDetail2CertRecordFromForm(
  var ACertRecord: TSQLHGSCertRecord): Boolean;
var
  LSQLHGSCertRecord: TSQLHGSCertRecord;
begin
  Result := CertNoButtonEdit.Text <> '';

  if not Result then
  begin
    ShowMessage('Cert. No. is invalid!');
    exit;
  end;

  with ACertRecord do
  begin
    CertNo := CertNoButtonEdit.Text;

    try
      LSQLHGSCertRecord := GetHGSCertFromCertNo(CertNo);
      IsUpdate := LSQLHGSCertRecord.IsUpdate;
    finally
      LSQLHGSCertRecord.Free;
    end;

    CertType := g_HGSCertType.ToType(CertTypeCB.ItemIndex);
    CompanyName := SubCompanyEdit.Text;
    CompanyName2 := SubCompanyEdit2.Text;
    CompanyCode := CompanyCodeEdit.Text;
    CompanyNatoin := CompanyNationEdit.Text;
    OrderNo := OrderNoEdit.Text;
    SalesAmount := SalesAmountEdit.Text;
    ProductType := g_ShipProductType.ToType(ProductTypeCB.ItemIndex);
    CertFileDBPath := CertFileDBPathEdit.Text;
    CertFileDBName := CertFileDBNameEdit.Text;
    PrevCertNo := PrevCertNoEdit.Text;
    FileCount := GSFileFrame.fileGrid.RowCount;
    UntilValidity := TimeLogFromDateTime(UntilValidityDatePicker.Date);
    UpdateDate := TimeLogFromDateTime(now);
    IssueDate := TimeLogFromDateTime(IssueDatePicker.Date);
    IsIgnoreInvoice := IgnoreInvoice.Checked;
    InvoiceCompanyName := InvoiceCompanyEdit.Text;
    InvoiceCompanyCode := InvoiceCompanyCodeEdit.Text;
    InvoiceCompanyNatoin := InvoiceCompanyNationEdit.Text;
    InvoiceEmail := InvoiceEmailEdit.Text;
    InvoiceIssueDate := TimeLogFromDateTime(InvoiceIssueDatePicker.Date);
    InvoiceConfirmDate := TimeLogFromDateTime(InvoiceConfirmDatePicker.Date);
    BillPaidDate := TimeLogFromDateTime(BillPaidDatePicker.Date);
    Notes := NotesMemo.Text;

    TrainedSubject := TrainedSubjectEdit.Text;
    TrainedCourse := TrainedCourseEdit.Text;
    TraineeName := TraineeNameEdit.Text;
    TraineeNation := TraineeNationEdit.Text;
    if CourseLevelCB.ItemIndex <> -1 then
      CourseLevel := g_AcademyCourseLevel.ToType(CourseLevelCB.ItemIndex);
    TrainedBeginDate := TimeLogFromDateTime(TrainedBeginDatePicker.Date);
    TrainedEndDate := TimeLogFromDateTime(TrainedEndDatePicker.Date);

    ReportNo := ReportNoEdit.Text;
    VDRSerialNo := VDRSerialNoEdit.Text;
    PlaceOfSurvey := PlaceOfSurveyEdit.Text;
    PICEmail := PICEmailEdit.Text;
    PICPhone := PICPhoneEdit.Text;
    IMONo := IMONoEdit.Text;
    ShipName := ShipNameEdit.Text;
    HullNo := HullNoEdit.Text;
    OwnerName := OwnerNameEdit.Text;
    ClassSociety := ClassSocietyEdit.Text;
    VDRType := VDRTypeEdit.Text;
    APTServiceDate := TimeLogFromDateTime(APTServiceDatePicker.Date);
    APTResult := g_VDRAPTResult.ToType(APTResultRG.ItemIndex);
  end;
end;

procedure TCertEditF.MakeCert2MSPPT(ACertType: integer; AOriginalFileName: string;
  ASaveFileKind: TJHPFileFormat; AIsSaveFile, AIsWordClose: Boolean);
var
  PptApp, PptApp2: PowerPointApplication;
  LWordDocument: OLEVariant;
  LTable, LTable2, LCell: OLEVariant;
  LCompanyName, LDate: string;
  LStr, LStr2, LStr3: string;
  FormatStrings: TFormatSettings;
  LMonth: integer;
  LIni: TMemIniFile;
begin
  PptApp := GetActiveMSPPTClass(AOriginalFileName, True);

  case ACertType of
    1,4: begin
      PPT_StringReplace(PptApp, 'Cert_No', CertNoButtonEdit.Text);

//      if  TrainedCourseEdit.Text = 'HIMSEN PRACTICAL ADVANCED' then
//      begin
//        Word_StringFindNFontSize(PptApp, 'T_Course2', 14);
//      end;

      PPT_StringReplace(PptApp, 'T_Course2', TrainedCourseEdit.Text);
      PPT_StringReplace(PptApp, 'T_Name', TraineeNameEdit.Text);
      LStr := SubCompanyEdit2.Text;

      if LStr = '' then
        LStr := SubCompanyEdit.Text;

      PPT_StringReplace(PptApp, 'C_Name', LStr);
      GetLocaleFormatSettings($0409, FormatStrings);
      LMonth := MonthOf(TrainedBeginDatePicker.Date);
      LDate := FormatStrings.ShortMonthNames[LMonth] + '. ';
      LStr := LDate + FormatDateTime('dd', TrainedBeginDatePicker.Date) + ' ~ ';
      LMonth := MonthOf(TrainedEndDatePicker.Date);
      LDate := FormatStrings.ShortMonthNames[LMonth] + '. ';
      LStr := LStr + LDate + FormatDateTime('dd, yyyy', TrainedEndDatePicker.Date);
      PPT_StringReplace(PptApp, 'T_Period', LStr);
      PPT_StringReplace(PptApp, 'T_Subject', TrainedSubjectEdit.Text);

      if  TrainedCourseEdit.Text = 'HIMSEN PRACTICAL ADVANCED' then
        Word_StringFindNFontSize(PptApp, 'T_Course', 17);

      PPT_StringReplace(PptApp, 'T_Course', TrainedSubjectEdit.Text);

      GetLocaleFormatSettings($0409, FormatStrings);
      LMonth := MonthOf(UntilValidityDatePicker.Date);
      LStr := FormatStrings.ShortMonthNames[LMonth] + ', ';
      LDate := FormatDateTime('yyyy', UntilValidityDatePicker.Date);
      LStr := LStr + LDate;
      PPT_StringReplace(PptApp, 'V_Date', LStr);
      PPT_InsertImageToPPTFromClipboard(PptApp);
    end;
    2: begin
    end;
    3: begin
    end;
  end;
end;

procedure TCertEditF.MakeCert2MSWord(ACertType: integer; AOriginalFileName: string;
  ASaveFileKind: TJHPFileFormat; AIsSaveFile, AIsWordClose: Boolean);
var
  WordApp, WordApp2: WordApplication;
  LWordDocument: OLEVariant;
  LTable, LTable2, LCell: OLEVariant;
  LCompanyName, LDate: string;
  LStr, LStr2, LStr3: string;
  FormatStrings: TFormatSettings;
  LMonth: integer;
  LIni: TMemIniFile;
begin
  WordApp := GetActiveMSWordClass(AOriginalFileName, True);
  QRCodeFrame1.CopyBitmapToClipboard;

  case ACertType of
    1,4: begin
      Word_StringReplace2(WordApp, 'Cert_No', CertNoButtonEdit.Text, [wrfReplaceAll]);

      if  TrainedCourseEdit.Text = 'HIMSEN PRACTICAL ADVANCED' then
      begin
        Word_StringFindNFontSize(WordApp, 'T_Course2', 14);
      end;

      Word_StringReplace2(WordApp, 'T_Course2', TrainedCourseEdit.Text, [wrfReplaceAll]);
      Word_StringReplace2(WordApp, 'T_Name', TraineeNameEdit.Text, [wrfReplaceAll]);
      LStr3 := SubCompanyEdit2.Text;

      if LStr3 = '' then
        LStr3 := SubCompanyEdit.Text;

      Word_StringReplace2(WordApp, 'C_Name', LStr3, [wrfReplaceAll]);
      GetLocaleFormatSettings($0409, FormatStrings);
      LMonth := MonthOf(TrainedBeginDatePicker.Date);
      LDate := FormatStrings.ShortMonthNames[LMonth] + '. ';
      LStr := LDate + FormatDateTime('dd', TrainedBeginDatePicker.Date) + ' ~ ';
      LMonth := MonthOf(TrainedEndDatePicker.Date);
      LDate := FormatStrings.ShortMonthNames[LMonth] + '. ';
      LStr := LStr + LDate + FormatDateTime('dd, yyyy', TrainedEndDatePicker.Date);
      Word_StringReplace2(WordApp, 'T_Period', LStr, [wrfReplaceAll]);
      Word_StringReplace2(WordApp, 'T_Subject', TrainedSubjectEdit.Text, [wrfReplaceAll]);

      if  TrainedCourseEdit.Text = 'HIMSEN PRACTICAL ADVANCED' then
        Word_StringFindNFontSize(WordApp, 'T_Course', 17);

      Word_StringReplace2(WordApp, 'T_Course', TrainedCourseEdit.Text, [wrfReplaceAll]);

      GetLocaleFormatSettings($0409, FormatStrings);
      LMonth := MonthOf(UntilValidityDatePicker.Date);
      LStr := FormatStrings.ShortMonthNames[LMonth] + ', ';
      LDate := FormatDateTime('yyyy', UntilValidityDatePicker.Date);
      LStr := LStr + LDate;
      Word_StringReplace2(WordApp, 'V_Date', LStr, [wrfReplaceAll]);
      QRCodeFrame1.CopyBitmapToClipboard;
      Word_InsertImageFromClipboard(WordApp);
    end;
    2: begin
      Word_StringReplace2(WordApp, 'Report_No', ReportNoEdit.Text, [wrfReplaceAll]);
      Word_StringReplace2(WordApp, 'PlaceOfSurvey', PlaceOfSurveyEdit.Text, [wrfReplaceAll]);
      Word_StringReplace2(WordApp, 'PIC@Email', PICEmailEdit.Text, [wrfReplaceAll]);
      Word_StringReplace2(WordApp, 'pic@email', PICEmailEdit.Text, [wrfReplaceAll]);
      Word_StringReplace2(WordApp, 'Phone_No', PICPhoneEdit.Text, [wrfReplaceAll]);

      LStr := VDRTypeEdit.Text;
      if LStr = 'E' then
        LStr := 'HIVDR-' + LStr + ' ' + VDRSerialNoEdit.Text
      else
      if LStr = 'N' then
        LStr := 'HIVDR ' + VDRSerialNoEdit.Text;

      Word_StringReplace2(WordApp, 'VDR_Serial_No', LStr, [wrfReplaceAll]);
      LStr := FormatDateTime('yyyy-mm-dd', APTServiceDatePicker.Date);//IssueDatePicker
      Word_StringReplace2(WordApp, 'Issue_Date', LStr, [wrfReplaceAll]);
      Word_StringReplace2(WordApp, 'Class_Society', ClassSocietyEdit.Text, [wrfReplaceAll]);
      Word_StringReplace2(WordApp, 'Company_Name', OwnerNameEdit.Text, [wrfReplaceAll]);
      Word_StringReplace2(WordApp, 'Ship_Name', ShipNameEdit.Text, [wrfReplaceAll]);

      GetLocaleFormatSettings($0409, FormatStrings);
      LMonth := MonthOf(APTServiceDatePicker.Date);
      LStr := FormatStrings.LongMonthNames[LMonth] + ' ';
      LDate := FormatDateTime('yyyy', APTServiceDatePicker.Date);
      LStr := LStr + LDate;
      Word_StringReplace2(WordApp, 'Service_Date', LStr, [wrfReplaceAll]);

      LWordDocument := WordApp.ActiveDocument;
      LTable := LWordDocument.Tables.Item(1);
      LTable2 := LTable.Tables.Item(1);
      LCell := LTable2.Cell(1,1);
      QRCodeFrame1.CopyBitmapToClipboard;
      Word_InsertImageToCellFromClipboard(LCell);

      Word_StringReplaceFooter(WordApp, 'Report_No', ReportNoEdit.Text, []);

      if AIsSaveFile then
      begin
        LStr := GetTempATRFileName; //.pjh�� ��ȯ��

        if ASaveFileKind = gfkWORD then
          Word_SaveAs(WordApp.ActiveDocument, LStr, wdFormatDocument)
        else
        if ASaveFileKind = gfkPDF then
          Word_SaveAs(WordApp.ActiveDocument, LStr, wdFormatPDF);
//          WordApp.ActiveDocument.SaveAs(LStr, wdFormatPDF);
      end;

      if AIsWordClose then
      begin
//        WordApp.ActiveDocument.Close;
//        WordApp.Quit;
        Document_Close(WordApp.ActiveDocument);
        Word_Quit(WordApp);
      end;

      LStr := CertFileDBPathEdit.Text;
      LStr := LStr+COC_FILENAME;

      if not FileExists(LStr) then
      begin
        ShowMessage('File (' + LStr + ') is not exists');
        exit;
      end;

      LStr := ExpandFileName(LStr);
      WordApp2 := GetActiveMSWordClass(LStr, True);
      Word_StringReplace2(WordApp2, 'Cert_No', CertNoButtonEdit.Text, [wrfReplaceAll]);
      Word_StringReplace2(WordApp2, 'Ship_Name', ShipNameEdit.Text, [wrfReplaceAll]);
      Word_StringReplace2(WordApp2, 'Imo_No', IMONoEdit.Text, [wrfReplaceAll]);
      Word_StringReplace2(WordApp2, 'VDR_Serial_No', VDRSerialNoEdit.Text, [wrfReplaceAll]);
      Word_StringReplace2(WordApp2, 'Place_Of_Survey', PlaceOfSurveyEdit.Text, [wrfReplaceAll]);

      LStr := FormatDateTime('dd', APTServiceDatePicker.Date) + ' ' +
        FormatStrings.LongMonthNames[LMonth] + ' ';
      LStr := LStr + LDate;
      Word_StringReplace2(WordApp2, 'Service_Date', LStr, [wrfReplaceAll]);

      Word_StringReplace2(WordApp2, 'Agent_Name', SubCompanyEdit.Text, [wrfReplaceAll]);
      Word_StringReplace2(WordApp2, 'Agent_Nation', CompanyNationEdit.Text, [wrfReplaceAll]);
//      Sleep(5000);
      QRCodeFrame1.CopyBitmapToClipboard;
      Word_InsertImageFromClipboard(WordApp2);

      if AIsSaveFile then
      begin
        LStr := GetTempCOCFileName;

        if ASaveFileKind = gfkWORD then
          Word_SaveAs(WordApp2.ActiveDocument, LStr, wdFormatDocument)
        else
        if ASaveFileKind = gfkPDF then
          Word_SaveAs(WordApp2.ActiveDocument, LStr, wdFormatPDF);
//          WordApp.ActiveDocument.SaveAs(LStr, wdFormatPDF);
      end;

      if AIsWordClose then
      begin
//        WordApp2.ActiveDocument.Close;
//        WordApp2.Quit;
        Document_Close(WordApp2.ActiveDocument);
        Word_Quit(WordApp2);
      end;

      if VDRConfigMemo.Text <> '' then
      begin
        LIni := TMemIniFile.Create('');
        try
          LIni.SetStrings(VDRConfigMemo.Lines);

          LStr := LIni.ReadString('Normal Configuration Data', 'Vessel', '');
          LMonth := VDRConfigMemo.Lines.IndexOf('Vessel='+LStr);
          if LMonth > -1 then
            VDRConfigMemo.Lines.Strings[LMonth] := 'Vessel='+ShipNameEdit.Text;

          LStr := LIni.ReadString('Normal Configuration Data', 'IMO Vessel ID', '');
          LMonth := VDRConfigMemo.Lines.IndexOf('IMO Vessel ID='+LStr);
          if LMonth > -1 then
            VDRConfigMemo.Lines.Strings[LMonth] := 'IMO Vessel ID='+IMONoEdit.Text;

          LStr := LIni.ReadString('Normal Configuration Data', 'Type Approval Authority', '');
          LMonth := VDRConfigMemo.Lines.IndexOf('Type Approval Authority='+LStr);
          if LMonth > -1 then
            VDRConfigMemo.Lines.Strings[LMonth] := 'Type Approval Authority='+ClassSocietyEdit.Text;

          VDRConfigMemo.Lines.SaveToFile(GetTempVDRConfigFileName);
        finally
          LIni.Free;
        end;
      end;

    end;
    3: begin
      LCompanyName := SubCompanyEdit.Text;
      Word_StringReplace2(WordApp, 'CompanyName1', LCompanyName, [wrfReplaceAll]);
      LCompanyName := CompanyNationEdit.Text;
      Word_StringReplace2(WordApp, 'CompanyNation', LCompanyName, [wrfReplaceAll]);
      LMonth := MonthOf(IssueDatePicker.Date);
      GetLocaleFormatSettings($0409, FormatStrings);
      LStr := FormatStrings.LongMonthNames[LMonth] + ' ';
      LDate := FormatDateTime('dd yyyy', IssueDatePicker.Date);
      Insert(LStr, LDate, 4);
      Word_StringReplace2(WordApp, 'Date1', LDate, [wrfReplaceAll]);
      Word_StringReplace2(WordApp, 'Cert_No', CertNoButtonEdit.Text, [wrfReplaceAll]);
      QRCodeFrame1.CopyBitmapToClipboard;
      Word_InsertImageFromClipboard(WordApp,2);
    end;
  end;
end;

//ACertType = 1 : Education�� Cert
//            2 : APT Report�� Cert
//            3 : Product Approval�� Cert
//            4 : ��Ź������ Cert
procedure TCertEditF.MakeCertDoc(ACertType: integer; AIsSaveFile: Boolean;
  ASaveFileKind: TJHPFileFormat; AIsWordClose: Boolean);
var
  LStr, LStr2: string;
  LGSFileKind: TJHPFileFormat;
begin
  SetCurrentDir(ExtractFilePath(Application.exename));
  LStr := CertFileDBPathEdit.Text;

  if LStr = '' then
  begin
    ShowMessage('Please fill in the "File DB Path" first!');
    exit;
  end;

  QRCodeFrame1.CopyBitmapToClipboard;

  //Cert ���� ���� �̸� ������
  case THGSCertType(ACertType) of
    hctEducation,hctEducation_Entrust: LStr2 := EDU_FILENAME2; //Education, Enthrust Edu
    hctLicBasic, hctLicInter, hctLicAdv: LStr2 := EDU_FILENAME2;//LICLIST_FILENAME;
    hctAPTService: begin //APT
      if IMONoEdit.Text = '' then
      begin
        ShowMessage('Please select IMO no!');
        exit;
      end;

      if CheckIfExistATRFileFromDB(IMONoEdit.Text, LStr2) then
      begin
        LStr := ExtractFilePath(LStr2);
        LStr2 := ExtractFileName(LStr2);
      end
      else
        LStr2 := ATR_FILENAME;

//      LStr3 := COC_FILENAME;
    end;

    hctProductApproval: LStr2 := PROD_APPROVAL_FILENAME; //Product Approval
  end;

  LStr := LStr+LStr2;

  if not FileExists(LStr) then
  begin
    ShowMessage('File (' + LStr + ') is not exists');
    exit;
  end;

  LStr := ExpandFileName(LStr);
  LGSFileKind := GetJHPFileFormatFromFileName(LStr);

  case LGSFileKind of
    gfkWORD, gfkPJH: MakeCert2MSWord(ACertType, LStr, ASaveFileKind, AIsSaveFile, AIsWordClose);
    gfkPDF: ;
    gfkPPT, gfkPJH2: MakeCert2MSPPT(ACertType, LStr, ASaveFileKind, AIsSaveFile, AIsWordClose);
  end;
end;

procedure TCertEditF.MakeCertXls;
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LRange: OleVariant;
  LWorksheet: OleVariant;
  LPicture: OleVariant;
  LStr, LStr2: string;
begin
  LStr := CertFileDBPathEdit.Text;

  LExcel := GetActiveExcelOleObject(True);
  try
    LWorkBook := LExcel.Workbooks.Open(LStr + 'Cert.ods');
    LWorksheet := LExcel.ActiveSheet;

    LStr := CertNoButtonEdit.Text;
    strToken(LStr, '-'); //CertNo���� HGA ����
    LStr2 := strToken(LStr, '-'); //�⵵
    LRange := LWorksheet.range['Q2'];
    LRange.FormulaR1C1 := LStr2;
    LRange := LWorksheet.range['U2'];
    LRange.Value := '''' + LStr;
    LRange := LWorksheet.range['Z29'];
    LRange.FormulaR1C1 := TrainedSubjectEdit.Text;
    LRange := LWorksheet.range['Z34'];
    LRange.FormulaR1C1 := TraineeNameEdit.Text;
    LRange := LWorksheet.range['Z38'];
    LRange.FormulaR1C1 := SubCompanyEdit.Text;
    LRange := LWorksheet.range['Z41'];
    LRange.FormulaR1C1 := FormatDateTime('mmm.dd', TrainedBeginDatePicker.Date) + ' ~ ' +
      FormatDateTime('mmm.dd,yyyy', TrainedEndDatePicker.Date);
    LRange := LWorksheet.range['Z45'];
    LRange.FormulaR1C1 := TrainedSubjectEdit.Text;
    LRange := LWorksheet.range['Z48'];
    LRange.FormulaR1C1 := TrainedCourseEdit.Text;
    LRange := LWorksheet.range['AP52'];
    LRange.FormulaR1C1 := FormatDateTime('mmm',UntilValidityDatePicker.Date);
    LRange := LWorksheet.range['AT52'];
    LRange.FormulaR1C1 := FormatDateTime('yyyy',UntilValidityDatePicker.Date);
    QRCodeFrame1.CopyBitmapToClipboard;
    LRange := LWorksheet.range['AS55'];
    LRange.Select;
    LWorksheet.Paste;
//    LPicture := LRange.ColumnWidth;
//    LPicture := LRange.RowHeight;
    LExcel.Selection.ShapeRange.Width := LRange.ColumnWidth*6;
    LExcel.Selection.ShapeRange.Height := LRange.RowHeight*6;
  finally
//    LWorkBook.Close;
//    LExcel.Quit;
  end;
end;

procedure TCertEditF.MakeLicenseDoc(ACertType: integer;
  AIsSaveFile: Boolean; ASaveFileKind: TJHPFileFormat; AIsWordClose: Boolean);
var
  LFileName: string;
begin
  //c:\temp\ �� PhotoFile ������(CertNo + Photo.jpg)
  LFileName := GetTempPhotoFileName;
  PhotoImage.Picture.SaveToFile(LFileName);

  //c:\temp\ �� QRCodeFile ������(CertNo + QRCode.png)
  LFileName := GetTempQRFileName;
  QRCodeFrame1.SaveToFile(LFileName);

  //c:\temp\ �� License list ���� ���� ������(CertNo + LicenseList.ods)
  LFileName := GetTempAttendantListFN;
//  GetGridColNamesFromForm4LicenseList;
//  AddNextGridColumnFromVariant;
//  MakeLicenseListXls;
end;

procedure TCertEditF.MakeLicenseListXls;
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LRange: OleVariant;
  LWorksheet: OleVariant;
  LPicture: OleVariant;
  LStr, LStr2, LCellNo: string;
begin
  LStr := CertFileDBPathEdit.Text;

  LExcel := GetActiveExcelOleObject(True);
  try
    LWorkBook := LExcel.Workbooks.Open(LStr + LICLIST_FILENAME);
    LWorksheet := LExcel.ActiveSheet;

    LStr := CertNoButtonEdit.Text;
    strToken(LStr, '-'); //CertNo���� HGA ����
    LStr2 := strToken(LStr, '-'); //�⵵
    LRange := LWorksheet.range['Q2'];
    LRange.FormulaR1C1 := LStr2;
    LRange := LWorksheet.range['U2'];
    LRange.Value := '''' + LStr;
    LRange := LWorksheet.range['Z29'];
    LRange.FormulaR1C1 := TrainedSubjectEdit.Text;
    LRange := LWorksheet.range['Z34'];
    LRange.FormulaR1C1 := TraineeNameEdit.Text;
    LRange := LWorksheet.range['Z38'];
    LRange.FormulaR1C1 := SubCompanyEdit.Text;
    LRange := LWorksheet.range['Z41'];
    LRange.FormulaR1C1 := FormatDateTime('mmm.dd', TrainedBeginDatePicker.Date) + ' ~ ' +
      FormatDateTime('mmm.dd,yyyy', TrainedEndDatePicker.Date);
    LRange := LWorksheet.range['Z45'];
    LRange.FormulaR1C1 := TrainedSubjectEdit.Text;
    LRange := LWorksheet.range['Z48'];
    LRange.FormulaR1C1 := TrainedCourseEdit.Text;
    LRange := LWorksheet.range['AP52'];
    LRange.FormulaR1C1 := FormatDateTime('mmm',UntilValidityDatePicker.Date);
    LRange := LWorksheet.range['AT52'];
    LRange.FormulaR1C1 := FormatDateTime('yyyy',UntilValidityDatePicker.Date);
    QRCodeFrame1.CopyBitmapToClipboard;
    LRange := LWorksheet.range['AS55'];
    LRange.Select;
    LWorksheet.Paste;
//    LPicture := LRange.ColumnWidth;
//    LPicture := LRange.RowHeight;
    LExcel.Selection.ShapeRange.Width := LRange.ColumnWidth*6;
    LExcel.Selection.ShapeRange.Height := LRange.RowHeight*6;
  finally
//    LWorkBook.Close;
//    LExcel.Quit;
  end;
end;

function TCertEditF.MakeZip4APTDoc(AFileKind: TJHPFileFormat;
  ADeleteTempFile: Boolean; AShowCompletionMsg: Boolean): string;
var
  LZip: TZipWrite;
  LZipFileName, LTempDir, LFileName, LFileName2: string;
begin
  Result := '';

//  LZipFileName := ReportNoEdit.Text;
  LZipFileName := GetZipFileName4Doc;

  if LZipFileName = '' then
  begin
//    ShowMessage('Please check the Report No.');
    exit;
  end;

  MakeCertDoc(CertTypeCB.ItemIndex, True, AFileKind, True);

//  LTempDir := ExtractFilePath(LZipFileName);// 'c:\temp\';
//  EnsureDirectoryExists(LTempDir);
//  LZipFileName := ChangeFileExt(LZipFileName, '.zip');
  LZip := TZipWrite.Create(LZipFileName);//LTempDir+
  try
    LFileName := GetTempATRFileName; //.pjh�� ��ȯ��

    if FileExists(LFileName) then
    begin
      LFileName2 := ExtractFileName(GetTempATRFileName(AFileKind)); //.doc �Ǵ� .pdf�� ��ȯ��
      LZip.AddDeflated(LFileName, True, 6, LFileName2);
    end;

    LFileName := GetTempCOCFileName;

    if FileExists(LFileName) then
    begin
      LFileName2 := ExtractFileName(GetTempCOCFileName(AFileKind)); //.doc �Ǵ� .pdf�� ��ȯ��
      LZip.AddDeflated(LFileName, True, 6, LFileName2);
    end;

    LFileName := GetTempVDRConfigFileName;

    if FileExists(LFileName) then
      LZip.AddDeflated(LFileName);

    if ClassSocietyEdit.Text = 'LR' then
    begin
      LFileName := GetLRCheckListFileName;

      if FileExists(LFileName) then
      begin
        LFileName2 := ChangeFileExt(ExtractFileName(LFIleName), '.doc');
        LZip.AddDeflated(LFileName, True, 6, LFileName2);
      end;
    end
    else
    if ClassSocietyEdit.Text = 'ABS' then
    begin
      LFileName := GetABSCheckListFileName;

      if FileExists(LFileName) then
      begin
        LFileName2 := ChangeFileExt(ExtractFileName(LFIleName), '.doc');
        LZip.AddDeflated(LFileName, True, 6, LFileName2);
      end;
    end;

  finally
    FreeAndNil(LZip);
  end;

  Result := LZipFileName;//LTempDir+

  if ADeleteTempFile then
  begin
    DeleteFile(GetTempATRFileName); //.pjh�� ��ȯ��
    DeleteFile(GetTempCOCFileName); //.pjh�� ��ȯ��
    DeleteFile(GetTempVDRConfigFileName);
  end;

  if AShowCompletionMsg then
    ShowMessage('Zip File is created successfully in ' + LZipFileName);//LTempDir+
end;

function TCertEditF.MakeZip4LicDoc(AFileKind: TJHPFileFormat; ADeleteTempFile,
  AShowCompletionMsg: Boolean): string;
var
  LZip: TZipWrite;
  LZipFileName, LTempDir, LFileName, LFileName2: string;
begin
  Result := '';

  LZipFileName := GetZipFileName4Doc;

  if LZipFileName = '' then
  begin
//    ShowMessage('Please check the Report No.');
    exit;
  end;

  MakeLicenseDoc(CertTypeCB.ItemIndex, True, AFileKind, True);

  LZip := TZipWrite.Create(LZipFileName);//LTempDir+
  try
//    LFileName := GetTempATRFileName; //.pjh�� ��ȯ��
//
//    if FileExists(LFileName) then
//    begin
//      LFileName2 := ExtractFileName(GetTempATRFileName(AFileKind)); //.doc �Ǵ� .pdf�� ��ȯ��
//      LZip.AddDeflated(LFileName, True, 6, LFileName2);
//    end;

    LFileName := GetTempPhotoFileName;

    if FileExists(LFileName) then
    begin
      LZip.AddDeflated(LFileName);
//      LFileName2 := ExtractFileName(GetTempCOCFileName(AFileKind));
//      LZip.AddDeflated(LFileName, True, 6, LFileName2);
    end;

    LFileName := GetTempQRFileName;

    if FileExists(LFileName) then
      LZip.AddDeflated(LFileName);

    LFileName := GetTempAttendantListFN;

    if FileExists(LFileName) then
      LZip.AddDeflated(LFileName);

  finally
    FreeAndNil(LZip);
  end;

  Result := LZipFileName;

  if ADeleteTempFile then
  begin
    DeleteFile(GetTempPhotoFileName);
    DeleteFile(GetTempQRFileName);
    DeleteFile(GetTempAttendantListFN);
  end;

  if AShowCompletionMsg then
    ShowMessage('Zip File is created successfully in ' + LZipFileName);//LTempDir+
end;

procedure TCertEditF.MenuItem1Click(Sender: TObject);
begin
  MakeCertDoc(CertTypeCB.ItemIndex, True, gfkPDF);
end;

procedure TCertEditF.MenuItem2Click(Sender: TObject);
begin
  MakeCertDoc(CertTypeCB.ItemIndex, True, gfkWORD);
end;

procedure TCertEditF.MenuItem3Click(Sender: TObject);
begin
  MakeZip4LicDoc(gfkEXCEL, True);
end;

procedure TCertEditF.QRCodeFrame1pbPreviewPaint(Sender: TObject);
begin
  QRCodeFrame1.pbPreviewPaint(Self);
end;

procedure TCertEditF.ReportNoEditButtonClick(Sender: TObject);
begin
  CreateVDRTestReportNo;
end;

procedure TCertEditF.RestoreColorExceptComponent(ATag: integer);
var
  i:integer;
begin
  for i := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i].Tag <> 0 then
      if Self.Components[i].Tag <> ATag then
        if IsPublishedProp(Self.Components[i], 'Color') then
          if Self.Components[i].ClassType = TJvDatePickerEdit then
          begin
            if TJvDatePickerEdit(Self.Components[i]).Color = clYellow then
              SetOrdProp(Self.Components[i], 'Color', clInfoBk);
          end
          else
            SetOrdProp(Self.Components[i], 'Color', clWindow);
  end;
end;

function TCertEditF.SaveEmail2DB: string;
begin
  FrameOLEmailList.SaveEmailFromGrid2DB;
  Result := FrameOLEmailList.GetSenderEmailListFromGrid([cdmPoFromCust]);
end;

procedure TCertEditF.SaveGSFile2DB;
var
  LDBName: string;
begin
  if CertFileDBNameEdit.Text = '' then
  begin
    ShowMessage('File DB Name is empty!');
    exit;
  end;

  LDBName := 'files\'+CertFileDBNameEdit.Text;

  if not FileExists(LDBName) then
    exit;

  InitJHPFileClient(LDBName);
  try
    if not Assigned(GSFileFrame.FJHPFiles_) then
      GSFileFrame.FJHPFiles_ := GetJHPFiles;

    if High(GSFileFrame.FJHPFiles_.Files) >= 0 then
    begin
      g_FileDB.Delete(TOrmJHPFile, GSFileFrame.FJHPFiles_.ID);
      g_FileDB.Add(GSFileFrame.FJHPFiles_, true);
    end
    else
      g_FileDB.Delete(TOrmJHPFile, GSFileFrame.FJHPFiles_.ID);
  finally
    DestroyJHPFile;
  end;
end;

procedure TCertEditF.ScreenActiveControlChange(Sender: TObject);
begin
  UnitFormUtil.ScreenActiveControlChange(Sender, FActiveControl, FPrevInactiveColor);
end;

procedure TCertEditF.SetVesselInfoFromIMONo(AIMONo: string);
var
  LSQLVesselMaster: TSQLVesselMaster;
  LSQLHGSVDRRecord: TSQLHGSVDRRecord;
  LDoc: Variant;
  LStr: string;
begin
  if not Assigned(g_VesselMasterDB) then
  begin
    LStr := GetSubFolderPath(ExtractFilePath(Application.ExeName), 'db');
    InitVesselMasterClient(LStr+'VesselList.sqlite');
  end;

  CertNoButtonEditButtonClick(nil);

  LSQLVesselMaster := GetVesselMasterFromIMONo(AIMONo);

  if LSQLVesselMaster.IsUpdate then
  begin
    HullNoEdit.Text := LSQLVesselMaster.HullNo;
    ShipNameEdit.Text := LSQLVesselMaster.ShipName;
    ImoNoEdit.Text := LSQLVesselMaster.ImoNo;
    OwnerNameEdit.Text := LSQLVesselMaster.OwnerName;
    ClassSocietyEdit.Text := LSQLVesselMaster.SClass1;
  end;

  InitHGSVDRClient(HGS_VDRLIST_DB_NAME);
  try
    LSQLHGSVDRRecord := GetHGSVDRFromIMONo(AIMONo);

    if LSQLHGSVDRRecord.IsUpdate then
    begin
      VDRSerialNoEdit.Text := LSQLHGSVDRRecord.VDRSerialNo;
      VDRConfigMemo.Text := LSQLHGSVDRRecord.VDRConfig;
      VDRTypeEdit.Text := LSQLHGSVDRRecord.VDRType;
    end;
  finally
    DestroyHGSVDR;
  end;

  ReportNoEditButtonClick(nil);
  SubCompanyEdit.Color := clYellow;
  PlaceOfSurveyEdit.Color := clYellow;
end;

procedure TCertEditF.ShipNameEditButtonClick(Sender: TObject);
begin
  ShowSearchVesselForm(Sender);
  DisplayEditPosition;
end;

procedure TCertEditF.ShowJsonFromQRCode;
var
  LJson: string;
begin
  LJson := GetJsonFromQRCode();
  LJson := JSONReformat(LJson, jsonHumanReadable); //jsonUnquotedPropName
  ShowMessage(LJson);
//  showmessage(inttostr(ljson.Length));
end;

procedure TCertEditF.ShowSearchVDRForm;
var
  LVDRSearchParamRec: TVDRSearchParamRec;
begin
  LVDRSearchParamRec := CreateSearchVDRFrom(VDRSerialNoEdit.Text, ImoNoEdit.Text,
    HullNoEdit.Text, ShipNameEdit.Text);

  if LVDRSearchParamRec.fVDRSerialNo <> '' then
  begin
    VDRSerialNoEdit.Text := LVDRSearchParamRec.fVDRSerialNo;
    VDRConfigMemo.Text := LVDRSearchParamRec.fVDRConfig;

    if ImoNoEdit.Text = '' then
      ImoNoEdit.Text := LVDRSearchParamRec.fIMONo;

    VDRTypeEdit.Text := LVDRSearchParamRec.fVDRType;
    DisplayEditPosition;
  end;
end;

procedure TCertEditF.ShowSearchVesselForm(Sender: TObject);
var
  LSearchVesselF: TSearchVesselF;
begin
  LSearchVesselF := TSearchVesselF.Create(nil);
  try
    if TNxButtonEdit(Sender).Name = 'IMONoEdit' then
      LSearchVesselF.ImoNoEdit.Text := Self.IMONoEdit.Text
    else
    if TNxButtonEdit(Sender).Name = 'ShipNameEdit' then
    begin
      if Self.IMONoEdit.Text <> '' then
        LSearchVesselF.ImoNoEdit.Text := Self.IMONoEdit.Text;

      LSearchVesselF.ShipNameEdit.Text := Self.ShipNameEdit.Text;
    end
    else
    if TNxButtonEdit(Sender).Name = 'HullNoEdit' then
    begin
      if Self.IMONoEdit.Text <> '' then
        LSearchVesselF.ImoNoEdit.Text := Self.IMONoEdit.Text;

      LSearchVesselF.HullNoEdit.Text := Self.HullNoEdit.Text;
    end;

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
        OwnerNameEdit.Text := LSearchVesselF.VesselListGrid.CellsByName['OwnerName',LSearchVesselF.VesselListGrid.SelectedRow];
        ClassSocietyEdit.Text := LSearchVesselF.VesselListGrid.CellsByName['SClass1',LSearchVesselF.VesselListGrid.SelectedRow];
      end;
    end;
  finally
    LSearchVesselF.Free;
  end;
end;

procedure TCertEditF.SubCompanyEditClickBtn(Sender: TObject);
var
  LSearchCustomerF: TSearchCustomerF;
begin
  LSearchCustomerF := TSearchCustomerF.Create(nil);
  try
    with LSearchCustomerF do
    begin
      FCompanyType := [ctAgent];
      CompanyNameEdit.Text := SubCompanyEdit.Text;

      if ShowModal = mrOk then
      begin
        if NextGrid1.SelectedRow <> -1 then
        begin
          Self.SubCompanyEdit.Text := NextGrid1.CellByName['CompanyName', NextGrid1.SelectedRow].AsString;
          Self.SubCompanyEdit2.Text := NextGrid1.CellByName['CompanyName2', NextGrid1.SelectedRow].AsString;
          Self.CompanyCodeEdit.Text := NextGrid1.CellByName['CompanyCode', NextGrid1.SelectedRow].AsString;
          Self.CompanyNationEdit.Text := NextGrid1.CellByName['Nation', NextGrid1.SelectedRow].AsString;
        end;
      end;
    end;
  finally
    LSearchCustomerF.Free;
    DisplayEditPosition;
  end;
end;

procedure TCertEditF.TrainedBeginDatePickerChange(Sender: TObject);
begin
  DisplayEditPosition;
end;

procedure TCertEditF.TrainedCourseEditButtonClick(Sender: TObject);
var
  LSubject, LCourseName, LContents: string;
begin
  if CreateCourseManageForm(LSubject, LCourseName, LContents) = mrOK then
  begin
    if LContents = '' then
      TrainedSubjectEdit.Text := LSubject
    else
      TrainedSubjectEdit.Text := LContents;

    TrainedCourseEdit.Text := LCourseName;
    DisplayEditPosition;
  end;
end;

procedure TCertEditF.TrainedEndDatePickerChange(Sender: TObject);
begin
  DisplayEditPosition;
end;

procedure TCertEditF.TrainedSubjectEditButtonClick(Sender: TObject);
var
  LSubject, LCourseName, LContents: string;
begin
  if CreateCourseManageForm(LSubject, LCourseName, LContents) = mrOK then
  begin
    if LContents = '' then
      TrainedSubjectEdit.Text := LSubject
    else
      TrainedSubjectEdit.Text := LContents;

    TrainedCourseEdit.Text := LCourseName;
    DisplayEditPosition;
  end;
end;

procedure TCertEditF.TraineeNameEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(VK_RETURN) then
    DisplayEditPosition;
end;

procedure TCertEditF.UntilValidityDatePickerChange(Sender: TObject);
begin
  DisplayEditPosition;
end;

procedure TCertEditF.VDRSerialNoEditButtonClick(Sender: TObject);
begin
  InitHGSVDRClient(HGS_VDRLIST_DB_NAME);
  try
    ShowSearchVDRForm;
  finally
    DestroyHGSVDR;
  end;
end;

end.