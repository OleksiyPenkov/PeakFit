unit unit_utils;

interface

uses
  VCLTee.Series,
  unit_const,
  StdCtrls,
  Windows,
  Messages,
  Dialogs;


procedure SeriesToClipboard(Series: TLineSeries);
procedure SeriesToFile(Series: TLineSeries; const FileName: string);

procedure SeriesFromClipboard(Series: TLineSeries);
procedure SeriesFromFile(Series: TLineSeries; const FileName: string);

function SeriesToData(Series: TLineSeries): TDataArray;
procedure DataToSeries(const Data: TDataArray; var Series: TLineSeries);

implementation

uses
  SysUtils,
  ClipBrd,
  Classes,
  System.Character;

const
  TabSeparator = #9;


procedure DataToSeries(const Data: TDataArray; var Series: TLineSeries);
var
  i: Integer;
begin
  Series.Clear;
  for I := 0 to High(Data) do
    Series.AddXY(Data[i].x, Data[i].y);
end;

function SeriesToData( Series: TLineSeries): TDataArray;
var
  i: integer;
begin
  SetLength(Result, Series.Count);
  for I := 0 to Series.Count - 1 do
  begin
    Result[i].x := Series.XValue[i];
    Result[i].y := Series.YValue[i];
  end;
end;

procedure SeriesToText(var MyStringList: TStringList; var Series:TLineSeries);
var
  i, N: integer;
  s: string;
  x, y: single;
begin
  MyStringList.Add('2Theta' + TabSeparator + 'Reflectivity');
  MyStringList.Add('deg' + TabSeparator + '');
  MyStringList.Add('');
  N := Series.Count;
  for i := 0 to N - 1 do
  begin
    x := Series.XValues[i];
    y := Series.YValues[i];
    s := FloatToStrF(x, ffFixed, 5, 3) + TabSeparator;
    s := s + FloatToStrF(y, ffExponent, 5, 4);
    MyStringList.Add(s);
  end;
end;

procedure SeriesFromText(var MyStringList: TStringList; var Series:TLineSeries);
var
  i, p: integer;
  s1, s2: string;
  x, y: single;
  Separator: string;
begin
  Separator := TabSeparator;
  Series.Clear;
  for i := 0 to MyStringList.Count - 1 do
  begin
    s2 := MyStringList.Strings[i];
    if s2 = '' then Continue;

    p := Pos(Separator, s2);
    if p = 0 then
    begin
      Separator := ' ';
      p := Pos(Separator, s2);
    end;

    if p = 0 then Continue;


    s1 := Copy(s2, 1, p - 1);
    delete(s2, 1, p);
    if (s1 <> '') and (s2 <> '') and IsNumber(s1[1]) and IsNumber(s2[1]) then
    try
      x := StrToFloat(s1);
      y := StrToFloat(s2);
      Series.AddXY(x, y);
    except
      on EConvertError do;
    end;
    end;
end;

procedure SeriesToClipboard(Series: TLineSeries);
var
  MyStringList: TStringList;
begin
  MyStringList := TStringList.Create;
  try
    SeriesToText(MyStringList, Series);
    Clipboard.AsText := MyStringList.Text;
  finally
    MyStringList.Free;
  end;
end;

procedure SeriesToFile(Series: TLineSeries; const FileName: string);
var
  MyStringList: TStringList;
begin
  MyStringList := TStringList.Create;
  try
    SeriesToText(MyStringList, Series);
    MyStringList.SaveToFile(FileName);
  finally
    MyStringList.Free;
  end;
end;

procedure SeriesFromClipboard(Series: TLineSeries);
var
  MyStringList: TStringList;
begin
  MyStringList := TStringList.Create;
  try
    MyStringList.Text := Clipboard.AsText;
    SeriesFromText(MyStringList, Series);
  finally
    MyStringList.Free;
  end;
end;

procedure SeriesFromFile(Series: TLineSeries; const FileName: string);
var
  MyStringList: TStringList;
  S: string;
  i: Integer;
begin
  MyStringList := TStringList.Create;
  try
    MyStringList.LoadFromFile(FileName);
    SeriesFromText(MyStringList, Series);
  finally
    MyStringList.Free;
  end;
end;


end.
