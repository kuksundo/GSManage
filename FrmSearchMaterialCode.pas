unit FrmSearchMaterialCode;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, NxColumnClasses, NxColumns,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid, Vcl.StdCtrls,
  JvExControls, JvLabel, Vcl.Buttons, Vcl.ExtCtrls,
  mormot.core.datetime, mormot.core.variants, mormot.orm.base, mormot.core.base,
  UnitHiASMaterialCodeRecord;

type
  TSearchMatCodeF = class(TForm)
    Panel1: TPanel;
    SearchButton: TButton;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    JvLabel5: TJvLabel;
    MatCodeEdit: TEdit;
    JvLabel6: TJvLabel;
    MatNameEdit: TEdit;
    MatCodeGrid: TNextGrid;
    NxIncrementColumn1: TNxIncrementColumn;
    TaskID: TNxTextColumn;
    PORNo: TNxTextColumn;
    MaterialCode: TNxTextColumn;
    MaterialName: TNxTextColumn;
    UnitPrice: TNxTextColumn;
    NeedCount: TNxTextColumn;
    LeadTime: TNxTextColumn;
    CreateDate: TNxDateColumn;
    NeedDate: TNxDateColumn;
    ClaimCauseHWCombo: TComboBox;
    JvLabel1: TJvLabel;
    procedure MatCodeGridCellDblClick(Sender: TObject; ACol, ARow: Integer);
    procedure SearchButtonClick(Sender: TObject);
    procedure MatCodeEditKeyPress(Sender: TObject; var Key: Char);
    procedure MatNameEditKeyPress(Sender: TObject; var Key: Char);
    procedure ImoNoEditKeyPress(Sender: TObject; var Key: Char);
    procedure ClaimCauseHWComboDropDown(Sender: TObject);
  private
    procedure ExecuteSearch(Key: Char);
  public
    procedure GetMaterialCode2Grid;
  end;

  function DisplayMaterialCode2EditForm(var AMatCode, AMatName: string): integer;

var
  SearchMatCodeF: TSearchMatCodeF;

implementation

uses CommonData2, UnitFolderUtil2, UnitNextGridUtil2, UnitElecServiceData2,
  UnitHiconisASData;

{$R *.dfm}

{ TSearchVesselF }

function DisplayMaterialCode2EditForm(var AMatCode, AMatName: string): integer;
var
  LSearchMatCodeF: TSearchMatCodeF;
begin
  LSearchMatCodeF := TSearchMatCodeF.Create(nil);
  try
    with LSearchMatCodeF do
    begin
      MatCodeEdit.Text := AMatCode;
      MatNameEdit.Text := AMatName;

      Result := ShowModal;

      if Result = mrOK then
      begin
        AMatCode := MatCodeGrid.CellsByName['MaterialCode', MatCodeGrid.SelectedRow];
        AMatName := MatCodeGrid.CellsByName['MaterialName', MatCodeGrid.SelectedRow];
      end;
    end;
  finally
    LSearchMatCodeF.Free;
  end;
end;

procedure TSearchMatCodeF.ClaimCauseHWComboDropDown(Sender: TObject);
begin
  g_ClaimCauseHW.SetType2Combo(ClaimCauseHWCombo);
end;

procedure TSearchMatCodeF.ExecuteSearch(Key: Char);
begin
  if Key = Chr(VK_RETURN) then
    SearchButtonClick(nil);
end;

procedure TSearchMatCodeF.GetMaterialCode2Grid;
var
  LOrmMaterialCode: TOrmMaterialCode;
  LVar: Variant;
  LUtf8: RawUtf8;
  LClaimCauseHW: integer; //TClaimCauseHW;
begin
  TDocVariant.New(LVar);
  MatCodeGrid.BeginUpdate;
  try
    MatCodeGrid.ClearRows;
    LClaimCauseHW := ClaimCauseHWCombo.ItemIndex;

    if LClaimCauseHW = -1 then
      LOrmMaterialCode := GetMaterialCodeByCode(MatCodeEdit.Text, MatNameEdit.Text)
    else
      LOrmMaterialCode := GetMaterialCodeByCauseHW(LClaimCauseHW);
    try
      if LOrmMaterialCode.IsUpdate then
      begin
        LOrmMaterialCode.FillRewind;

        while LOrmMaterialCode.FillOne do
        begin
          LUtf8 := LOrmMaterialCode.GetJsonValues(true, true, soSelect);
          LVar := _JSON(LUtf8);
          AddNextGridRowFromVariant(MatCodeGrid, LVar, True);
        end;//while
      end;
    finally
      LOrmMaterialCode.Free;
    end;
  finally
    MatCodeGrid.EndUpdate;
  end;
end;

procedure TSearchMatCodeF.MatCodeEditKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteSearch(Key);
end;

procedure TSearchMatCodeF.ImoNoEditKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteSearch(Key);
end;

procedure TSearchMatCodeF.SearchButtonClick(Sender: TObject);
begin
  GetMaterialCode2Grid;
end;

procedure TSearchMatCodeF.MatNameEditKeyPress(Sender: TObject; var Key: Char);
begin
  ExecuteSearch(Key);
end;

procedure TSearchMatCodeF.MatCodeGridCellDblClick(Sender: TObject; ACol,
  ARow: Integer);
begin
  ModalResult := mrOK;
end;

end.
