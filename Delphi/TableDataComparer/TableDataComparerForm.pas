unit TableDataComparerForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dbcClasses, dbcSQL_Exec, dbcDBEngine,
  DB, DBTables, StdCtrls, Buttons, ComCtrls,
  dbcTableDataComparer, ExtCtrls, dbcTypes, Mask, dbcMSSQLExec,
  dbcIBSQLExec;

type
  TForm1 = class(TForm)
    BtnCompare: TBitBtn;
    OpenDialog: TOpenDialog;
    MemoScript: TRichEdit;
    BtnUpdate: TBitBtn;
    MemoLog: TRichEdit;
    ProgressBarM: TProgressBar;
    DBCConnectionM: TDBCConnection;
    DBCConnectionT: TDBCConnection;
    TableDataComparer: TTableDataComparer;
    Panel2: TPanel;
    rbMIB: TRadioButton;
    rbMMS: TRadioButton;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    EditDBNameM: TEdit;
    EditUserM: TEdit;
    EditPswdM: TEdit;
    Label3: TLabel;
    LabelUserM: TLabel;
    LabelPswdM: TLabel;
    cbAuthM: TCheckBox;
    EditServerM: TEdit;
    LabelServerM: TLabel;
    Panel1: TPanel;
    rbTIB: TRadioButton;
    rbTMS: TRadioButton;
    ProgressBarT: TProgressBar;
    EditDBNameT: TEdit;
    EditUserT: TEdit;
    EditPswdT: TEdit;
    Label7: TLabel;
    LabelUserT: TLabel;
    LabelPswdT: TLabel;
    cbAuthT: TCheckBox;
    EditServerT: TEdit;
    LabelServerT: TLabel;
    EditTableM: TEdit;
    EditTableT: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    IBSQLExec: TIBSQLExec;
    MSSQLExec: TMSSQLExec;
    Database1: TDatabase;
    Query1: TQuery;
    procedure LogErrorMessage(Sender: TObject;
      ErrText: String);
    procedure LogNextLine(Sender: TObject; LogText: String);
    procedure BtnUpdateClick(Sender: TObject);
    procedure BtnCompareClick(Sender: TObject);
    procedure TableDataComparerProgressUpdateMaster(Sender: TObject; Value,
      MaxValue: Integer);
    procedure TableDataComparerProgressUpdateTarget(Sender: TObject; Value,
      MaxValue: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rbMClick(Sender: TObject);
    procedure rbTClick(Sender: TObject);
  private
    { Private declarations }
    function GetDBTypeM(): TDatabaseType;
    function GetDBTypeT(): TDatabaseType;
    procedure SetDBTypeM(aType: TDatabaseType);
    procedure SetDBTypeT(aType: TDatabaseType);
  public
    { Public declarations }
    property DatabaseTypeM: TDatabaseType read GetDBTypeM;
    property DatabaseTypeT: TDatabaseType read GetDBTypeT;
    procedure AddToLog(aText: String);
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
  // create
  with TIniFile.Create(IniFileName()) do begin
    try
      dbType := ReadInteger('Databases', 'DatabaseTypeM', ORD(dbInterbase));
      SetDbTypeM(TDatabaseType(dbType));
      dbType := ReadInteger('Databases', 'DatabaseTypeT', ORD(dbInterbase));
      SetDbTypeT(TDatabaseType(dbType));
    except end;
    rbMClick(nil);
    rbTClick(nil);
    EditDBNameM.Text := ReadString('Databases','DBNameM','');
    EditDBNameT.Text := ReadString('Databases','DBNameT','');
    EditServerM.Text := ReadString('Databases','HostNameM','');
    EditServerT.Text := ReadString('Databases','HostNameT','');
    EditUserM.Text := ReadString('Databases','UserNameM','');
    EditUserT.Text := ReadString('Databases','UserNameT','');
    EditPswdM.Text := ReadString('Databases','PasswordM','');
    EditPswdT.Text := ReadString('Databases','PasswordT','');
    cbAuthM.Checked := ReadBool('Databases', 'WinAuthenticationM', False);
    cbAuthT.Checked := ReadBool('Databases', 'WinAuthenticationT', False);
    EditTableM.Text := ReadString('Databases','TableNameM','');
    EditTableT.Text := ReadString('Databases','TableNameT','');
    Free;
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  // destroy
  with TIniFile.Create(IniFileName()) do begin
    try
      WriteInteger('Databases', 'DatabaseTypeM', ORD(GetDbTypeM()));
    except end;
    try
      WriteInteger('Databases', 'DatabaseTypeT', ORD(GetDbTypeT()));
    except end;
    WriteString('Databases', 'DBNameM', EditDBNameM.Text);
    WriteString('Databases', 'DBNameT', EditDBNameT.Text);
    WriteString('Databases', 'HostNameM', EditServerM.Text);
    WriteString('Databases', 'HostNameT', EditServerT.Text);
    WriteString('Databases','UserNameM',EditUserM.Text);
    WriteString('Databases','UserNameT',EditUserT.Text);
    WriteString('Databases','PasswordM',EditPswdM.Text);
    WriteString('Databases','PasswordT',EditPswdT.Text);
    WriteBool('Databases', 'WinAuthenticationM', cbAuthM.Checked);
    WriteBool('Databases', 'WinAuthenticationT', cbAuthT.Checked);
    WriteString('Databases','TableNameM',EditTableM.Text);
    WriteString('Databases','TableNameT',EditTableT.Text);
    Free;
  end;
end;

procedure TForm1.AddToLog(aText: String);
begin
  MemoLog.Lines.Add(aText);
  MemoLog.Perform(EM_SCROLLCARET, 0, 0);
end;


procedure TForm1.LogErrorMessage(Sender: TObject;
  ErrText: String);
begin
  AddToLog(ErrText);
end;

procedure TForm1.LogNextLine(Sender: TObject; LogText: String);
begin
  AddToLog(LogText);
end;

procedure TForm1.BtnUpdateClick(Sender: TObject);
begin
  if Assigned(TableDataComparer.SQLExec) then begin
    DBCConnectionT.Connected := True;
    TableDataComparer.SQLExec.ExecuteScript();
    DBCConnectionT.Connected := False;
  end;
end;

function TForm1.GetDBTypeM(): TDatabaseType;
begin
  if rbMMS.Checked then Result := dbMSSQL
  else Result := dbInterbase;
end;

function TForm1.GetDBTypeT(): TDatabaseType;
begin
  if rbTMS.Checked then Result := dbMSSQL
  else Result := dbInterbase;
end;

procedure TForm1.SetDBTypeM(aType: TDatabaseType);
begin
  case aType of
    dbMSSQL: rbMMS.Checked := True;
  else
    rbMIB.Checked := True;
  end;
end;

procedure TForm1.SetDBTypeT(aType: TDatabaseType);
begin
  case aType of
    dbMSSQL: rbTMS.Checked := True;
  else
    rbTIB.Checked := True;
  end;
end;

procedure TForm1.BtnCompareClick(Sender: TObject);
begin
  case Self.DatabaseTypeM of
    dbInterbase: begin
      DBCConnectionM.ConnectionType := cnIBX;
      if EditServerM.Text <> '' then
        DBCConnectionM.ConnectionOptions.Protocol := ptTCP
      else DBCConnectionM.ConnectionOptions.Protocol := ptLocal;
    end;
    dbMSSQL: begin
      DBCConnectionM.ConnectionType := cnADO;
    end;
  end;
  DBCConnectionM.DatabaseType := Self.DatabaseTypeM;
  case Self.DatabaseTypeT of
    dbInterbase: begin
      DBCConnectionT.ConnectionType := cnIBX;
      if EditServerT.Text <> '' then
        DBCConnectionT.ConnectionOptions.Protocol := ptTCP
      else DBCConnectionT.ConnectionOptions.Protocol := ptLocal;
      TableDataComparer.SQLExec := IBSQLExec;
    end;
    dbMSSQL: begin
      DBCConnectionT.ConnectionType := cnADO;
      TableDataComparer.SQLExec := MSSQLExec;
    end;
  end;
  DBCConnectionT.DatabaseType := Self.DatabaseTypeT;
  with DBCConnectionM.ConnectionOptions do begin
    DatabaseName := EditDBNameM.Text;
    HostName := EditServerM.Text;
    UserName := EditUserM.Text;
    Password := EditPswdM.Text;
    UseWindowsAuthentication := cbAuthM.Checked;
  end;
  with DBCConnectionT.ConnectionOptions do begin
    DatabaseName := EditDBNameT.Text;
    HostName := EditServerT.Text;
    UserName := EditUserT.Text;
    Password := EditPswdT.Text;
    UseWindowsAuthentication := cbAuthT.Checked;
  end;
  // tables
  TableDataComparer.TableNameMaster := EditTableM.Text;
  TableDataComparer.TableNameTarget := EditTableT.Text;
  // run comparing
  MemoScript.Lines.Clear;
  if TableDataComparer.CompareData() then begin
    TableDataComparer.SQLExec.GetScript(MemoScript.Lines);
    AddToLog('< Comparing finished. >');
  end
  else AddToLog('< Comparing finished abnormally! >');
end;

procedure TForm1.TableDataComparerProgressUpdateMaster(Sender: TObject;
  Value, MaxValue: Integer);
begin
  ProgressBarM.Max := MaxValue;
  ProgressBarM.Position := Value;
end;

procedure TForm1.TableDataComparerProgressUpdateTarget(Sender: TObject;
  Value, MaxValue: Integer);
begin
  ProgressBarT.Max := MaxValue;
  ProgressBarT.Position := Value;
end;

procedure TForm1.rbMClick(Sender: TObject);
var
  LoginEnabled: Boolean;
begin
  if rbMIB.Checked then begin
    EditUserM.Text := 'SYSDBA';
    EditPswdM.Text := 'masterkey';
  end
  else begin
    EditUserM.Text := '';
    EditPswdM.Text := '';
  end;
  if Sender <> cbAuthM then
    cbAuthM.Checked := rbMMS.Checked;
  cbAuthM.Enabled := rbMMS.Checked;
  LoginEnabled := rbMIB.Checked or (rbMMS.Checked and (not cbAuthM.Checked));
  EditUserM.Enabled := LoginEnabled;
  EditPswdM.Enabled := LoginEnabled;
  LabelUserM.Enabled := LoginEnabled;
  LabelPswdM.Enabled := LoginEnabled;
  LabelServerM.Enabled := rbMIB.Checked or rbMMS.Checked;
  EditServerM.Enabled := rbMIB.Checked or rbMMS.Checked;
end;

procedure TForm1.rbTClick(Sender: TObject);
var
  LoginEnabled: Boolean;
begin
  if rbTIB.Checked then begin
    EditUserT.Text := 'SYSDBA';
    EditPswdT.Text := 'masterkey';
  end
  else begin
    EditUserT.Text := '';
    EditPswdT.Text := '';
  end;
  if Sender <> cbAuthT then
    cbAuthT.Checked := rbTMS.Checked;
  cbAuthT.Enabled := rbTMS.Checked;
  LoginEnabled := rbTIB.Checked or (rbTMS.Checked and (not cbAuthT.Checked));
  EditUserT.Enabled := LoginEnabled;
  EditPswdT.Enabled := LoginEnabled;
  LabelUserT.Enabled := LoginEnabled;
  LabelPswdT.Enabled := LoginEnabled;
  LabelServerT.Enabled := rbTIB.Checked or rbTMS.Checked;
  EditServerT.Enabled := rbTIB.Checked or rbTMS.Checked;
end;

end.
