object Form1: TForm1
  Left = 36
  Top = 66
  Caption = 'Table Data Comparer with Custom SQL (FireDAC)'
  ClientHeight = 514
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 350
    Top = 249
    Width = 5
    Height = 265
    Beveled = True
    ExplicitLeft = 380
    ExplicitTop = 290
    ExplicitHeight = 224
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 688
    Height = 249
    Align = alTop
    Caption = 'Databases...'
    TabOrder = 0
    object Label1: TLabel
      Left = 9
      Top = 28
      Width = 50
      Height = 13
      Caption = 'Master DB'
    end
    object Label2: TLabel
      Left = 353
      Top = 28
      Width = 49
      Height = 13
      Caption = 'Target DB'
    end
    object BtnSelDatabaseMaster: TSpeedButton
      Left = 312
      Top = 47
      Width = 25
      Height = 22
      Hint = 'Select Master Database'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        0800000000000001000000000000000000000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A6000020400000206000002080000020A0000020C0000020E000004000000040
        20000040400000406000004080000040A0000040C0000040E000006000000060
        20000060400000606000006080000060A0000060C0000060E000008000000080
        20000080400000806000008080000080A0000080C0000080E00000A0000000A0
        200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
        200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
        200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
        20004000400040006000400080004000A0004000C0004000E000402000004020
        20004020400040206000402080004020A0004020C0004020E000404000004040
        20004040400040406000404080004040A0004040C0004040E000406000004060
        20004060400040606000406080004060A0004060C0004060E000408000004080
        20004080400040806000408080004080A0004080C0004080E00040A0000040A0
        200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
        200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
        200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
        20008000400080006000800080008000A0008000C0008000E000802000008020
        20008020400080206000802080008020A0008020C0008020E000804000008040
        20008040400080406000804080008040A0008040C0008040E000806000008060
        20008060400080606000806080008060A0008060C0008060E000808000008080
        20008080400080806000808080008080A0008080C0008080E00080A0000080A0
        200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
        200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
        200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
        2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
        2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
        2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
        2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
        2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
        2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
        2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FDFDFDFDFDFD
        FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD0B0B0B0B
        0B0B0B0B0B0BFDFDFDFDFD1E1E1E1E1E1E1E1E1E1E1E0BFDFDFD1E1EBFFBFBFB
        FBFBFBFBFBFB1E01FDFD1E1EFBBFFBFBFBFBFBFBFBFB2F01FDFD1E2737BFFBFB
        FBFBFBFBFBFB3701FDFD1E2F27BF7F7F7F7F7F7F7F7F373701FD1EFB1E7FBFBF
        BFBFBFBFBFBF377F01FD1EFB1E37FFFFFFFFFFFFFFFFFBFF01FD1EFB371E1E1E
        1E1E1E1E1E1E1E1E01FD1EBF7F7F7F7F7FFFFFFFFFFF1E0BFDFD1EFFBFBFBFBF
        FF1E1E1E1E1E1EFDFDFDFD27FFFFFFFF1EFDFDFDFDFDFDFDFDFDFDFD27272727
        FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD}
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnSelFileClick
    end
    object BtnSelDatabaseTarget: TSpeedButton
      Left = 656
      Top = 47
      Width = 25
      Height = 22
      Hint = 'Select Target Database'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        0800000000000001000000000000000000000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A6000020400000206000002080000020A0000020C0000020E000004000000040
        20000040400000406000004080000040A0000040C0000040E000006000000060
        20000060400000606000006080000060A0000060C0000060E000008000000080
        20000080400000806000008080000080A0000080C0000080E00000A0000000A0
        200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
        200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
        200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
        20004000400040006000400080004000A0004000C0004000E000402000004020
        20004020400040206000402080004020A0004020C0004020E000404000004040
        20004040400040406000404080004040A0004040C0004040E000406000004060
        20004060400040606000406080004060A0004060C0004060E000408000004080
        20004080400040806000408080004080A0004080C0004080E00040A0000040A0
        200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
        200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
        200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
        20008000400080006000800080008000A0008000C0008000E000802000008020
        20008020400080206000802080008020A0008020C0008020E000804000008040
        20008040400080406000804080008040A0008040C0008040E000806000008060
        20008060400080606000806080008060A0008060C0008060E000808000008080
        20008080400080806000808080008080A0008080C0008080E00080A0000080A0
        200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
        200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
        200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
        2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
        2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
        2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
        2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
        2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
        2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
        2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FDFDFDFDFDFD
        FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD0B0B0B0B
        0B0B0B0B0B0BFDFDFDFDFD1E1E1E1E1E1E1E1E1E1E1E0BFDFDFD1E1EBFFBFBFB
        FBFBFBFBFBFB1E01FDFD1E1EFBBFFBFBFBFBFBFBFBFB2F01FDFD1E2737BFFBFB
        FBFBFBFBFBFB3701FDFD1E2F27BF7F7F7F7F7F7F7F7F373701FD1EFB1E7FBFBF
        BFBFBFBFBFBF377F01FD1EFB1E37FFFFFFFFFFFFFFFFFBFF01FD1EFB371E1E1E
        1E1E1E1E1E1E1E1E01FD1EBF7F7F7F7F7FFFFFFFFFFF1E0BFDFD1EFFBFBFBFBF
        FF1E1E1E1E1E1EFDFDFDFD27FFFFFFFF1EFDFDFDFDFDFDFDFDFDFDFD27272727
        FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD}
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnSelFileClick
    end
    object LabelMUser: TLabel
      Left = 114
      Top = 28
      Width = 22
      Height = 13
      Caption = 'User'
    end
    object LabelMPswd: TLabel
      Left = 212
      Top = 27
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object LabelTUser: TLabel
      Left = 460
      Top = 27
      Width = 22
      Height = 13
      Caption = 'User'
    end
    object LabelTPswd: TLabel
      Left = 556
      Top = 27
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object Label4: TLabel
      Left = 9
      Top = 77
      Width = 93
      Height = 13
      Caption = 'Master Table Name'
    end
    object Label5: TLabel
      Left = 352
      Top = 77
      Width = 92
      Height = 13
      Caption = 'Target Table Name'
    end
    object Label6: TLabel
      Left = 9
      Top = 160
      Width = 72
      Height = 13
      Caption = 'Compare Mode'
    end
    object LabelCustomFlds: TLabel
      Left = 207
      Top = 159
      Width = 86
      Height = 13
      Caption = 'Custom Key Fields'
    end
    object Label8: TLabel
      Left = 454
      Top = 161
      Width = 94
      Height = 13
      Caption = 'Exclude Data Fields'
    end
    object Label3: TLabel
      Left = 9
      Top = 104
      Width = 81
      Height = 13
      Caption = 'Master SQL Filter'
    end
    object Label7: TLabel
      Left = 352
      Top = 104
      Width = 80
      Height = 13
      Caption = 'Target SQL Filter'
    end
    object Label9: TLabel
      Left = 9
      Top = 193
      Width = 25
      Height = 13
      Caption = 'Allow'
    end
    object fnDatabaseMaster: TEdit
      Left = 9
      Top = 47
      Width = 304
      Height = 21
      TabOrder = 0
    end
    object fnDatabaseTarget: TEdit
      Left = 352
      Top = 47
      Width = 305
      Height = 21
      TabOrder = 3
    end
    object EditMUser: TEdit
      Left = 142
      Top = 25
      Width = 59
      Height = 21
      TabOrder = 1
      Text = 'SYSDBA'
    end
    object EditMPswd: TEdit
      Left = 264
      Top = 25
      Width = 73
      Height = 21
      PasswordChar = '#'
      TabOrder = 2
      Text = 'masterkey'
    end
    object EditTUser: TEdit
      Left = 486
      Top = 25
      Width = 59
      Height = 21
      TabOrder = 4
      Text = 'SYSDBA'
    end
    object EditTPswd: TEdit
      Left = 608
      Top = 25
      Width = 73
      Height = 21
      PasswordChar = '#'
      TabOrder = 5
      Text = 'masterkey'
    end
    object EditTableM: TEdit
      Left = 142
      Top = 74
      Width = 195
      Height = 21
      TabOrder = 6
      OnChange = EditTableMChange
    end
    object EditTableT: TEdit
      Left = 486
      Top = 74
      Width = 193
      Height = 21
      TabOrder = 7
    end
    object BtnDataCompare: TBitBtn
      Left = 527
      Top = 214
      Width = 73
      Height = 23
      Caption = 'Compare'
      TabOrder = 16
      OnClick = BtnDataCompareClick
    end
    object BtnUpdate: TBitBtn
      Left = 606
      Top = 214
      Width = 73
      Height = 23
      Caption = 'Update'
      TabOrder = 17
      OnClick = BtnUpdateClick
    end
    object cbCompareMode: TComboBox
      Left = 87
      Top = 156
      Width = 97
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 10
      Text = 'All fields'
      Items.Strings = (
        'All fields'
        'Primary key'
        'Unique'
        'Custom fields'
        'Auto')
    end
    object EditCustomFlds: TEdit
      Left = 302
      Top = 156
      Width = 145
      Height = 21
      TabOrder = 11
    end
    object EditExclFlds: TEdit
      Left = 550
      Top = 156
      Width = 129
      Height = 21
      TabOrder = 12
    end
    object EditFilterM: TEdit
      Left = 9
      Top = 123
      Width = 328
      Height = 21
      TabOrder = 8
    end
    object EditFilterT: TEdit
      Left = 353
      Top = 123
      Width = 326
      Height = 21
      TabOrder = 9
    end
    object cbInsert: TCheckBox
      Left = 87
      Top = 192
      Width = 97
      Height = 17
      Caption = 'INSERT'
      Checked = True
      State = cbChecked
      TabOrder = 13
    end
    object cbUpdate: TCheckBox
      Left = 207
      Top = 192
      Width = 97
      Height = 17
      Caption = 'UPDATE'
      Checked = True
      State = cbChecked
      TabOrder = 14
    end
    object cbDelete: TCheckBox
      Left = 302
      Top = 192
      Width = 97
      Height = 17
      Caption = 'DELETE'
      Checked = True
      State = cbChecked
      TabOrder = 15
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 249
    Width = 350
    Height = 265
    Align = alLeft
    Caption = 'Log...'
    TabOrder = 1
    ExplicitTop = 290
    ExplicitHeight = 224
    object MemoExtr: TRichEdit
      Left = 2
      Top = 15
      Width = 346
      Height = 248
      Align = alClient
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Lines.Strings = (
        'MemoExtr')
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      WordWrap = False
      Zoom = 100
      ExplicitWidth = 381
      ExplicitHeight = 114
    end
  end
  object GroupBox3: TGroupBox
    Left = 355
    Top = 249
    Width = 333
    Height = 265
    Align = alClient
    Caption = 'Result Script...'
    TabOrder = 2
    ExplicitLeft = 388
    ExplicitTop = 313
    ExplicitWidth = 300
    ExplicitHeight = 131
    object MemoResult: TMemo
      Left = 2
      Top = 15
      Width = 329
      Height = 248
      Align = alClient
      Lines.Strings = (
        'MemoResult')
      ScrollBars = ssVertical
      TabOrder = 0
      WordWrap = False
      ExplicitWidth = 296
      ExplicitHeight = 114
    end
  end
  object Gauge1: TProgressBar
    Left = 8
    Top = 218
    Width = 153
    Height = 19
    TabOrder = 3
  end
  object Gauge2: TProgressBar
    Left = 352
    Top = 218
    Width = 153
    Height = 19
    TabOrder = 4
  end
  object TableDataComparer: TTableDataComparer
    DBCConnectionMaster = DataMd.DBCConnection1
    DBCConnectionTarget = DataMd.DBCConnection2
    ScriptFileName = 'Result.SQL'
    BlobFileName = 'Result.LOB'
    SQLExec = IBSQLExec
    OnLogNextLine = LogNextLine
    OnErrorMessage = LogNextLine
    OnProgressUpdateMaster = TableDataComparerProgressUpdateMaster
    OnProgressUpdateTarget = TableDataComparerProgressUpdateTarget
    OnGetSelectSQL = TableDataComparerGetSelectSQL
    OnGetCountSQL = TableDataComparerGetCountSQL
    Left = 144
    Top = 392
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Firebird Databases (*.FDB)|*.fdb|All Files (*.*)|*.*'
    Left = 144
    Top = 320
  end
  object IBSQLExec: TIBSQLExec
    IBServerOptions.SQLServerVersion = st_Firebird_30
    DBCConnection = DataMd.DBCConnection2
    OnLogNextLine = LogNextLine
    OnProgressUpdate = ProgressUpdate
    OnErrorMessage = LogNextLine
    Left = 272
    Top = 392
  end
end
