object FeedOutForm: TFeedOutForm
  Left = 328
  Top = 296
  BorderStyle = bsDialog
  Caption = #1057#1087#1080#1089#1072#1085#1080#1077' '#1089#1086' '#1089#1082#1083#1072#1076#1072' ('#1080#1085#1074#1077#1085#1090#1072#1088#1080#1079#1072#1094#1080#1103')'
  ClientHeight = 99
  ClientWidth = 426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 237
    Height = 13
    Caption = #1055#1088#1086#1074#1077#1089#1090#1080' '#1089#1087#1080#1089#1072#1085#1080#1077' '#1089#1086' '#1089#1082#1083#1072#1076#1072' '#1074' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086
  end
  object Label2: TLabel
    Left = 8
    Top = 37
    Width = 6
    Height = 13
    Caption = #1089
  end
  object Label3: TLabel
    Left = 216
    Top = 37
    Width = 12
    Height = 13
    Caption = #1087#1086
  end
  object DateStart: TDateTimePicker
    Left = 24
    Top = 32
    Width = 186
    Height = 21
    Date = 39945.438038784720000000
    Time = 39945.438038784720000000
    TabOrder = 0
  end
  object DateEnd: TDateTimePicker
    Left = 232
    Top = 32
    Width = 186
    Height = 21
    Date = 39945.438462893520000000
    Time = 39945.438462893520000000
    TabOrder = 1
  end
  object OkButton: TButton
    Left = 344
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 2
    OnClick = OkButtonClick
  end
end
