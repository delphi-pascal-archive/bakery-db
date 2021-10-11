unit UnitUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataModule, DB, ADODB, ExtCtrls, Grids, DBGrids, DBCtrls;

type
  TUnitForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Table: TADOTable;
    DataSource: TDataSource;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    Tableid: TAutoIncField;
    TableName: TWideStringField;
    procedure TableBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UnitForm: TUnitForm;

implementation

{$R *.dfm}

procedure TUnitForm.TableBeforeDelete(DataSet: TDataSet);
begin
  if not(DM.CheckUnitDelete(Table.FieldByName('id').AsInteger)) then
    begin
      ShowMessage(
        'Это системная единица измерения.'#$0D#$0A+
        'Удаление невозможно!!!'
      );
      Abort;
    end;
end;

end.
