unit FrameHiReportInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ComCtrls, JvExControls, JvLabel, Vcl.ExtCtrls;

type
  THiRptInfoFr = class(TFrame)
    Panel5: TPanel;
    JvLabel31: TJvLabel;
    JvLabel49: TJvLabel;
    JvLabel30: TJvLabel;
    JvLabel10: TJvLabel;
    JvLabel1: TJvLabel;
    ReportSubject: TEdit;
    ReportAuthorID: TEdit;
    ReportAuthorName: TEdit;
    ReportMakeDate: TDateTimePicker;
    ReportKind: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
