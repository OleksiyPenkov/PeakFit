unit unit_GaussFit;

interface

uses
  System.SysUtils, System.Math, unit_const;

type

  TFit = class(TObject)
  private
    Max: single;
    Data: TDataArray;
    Background: TDataArray;

    FResults: TResults;
    FSum: TDataArray;

    FLastChiSqr: Single;

    FFunctions: TFitSets;
    FMode: TFitMode;
    FNMax: Integer;

    function ChiSqrM: single;
    function DataValue(const x: single): single;
    function Rnd: single;
    function GaussF(const x: single; F: TFitSet): single;
    procedure CalcResulingCurves;
    function Curve(const index: Integer): TDataArray;
    function GLCrossF(const x: single; F: TFitSet): single;
  public
    constructor Create;
    destructor Free;
    procedure Init;
    procedure Zero;
    function DoFitGauss(Nmax: integer):single;
    function Process(const AData, ABackground: TDataArray): single;
    property Result:TResults read FResults;
    property Sum:TDataArray read FSum;
    property LastChiSqr: Single read FLastChiSqr;
    property Functions: TFitSets read FFunctions write FFunctions;
    property NMax: Integer write FNMax;
  end;

var
  Fit: TFit;

implementation


function TFit.GaussF(const x: single; F: TFitSet): single;
begin
  Result := 2 * F.A.Last * exp(- _4ln2 * (sqr(x - F.xc.Last) / sqr(F.W.Last)))/(F.W.Last * 1.064);
end;

function TFit.GLCrossF(const x: single; F: TFitSet): single;
var
  B: Single;
begin
  B := sqr((x - F.xc.Last)/F.W.Last);
  Result := F.A.Last/(1 + F.s.Last*(B*exp(0.5*(1 - F.s.Last)*B)));
end;

function TFit.Process(const AData, ABackground: TDataArray): single;
begin
  Data := AData;
  Background := ABackground;
  Result := DoFitGauss(FNMax);
end;

procedure TFit.CalcResulingCurves;
var
  i, j: integer;
  S: string;
  Sum, y: single;
begin
  SetLength(FResults, High(FFunctions) + 1);
  for j := 0 to High(FFunctions) do
    SetLength(FResults[j], High(Data));

  SetLength(FSum, High(Data));

  for i := 0 to High(Data) do
  begin
    S := '';
    Sum := 0;
    for j := 0 to High(FFunctions) do
    begin
      FResults[j][i].x := Data[i].x;
      case FMode of
        fmGauss  :  y := GaussF(Data[i].x, FFunctions[j]);
        fmGLCross:  y := GLCrossF(Data[i].x, FFunctions[j]);
      end;
      FResults[j][i].y := y + Background[i].y;
      Sum := Sum + y;
    end;
    FSum[i].x := Data[i].x;
    FSum[i].y := Sum + + Background[i].y;
  end;
end;

function TFit.ChiSqrM: single;
var
  i, j: integer;
  Sum, y: single;
begin
  Result := 0;

  for i := Low(Data) to High(Data) do
  begin
    Sum := 0;
    if Data[i].y = 0 then Continue ;

    for j := Low(FFunctions) to High(FFunctions) do
    begin
      case FMode of
        fmGauss  :  y := GaussF(Data[i].x, FFunctions[j]);
        fmGLCross:  y := GLCrossF(Data[i].x, FFunctions[j]);
      end;
      Sum := Sum + y;
    end;
    Sum := Sum + Background[i].y;
    Result := Result + sqr(Sum - Data[i].y )/Data[i].y ;
  end;
end;

constructor TFit.Create;
begin
  inherited Create;
  SetLength(FResults, 0);
  SetLength(FFunctions, 0);
  FMode := fmGLCross;
  FNMax := 5000;
end;


function TFit.Curve(const index: Integer): TDataArray;
begin

end;

function TFit.Rnd: single;
begin
  Result := (Random(100) - 50) / 50;
end;

procedure TFit.Zero;
begin
  SetLength(FFunctions, 0);
end;

function TFit.DataValue(const x: single): single;
var
  i: integer;
begin
  Result := Max;
  for i := Low(Data) to High(Data) - 1 do
    if (x >= Data[i].x) and (x < Data[i + 1].x) then
    begin
      Result := Data[i].y;
      Break;
    end;
end;

destructor TFit.Free;
begin
  inherited Destroy;
end;

procedure TFit.Init;
const
  peaks: array [0 .. 2] of single = (227, 230.86, 233);
var
  i: Integer;
begin
  SetLength(FFunctions, 0);
  SetLength(FFunctions, High(Peaks) + 1);

  for i := Low(FFunctions) to High(FFunctions) do
  begin
    FFunctions[i].xc.Last  := peaks[i];
    FFunctions[i].xc.min := peaks[i] - 0.2;
    FFunctions[i].xc.max := peaks[i] + 0.2;
    FFunctions[i].xc.RF  := 0.005;

    FFunctions[i].A.Last  := DataValue(peaks[i]);
    FFunctions[i].A.Max := FFunctions[i].A.Last * 3;
    FFunctions[i].A.min := FFunctions[i].A.Last / 10;
    FFunctions[i].A.RF  := 200;

    FFunctions[i].W.Last  := 0.1;
    FFunctions[i].W.min := 0.5;
    FFunctions[i].W.Max := 3;
    FFunctions[i].W.RF  := 0.05;

    FFunctions[i].s.Last  := 0.6;
    FFunctions[i].s.min := 0.4;
    FFunctions[i].s.Max := 0.8;
    FFunctions[i].s.RF  := 0.005;
  end;
end;

function TFit.DoFitGauss(Nmax: integer):single;
var
  ChiSqrMin, ChiSqrLast: single;
  i, N: integer;

  procedure Swap(const i: Integer; var V: TVariable);
  var
    prev: Single;
  begin
    prev := v.Last;
    V.d := Rnd * V.RF;
    V.Last := V.Last + V.d;
    V.Bound;
    ChiSqrLast := ChiSqrM;
    if ChiSqrLast > ChiSqrMin then
    begin
      v.Last := prev ;
    end
    else begin
      while ChiSqrLast < ChiSqrMin do
      begin
        ChiSqrMin := ChiSqrLast;
        V.d := V.d * Random(2);
        V.Last := V.Last + V.d;
        if V.Bound then  Break;
        ChiSqrLast := ChiSqrM;
      end;
    end;

  end;


begin
  Randomize;
  ChiSqrMin := ChiSqrM;
  N := 0;
  while (ChiSqrMin > 0) and (N < Nmax ) do
  begin
    for i := Low(FFunctions) to High(FFunctions) do
    begin
      Swap(i, FFunctions[i].xc);
      Swap(i, FFunctions[i].A);
      Swap(i, FFunctions[i].W);
      Swap(i, FFunctions[i].s);
    end;
    inc(N);
  end;

  CalcResulingCurves;
  FLastChiSqr := ChiSqrMin;
end;

end.
