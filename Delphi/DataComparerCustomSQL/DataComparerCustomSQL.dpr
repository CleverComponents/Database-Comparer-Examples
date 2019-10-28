program DataComparerCustomSQL;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  DataModule1 in 'DataModule1.pas' {DataMd: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataMd, DataMd);
  Application.Run;
  Form1.Free;
  DataMd.Free;
end.
