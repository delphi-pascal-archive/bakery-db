unit HolidayUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DataModule, DB, ADODB, DBCtrls, Grids, DBGrids;

type
  THolidayForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DataSource: TDataSource;
    Table: TADOTable;
    Tableid: TAutoIncField;
    Tablemonth: TIntegerField;
    Tableday: TIntegerField;
    TableisOffDay: TBooleanField;
    Grid: TDBGrid;
    DBNavigator1: TDBNavigator;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HolidayForm: THolidayForm;

implementation

{$R *.dfm}

procedure THolidayForm.FormShow(Sender: TObject);
begin
  with Grid.Columns.Items[2].PickList do
    begin
      Append('Да');
      Append('Нет');
    end;
end;

end.
