//---------------------------------------------------------------------------

#ifndef TableDataComparerFormH
#define TableDataComparerFormH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include "dbcClasses.hpp"
#include "dbcDBEngine.hpp"
#include "dbcIBSQLExec.hpp"
#include "dbcMSSQLExec.hpp"
#include "dbcSQL_Exec.hpp"
#include "dbcTableDataComparer.hpp"
#include <Dialogs.hpp>
#include <DB.hpp>
#include <DBTables.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
	TLabel *Label1;
	TLabel *Label2;
	TLabel *Label3;
	TLabel *LabelUserM;
	TLabel *LabelPswdM;
	TLabel *LabelServerM;
	TLabel *Label7;
	TLabel *LabelUserT;
	TLabel *LabelPswdT;
	TLabel *LabelServerT;
	TLabel *Label11;
	TLabel *Label12;
	TBevel *Bevel1;
	TRichEdit *MemoScript;
	TRichEdit *MemoLog;
	TProgressBar *ProgressBarM;
	TPanel *Panel2;
	TRadioButton *rbMIB;
	TRadioButton *rbMMS;
	TEdit *EditDBNameM;
	TEdit *EditUserM;
	TEdit *EditPswdM;
	TCheckBox *cbAuthM;
	TEdit *EditServerM;
	TPanel *Panel1;
	TRadioButton *rbTIB;
	TRadioButton *rbTMS;
	TProgressBar *ProgressBarT;
	TEdit *EditDBNameT;
	TEdit *EditUserT;
	TEdit *EditPswdT;
	TCheckBox *cbAuthT;
	TEdit *EditServerT;
	TBitBtn *BtnCompare;
	TBitBtn *BtnUpdate;
	TEdit *EditTableM;
	TEdit *EditTableT;
	TTableDataComparer *TableDataComparer;
	TDBCConnection *DBCConnectionM;
	TDBCConnection *DBCConnectionT;
	TIBSQLExec *IBSQLExec;
	TMSSQLExec *MSSQLExec;
	TOpenDialog *OpenDialog;
	TQuery *Query1;
	TDatabase *Database1;
	void __fastcall LogErrorMessage(TObject *Sender, UnicodeString ErrText);
	void __fastcall LogNextLine(TObject *Sender, UnicodeString LogText);
	void __fastcall TableDataComparerProgressUpdateMaster(TObject *Sender, int Value,
          int MaxValue);
	void __fastcall TableDataComparerProgressUpdateTarget(TObject *Sender, int Value,
          int MaxValue);
	void __fastcall BtnCompareClick(TObject *Sender);
	void __fastcall BtnUpdateClick(TObject *Sender);
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall FormDestroy(TObject *Sender);
	void __fastcall rbMClick(TObject *Sender);
	void __fastcall rbTClick(TObject *Sender);



private:	// User declarations
  TDatabaseType __fastcall GetDBTypeM();
  TDatabaseType __fastcall GetDBTypeT();
  void __fastcall SetDBTypeM(TDatabaseType aType);
  void __fastcall SetDBTypeT(TDatabaseType aType);
public:		// User declarations
	__fastcall TForm1(TComponent* Owner);
  void __fastcall AddToLog(UnicodeString aText);
  __property TDatabaseType DatabaseTypeM = {read=GetDBTypeM};
  __property TDatabaseType DatabaseTypeT = {read=GetDBTypeT};
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
