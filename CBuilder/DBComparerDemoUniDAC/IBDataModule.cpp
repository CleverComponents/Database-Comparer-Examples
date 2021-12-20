//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "IBDataModule.h"
#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "dbcConnection_UniDAC"
#pragma link "dbcDBEngine"
#pragma link "DBAccess"
#pragma link "Uni"
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
  UniConnection1->ProviderName = "InterBase";
  UniConnection1->Username = Form1->EditMUser->Text;
  UniConnection1->Password = Form1->EditMPswd->Text;
  UniConnection1->Database = Form1->fnDatabaseMaster->Text;
}
//---------------------------------------------------------------------------

void __fastcall TDataMd::DBCConnection2BeforeConnect(TObject *Sender)
{
  UniConnection2->ProviderName = "InterBase";
  UniConnection2->Username = Form1->EditTUser->Text;
  UniConnection2->Password = Form1->EditTPswd->Text;
  UniConnection2->Database = Form1->fnDatabaseTarget->Text;
}
//---------------------------------------------------------------------------

