//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "DataModuleAdo.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TDataMdMS *DataMdMS;
//---------------------------------------------------------------------------
__fastcall TDataMdMS::TDataMdMS(TComponent* Owner)
  : TDataModule(Owner)
{
}
//---------------------------------------------------------------------------
