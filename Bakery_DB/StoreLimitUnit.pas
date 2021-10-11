unit StoreLimitUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataModule, Grids, DBGrids, DB, ADODB, ExtCtrls, DBCtrls;

type
  TStoreLimitForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Table: TADOTable;
    FeedTable: TADOTable;
    UnitTable: TADOTable;
    Tableid: TAutoIncField;
    Tableid_feed: TIntegerField;
    Tablecapacity: TIntegerField;
    Tablereserv: TIntegerField;
    Tableunit: TIntegerField;
    TableName: TStringField;
    TableUnitName: TStringField;
    DataSource: TDataSource;
    DBGrid1: TDBGrid;
    FeedTableid: TAutoIncField;
    FeedTableName: TWideStringField;
    UnitTableid: TAutoIncField;
    UnitTableName: TWideStringField;
    DBNavigator1: TDBNavigator;
    procedure TableBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StoreLimitForm: TStoreLimitForm;

implementation

{$R *.dfm}

procedure TStoreLimitForm.TableBeforeDelete(DataSet: TDataSet);
begin
  if not(DM.CheckStoreLimitDelete(Table.FieldByName('id_feed').AsInteger)) then
    begin
      ShowMessage(
        'Невозможно удалить данный лимит на сырье,'#$0D#$0A+
        'т.к. остатки данного сырья присутствуют на складе.'
      );
      Abort;
    end;
end;

end.
