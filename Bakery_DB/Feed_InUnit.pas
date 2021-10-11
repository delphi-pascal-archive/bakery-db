unit Feed_InUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DBCtrls, ComCtrls, StdCtrls, ExtCtrls, DataModule,
  DB, ADODB, Buttons;

type
  TFeed_InForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    DocNumber: TEdit;
    Label2: TLabel;
    DocDate: TDateTimePicker;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    DataSource: TDataSource;
    Table: TADOTable;
    Tableid_feed: TIntegerField;
    Tableamount: TFloatField;
    FeedTable: TADOTable;
    TableName: TStringField;
    OkButton: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OkButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Feed_InForm: TFeed_InForm;

implementation

{$R *.dfm}

procedure TFeed_InForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DM.ClearTmp_Feed_In;
end;

procedure TFeed_InForm.OkButtonClick(Sender: TObject);
begin
  if Table.State in [dsEdit,dsInsert] then
    Table.Cancel;
  if not(DM.ReloadFeeds(DocNumber.Text,DocDate.Date)) then
    begin
      ShowMessage('Провести документ не удалось :(');
      Exit;
    end;
  ModalResult:=mrOk;
end;

procedure TFeed_InForm.FormCreate(Sender: TObject);
begin
  DocDate.Date:=Now;
end;

end.
