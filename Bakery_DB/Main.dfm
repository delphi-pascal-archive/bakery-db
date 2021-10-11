object MainForm: TMainForm
  Left = 225
  Top = 131
  Width = 870
  Height = 693
  Caption = #1056#1072#1073#1086#1090#1072' '#1087#1077#1082#1072#1088#1085#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object Splitter1: TSplitter
    Left = 0
    Top = 245
    Width = 862
    Height = 4
    Cursor = crVSplit
    Align = alBottom
  end
  object ChartPanel: TPanel
    Left = 0
    Top = 249
    Width = 862
    Height = 392
    Align = alBottom
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 862
    Height = 245
    Align = alClient
    TabOrder = 1
    object Splitter2: TSplitter
      Left = 349
      Top = 1
      Height = 243
      Align = alRight
    end
    object Panel1: TPanel
      Left = 352
      Top = 1
      Width = 509
      Height = 243
      Align = alRight
      TabOrder = 0
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 348
      Height = 243
      Align = alClient
      TabOrder = 1
    end
  end
  object MainMenu: TMainMenu
    Left = 456
    Top = 8
    object MFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object N3: TMenuItem
        Caption = '-'
      end
      object MFExit: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = MFExitClick
      end
    end
    object MNSI: TMenuItem
      Caption = #1053'.'#1057'.'#1048'.'
      object MNFeed: TMenuItem
        Caption = #1057#1099#1088#1100#1077
        OnClick = MNFeedClick
      end
      object MNHolidays: TMenuItem
        Caption = #1055#1088#1072#1079#1076#1085#1080#1095#1085#1099#1077' '#1076#1085#1080
        OnClick = MNHolidaysClick
      end
      object MNPassover: TMenuItem
        Caption = #1044#1085#1080' '#1055#1072#1089#1093#1080
        OnClick = MNPassoverClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object MNRate: TMenuItem
        Caption = #1053#1086#1088#1084#1099' '#1088#1072#1089#1093#1086#1076#1099' '#1089#1099#1088#1100#1103
        OnClick = MNRateClick
      end
      object MNStore: TMenuItem
        Caption = #1042#1084#1077#1089#1090#1080#1084#1086#1089#1090#1100' '#1089#1082#1083#1072#1076#1072
        OnClick = MNStoreClick
      end
    end
    object MStorage: TMenuItem
      Caption = #1057#1082#1083#1072#1076
      object MSIn: TMenuItem
        Caption = #1055#1088#1080#1093#1086#1076
        OnClick = MSInClick
      end
      object MSOut: TMenuItem
        Caption = #1057#1087#1080#1089#1072#1085#1080#1077' ('#1080#1085#1074#1077#1085#1090#1072#1088#1080#1079#1072#1094#1080#1103')'
        OnClick = MSOutClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object N2: TMenuItem
        Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1088#1077#1089#1091#1088#1089#1099' '#1087#1077#1082#1072#1088#1085#1080
        OnClick = N2Click
      end
    end
  end
end
