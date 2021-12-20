object DataMd: TDataMd
  Height = 209
  Width = 288
  PixelsPerInch = 96
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
    Left = 40
    Top = 24
  end
  object UniConnection2: TUniConnection
    Left = 40
    Top = 88
  end
end
