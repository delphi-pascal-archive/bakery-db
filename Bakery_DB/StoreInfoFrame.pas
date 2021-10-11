unit StoreInfoFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart;

type
  TStoreFrame = class(TFrame)
    Chart: TChart;
    Series1: TBarSeries;
    Series2: TBarSeries;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RefreshData(aDate:TDate);
  end;

implementation

uses DataModule, projectutils;

{$R *.dfm}

{ TStoreFrame }

procedure TStoreFrame.RefreshData(aDate:TDate);
var
  FeedInfo:TFeedsInfo;
  i:integer;
begin
  DM.GetFeedsInfo(FeedInfo,aDate);
  Chart.Series[0].Clear;
  Chart.Series[1].Clear;
  for i:=Low(FeedInfo) to High(FeedInfo) do
    begin
      Chart.Series[0].Add(FeedInfo[i].Limit,FeedInfo[i].Name);
      Chart.Series[1].Add(FeedInfo[i].InStorage);
    end;
end;

end.
