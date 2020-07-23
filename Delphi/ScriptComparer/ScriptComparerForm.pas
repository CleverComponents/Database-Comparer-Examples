unit ScriptComparerForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,
  dbcTypes, ExtCtrls, ComCtrls, dbcMSSQLScriptExtract,
  dbcOracleScriptExtract, dbcMySQLScriptExtract, dbcASAScriptExtract,
  dbcClasses, dbcCustomScriptExtract, dbcIBScriptExtract, dbcDBStructure,
  dbcDBComparer;

type
  TForm1 = class(TForm)
    BtnSelM: TSpeedButton;
    fnScriptM: TEdit;
    BtnSelT: TSpeedButton;
    FnScriptT: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    OpenDialog1: TOpenDialog;
    rbIB: TRadioButton;
    rbSAW: TRadioButton;
    rbMy: TRadioButton;
    rbOra: TRadioButton;
    rbMS: TRadioButton;
    BtnExtract: TBitBtn;
    BtnCompare: TBitBtn;
    MemoLog: TRichEdit;
    MemoScript: TRichEdit;
    Panel1: TPanel;
    Splitter1: TSplitter;
    DBComparer: TDBComparer;
    DBStructureMaster: TDBStructure;
    DBStructureTarget: TDBStructure;
    IBScriptExtract: TIBScriptExtract;
    SAWScriptExtract: TASAScriptExtract;
    MySQLScriptExtract: TMySQLScriptExtract;
    OracleScriptExtract: TOracleScriptExtract;
    MSSQLScriptExtract: TMSSQLScriptExtract;
    ProgressBar: TProgressBar;
    procedure BtnSelClick(Sender: TObject);
    procedure DBComparerBeforeExtract(Sender: TObject);
    procedure DBComparerBeforeExtractMaster(Sender: TObject);
    procedure DBComparerBeforeExtractTarget(Sender: TObject);
    procedure DBComparerProgressUpdate(Sender: TObject; Value,
      MaxValue: Integer);
    procedure BtnExtractClick(Sender: TObject);
    procedure BtnCompareClick(Sender: TObject);
    procedure DBComparerLogNextLine(Sender: TObject; LogText: String);
    procedure DBComparerErrorMessage(Sender: TObject; ErrText: String);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    function GetDbType(): TDatabaseType;
    procedure SetDbType(aType: TDatabaseType);
  public
    { Public declarations }
    procedure AddToLog(aText: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

Uses IniFiles;

function IniFileName(): String;
begin
  Result := ExtractFilePath(ParamStr(0))+'CompDemo.Ini';
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  dbType: Integer;
begin
  with TIniFile.Create(IniFileName()) do begin
    fnScriptM.Text := ReadString('Databases','MasterScript','');
    fnScriptT.Text := ReadString('Databases','TargetScript','');
    try
      dbType := ReadInteger('Databases', 'DatabaseType', ORD(dbInterbase));
      SetDbType(TDatabaseType(dbType));
    except end;
    Free;
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  with TIniFile.Create(IniFileName()) do begin
    WriteString('Databases', 'MasterScript', fnScriptM.Text);
    WriteString('Databases', 'TargetScript', fnScriptT.Text);
    try
      WriteInteger('Databases', 'DatabaseType', ORD(GetDbType()));
    except end;
    Free;
  end;
end;

procedure TForm1.BtnSelClick(Sender: TObject);
begin
  if (Sender = BtnSelM) or (Sender = BtnSelT) then begin
    OpenDialog1.Filter := 'SQL script (*.SQL)|*.sql|SQL script (*.DDL)|*.ddl|All files (*.*)|*.*';
  end;
  if OpenDialog1.Execute then begin
    if Sender = BtnSelM then
      fnScriptM.Text := OpenDialog1.FileName;
    if Sender = BtnSelT then
      fnScriptT.Text := OpenDialog1.FileName;
  end;
end;

function TForm1.GetDbType(): TDatabaseType;
begin
  if rbSAW.Checked then Result := dbSybaseASA
  else if rbMy.Checked then Result := dbMySQL
  else if rbOra.Checked then Result := dbOracle
  else if rbMS.Checked then Result := dbMSSQL
  else Result := dbInterbase;
end;

procedure TForm1.SetDbType(aType: TDatabaseType);
begin
  case aType of
    dbSybaseASA:
      rbSAW.Checked := True;
    dbMySQL:
      rbMy.Checked := True;
    dbOracle:
      rbOra.Checked := True;
    dbMSSQL:
      rbMS.Checked := True;
  else
    rbIB.Checked := True;    
  end;
end;

procedure TForm1.AddToLog(aText: string);
begin
  MemoLog.Lines.Add(aText);
  Memolog.Perform(EM_SCROLLCARET, 0, 0);
end;

procedure TForm1.DBComparerBeforeExtract(Sender: TObject);
begin
  case GetDbType() of
    dbInterBase: begin
      DBComparer.ExtractorMaster := IBScriptExtract;
      DBComparer.ExtractorTarget := IBScriptExtract;
    end;
    dbSybaseASA: begin
      DBComparer.ExtractorMaster := SAWScriptExtract;
      DBComparer.ExtractorTarget := SAWScriptExtract;
    end;
    dbMySQL: begin
      DBComparer.ExtractorMaster := MySQLScriptExtract;
      DBComparer.ExtractorTarget := MySQLScriptExtract;
    end;
    dbOracle: begin
      DBComparer.ExtractorMaster := OracleScriptExtract;
      DBComparer.ExtractorTarget := OracleScriptExtract;
    end;
    dbMSSQL: begin
      DBComparer.ExtractorMaster := MSSQLScriptExtract;
      DBComparer.ExtractorTarget := MSSQLScriptExtract;
    end;
  end;
end;

procedure TForm1.DBComparerBeforeExtractTarget(Sender: TObject);
begin
  with (DBComparer.ExtractorTarget as TCustomScriptExtract) do begin
    DBStructure := Self.DBStructureTarget;
    ScriptFileNames.Text := fnScriptT.Text;
  end;
end;

procedure TForm1.DBComparerBeforeExtractMaster(Sender: TObject);
begin
  with (DBComparer.ExtractorMaster as TCustomScriptExtract) do begin
    DBStructure := Self.DBStructureMaster;
    ScriptFileNames.Text := fnScriptM.Text;
  end;
end;

procedure TForm1.DBComparerProgressUpdate(Sender: TObject; Value,
  MaxValue: Integer);
begin
  ProgressBar.Max := MaxValue;
  ProgressBar.Position := Value;
end;

procedure TForm1.BtnExtractClick(Sender: TObject);
begin
  // extract metadata
  Screen.Cursor := crHourGlass;
  DBComparer.ExtractDatabases();
  Memolog.SelAttributes.Color := clHotLight;
  AddToLog('< Extracting finished... >');
  if DBComparer.MsgManager.IsErr then begin
    Memolog.SelAttributes.Color := clRed;
    AddToLog('Errors:');
    AddToLog(DBcomparer.MsgManager.ErrSummary());
  end;
  Memolog.SelAttributes.Color := clWindowText;
  Screen.Cursor := crDefault;
end;

procedure TForm1.BtnCompareClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  DBComparer.CompareDatabases();
  if Assigned(DBComparer.SQLExec) then begin
    Memolog.SelAttributes.Color := clHotLight;
    AddToLog('< Comparing finished. Loading script... >');
    MemoScript.Lines.Clear;
    DBComparer.SQLExec.GetScript(MemoScript.Lines);
    AddToLog('< Process finished. >');
    Memolog.SelAttributes.Color := clWindowText;
  end;
  Screen.Cursor := crDefault;
end;

procedure TForm1.DBComparerLogNextLine(Sender: TObject; LogText: String);
begin
  AddToLog(LogText);
end;

procedure TForm1.DBComparerErrorMessage(Sender: TObject; ErrText: String);
begin
  Memolog.Perform(EM_SCROLLCARET, 0, 0);
  Memolog.SelAttributes.Color := clRed;
  AddToLog(ErrText);
  Memolog.SelAttributes.Color := clWindowText;
end;

end.
