//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
#include "IBDataModule.h"
#include <inifiles.hpp>

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "dbcClasses"
#pragma link "dbcCustomScriptExtract"
#pragma link "dbcDBComparer"
#pragma link "dbcDBStructure"
#pragma link "dbcIBDatabaseExtract"
#pragma link "dbcIBScriptExtract"
#pragma link "dbcIBSQLExec"
#pragma link "dbcSQL_Exec"
#pragma link "dbcTableDataComparer"
#pragma resource "*.dfm"

TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------

UnicodeString __fastcall IniFileName()
{
  return ExtractFilePath(ParamStr(0)) + "CompDemo.Ini";
}

void __fastcall TForm1::FormCreate(TObject *Sender)
{
  fnDatabaseMaster->Text = "";
  fnDatabaseTarget->Text = "";
  fnScriptMaster->Text = "";
  fnScriptTarget->Text = "";
  MemoExtr->Clear();
  MemoResult->Clear();
  
  TIniFile *ini = new TIniFile(IniFileName());
  __try
  {
    fnDatabaseMaster->Text = ini->ReadString("Databases","MasterDB","");
    fnDatabaseTarget->Text = ini->ReadString("Databases","TargetDB","");
    fnScriptMaster->Text = ini->ReadString("Databases","MasterScript","");
    fnScriptTarget->Text = ini->ReadString("Databases","TargetScript","");
    bool MFromD = ini->ReadBool("Databases","MasterFromDatabase",true);
    bool TFromD = ini->ReadBool("Databases","TargetFromDatabase",true);

    if (MFromD)
      rbMasterFromDatabase->Checked = true;
    else
      rbMasterFromScript->Checked = true;
    if (TFromD)
      rbTargetFromDatabase->Checked = true;
    else
      rbTargetFromScript->Checked = true;

    EditTableM->Text = ini->ReadString("TableDataComparer","TableNameMaster", "");
    EditTableT->Text = ini->ReadString("TableDataComparer","TableNameTarget", "");
    cbCompareMode->ItemIndex = ini->ReadInteger("TableDataComparer","DataCompareMode", 0);
    cbCompareModeChange(cbCompareMode);
    EditCustomFlds->Text = ini->ReadString("TableDataComparer","CustomKeyFields", "");
    EditExclFlds->Text = ini->ReadString("TableDataComparer","ExcludeDataFields", "");
  }
  __finally
  {
    delete ini;
  }
  rbFromClick(NULL);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BtnSelFileClick(TObject *Sender)
{
  if ((Sender == BtnSelDatabaseMaster) || (Sender == BtnSelDatabaseTarget))
  {
    OpenDialog1->Filter = "InterBase Databases (*.GDB)|*.gdb|All Files (*.*)|*.*";
  }
  if ((Sender == BtnSelScriptMaster) || (Sender == BtnSelScriptTarget))
  {
    OpenDialog1->Filter = "SQL Script (*.SQL)|*.sql|SQL Script (*.DDL)|*.ddl|All Files (*.*)|*.*";
  }
  if (OpenDialog1->Execute())
  {
    if (Sender == BtnSelDatabaseMaster)
      fnDatabaseMaster->Text = OpenDialog1->FileName;
    if (Sender == BtnSelDatabaseTarget)
      fnDatabaseTarget->Text = OpenDialog1->FileName;
    if (Sender == BtnSelScriptMaster)
      fnScriptMaster->Text = OpenDialog1->FileName;
    if (Sender == BtnSelScriptTarget)
      fnScriptTarget->Text = OpenDialog1->FileName;
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BtnExtractClick(TObject *Sender)
{
  BtnExtract->Enabled = false;
  if (rbTargetFromDatabase->Checked)
    ExtractTargetDatabase();
  if (rbTargetFromScript->Checked)
    ExtractTargetScript();
  if (rbMasterFromDatabase->Checked)
    ExtractMasterDatabase();
  if (rbMasterFromScript->Checked)
    ExtractMasterScript();
  BtnExtract->Enabled = true;
  MemoExtr->Lines->Add("< Extract finished. >");
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormDestroy(TObject *Sender)
{
  TIniFile *ini = new TIniFile(IniFileName());
  __try
  {
    ini->WriteString("Databases", "MasterDB", fnDatabaseMaster->Text);
    ini->WriteString("Databases", "TargetDB", fnDatabaseTarget->Text);
    ini->WriteString("Databases", "MasterScript", fnScriptMaster->Text);
    ini->WriteString("Databases", "TargetScript", fnScriptTarget->Text);
    ini->WriteBool("Databases","MasterFromDatabase",rbMasterFromDatabase->Checked);
    ini->WriteBool("Databases","TargetFromDatabase",rbTargetFromDatabase->Checked);
    ini->WriteString("TableDataComparer","TableNameMaster", EditTableM->Text);
    ini->WriteString("TableDataComparer","TableNameTarget", EditTableT->Text);
    ini->WriteInteger("TableDataComparer","DataCompareMode", cbCompareMode->ItemIndex);
    ini->WriteString("TableDataComparer","CustomKeyFields", EditCustomFlds->Text);
    ini->WriteString("TableDataComparer","ExcludeDataFields", EditExclFlds->Text);
  }
  __finally
  {
    delete ini;
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::LogNextLine(TObject *Sender, UnicodeString LogLine)
{
  MemoExtr->Lines->Add(LogLine);
  MemoExtr->Perform(EM_SCROLLCARET, 0, 0);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BtnCompareClick(TObject *Sender)
{
  MemoResult->Lines->Clear();
  BtnCompare->Enabled = false;
  try
  {
    DBComparer1->CompareDatabases();
    MemoResult->Lines->BeginUpdate();
    DBComparer1->SQLExec->GetScript(MemoResult->Lines);
    MemoResult->Lines->EndUpdate();
  }
  catch (Exception &E)
  {
    Dialogs::ShowMessage(E.Message);
    MemoResult->Lines->Add("Error: " + E.Message);
  }
  MemoExtr->Lines->Add("< Compare finished. >");
  BtnCompare->Enabled = true;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::rbFromClick(TObject *Sender)
{
  if (rbMasterFromDatabase->Checked)
  {
    fnDatabaseMaster->Enabled = true;
    BtnSelDatabaseMaster->Enabled = true;
    fnScriptMaster->Enabled = false;
    BtnSelScriptMaster->Enabled = false;
    EditMUser->Enabled = true;
    EditMPswd->Enabled = true;
    LabelMUser->Enabled = true;
    LabelMPswd->Enabled = true;
    fnDatabaseMaster->Color = clWindow;
    fnScriptMaster->Color = clBtnFace;
  } else
  {
    fnDatabaseMaster->Enabled = false;
    BtnSelDatabaseMaster->Enabled = false;
    fnScriptMaster->Enabled = true;
    BtnSelScriptMaster->Enabled = true;
    EditMUser->Enabled = false;
    EditMPswd->Enabled = false;
    LabelMUser->Enabled = false;
    LabelMPswd->Enabled = false;
    fnDatabaseMaster->Color = clBtnFace;
    fnScriptMaster->Color = clWindow;
  }
  if (rbTargetFromDatabase->Checked)
  {
    fnDatabaseTarget->Enabled = true;
    BtnSelDatabaseTarget->Enabled = true;
    fnScriptTarget->Enabled = false;
    BtnSelScriptTarget->Enabled = false;
    EditTUser->Enabled = true;
    EditTPswd->Enabled = true;
    LabelTUser->Enabled = true;
    LabelTPswd->Enabled = true;
    fnDatabaseTarget->Color = clWindow;
    fnScriptTarget->Color = clBtnFace;
  } else
  {
    fnDatabaseTarget->Enabled = false;
    BtnSelDatabaseTarget->Enabled = false;
    fnScriptTarget->Enabled = true;
    BtnSelScriptTarget->Enabled = true;
    EditTUser->Enabled = false;
    EditTPswd->Enabled = false;
    LabelTUser->Enabled = false;
    LabelTPswd->Enabled = false;
    fnDatabaseTarget->Color = clBtnFace;
    fnScriptTarget->Color = clWindow;
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ProgressUpdate(TObject *Sender, int Value, int MaxValue)
{
  Gauge1->Max = MaxValue;
  Gauge1->Position = Value;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BtnUpdateClick(TObject *Sender)
{
  IBSQLExec->ExecuteScript();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BtnDataCompareClick(TObject *Sender)
{
  if ((!rbMasterFromDatabase->Checked) || (!rbTargetFromDatabase->Checked))
  {
    Dialogs::ShowMessage("Table data comparer find differences only in database-tables...");
    rbMasterFromDatabase->Checked = true;
    rbTargetFromDatabase->Checked = true;
    rbFromClick(NULL);
    return;
  }
  
  TableDataComparer->TableNameMaster = EditTableM->Text;
  TableDataComparer->TableNameTarget = EditTableT->Text;
  DecodeFields(EditCustomFlds->Text, TableDataComparer->CustomKeyFields);
  DecodeFields(EditExclFlds->Text, TableDataComparer->ExcludeDataFields);
  IBSQLExec->Clear();
  MemoResult->Clear();
  
  if (TableDataComparer->CompareData())
  {
    IBSQLExec->GetScript(MemoResult->Lines);
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::EditTableMChange(TObject *Sender)
{
  EditTableT->Text = EditTableM->Text;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::TableDataComparerProgressUpdateMaster(TObject *Sender, int Value, int MaxValue)
{
  Gauge1->Max = MaxValue;
  Gauge1->Position = Value;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::TableDataComparerProgressUpdateTarget(TObject *Sender, int Value, int MaxValue)
{
  Gauge2->Max = MaxValue;
  Gauge2->Position = Value;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::cbCompareModeChange(TObject *Sender)
{
  EditCustomFlds->Enabled = cbCompareMode->ItemIndex == 3;
  LabelCustomFlds->Enabled = cbCompareMode->ItemIndex == 3;
}
//---------------------------------------------------------------------------

UnicodeString __fastcall CheckUpper(UnicodeString fldName)
{
  if ((fldName.Length() > 0) && (
    ((fldName[1] >= 'a') && (fldName[1] <= 'z'))
    || ((fldName[1] >= 'A') && (fldName[1] <= 'Z'))))
  {
    return AnsiUpperCase(fldName);
  }
  return fldName;
}

void __fastcall TForm1::DecodeFields(UnicodeString aFlds, TStrings *aFields)
{
  aFields->Clear();
  UnicodeString s = aFlds;
  UnicodeString FldName;

  int p = s.Pos(",");
  while (p > 0)
  {
    FldName = s.SubString(1, p - 1).Trim();
    if (FldName != "")
      aFields->Add(CheckUpper(FldName));

    s.Delete(1, p);
    p = s.Pos(",");
  }
  
  FldName = s.Trim();
  if (FldName != "")
    aFields->Add(CheckUpper(FldName));
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ExtractMasterDatabase()
{
  bool ErrFlg = false;
  try
  {
    DataMd->DBCConnection1->Connected = true;
  }
  catch (Exception &E)
  {
    Dialogs::ShowMessage(E.Message);
    MemoExtr->Lines->Add("Error: " + E.Message);
    ErrFlg = true;
	DataMd->UniConnection1->Connected = false;
  }
  if (ErrFlg) return;

  MemoExtr->Lines->Add("Database: " + fnDatabaseMaster->Text + " open.");
  DBStructure1->Clear();
  IBDBExtract1->ExtractDatabase();
  DataMd->DBCConnection1->Connected = false;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ExtractTargetDatabase()
{
  bool ErrFlg = false;
  try
  {
	DataMd->DBCConnection2->Connected = true;
  }
  catch (Exception &E)
  {
	Dialogs::ShowMessage(E.Message);
	MemoExtr->Lines->Add("Error: " + E.Message);
	ErrFlg = true;
	DataMd->UniConnection2->Connected = false;
  }
  if (ErrFlg) return;

  MemoExtr->Lines->Add("Database: " + fnDatabaseTarget->Text + " open.");
  DBStructure2->Clear();
  IBDBExtract2->ExtractDatabase();
  DataMd->DBCConnection2->Connected = false;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ExtractMasterScript()
{
  IBScriptExtract1->ScriptFileName = fnScriptMaster->Text;
  IBScriptExtract1->ExtractDatabase();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ExtractTargetScript()
{
  IBScriptExtract2->ScriptFileName = fnScriptTarget->Text;
  IBScriptExtract2->ExtractDatabase();
}
//---------------------------------------------------------------------------



