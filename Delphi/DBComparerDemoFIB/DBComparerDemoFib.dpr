program DBComparerDemoFib;

uses
  Forms,
  Unit1Fib in 'Unit1Fib.pas' {Form1},
  IBDataModuleFib in 'IBDataModuleFib.pas' {DataMdFib: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataMdFib, DataMdFib);
  Application.Run;
end.
