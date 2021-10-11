unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, TeEngine, Series, ExtCtrls, TeeProcs, Chart, StdCtrls;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    MFile: TMenuItem;
    MNSI: TMenuItem;
    N3: TMenuItem;
    MFExit: TMenuItem;
    MNFeed: TMenuItem;
    MNHolidays: TMenuItem;
    MNPassover: TMenuItem;
    N5: TMenuItem;
    MNRate: TMenuItem;
    MNStore: TMenuItem;
    MStorage: TMenuItem;
    MSIn: TMenuItem;
    ChartPanel: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    MSOut: TMenuItem;
    Panel1: TPanel;
    Splitter2: TSplitter;
    Panel3: TPanel;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure MFExitClick(Sender: TObject);
    procedure MNFeedClick(Sender: TObject);
    procedure MNHolidaysClick(Sender: TObject);
    procedure MNUnitClick(Sender: TObject);
    procedure MNPassoverClick(Sender: TObject);
    procedure MNRateClick(Sender: TObject);
    procedure MNStoreClick(Sender: TObject);
    procedure MSInClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MSOutClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
    procedure RefreshInfo;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses FeedUnit, HolidayUnit, UnitUnit, PassoverUnit, RateUnit,
  StoreLimitUnit, Feed_InUnit, projectutils, DataModule, StoreInfoFrame,
  Feed_OutUnit, FreeLimitsUtit, MonthFeedUnit;

{$R *.dfm}

var
  sf:TStoreFrame;
  flf:TFreeLimitFrame;
  mff:TMonthFeedFrame;


procedure TMainForm.MFExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.MNFeedClick(Sender: TObject);
var
  ff:TFeedForm;
begin
  ff:=TFeedForm.Create(nil);
  with ff do
    begin
      Table.Active:=True;
      ShowModal;
      if Table.State in [dsEdit,dsInsert] then
        Table.Cancel;
      Table.Active:=False;
      Free;
    end;
  RefreshInfo;
end;

procedure TMainForm.MNHolidaysClick(Sender: TObject);
var
  hf:THolidayForm;
begin
  hf:=THolidayForm.Create(nil);
  with hf do
    begin
      Table.Active:=True;
      ShowModal;
      if Table.State in [dsEdit,dsInsert] then
        Table.Cancel;
      Table.Active:=False;
      Free;
    end;
  DM.LoadHolidays;
end;

procedure TMainForm.MNUnitClick(Sender: TObject);
var
  uf:TUnitForm;
begin
  uf:=TUnitForm.Create(nil);
  with uf do
    begin
      Table.Active:=True;
      ShowModal;
      if Table.State in [dsEdit,dsInsert] then
        Table.Cancel;
      Table.Active:=False;
      Free;
    end;
end;

procedure TMainForm.MNPassoverClick(Sender: TObject);
var
  pf:TPassoverForm;
begin
  pf:=TPassoverForm.Create(nil);
  with pf do
    begin
      Table.Active:=True;
      ShowModal;
      if Table.State in [dsEdit,dsInsert] then
        Table.Cancel;
      Table.Active:=False;
      Free;
    end;
  DM.LoadPassovers;
end;

procedure TMainForm.MNRateClick(Sender: TObject);
var
  rf:TRateForm;
begin
  rf:=TRateForm.Create(nil);
  with rf do
    begin
      FeedTable.Active:=True;
      Table.Active:=True;
      ShowModal;
      if Table.State in [dsEdit,dsInsert] then
        Table.Cancel;
      Table.Active:=False;
      FeedTable.Active:=False;
      Free;
    end;
  DM.LoadRates;
end;

procedure TMainForm.MNStoreClick(Sender: TObject);
var
  slf:TStoreLimitForm;
begin
  slf:=TStoreLimitForm.Create(nil);
  with slf do
    begin
      FeedTable.Active:=True;
      UnitTable.Active:=True;
      Table.Active:=True;
      ShowModal;
      if Table.State in [dsEdit,dsInsert] then
        Table.Cancel;
      Table.Active:=False;
      FeedTable.Active:=False;
      UnitTable.Active:=False;
      Free;
    end;
  RefreshInfo;
end;

procedure TMainForm.MSInClick(Sender: TObject);
var
  fif:TFeed_InForm;
begin
  fif:=TFeed_InForm.Create(nil);
  with fif do
    begin
      FeedTable.Active:=True;
      Table.Active:=True;
      ShowModal;
      if Table.State in [dsEdit,dsInsert] then
        Table.Cancel;
      Table.Active:=False;
      FeedTable.Active:=False;
      Free;
    end;
  RefreshInfo
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  DM.LoadConst;
  sf:=TStoreFrame.Create(Self);
  sf.Align:=alClient;
  sf.Parent:=ChartPanel;
  flf:=TFreeLimitFrame.Create(self);
  flf.Align:=alClient;
  flf.Parent:=Panel1;
  mff:=TMonthFeedFrame.Create(self);
  mff.Align:=alClient;
  mff.Parent:=Panel3;
  RefreshInfo;
end;

procedure TMainForm.MSOutClick(Sender: TObject);
var
  fof:TFeedOutForm;
begin
  fof:=TFeedOutForm.Create(nil);
  fof.ShowModal;
  fof.Free;
  RefreshInfo;
end;

procedure TMainForm.RefreshInfo;
begin
  sf.RefreshData(Now);
  flf.RefreshData(Now);
  mff.RefreshData(Now);
end;

procedure TMainForm.N2Click(Sender: TObject);
begin
  ShowMessage(
    Format('Оставшихся ресурсов на складе хватит для производства в течении %d дней',[DM.GetWorkDays(Now)])
  );
end;

end.
