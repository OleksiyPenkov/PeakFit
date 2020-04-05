unit unit_GaussFit;

interface

uses
  System.SysUtils, System.Math, unit_const;

type

  TFit = class(TObject)
  private
    Max: single;
    Data: TDataArray;

    FResults: TResults;
    FSum: TDataArray;

    FLastChiSqr: Single;

    Functions: array of TGaussFitSet;

    function ChiSqrM: single;
    function DataValue(const x: single): single;
    function DoFitGauss(Nmax: integer):single;
    function Rnd: single;
    function GaussF(const x: single; F: TGaussFitSet): single;
    procedure CalcResulingCurves;
    function Curve(const index: Integer): TDataArray;
  public
    constructor Create;
    destructor Free;

    function Process(const AData: TDataArray): single;

    property Result:TResults read FResults;
    property Sum:TDataArray read FSum;
    property LastChiSqr: Single read FLastChiSqr;

  end;

var
  Fit: TFit;

implementation


function TFit.GaussF(const x: single; F: TGaussFitSet): single;
begin
  Result := 2 * F.A.Last * exp(- _4ln2 * (sqr(x - F.xc.Last) / sqr(F.W.Last)))/(F.W.Last * 1.064);
end;

function TFit.Process(const AData: TDataArray): single;
begin
  Data := AData;
  Result := DoFitGauss(500);
end;

procedure TFit.CalcResulingCurves;
var
  i, j: integer;
  S: string;
  Sum, y: single;
begin
  for j := 0 to NPeaks - 1 do
    SetLength(FResults[j], High(Data));

  SetLength(FSum, High(Data));

  for i := 0 to High(Data) do
  begin
    S := '';
    Sum := 0;
    for j := 0 to NPeaks - 1 do
    begin
      FResults[j][i].x := Data[i].x;
      y := GaussF(Data[i].x, Functions[j]);
      FResults[j][i].y := y;
      Sum := Sum + y;
    end;
    FSum[i].x := Data[i].x;
    FSum[i].y := Sum;
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

    for j := Low(Functions) to High(Functions) do
    begin
      y := GaussF(Data[i].x, Functions[j]);
      Sum := Sum + y;
    end;
    Result := Result + sqr(Sum - Data[i].y )/Data[i].y;
  end;
end;

constructor TFit.Create;
begin
  inherited Create;
  SetLength(FResults, NPeaks);
  SetLength(Functions, NPeaks);
end;


function TFit.Curve(const index: Integer): TDataArray;
begin

end;

function TFit.Rnd: single;
begin
  Result := (Random(100) - 50) / 50;
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

function TFit.DoFitGauss(Nmax: integer):single;
const
  peaks: array [0 .. 1] of single = (227, 230.86);

var
  ChiSqrMin, ChiSqrLast: single;
  i, N: integer;

  procedure Init;
  var
    i: Integer;


  begin
    Randomize;
    for i := Low(Functions) to High(Functions) do
    begin
      Functions[i].xc.v0  := peaks[i];
      Functions[i].xc.min := peaks[i] - 1;
      Functions[i].xc.max := peaks[i] + 1;
      Functions[i].xc.RF  := 0.1;

      Functions[i].A.v0  := DataValue(peaks[i]);
      Functions[i].A.Max := Functions[i].A.v0 * 3;
      Functions[i].A.min := Functions[i].A.v0 / 10;
      Functions[i].A.RF  := 100;

      Functions[i].W.v0  := 1;
      Functions[i].W.min := 1;
      Functions[i].W.Max := 2;
      Functions[i].W.RF  := 0.2;

      Functions[i].A.last := Functions[i].A.V0;
      Functions[i].W.last := Functions[i].W.V0;
      Functions[i].xc.last := Functions[i].xc.V0;
    end;

    ChiSqrMin := ChiSqrM;
  end;

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
  Init;
  N := 0;
  while ChiSqrMin > 0 do
  begin
    for i := Low(Functions) to High(Functions) do
    begin
      Swap(i, Functions[i].xc);
      Swap(i, Functions[i].A);
      Swap(i, Functions[i].W);
    end;
    inc(N);
    if N > Nmax then
      Break;
  end;

  CalcResulingCurves;
  FLastChiSqr := ChiSqrMin;
end;

end.
