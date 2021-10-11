object FeedForm: TFeedForm
  Left = 357
  Top = 211
  Width = 660
  Height = 362
  Caption = #1057#1099#1088#1100#1077
  Color = clBtnFace
  Constraints.MaxWidth = 660
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
    Top = 294
    Width = 652
    Height = 41
    Align = alBottom
    TabOrder = 0
    object DBNavigator1: TDBNavigator
      Left = 1
      Top = 1
      Width = 650
      Height = 39
      DataSource = DataSource
      Align = alClient
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 652
    Height = 294
    Align = alClient
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 650
      Height = 292
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
    TableName = 'Feed'
    Left = 48
    Top = 192
    object TableName: TWideStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'Name'
      Size = 100
    end
    object Tableid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
      Visible = False
    end
  end
  object DataSource: TDataSource
    DataSet = Table
    Left = 16
    Top = 192
  end
end
