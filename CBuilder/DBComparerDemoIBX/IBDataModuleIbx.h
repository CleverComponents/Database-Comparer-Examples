//---------------------------------------------------------------------------

#ifndef IBDataModuleIbxH
#define IBDataModuleIbxH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "dbcConnection_IBX.hpp"
#include "dbcDBEngine.hpp"
#include <DB.hpp>
#include <IBDatabase.hpp>
//---------------------------------------------------------------------------
class TDataMdIbx : public TDataModule
{
__published:	// IDE-managed Components
  TIBDatabase *IBDatabase1;
  TIBDatabase *IBDatabase2;
  TDBCConnectionIBX *DBCConnection1;
  TDBCConnectionIBX *DBCConnection2;
  void __fastcall DBCConnection1BeforeConnect(TObject *Sender);
  void __fastcall DBCConnection2BeforeConnect(TObject *Sender);
private:	// User declarations
public:		// User declarations
  __fastcall TDataMdIbx(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TDataMdIbx *DataMdIbx;
//---------------------------------------------------------------------------
#endif
