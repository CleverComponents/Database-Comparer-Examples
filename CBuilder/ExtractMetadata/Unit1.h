//---------------------------------------------------------------------------

#ifndef Unit1H
#define Unit1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <dbcClasses.hpp>
#include <dbcDBEngine.hpp>
#include <dbcDBStructure.hpp>
#include <dbcIBDatabaseExtract.hpp>
#include <dbcMSSQLDatabaseExtract.hpp>
#include <dbcMySQLDatabaseExtract.hpp>
#include <dbcTypes.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
  TBitBtn *BtnExtractDb;
  TOpenDialog *OpenDialog;
  TRichEdit *MemoScript;
  TRichEdit *MemoLog;
  TProgressBar *ProgressBarM;
  TDBCConnection *DBCConnection;
  TPanel *Panel2;
  TRadioButton *rbMIB;
  TRadioButton *rbMMS;
  TRadioButton *rbMMY;
  TEdit *EditDBNameM;
  TEdit *EditUserM;
  TEdit *EditPswdM;
  TLabel *Label3;
  TLabel *LabelUserM;
  TLabel *LabelPswdM;
  TCheckBox *cbAuthM;
  TEdit *EditServerM;
  TLabel *LabelServerM;
  TEdit *EditTableM;
  TLabel *Label11;
  TIBDBExtract *IBDBExtract;
  TMSSQLDBExtract *MSSQLDBExtract;
  TMySQLDBExtract *MySQLDBExtract;
  TDBStructure *DBStructure;
  TBitBtn *BtnExtractMetadata;
  TBitBtn *BtnExtractTable;
  void __fastcall LogErrorMessage(TObject *Sender, UnicodeString ErrText);
  void __fastcall LogNextLine(TObject *Sender, UnicodeString LogText);
  void __fastcall BtnExtractDbClick(TObject *Sender);
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall rbMClick(TObject *Sender);
  void __fastcall BtnExtractMetadataClick(TObject *Sender);
  void __fastcall BtnExtractTableClick(TObject *Sender);
private:	// User declarations
  TDatabaseType __fastcall GetDBType();
  void __fastcall SetDBType(TDatabaseType aType);
public:		// User declarations
  __fastcall TForm1(TComponent* Owner);
  void __fastcall AddToLog(UnicodeString aText);
  __property TDatabaseType DatabaseType = {read=GetDBType};
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
 