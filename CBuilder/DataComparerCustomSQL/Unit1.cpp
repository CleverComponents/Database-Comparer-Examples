//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
#include "DataModule1.h"
#include <inifiles.hpp>

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "dbcClasses"
#pragma link "dbcIBSQLExec"
#pragma link "dbcSQL_Exec"
#pragma link "dbcTableDataComparer"
#pragma resource "*.dfm"

TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------

UnicodeString __fastcall TForm1::IniFileName()
{
  return ExtractFilePath(ParamStr(0)) + "CompDemo.Ini";
}

void __fastcall TForm1::FormCreate(TObject *Sender)
{
  MemoExtr->Clear();
  MemoResult->Clear();

  TIniFile *ini = new TIniFile(IniFileName());
  __try
  {
	fnDatabaseMaster->Text = ini->ReadString("Databases","MasterDB","");
	fnDatabaseTarget->Text = ini->ReadString("Databases","TargetDB","");
	EditTableM->Text = ini->ReadString("TableDataComparer","TableNameMaster", "");
    EditTableT->Text = ini->ReadString("TableDataComparer","TableNameTarget", "");
    cbCompareMode->ItemIndex = ini->ReadInteger("TableDataComparer","DataCompareMode", 0);
    cbCompareModeChange(cbCompareMode);
    EditCustomFlds->Text = ini->ReadString("TableDataComparer","CustomKeyFields", "");
	EditExclFlds->Text = ini->ReadString("TableDataComparer","ExcludeDataFields", "");
	EditFilterM->Text = ini->ReadString("TableDataComparer","EditFilterM", "");
	EditFilterT->Text = ini->ReadString("TableDataComparer","EditFilterT", "");
  }
  __finally
  {
    delete ini;
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BtnSelFileClick(TObject *Sender)
{
  if (OpenDialog1->Execute())
  {
    if (Sender == BtnSelDatabaseMaster)
      fnDatabaseMaster->Text = OpenDialog1->FileName;
    if (Sender == BtnSelDatabaseTarget)
      fnDatabaseTarget->Text = OpenDialog1->FileName;
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormDestroy(TObject *Sender)
{
  TIniFile *ini = new TIniFile(IniFileName());
  __try
  {
    ini->WriteString("Databases", "MasterDB", fnDatabaseMaster->Text);
    ini->WriteString("Databases", "TargetDB", fnDatabaseTarget->Text);
    ini->WriteString("TableDataComparer","TableNameMaster", EditTableM->Text);
    ini->WriteString("TableDataComparer","TableNameTarget", EditTableT->Text);
    ini->WriteInteger("TableDataComparer","DataCompareMode", cbCompareMode->ItemIndex);
    ini->WriteString("TableDataComparer","CustomKeyFields", EditCustomFlds->Text);
    ini->WriteString("TableDataComparer","ExcludeDataFields", EditExclFlds->Text);
	ini->WriteString("TableDataComparer","EditFilterM", EditFilterM->Text);
	ini->WriteString("TableDataComparer","EditFilterT", EditFilterT->Text);
  }
  __finally
  {
    delete ini;
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::LogNextLine(TObject *Sender, UnicodeString LogLine)
{
  MemoExtr->Lines->Add(LogLine);
  MemoExtr->Perform(EM_SCROLLCARET, 0, 0);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ProgressUpdate(TObject *Sender, int Value, int MaxValue)
{
  Gauge1->Max = MaxValue;
  Gauge1->Position = Value;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BtnUpdateClick(TObject *Sender)
{
  IBSQLExec->ExecuteScript();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BtnDataCompareClick(TObject *)
{
  TableDataComparer->TableNameMaster = EditTableM->Text;
  TableDataComparer->TableNameTarget = EditTableT->Text;
  DecodeFields(EditCustomFlds->Text, TableDataComparer->CustomKeyFields);
  DecodeFields(EditExclFlds->Text, TableDataComparer->ExcludeDataFields);
  TableDataComparer->AllowedOperations = TDataCompareOperations();

  if (cbInsert->Checked)
  {
	TableDataComparer->AllowedOperations = TableDataComparer->AllowedOperations << dcopInsert;
  }
  if (cbUpdate->Checked)
  {
	TableDataComparer->AllowedOperations = TableDataComparer->AllowedOperations << dcopUpdate;
  }
  if (cbDelete->Checked)
  {
	TableDataComparer->AllowedOperations =TableDataComparer->AllowedOperations << dcopDelete;
  }

  IBSQLExec->Clear();
  MemoResult->Clear();
  if (TableDataComparer->CompareData())
  {
    IBSQLExec->GetScript(MemoResult->Lines);
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::EditTableMChange(TObject *)
{
  EditTableT->Text = EditTableM->Text;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::TableDataComparerProgressUpdateMaster(TObject *, int Value, int MaxValue)
{
  Gauge1->Max = MaxValue;
  Gauge1->Position = Value;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::TableDataComparerProgressUpdateTarget(TObject *, int Value, int MaxValue)
{
  Gauge2->Max = MaxValue;
  Gauge2->Position = Value;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::cbCompareModeChange(TObject *)
{
  EditCustomFlds->Enabled = cbCompareMode->ItemIndex == 3;
  LabelCustomFlds->Enabled = cbCompareMode->ItemIndex == 3;
}
//---------------------------------------------------------------------------

UnicodeString __fastcall CheckUpper(UnicodeString fldName)
{
  if ((fldName.Length() > 0) && (
    ((fldName[1] >= 'a') && (fldName[1] <= 'z'))
    || ((fldName[1] >= 'A') && (fldName[1] <= 'Z'))))
  {
    return AnsiUpperCase(fldName);
  }
  return fldName;
}

void __fastcall TForm1::DecodeFields(UnicodeString aFlds, TStrings *aFields)
{
  aFields->Clear();
  UnicodeString s = aFlds;
  UnicodeString FldName;

  int p = s.Pos(",");
  while (p > 0)
  {
    FldName = s.SubString(1, p - 1).Trim();
    if (FldName != "")
      aFields->Add(CheckUpper(FldName));

    s.Delete(1, p);
    p = s.Pos(",");
  }
  
  FldName = s.Trim();
  if (FldName != "")
    aFields->Add(CheckUpper(FldName));
}
//---------------------------------------------------------------------------
void __fastcall TForm1::TableDataComparerGetSelectSQL(TObject *Sender, TStrings * const SQLM,
          TStrings * const SQLT)
{
  SQLM->Text = "select * from " + EditTableM->Text
	+ ((EditFilterM->Text != "") ? " where " : "") + EditFilterM->Text;
  SQLT->Text = "select * from " + EditTableT->Text
	+ ((EditFilterT->Text != "") ? " where " : "") + EditFilterT->Text;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::TableDataComparerGetCountSQL(TObject *Sender, TStrings * const SQLM,
		  TStrings * const SQLT)
{
  SQLM->Text = "select count(*) from " + EditTableM->Text
	+ ((EditFilterM->Text != "") ? " where " : "") + EditFilterM->Text;
  SQLT->Text = "select count(*) from " + EditTableT->Text
	+ ((EditFilterT->Text != "") ? " where " : "") + EditFilterT->Text;
}
//---------------------------------------------------------------------------

