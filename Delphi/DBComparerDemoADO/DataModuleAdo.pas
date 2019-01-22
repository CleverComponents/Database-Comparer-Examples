unit DataModuleAdo;

interface

uses
  SysUtils, Classes, ADODB, DB;

type
  TDataMdMS = class(TDataModule)
    ADOConnection1: TADOConnection;
    ADOConnection2: TADOConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataMdMS: TDataMdMS;

implementation

{$R *.dfm}

end.
