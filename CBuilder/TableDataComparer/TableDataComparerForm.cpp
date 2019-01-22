//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "TableDataComparerForm.h"
#include <inifiles.hpp>

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "dbcClasses"
#pragma link "dbcDBEngine"
#pragma link "dbcIBSQLExec"
#pragma link "dbcMSSQLExec"
#pragma link "dbcSQL_Exec"
#pragma link "dbcTableDataComparer"
#pragma link "dbcConnection_ADODB"
#pragma link "dbcConnection_IBXDB"
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
void __fastcall TForm1::LogErrorMessage(TObject *Sender, UnicodeString ErrText)

{
  AddToLog(ErrText);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::LogNextLine(TObject *Sender, UnicodeString LogText)

{
  AddToLog(LogText);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::TableDataComparerProgressUpdateMaster(TObject *Sender, int Value,
          int MaxValue)
{
  ProgressBarM->Max = MaxValue;
  ProgressBarM->Position = Value;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::TableDataComparerProgressUpdateTarget(TObject *Sender, int Value,
          int MaxValue)
{
  ProgressBarT->Max = MaxValue;
  ProgressBarT->Position = Value;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BtnCompareClick(TObject *Sender)
{
  switch (DatabaseTypeM)
  {
    case dbInterBase:
      DBCConnectionM->ConnectionType = cnIBX;
      if (EditServerM->Text != "")
        DBCConnectionM->ConnectionOptions->Protocol = ptTCP;
      else
        DBCConnectionM->ConnectionOptions->Protocol = ptLocal;
      break;
    case dbMSSQL:
      DBCConnectionM->ConnectionType = cnADO;
      break;
  }

  DBCConnectionM->DatabaseType = DatabaseTypeM;

  switch (DatabaseTypeT)
  {
    case dbInterBase:
      DBCConnectionT->ConnectionType = cnIBX;
      if (EditServerT->Text != "")
        DBCConnectionT->ConnectionOptions->Protocol = ptTCP;
      else
        DBCConnectionT->ConnectionOptions->Protocol = ptLocal;
      TableDataComparer->SQLExec = IBSQLExec;
      break;
    case dbMSSQL:
      DBCConnectionT->ConnectionType = cnADO;
      TableDataComparer->SQLExec = MSSQLExec;
      break;
  }

  DBCConnectionT->DatabaseType = DatabaseTypeT;
  DBCConnectionM->ConnectionOptions->DatabaseName = EditDBNameM->Text;
  DBCConnectionM->ConnectionOptions->HostName = EditServerM->Text;
  DBCConnectionM->ConnectionOptions->UserName = EditUserM->Text;
  DBCConnectionM->ConnectionOptions->Password = EditPswdM->Text;
  DBCConnectionM->ConnectionOptions->UseWindowsAuthentication = cbAuthM->Checked;

  DBCConnectionT->ConnectionOptions->DatabaseName = EditDBNameT->Text;
  DBCConnectionT->ConnectionOptions->HostName = EditServerT->Text;
  DBCConnectionT->ConnectionOptions->UserName = EditUserT->Text;
  DBCConnectionT->ConnectionOptions->Password = EditPswdT->Text;
  DBCConnectionT->ConnectionOptions->UseWindowsAuthentication = cbAuthT->Checked;

  // tables
  TableDataComparer->TableNameMaster = EditTableM->Text;
  TableDataComparer->TableNameTarget = EditTableT->Text;
  // run comparing
  MemoScript->Lines->Clear();
  if (TableDataComparer->CompareData())
  {
    TableDataComparer->SQLExec->GetScript(MemoScript->Lines);
    AddToLog("< Comparing finished. >");
  } else
  {
    AddToLog("< Comparing finished abnormally! >");
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BtnUpdateClick(TObject *Sender)
{
  if (TableDataComparer->SQLExec)
  {
    DBCConnectionT->Connected = true;
    TableDataComparer->SQLExec->ExecuteScript();
    DBCConnectionT->Connected = false;
  }
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormCreate(TObject *Sender)
{
  TIniFile *ini = new TIniFile(IniFileName());
  __try
  {
    try
    {
      int dbType = ini->ReadInteger("Databases", "DatabaseTypeM", (int)dbInterBase);
      SetDBTypeM((TDatabaseType)dbType);
      dbType = ini->ReadInteger("Databases", "DatabaseTypeT", (int)dbInterBase);
      SetDBTypeT((TDatabaseType)dbType);
    }
    catch (...) {}

    rbMClick(NULL);
    rbTClick(NULL);

    EditDBNameM->Text = ini->ReadString("Databases","DBNameM","");
    EditDBNameT->Text = ini->ReadString("Databases","DBNameT","");
    EditServerM->Text = ini->ReadString("Databases","HostNameM","");
    EditServerT->Text = ini->ReadString("Databases","HostNameT","");
    EditUserM->Text = ini->ReadString("Databases","UserNameM","");
    EditUserT->Text = ini->ReadString("Databases","UserNameT","");
    EditPswdM->Text = ini->ReadString("Databases","PasswordM","");
    EditPswdT->Text = ini->ReadString("Databases","PasswordT","");
    cbAuthM->Checked = ini->ReadBool("Databases", "WinAuthenticationM", false);
    cbAuthT->Checked = ini->ReadBool("Databases", "WinAuthenticationT", false);
    EditTableM->Text = ini->ReadString("Databases","TableNameM","");
    EditTableT->Text = ini->ReadString("Databases","TableNameT","");
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
    try
    {
      ini->WriteInteger("Databases", "DatabaseTypeM", (int)GetDBTypeM());
    }
    catch (...) {}
    try
    {
      ini->WriteInteger("Databases", "DatabaseTypeT", (int)GetDBTypeT());
    }
    catch (...) {}
    ini->WriteString("Databases", "DBNameM", EditDBNameM->Text);
    ini->WriteString("Databases", "DBNameT", EditDBNameT->Text);
    ini->WriteString("Databases", "HostNameM", EditServerM->Text);
    ini->WriteString("Databases", "HostNameT", EditServerT->Text);
    ini->WriteString("Databases", "UserNameM", EditUserM->Text);
    ini->WriteString("Databases", "UserNameT", EditUserT->Text);
    ini->WriteString("Databases", "PasswordM", EditPswdM->Text);
    ini->WriteString("Databases", "PasswordT", EditPswdT->Text);
    ini->WriteBool("Databases", "WinAuthenticationM", cbAuthM->Checked);
    ini->WriteBool("Databases", "WinAuthenticationT", cbAuthT->Checked);
    ini->WriteString("Databases", "TableNameM", EditTableM->Text);
    ini->WriteString("Databases", "TableNameT", EditTableT->Text);
  }
  __finally
  {
    delete ini;
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::rbMClick(TObject *Sender)
{
  if (rbMIB->Checked)
  {
    EditUserM->Text = "SYSDBA";
    EditPswdM->Text = "masterkey";
  } else
  {
    EditUserM->Text = "";
    EditPswdM->Text = "";
  }
  if (Sender != cbAuthM)
    cbAuthM->Checked = rbMMS->Checked;
  cbAuthM->Enabled = rbMMS->Checked;

  bool LoginEnabled = rbMIB->Checked || (rbMMS->Checked && !cbAuthM->Checked);
  EditUserM->Enabled = LoginEnabled;
  EditPswdM->Enabled = LoginEnabled;
  LabelUserM->Enabled = LoginEnabled;
  LabelPswdM->Enabled = LoginEnabled;
  LabelServerM->Enabled = rbMIB->Checked || rbMMS->Checked;
  EditServerM->Enabled = rbMIB->Checked || rbMMS->Checked;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::rbTClick(TObject *Sender)
{
  if (rbTIB->Checked)
  {
    EditUserT->Text = "SYSDBA";
    EditPswdT->Text = "masterkey";
  } else
  {
    EditUserT->Text = "";
    EditPswdT->Text = "";
  }
  if (Sender != cbAuthT)
    cbAuthT->Checked = rbTMS->Checked;
  cbAuthT->Enabled = rbTMS->Checked;

  bool LoginEnabled = rbTIB->Checked || (rbTMS->Checked && !cbAuthT->Checked);
  EditUserT->Enabled = LoginEnabled;
  EditPswdT->Enabled = LoginEnabled;
  LabelUserT->Enabled = LoginEnabled;
  LabelPswdT->Enabled = LoginEnabled;
  LabelServerT->Enabled = rbTIB->Checked || rbTMS->Checked;
  EditServerT->Enabled = rbTIB->Checked || rbTMS->Checked;
}
//---------------------------------------------------------------------------

TDatabaseType __fastcall TForm1::GetDBTypeM()
{
  if (rbMMS->Checked)
    return dbMSSQL;
  return dbInterBase;
}
//---------------------------------------------------------------------------

TDatabaseType __fastcall TForm1::GetDBTypeT()
{
  if (rbTMS->Checked)
    return dbMSSQL;
  return dbInterBase;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::SetDBTypeM(TDatabaseType aType)
{
  switch (aType)
  {
    case dbMSSQL: rbMMS->Checked = true; break;
    default: rbMIB->Checked = true;
  }
}
//---------------------------------------------------------------------------
void __fastcall TForm1::SetDBTypeT(TDatabaseType aType)
{
  switch (aType)
  {
    case dbMSSQL: rbTMS->Checked = true; break;
    default: rbTIB->Checked = true;
  }
}
//---------------------------------------------------------------------------
void __fastcall TForm1::AddToLog(UnicodeString aText)
{
  MemoLog->Lines->Add(aText);
  MemoLog->Perform(EM_SCROLLCARET, 0, 0);
}
//---------------------------------------------------------------------------

