program TableDataComparer;

uses
  Forms,
  dbcConnection_ADODB,
  dbcConnection_IBXDB,
  TableDataComparerForm in 'TableDataComparerForm.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
