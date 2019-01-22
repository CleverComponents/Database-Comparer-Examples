//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "IBDataModuleFib.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "FIBDatabase"
#pragma link "pFIBDatabase"
#pragma resource "*.dfm"
TDataMdFib *DataMdFib;
//---------------------------------------------------------------------------
__fastcall TDataMdFib::TDataMdFib(TComponent* Owner)
  : TDataModule(Owner)
{
}
//---------------------------------------------------------------------------
