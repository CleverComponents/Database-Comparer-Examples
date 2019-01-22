//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1Fib.h"
#include "IBDataModuleFib.h"
#include <inifiles.hpp>

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "dbcClasses"
#pragma link "dbcConnection_FIB"
#pragma link "dbcCustomScriptExtract"
#pragma link "dbcDBComparer"
#pragma link "dbcDBEngine"
#pragma link "dbcDBStructure"
#pragma link "dbcIBDatabaseExtract"
#pragma link "dbcIBScriptExtract"
#pragma link "dbcIBSQLExec"
#pragma link "dbcSQL_Exec"
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
//---------------------------------------------------------------------------

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
  MemoExtr->Lines->Add("< Extract finished-> >");
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
    ShowMessage(E.Message);
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
  IBSQLExec1->ExecuteScript();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ExtractMasterDatabase()
{
  DataMdFib->IBDatabase1->DatabaseName = fnDatabaseMaster->Text;
  DataMdFib->IBDatabase1->ConnectParams->UserName = EditMUser->Text;
  DataMdFib->IBDatabase1->ConnectParams->Password = EditMPswd->Text;

  bool ErrFlg = false;
  try
  {
    DataMdFib->IBDatabase1->Connected = true;
  }
  catch (Exception &E)
  {
    Dialogs::ShowMessage(E.Message);
    MemoExtr->Lines->Add("Error: " + E.Message);
    ErrFlg = true;
    DataMdFib->IBDatabase1->Connected = false;
  }
  if (ErrFlg) return;
  
  MemoExtr->Lines->Add("Database: " + DataMdFib->IBDatabase1->DatabaseName + " open.");
  DBStructure1->Clear();
  IBDBExtract1->ExtractDatabase();
  DataMdFib->IBDatabase1->Connected = false;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ExtractTargetDatabase()
{
  DataMdFib->IBDatabase2->DatabaseName = fnDatabaseTarget->Text;
  DataMdFib->IBDatabase2->ConnectParams->UserName = EditTUser->Text;
  DataMdFib->IBDatabase2->ConnectParams->Password = EditTPswd->Text;
  
  bool ErrFlg = false;
  try
  {
    DataMdFib->IBDatabase2->Connected = true;
  }
  catch (Exception &E)
  {
    Dialogs::ShowMessage(E.Message);
    MemoExtr->Lines->Add("Error: " + E.Message);
    ErrFlg = true;
    DataMdFib->IBDatabase2->Connected = false;
  }
  if (ErrFlg) return;

  MemoExtr->Lines->Add("Database: " + DataMdFib->IBDatabase2->DatabaseName + " open.");
  DBStructure2->Clear();
  IBDBExtract2->ExtractDatabase();
  DataMdFib->IBDatabase2->Connected = false;
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


