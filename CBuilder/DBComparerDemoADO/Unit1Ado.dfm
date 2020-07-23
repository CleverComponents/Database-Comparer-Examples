object Form1: TForm1
  Left = 29
  Top = 112
  Width = 696
  Height = 480
  Caption = 'DB Comparer Demo (MS SQL)'
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
    Left = 385
    Top = 131
    Width = 3
    Height = 315
    Cursor = crHSplit
    Beveled = True
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 688
    Height = 131
    Align = alTop
    Caption = 'Databases...'
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 41
      Height = 13
      Caption = 'Master...'
    end
    object Label2: TLabel
      Left = 352
      Top = 16
      Width = 40
      Height = 13
      Caption = 'Target...'
    end
    object BtnSelDatabaseMaster: TSpeedButton
      Left = 312
      Top = 56
      Width = 23
      Height = 22
      Hint = 'Select Master Database'
      Enabled = False
      Flat = True
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
      Top = 56
      Width = 23
      Height = 22
      Hint = 'Select Target Database'
      Enabled = False
      Flat = True
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
      Left = 92
      Top = 12
      Width = 22
      Height = 13
      Caption = 'User'
    end
    object LabelMPswd: TLabel
      Left = 204
      Top = 12
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object LabelTUser: TLabel
      Left = 436
      Top = 12
      Width = 22
      Height = 13
      Caption = 'User'
    end
    object LabelTPswd: TLabel
      Left = 548
      Top = 12
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object BtnSelScriptMaster: TSpeedButton
      Left = 312
      Top = 80
      Width = 23
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
    object BtnSelScriptTarget: TSpeedButton
      Left = 656
      Top = 80
      Width = 23
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
    object fnScriptMaster: TEdit
      Left = 80
      Top = 80
      Width = 233
      Height = 21
      TabOrder = 10
      Text = 'fnScriptMaster'
    end
    object EditDbMaster: TEdit
      Left = 80
      Top = 56
      Width = 233
      Height = 21
      TabOrder = 7
      Text = 'EditDbMaster'
    end
    object EditDbTarget: TEdit
      Left = 424
      Top = 56
      Width = 233
      Height = 21
      TabOrder = 9
      Text = 'EditDbTarget'
    end
    object EditMUser: TEdit
      Left = 118
      Top = 10
      Width = 73
      Height = 21
      TabOrder = 0
    end
    object EditMPswd: TEdit
      Left = 254
      Top = 10
      Width = 81
      Height = 21
      PasswordChar = '#'
      TabOrder = 1
    end
    object EditTUser: TEdit
      Left = 462
      Top = 10
      Width = 73
      Height = 21
      TabOrder = 2
    end
    object EditTPswd: TEdit
      Left = 598
      Top = 10
      Width = 81
      Height = 21
      PasswordChar = '#'
      TabOrder = 3
    end
    object BtnExtract: TBitBtn
      Left = 8
      Top = 103
      Width = 75
      Height = 21
      Caption = 'Extract'
      TabOrder = 12
      OnClick = BtnExtractClick
    end
    object BtnCompare: TBitBtn
      Left = 88
      Top = 103
      Width = 75
      Height = 21
      Caption = 'Compare'
      TabOrder = 13
      OnClick = BtnCompareClick
    end
    object fnScriptTarget: TEdit
      Left = 424
      Top = 80
      Width = 233
      Height = 21
      TabOrder = 11
      Text = 'fnScriptTarget'
    end
    object Panel1: TPanel
      Left = 1
      Top = 56
      Width = 80
      Height = 45
      BevelOuter = bvNone
      TabOrder = 6
      object rbMasterFromDatabase: TRadioButton
        Left = 4
        Top = 2
        Width = 71
        Height = 17
        Caption = 'Database'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = rbFromClick
      end
      object rbMasterFromScript: TRadioButton
        Left = 4
        Top = 26
        Width = 71
        Height = 17
        Caption = 'Script'
        TabOrder = 1
        OnClick = rbFromClick
      end
    end
    object Panel2: TPanel
      Left = 345
      Top = 56
      Width = 80
      Height = 45
      BevelOuter = bvNone
      TabOrder = 8
      object rbTargetFromDatabase: TRadioButton
        Left = 4
        Top = 2
        Width = 71
        Height = 17
        Caption = 'Database'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = rbFromClick
      end
      object rbTargetFromScript: TRadioButton
        Left = 4
        Top = 26
        Width = 71
        Height = 17
        Caption = 'Script'
        TabOrder = 1
        OnClick = rbFromClick
      end
    end
    object BtnUpdate: TBitBtn
      Left = 168
      Top = 103
      Width = 75
      Height = 21
      Caption = 'Update'
      TabOrder = 14
      OnClick = BtnUpdateClick
    end
    object Panel3: TPanel
      Left = 0
      Top = 33
      Width = 337
      Height = 21
      BevelOuter = bvNone
      TabOrder = 4
      object LabelSrvM: TLabel
        Left = 8
        Top = 3
        Width = 34
        Height = 13
        Caption = 'Server:'
      end
      object LabelAuthM: TLabel
        Left = 152
        Top = 4
        Width = 71
        Height = 13
        Caption = 'Authentication:'
      end
      object EditHostM: TEdit
        Left = 48
        Top = 0
        Width = 89
        Height = 21
        TabOrder = 0
      end
      object rbMWin: TRadioButton
        Left = 232
        Top = 3
        Width = 49
        Height = 17
        Caption = 'Win'
        Checked = True
        TabOrder = 1
        TabStop = True
      end
      object rbMSql: TRadioButton
        Left = 280
        Top = 3
        Width = 49
        Height = 17
        Caption = 'SQL'
        TabOrder = 2
      end
    end
    object Panel4: TPanel
      Left = 344
      Top = 33
      Width = 337
      Height = 21
      BevelOuter = bvNone
      TabOrder = 5
      object LabelSrvT: TLabel
        Left = 8
        Top = 3
        Width = 34
        Height = 13
        Caption = 'Server:'
      end
      object LabelAuthT: TLabel
        Left = 152
        Top = 4
        Width = 71
        Height = 13
        Caption = 'Authentication:'
      end
      object EditHostT: TEdit
        Left = 48
        Top = 0
        Width = 89
        Height = 21
        TabOrder = 0
      end
      object rbTWin: TRadioButton
        Left = 232
        Top = 3
        Width = 49
        Height = 17
        Caption = 'Win'
        Checked = True
        TabOrder = 1
        TabStop = True
      end
      object rbTSql: TRadioButton
        Left = 280
        Top = 3
        Width = 49
        Height = 17
        Caption = 'SQL'
        TabOrder = 2
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 131
    Width = 385
    Height = 315
    Align = alLeft
    Caption = 'Log...'
    TabOrder = 1
    object MemoLog: TRichEdit
      Left = 2
      Top = 15
      Width = 381
      Height = 298
      Align = alClient
      Lines.Strings = (
        'MemoExtr')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      WordWrap = False
    end
  end
  object GroupBox3: TGroupBox
    Left = 388
    Top = 131
    Width = 300
    Height = 315
    Align = alClient
    Caption = 'Result Script...'
    TabOrder = 2
    object MemoResult: TMemo
      Left = 2
      Top = 15
      Width = 296
      Height = 298
      Align = alClient
      Lines.Strings = (
        'MemoResult')
      ScrollBars = ssVertical
      TabOrder = 0
      WordWrap = False
    end
  end
  object Gauge1: TProgressBar
    Left = 345
    Top = 106
    Width = 178
    Height = 19
    Min = 0
    Max = 100
    TabOrder = 3
  end
  object OpenDialog1: TOpenDialog
    Filter = 'InterBase Databases (*.GDB)|*.gdb|All Files (*.*)|*.*'
    Left = 448
    Top = 168
  end
  object DBStructure1: TDBStructure
    Left = 304
    Top = 304
  end
  object DBStructure2: TDBStructure
    Left = 304
    Top = 368
  end
  object DBComparer1: TDBComparer
    DBStructureMaster = DBStructure1
    DBStructureTarget = DBStructure2
    SQLExec = MSSQLExec1
    OnProgressUpdate = ProgressUpdate
    OnLogNextLine = LogNextLine
    OnErrorMessage = LogNextLine
    Left = 424
    Top = 336
  end
  object DBCConnectionADO1: TDBCConnectionADO
    Connection = DataMdMS.ADOConnection1
    OnErrorMessage = LogNextLine
    Left = 520
    Top = 208
  end
  object DBCConnectionADO2: TDBCConnectionADO
    Connection = DataMdMS.ADOConnection2
    OnErrorMessage = LogNextLine
    Left = 520
    Top = 256
  end
  object MSSQLExec1: TMSSQLExec
    DBCConnection = DBCConnectionADO2
    OnLogNextLine = LogNextLine
    OnProgressUpdate = ProgressUpdate
    OnErrorMessage = LogNextLine
    Left = 520
    Top = 320
  end
  object MSSQLScriptExtract1: TMSSQLScriptExtract
    DBStructure = DBStructure1
    OnProgressUpdate = ProgressUpdate
    OnLogNextLine = LogNextLine
    OnErrorMessage = LogNextLine
    Left = 144
    Top = 176
  end
  object MSSQLScriptExtract2: TMSSQLScriptExtract
    DBStructure = DBStructure2
    OnProgressUpdate = ProgressUpdate
    OnLogNextLine = LogNextLine
    OnErrorMessage = LogNextLine
    Left = 144
    Top = 224
  end
  object MSSQLDBExtract1: TMSSQLDBExtract
    DBCConnection = DBCConnectionADO1
    DBStructure = DBStructure1
    ShowFullLog = False
    OnProgressUpdate = ProgressUpdate
    OnLogNextLine = LogNextLine
    OnErrorMessage = LogNextLine
    Left = 144
    Top = 288
  end
  object MSSQLDBExtract2: TMSSQLDBExtract
    DBCConnection = DBCConnectionADO2
    DBStructure = DBStructure2
    ShowFullLog = False
    OnProgressUpdate = ProgressUpdate
    OnLogNextLine = LogNextLine
    OnErrorMessage = LogNextLine
    Left = 144
    Top = 336
  end
end
