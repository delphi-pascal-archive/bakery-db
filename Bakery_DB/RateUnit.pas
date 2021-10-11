unit RateUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DataModule, Grids, DBGrids, DB, ADODB, DBCtrls;

type
  TRateForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Table: TADOTable;
    Tableid: TAutoIncField;
    Tableid_feed: TIntegerField;
    Tableday: TFloatField;
    Tableday_off: TFloatField;
    Tableholiday: TFloatField;
    Tablepassover: TFloatField;
    DataSource: TDataSource;
    DBGrid1: TDBGrid;
    FeedTable: TADOTable;
    FeedTableid: TAutoIncField;
    FeedTableName: TWideStringField;
    TableName: TStringField;
    DBNavigator1: TDBNavigator;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RateForm: TRateForm;

implementation

{$R *.dfm}

end.
