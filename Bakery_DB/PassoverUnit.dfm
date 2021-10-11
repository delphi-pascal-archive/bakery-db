object PassoverForm: TPassoverForm
  Left = 464
  Top = 248
  Width = 215
  Height = 341
  Caption = #1044#1085#1080' '#1055#1072#1089#1093#1080
  Color = clBtnFace
  Constraints.MaxWidth = 215
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
    Top = 273
    Width = 207
    Height = 41
    Align = alBottom
    TabOrder = 0
    object DBNavigator1: TDBNavigator
      Left = 1
      Top = 1
      Width = 205
      Height = 39
      DataSource = DataSource
      Align = alClient
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 207
    Height = 273
    Align = alClient
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 205
      Height = 271
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
    TableName = 'Passover'
    Left = 152
    Top = 48
    object Tableid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
      Visible = False
    end
    object TableDate: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1055#1072#1089#1093#1080
      FieldName = 'Date'
    end
  end
  object DataSource: TDataSource
    DataSet = Table
    Left = 152
    Top = 16
  end
end
