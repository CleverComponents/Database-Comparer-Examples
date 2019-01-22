//---------------------------------------------------------------------------

#ifndef IBDataModuleFibH
#define IBDataModuleFibH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <FIBDatabase.hpp>
#include <pFIBDatabase.hpp>
//---------------------------------------------------------------------------
class TDataMdFib : public TDataModule
{
__published:	// IDE-managed Components
  TpFIBDatabase *IBDatabase1;
  TpFIBDatabase *IBDatabase2;
private:	// User declarations
public:		// User declarations
  __fastcall TDataMdFib(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TDataMdFib *DataMdFib;
//---------------------------------------------------------------------------
#endif
