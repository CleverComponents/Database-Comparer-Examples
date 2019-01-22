unit Unit1Fib;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls,
  ExtCtrls, dbcDBComparer, dbcDBStructure,
  dbcIBDatabaseExtract, dbcClasses, dbcIBScriptExtract,
  dbcSQL_Exec, dbcIBSQLExec, ComCtrls,
  dbcCustomScriptExtract, dbcDBEngine, dbcConnection_FIB;

type
  TForm1 = class(TForm)
    IBDBExtract1: TIBDBExtract;
    DBStructure1: TDBStructure;
    DBStructure2: TDBStructure;
    IBDBExtract2: TIBDBExtract;
    OpenDialog1: TOpenDialog;
    GroupBox1: TGroupBox;
    fnDatabaseMaster: TEdit;
    fnDatabaseTarget: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    BtnSelDatabaseMaster: TSpeedButton;
    BtnSelDatabaseTarget: TSpeedButton;
    EditMUser: TEdit;
    EditMPswd: TEdit;
    LabelMUser: TLabel;
    LabelMPswd: TLabel;
    LabelTUser: TLabel;
    EditTUser: TEdit;
    LabelTPswd: TLabel;
    EditTPswd: TEdit;
    BtnExtract: TBitBtn;
    BtnCompare: TBitBtn;
    GroupBox2: TGroupBox;
    MemoExtr: TRichEdit;
    DBComparer1: TDBComparer;
    Splitter1: TSplitter;
    GroupBox3: TGroupBox;
    MemoResult: TMemo;
    fnScriptMaster: TEdit;
    BtnSelScriptMaster: TSpeedButton;
    fnScriptTarget: TEdit;
    BtnSelScriptTarget: TSpeedButton;
    IBScriptExtract1: TIBScriptExtract;
    IBScriptExtract2: TIBScriptExtract;
    Panel1: TPanel;
    rbMasterFromDatabase: TRadioButton;
    rbMasterFromScript: TRadioButton;
    Panel2: TPanel;
    rbTargetFromDatabase: TRadioButton;
    rbTargetFromScript: TRadioButton;
    IBSQLExec1: TIBSQLExec;
    BtnUpdate: TBitBtn;
    Gauge1: TProgressBar;
    DBCConnectionFIB1: TDBCConnectionFIB;
    DBCConnectionFIB2: TDBCConnectionFIB;
    procedure FormCreate(Sender: TObject);
    procedure BtnSelFileClick(Sender: TObject);
    procedure BtnExtractClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LogNextLine(Sender: TObject; LogLine: String);
    procedure BtnCompareClick(Sender: TObject);
    procedure rbFromClick(Sender: TObject);
    procedure ProgressUpdate(Sender: TObject; Value, MaxValue: Integer);
    procedure BtnUpdateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ExtractMasterDatabase();
    procedure ExtractTargetDatabase();
    procedure ExtractMasterScript();
    procedure ExtractTargetScript();
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

Uses IBDataModuleFib, IniFiles, dbcCompObj;

function IniFileName(): String;
begin
  Result := ExtractFilePath(ParamStr(0))+'CompDemo.Ini';
end;

procedure AddToExtrlog(s: String);
begin
  Form1.MemoExtr.Lines.Add(s);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  MFromD, TFromD: Boolean;
begin
  fnDatabaseMaster.Text := '';
  fnDatabaseTarget.Text := '';
  fnScriptMaster.Text := '';
  fnScriptTarget.Text := '';
  MemoExtr.Clear;
  MemoResult.Clear;
  with TIniFile.Create(IniFileName()) do begin
    fnDatabaseMaster.Text := ReadString('Databases','MasterDB','');
    fnDatabaseTarget.Text := ReadString('Databases','TargetDB','');
    fnScriptMaster.Text := ReadString('Databases','MasterScript','');
    fnScriptTarget.Text := ReadString('Databases','TargetScript','');
    MFromD := ReadBool('Databases','MasterFromDatabase',True);
    TFromD := ReadBool('Databases','TargetFromDatabase',True);
    if MFromD then rbMasterFromDatabase.Checked := True
    else rbMasterFromScript.Checked := True;
    if TFromD then rbTargetFromDatabase.Checked := True
    else rbTargetFromScript.Checked := True;
    Free;
  end;
  rbFromClick(nil);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  with TIniFile.Create(IniFileName()) do begin
    WriteString('Databases', 'MasterDB', fnDatabaseMaster.Text);
    WriteString('Databases', 'TargetDB', fnDatabaseTarget.Text);
    WriteString('Databases', 'MasterScript', fnScriptMaster.Text);
    WriteString('Databases', 'TargetScript', fnScriptTarget.Text);
    WriteBool('Databases','MasterFromDatabase',rbMasterFromDatabase.Checked);
    WriteBool('Databases','TargetFromDatabase',rbTargetFromDatabase.Checked);
    Free;
  end;
end;

procedure TForm1.BtnSelFileClick(Sender: TObject);
begin
  if (Sender = BtnSelDataBaseMaster) or (Sender = BtnSelDatabaseTarget) then begin
    OpenDialog1.Filter := 'InterBase Databases (*.GDB)|*.gdb|All Files (*.*)|*.*';
  end;
  if (Sender = BtnSelScriptMaster) or (Sender = BtnSelScriptTarget) then begin
    OpenDialog1.Filter := 'SQL Script (*.SQL)|*.sql|SQL Script (*.DDL)|*.ddl|All Files (*.*)|*.*';
  end;
  if OpenDialog1.Execute then begin
    if Sender = BtnSelDatabaseMaster then
      fnDatabaseMaster.Text := OpenDialog1.FileName;
    if Sender = BtnSelDatabaseTarget then
      fnDatabaseTarget.Text := OpenDialog1.FileName;
    if Sender = BtnSelScriptMaster then
      fnScriptMaster.Text := OpenDialog1.FileName;
    if Sender = BtnSelScriptTarget then
      fnScriptTarget.Text := OpenDialog1.FileName;
  end;
end;

procedure TForm1.ExtractMasterDatabase();
var
  ErrFlg: Boolean;
begin
  with DataMdFib do begin

    IBDatabase1.DatabaseName := fnDatabaseMaster.Text;
    IBDatabase1.ConnectParams.Username := EditMUser.Text;
    IBDatabase1.ConnectParams.Password := EditMPswd.Text;

    ErrFlg := False;
    try
      IBDatabase1.Connected := True;
    except on E: Exception do begin
      ShowMessage(E.Message);
      MemoExtr.Lines.Add('Error: '+E.Message);
      ErrFlg := True;
      IBDatabase1.Connected := False;
    end end;
    if ErrFlg then exit;
    MemoExtr.Lines.Add('Database: '+IBDatabase1.DatabaseName+' open.');
    DBStructure1.Clear;
    IBDBExtract1.ExtractDatabase;
    IBDatabase1.Connected := False;
  end;
end;

procedure TForm1.ExtractTargetDatabase;
var
  ErrFlg: Boolean;
begin
  with DataMdFib do begin

    IBDatabase2.DatabaseName := fnDatabaseTarget.Text;
    IBDatabase2.ConnectParams.Username := EditTUser.Text;
    IBDatabase2.ConnectParams.Password := EditTPswd.Text;
    ErrFlg := False;
    try
      IBDatabase2.Connected := True;
    except on E: Exception do begin
      ShowMessage(E.Message);
      MemoExtr.Lines.Add('Error: '+E.Message);
      ErrFlg := True;
      IBDatabase2.Connected := False;
    end end;
    if ErrFlg then exit;
    MemoExtr.Lines.Add('Database: '+IBDatabase2.DatabaseName+' open.');
    DBStructure2.Clear;
    IBDBExtract2.ExtractDatabase;
    IBDatabase2.Connected := False;
  end;
end;

procedure TForm1.ExtractMasterScript();
begin
  IBScriptExtract1.ScriptFileName := fnScriptMaster.Text;
  IBScriptExtract1.ExtractDatabase;
end;

procedure TForm1.ExtractTargetScript();
begin
  IBScriptExtract2.ScriptFileName := fnScriptTarget.Text;
  IBScriptExtract2.ExtractDatabase;
end;

procedure TForm1.BtnExtractClick(Sender: TObject);
begin
  BtnExtract.Enabled := False;
  if rbTargetFromDatabase.Checked then ExtractTargetDatabase();
  if rbTargetFromScript.Checked then ExtractTargetScript();
  if rbMasterFromDatabase.Checked then ExtractMasterDatabase();
  if rbMasterFromScript.Checked then ExtractMasterScript();
  BtnExtract.Enabled := True;
  MemoExtr.Lines.Add('< Extract finished. >');
end;

procedure TForm1.LogNextLine(Sender: TObject; LogLine: String);
begin
//  MemoExtr.AddToBuffer(LogLine);
  MemoExtr.Lines.Add(LogLine);
//  Application.ProcessMessages;
end;

procedure TForm1.BtnCompareClick(Sender: TObject);
begin
  MemoResult.Lines.Clear;
  BtnCompare.Enabled := False;
  try
    DBComparer1.CompareDatabases;
    MemoResult.Lines.BeginUpdate;
    DBComparer1.SQLExec.GetScript(MemoResult.Lines);
    MemoResult.Lines.EndUpdate;
  except on E: Exception do begin
    ShowMessage(E.Message);
    MemoResult.Lines.Add('Error: '+E.Message);
  end end;
  MemoExtr.Lines.Add('< Compare finished. >');
  BtnCompare.Enabled := True;
end;

procedure TForm1.rbFromClick(Sender: TObject);
begin
  if rbMasterFromDatabase.Checked then begin
    fnDatabaseMaster.Enabled := True;
    BtnSelDatabaseMaster.Enabled := True;
    fnScriptMaster.Enabled := False;
    BtnSelScriptMaster.Enabled := False;
    EditMUser.Enabled := True;
    EditMPswd.Enabled := True;
    LabelMUser.Enabled := True;
    LabelMPswd.Enabled := True;
  end
  else begin
    fnDatabaseMaster.Enabled := False;
    BtnSelDatabaseMaster.Enabled := False;
    fnScriptMaster.Enabled := True;
    BtnSelScriptMaster.Enabled := True;
    EditMUser.Enabled := False;
    EditMPswd.Enabled := False;
    LabelMUser.Enabled := False;
    LabelMPswd.Enabled := False;
  end;
  if rbTargetFromDatabase.Checked then begin
    fnDatabaseTarget.Enabled := True;
    BtnSelDatabaseTarget.Enabled := True;
    fnScriptTarget.Enabled := False;
    BtnSelScriptTarget.Enabled := False;
    EditTUser.Enabled := True;
    EditTPswd.Enabled := True;
    LabelTUser.Enabled := True;
    LabelTPswd.Enabled := True;
  end
  else begin
    fnDatabaseTarget.Enabled := False;
    BtnSelDatabaseTarget.Enabled := False;
    fnScriptTarget.Enabled := True;
    BtnSelScriptTarget.Enabled := True;
    EditTUser.Enabled := False;
    EditTPswd.Enabled := False;
    LabelTUser.Enabled := False;
    LabelTPswd.Enabled := False;
  end;
end;

procedure TForm1.ProgressUpdate(Sender: TObject; Value, MaxValue: Integer);
begin
  Gauge1.Max := MaxValue;
  Gauge1.Position := Value;
end;

procedure TForm1.BtnUpdateClick(Sender: TObject);
begin
  IBSQLExec1.ExecuteScript();
end;

initialization
  dbcCompObj.AddToLog := AddToExtrLog;
end.
