//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "IBDataModuleIbx.h"
#include "Unit1Ibx.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "dbcConnection_IBX"
#pragma link "dbcDBEngine"
#pragma resource "*.dfm"
TDataMdIbx *DataMdIbx;
//---------------------------------------------------------------------------
__fastcall TDataMdIbx::TDataMdIbx(TComponent* Owner)
  : TDataModule(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TDataMdIbx::DBCConnection1BeforeConnect(TObject *Sender)
{
  IBDatabase1->DatabaseName = Form1->fnDatabaseMaster->Text;
  IBDatabase1->Params->Clear();
  IBDatabase1->Params->Add("user_name=" + Form1->EditMUser->Text);
  IBDatabase1->Params->Add("password=" + Form1->EditMPswd->Text);
}
//---------------------------------------------------------------------------

void __fastcall TDataMdIbx::DBCConnection2BeforeConnect(TObject *Sender)
{
  IBDatabase2->DatabaseName = Form1->fnDatabaseTarget->Text;
  IBDatabase2->Params->Clear();
  IBDatabase2->Params->Add("user_name=" + Form1->EditTUser->Text);
  IBDatabase2->Params->Add("password=" + Form1->EditTPswd->Text);
  IBDatabase2->LoginPrompt = (Form1->EditTUser->Text == "") || (Form1->EditTPswd->Text == "");
}
//---------------------------------------------------------------------------

