object HolidayForm: THolidayForm
  Left = 401
  Top = 195
  Width = 310
  Height = 319
  Caption = #1055#1088#1072#1079#1076#1085#1080#1095#1085#1099#1077' '#1076#1085#1080
  Color = clBtnFace
  Constraints.MaxWidth = 310
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 251
    Width = 302
    Height = 41
    Align = alBottom
    TabOrder = 0
    object DBNavigator1: TDBNavigator
      Left = 1
      Top = 1
      Width = 300
      Height = 39
      DataSource = DataSource
      Align = alClient
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 302
    Height = 251
    Align = alClient
    TabOrder = 1
    object Grid: TDBGrid
      Left = 1
      Top = 1
      Width = 300
      Height = 249
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
  object DataSource: TDataSource
    DataSet = Table
    Left = 48
    Top = 192
  end
  object Table: TADOTable
    Active = True
    Connection = DM.MainConnection
    CursorType = ctStatic
    TableName = 'HoliDays'
    Left = 8
    Top = 192
    object Tableid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
      Visible = False
    end
    object Tablemonth: TIntegerField
      DisplayLabel = #1052#1077#1089#1103#1094
      FieldName = 'month'
    end
    object Tableday: TIntegerField
      DisplayLabel = #1044#1077#1085#1100
      FieldName = 'day'
    end
    object TableisOffDay: TBooleanField
      DisplayLabel = #1057#1095#1080#1090#1072#1090#1100' '#1074#1099#1093#1086#1076#1085#1099#1084' '#1076#1085#1077#1084
      FieldName = 'isOffDay'
      DisplayValues = #1044#1072';'#1053#1077#1090
    end
  end
end
