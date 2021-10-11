unit DataModule;

interface

uses
  SysUtils, Classes, DB, ADODB, Controls, projectutils;

type
  TDM = class(TDataModule)
    MainConnection: TADOConnection;
    Query: TADOQuery;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FRates:TRates;
    FPassoverDays:TPassoverDays;
    FHolydays:THolidays;

    function GetFreeFeedLimit(id_feed:integer; aDate:TDate):double;
    function GetFeedName(id_feed:integer):string;
    procedure WriteDocLine(NDoc:string;DTDoc:TDate;id_feed:integer;amount:double;isNew:boolean);
    procedure WriteInStorege(id_feed:integer;amount:double;_set:boolean);
    function PassInfo(Day:TDate):boolean;
    function HolidayInfo(Day:TDate):boolean;
    function OffDayInfo(Day:TDate):Boolean;
    procedure SetWorkInfo(aInfo:boolean; aDate:TDate);
    function FeedOut(id_feed:integer;aDate:TDate):boolean;
    procedure RollBackFeedsOut(aDate:TDate);
  public
    { Public declarations }
    procedure LoadConst;
    procedure LoadRates;
    procedure LoadPassovers;
    procedure LoadHolidays;

    function CheckFeedDelete(id_feed:integer):boolean;
    function CheckUnitDelete(id_unit:integer):boolean;
    function CheckStoreLimitDelete(id_feed:integer):boolean;
    function ReloadFeeds(NDoc:string;DtDoc:TDate):boolean;
    function GetFeedLimit(id_feed:integer):double;
    function GetFeedInStorage(id_feed: integer; aDate:TDate):double;
    function GetFeedsInfo(var Data:TFeedsInfo; aDate:TDate; noLimits:boolean = False):boolean;
    function GetFreeFeedsInfo(var Data:TFreeFeedsInfo; aDate:TDate):boolean;
    procedure ClearTmp_Feed_In;
    function CostFeedInDay(Day:TDate;id_feed:integer):double;
    procedure FeedsOut(Day:TDate);
    function GetLastFeedOut:TDate;
    procedure NeedFeedsInMonth(var Data:TFreeFeedsInfo;aDate:TDate);
    function GetWorkDays(aDate:TDate):integer;

  end;

var
  DM: TDM;

implementation

uses Dialogs,DateUtils, Math;

{$R *.dfm}

function TDM.CheckFeedDelete(id_feed: integer): boolean;
begin
  result:=false;
  //�������� �� ������� ������� ����� � ������������� ��������� (rate)
  with Query do
    begin
      Close;
      SQL.Text:='SELECT id_feed FROM [rate] WHERE id_feed = :id_feed';
      Parameters.ParseSQL(SQL.Text,true);
      Parameters.ParamByName('id_feed').Value:=id_feed;
      try
        Open;
      except
        on E:Exception do
          begin
            SaveToLog(Format('������ �������� ������� rate � ��������� �������� �������� ����� - %s',[E.Message]));
            Exit; //������ �������� - ����� ����� �� ���������
          end;
      end;
      if FieldByName('id_feed').AsInteger=id_feed then
        begin
          Close;
          Exit;
        end;
      Close;
    end;
  //�������� ������� �������� ������� ���� ����� �� ������ (Store)
  with Query do
    begin
      Close;
      SQL.Text:='SELECT SUM([amount]) as [amount] FROM [store] WHERE id_feed = :id_feed GROUP BY id_feed';
      Parameters.ParseSQL(SQL.Text,true);
      Parameters.ParamByName('id_feed').Value:=id_feed;
      try
        Open;
      except
        on E:Exception do
          begin
            SaveToLog(Format('������ �������� ������� store � ��������� �������� �������� ����� - %s',[E.Message]));
            Exit; //������ �������� - ����� ����� �� ���������
          end;
      end;
      if FieldByName('amount').AsInteger<>0 then
        begin
          Close;
          Exit;
        end;
      Close;
    end;
  Result:=True;
end;

function TDM.CheckStoreLimitDelete(id_feed: integer): boolean;
begin
  Result:=False;
  //�������� ������� �������� ������� ���� ����� �� ������ (Store)
  with Query do
    begin
      Close;
      SQL.Text:='SELECT SUM([amount]) as [amount] FROM [store] WHERE id_feed = :id_feed GROUP BY id_feed';
      Parameters.ParseSQL(SQL.Text,true);
      Parameters.ParamByName('id_feed').Value:=id_feed;
      try
        Open;
      except
        on E:Exception do
          begin
            SaveToLog(Format('������ �������� ������� store � ��������� �������� �������� ������ ������ - %s',[E.Message]));
            Exit; //������ �������� - ����� ����� �� ���������
          end;
      end;
      if FieldByName('amount').AsInteger<>0 then
        begin
          Close;
          Exit;
        end;
      Close;
    end;
  Result:=True;
end;

function TDM.CheckUnitDelete(id_unit: integer): boolean;
begin
  result:=false;
  if id_unit<3 then
    Exit;
  result:=true;
end;

procedure TDM.ClearTmp_Feed_In;
begin
  //������� ��������� ������� �������
  with Query do
    begin
      Close;
      SQL.Text:='DELETE FROM tmp_feed_in';
      try
        ExecSQL;
      except
        on E:Exception do
          begin
            SaveToLog(Format('������ ��� ������� ���������� ��������� �� ������� �� ����� - %s',[E.Message]));
            Exit; //������ �������� - ����� ����� �� ���������
          end;
      end;
    end;
end;

function TDM.CostFeedInDay(Day: TDate; id_feed: integer): double;
{
  ������� ������� ������� ���� ��������� �� ���� Day
}
var
  tmp_res:Double;
  i:integer;
begin
  tmp_res:=0;
  //������� ����� �� ������� ����, � �����������, ���� ���� "�� �������" �� ����� �����������
  for i:=Low(FRates) to High(FRates) do
    if FRates[i].id_feed = id_feed then
      begin
        tmp_res:=FRates[i].day;
        Break;
      end;
  //��� ������ �������� - �� ����� �� ���
  if PassInfo(Day) then
    begin
      for i:=Low(FRates) to High(FRates) do
        if FRates[i].id_feed = id_feed then
          begin
            tmp_res:=FRates[i].passover;
            Break;
          end;
    end;
  //������ �������� �� ����������� ����
  if HolidayInfo(Day) then
    begin
      for i:=Low(FRates) to High(FRates) do
        if FRates[i].id_feed = id_feed then
          begin
            tmp_res:=FRates[i].holiday;
            Break;
          end;
    end;
  //������ �������� �� ��������
  if (DayOfTheWeek(Day) in [1,2,5,6]) or (OffDayInfo(Day)) then
    begin
      for i:=Low(FRates) to High(FRates) do
        if FRates[i].id_feed = id_feed then
          begin
            tmp_res:=FRates[i].day;
            Break;
          end;
    end;
  Result:=tmp_res;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  FRates:=nil;
  MainConnection.Close;
end;

procedure TDM.FeedsOut(Day: TDate);
{
  �������� ����� �� ������ (� ������������);
}
var
  q:TADOQuery;
  WrkInfo:boolean;
begin
  WrkInfo:=True;
  q:=TADOQuery.Create(nil);
  with q do
    begin
      Connection:=MainConnection;
      SQL.Text:='SELECT [id] FROM [feed]';
      try
        Open;
        First;
        while not(Eof) do
          begin
            {$B+}  //������ ��������� ������� ��������
            WrkInfo:=FeedOut(FieldByName('id').AsInteger,Day) and WrkInfo;
            {$B-}
            Next;
          end;
        Close;
      except
        on E:Exception do
          begin
            Free;
            SaveToLog(Format('������ � ��������� �������� �� ������ - %s',[E.Message]));
            Exit;
          end;
      end;
      Free;
    end;
  SetWorkInfo(WrkInfo,Day);
  if not(WrkInfo) then
    RollBackFeedsOut(Day);
end;

function TDM.FeedOut(id_feed: integer; aDate: TDate): boolean;
//�������� �� ������ ������������� ���� ����� �� ����
var
  q:TADOQuery;
  feedamount:double;
begin
  Result:=False;
  feedamount:=CostFeedInDay(aDate,id_feed);
  if GetFeedInStorage(id_feed,aDate)>=feedamount then
    begin
      q:=TADOQuery.Create(nil);
      with q do
        begin
          Connection:=MainConnection;
          SQL.Text:='INSERT INTO [feed_out] ([id_feed], [amount], [date]) VALUES (:id_feed, :amount, :date)';
          Parameters.ParseSQL(SQL.Text,True);
          Parameters.ParamByName('id_feed').Value:=id_feed;
          Parameters.ParamByName('amount').Value:=feedamount;
          Parameters.ParamByName('date').Value:=StartOfTheDay(aDate);
          try
            ExecSQL;
            Result:=True;
          except
            on E:Exception do
              SaveToLog(Format('������ ��� �������� �� ������ - %s',[E.Message]));
          end;
          Free;
        end;
    end;
end;


function TDM.GetFeedInStorage(id_feed: integer; aDate:TDate): double;
{
  ���������� ������� ��������� �� ������ �� ������������ ����
}
var
  q:TADOQuery;
  f_in,f_out:double;
begin
  Result:=0;
  q:=TADOQuery.Create(nil);
  with q do
    begin
      Connection:=MainConnection;
      SQL.Text:='SELECT SUM([amount]) as AllFeeds FROM [feed_in] WHERE [id_feed]=:id_feed AND [docdate]<=:date';  //��������� ���������� ������������ �������
      Parameters.ParseSQL(SQL.Text,True);
      Parameters.ParamByName('id_feed').Value:=id_feed;
      Parameters.ParamByName('date').Value:=StartOfTheDay(aDate);
      try
        Open;
      except
        on E:Exception do
          begin
            SaveToLog(Format('������ �������� ������� �������� (��������� ��������� ���������� ������ �� ������) - %s',[E.Message]));
            Free;
            Exit; //������ �������� - ����� ����� �� ���������
          end;
      end;
      f_in:=FieldByName('AllFeeds').AsFloat;
      Close;

      SQL.Text:='SELECT SUM([amount]) as AllFeeds FROM [feed_out] WHERE [id_feed]=:id_feed AND [date]<:date';  //��������� ���������� ������ (������� �� ���� ������, ������� ���� �� ���������)
      Parameters.ParseSQL(SQL.Text,True);
      Parameters.ParamByName('id_feed').Value:=id_feed;
      Parameters.ParamByName('date').Value:=StartOfTheDay(aDate);
      try
        Open;
      except
        on E:Exception do
          begin
            SaveToLog(Format('������ �������� ������� ������� (��������� ��������� ���������� ������ �� ������) - %s',[E.Message]));
            Free;
            Exit; //������ �������� - ����� ����� �� ���������
          end;
      end;
      f_out:=FieldByName('AllFeeds').AsFloat;
      Close;
      Free;
    end;
  Result:=f_in-f_out;
end;

function TDM.GetFeedLimit(id_feed: integer): double;
var
  q:TADOQuery;
begin
  Result:=0;
  q:=TADOQuery.Create(nil);
  with q do
    begin
      Connection:=MainConnection;
      SQL.Text:='SELECT [capacity]+[reserv] as allcapacity FROM [StoreLimits] WHERE [id_feed]=:id_feed';  //������ ������
      Parameters.ParseSQL(SQL.Text,True);
      Parameters.ParamByName('id_feed').Value:=id_feed;
      try
        Open;
      except
        on E:Exception do
          begin
            SaveToLog(Format('������ �������� ������� ������� (��������� ��������� ���������� ����� �� ������) - %s',[E.Message]));
            Free;
            Exit; //������ �������� - ����� ����� �� ���������
          end;
      end;
      Result:=FieldByName('allcapacity').AsFloat;
      Close;
      Free;
    end;
end;

function TDM.GetFeedName(id_feed: integer): string;
var
  q:TADOQuery;
begin
  Result:='';
  q:=TADOQuery.Create(nil);
  with q do
    begin
      Connection:=MainConnection;
      SQL.Text:='SELECT [name] FROM [feed] WHERE [id]=:id_feed';  //������� �� ������
      Parameters.ParseSQL(SQL.Text,True);
      Parameters.ParamByName('id_feed').Value:=id_feed;
      try
        Open;
      except
        on E:Exception do
          begin
            SaveToLog(Format('������ �������� ������� ����� (��������� ��������� ����� �����) - %s',[E.Message]));
            Free;
            Exit; //������ �������� - ����� ����� �� ���������
          end;
      end;
      Result:=FieldByName('name').AsString;
      Free;
    end;
end;

function TDM.GetFeedsInfo(var Data: TFeedsInfo; aDate:TDate; noLimits:boolean = False): boolean;
var
  q:TADOQuery;
begin
  Result:=False;
  q:=TADOQuery.Create(nil);
  with q do
    begin
      Connection:=MainConnection;
      SQL.Text:='SELECT * FROM [feed] ';
      try
        Open;
      except
        on E:Exception do
          begin
            SaveToLog(Format('������ �������� ������� ����� (GetFeedsInfo) - %s',[E.Message]));
            Free;
            Exit; //������ �������� - ����� ����� �� ���������
          end;
      end;
      First;
      while not(Eof) do
        begin
          SetLength(Data,Length(Data)+1);
          Data[High(Data)].Name:=FieldByName('name').AsString;
          Data[High(Data)].id_feed:=FieldByName('id').AsInteger;
          if not(noLimits) then
            Data[High(Data)].Limit:=GetFeedLimit(FieldByName('id').AsInteger);
          Data[High(Data)].InStorage:=GetFeedInStorage(FieldByName('id').AsInteger, aDate);
          Next;
        end;
      Close;
      Free;
    end;
   Result:=True;
end;

function TDM.GetFreeFeedLimit(id_feed: integer; aDate:TDate): double;
begin
  Result:=GetFeedLimit(id_feed)-GetFeedInStorage(id_feed, aDate);
end;

function TDM.HolidayInfo(Day: TDate): boolean;
//�������� �������� �� � ������ ����������
var
  i:integer;
  aDay,aMonth:integer;
begin
  Result:=False;
  aDay:=DayOfTheMonth(Day);
  aMonth:=MonthOfTheYear(Day);
  for i:=Low(FHolydays) to High(FHolydays) do
    if (FHolydays[i].Day=aDay) AND (FHolydays[i].Month=aMonth) then
      begin
        Result:=True;
        Exit;
      end;
end;

function TDM.OffDayInfo(Day: TDate): Boolean;
//�������� �������� �� ������ ���� � ������ ���� ����������� � �������
var
  i:integer;
  aDay,aMonth:integer;
begin
  Result:=False;
  aDay:=DayOfTheMonth(Day);
  aMonth:=MonthOfTheYear(Day);
  for i:=Low(FHolydays) to High(FHolydays) do
    if (FHolydays[i].Day=aDay) AND (FHolydays[i].Month=aMonth) AND (FHolydays[i].isDayOff) then
      begin
        Result:=True;
        Exit;
      end;
end;

function TDM.PassInfo(Day: TDate): boolean;
//�������� �������� �� ������ ���� � 3 ���������� ���
var
  i:integer;
begin
  Result:=False;
  for i:=Low(FPassoverDays) to High(FPassoverDays) do
    if YearOf(FPassoverDays[i])=YearOf(Day) then  //������ ���
      if ((Day-2)>=FPassoverDays[i]) AND (Day<=FPassoverDays[i]) then
        begin
          Result:=True;
          Exit;
        end;
end;

function TDM.ReloadFeeds(NDoc:string;DtDoc:TDate):boolean;
//����������� �� ����� ������
var
  isNew:boolean;
  isBreak:boolean;
begin
  Result:=False;
  //������� ��������, �� ���������� �� ��� ������ ��������
  with Query do
    begin
      Close;
      SQL.Text:='SELECT Count([amount]) as AllFeeds FROM [feed_in] WHERE [docdate]=:date AND [numdoc]=:numdoc GROUP BY [docdate],[numdoc]';
      Parameters.ParseSQL(SQL.Text,True);
      Parameters.ParamByName('date').Value:=DtDoc;
      Parameters.ParamByName('numdoc').Value:=Trim(NDoc);
      try
        Open;
      except
        on E:Exception do
          begin
            SaveToLog(Format('������ ��� ������ ��������� � ������� ����������� - %s',[E.Message]));
            Exit; //������ �������� - ����� ����� �� ���������
          end;
      end;
      isNew:=not(FieldByName('AllFeeds').AsInteger>0);
      Close;
      //������ ��������� ����������� ��������� �� �� ����� ������
      isBreak:=False;
      SQL.Text:='SELECT [id_feed],[amount] FROM [tmp_feed_in]';
      try
        Open;
      except
        on E:Exception do
          begin
            SaveToLog(Format('������ ��� �������� ���������� ��������� - %s',[E.Message]));
            Exit; //������ �������� - ����� ����� �� ���������
          end;
      end;
      First;
      while not(Eof) do
        begin
          if GetFreeFeedLimit(FieldByName('id_feed').AsInteger,DtDoc)<FieldByName('amount').AsInteger then
            begin
              isBreak:=True;
              MessageDlg(
                Format('��� ����� "%s" ������������ ����� �� ������!!!',[GetFeedName(FieldByName('id_feed').AsInteger)]),
                mtError,[mbOk],0
              )
            end;
          Next;
        end;
      if isBreak then
        begin
          Close;
          Exit;
        end;
      //���� ����� �� ���� �� ��� �������� ������� � �������� ����� ��������� �� ������
      First;
      while not(Eof) do
        begin
          WriteDocLine(NDoc,DtDoc,FieldByName('id_feed').AsInteger,FieldByName('amount').AsFloat,isNew);
          if isNew then
            WriteInStorege(FieldByName('id_feed').AsInteger,FieldByName('amount').AsFloat,true);
          Next;
        end;
    end;
  Result:=True;
end;

procedure TDM.SetWorkInfo(aInfo: boolean; aDate:TDate);
var
  q:TADOQuery;
  Info:integer;
begin
  info:=IfThen(aInfo,1,0);
  q:=TADOQuery.Create(nil);
  with q do
    begin
      Connection:=MainConnection;
      SQL.Text:='INSERT INTO [WorkInfo] ([date], [info]) VALUES (:date, :info)';
      Parameters.ParseSQL(SQL.Text,True);
      Parameters.ParamByName('date').Value:=StartOfTheDay(aDate);
      Parameters.ParamByName('info').Value:=info;
      try
        ExecSQL;
      except
        on E:Exception do
          SaveToLog(Format('������ ��� ������ ���������� � ������ �� ���� - %s',[E.Message]));
      end;
      Free;
    end;
end;

procedure TDM.WriteDocLine(NDoc: string; DTDoc: TDate; id_feed:integer;
  amount: double; isNew:boolean);
//���������� ������ �� ���������� ��������� � ������ �������
var
  q:TADOQuery;
begin
  q:=TADOQuery.Create(nil);
  with q do
    begin
      Connection:=MainConnection;
      if isNew then
        SQL.Text:='INSERT INTO [feed_in] ([id_feed],[amount],[docdate],[numdoc]) VALUES (:id_feed,:amount,:date,:numdoc)'
      else
        SQL.Text:='UPDATE [feed_in] SET [amount] = :amount WHERE [id_feed]=:id_feed AND [docdate]=:date AND [numdoc]=:numdoc';
      Parameters.ParseSQL(SQL.Text,True);
      Parameters.ParamByName('id_feed').Value:=id_feed;
      Parameters.ParamByName('amount').Value:=amount;
      Parameters.ParamByName('date').Value:=StartOfTheDay(DTDoc);
      Parameters.ParamByName('numdoc').Value:=Trim(NDoc);
      try
        ExecSQL;
      except
        on E:Exception do
          begin
            SaveToLog(Format('������ ��� ���������� ������ ���������� ��������� - %s',[E.Message]));
            Free;
            Exit; //������ �������� - ����� ����� �� ���������
          end;
      end;
      Free;
    end;
end;

procedure TDM.WriteInStorege(id_feed:integer; amount: double; _set: boolean);
// ������� ������� �� ������
var
  q:TADOQuery;
  delta:integer;
  isNew:boolean;
begin
  if _set then
    delta:=1
  else
    delta:=-1;
  q:=TADOQuery.Create(nil);
  with q do
    begin
      Connection:=MainConnection;
      //���������, ���� �� ����� �� ������ ������
      SQL.Text:='SELECT Count([id_feed]) as FeedCount FROM [store] WHERE [id_feed]=:id_feed';
      Parameters.ParseSQL(SQL.Text,True);
      Parameters.ParamByName('id_feed').Value:=id_feed;
      try
        Open;
      except
        on E:Exception do
          begin
            SaveToLog(Format('������ �������� ������� ������ (��������� �������� �� �����) - %s',[E.Message]));
            Free;
            Exit; //������ �������� - ����� ����� �� ���������
          end;
      end;
      isNew:=FieldByName('FeedCount').AsInteger=0;
      Close;
      if isNew then
        SQL.Text:='INSERT INTO [store] ([id_feed],[amount],[datecorr]) VALUES (:id_feed,:amount,:date)'
      else
        SQL.Text:='UPDATE [store] SET [amount]=[amount]+:amount , [datecorr] = :date WHERE [id_feed] = :id_feed';
      Parameters.ParseSQL(SQL.Text,True);
      Parameters.ParamByName('id_feed').Value:=id_feed;
      Parameters.ParamByName('amount').Value:=amount*delta;
      Parameters.ParamByName('date').Value:=StartOfTheDay(Now);
      try
        ExecSQL;
      except
        on E:Exception do
          begin
            SaveToLog(Format('������ ��� ���������� �� ������ - %s',[E.Message]));
            Free;
            Exit; //������ �������� - ����� ����� �� ���������
          end;
      end;
      Free;
    end;
end;

procedure TDM.RollBackFeedsOut(aDate: TDate);
{
  ����� �������� �� ���� (��� �������� ���������)
}
var
  q:TADOQuery;
begin
  q:=TADOQuery.Create(nil);
  with q do
    begin
      Connection:=MainConnection;
      SQL.Text:='DELETE FROM [feed_out] WHERE [date]=:date';
      Parameters.ParseSQL(SQl.Text,True);
      Parameters.ParamByName('date').Value:=StartOfTheDay(aDate);
      try
      except
        on E:Exception do
          SaveToLog(Format('������ ��� ������ �������� - %s',[E.Message]));
      end;
      Free;
    end;
end;

function TDM.GetLastFeedOut: TDate;
{
  ���������� ���� ���������� �������� �� ������
  ���� �������� �� ������������� - �� ���� ������� ����������� �� �����
}
var
  q:TADOQuery;
  tmpdate:TDate;
begin
  q:=TADOQuery.Create(nil);
  with q do
    begin
      Connection:=MainConnection;
      SQL.Text:='SELECT MAX([date]) as maxdate FROM [feed_out]';
      Open;
      tmpdate:=StartOfTheDay(FieldByName('maxdate').AsDateTime);
      Close;
      SQL.Text:='SELECT MIN([docdate]) as maxdate FROM [feed_in]';
      Open;
      Result:=max(StartOfTheDay(FieldByName('maxdate').AsDateTime),tmpdate);
      Close;
      Free;
    end;
end;

function TDM.GetFreeFeedsInfo(var Data: TFreeFeedsInfo;
  aDate: TDate): boolean;
var
  q:TADOQuery;
begin
  Result:=False;
  q:=TADOQuery.Create(nil);
  with q do
    begin
      Connection:=MainConnection;
      SQL.Text:='SELECT * FROM [feed] ';
      try
        Open;
      except
        on E:Exception do
          begin
            SaveToLog(Format('������ �������� ������� ����� (GetFeedsInfo) - %s',[E.Message]));
            Free;
            Exit; //������ �������� - ����� ����� �� ���������
          end;
      end;
      First;
      while not(Eof) do
        begin
          SetLength(Data,Length(Data)+1);
          Data[High(Data)].Name:=FieldByName('name').AsString;
          Data[High(Data)].FreeLimit:=GetFreeFeedLimit(FieldByName('id').AsInteger, aDate);
          Next;
        end;
      Close;
      Free;
    end;
   Result:=True;
end;

procedure TDM.LoadRates;
{ �������� ����� ������� � ������, ��� ��������� ���������}
var
  q:TADOQuery;
begin
  FRates:=nil;
  q:=TADOQuery.Create(nil);
  with q do
    begin
      Connection:=MainConnection;
      SQL.Text:='SELECT * FROM [rate]';
      Open;
      First;
      while not(Eof) do
        begin
          SetLength(FRates,Length(FRates)+1);
          FRates[High(FRates)].id_feed:=FieldByName('id_feed').AsInteger;
          FRates[High(FRates)].day:=FieldByName('day').AsFloat;
          FRates[High(FRates)].day_off:=FieldByName('day_off').AsFloat;
          FRates[High(FRates)].holiday:=FieldByName('holiday').AsFloat;
          FRates[High(FRates)].passover:=FieldByName('passover').AsFloat;
          Next;
        end;
      Close;
      Free;
    end;
end;

procedure TDM.LoadPassovers;
{ �������� ��� ����� � ������, ��� ��������� ���������}
var
  q:TADOQuery;
begin
  FPassoverDays:=nil;
  q:=TADOQuery.Create(nil);
  with q do
    begin
      Connection:=MainConnection;
      SQL.Text:='SELECT * FROM [passover]';
      Open;
      First;
      while not(Eof) do
        begin
          SetLength(FPassoverDays,Length(FPassoverDays)+1);
          FPassoverDays[High(FPassoverDays)]:=StartOfTheDay(FieldByName('date').AsDateTime);
          Next;
        end;
      Close;
      Free;
    end;
end;

procedure TDM.LoadConst;
begin
  LoadRates;
  LoadPassovers;
  LoadHolidays;
end;

procedure TDM.LoadHolidays;
{ �������� ����������� ��� � ������, ��� ��������� ���������}
var
  q:TADOQuery;
begin
  FHolydays:=nil;
  q:=TADOQuery.Create(nil);
  with q do
    begin
      Connection:=MainConnection;
      SQL.Text:='SELECT * FROM [holidays]';
      Open;
      First;
      while not(Eof) do
        begin
          SetLength(FHolydays,Length(FHolydays)+1);
          FHolydays[High(FHolydays)].Day:=FieldByName('day').AsInteger;
          FHolydays[High(FHolydays)].Month:=FieldByName('month').AsInteger;
          FHolydays[High(FHolydays)].isDayOff:=FieldByName('isoffday').AsBoolean;
          Next;
        end;
      Close;
      Free;
    end;
end;

procedure TDM.NeedFeedsInMonth(var Data: TFreeFeedsInfo; aDate: TDate);
{
  ������� ���������� ���������� ����� �� ����� ������ ������� � ���� aDate � ������� ��
}
var
  DCounter:TDate;
  q:TADOQuery;
  i:integer;
begin
  Data:=nil;
  //���������� � ������� ������ �����
  q:=TADOQuery.Create(nil);
  with q do
    begin
      Connection:=MainConnection;
      SQL.Text:='SELECT [id] FROM [feed]';
      Open;
      First;
      while not(Eof) do
        begin
          SetLength(Data,Length(Data)+1);
          Data[High(Data)].id_feed:=FieldByName('id').AsInteger;
          Data[High(Data)].Name:=GetFeedName(Data[High(Data)].id_feed);
          Data[High(Data)].FreeLimit:=0;
          Next;
        end;
      Close;
      Free;
    end;
  DCounter:=aDate;
  while DCounter<IncMonth(aDate) do
    begin
      for i:=Low(Data) to High(Data) do
        Data[i].FreeLimit:=Data[i].FreeLimit+CostFeedInDay(DCounter,Data[i].id_feed);
      DCounter:=IncDay(DCounter);
    end;
end;

function TDM.GetWorkDays(aDate:TDate): integer;
{
  ���������� ���������� ���� �� ������� ������ �������� ������
  �� ���������� ����
}
var
  Feeds:TFeedsInfo;
  currentdate:TDate;
  i:integer;
  daycounter:integer;
begin
  GetFeedsInfo(Feeds,aDate,True);  //������ �������� �� ������
  currentdate:=aDate;
  daycounter:=0;
  while true do  //���������� "������" ���� (����� �� ���� ����� � ������ ���� ���� �� �������� ����������)
    begin
      for i:=Low(Feeds) to High(Feeds) do
        begin
          Feeds[i].InStorage:=Feeds[i].InStorage-CostFeedInDay(currentdate,Feeds[i].id_feed);
          if Feeds[i].InStorage<=0 then
            begin
              Result:=daycounter;
              Exit;  //��� ��� ����������
            end;
        end;
      inc(daycounter);
      currentdate:=IncDay(currentdate);
    end;
end;

end.
