object FreeLimitFrame: TFreeLimitFrame
  Left = 0
  Top = 0
  Width = 320
  Height = 240
  TabOrder = 0
  object Chart: TChart
    Left = 0
    Top = 0
    Width = 320
    Height = 240
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      #1057#1074#1086#1073#1086#1076#1085#1099#1077' '#1088#1077#1089#1091#1088#1089#1099' '#1089#1082#1083#1072#1076#1072' ('#1085#1072' '#1090#1077#1082#1091#1097#1091#1102' '#1076#1072#1090#1091')')
    AxisVisible = False
    LeftAxis.Logarithmic = True
    View3D = False
    Align = alClient
    TabOrder = 0
    object Series1: TBarSeries
      ColorEachPoint = True
      Marks.ArrowLength = 20
      Marks.Style = smsValue
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
