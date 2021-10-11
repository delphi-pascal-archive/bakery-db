object DM: TDM
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Left = 303
  Top = 195
  Height = 264
  Width = 360
  object MainConnection: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Persist Security Info=False;Data Source='#1041#1072#1079#1072' ' +
      #1076#1072#1085#1085#1099#1093' MS Access;Initial Catalog=F:\Projects\Bakery\bakery.mdb'
    LoginPrompt = False
    Provider = 'MSDASQL.1'
    Left = 40
    Top = 16
  end
  object Query: TADOQuery
    Connection = MainConnection
    Parameters = <>
    Left = 40
    Top = 76
  end
end
