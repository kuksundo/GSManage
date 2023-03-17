unit UnitStrategy4OLEmailInterface2;

interface

uses mORMot.orm.core, mORMot.core.rtti;

type

  TContext4OLEmail = class;

  TOLEmailActionRecord = record
    FEmailAction: integer;
    FMailKind: integer;
    FFileKind: integer;
    FTemplateFileName,
    FMySignature: string;
  end;

  IStrategy4OLEmail = interface
  ['{B69268F4-F364-435E-B9D5-85FEB5A2C5A4}']
    function MakeEmailHTMLBody(AContext: TContext4OLEmail): string;
    function MakeAttachFile(AContext: TContext4OLEmail): string;
  end;

  TContext4OLEmail = class
  private
    FStrategy4OLEmail: IStrategy4OLEmail;
  public
    FSQLRecord: TSQLRecord;
    FOLEmailActionRec: TOLEmailActionRecord;

    constructor Create;
    function Algorithm4EmailAction(AOLEmailAction: TOLEmailActionRecord): string;
    procedure SetStrategy(AStrategy: IStrategy4OLEmail);
  end;

implementation

{ TContext4OLEmail }

function TContext4OLEmail.Algorithm4EmailAction(AOLEmailAction: TOLEmailActionRecord): string;
begin
  RecordCopy(FOLEmailActionRec, AOLEmailAction, TypeInfo(TOLEmailActionRecord));

  case FOLEmailActionRec.FEmailAction of
    1: Result := FStrategy4OLEmail.MakeEmailHTMLBody(Self);
    2: Result := FStrategy4OLEmail.MakeAttachFile(Self);
  end;
end;

constructor TContext4OLEmail.Create;
begin
  inherited;
end;

procedure TContext4OLEmail.SetStrategy(AStrategy: IStrategy4OLEmail);
begin
  FStrategy4OLEmail := AStrategy;
end;

end.
