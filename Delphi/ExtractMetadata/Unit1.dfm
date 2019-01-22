object Form1: TForm1
  Left = 44
  Top = 161
  Width = 800
  Height = 540
  Caption = 'Metadata extractor'
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
    792
    513)
  PixelsPerInch = 96
  TextHeight = 13
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
  object Label11: TLabel
    Left = 136
    Top = 84
    Width = 55
    Height = 13
    Caption = 'Table name'
  end
  object MemoScript: TRichEdit
    Left = 8
    Top = 232
    Width = 777
    Height = 273
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      '< Script is empty >')
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object MemoLog: TRichEdit
    Left = 8
    Top = 128
    Width = 777
    Height = 97
    Anchors = [akLeft, akTop, akRight]
    Lines.Strings = (
      '< Log >')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object ProgressBarM: TProgressBar
    Left = 200
    Top = 106
    Width = 137
    Height = 17
    TabOrder = 3
  end
  object Panel2: TPanel
    Left = 8
    Top = 2
    Width = 273
    Height = 17
    BevelOuter = bvNone
    TabOrder = 4
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
    object rbMMY: TRadioButton
      Left = 144
      Top = 0
      Width = 65
      Height = 17
      Caption = 'MySQL'
      TabOrder = 2
      Visible = False
      OnClick = rbMClick
    end
  end
  object EditDBNameM: TEdit
    Left = 8
    Top = 40
    Width = 161
    Height = 21
    TabOrder = 5
  end
  object EditUserM: TEdit
    Left = 176
    Top = 40
    Width = 81
    Height = 21
    TabOrder = 6
  end
  object EditPswdM: TEdit
    Left = 256
    Top = 40
    Width = 81
    Height = 21
    TabOrder = 7
  end
  object cbAuthM: TCheckBox
    Left = 176
    Top = 61
    Width = 161
    Height = 17
    Caption = 'Windows authentication'
    TabOrder = 8
    OnClick = rbMClick
  end
  object EditServerM: TEdit
    Left = 8
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 9
  end
  object BtnExtractDb: TBitBtn
    Left = 368
    Top = 8
    Width = 145
    Height = 25
    Caption = 'Extract database'
    TabOrder = 0
    OnClick = BtnExtractDbClick
  end
  object EditTableM: TEdit
    Left = 200
    Top = 80
    Width = 137
    Height = 21
    TabOrder = 10
  end
  object BtnExtractMetadata: TBitBtn
    Left = 368
    Top = 40
    Width = 145
    Height = 25
    Caption = 'Extract metadata'
    Enabled = False
    TabOrder = 11
    OnClick = BtnExtractMetadataClick
  end
  object BtnExtractTable: TBitBtn
    Left = 368
    Top = 80
    Width = 145
    Height = 25
    Caption = 'Extract table'
    Enabled = False
    TabOrder = 12
    OnClick = BtnExtractTableClick
  end
  object OpenDialog: TOpenDialog
    Filter = 'Local SQL script (*.SQL)|*.sql|All files|*.*'
    Left = 376
    Top = 128
  end
  object DBCConnection: TDBCConnection
    OnErrorMessage = LogErrorMessage
    Left = 176
    Top = 128
  end
  object IBDBExtract: TIBDBExtract
    DBCConnection = DBCConnection
    DBStructure = DBStructure
    OnLogNextLine = LogNextLine
    OnErrorMessage = LogErrorMessage
    Left = 200
    Top = 248
  end
  object MSSQLDBExtract: TMSSQLDBExtract
    DBCConnection = DBCConnection
    DBStructure = DBStructure
    OnLogNextLine = LogNextLine
    OnErrorMessage = LogErrorMessage
    Left = 288
    Top = 248
  end
  object MySQLDBExtract: TMySQLDBExtract
    DBCConnection = DBCConnection
    DBStructure = DBStructure
    OnLogNextLine = LogNextLine
    OnErrorMessage = LogErrorMessage
    Left = 384
    Top = 248
  end
  object DBStructure: TDBStructure
    Left = 200
    Top = 304
  end
end
