object StoreFrame: TStoreFrame
  Left = 0
  Top = 0
  Width = 741
  Height = 583
  TabOrder = 0
  object Chart: TChart
    Left = 0
    Top = 0
    Width = 741
    Height = 583
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1089#1082#1083#1072#1076#1072' '#1085#1072' '#1090#1077#1082#1091#1097#1091#1102' '#1076#1072#1090#1091)
    BottomAxis.LabelsAngle = 90
    BottomAxis.LabelsMultiLine = True
    LeftAxis.LabelsMultiLine = True
    LeftAxis.Logarithmic = True
    LeftAxis.Visible = False
    Legend.Alignment = laBottom
    Align = alClient
    TabOrder = 0
    object Series1: TBarSeries
      Marks.ArrowLength = 20
      Marks.Style = smsValue
      Marks.Visible = True
      SeriesColor = clRed
      Title = #1051#1080#1084#1080#1090
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Bar'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series2: TBarSeries
      Marks.ArrowLength = 20
      Marks.Visible = True
      SeriesColor = clGreen
      Title = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1085#1072' '#1089#1082#1083#1072#1076#1077
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
