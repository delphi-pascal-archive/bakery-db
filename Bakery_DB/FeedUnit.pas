unit FeedUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, ExtCtrls, DataModule, Grids, DBGrids, DBCtrls;

type
  TFeedForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Table: TADOTable;
    DataSource: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    TableName: TWideStringField;
    Tableid: TAutoIncField;
    procedure TableBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FeedForm: TFeedForm;

implementation

uses projectutils;


{$R *.dfm}

procedure TFeedForm.TableBeforeDelete(DataSet: TDataSet);
begin
  //Проверим перед удалением нет ли связанных данных в других таблицах
  if not(DM.CheckFeedDelete(Table.FieldByName('id').AsInteger)) then
    begin
      ShowMessage(
        'Невозможно удалить данный вид сырья из справочника,'#$0D#$0A+
        'т.к. он используется в производстве готовой продукции и/или'#$0D#$0A+
        'остатки данного сырья присутствуют на складе.'
      );
      Abort;
    end;
end;

end.
