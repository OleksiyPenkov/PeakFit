unit unit_utils;

interface

uses
  VCLTee.Series,
  unit_const,
  StdCtrls,
  Windows,
  Messages,
  Dialogs,
  SysUtils,
  ClipBrd,
  Classes,
  System.Character;

procedure SeriesToClipboard(Data: TLineSeries);
procedure SeriesToFile(Series: TLineSeries; const FileName: string);

procedure SeriesFromClipboard(Data, Background: TLineSeries);
procedure SeriesFromFile(Data, Background: TLineSeries; const FileName: string);

function SeriesToData(Series: TLineSeries): TDataArray;
procedure DataToSeries(const Data: TDataArray; var Series: TLineSeries);

implementation


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

function NumberOfColumns(const S:string): Integer;
var
  i: Integer;
begin
  Result := 1;
  for I := 1 to Length(S) do
    if S[i] = TabSeparator then Inc(Result);

end;

procedure DataFromText(var MyStringList: TStringList; var Data, Background: TDataArray);
var
  i, p, j: integer;
  s1, s2, s3: string;
  x, y, b: single;
  Separator: string;
  NCol: Integer;
begin
  NCol := 2;
  Separator := TabSeparator;
  SetLength(Data, 0);
  SetLength(Background, 0);

  NCol := NumberOfColumns(MyStringList.Strings[MyStringList.Count div 2]);

  j := 0;
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

    if NCol = 3 then
    begin
      p := Pos(Separator, s2);
      s2 := Copy(s2, 1, p - 1);
      s3 := Copy(s2, p + 1, Length(s2) - p - 1);
    end;

    if (s1 <> '') and (s2 <> '') and IsNumber(s1[1]) and IsNumber(s2[1]) then
    try
      SetLength(Data, Length(Data) + 1);
      SetLength(Background, Length(Background) + 1);
      x := StrToFloat(s1);
      y := StrToFloat(s2);
      Data[j].x := x;
      Background[j].x := x;
      Data[j].y := y;
      if (NCol = 3) and IsNumber(s3[1]) then
      begin
        b := StrToFloat(s3);
        Background[j].y := b;
      end
      else
        Background[j].y := 0;

    except
      on EConvertError do;
    end;
    end;
end;

procedure SeriesFromText(var MyStringList: TStringList; var Data, Background:TLineSeries);
var
  i, p: integer;
  s1, s2, s3: string;
  x, y, b: single;
  Separator: string;
  NCol: Integer;
begin
  NCol := 2;
  Separator := TabSeparator;
  Data.Clear;
  Background.Clear;

  NCol := NumberOfColumns(MyStringList.Strings[MyStringList.Count div 2]);

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

    if NCol = 3 then
    begin
      p := Pos(Separator, s2);
      s3 := Copy(s2, p + 1, Length(s2) - p - 1);
      s2 := Copy(s2, 1, p - 1);
    end;

    if (s1 <> '') and (s2 <> '') and IsNumber(s1[1]) and IsNumber(s2[1]) then
    try
      x := StrToFloat(s1);
      y := StrToFloat(s2);
      Data.AddXY(x, y);

      if (NCol = 3) and IsNumber(s3[1]) then
      begin
        b := StrToFloat(s3);
        Background.AddXY(x, b);
      end
      else
        Background.AddXY(x, 0);
    except
      on EConvertError do;
    end;
    end;
end;

procedure SeriesToClipboard(Data: TLineSeries);
var
  MyStringList: TStringList;
begin
  MyStringList := TStringList.Create;
  try
    SeriesToText(MyStringList, Data);
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

procedure SeriesFromClipboard(Data, Background: TLineSeries);
var
  MyStringList: TStringList;
begin
  MyStringList := TStringList.Create;
  try
    MyStringList.Text := Clipboard.AsText;
    SeriesFromText(MyStringList, Data, Background);
  finally
    MyStringList.Free;
  end;
end;

procedure SeriesFromFile(Data, Background: TLineSeries; const FileName: string);
var
  MyStringList: TStringList;
  S: string;
  i: Integer;
begin
  MyStringList := TStringList.Create;
  try
    MyStringList.LoadFromFile(FileName);
    SeriesFromText(MyStringList, Data, Background);
  finally
    MyStringList.Free;
  end;
end;

end.
