unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls,
  NxScrollControl, NxCustomGridControl,
  NxCustomGrid, NxGrid, Vcl.ExtCtrls,

  mormot.db.sql.oledb, mormot.db.sql, mormot.core.base, mormot.core.variants;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    NextGrid1: TNextGrid;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses UnitNextGridUtil2;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  LProps: TOleDBConnectionProperties;
  LConn: TSQLDBConnection;
  LQuery: TSQLDBStatement;
  LUtf8: RawUtf8;
  LVar: variant;
begin
  LProps := TSqlDBOleDBACEConnectionProperties.Create('e:\temp\system_bak.accdb','', '','');
  try
    LConn := LProps.NewConnection;
    try
      LConn.Connect;

      LQuery := LConn.NewStatement;
      try
        LQuery.Execute('select * from INFO', True);
        LUtf8 := LQuery.FetchAllAsJson(True);
        LVar := _JSON(LUtf8);
        AddNextGridRowsFromVariant2(NextGrid1, LVar, True);
      finally
        LQuery.Free;
      end;
    finally
      LConn.Free;
    end;
  finally
    LProps.Free;
  end;
end;

end.
