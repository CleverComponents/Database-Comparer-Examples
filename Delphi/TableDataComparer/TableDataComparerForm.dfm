object Form1: TForm1
  Left = 44
  Top = 161
  Caption = 'TableDataComparer'
  ClientHeight = 502
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    784
    502)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 3
    Width = 43
    Height = 13
    Caption = 'Master:'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 360
    Top = 3
    Width = 41
    Height = 13
    Caption = 'Target:'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 24
    Width = 75
    Height = 13
    Caption = 'Database name'
  end
  object LabelUserM: TLabel
    Left = 176
    Top = 24
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object LabelPswdM: TLabel
    Left = 256
    Top = 24
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object LabelServerM: TLabel
    Left = 8
    Top = 64
    Width = 61
    Height = 13
    Caption = 'Server name'
  end
  object Label7: TLabel
    Left = 352
    Top = 24
    Width = 75
    Height = 13
    Caption = 'Database name'
  end
  object LabelUserT: TLabel
    Left = 520
    Top = 24
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object LabelPswdT: TLabel
    Left = 600
    Top = 24
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object LabelServerT: TLabel
    Left = 352
    Top = 64
    Width = 61
    Height = 13
    Caption = 'Server name'
  end
  object Label11: TLabel
    Left = 136
    Top = 84
    Width = 55
    Height = 13
    Caption = 'Table name'
  end
  object Label12: TLabel
    Left = 480
    Top = 84
    Width = 55
    Height = 13
    Caption = 'Table name'
  end
  object Bevel1: TBevel
    Left = 344
    Top = 0
    Width = 3
    Height = 121
  end
  object MemoScript: TRichEdit
    Left = 8
    Top = 128
    Width = 777
    Height = 177
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = []
    Lines.Strings = (
      '< Script is empty >')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object MemoLog: TRichEdit
    Left = 8
    Top = 312
    Width = 777
    Height = 197
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = []
    Lines.Strings = (
      '< Log >')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object ProgressBarM: TProgressBar
    Left = 200
    Top = 106
    Width = 137
    Height = 17
    TabOrder = 4
  end
  object Panel2: TPanel
    Left = 56
    Top = 2
    Width = 273
    Height = 17
    BevelOuter = bvNone
    TabOrder = 5
    object rbMIB: TRadioButton
      Left = 8
      Top = 0
      Width = 73
      Height = 17
      Caption = 'InterBase'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbMClick
    end
    object rbMMS: TRadioButton
      Left = 80
      Top = 0
      Width = 65
      Height = 17
      Caption = 'MS SQL'
      TabOrder = 1
      OnClick = rbMClick
    end
  end
  object EditDBNameM: TEdit
    Left = 8
    Top = 40
    Width = 161
    Height = 21
    TabOrder = 6
  end
  object EditUserM: TEdit
    Left = 176
    Top = 40
    Width = 81
    Height = 21
    TabOrder = 7
  end
  object EditPswdM: TEdit
    Left = 256
    Top = 40
    Width = 81
    Height = 21
    TabOrder = 8
  end
  object cbAuthM: TCheckBox
    Left = 176
    Top = 61
    Width = 161
    Height = 17
    Caption = 'Windows authentication'
    TabOrder = 9
    OnClick = rbMClick
  end
  object EditServerM: TEdit
    Left = 8
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 10
  end
  object Panel1: TPanel
    Left = 408
    Top = 2
    Width = 273
    Height = 17
    BevelOuter = bvNone
    TabOrder = 11
    object rbTIB: TRadioButton
      Left = 8
      Top = 0
      Width = 73
      Height = 17
      Caption = 'InterBase'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbTClick
    end
    object rbTMS: TRadioButton
      Left = 80
      Top = 0
      Width = 65
      Height = 17
      Caption = 'MS SQL'
      TabOrder = 1
      OnClick = rbTClick
    end
  end
  object ProgressBarT: TProgressBar
    Left = 544
    Top = 106
    Width = 137
    Height = 17
    TabOrder = 12
  end
  object EditDBNameT: TEdit
    Left = 352
    Top = 40
    Width = 161
    Height = 21
    TabOrder = 13
  end
  object EditUserT: TEdit
    Left = 520
    Top = 40
    Width = 81
    Height = 21
    TabOrder = 14
  end
  object EditPswdT: TEdit
    Left = 600
    Top = 40
    Width = 81
    Height = 21
    TabOrder = 15
  end
  object cbAuthT: TCheckBox
    Left = 520
    Top = 61
    Width = 161
    Height = 17
    Caption = 'Windows authentication'
    TabOrder = 16
    OnClick = rbTClick
  end
  object EditServerT: TEdit
    Left = 352
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 17
  end
  object BtnCompare: TBitBtn
    Left = 704
    Top = 8
    Width = 81
    Height = 21
    Anchors = [akTop, akRight]
    Caption = 'Compare'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 0
    OnClick = BtnCompareClick
  end
  object BtnUpdate: TBitBtn
    Left = 704
    Top = 40
    Width = 81
    Height = 21
    Anchors = [akTop, akRight]
    Caption = 'Update'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = BtnUpdateClick
  end
  object EditTableM: TEdit
    Left = 200
    Top = 80
    Width = 137
    Height = 21
    TabOrder = 18
  end
  object EditTableT: TEdit
    Left = 544
    Top = 80
    Width = 137
    Height = 21
    TabOrder = 19
  end
  object OpenDialog: TOpenDialog
    Filter = 'Local SQL script (*.SQL)|*.sql|All files|*.*'
    Left = 376
    Top = 128
  end
  object DBCConnectionM: TDBCConnection
    OnErrorMessage = LogErrorMessage
    Left = 176
    Top = 128
  end
  object DBCConnectionT: TDBCConnection
    OnErrorMessage = LogErrorMessage
    Left = 176
    Top = 192
  end
  object TableDataComparer: TTableDataComparer
    DBCConnectionMaster = DBCConnectionM
    DBCConnectionTarget = DBCConnectionT
    ScriptFileName = 'Result.SQL'
    BlobFileName = 'Result.LOB'
    OnLogNextLine = LogNextLine
    OnErrorMessage = LogErrorMessage
    OnProgressUpdateMaster = TableDataComparerProgressUpdateMaster
    OnProgressUpdateTarget = TableDataComparerProgressUpdateTarget
    Left = 80
    Top = 128
  end
  object IBSQLExec: TIBSQLExec
    DBCConnection = DBCConnectionT
    OnLogNextLine = LogNextLine
    OnErrorMessage = LogErrorMessage
    Left = 296
    Top = 192
  end
  object MSSQLExec: TMSSQLExec
    DBCConnection = DBCConnectionT
    OnLogNextLine = LogNextLine
    OnErrorMessage = LogErrorMessage
    Left = 360
    Top = 192
  end
  object Database1: TDatabase
    AliasName = 'DBDEMOS'
    DatabaseName = 'DBC_Database'
    SessionName = 'Default'
    Left = 384
    Top = 256
  end
  object Query1: TQuery
    DatabaseName = 'DBCDatabase'
    SQL.Strings = (
      'select * from frReport')
    Left = 528
    Top = 232
  end
end
