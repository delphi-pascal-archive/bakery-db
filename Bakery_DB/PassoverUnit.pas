unit PassoverUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataModule, ExtCtrls, Grids, DBGrids, DBCtrls, DB, ADODB;

type
  TPassoverForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Table: TADOTable;
    Tableid: TAutoIncField;
    TableDate: TDateTimeField;
    DataSource: TDataSource;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PassoverForm: TPassoverForm;

implementation

{$R *.dfm}

end.
