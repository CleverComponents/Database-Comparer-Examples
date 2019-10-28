object DataMd: TDataMd
  OldCreateOrder = False
  Height = 209
  Width = 288
  object FDConnection1: TFDConnection
    LoginPrompt = False
    Left = 64
    Top = 24
  end
  object FDConnection2: TFDConnection
    LoginPrompt = False
    Left = 64
    Top = 80
  end
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
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 64
    Top = 128
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 144
    Top = 128
  end
end
