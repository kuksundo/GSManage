unit UnitHiconMariaDBUtil;

interface

uses System.SysUtils, Vcl.Forms, Vcl.Dialogs,
  mormot.db.sql.oledb, mormot.db.sql, mormot.core.base, mormot.db.sql.zeos,
  mormot.orm.core, mormot.db.core, mormot.orm.sql;

type
  THiconConfigOrm = class(TOrm)
  private
    FAcoAutoRun_NX_bat,
    FInfluxdb_conf
    : RawUtf8;
  published
    property AcoAutoRun_NX_bat: RawUtf8 read FAcoAutoRun_NX_bat write FAcoAutoRun_NX_bat;
    property Influxdb_conf: RawUtf8 read Finfluxdb_conf write Finfluxdb_conf;
  end;

  THiConMariaDB = class
  private
    FConnProp: TSQLDBConnectionProperties;
    FConnection: TSQLDBConnection;
    FModel: TOrmModel;
  public
    procedure CreateDB(AHostIp, APort, ADBName, AUserId, APassed: string);
    procedure ConnectDB();
    procedure DestroyDB();
    function ExecuteQuery(AQuery: string; ANoResult: Boolean=False): ISQLDBRows;
    function GetResultStatFromSQL(AQuery: string): Boolean;
    function GetList2JsonFromDB(AQuery: string; ADBName, ATableName: string): RawUtf8;
  end;

implementation

{ THiConMariaDB }

procedure THiConMariaDB.ConnectDB();
begin
  if not Assigned(FConnProp) then
    exit;

  FConnection := FConnProp.NewConnection;
  FConnection.Connect;
end;

procedure THiConMariaDB.CreateDB(AHostIp, APort, ADBName, AUserId,
  APassed: string);
begin
  FConnProp := TSQLDBZEOSConnectionProperties.Create(
    TSQLDBZEOSConnectionProperties.URI(dMariaDB, AHostIp + ':' + APort, '.\lib\libmariadb.dll'), ADBName, AUserId, APassed);

  FModel := TOrmModel.Create([THiconConfigOrm]);
  VirtualTableExternalRegisterAll(FModel, FConnProp);
end;

procedure THiConMariaDB.DestroyDB;
begin
  if Assigned(FConnection) then
    FConnection.Free;

  if Assigned(FConnProp) then
    FConnProp.Free;

  if Assigned(FModel) then
    FModel.Free;

end;

function THiConMariaDB.ExecuteQuery(AQuery: string; ANoResult: Boolean): ISQLDBRows;
var
  LStatement: ISQLDBStatement;
//  IRows: ISQLDBRows;
begin
//  LStatement := FConnection.NewStatement;
//  LStatement.
  if not FConnection.Connected then
    exit;

  if ANoResult then
  begin
    Result := nil;
    FConnProp.ExecuteNoResult(AQuery, [])
  end
  else
    Result := FConnProp.Execute(AQuery, []);
end;

function THiConMariaDB.GetList2JsonFromDB(AQuery,
  ADBName, ATableName: string): RawUtf8;
begin

end;

function THiConMariaDB.GetResultStatFromSQL(AQuery: string): Boolean;
begin
  AQuery := UpperCase(AQuery);
  Result := (Pos('CREATE', AQuery) > 0) or (Pos('REPLACE', AQuery) > 0) or
    (Pos('ALTER', AQuery) > 0) or (Pos('INSERT', AQuery) > 0) or (Pos('UPDATE', AQuery) > 0) or
    (Pos('INTO OUTFILE', AQuery) > 0)
    ;
end;

end.
