unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, dbcSQL_Exec, dbcIBSQLExec,
  ComCtrls, dbcConnection_FireDAC, dbcTableDataComparer, dbcClasses;

type
  TForm1 = class(TForm)
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
    GroupBox2: TGroupBox;
    MemoExtr: TRichEdit;
    Splitter1: TSplitter;
    GroupBox3: TGroupBox;
    MemoResult: TMemo;
    Gauge1: TProgressBar;
    Gauge2: TProgressBar;
    Label4: TLabel;
    EditTableM: TEdit;
    Label5: TLabel;
    EditTableT: TEdit;
    BtnDataCompare: TBitBtn;
    BtnUpdate: TBitBtn;
    Label6: TLabel;
    cbCompareMode: TComboBox;
    LabelCustomFlds: TLabel;
    EditCustomFlds: TEdit;
    Label8: TLabel;
    EditExclFlds: TEdit;
    Label3: TLabel;
    Label7: TLabel;
    TableDataComparer: TTableDataComparer;
    OpenDialog1: TOpenDialog;
    IBSQLExec: TIBSQLExec;
    EditFilterM: TEdit;
    EditFilterT: TEdit;
    cbInsert: TCheckBox;
    cbUpdate: TCheckBox;
    cbDelete: TCheckBox;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BtnSelFileClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LogNextLine(Sender: TObject; LogLine: String);
    procedure ProgressUpdate(Sender: TObject; Value, MaxValue: Integer);
    procedure BtnUpdateClick(Sender: TObject);
    procedure BtnDataCompareClick(Sender: TObject);
    procedure EditTableMChange(Sender: TObject);
    procedure TableDataComparerProgressUpdateMaster(Sender: TObject; Value,
      MaxValue: Integer);
    procedure TableDataComparerProgressUpdateTarget(Sender: TObject; Value,
      MaxValue: Integer);
    procedure cbCompareModeChange(Sender: TObject);
    procedure TableDataComparerGetSelectSQL(Sender: TObject; const SQLM,
      SQLT: TStrings);
    procedure TableDataComparerGetCountSQL(Sender: TObject; const SQLM,
      SQLT: TStrings);
  private
    { Private declarations }
    procedure DecodeFields(aFlds: String; aFields: TStrings);
    function IniFileName: String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

Uses DataModule1, IniFiles;

function TForm1.IniFileName(): String;
begin
  Result := ExtractFilePath(ParamStr(0))+'CompDemo.Ini';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  MemoExtr.Clear;
  MemoResult.Clear;

  with TIniFile.Create(IniFileName()) do
  begin
    fnDatabaseMaster.Text := ReadString('Databases','MasterDB','');
    fnDatabaseTarget.Text := ReadString('Databases','TargetDB','');
    EditTableM.Text := ReadString('TableDataComparer','TableNameMaster', '');
    EditTableT.Text := ReadString('TableDataComparer','TableNameTarget', '');
    cbCompareMode.ItemIndex := ReadInteger('TableDataComparer','DataCompareMode', 0);
    cbCompareModeChange(cbCompareMode);
    EditCustomFlds.Text := ReadString('TableDataComparer','CustomKeyFields', '');
    EditExclFlds.Text := ReadString('TableDataComparer','ExcludeDataFields', '');
    EditFilterM.Text := ReadString('TableDataComparer','EditFilterM', '');
    EditFilterT.Text := ReadString('TableDataComparer','EditFilterT', '');
    Free;
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  with TIniFile.Create(IniFileName()) do
  begin
    WriteString('Databases', 'MasterDB', fnDatabaseMaster.Text);
    WriteString('Databases', 'TargetDB', fnDatabaseTarget.Text);
    WriteString('TableDataComparer','TableNameMaster', EditTableM.Text);
    WriteString('TableDataComparer','TableNameTarget', EditTableT.Text);
    WriteInteger('TableDataComparer','DataCompareMode', cbCompareMode.ItemIndex);
    WriteString('TableDataComparer','CustomKeyFields', EditCustomFlds.Text);
    WriteString('TableDataComparer','ExcludeDataFields', EditExclFlds.Text);
    WriteString('TableDataComparer','EditFilterM', EditFilterM.Text);
    WriteString('TableDataComparer','EditFilterT', EditFilterT.Text);
    Free;
  end;
end;

procedure TForm1.BtnSelFileClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    if Sender = BtnSelDatabaseMaster then
      fnDatabaseMaster.Text := OpenDialog1.FileName;
    if Sender = BtnSelDatabaseTarget then
      fnDatabaseTarget.Text := OpenDialog1.FileName;
  end;
end;

procedure TForm1.LogNextLine(Sender: TObject; LogLine: String);
begin
  MemoExtr.Lines.Add(LogLine);
  MemoExtr.Perform(EM_SCROLLCARET, 0, 0);
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
    if (Length(fldName) > 0) and CharInSet(fldName[1], ['A'..'Z','a'..'z']) then
    begin
      Result := AnsiUpperCase(fldName);
    end else
    begin
      Result := fldName;
    end;
  end;

begin
  aFields.Clear;
  s := aFlds;
  p := pos(',', s);
  while p > 0 do
  begin
    FldName := Trim(Copy(s, 1, p-1));
    if fldName <> '' then
    begin
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
  TableDataComparer.TableNameMaster := EditTableM.Text;
  TableDataComparer.TableNameTarget := EditTableT.Text;
  DecodeFields(EditCustomFlds.Text, TableDataComparer.CustomKeyFields);
  DecodeFields(EditExclFlds.Text, TableDataComparer.ExcludeDataFields);
  TableDataComparer.AllowedOperations := [];

  if cbInsert.Checked then
  begin
    TableDataComparer.AllowedOperations := TableDataComparer.AllowedOperations + [dcopInsert];
  end;
  if cbUpdate.Checked then
  begin
    TableDataComparer.AllowedOperations := TableDataComparer.AllowedOperations + [dcopUpdate];
  end;
  if cbDelete.Checked then
  begin
    TableDataComparer.AllowedOperations := TableDataComparer.AllowedOperations + [dcopDelete];
  end;

  IBSQLExec.Clear;
  MemoResult.Clear;
  if TableDataComparer.CompareData() then
  begin
    IBSQLExec.GetScript(MemoResult.Lines);
  end;
end;

procedure TForm1.EditTableMChange(Sender: TObject);
begin
  EditTableT.Text := EditTableM.Text;
end;

const
  WhereClause: array[Boolean] of string = ('', ' where ');

procedure TForm1.TableDataComparerGetCountSQL(Sender: TObject; const SQLM,
  SQLT: TStrings);
begin
  SQLM.Text := 'select count(*) from ' + EditTableM.Text
    + WhereClause[EditFilterM.Text <> ''] + EditFilterM.Text;
  SQLT.Text := 'select count(*) from ' + EditTableT.Text
    + WhereClause[EditFilterT.Text <> ''] + EditFilterT.Text;
end;

procedure TForm1.TableDataComparerGetSelectSQL(Sender: TObject; const SQLM,
  SQLT: TStrings);
begin
  SQLM.Text := 'select * from ' + EditTableM.Text
    + WhereClause[EditFilterM.Text <> ''] + EditFilterM.Text;
  SQLT.Text := 'select * from ' + EditTableT.Text
    + WhereClause[EditFilterM.Text <> ''] + EditFilterM.Text;
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
  EditCustomFlds.Enabled := (cbCompareMode.ItemIndex = 3);
  LabelCustomFlds.Enabled := (cbCompareMode.ItemIndex = 3);
end;

end.
