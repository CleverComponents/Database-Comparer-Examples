unit IBDataModuleFib;

interface

uses
  SysUtils, Classes, FIBDatabase, pFIBDatabase;

type
  TDataMdFib = class(TDataModule)
    IBDatabase1: TpFIBDatabase;
    IBDatabase2: TpFIBDatabase;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataMdFib: TDataMdFib;

implementation

{$R *.dfm}

end.
