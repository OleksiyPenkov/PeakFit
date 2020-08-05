unit unit_utils;

interface

uses
  VCLTee.Series,
  VCLTee.TeEngine,
  unit_const,
  StdCtrls,
  Windows,
  Messages,
  Dialogs,
  SysUtils,
  ClipBrd,
  Classes,
  System.JSON;

procedure SeriesToClipboard(Data: TLineSeries);
procedure SeriesToFile(Series: TLineSeries; const FileName: string);
procedure SeriesToText(var MyStringList: TStringList; var Series:TLineSeries);

procedure SeriesFromClipboard(Data, Background: TLineSeries);
procedure SeriesFromFile(Data, Background: TLineSeries; const FileName: string);

function SeriesToData(Series: TLineSeries): TDataArray;
procedure DataToSeries(const Data: TDataArray; var Series: TLineSeries);
procedure SeriesFromText(var MyStringList: TStringList; var Data, Background:TLineSeries);
procedure SeriesFromTextS(var MyStringList: TStringList; var Data:TLineSeries);

function FunctionToJSON(F: TFitSet; Id: integer): TJSONObject;
procedure FunctionsToLines(F: TFitSets; var Strings: TStringList);
procedure FunctionsFromStrings(Strings: TStringList; var F: TFitSets);

procedure SaveProject(Data, Background: TLineSeries; FileName: string);
procedure LoadProject(Data, Background: TLineSeries; FileName: string; FunctionsOnly: boolean = False);

implementation

uses
  System.Character,
  AbUtils,
  AbBase,
  AbZipper,
  AbUnzper,
  AbZipTyp,
  unit_GaussFit;

const
  TabSeparator = #9;

procedure JSONtoFunction(JVar: TJSONObject; var F: TFitSet);
var
  Param: TJSONObject;

  procedure ParseVariable(Name: string; var Variable: TVariable);
  begin
    Param := JVar.GetValue<TJSONObject>(Name);

    Variable.Last := Param.Values['Last'].AsType<Single>;
    Variable.d := Param.Values['d'].AsType<Single>;
    Variable.min := Param.Values['min'].AsType<Single>;
    Variable.max := Param.Values['max'].AsType<Single>;
  end;

begin
  ParseVariable('A', F.A);
  ParseVariable('xc', F.xc);
  ParseVariable('W', F.W);
  ParseVariable('s', F.s);
end;

procedure FunctionsFromStrings(Strings: TStringList; var F: TFitSets);
var
  JSON: TJSONObject;
  JSONArray: TJSONArray;
  JsonArrEnum: TJSONArray.TEnumerator;
  i: Integer;
begin
  SetLength(F, 0);
  JSON := TJSONObject.Create;
  JSON.Parse(TEncoding.UTF8.GetBytes(Strings.Text), 0);
  JSONArray := TJSONArray.Create;

  JSONArray := JSON.GetValue<TJSONArray>('Fits');
  SetLength(F, JSONArray.Count);
  JsonArrEnum:=JSONArray.GetEnumerator;

  i := 0;
  while JsonArrEnum.MoveNext do
  begin
    JSONtoFunction((JSONArrEnum.Current as TJSONObject), F[i]);
    inc(i);
  end;


end;


procedure LoadProject(Data, Background: TLineSeries; FileName: string; FunctionsOnly: boolean = False);
var
  Strings: TStringList;
  Stream: TMemoryStream;
  Zipper: TAbUnZipper;
  F: TFitSets;

  procedure ExtractToStringList(const FileName: string);
  begin
    Stream.Clear;
    Zipper.ExtractToStream (FileName, Stream);
    Stream.Seek(0, soFromBeginning);
    Strings.LoadFromStream(Stream);
  end;


begin
  Strings := TStringList.Create;
  Stream  := TMemoryStream.Create;

  try
    Zipper := TAbUnZipper.Create(Nil);
    Zipper.ArchiveType := atZip;
    Zipper.ForceType := True;
    Zipper.FileName := FileName;

    if not FunctionsOnly then
    begin

      ExtractToStringList('background.dat');
      SeriesFromTextS(Strings, Background);

      ExtractToStringList('Data.dat');
      SeriesFromTextS(Strings, Data);

    end;

    ExtractToStringList('FitFunctions.json');
    FunctionsFromStrings(Strings, F);

    Fit.Functions := F;
  finally
    FreeAndNil(Strings);
    FreeAndNil(Stream);
    FreeAndNil(Zipper);
  end;
end;

procedure SaveProject(Data, Background: TLineSeries; FileName: string);
var
  Strings: TStringList;
  Stream: TMemoryStream;
  Zipper: TAbZipper;

  procedure AddString(const FN: string);
  begin
    Strings.SaveToStream(Stream);
    Stream.Seek(0, soFromBeginning);
    Zipper.AddFromStream(FN, Stream);
    Stream.Clear;
    Strings.Clear;
  end;

begin

  if FileExists(FileName) then SysUtils.DeleteFile(FileName);

  Strings := TStringList.Create;
  Stream  := TMemoryStream.Create;

  try
    Zipper := TAbZipper.Create(Nil);
    Zipper.ArchiveType := atZip;
    Zipper.AutoSave := True;
    Zipper.ForceType := True;
    Zipper.CompressionMethodToUse := smDeflated;
    Zipper.DeflationOption := doNormal;
    Zipper.FileName := FileName;

    FunctionsToLines(Fit.Functions, Strings);
    AddString('FitFunctions.json');

    SeriesToText(Strings, Background);
    AddString('background.dat');

    SeriesToText(Strings, Data);
    AddString('Data.dat');

    Zipper.CloseArchive;
  finally
    FreeAndNil(Strings);
    FreeAndNil(Stream);
    FreeAndNil(Zipper);
  end;
end;


procedure FunctionsToLines(F: TFitSets; var Strings: TStringList);
var
  i: Integer;

  JSON: TJSONObject;
  JSONArray: TJSONArray;
begin
  JSON := TJSONObject.Create;

  try
    JSON.AddPair('Contents','FitFunctions');
    JSONArray := TJSONArray.Create;

    for I := 0 to High(F) do
      JSONArray.Addelement(FunctionToJSON(F[i],i));

    JSON.AddPair('Fits', JSONArray);

    Strings.Text := JSON.ToString;
  finally
    FreeAndNil(JSON);
  end;
end;


function JSonVariable(V: TVariable):TJSONObject;
begin
  Result := TJSONObject.Create;

  Result.AddPair('Last', TJSONNumber.Create(V.Last));
  Result.AddPair('d', TJSONNumber.Create(V.d));
  Result.AddPair('min', TJSONNumber.Create(V.min));
  Result.AddPair('max', TJSONNumber.Create(V.max));
end;


function FunctionToJSON(F: TFitSet; Id: integer): TJSONObject;
var
  JVar: TJSONObject;

begin
  Result := TJSONObject.Create;
  Result.AddPair('ID', TJSONNumber.Create(Id));

  JVar := JSonVariable(F.A);
  Result.AddPair('A', JVar);

  JVar := JSonVariable(F.xc);
  Result.AddPair('xc', JVar);

  JVar := JSonVariable(F.W);
  Result.AddPair('W', JVar);

  JVar := JSonVariable(F.s);
  Result.AddPair('s', JVar);

end;

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

    if (s1 <> '') and (s2 <> '') and (s1[1].IsNumber and s2[1].IsNumber) then
    try
      SetLength(Data, Length(Data) + 1);
      SetLength(Background, Length(Background) + 1);
      x := StrToFloat(s1);
      y := StrToFloat(s2);
      Data[j].x := x;
      Background[j].x := x;
      Data[j].y := y;
      if (NCol = 3) and (s3[1].IsNumber) then
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

    if (s1 <> '') and (s2 <> '') and (s1[1].IsNumber) and (s2[1].IsNumber) then
    try
      x := StrToFloat(s1);
      y := StrToFloat(s2);
      Data.AddXY(x, y);

      if (NCol = 3) and  (s3[1].IsNumber) then
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


procedure SeriesFromTextS(var MyStringList: TStringList; var Data :TLineSeries);
var
  i, p: integer;
  s1, s2: string;
  x, y: single;
  Separator: string;
begin
  Separator := TabSeparator;
  Data.Clear;

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

    if (s1 <> '') and (s2 <> '') and (s1[1].IsNumber) and (s2[1].IsNumber) then
    try
      x := StrToFloat(s1);
      y := StrToFloat(s2);
      Data.AddXY(x, y);

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
