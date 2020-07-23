//---------------------------------------------------------------------------

#ifndef Unit1H
#define Unit1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "dbcClasses.hpp"
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
  TGroupBox *GroupBox2;
  TRichEdit *MemoExtr;
  TSplitter *Splitter1;
  TGroupBox *GroupBox3;
  TMemo *MemoResult;
  TProgressBar *Gauge1;
  TProgressBar *Gauge2;
  TLabel *Label4;
  TEdit *EditTableM;
  TLabel *Label5;
  TEdit *EditTableT;
  TBitBtn *BtnDataCompare;
  TBitBtn *BtnUpdate;
  TLabel *Label6;
  TComboBox *cbCompareMode;
  TLabel *LabelCustomFlds;
  TEdit *EditCustomFlds;
  TLabel *Label8;
  TEdit *EditExclFlds;
  TLabel *Label3;
  TLabel *Label7;
  TTableDataComparer *TableDataComparer;
  TOpenDialog *OpenDialog1;
  TIBSQLExec *IBSQLExec;
  TEdit *EditFilterM;
  TEdit *EditFilterT;
  TCheckBox *cbInsert;
  TCheckBox *cbUpdate;
  TCheckBox *cbDelete;
  TLabel *Label9;
  void __fastcall FormCreate(TObject *Sender);
  void __fastcall BtnSelFileClick(TObject *Sender);
  void __fastcall FormDestroy(TObject *Sender);
  void __fastcall LogNextLine(TObject *Sender, UnicodeString LogLine);
  void __fastcall ProgressUpdate(TObject *Sender, int Value, int MaxValue);
  void __fastcall BtnUpdateClick(TObject *Sender);
  void __fastcall BtnDataCompareClick(TObject *);
  void __fastcall EditTableMChange(TObject *);
  void __fastcall TableDataComparerProgressUpdateMaster(TObject *, int Value, int MaxValue);
  void __fastcall TableDataComparerProgressUpdateTarget(TObject *, int Value, int MaxValue);
  void __fastcall cbCompareModeChange(TObject *);
	void __fastcall TableDataComparerGetSelectSQL(TObject *Sender, TStrings * const SQLM,
          TStrings * const SQLT);
	void __fastcall TableDataComparerGetCountSQL(TObject *Sender, TStrings * const SQLM,
          TStrings * const SQLT);

private:	// User declarations
  void __fastcall DecodeFields(UnicodeString aFlds, TStrings *aFields);
  UnicodeString __fastcall IniFileName();
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
