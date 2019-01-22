//---------------------------------------------------------------------------

#ifndef LocalSqlFormH
#define LocalSqlFormH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <dbcClasses.hpp>
#include <dbcConnection_BDE.hpp>
#include <dbcDBEngine.hpp>
#include <dbcLocalSQLExec.hpp>
#include <dbcSQL_Exec.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <DB.hpp>
#include <DBTables.hpp>
#include <Dialogs.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
  TDatabase *Database;
  TDBCConnectionBDE *DBCConnectionBDE;
  TLocalSQLExec *LocalSQLExec;
  TEdit *EditFileName;
  TBitBtn *BitBtn1;
  TOpenDialog *OpenDialog;
  TRichEdit *MemoScript;
  TBitBtn *BitBtn2;
  TRichEdit *MemoLog;
  TProgressBar *ProgressBar;
  void __fastcall BitBtn1Click(TObject *Sender);
  void __fastcall ShowErrorMessage(TObject *Sender, UnicodeString ErrText);
  void __fastcall LocalSQLExecLogNextLine(TObject *Sender, UnicodeString LogText);
  void __fastcall BitBtn2Click(TObject *Sender);
  void __fastcall LocalSQLExecProgressUpdate(TObject *Sender, int Value, int MaxValue);
private:	// User declarations
public:		// User declarations
  __fastcall TForm1(TComponent* Owner);
  void __fastcall AddToLog(UnicodeString aText);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
