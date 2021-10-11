object RateForm: TRateForm
  Left = 316
  Top = 224
  Width = 700
  Height = 338
  Caption = #1053#1086#1088#1084#1099' '#1088#1072#1089#1093#1086#1076#1072' '#1089#1099#1088#1100#1103
  Color = clBtnFace
  Constraints.MaxWidth = 700
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
    Top = 270
    Width = 692
    Height = 41
    Align = alBottom
    TabOrder = 0
    object DBNavigator1: TDBNavigator
      Left = 1
      Top = 1
      Width = 690
      Height = 39
      DataSource = DataSource
      Align = alClient
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 692
    Height = 270
    Align = alClient
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 690
      Height = 268
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
    TableName = 'Rate'
    Left = 8
    Top = 192
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
      DisplayWidth = 12
      FieldName = 'id_feed'
      Visible = False
    end
    object Tableday: TFloatField
      DisplayLabel = #1054#1073#1099#1095#1085#1099#1081' '#1076#1077#1085#1100
      DisplayWidth = 15
      FieldName = 'day'
      Precision = 4
    end
    object Tableday_off: TFloatField
      DisplayLabel = #1055#1085'., '#1042#1090'., '#1055#1090'., '#1057#1073'.'
      DisplayWidth = 19
      FieldName = 'day_off'
      Precision = 4
    end
    object Tableholiday: TFloatField
      DisplayLabel = #1055#1088#1072#1079#1076#1085#1080#1095#1085#1099#1081' '#1076#1077#1085#1100
      DisplayWidth = 21
      FieldName = 'holiday'
      Precision = 4
    end
    object Tablepassover: TFloatField
      DisplayLabel = #1055#1072#1089#1093#1072
      DisplayWidth = 9
      FieldName = 'passover'
      Precision = 4
    end
  end
  object DataSource: TDataSource
    DataSet = Table
    Left = 40
    Top = 192
  end
  object FeedTable: TADOTable
    Active = True
    Connection = DM.MainConnection
    CursorType = ctStatic
    TableName = 'Feed'
    Left = 8
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
end
