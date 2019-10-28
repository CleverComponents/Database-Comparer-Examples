unit DataModule1;

interface

uses
  SysUtils, Classes, dbcDBEngine, dbcConnection_FireDAC, DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Comp.Client, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  FireDAC.DApt, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TDataMd = class(TDataModule)
    FDConnection1: TFDConnection;
    FDConnection2: TFDConnection;
    DBCConnection1: TDBCConnectionFireDAC;
    DBCConnection2: TDBCConnectionFireDAC;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
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
  FDConnection1.Params.Clear();
  FDConnection1.DriverName := 'FB';
  FDConnection1.Params.Add('Database=' + Form1.fnDatabaseMaster.Text);
  FDConnection1.Params.Add('User_Name=' + Form1.EditMUser.Text);
  FDConnection1.Params.Add('Password=' + Form1.EditMPswd.Text);
end;

procedure TDataMd.DBCConnection2BeforeConnect(Sender: TObject);
begin
  FDConnection2.Params.Clear();
  FDConnection2.DriverName := 'FB';
  FDConnection2.Params.Add('Database=' + Form1.fnDatabaseTarget.Text);
  FDConnection2.Params.Add('User_Name=' + Form1.EditTUser.Text);
  FDConnection2.Params.Add('Password=' + Form1.EditTPswd.Text);
end;

end.
