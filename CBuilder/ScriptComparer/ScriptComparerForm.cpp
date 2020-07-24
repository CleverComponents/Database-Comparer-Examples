//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "ScriptComparerForm.h"
#include <inifiles.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "dbcClasses"
#pragma link "dbcCustomScriptExtract"
#pragma link "dbcDBComparer"
#pragma link "dbcDBStructure"
#pragma link "dbcIBScriptExtract"
#pragma link "dbcMSSQLScriptExtract"
#pragma link "dbcMySQLScriptExtract"
#pragma link "dbcOracleScriptExtract"
#pragma link "dbcASAScriptExtract"
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

void __fastcall TForm1::BtnSelClick(TObject *Sender)
{
  if ((Sender == BtnSelM) || (Sender == BtnSelT))
  {
    OpenDialog1->Filter = "SQL script (*.SQL)|*.sql|SQL script (*.DDL)|*.ddl|All files (*.*)|*.*";
  }
  if (OpenDialog1->Execute())
  {
    if (Sender == BtnSelM)
      fnScriptM->Text = OpenDialog1->FileName;
    if (Sender == BtnSelT)
      FnScriptT->Text = OpenDialog1->FileName;
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::DBComparerBeforeExtract(TObject *Sender)
{
  switch (GetDbType())
  {
    case dbInterBase:
      DBComparer->ExtractorMaster = IBScriptExtract;
      DBComparer->ExtractorTarget = IBScriptExtract;
      break;
    case dbSybaseASA:
      DBComparer->ExtractorMaster = SAWScriptExtract;
      DBComparer->ExtractorTarget = SAWScriptExtract;
      break;
    case dbMySQL:
      DBComparer->ExtractorMaster = MySQLScriptExtract;
      DBComparer->ExtractorTarget = MySQLScriptExtract;
      break;
    case dbOracle:
      DBComparer->ExtractorMaster = OracleScriptExtract;
      DBComparer->ExtractorTarget = OracleScriptExtract;
      break;
    case dbMSSQL:
      DBComparer->ExtractorMaster = MSSQLScriptExtract;
      DBComparer->ExtractorTarget = MSSQLScriptExtract;
      break;
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::DBComparerBeforeExtractMaster(TObject *Sender)
{
  TCustomScriptExtract *extract = dynamic_cast<TCustomScriptExtract *>(DBComparer->ExtractorMaster);

  extract->DBStructure = DBStructureMaster;
  extract->ScriptFileNames->Text = fnScriptM->Text;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::DBComparerBeforeExtractTarget(TObject *Sender)
{
  TCustomScriptExtract *extract = dynamic_cast<TCustomScriptExtract *>(DBComparer->ExtractorTarget);

  extract->DBStructure = DBStructureTarget;
  extract->ScriptFileNames->Text = FnScriptT->Text;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::DBComparerProgressUpdate(TObject *Sender, int Value, int MaxValue)
{
  ProgressBar->Max = MaxValue;
  ProgressBar->Position = Value;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BtnExtractClick(TObject *Sender)
{
  // extract metadata
  Screen->Cursor = crHourGlass;
  DBComparer->ExtractDatabases();
  MemoLog->SelAttributes->Color = clHotLight;
  AddToLog("< Extracting finished... >");

  if (DBComparer->MsgManager->IsErr)
  {
    MemoLog->SelAttributes->Color = clRed;
    AddToLog("Errors:");
    AddToLog(DBComparer->MsgManager->ErrSummary());
  }
  MemoLog->SelAttributes->Color = clWindowText;
  Screen->Cursor = crDefault;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BtnCompareClick(TObject *Sender)
{
  Screen->Cursor = crHourGlass;
  DBComparer->CompareDatabases();

  if (DBComparer->SQLExec)
  {
    MemoLog->SelAttributes->Color = clHotLight;
    AddToLog("< Comparing finished. Loading script... >");
    MemoScript->Lines->Clear();
    DBComparer->SQLExec->GetScript(MemoScript->Lines);
    AddToLog("< Process finished. >");
    MemoLog->SelAttributes->Color = clWindowText;
  }
  Screen->Cursor = crDefault;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::DBComparerLogNextLine(TObject *Sender, UnicodeString LogText)
{
  AddToLog(LogText);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::DBComparerErrorMessage(TObject *Sender, UnicodeString ErrText)
{
  MemoLog->Perform(EM_SCROLLCARET, 0, 0);
  MemoLog->SelAttributes->Color = clRed;
  AddToLog(ErrText);
  MemoLog->SelAttributes->Color = clWindowText;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender)
{
  TIniFile *ini = new TIniFile(IniFileName());
  __try
  {
    fnScriptM->Text = ini->ReadString("Databases", "MasterScript", "");
    FnScriptT->Text = ini->ReadString("Databases", "TargetScript", "");
    try
    {
      int dbType = ini->ReadInteger("Databases", "DatabaseType", (int)dbInterBase);
      SetDbType((TDatabaseType)dbType);
    }
    catch (...) {}
  }
  __finally
  {
    delete ini;
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormDestroy(TObject *Sender)
{
  TIniFile *ini = new TIniFile(IniFileName());
  __try
  {
    ini->WriteString("Databases", "MasterScript", fnScriptM->Text);
    ini->WriteString("Databases", "TargetScript", FnScriptT->Text);
    try
    {
      ini->WriteInteger("Databases", "DatabaseType", (int)GetDbType());
    }
    catch (...) {}
  }
  __finally
  {
    delete ini;
  }
}
//---------------------------------------------------------------------------

TDatabaseType __fastcall TForm1::GetDbType()
{
  if (rbSAW->Checked)
    return dbSybaseASA;
  if (rbMy->Checked)
    return dbMySQL;
  if (rbOra->Checked)
    return dbOracle;
  if (rbMS->Checked)
    return dbMSSQL;
  return dbInterBase;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::SetDbType(TDatabaseType aType)
{
  switch (aType)
  {
    case dbSybaseASA: rbSAW->Checked = true; break;
    case dbMySQL: rbMy->Checked = true; break;
    case dbOracle: rbOra->Checked = true; break;
    case dbMSSQL: rbMS->Checked = true; break;
    default: rbIB->Checked = true;
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::AddToLog(UnicodeString aText)
{
  MemoLog->Lines->Add(aText);
  MemoLog->Perform(EM_SCROLLCARET, 0, 0);
}
//---------------------------------------------------------------------------


