unit projectutils;

interface
uses
  Controls;
type
  TFeedInfo = record
    Name:string[100];
    id_feed:integer;
    Limit:single;
    InStorage:single;
  end;
  TFeedsInfo = array of TFeedInfo;

  TFreeFeedInfo = record
    Name:string[100];
    id_feed:integer;
    FreeLimit:single;
  end;
  TFreeFeedsInfo = array of TFreeFeedInfo;

  TRate = record
    id_feed:integer;
    day:single;
    day_off:single;
    holiday:single;
    passover:single;
  end;
  TRates = array of TRate;
  TPassoverDays = array of TDate;

  THoliday = record
    Day:byte;
    Month:byte;
    isDayOff:boolean;
  end;
  THolidays = array of THoliday;

procedure SaveToLog(aData:string);
function GetLastAcc:TDate;
procedure SetLastAcc(Value:TDate);

implementation

uses
  SysUtils,Forms,IniFiles;

procedure SaveToLog(aData:string);
var
  LogName:string;
  Log:TextFile;
begin
  LogName:=Format('%s\log.txt',[ExtractFilePath(Application.ExeName)]);
  AssignFile(Log,LogName);
  if FileExists(LogName) then
    Append(Log)
  else
    Rewrite(Log);
  WriteLn(Log,Format('%s - %s',[DateTimeToStr(now),aData]));
  CloseFile(Log);
end;
function GetLastAcc:TDate;
var
  ini:TIniFile;
begin
  ini:=TIniFile.Create(Format('%s\%s',[ExtractFilePath(Application.ExeName),'main.ini']));
  Result:=ini.ReadDate('Main','LastAcc',0);
  ini.Free;
end;
procedure SetLastAcc(Value:TDate);
var
  ini:TIniFile;
begin
  ini:=TIniFile.Create(Format('%s\%s',[ExtractFilePath(Application.ExeName),'main.ini']));
  ini.WriteDate('Main','LastAcc',Value);
  ini.Free;
end;

end.
