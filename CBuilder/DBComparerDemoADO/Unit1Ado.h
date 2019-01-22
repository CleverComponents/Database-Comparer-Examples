//---------------------------------------------------------------------------

#ifndef Unit1AdoH
#define Unit1AdoH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "dbcClasses.hpp"
#include "dbcConnection_ADO.hpp"
#include "dbcCustomScriptExtract.hpp"
#include "dbcDBComparer.hpp"
#include "dbcDBEngine.hpp"
#include "dbcDBStructure.hpp"
#include "dbcMSSQLDatabaseExtract.hpp"
#include "dbcMSSQLExec.hpp"
#include "dbcMSSQLScriptExtract.hpp"
#include "dbcSQL_Exec.hpp"
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
  TDBStructure *DBStructure1;
  TDBStructure *DBStructure2;
  TOpenDialog *OpenDialog1;
  TGroupBox *GroupBox1;
  TEdit *EditDbMaster;
  TEdit *EditDbTarget;
  TLabel *Label1;
  TLabel *Label2;
  TSpeedButton *BtnSelDatabaseMaster;
  TSpeedButton *BtnSelDatabaseTarget;
  TEdit *EditMUser;
  TEdit *EditMPswd;
  TLabel *LabelMUser;
  TLabel *LabelMPswd;
  TLabel *LabelTUser;
  TEdit *EditTUser;
  TLabel *LabelTPswd;
  TEdit *EditTPswd;
  TBitBtn *BtnExtract;
  TBitBtn *BtnCompare;
  TGroupBox *GroupBox2;
  TRichEdit *MemoLog;
  TDBComparer *DBComparer1;
  TSplitter *Splitter1;
  TGroupBox *GroupBox3;
  TMemo *MemoResult;
  TEdit *fnScriptMaster;
  TSpeedButton *BtnSelScriptMaster;
  TEdit *fnScriptTarget;
  TSpeedButton *BtnSelScriptTarget;
  TPanel *Panel1;
  TRadioButton *rbMasterFromDatabase;
  TRadioButton *rbMasterFromScript;
  TPanel *Panel2;
  TRadioButton *rbTargetFromDatabase;
  TRadioButton *rbTargetFromScript;
  TBitBtn *BtnUpdate;
  TProgressBar *Gauge1;
  TDBCConnectionADO *DBCConnectionADO1;
  TDBCConnectionADO *DBCConnectionADO2;
  TMSSQLExec *MSSQLExec1;
  TMSSQLScriptExtract *MSSQLScriptExtract1;
  TMSSQLScriptExtract *MSSQLScriptExtract2;
  TMSSQLDBExtract *MSSQLDBExtract1;
  TMSSQLDBExtract *MSSQLDBExtract2;
  TPanel *Panel3;
  TPanel *Panel4;
  TLabel *LabelSrvM;
  TEdit *EditHostM;
  TLabel *LabelAuthM;
  TRadioButton *rbMWin;
  TRadioButton *rbMSql;
  TLabel *LabelSrvT;
  TEdit *EditHostT;
  TLabel *LabelAuthT;
  TRadioButton *rbTWin;
  TRadioButton *rbTSql;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall BtnSelFileClick(TObject *Sender);
  void __fastcall BtnExtractClick(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall LogNextLine(TObject *Sender, UnicodeString LogLine);
  void __fastcall BtnCompareClick(TObject *Sender);
  void __fastcall rbFromClick(TObject *Sender);
  void __fastcall ProgressUpdate(TObject *Sender, int Value, int MaxValue);
  void __fastcall BtnUpdateClick(TObject *Sender);
private:	// User declarations
  void __fastcall AddToLog(UnicodeString aText);
public:		// User declarations
  __fastcall TForm1(TComponent* Owner);
  void __fastcall ExtractMasterDatabase();
  void __fastcall ExtractTargetDatabase();
  void __fastcall ExtractMasterScript();
  void __fastcall ExtractTargetScript();
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
