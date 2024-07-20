unit FrmEmailListView2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Forms, Vcl.Controls,
  mormot.core.base,
  FrameOLEmailList4Ole;

type
  TEmailListViewF = class(TForm)
    FrameOLMailList: TOutlookEmailListFr;
  public
    FOLFolderListFileName: string;
    FDBNameSuffix: string;
    constructor CreateWithOLFolderList(AFolderListFileName, AProdCode: string);
  end;

var
  EmailListViewF: TEmailListViewF;

implementation

uses UnitVesselData2, UnitOLEmailRecord2;//UnitHGSCertRecord2,UnitStrategy4VDRAPTCert2,

{$R *.dfm}

{ TEmailListViewF }

constructor TEmailListViewF.CreateWithOLFolderList(AFolderListFileName,
  AProdCode: string);
begin
  inherited Create(nil);

  FOLFolderListFileName := AFolderListFileName;
  FDBNameSuffix := AProdCode;
end;

end.
