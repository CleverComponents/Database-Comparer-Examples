unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, dbcDBComparer, dbcDBStructure,
  dbcIBDatabaseExtract, dbcClasses, dbcIBScriptExtract, dbcSQL_Exec, dbcIBSQLExec,
  ComCtrls, dbcDBEngine, dbcCustomScriptExtract,
  dbcTableDataComparer;

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
    IBSQLExec: TIBSQLExec;
    BtnUpdate: TBitBtn;
    Gauge1: TProgressBar;
    Label3: TLabel;
    GroupBox4: TGroupBox;
    EditTableM: TEdit;
    EditTableT: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    TableDataComparer: TTableDataComparer;
    Label6: TLabel;
    cbCompareMode: TComboBox;
    EditCustomFlds: TEdit;
    LabelCustomFlds: TLabel;
    EditExclFlds: TEdit;
    Label8: TLabel;
    BtnDataCompare: TBitBtn;
    BitBtn2: TBitBtn;
    Label9: TLabel;
    Gauge2: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure BtnSelFileClick(Sender: TObject);
    procedure BtnExtractClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LogNextLine(Sender: TObject; LogLine: String);
    procedure BtnCompareClick(Sender: TObject);
    procedure rbFromClick(Sender: TObject);
    procedure ProgressUpdate(Sender: TObject; Value, MaxValue: Integer);
    procedure BtnUpdateClick(Sender: TObject);
    procedure BtnDataCompareClick(Sender: TObject);
    procedure EditTableMChange(Sender: TObject);
    procedure TableDataComparerProgressUpdateMaster(Sender: TObject; Value,
      MaxValue: Integer);
    procedure TableDataComparerProgressUpdateTarget(Sender: TObject; Value,
      MaxValue: Integer);
    procedure cbCompareModeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DecodeFields(aFlds: String; aFields: TStrings);
    procedure ExtractMasterDatabase();
    procedure ExtractTargetDatabase();
    procedure ExtractMasterScript();
    procedure ExtractTargetScript();
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

Uses IBDataModule, IniFiles, dbcCompObj;

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
    EditTableM.Text := ReadString('TableDataComparer','TableNameMaster', '');
    EditTableT.Text := ReadString('TableDataComparer','TableNameTarget', '');
    cbCompareMode.ItemIndex := ReadInteger('TableDataComparer','DataCompareMode', 0);
    cbCompareModeChange(cbCompareMode);
    EditCustomFlds.Text := ReadString('TableDataComparer','CustomKeyFields', '');
    EditExclFlds.Text := ReadString('TableDataComparer','ExcludeDataFields', '');
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
    WriteString('TableDataComparer','TableNameMaster', EditTableM.Text);
    WriteString('TableDataComparer','TableNameTarget', EditTableT.Text);
    WriteInteger('TableDataComparer','DataCompareMode', cbCompareMode.ItemIndex);
    WriteString('TableDataComparer','CustomKeyFields', EditCustomFlds.Text);
    WriteString('TableDataComparer','ExcludeDataFields', EditExclFlds.Text);
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
  with DataMd do begin

    ErrFlg := False;
    try
      DBCConnection1.Connected := True;
    except on E: Exception do begin
      ShowMessage(E.Message);
      MemoExtr.Lines.Add('Error: '+E.Message);
      ErrFlg := True;
      UniConnection1.Connected := false;
    end end;
    if ErrFlg then exit;
    MemoExtr.Lines.Add('Database: '+fnDatabaseMaster.Text+' open.');
    DBStructure1.Clear;
    IBDBExtract1.ExtractDatabase;
    DBCConnection1.Connected := False;
  end;
end;

procedure TForm1.ExtractTargetDatabase;
var
  ErrFlg: Boolean;
begin
  with DataMd do begin

    ErrFlg := False;
    try
      DBCConnection2.Connected := True;
    except on E: Exception do begin
      ShowMessage(E.Message);
      MemoExtr.Lines.Add('Error: '+E.Message);
      ErrFlg := True;
      UniConnection2.Connected := false;
    end end;
    if ErrFlg then exit;
    MemoExtr.Lines.Add('Database: '+fnDatabaseTarget.Text+' open.');
    DBStructure2.Clear;
    IBDBExtract2.ExtractDatabase;
    DBCConnection2.Connected := False;
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
  MemoExtr.Lines.Add(LogLine);
  MemoExtr.Perform(EM_SCROLLCARET, 0, 0);
end;

procedure TForm1.BtnCompareClick(Sender: TObject);
begin
  MemoResult.Lines.Clear;
  BtnCompare.Enabled := False;
  try
    DBComparer1.CompareDatabases();
    MemoResult.Lines.BeginUpdate();
    DBComparer1.SQLExec.GetScript(MemoResult.Lines);
    MemoResult.Lines.EndUpdate();
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
    fnDatabaseMaster.Color := clWindow;
    fnScriptMaster.Color := clBtnFace;
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
    fnDatabaseMaster.Color := clBtnFace;
    fnScriptMaster.Color := clWindow;
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
    fnDatabaseTarget.Color := clWindow;
    fnScriptTarget.Color := clBtnFace;
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
    fnDatabaseTarget.Color := clBtnFace;
    fnScriptTarget.Color := clWindow;
  end;
end;

procedure TForm1.ProgressUpdate(Sender: TObject; Value, MaxValue: Integer);
begin
  Gauge1.Max := MaxValue;
  Gauge1.Position := Value;
end;

procedure TForm1.BtnUpdateClick(Sender: TObject);
begin
  IBSQLExec.ExecuteScript();
end;

procedure TForm1.DecodeFields(aFlds: String; aFields: TStrings);
var
  s: String;
  p: integer;
  FldName: String;

  function CheckUpper(fldName: String): string;
  begin
    if (Length(fldName) > 0) and (fldName[1] in ['A'..'Z','a'..'z']) then
      Result := AnsiUpperCase(fldName)
    else Result := fldName;
  end;

begin
  aFields.Clear;
  s := aFlds;
  p := pos(',', s);
  while p > 0 do begin
    FldName := Trim(Copy(s, 1, p-1));
    if fldName <> '' then begin
      aFields.Add(CheckUpper(FldName));
    end;
    Delete(s, 1, p);
    p := pos(',', s);
  end;
  FldName := Trim(s);
  if FldName <> '' then aFields.Add(CheckUpper(FldName));
end;

procedure TForm1.BtnDataCompareClick(Sender: TObject);
begin
  if (not rbMasterFromDatabase.Checked) or (not rbTargetFromDatabase.Checked) then begin
    ShowMessage('Table data comparer find differences only in database-tables...');
    rbMasterFromDatabase.Checked := True;
    rbTargetFromDatabase.Checked := True;
    rbFromClick(nil);
    exit;
  end;
  TableDataComparer.TableNameMaster := EditTableM.Text;
  TableDataComparer.TableNameTarget := EditTableT.Text;
  DecodeFields(EditCustomFlds.Text, TableDataComparer.CustomKeyFields);
  DecodeFields(EditExclFlds.Text, TableDataComparer.ExcludeDataFields);
  IBSQLExec.Clear;
  MemoResult.Clear;
  if TableDataComparer.CompareData() then begin
    IBSQLExec.GetScript(MemoResult.Lines);
  end;
end;

procedure TForm1.EditTableMChange(Sender: TObject);
begin
  EditTableT.Text := EditTableM.Text;
end;

procedure TForm1.TableDataComparerProgressUpdateMaster(Sender: TObject;
  Value, MaxValue: Integer);
begin
  Gauge1.Max := MaxValue;
  Gauge1.Position := Value;
end;

procedure TForm1.TableDataComparerProgressUpdateTarget(Sender: TObject;
  Value, MaxValue: Integer);
begin
  Gauge2.Max := MaxValue;
  Gauge2.Position := Value;
end;

procedure TForm1.cbCompareModeChange(Sender: TObject);
begin
  EditCustomFlds.Enabled := cbCompareMode.ItemIndex = 3;
  LabelCustomFlds.Enabled := cbCompareMode.ItemIndex = 3;
end;

initialization
  dbcCompObj.AddToLog := AddToExtrLog;
end.
