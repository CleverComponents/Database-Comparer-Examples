unit IBDataModuleIbx;

interface

uses
  SysUtils, Classes, IBDatabase, dbcDBEngine, dbcConnection_IBX, DB;

type
  TDataMdIbx = class(TDataModule)
    IBDatabase1: TIBDatabase;
    IBDatabase2: TIBDatabase;
    DBCConnection1: TDBCConnectionIBX;
    DBCConnection2: TDBCConnectionIBX;
  private
    { Private declarations }
  public
    { Public declarations }
  published
    procedure DBCConnection1BeforeConnect(Sender: TObject);
    procedure DBCConnection2BeforeConnect(Sender: TObject);
  end;

var
  DataMdIbx: TDataMdIbx;

implementation

{$R *.dfm}

Uses Unit1Ibx;


procedure TDataMdIbx.DBCConnection1BeforeConnect(Sender: TObject);
begin
  with Form1 do begin
    IBDatabase1.DatabaseName := fnDatabaseMaster.Text;
    IBDatabase1.Params.Clear;
    IBDatabase1.Params.Add('user_name='+EditMUser.Text);
    IBDatabase1.Params.Add('password='+EditMPswd.Text);
  end;
end;

procedure TDataMdIbx.DBCConnection2BeforeConnect(Sender: TObject);
begin
  with Form1 do begin
    IBDatabase2.DatabaseName := fnDatabaseTarget.Text;
    IBDatabase2.Params.Clear;
    IBDatabase2.Params.Add('user_name='+EditTUser.Text);
    IBDatabase2.Params.Add('password='+EditTPswd.Text);
    IBDatabase2.LoginPrompt := (EditTUser.Text = '') or (EditTPswd.Text = '');
  end;
end;

end.
