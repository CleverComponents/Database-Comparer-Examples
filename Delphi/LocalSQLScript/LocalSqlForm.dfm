object Form1: TForm1
  Left = 70
  Top = 226
  Width = 640
  Height = 400
  Caption = 'LocalSQLExec sample'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    632
    373)
  PixelsPerInch = 96
  TextHeight = 13
  object EditFileName: TEdit
    Left = 144
    Top = 8
    Width = 321
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 464
    Top = 8
    Width = 81
    Height = 21
    Caption = 'Load script'
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object MemoScript: TRichEdit
    Left = 8
    Top = 40
    Width = 617
    Height = 185
    Anchors = [akLeft, akTop, akRight]
    Lines.Strings = (
      '< Script is empty >')
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object BitBtn2: TBitBtn
    Left = 552
    Top = 8
    Width = 75
    Height = 21
    Caption = 'Execute'
    TabOrder = 3
    OnClick = BitBtn2Click
  end
  object MemoLog: TRichEdit
    Left = 8
    Top = 232
    Width = 617
    Height = 137
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      '< Log >')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 4
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 8
    Width = 129
    Height = 21
    TabOrder = 5
  end
  object Database: TDatabase
    AliasName = 'DBDEMOS'
    DatabaseName = 'LocalDatabase'
    SessionName = 'Default'
    TransIsolation = tiDirtyRead
    Left = 96
    Top = 16
  end
  object DBCConnectionBDE: TDBCConnectionBDE
    Database = Database
    OnErrorMessage = ShowErrorMessage
    Left = 96
    Top = 72
  end
  object LocalSQLExec: TLocalSQLExec
    DBCConnection = DBCConnectionBDE
    BreakOnError = False
    OnLogNextLine = LocalSQLExecLogNextLine
    OnProgressUpdate = LocalSQLExecProgressUpdate
    OnErrorMessage = ShowErrorMessage
    Left = 96
    Top = 120
  end
  object OpenDialog: TOpenDialog
    Filter = 'Local SQL script (*.SQL)|*.sql|All files|*.*'
    Left = 392
    Top = 40
  end
end
