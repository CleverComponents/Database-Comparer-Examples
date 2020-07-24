//---------------------------------------------------------------------------

#ifndef DataModule1H
#define DataModule1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "dbcConnection_FireDAC.hpp"
#include "dbcDBEngine.hpp"
#include <DB.hpp>
#include <FireDAC.Comp.Client.hpp>
#include <FireDAC.Phys.hpp>
#include <FireDAC.Phys.Intf.hpp>
#include <FireDAC.Stan.Async.hpp>
#include <FireDAC.Stan.Def.hpp>
#include <FireDAC.Stan.Error.hpp>
#include <FireDAC.Stan.Intf.hpp>
#include <FireDAC.Stan.Option.hpp>
#include <FireDAC.Stan.Pool.hpp>
#include <FireDAC.UI.Intf.hpp>
#include <FireDAC.Phys.FB.hpp>
#include <FireDAC.Phys.FBDef.hpp>
#include <FireDAC.Phys.IBBase.hpp>
#include <FireDAC.Comp.UI.hpp>
#include <FireDAC.VCLUI.Wait.hpp>
//---------------------------------------------------------------------------
class TDataMd : public TDataModule
{
__published:	// IDE-managed Components
  TDBCConnectionFireDAC *DBCConnection1;
  TDBCConnectionFireDAC *DBCConnection2;
	TFDConnection *FDConnection1;
	TFDConnection *FDConnection2;
	TFDPhysFBDriverLink *FDPhysFBDriverLink1;
	TFDGUIxWaitCursor *FDGUIxWaitCursor1;
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
