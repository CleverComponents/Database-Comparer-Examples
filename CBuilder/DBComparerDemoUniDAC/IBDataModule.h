//---------------------------------------------------------------------------

#ifndef IBDataModuleH
#define IBDataModuleH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "dbcConnection_UniDAC.hpp"
#include "dbcDBEngine.hpp"
#include <DB.hpp>
#include "DBAccess.hpp"
#include "Uni.hpp"
//---------------------------------------------------------------------------
class TDataMd : public TDataModule
{
__published:	// IDE-managed Components
  TDBCConnectionUniDAC *DBCConnection1;
  TDBCConnectionUniDAC *DBCConnection2;
	TUniConnection *UniConnection1;
	TUniConnection *UniConnection2;
  void __fastcall DBCConnection1BeforeConnect(TObject *Sender);
  void __fastcall DBCConnection2BeforeConnect(TObject *Sender);
private:	// User declarations
public:		// User declarations
  __fastcall TDataMd(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TDataMd *DataMd;
//---------------------------------------------------------------------------
#endif
