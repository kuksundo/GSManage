unit UnitHiASUtil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Forms, Vcl.Dialogs, Vcl.StdCtrls;

procedure ExecMacro_QryClaimMonitoringByHullNo(AEdit: TCustomEdit);

implementation

uses UnitMacroListClass2, UnitAdvCompUtil, UnitKeyBdUtil;

procedure ExecMacro_QryClaimMonitoringByHullNo(AEdit: TCustomEdit);
var
  LRoot: TMacroManagements;
  LMacroM: TMacroManagement;
  LPath, LMacroName: string;
  LIdx: integer;
begin
  SetCurrentDir(ExtractFilePath(Application.ExeName));
  LPath := '.\mcr\';
  LRoot := TMacroManagements.Create;
  try
    LMacroName := '유상Claim모니터링-조회-MouseMove2HullNo.mcr';

    LIdx := LRoot.AddMacro2RootFromJsonFile(LPath + LMacroName);
    LMacroM := LRoot.FMacroManageList.Items[LIdx];
    LMacroM.ExecuteActItemList();
    //HullNo 복사 2 Clipboard
    ClipboardCopyOrPaste2AdvEditBtn(AEdit, True);
//    SendCtlNChar('V');
    LMacroM.AddWaitMacro2ActItemList(500);

    LIdx := LRoot.AddMacro2RootFromJsonFile(LPath + '유상Claim모니터링-조회-조회버튼클릭.mcr');
    LMacroM := LRoot.FMacroManageList.Items[LIdx];
    LMacroM.ExecuteActItemList();
    LMacroM.AddWaitMacro2ActItemList(1000);

  finally
    ShowMessage('Claim 조회 완료!');
    LRoot.Free;
  end;
end;

end.
