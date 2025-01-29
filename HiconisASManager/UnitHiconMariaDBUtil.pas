unit UnitHiconMariaDBUtil;

interface

uses System.SysUtils, Vcl.Forms, Vcl.Dialogs, System.Variants,
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
    FIsConnected: Boolean;

    //AEncryptedPasswd:
    //Encrypt : MakeEncrypNBase64String
    //DeCrypt : MakeUnBase64NDecryptString
    procedure CreateDB(AHostIp, APort, ADBName, AUserId, AEncryptedPasswd: string);
    procedure ConnectDB();
    procedure DestroyDB();
    procedure CreateModel();
    procedure DestroyModel();
    function ExecuteQuery(AQuery: string; ANoResult: Boolean=False): ISQLDBRows;
    function GetResultStatFromSQL(AQuery: string): Boolean;
    function GetList2JsonFromDB(AQuery: string; ADBName, ATableName: string): RawUtf8;

    function CheckDataBaseExistByName(const ADBName: string): Boolean;
  end;

implementation

uses UnitCryptUtil3;

{ THiConMariaDB }

function THiConMariaDB.CheckDataBaseExistByName(const ADBName: string): Boolean;
var
  LQry: string;
  LSQLDBRows: ISQLDBRows;
  LRowData: Variant;
begin
//  LQry := 'SHOW DATABASES LIKE "' + ADBName + '"';
  LQry := 'select schema_name from information_schema.schemata where schema_name="' + ADBName + '"';
  LSQLDBRows := ExecuteQuery(LQry);
  LRowData := LSQLDBRows.RowData;

  while LSQLDBRows.Step do
  begin
    LQry := LRowData.schema_name;
  end;

  Result := LQry = ADBName;
//  Result := not VarIsNull(LRowData);
//  Result := LRowData <> UnAssigned;
end;

procedure THiConMariaDB.ConnectDB();
begin
  if not Assigned(FConnProp) then
    exit;

  FConnection := FConnProp.NewConnection;
  FConnection.Connect;

  FIsConnected := True;
end;

procedure THiConMariaDB.CreateDB(AHostIp, APort, ADBName, AUserId,
  AEncryptedPasswd: string);
var
  LPasswd: string;
begin
  FIsConnected := False;

  LPasswd := MakeUnBase64NDecryptString(AEncryptedPasswd);

  FConnProp := TSQLDBZEOSConnectionProperties.Create(
    TSQLDBZEOSConnectionProperties.URI(dMariaDB, AHostIp + ':' + APort, '.\lib\libmariadb.dll'), ADBName, AUserId, LPasswd);

  ConnectDB();
end;

procedure THiConMariaDB.CreateModel;
begin
  FModel := TOrmModel.Create([THiconConfigOrm]);
  VirtualTableExternalRegisterAll(FModel, FConnProp);
end;

procedure THiConMariaDB.DestroyDB;
begin
  if Assigned(FConnection) then
    FConnection.Free;

  if Assigned(FConnProp) then
    FConnProp.Free;
end;

procedure THiConMariaDB.DestroyModel;
begin
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
    ConnectDB();

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
