unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dbcClasses, dbcDBStructure, dbcMySQLDatabaseExtract,
  dbcMSSQLDatabaseExtract, dbcIBDatabaseExtract, dbcDBEngine, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, dbcTypes;

type
  TForm1 = class(TForm)
    BtnExtractDb: TBitBtn;
    OpenDialog: TOpenDialog;
    MemoScript: TRichEdit;
    MemoLog: TRichEdit;
    ProgressBarM: TProgressBar;
    DBCConnection: TDBCConnection;
    Panel2: TPanel;
    rbMIB: TRadioButton;
    rbMMS: TRadioButton;
    rbMMY: TRadioButton;
    EditDBNameM: TEdit;
    EditUserM: TEdit;
    EditPswdM: TEdit;
    Label3: TLabel;
    LabelUserM: TLabel;
    LabelPswdM: TLabel;
    cbAuthM: TCheckBox;
    EditServerM: TEdit;
    LabelServerM: TLabel;
    EditTableM: TEdit;
    Label11: TLabel;
    IBDBExtract: TIBDBExtract;
    MSSQLDBExtract: TMSSQLDBExtract;
    MySQLDBExtract: TMySQLDBExtract;
    DBStructure: TDBStructure;
    BtnExtractMetadata: TBitBtn;
    BtnExtractTable: TBitBtn;
    procedure LogErrorMessage(Sender: TObject;
      ErrText: String);
    procedure LogNextLine(Sender: TObject; LogText: String);
    procedure BtnExtractDbClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rbMClick(Sender: TObject);
    procedure BtnExtractMetadataClick(Sender: TObject);
    procedure BtnExtractTableClick(Sender: TObject);
  private
    { Private declarations }
    function GetDBType(): TDatabaseType;
    procedure SetDBType(aType: TDatabaseType);
  public
    { Public declarations }
    property DatabaseType: TDatabaseType read GetDBType;
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
      SetDbType(TDatabaseType(dbType));
    except end;
    rbMClick(nil);
    EditDBNameM.Text := ReadString('Databases','DBNameM','');
    EditServerM.Text := ReadString('Databases','HostNameM','');
    EditUserM.Text := ReadString('Databases','UserNameM','');
    EditPswdM.Text := ReadString('Databases','PasswordM','');
    cbAuthM.Checked := ReadBool('Databases', 'WinAuthenticationM', False);
    EditTableM.Text := ReadString('Databases','TableNameM','');
    Free;
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  // destroy
  with TIniFile.Create(IniFileName()) do begin
    try
      WriteInteger('Databases', 'DatabaseTypeM', ORD(GetDbType()));
    except end;
    WriteString('Databases', 'DBNameM', EditDBNameM.Text);
    WriteString('Databases', 'HostNameM', EditServerM.Text);
    WriteString('Databases','UserNameM',EditUserM.Text);
    WriteString('Databases','PasswordM',EditPswdM.Text);
    WriteBool('Databases', 'WinAuthenticationM', cbAuthM.Checked);
    WriteString('Databases','TableNameM',EditTableM.Text);
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

function TForm1.GetDBType(): TDatabaseType;
begin
  if rbMMS.Checked then Result := dbMSSQL
  else if rbMMY.Checked then Result := dbMySQL
  else Result := dbInterbase;
end;

procedure TForm1.SetDBType(aType: TDatabaseType);
begin
  case aType of
    dbMSSQL: rbMMS.Checked := True;
    dbMySQL: rbMMY.Checked := True;
  else
    rbMIB.Checked := True;
  end;
end;

procedure TForm1.BtnExtractDbClick(Sender: TObject);
var
  Extractor: TCustomExtract;
begin
  BtnExtractDb.Enabled := False;
  BtnExtractDb.Update();
  Extractor := nil;
  case Self.DatabaseType of
    dbInterbase: begin
      DBCConnection.ConnectionType := cnIBX;
      if EditServerM.Text <> '' then
        DBCConnection.ConnectionOptions.Protocol := ptTCP
      else DBCConnection.ConnectionOptions.Protocol := ptLocal;
      Extractor := IBDBExtract;
    end;
    dbMSSQL: begin
      DBCConnection.ConnectionType := cnADO;
      Extractor := MSSQLDBExtract;
    end;
    dbMySQL: begin
      Extractor := MySQLDBExtract;
    end;
  end;
  DBCConnection.DatabaseType := Self.DatabaseType;
  with DBCConnection.ConnectionOptions do begin
    DatabaseName := EditDBNameM.Text;
    HostName := EditServerM.Text;
    UserName := EditUserM.Text;
    Password := EditPswdM.Text;
    UseWindowsAuthentication := cbAuthM.Checked;
  end;
  // run extracting
  MemoScript.Lines.Clear;
  try
    DBCConnection.Connected := True;
  except on E: Exception do begin
    AddToLog(E.Message);
  end end;

  if DBCConnection.Connected and Extractor.ExtractDatabase() then begin
    AddToLog('< Extracting finished. >');
    BtnExtractMetadata.Enabled := True;
    BtnExtractTable.Enabled := True;
  end
  else AddToLog('< Extracting finished abnormally! >');
  DBCConnection.Connected := False;
  BtnExtractDb.Enabled := True;
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
  LoginEnabled := rbMIB.Checked or rbMMY.Checked or (rbMMS.Checked and (not cbAuthM.Checked));
  EditUserM.Enabled := LoginEnabled;
  EditPswdM.Enabled := LoginEnabled;
  LabelUserM.Enabled := LoginEnabled;
  LabelPswdM.Enabled := LoginEnabled;
  LabelServerM.Enabled := rbMIB.Checked or rbMMS.Checked or rbMMY.Checked;
  EditServerM.Enabled := rbMIB.Checked or rbMMS.Checked or rbMMY.Checked;
end;

procedure TForm1.BtnExtractMetadataClick(Sender: TObject);
begin
  BtnExtractMetadata.Enabled := False;
  BtnExtractMetadata.Update();
  MemoScript.Clear;
  DBStructure.Metadata.ExtractMetadata(MemoScript.Lines);
  BtnExtractMetadata.Enabled := True;
end;

procedure TForm1.BtnExtractTableClick(Sender: TObject);
begin
  BtnExtractTable.Enabled := False;
  BtnExtractTable.Update();
  if EditTableM.Text = '' then ShowMessage('Table name not specified.')
  else begin
    MemoScript.Clear;
    DBStructure.Metadata.ExtractTable(MemoScript.Lines, EditTableM.Text, dbcTypes.DefCmpObjSet);
  end;
  BtnExtractTable.Enabled := True;
end;

end.
