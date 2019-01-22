unit LocalSqlForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dbcClasses, dbcSQL_Exec, dbcLocalSQLExec, dbcDBEngine,
  dbcConnection_BDE, DB, DBTables, StdCtrls, Buttons, ComCtrls;

type
  TForm1 = class(TForm)
    Database: TDatabase;
    DBCConnectionBDE: TDBCConnectionBDE;
    LocalSQLExec: TLocalSQLExec;
    EditFileName: TEdit;
    BitBtn1: TBitBtn;
    OpenDialog: TOpenDialog;
    MemoScript: TRichEdit;
    BitBtn2: TBitBtn;
    MemoLog: TRichEdit;
    ProgressBar: TProgressBar;
    procedure BitBtn1Click(Sender: TObject);
    procedure ShowErrorMessage(Sender: TObject;
      ErrText: String);
    procedure LocalSQLExecLogNextLine(Sender: TObject; LogText: String);
    procedure BitBtn2Click(Sender: TObject);
    procedure LocalSQLExecProgressUpdate(Sender: TObject; Value,
      MaxValue: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddToLog(aText: String);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  if OpenDialog.Execute then begin
    EditFileName.Text := OpenDialog.FileName;
    if FileExists(OpenDialog.FileName) then begin
      LocalSQLExec.LoadFromFile(OpenDialog.FileName);
      MemoScript.Lines.LoadFromFile(OpenDialog.FileName);
      MemoLog.Lines.Clear;
      AddToLog('Script loaded: '+ IntToStr(LocalSQLExec.StatementsCount)+' statements.');
    end
    else AddToLog('File not found: '+OpenDialog.FileName);
  end;
end;

procedure TForm1.AddToLog(aText: String);
begin
  MemoLog.Lines.Add(aText);
  MemoLog.Perform(EM_SCROLLCARET, 0, 0);
end;


procedure TForm1.ShowErrorMessage(Sender: TObject;
  ErrText: String);
begin
  AddToLog('Error: '+ ErrText);
end;

procedure TForm1.LocalSQLExecLogNextLine(Sender: TObject; LogText: String);
begin
  AddToLog(LogText);
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  DBCConnectionBDE.Connected := True;
  LocalSQLExec.ExecuteScript();
  DBCConnectionBDE.Connected := False;
end;

procedure TForm1.LocalSQLExecProgressUpdate(Sender: TObject; Value,
  MaxValue: Integer);
begin
  ProgressBar.Max := MaxValue;
  ProgressBar.Position := Value;
end;

end.
