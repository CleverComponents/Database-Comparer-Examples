object DataMd: TDataMd
  OldCreateOrder = False
  Height = 209
  Width = 288
  object DBCConnection1: TDBCConnectionUniDAC
    Database = UniConnection1
    OnBeforeConnect = DBCConnection1BeforeConnect
    Left = 144
    Top = 24
  end
  object DBCConnection2: TDBCConnectionUniDAC
    Database = UniConnection2
    OnBeforeConnect = DBCConnection2BeforeConnect
    Left = 144
    Top = 80
  end
  object UniConnection1: TUniConnection
    LoginPrompt = False
    Left = 48
    Top = 24
  end
  object UniConnection2: TUniConnection
    LoginPrompt = False
    Left = 48
    Top = 80
  end
  object InterBaseUniProvider1: TInterBaseUniProvider
    Left = 144
    Top = 144
  end
end
