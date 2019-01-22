program DBComparerDemoAdo;

uses
  Forms,
  Unit1Ado in 'Unit1Ado.pas' {Form1},
  DataModuleAdo in 'DataModuleAdo.pas' {DataMdMS: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataMdMS, DataMdMS);
  Application.Run;
end.
