//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "LocalSqlForm.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "dbcClasses"
#pragma link "dbcConnection_BDE"
#pragma link "dbcDBEngine"
#pragma link "dbcLocalSQLExec"
#pragma link "dbcSQL_Exec"
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BitBtn1Click(TObject *Sender)
{
  if (OpenDialog->Execute())
  {
    EditFileName->Text = OpenDialog->FileName;
    if (FileExists(OpenDialog->FileName))
    {
      LocalSQLExec->LoadFromFile(OpenDialog->FileName);
      MemoScript->Lines->LoadFromFile(OpenDialog->FileName);
      MemoLog->Lines->Clear();
      AddToLog("Script loaded: " + IntToStr(LocalSQLExec->StatementsCount) + " statements.");
    } else
    {
      AddToLog("File not found: " + OpenDialog->FileName);
    }
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ShowErrorMessage(TObject *Sender, UnicodeString ErrText)
{
  AddToLog("Error: " + ErrText);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::LocalSQLExecLogNextLine(TObject *Sender, UnicodeString LogText)
{
  AddToLog(LogText);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BitBtn2Click(TObject *Sender)
{
  DBCConnectionBDE->Connected = true;
  LocalSQLExec->ExecuteScript();
  DBCConnectionBDE->Connected = false;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::LocalSQLExecProgressUpdate(TObject *Sender, int Value, int MaxValue)
{
  ProgressBar->Max = MaxValue;
  ProgressBar->Position = Value;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::AddToLog(UnicodeString aText)
{
  MemoLog->Lines->Add(aText);
  MemoLog->Perform(EM_SCROLLCARET, 0, 0);
}
//---------------------------------------------------------------------------


