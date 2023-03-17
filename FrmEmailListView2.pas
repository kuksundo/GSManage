unit FrmEmailListView2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Forms, Vcl.Controls,
  mormot.core.base,
  FrameOLEmailList2;

type
  TEmailListViewF = class(TForm)
    FrameOLMailList: TFrame2;
  private
    FOLFolderListFileName: string;
    FDBNameSuffix: string;
  public
    constructor CreateWithOLFolderList(AFolderListFileName, AProdCode: string);
  end;

function ShowEMailListFromCertNo(ACertNo, AHullNo, AProdType, AOLFolderListFileName: string): integer;

var
  EmailListViewF: TEmailListViewF;

implementation

uses UnitVesselData2, UnitHGSCertRecord2, UnitStrategy4VDRAPTCert2, UnitOLEmailRecord2;

{$R *.dfm}

{ TEmailListViewF }

constructor TEmailListViewF.CreateWithOLFolderList(AFolderListFileName,
  AProdCode: string);
begin
  inherited Create(nil);

  FOLFolderListFileName := AFolderListFileName;
  FDBNameSuffix := AProdCode;
end;

function ShowEMailListFromCertNo(ACertNo, AHullNo, AProdType, AOLFolderListFileName: string): integer;
var
  LEmailListViewF: TEmailListViewF;
  LUtf8: RawUTF8;
  LProdCode, LEMailDBName: string;
  LMailCount: integer;
begin
  Result := -1;
  LProdCode := GetProdCodeFromProdType(AProdType);

  LEmailListViewF := TEmailListViewF.CreateWithOLFolderList(
    AOLFolderListFileName, LProdCode);
  try
    with LEmailListViewF.FrameOLMailList do
    begin
      FDBKey := ACertNo;
      FHullNo := AHullNo;
      FOLFolderListFileName := LEmailListViewF.FOLFolderListFileName;
      FDBNameSuffix := LEmailListViewF.FDBNameSuffix;
//      SetWSInfoRec(FSettings.WSServerIPAddr, FSettings.WSServerPort,
//        FSettings.WSServerTransmissionKey);
//      SetMQInfoRec(FSettings.MQServerIP, FSettings.MQServerPort,
//        FSettings.MQServerUserId, FSettings.MQServerPasswd,
//        FSettings.MQServerTopic, FSettings.MQServerEnable);

      FContext4OLEmail.SetStrategy(TOLEmail4VDRAPTCert.Create(ACertNo));
      LEMailDBName := GetEMailDBName(Application.ExeName, LProdCode);
      InitOLEmailMsgClient(LEMailDBName);
      MailCount := ShowEmailListFromDBKey(grid_Mail, FDBKey);
      LMailCount := MailCount;

      LEmailListViewF.ShowModal;

      if LMailCount <> MailCount then
      begin
        UpdateMailCountFromCertNo(ACertNo, MailCount);
        Result := MailCount;
      end;
    end;
  finally
    LEmailListViewF.Free;
  end;
end;

end.
