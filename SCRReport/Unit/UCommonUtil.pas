unit UCommonUtil;

interface

uses Forms;

procedure SaveSCRForm2DFM(AForm: TForm);

implementation

uses UnitDialogUtil,UnitDFMUtil;

procedure SaveSCRForm2DFM(AForm: TForm);
var
  LFileName: string;
begin
  LFileName := GetFileNameFromSaveDialog();
  SaveToDFM2(LFileName, AForm);
end;

end.
