program DBComparerDemoIbx;

uses
  Forms,
  Unit1Ibx in 'Unit1Ibx.pas' {Form1},
  IBDataModuleIbx in 'IBDataModuleIbx.pas' {DataMdIbx: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataMdIbx, DataMdIbx);
  Application.Run;
  Form1.Free;
  DataMdIbx.Free;
end.
