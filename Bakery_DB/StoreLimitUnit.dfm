object StoreLimitForm: TStoreLimitForm
  Left = 389
  Top = 192
  Width = 520
  Height = 343
  Caption = #1042#1084#1077#1089#1090#1080#1084#1086#1089#1090#1100' '#1089#1082#1083#1072#1076#1072
  Color = clBtnFace
  Constraints.MaxWidth = 520
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 275
    Width = 512
    Height = 41
    Align = alBottom
    TabOrder = 0
    object DBNavigator1: TDBNavigator
      Left = 1
      Top = 1
      Width = 510
      Height = 39
      DataSource = DataSource
      Align = alClient
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 512
    Height = 275
    Align = alClient
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 510
      Height = 273
      Align = alClient
      DataSource = DataSource
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object Table: TADOTable
    Active = True
    Connection = DM.MainConnection
    CursorType = ctStatic
    BeforeDelete = TableBeforeDelete
    TableName = 'StoreLimits'
    Left = 432
    Top = 8
    object TableName: TStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      DisplayWidth = 24
      FieldKind = fkLookup
      FieldName = 'Name'
      LookupDataSet = FeedTable
      LookupKeyFields = 'id'
      LookupResultField = 'Name'
      KeyFields = 'id_feed'
      Lookup = True
    end
    object Tableid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
      Visible = False
    end
    object Tableid_feed: TIntegerField
      FieldName = 'id_feed'
      Visible = False
    end
    object Tablecapacity: TIntegerField
      DisplayLabel = #1042#1084#1077#1089#1090#1080#1084#1086#1089#1090#1100
      DisplayWidth = 14
      FieldName = 'capacity'
    end
    object Tablereserv: TIntegerField
      DisplayLabel = #1044#1086#1087'. '#1088#1077#1079#1077#1088#1074
      DisplayWidth = 13
      FieldName = 'reserv'
    end
    object Tableunit: TIntegerField
      FieldName = 'unit'
      Visible = False
    end
    object TableUnitName: TStringField
      DisplayLabel = #1045#1076'. '#1080#1079#1084'.'
      DisplayWidth = 11
      FieldKind = fkLookup
      FieldName = 'UnitName'
      LookupDataSet = UnitTable
      LookupKeyFields = 'id'
      LookupResultField = 'Name'
      KeyFields = 'unit'
      Lookup = True
    end
  end
  object FeedTable: TADOTable
    Active = True
    Connection = DM.MainConnection
    CursorType = ctStatic
    TableName = 'Feed'
    Left = 416
    Top = 224
    object FeedTableid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object FeedTableName: TWideStringField
      FieldName = 'Name'
      Size = 100
    end
  end
  object UnitTable: TADOTable
    Active = True
    Connection = DM.MainConnection
    CursorType = ctStatic
    TableName = 'Units'
    Left = 448
    Top = 224
    object UnitTableid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object UnitTableName: TWideStringField
      FieldName = 'Name'
      Size = 10
    end
  end
  object DataSource: TDataSource
    DataSet = Table
    Left = 392
    Top = 8
  end
end
