object DataMd: TDataMd
  OldCreateOrder = False
  Height = 209
  Width = 288
  object DBCConnection1: TDBCConnectionFireDAC
    Database = FDConnection1
    OnBeforeConnect = DBCConnection1BeforeConnect
    Left = 144
    Top = 24
  end
  object DBCConnection2: TDBCConnectionFireDAC
    Database = FDConnection2
    OnBeforeConnect = DBCConnection2BeforeConnect
    Left = 144
    Top = 80
  end
  object FDConnection1: TFDConnection
    Left = 48
    Top = 32
  end
  object FDConnection2: TFDConnection
    Left = 48
    Top = 88
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 48
    Top = 144
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 144
    Top = 144
  end
end
