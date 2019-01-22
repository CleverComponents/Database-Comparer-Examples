//---------------------------------------------------------------------------

#ifndef Unit1IbxH
#define Unit1IbxH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "dbcClasses.hpp"
#include "dbcCustomScriptExtract.hpp"
#include "dbcDBComparer.hpp"
#include "dbcDBStructure.hpp"
#include "dbcIBDatabaseExtract.hpp"
#include "dbcIBScriptExtract.hpp"
#include "dbcIBSQLExec.hpp"
#include "dbcSQL_Exec.hpp"
#include "dbcTableDataComparer.hpp"
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
  TIBDBExtract *IBDBExtract1;
  TDBStructure *DBStructure1;
  TDBStructure *DBStructure2;
  TIBDBExtract *IBDBExtract2;
  TOpenDialog *OpenDialog1;
  TGroupBox *GroupBox1;
  TEdit *fnDatabaseMaster;
  TEdit *fnDatabaseTarget;
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
  TRichEdit *MemoExtr;
  TDBComparer *DBComparer1;
  TSplitter *Splitter1;
  TGroupBox *GroupBox3;
  TMemo *MemoResult;
  TEdit *fnScriptMaster;
  TSpeedButton *BtnSelScriptMaster;
  TEdit *fnScriptTarget;
  TSpeedButton *BtnSelScriptTarget;
  TIBScriptExtract *IBScriptExtract1;
  TIBScriptExtract *IBScriptExtract2;
  TPanel *Panel1;
  TRadioButton *rbMasterFromDatabase;
  TRadioButton *rbMasterFromScript;
  TPanel *Panel2;
  TRadioButton *rbTargetFromDatabase;
  TRadioButton *rbTargetFromScript;
  TIBSQLExec *IBSQLExec;
  TBitBtn *BtnUpdate;
  TProgressBar *Gauge1;
  TLabel *Label3;
  TGroupBox *GroupBox4;
  TEdit *EditTableM;
  TEdit *EditTableT;
  TLabel *Label4;
  TLabel *Label5;
  TTableDataComparer *TableDataComparer;
  TLabel *Label6;
  TComboBox *cbCompareMode;
  TEdit *EditCustomFlds;
  TLabel *LabelCustomFlds;
  TEdit *EditExclFlds;
  TLabel *Label8;
  TBitBtn *BtnDataCompare;
  TBitBtn *BitBtn2;
  TLabel *Label9;
  TProgressBar *Gauge2;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall BtnSelFileClick(TObject *Sender);
  void __fastcall BtnExtractClick(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall LogNextLine(TObject *Sender, UnicodeString LogLine);
  void __fastcall BtnCompareClick(TObject *Sender);
  void __fastcall rbFromClick(TObject *Sender);
  void __fastcall ProgressUpdate(TObject *Sender, int Value, int MaxValue);
  void __fastcall BtnUpdateClick(TObject *Sender);
  void __fastcall BtnDataCompareClick(TObject *Sender);
  void __fastcall EditTableMChange(TObject *Sender);
  void __fastcall TableDataComparerProgressUpdateMaster(TObject *Sender, int Value, int MaxValue);
  void __fastcall TableDataComparerProgressUpdateTarget(TObject *Sender, int Value, int MaxValue);
  void __fastcall cbCompareModeChange(TObject *Sender);
private:	// User declarations
public:		// User declarations
  __fastcall TForm1(TComponent* Owner);
  void __fastcall DecodeFields(UnicodeString aFlds, TStrings *aFields);
  void __fastcall ExtractMasterDatabase();
  void __fastcall ExtractTargetDatabase();
  void __fastcall ExtractMasterScript();
  void __fastcall ExtractTargetScript();
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
