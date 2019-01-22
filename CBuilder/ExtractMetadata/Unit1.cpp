//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
#include <inifiles.hpp>

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "dbcClasses"
#pragma link "dbcDBEngine"
#pragma link "dbcDBStructure"
#pragma link "dbcIBDatabaseExtract"
#pragma link "dbcMSSQLDatabaseExtract"
#pragma link "dbcMySQLDatabaseExtract"
#pragma link "dbcConnection_IBXDB"
#pragma link "dbcConnection_ADODB"
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
TDatabaseType __fastcall TForm1::GetDBType()
{
  if (rbMMS->Checked)
    return Dbctypes::dbMSSQL;
  if (rbMMY->Checked)
    return Dbctypes::dbMySQL;
  return Dbctypes::dbInterBase;
}

//---------------------------------------------------------------------------
void __fastcall TForm1::SetDBType(TDatabaseType aType)
{
  switch (aType)
  {
    case Dbctypes::dbMSSQL: rbMMS->Checked = true; break;
    case Dbctypes::dbMySQL: rbMMY->Checked = true; break;
    default: rbMIB->Checked = true;
  }
}

//---------------------------------------------------------------------------
void __fastcall TForm1::AddToLog(UnicodeString aText)
{
  MemoLog->Lines->Add(aText);
  MemoLog->Perform(EM_SCROLLCARET, 0, 0);
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

void __fastcall TForm1::BtnExtractDbClick(TObject *Sender)
{
  BtnExtractDb->Enabled = false;
  BtnExtractDb->Update();
  
  TCustomExtract *Extractor = NULL;
  switch (this->DatabaseType)
  {
    case dbInterBase:
      DBCConnection->ConnectionType = cnIBX;
      if (EditServerM->Text != "")
        DBCConnection->ConnectionOptions->Protocol = ptTCP;
      else
        DBCConnection->ConnectionOptions->Protocol = ptLocal;
      Extractor = IBDBExtract;
      break;
    case dbMSSQL:
      DBCConnection->ConnectionType = cnADO;
      Extractor = MSSQLDBExtract;
      break;
    case dbMySQL:
      Extractor = MySQLDBExtract;
      break;
  }
  DBCConnection->DatabaseType = this->DatabaseType;
  DBCConnection->ConnectionOptions->DatabaseName = EditDBNameM->Text;
  DBCConnection->ConnectionOptions->HostName = EditServerM->Text;
  DBCConnection->ConnectionOptions->UserName = EditUserM->Text;
  DBCConnection->ConnectionOptions->Password = EditPswdM->Text;
  DBCConnection->ConnectionOptions->UseWindowsAuthentication = cbAuthM->Checked;

  // run extracting
  MemoScript->Lines->Clear();
  try
  {
    DBCConnection->Connected = true;
  }
  catch(Exception &E)
  {
    AddToLog(E.Message);
  }

  if (DBCConnection->Connected && Extractor->ExtractDatabase())
  {
    AddToLog("< Extracting finished. >");
    BtnExtractMetadata->Enabled = true;
    BtnExtractTable->Enabled = true;
  } else
  {
    AddToLog("< Extracting finished abnormally! >");
  }
  DBCConnection->Connected = false;
  BtnExtractDb->Enabled = true;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender)
{
  TIniFile *ini = new TIniFile(IniFileName());
  __try
  {
    try
    {
      int dbType = ini->ReadInteger("Databases", "DatabaseTypeM", (int)Dbctypes::dbInterBase);
      SetDBType((TDatabaseType)dbType);
    }
    catch (...) {}

    rbMClick(NULL);
    EditDBNameM->Text = ini->ReadString("Databases", "DBNameM", "");
    EditServerM->Text = ini->ReadString("Databases", "HostNameM", "");
    EditUserM->Text = ini->ReadString("Databases", "UserNameM", "");
    EditPswdM->Text = ini->ReadString("Databases", "PasswordM", "");
    cbAuthM->Checked = ini->ReadBool("Databases", "WinAuthenticationM", false);
    EditTableM->Text = ini->ReadString("Databases", "TableNameM", "");
  }
  __finally
  {
    delete ini;
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormDestroy(TObject *Sender)
{
  TIniFile *ini =new TIniFile(IniFileName());
  __try
  {
    try
    {
      ini->WriteInteger("Databases", "DatabaseTypeM", (int)GetDBType());
    }
    catch (...) {}
    
    ini->WriteString("Databases", "DBNameM", EditDBNameM->Text);
    ini->WriteString("Databases", "HostNameM", EditServerM->Text);
    ini->WriteString("Databases", "UserNameM", EditUserM->Text);
    ini->WriteString("Databases", "PasswordM", EditPswdM->Text);
    ini->WriteBool("Databases", "WinAuthenticationM", cbAuthM->Checked);
    ini->WriteString("Databases", "TableNameM", EditTableM->Text);
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

  bool LoginEnabled = rbMIB->Checked || rbMMY->Checked || (rbMMS->Checked && !cbAuthM->Checked);
  EditUserM->Enabled = LoginEnabled;
  EditPswdM->Enabled = LoginEnabled;
  LabelUserM->Enabled = LoginEnabled;
  LabelPswdM->Enabled = LoginEnabled;
  LabelServerM->Enabled = rbMIB->Checked || rbMMS->Checked || rbMMY->Checked;
  EditServerM->Enabled = rbMIB->Checked || rbMMS->Checked || rbMMY->Checked;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BtnExtractMetadataClick(TObject *Sender)
{
  BtnExtractMetadata->Enabled = false;
  BtnExtractMetadata->Update();
  MemoScript->Clear();
  DBStructure->Metadata->ExtractMetadata(MemoScript->Lines);
  BtnExtractMetadata->Enabled = true;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BtnExtractTableClick(TObject *Sender)
{
  BtnExtractTable->Enabled = false;
  BtnExtractTable->Update();
  if (EditTableM->Text == "")
  {
    Dialogs::ShowMessage("Table name not specified.");
  } else
  {
    MemoScript->Clear();
    DBStructure->Metadata->ExtractTable(MemoScript->Lines, EditTableM->Text, DefCmpObjSet);
  }
  BtnExtractTable->Enabled = true;
}
//---------------------------------------------------------------------------


