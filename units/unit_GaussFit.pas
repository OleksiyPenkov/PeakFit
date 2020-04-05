unit unit_GaussFit;

interface

uses
  System.SysUtils, System.Math, unit_const;

type

  TFit = class(TObject)
  private
    Max: single;
    Data: TDataArray;

    Functions: TGaussFunctions;

    FLastSigma: TSigmaFunction;

    FResults: TResults;
    FSum: TDataArray;

    function ChiSqrM: single;
    function DataValue(const x: single): single;
    function DoFitGauss(Nmax: integer):single;
    function Rnd: single;
    function GaussF(const x: single; F: TGaussFunction): single;
    procedure CalcResulingCurves;
    function Curve(const index: Integer): TDataArray;
  public
    constructor Create;
    destructor Free;

    function Process(const AData: TDataArray): single;

    property Result:TResults read FResults;
    property Sum:TDataArray read FSum;

  end;

var
  Fit: TFit;

implementation


function TFit.GaussF(const x: single; F: TGaussFunction): single;
begin
  Result := F.A / (F.W * sqrtpi) * exp(-2 * (sqr(x - F.xc) / sqr(F.W)));;
end;

function TFit.Process(const AData: TDataArray): single;
begin
  Data := AData;
  Result := DoFitGauss(1000);
end;

procedure TFit.CalcResulingCurves;
var
  i, j: integer;
  S: string;
  Sum, y: single;
begin
  for j := Low(Functions) to High(Functions) do
    SetLength(FResults[j], High(Data));

  SetLength(FSum, High(Data));

  for i := 0 to High(Data) do
  begin
    S := '';
    Sum := 0;
    for j := Low(Functions) to High(Functions) do
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
  Sum: single;
begin
  Result := 0;

  for i := Low(Data) to High(Data) do
  begin
    Sum := 0;
    for j := Low(Functions) to High(Functions) do
      Sum := Sum + GaussF(Data[i].x, Functions[j]);
    Result := Result + sqr(Data[i].y - Sum)
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
  peaks: array [0 .. 1] of single = (227.5, 230.7);

var
  ChiSqrMin, ChiSqrLast: single;
  i, N: integer;

  GaussFitSets: array of TGaussFitSet;

  procedure Init;
  var
    i: Integer;
  begin
    Randomize;
    SetLength(GaussFitSets, NPeaks);
    for i := Low(Functions) to High(Functions) do
    begin
      GaussFitSets[i].x0 := peaks[i];
      GaussFitSets[i].xc_min := peaks[i] - 0.25;
      GaussFitSets[i].xc_max := peaks[i] + 0.25;

      GaussFitSets[i].A0 := DataValue(peaks[i]);
      GaussFitSets[i].A_Max := GaussFitSets[i].A0 * 2;
      GaussFitSets[i].A_min := GaussFitSets[i].A0 / 10;

      GaussFitSets[i].W0 := 0.5;
      GaussFitSets[i].W_min := 0.1;
      GaussFitSets[i].W_Max := 3;

      Functions[i].A := GaussFitSets[i].A0;
      Functions[i].W := GaussFitSets[i].W0;
      Functions[i].xc := GaussFitSets[i].x0;

      GaussFitSets[i].lastA := GaussFitSets[i].A0;
      GaussFitSets[i].lastW := GaussFitSets[i].W0;
    end;

    ChiSqrMin := ChiSqrM;
  end;

  function Bound(var val, min, max: Single):boolean;
  begin
    Result := False;
    if val < min then
    begin
      val := min;
      Result := True;
    end;
    if val > max then
    begin
      val := max;
      Result := True;
    end;
  end;

  procedure SwapXc(const i: Integer);
  begin
    GaussFitSets[i].dXc := Rnd / 10;
    Functions[i].Xc := Functions[i].Xc + GaussFitSets[i].dXc;
    Bound(Functions[i].Xc, GaussFitSets[i].xc_min, GaussFitSets[i].xc_Max);
    ChiSqrLast := ChiSqrM;
    while ChiSqrLast < ChiSqrMin do
    begin
      GaussFitSets[i].lastX := Functions[i].Xc;
      ChiSqrMin := ChiSqrLast;
      GaussFitSets[i].dXc := GaussFitSets[i].dXc * Random(2);
      Functions[i].Xc := Functions[i].Xc + GaussFitSets[i].dXc;
      if Bound(Functions[i].Xc,
               GaussFitSets[i].xc_min,
               GaussFitSets[i].xc_Max) then
      begin
        GaussFitSets[i].lastX := Functions[i].Xc;
        Break;
      end;
      ChiSqrLast := ChiSqrM;
    end;
    Functions[i].xc := GaussFitSets[i].lastX;
  end;


  procedure SwapA(const i: Integer);
  begin
    GaussFitSets[i].dA := Rnd / 5;
    Functions[i].A := Functions[i].A + GaussFitSets[i].dA;
    Bound(Functions[i].A, GaussFitSets[i].A_min, GaussFitSets[i].A_Max);
    ChiSqrLast := ChiSqrM;
    while ChiSqrLast < ChiSqrMin do
    begin
      GaussFitSets[i].lastA := Functions[i].A;
      ChiSqrMin := ChiSqrLast;
      GaussFitSets[i].dA := GaussFitSets[i].dA * Random(2);
      Functions[i].A := Functions[i].A + GaussFitSets[i].dA;
      if Bound(Functions[i].A,
               GaussFitSets[i].A_min,
               GaussFitSets[i].A_Max) then
      begin
        GaussFitSets[i].lastA := Functions[i].A;
        Break;
      end;
      ChiSqrLast := ChiSqrM;
    end;
    Functions[i].A := GaussFitSets[i].lastA;
  end;


  procedure SwapW(const i: Integer);
  begin
    GaussFitSets[i].dW := Rnd / 10;
    Functions[i].W := Functions[i].W + GaussFitSets[i].dW;
    Bound(Functions[i].W, GaussFitSets[i].W_min, GaussFitSets[i].W_Max);
    ChiSqrLast := ChiSqrM;
    while ChiSqrLast < ChiSqrMin do
    begin
      GaussFitSets[i].lastW := Functions[i].W;
      ChiSqrMin := ChiSqrLast;
      GaussFitSets[i].dW := GaussFitSets[i].dW * Random(2);
      Functions[i].W := Functions[i].W + GaussFitSets[i].dW;
      if Bound(Functions[i].W,
               GaussFitSets[i].W_min,
               GaussFitSets[i].W_Max) then
      begin
        GaussFitSets[i].lastW := Functions[i].W;
        Break;
      end;
      ChiSqrLast := ChiSqrM;
    end;
    Functions[i].W := GaussFitSets[i].lastW;
  end;


begin
  Init;

  N := 0;

  while ChiSqrMin > 0 do
  begin
    for i := Low(Functions) to High(Functions) do
    begin
      SwapXc(i);
      SwapA(i);
      SwapW(i);
    end;
    inc(N);
    if N > Nmax then
      Break;
  end;

  CalcResulingCurves;

end;

end.
