unit Unit1Ado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls,
  ExtCtrls, dbcMSSQLDatabaseExtract, dbcClasses, dbcCustomScriptExtract,
  dbcMSSQLScriptExtract, dbcSQL_Exec, dbcMSSQLExec, dbcDBEngine,
  dbcConnection_ADO, dbcDBComparer, dbcDBStructure, ComCtrls;

type
  TForm1 = class(TForm)
    DBStructure1: TDBStructure;
    DBStructure2: TDBStructure;
    OpenDialog1: TOpenDialog;
    GroupBox1: TGroupBox;
    EditDbMaster: TEdit;
    EditDbTarget: TEdit;
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
    MemoLog: TRichEdit;
    DBComparer1: TDBComparer;
    Splitter1: TSplitter;
    GroupBox3: TGroupBox;
    MemoResult: TMemo;
    fnScriptMaster: TEdit;
    BtnSelScriptMaster: TSpeedButton;
    fnScriptTarget: TEdit;
    BtnSelScriptTarget: TSpeedButton;
    Panel1: TPanel;
    rbMasterFromDatabase: TRadioButton;
    rbMasterFromScript: TRadioButton;
    Panel2: TPanel;
    rbTargetFromDatabase: TRadioButton;
    rbTargetFromScript: TRadioButton;
    BtnUpdate: TBitBtn;
    Gauge1: TProgressBar;
    DBCConnectionADO1: TDBCConnectionADO;
    DBCConnectionADO2: TDBCConnectionADO;
    MSSQLExec1: TMSSQLExec;
    MSSQLScriptExtract1: TMSSQLScriptExtract;
    MSSQLScriptExtract2: TMSSQLScriptExtract;
    MSSQLDBExtract1: TMSSQLDBExtract;
    MSSQLDBExtract2: TMSSQLDBExtract;
    Panel3: TPanel;
    Panel4: TPanel;
    LabelSrvM: TLabel;
    EditHostM: TEdit;
    LabelAuthM: TLabel;
    rbMWin: TRadioButton;
    rbMSql: TRadioButton;
    LabelSrvT: TLabel;
    EditHostT: TEdit;
    LabelAuthT: TLabel;
    rbTWin: TRadioButton;
    rbTSql: TRadioButton;
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
    procedure AddToLog(aText: String);
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

Uses DataModuleAdo, IniFiles, dbcCompObj;

function IniFileName(): String;
begin
  Result := ExtractFilePath(ParamStr(0))+'CompDemo.Ini';
end;

function AdoConnectString(WinAuth: Boolean;
                          HostName, DbName, UserName, Password: String): String;
begin
    Result := 'Provider=SQLOLEDB;' +
                        'Initial Catalog='+DbName+';';
    if HostName <> '' then Result := Result +
                        'Data Source='+HostName+';';
    if WinAuth then begin
      Result := Result + 'Integrated Security=SSPI;' +
                         'Persist Security Info=False;';
    end
    else begin
      Result := Result + 'Persist Security Info=True;';
      if UserName <> '' then
        Result := Result + 'User ID=' + UserName + ';';
      if Password <> '' then
        Result := Result + 'Password=' + Password + ';';
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  MFromD, TFromD: Boolean;
begin
  EditDBMaster.Text := '';
  EditDBTarget.Text := '';
  fnScriptMaster.Text := '';
  fnScriptTarget.Text := '';
  MemoLog.Clear;
  MemoResult.Clear;
  with TIniFile.Create(IniFileName()) do begin
    EditDBMaster.Text := ReadString('Databases','MasterDBMS','');
    EditDBTarget.Text := ReadString('Databases','TargetDBMS','');
    fnScriptMaster.Text := ReadString('Databases','MasterScriptMS','');
    fnScriptTarget.Text := ReadString('Databases','TargetScriptMS','');
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
    WriteString('Databases', 'MasterDBMS', EditDBMaster.Text);
    WriteString('Databases', 'TargetDBMS', EditDBTarget.Text);
    WriteString('Databases', 'MasterScriptMS', fnScriptMaster.Text);
    WriteString('Databases', 'TargetScriptMS', fnScriptTarget.Text);
    WriteBool('Databases','MasterFromDatabase',rbMasterFromDatabase.Checked);
    WriteBool('Databases','TargetFromDatabase',rbTargetFromDatabase.Checked);
    Free;
  end;
end;

procedure TForm1.BtnSelFileClick(Sender: TObject);
begin
  if (Sender = BtnSelDataBaseMaster) or (Sender = BtnSelDatabaseTarget) then begin
    OpenDialog1.Filter := 'All Files (*.*)|*.*';
  end;
  if (Sender = BtnSelScriptMaster) or (Sender = BtnSelScriptTarget) then begin
    OpenDialog1.Filter := 'SQL Script (*.SQL)|*.sql|SQL Script (*.DDL)|*.ddl|All Files (*.*)|*.*';
  end;
  if OpenDialog1.Execute then begin
    if Sender = BtnSelDatabaseMaster then
      EditDBMaster.Text := OpenDialog1.FileName;
    if Sender = BtnSelDatabaseTarget then
      EditDBTarget.Text := OpenDialog1.FileName;
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
  with DataMdMS do begin
    ADOConnection1.Provider := 'SQLOLEDB';
    ADOConnection1.ConnectionString := AdoConnectString(rbMWin.Checked,
                                       EditHostM.Text,
                                       EditDBMaster.Text,
                                       EditMUser.Text,
                                       EditMPswd.Text);
    ErrFlg := False;
    try
      ADOConnection1.Connected := True;
    except on E: Exception do begin
      ShowMessage(E.Message);
      AddToLog('Error: '+E.Message);
      ErrFlg := True;
      ADOConnection1.Connected := False;
    end end;
    if ErrFlg then exit;
    AddToLog('Database: '+EditDBMaster.Text+' opened.');
    DBStructure1.Clear;
    MSSQLDBExtract1.ExtractDatabase;
    ADOConnection1.Connected := False;
  end;
end;

procedure TForm1.ExtractTargetDatabase;
var
  ErrFlg: Boolean;
begin
  with DataMdMS do begin
    ADOConnection2.Provider := 'SQLOLEDB';
    ADOConnection2.ConnectionString := AdoConnectString(rbTWin.Checked,
                                       EditHostT.Text,
                                       EditDBTarget.Text,
                                       EditTUser.Text,
                                       EditTPswd.Text);
    ErrFlg := False;
    try
      ADOConnection2.Connected := True;
    except on E: Exception do begin
      ShowMessage(E.Message);
      AddToLog('Error: '+E.Message);
      ErrFlg := True;
      ADOConnection2.Connected := False;
    end end;
    if ErrFlg then exit;
    AddToLog('Database: '+EditDBTarget.Text+' opened.');
    DBStructure2.Clear;
    MSSQLDBExtract2.ExtractDatabase;
    ADOConnection2.Connected := False;
  end;
end;

procedure TForm1.ExtractMasterScript();
begin
  MSSQLScriptExtract1.ScriptFileName := fnScriptMaster.Text;
  MSSQLScriptExtract1.ExtractDatabase;
end;

procedure TForm1.ExtractTargetScript();
begin
  MSSQLScriptExtract2.ScriptFileName := fnScriptTarget.Text;
  MSSQLScriptExtract2.ExtractDatabase;
end;

procedure TForm1.BtnExtractClick(Sender: TObject);
begin
  BtnExtract.Enabled := False;
  if rbTargetFromDatabase.Checked then ExtractTargetDatabase();
  if rbTargetFromScript.Checked then ExtractTargetScript();
  if rbMasterFromDatabase.Checked then ExtractMasterDatabase();
  if rbMasterFromScript.Checked then ExtractMasterScript();
  BtnExtract.Enabled := True;
  AddToLog('< Extracting finished. >');
end;

procedure TForm1.LogNextLine(Sender: TObject; LogLine: String);
begin
  AddToLog(LogLine);
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
  AddToLog('< Comparing finished. >');
  BtnCompare.Enabled := True;
end;

procedure TForm1.rbFromClick(Sender: TObject);
begin
  if rbMasterFromDatabase.Checked then begin
    EditDBMaster.Enabled := True;
//    BtnSelDatabaseMaster.Enabled := True;
    fnScriptMaster.Enabled := False;
    BtnSelScriptMaster.Enabled := False;
    EditMUser.Enabled := True;
    EditMPswd.Enabled := True;
    LabelMUser.Enabled := True;
    LabelMPswd.Enabled := True;
    LabelSrvM.Enabled := True;
    EditHostM.Enabled := True;
    LabelAuthM.Enabled := True;
    rbMWin.Enabled := True;
    rbMSql.Enabled := True;
  end
  else begin
    EditDBMaster.Enabled := False;
    BtnSelDatabaseMaster.Enabled := False;
    fnScriptMaster.Enabled := True;
    BtnSelScriptMaster.Enabled := True;
    EditMUser.Enabled := False;
    EditMPswd.Enabled := False;
    LabelMUser.Enabled := False;
    LabelMPswd.Enabled := False;
    LabelSrvM.Enabled := False;
    EditHostM.Enabled := False;
    LabelAuthM.Enabled := False;
    rbMWin.Enabled := False;
    rbMSql.Enabled := False;
  end;
  if rbTargetFromDatabase.Checked then begin
    EditDBTarget.Enabled := True;
//    BtnSelDatabaseTarget.Enabled := True;
    fnScriptTarget.Enabled := False;
    BtnSelScriptTarget.Enabled := False;
    EditTUser.Enabled := True;
    EditTPswd.Enabled := True;
    LabelTUser.Enabled := True;
    LabelTPswd.Enabled := True;
    LabelSrvT.Enabled := True;
    EditHostT.Enabled := True;
    LabelAuthT.Enabled := True;
    rbTWin.Enabled := True;
    rbTSql.Enabled := True;
  end
  else begin
    EditDBTarget.Enabled := False;
    BtnSelDatabaseTarget.Enabled := False;
    fnScriptTarget.Enabled := True;
    BtnSelScriptTarget.Enabled := True;
    EditTUser.Enabled := False;
    EditTPswd.Enabled := False;
    LabelTUser.Enabled := False;
    LabelTPswd.Enabled := False;
    LabelSrvT.Enabled := False;
    EditHostT.Enabled := False;
    LabelAuthT.Enabled := False;
    rbTWin.Enabled := False;
    rbTSql.Enabled := False;
  end;
end;

procedure TForm1.ProgressUpdate(Sender: TObject; Value, MaxValue: Integer);
begin
  Gauge1.Max := MaxValue;
  Gauge1.Position := Value;
end;

procedure TForm1.BtnUpdateClick(Sender: TObject);
begin
  MSSQLExec1.ExecuteScript();
end;

procedure TForm1.AddToLog(aText: String);
begin
  MemoLog.Lines.Add(aText);
  MemoLog.Perform(EM_SCROLLCARET, 0, 0);
end;

initialization
  dbcCompObj.AddToLog := AddToLog;
end.
