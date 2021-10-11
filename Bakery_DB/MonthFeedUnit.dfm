object MonthFeedFrame: TMonthFeedFrame
  Left = 0
  Top = 0
  Width = 498
  Height = 373
  TabOrder = 0
  object Chart: TChart
    Left = 0
    Top = 0
    Width = 498
    Height = 373
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1089#1099#1088#1100#1103' '#1090#1088#1077#1073#1091#1077#1084#1086#1075#1086' '#1085#1072' '#1073#1083#1080#1078#1072#1081#1096#1080#1081' '#1084#1077#1089#1103#1094' '
      '('#1086#1090' '#1090#1077#1082#1091#1097#1077#1081' '#1076#1072#1090#1099')')
    AxisVisible = False
    LeftAxis.Logarithmic = True
    Align = alClient
    TabOrder = 0
    object Series1: TBarSeries
      ColorEachPoint = True
      Marks.ArrowLength = 20
      Marks.Visible = True
      SeriesColor = clRed
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Bar'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
  end
end
