unit IBDataModule;

interface

uses
  SysUtils, Classes, dbcDBEngine, dbcConnection_UniDAC, DB, DBAccess, Uni,
  UniProvider, InterBaseUniProvider;

type
  TDataMd = class(TDataModule)
    DBCConnection1: TDBCConnectionUniDAC;
    DBCConnection2: TDBCConnectionUniDAC;
    UniConnection1: TUniConnection;
    UniConnection2: TUniConnection;
    InterBaseUniProvider1: TInterBaseUniProvider;
  private
    { Private declarations }
  public
    { Public declarations }
  published
    procedure DBCConnection1BeforeConnect(Sender: TObject);
    procedure DBCConnection2BeforeConnect(Sender: TObject);
  end;

var
  DataMd: TDataMd;

implementation

{$R *.dfm}

Uses Unit1;


procedure TDataMd.DBCConnection1BeforeConnect(Sender: TObject);
begin
  UniConnection1.ProviderName := 'InterBase';
  UniConnection1.Username := Form1.EditMUser.Text;
  UniConnection1.Password := Form1.EditMPswd.Text;
  UniConnection1.Database := Form1.fnDatabaseMaster.Text;
end;

procedure TDataMd.DBCConnection2BeforeConnect(Sender: TObject);
begin
  UniConnection2.ProviderName := 'InterBase';
  UniConnection2.Username := Form1.EditTUser.Text;
  UniConnection2.Password := Form1.EditTPswd.Text;
  UniConnection2.Database := Form1.fnDatabaseTarget.Text;
end;

end.
