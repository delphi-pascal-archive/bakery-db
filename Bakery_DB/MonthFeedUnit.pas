unit MonthFeedUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart;

type
  TMonthFeedFrame = class(TFrame)
    Chart: TChart;
    Series1: TBarSeries;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RefreshData(aDate:TDate);
  end;

implementation

uses projectutils, DataModule;

{$R *.dfm}

{ TFrame1 }

procedure TMonthFeedFrame.RefreshData(aDate: TDate);
var
  FeedNeed:TFreeFeedsInfo;
  i:integer;
begin
  DM.NeedFeedsInMonth(FeedNeed,aDate);
  Chart.Series[0].Clear;
  for i:=Low(FeedNeed) to High(FeedNeed) do
    Chart.Series[0].Add(FeedNeed[i].FreeLimit,FeedNeed[i].Name);

end;

end.
