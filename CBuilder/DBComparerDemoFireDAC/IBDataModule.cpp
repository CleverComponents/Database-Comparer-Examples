//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "IBDataModule.h"
#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "dbcConnection_FireDAC"
#pragma link "dbcDBEngine"
#pragma link "FireDAC.DApt"
#pragma resource "*.dfm"
TDataMd *DataMd;
//---------------------------------------------------------------------------
__fastcall TDataMd::TDataMd(TComponent* Owner)
  : TDataModule(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TDataMd::DBCConnection1BeforeConnect(TObject *Sender)
{
  FDConnection1->Params->Clear();
  FDConnection1->DriverName = "FB";
  FDConnection1->Params->Add("Database=" + Form1->fnDatabaseMaster->Text);
  FDConnection1->Params->Add("User_Name=" + Form1->EditMUser->Text);
  FDConnection1->Params->Add("Password=" + Form1->EditMPswd->Text);
}
//---------------------------------------------------------------------------

void __fastcall TDataMd::DBCConnection2BeforeConnect(TObject *Sender)
{
  FDConnection2->Params->Clear();
  FDConnection2->DriverName = "FB";
  FDConnection2->Params->Add("Database=" + Form1->fnDatabaseTarget->Text);
  FDConnection2->Params->Add("User_Name=" + Form1->EditTUser->Text);
  FDConnection2->Params->Add("Password=" + Form1->EditTPswd->Text);
}
//---------------------------------------------------------------------------

