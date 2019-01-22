//---------------------------------------------------------------------------

#ifndef DataModuleAdoH
#define DataModuleAdoH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ADODB.hpp>
#include <DB.hpp>
//---------------------------------------------------------------------------
class TDataMdMS : public TDataModule
{
__published:	// IDE-managed Components
  TADOConnection *ADOConnection1;
  TADOConnection *ADOConnection2;
private:	// User declarations
public:		// User declarations
  __fastcall TDataMdMS(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TDataMdMS *DataMdMS;
//---------------------------------------------------------------------------
#endif
