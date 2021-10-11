unit Feed_OutUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TFeedOutForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    DateStart: TDateTimePicker;
    Label3: TLabel;
    DateEnd: TDateTimePicker;
    OkButton: TButton;
    procedure FormShow(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FeedOutForm: TFeedOutForm;

implementation

uses DataModule, DateUtils;

{$R *.dfm}

procedure TFeedOutForm.FormShow(Sender: TObject);
begin
  DateStart.Date:=DM.GetLastFeedOut+1;
end;

procedure TFeedOutForm.OkButtonClick(Sender: TObject);
var
  counter:TDate;
begin
  //проверка правильности введенных дат
  if DateStart.Date>DateEnd.Date then
    begin
      MessageDlg('Даты указаны не верно!',mtError,[mbOk],0);
      Exit;
    end;
  counter:=StartOfTheDay(DateStart.Date);
  while Trunc(DateEnd.Date)>=Trunc(counter) do
    begin
      DM.FeedsOut(counter);
      counter:=IncDay(counter);
    end;
end;

end.
