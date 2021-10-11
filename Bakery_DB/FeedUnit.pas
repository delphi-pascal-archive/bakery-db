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
  //�������� ����� ��������� ��� �� ��������� ������ � ������ ��������
  if not(DM.CheckFeedDelete(Table.FieldByName('id').AsInteger)) then
    begin
      ShowMessage(
        '���������� ������� ������ ��� ����� �� �����������,'#$0D#$0A+
        '�.�. �� ������������ � ������������ ������� ��������� �/���'#$0D#$0A+
        '������� ������� ����� ������������ �� ������.'
      );
      Abort;
    end;
end;

end.
