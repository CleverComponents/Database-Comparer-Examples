//---------------------------------------------------------------------------

#ifndef ScriptComparerFormH
#define ScriptComparerFormH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <dbcClasses.hpp>
#include <dbcCustomScriptExtract.hpp>
#include <dbcDBComparer.hpp>
#include <dbcDBStructure.hpp>
#include <dbcIBScriptExtract.hpp>
#include <dbcMSSQLScriptExtract.hpp>
#include <dbcMySQLScriptExtract.hpp>
#include <dbcOracleScriptExtract.hpp>
#include <dbcASAScriptExtract.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
  TSpeedButton *BtnSelM;
  TEdit *fnScriptM;
  TSpeedButton *BtnSelT;
  TEdit *FnScriptT;
  TLabel *Label1;
  TLabel *Label2;
  TOpenDialog *OpenDialog1;
  TRadioButton *rbIB;
  TRadioButton *rbSAW;
  TRadioButton *rbMy;
  TRadioButton *rbOra;
  TRadioButton *rbMS;
  TBitBtn *BtnExtract;
  TBitBtn *BtnCompare;
  TRichEdit *MemoLog;
  TRichEdit *MemoScript;
  TPanel *Panel1;
  TSplitter *Splitter1;
  TDBComparer *DBComparer;
  TDBStructure *DBStructureMaster;
  TDBStructure *DBStructureTarget;
  TIBScriptExtract *IBScriptExtract;
  TASAScriptExtract *SAWScriptExtract;
  TMySQLScriptExtract *MySQLScriptExtract;
  TOracleScriptExtract *OracleScriptExtract;
  TMSSQLScriptExtract *MSSQLScriptExtract;
  TProgressBar *ProgressBar;
  void __fastcall BtnSelClick(TObject *Sender);
  void __fastcall DBComparerBeforeExtract(TObject *Sender);
  void __fastcall DBComparerBeforeExtractMaster(TObject *Sender);
  void __fastcall DBComparerBeforeExtractTarget(TObject *Sender);
  void __fastcall DBComparerProgressUpdate(TObject *Sender, int Value, int MaxValue);
  void __fastcall BtnExtractClick(TObject *Sender);
  void __fastcall BtnCompareClick(TObject *Sender);
  void __fastcall DBComparerLogNextLine(TObject *Sender, UnicodeString LogText);
  void __fastcall DBComparerErrorMessage(TObject *Sender, UnicodeString ErrText);
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
private:	// User declarations
  TDatabaseType __fastcall GetDbType();
  void __fastcall SetDbType(TDatabaseType aType);
public:		// User declarations
  __fastcall TForm1(TComponent* Owner);
  void __fastcall AddToLog(UnicodeString aText);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
