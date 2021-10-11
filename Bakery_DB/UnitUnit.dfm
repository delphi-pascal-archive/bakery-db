object UnitForm: TUnitForm
  Left = 386
  Top = 204
  Width = 300
  Height = 342
  Caption = #1045#1076#1080#1085#1080#1094#1099' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
  Color = clBtnFace
  Constraints.MaxWidth = 300
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
    Top = 274
    Width = 292
    Height = 41
    Align = alBottom
    TabOrder = 0
    object DBNavigator1: TDBNavigator
      Left = 1
      Top = 1
      Width = 290
      Height = 39
      DataSource = DataSource
      Align = alClient
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 292
    Height = 274
    Align = alClient
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 290
      Height = 272
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
    TableName = 'Units'
    Left = 112
    Top = 136
    object Tableid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
      Visible = False
    end
    object TableName: TWideStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'Name'
      Size = 10
    end
  end
  object DataSource: TDataSource
    DataSet = Table
    Left = 152
    Top = 136
  end
end
