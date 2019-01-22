program ExtractMetadata;

uses
  Forms,
//  dbcConnection_ZEOSDB,
  dbcConnection_IBXDB,
  dbcConnection_ADODB,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
