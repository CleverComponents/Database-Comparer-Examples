//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1Ado.h"
#include "DataModuleAdo.h"
#include <inifiles.hpp>

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "dbcClasses"
#pragma link "dbcConnection_ADO"
#pragma link "dbcCustomScriptExtract"
#pragma link "dbcDBComparer"
#pragma link "dbcDBEngine"
#pragma link "dbcDBStructure"
#pragma link "dbcMSSQLDatabaseExtract"
#pragma link "dbcMSSQLExec"
#pragma link "dbcMSSQLScriptExtract"
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

UnicodeString __fastcall AdoConnectString(bool WinAuth,
  UnicodeString HostName, UnicodeString DbName, UnicodeString UserName, UnicodeString Password)
{
  UnicodeString Result = "Provider=SQLOLEDB;Initial Catalog=" + DbName + ";";
  if (HostName != "")
    Result += "Data Source=" + HostName + ";";
  if (WinAuth)
  {
    Result += "Integrated Security=SSPI;Persist Security Info=False;";
  } else
  {
    Result += "Persist Security Info=True;";
    if (UserName != "")
      Result += "User ID=" + UserName + ";";
    if (Password != "")
      Result += "Password=" + Password + ";";
  }
  return Result;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender)
{
  EditDbMaster->Text = "";
  EditDbTarget->Text = "";
  fnScriptMaster->Text = "";
  fnScriptTarget->Text = "";
  MemoLog->Clear();
  MemoResult->Clear();
  
  TIniFile *ini = new TIniFile(IniFileName());
  __try
  {
    EditDbMaster->Text = ini->ReadString("Databases","MasterDBMS","");
    EditDbTarget->Text = ini->ReadString("Databases","TargetDBMS","");
    fnScriptMaster->Text = ini->ReadString("Databases","MasterScriptMS","");
    fnScriptTarget->Text = ini->ReadString("Databases","TargetScriptMS","");
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
    OpenDialog1->Filter = "All Files (*.*)|*.*";
  }
  if ((Sender == BtnSelScriptMaster) || (Sender == BtnSelScriptTarget))
  {
    OpenDialog1->Filter = "SQL Script (*.SQL)|*.sql|SQL Script (*.DDL)|*.ddl|All Files (*.*)|*.*";
  }
  if (OpenDialog1->Execute())
  {
    if (Sender == BtnSelDatabaseMaster)
      EditDbMaster->Text = OpenDialog1->FileName;
    if (Sender == BtnSelDatabaseTarget)
      EditDbTarget->Text = OpenDialog1->FileName;
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
  AddToLog("< Extracting finished. >");
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormDestroy(TObject *Sender)
{
  TIniFile *ini = new TIniFile(IniFileName());
  __try
  {
    ini->WriteString("Databases", "MasterDBMS", EditDbMaster->Text);
    ini->WriteString("Databases", "TargetDBMS", EditDbTarget->Text);
    ini->WriteString("Databases", "MasterScriptMS", fnScriptMaster->Text);
    ini->WriteString("Databases", "TargetScriptMS", fnScriptTarget->Text);
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
  AddToLog(LogLine);
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
  AddToLog("< Comparing finished. >");
  BtnCompare->Enabled = true;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::rbFromClick(TObject *Sender)
{
  if (rbMasterFromDatabase->Checked)
  {
    EditDbMaster->Enabled = true;
//    BtnSelDatabaseMaster->Enabled = true;
    fnScriptMaster->Enabled = false;
    BtnSelScriptMaster->Enabled = false;
    EditMUser->Enabled = true;
    EditMPswd->Enabled = true;
    LabelMUser->Enabled = true;
    LabelMPswd->Enabled = true;
    LabelSrvM->Enabled = true;
    EditHostM->Enabled = true;
    LabelAuthM->Enabled = true;
    rbMWin->Enabled = true;
    rbMSql->Enabled = true;
  } else
  {
    EditDbMaster->Enabled = false;
    BtnSelDatabaseMaster->Enabled = false;
    fnScriptMaster->Enabled = true;
    BtnSelScriptMaster->Enabled = true;
    EditMUser->Enabled = false;
    EditMPswd->Enabled = false;
    LabelMUser->Enabled = false;
    LabelMPswd->Enabled = false;
    LabelSrvM->Enabled = false;
    EditHostM->Enabled = false;
    LabelAuthM->Enabled = false;
    rbMWin->Enabled = false;
    rbMSql->Enabled = false;
  }
  if (rbTargetFromDatabase->Checked)
  {
    EditDbTarget->Enabled = true;
//    BtnSelDatabaseTarget->Enabled = true;
    fnScriptTarget->Enabled = false;
    BtnSelScriptTarget->Enabled = false;
    EditTUser->Enabled = true;
    EditTPswd->Enabled = true;
    LabelTUser->Enabled = true;
    LabelTPswd->Enabled = true;
    LabelSrvT->Enabled = true;
    EditHostT->Enabled = true;
    LabelAuthT->Enabled = true;
    rbTWin->Enabled = true;
    rbTSql->Enabled = true;
  } else
  {
    EditDbTarget->Enabled = false;
    BtnSelDatabaseTarget->Enabled = false;
    fnScriptTarget->Enabled = true;
    BtnSelScriptTarget->Enabled = true;
    EditTUser->Enabled = false;
    EditTPswd->Enabled = false;
    LabelTUser->Enabled = false;
    LabelTPswd->Enabled = false;
    LabelSrvT->Enabled = false;
    EditHostT->Enabled = false;
    LabelAuthT->Enabled = false;
    rbTWin->Enabled = false;
    rbTSql->Enabled = false;
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
  MSSQLExec1->ExecuteScript();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::AddToLog(UnicodeString aText)
{
  MemoLog->Lines->Add(aText);
  MemoLog->Perform(EM_SCROLLCARET, 0, 0);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ExtractMasterDatabase()
{
  DataMdMS->ADOConnection1->Provider = "SQLOLEDB";
  DataMdMS->ADOConnection1->ConnectionString = AdoConnectString(rbMWin->Checked,
                                     EditHostM->Text,
                                     EditDbMaster->Text,
                                     EditMUser->Text,
                                     EditMPswd->Text);
  bool ErrFlg = false;
  try
  {
    DataMdMS->ADOConnection1->Connected = true;
  }
  catch (Exception &E)
  {
    Dialogs::ShowMessage(E.Message);
    AddToLog("Error: " + E.Message);
    ErrFlg = true;
    DataMdMS->ADOConnection1->Connected = false;
  }
  if (ErrFlg) return;

  AddToLog("Database: " + EditDbMaster->Text + " opened.");
  DBStructure1->Clear();
  MSSQLDBExtract1->ExtractDatabase();
  DataMdMS->ADOConnection1->Connected = false;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ExtractTargetDatabase()
{
  DataMdMS->ADOConnection2->Provider = "SQLOLEDB";
  DataMdMS->ADOConnection2->ConnectionString = AdoConnectString(rbTWin->Checked,
                                     EditHostT->Text,
                                     EditDbTarget->Text,
                                     EditTUser->Text,
                                     EditTPswd->Text);
  bool ErrFlg = false;
  try
  {
    DataMdMS->ADOConnection2->Connected = true;
  }
  catch (Exception &E)
  {
    Dialogs::ShowMessage(E.Message);
    AddToLog("Error: " + E.Message);
    ErrFlg = true;
    DataMdMS->ADOConnection2->Connected = false;
  }
  if (ErrFlg) return;

  AddToLog("Database: " + EditDbTarget->Text + " opened.");
  DBStructure2->Clear();
  MSSQLDBExtract2->ExtractDatabase();
  DataMdMS->ADOConnection2->Connected = false;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ExtractMasterScript()
{
  MSSQLScriptExtract1->ScriptFileName = fnScriptMaster->Text;
  MSSQLScriptExtract1->ExtractDatabase();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ExtractTargetScript()
{
  MSSQLScriptExtract2->ScriptFileName = fnScriptTarget->Text;
  MSSQLScriptExtract2->ExtractDatabase();
}
//---------------------------------------------------------------------------


