program Bakery;

uses
  SysUtils,
  Forms,
  Dialogs,
  Main in 'Main.pas' {MainForm},
  DataModule in 'DataModule.pas' {DM: TDataModule},
  FeedUnit in 'FeedUnit.pas' {FeedForm},
  projectutils in 'projectutils.pas',
  HolidayUnit in 'HolidayUnit.pas' {HolidayForm},
  UnitUnit in 'UnitUnit.pas' {UnitForm},
  PassoverUnit in 'PassoverUnit.pas' {PassoverForm},
  RateUnit in 'RateUnit.pas' {RateForm},
  StoreLimitUnit in 'StoreLimitUnit.pas' {StoreLimitForm},
  Feed_InUnit in 'Feed_InUnit.pas' {Feed_InForm},
  StoreInfoFrame in 'StoreInfoFrame.pas' {StoreFrame: TFrame},
  Feed_OutUnit in 'Feed_OutUnit.pas' {FeedOutForm},
  FreeLimitsUtit in 'FreeLimitsUtit.pas' {FreeLimitFrame: TFrame},
  MonthFeedUnit in 'MonthFeedUnit.pas' {MonthFeedFrame: TFrame};

{$R *.res}

const
  ConnStr = 'Provider=MSDASQL.1;Persist Security Info=False;Data Source=База данных MS Access;Initial Catalog=%s';
//  ConnStr = 'Provider=MSDASQL.1;Persist Security Info=False;Data Source=MS Access;Initial Catalog=%s';
begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDM, DM);
  //Соединение с БД
  DM.MainConnection.Close;
  DM.MainConnection.ConnectionString:=Format(ConnStr,[Format('%s/%s',[ExtractFilePath(Application.ExeName),'bakery.mdb'])]);
  try
    DM.MainConnection.Open;
  except
    MessageDlg('Ошибка соединения с файлом базы данных.',mtError,[mbOk],0);
  end;
  Application.Run;
end.
