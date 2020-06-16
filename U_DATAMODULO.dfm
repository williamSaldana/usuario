object DataModule2: TDataModule2
  OldCreateOrder = False
  Height = 150
  Width = 215
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=Epsi062019*;Persist Security Info=T' +
      'rue;User ID=sa;Initial Catalog=usuario'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 24
    Top = 8
  end
end
