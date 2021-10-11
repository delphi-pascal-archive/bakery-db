unit FreeLimitsUtit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, TeeProcs, TeEngine, Chart, Series;

type
  TFreeLimitFrame = class(TFrame)
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

{ TFreeLimitFrame }

procedure TFreeLimitFrame.RefreshData(aDate: TDate);
var
  FeedInfo:TFreeFeedsInfo;
  i:integer;
begin
  DM.GetFreeFeedsInfo(FeedInfo,aDate);
  Chart.Series[0].Clear;
  for i:=Low(FeedInfo) to High(FeedInfo) do
    Chart.Series[0].Add(FeedInfo[i].FreeLimit,FeedInfo[i].Name);
end;

end.
