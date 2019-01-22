object DataMdIbx: TDataMdIbx
  OldCreateOrder = False
  Left = 202
  Top = 184
  Height = 209
  Width = 288
  object IBDatabase1: TIBDatabase
    Params.Strings = (
      '')
    LoginPrompt = False
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    AllowStreamedConnected = False
    Left = 40
    Top = 24
  end
  object IBDatabase2: TIBDatabase
    LoginPrompt = False
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    AllowStreamedConnected = False
    Left = 40
    Top = 80
  end
  object DBCConnection1: TDBCConnectionIBX
    Database = IBDatabase1
    OnBeforeConnect = DBCConnection1BeforeConnect
    Left = 144
    Top = 24
  end
  object DBCConnection2: TDBCConnectionIBX
    Database = IBDatabase2
    OnBeforeConnect = DBCConnection2BeforeConnect
    Left = 144
    Top = 80
  end
end
