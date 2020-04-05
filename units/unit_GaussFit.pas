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
  Result := DoFitGauss(2000);
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

  for i := 1 to High(Data) do
  begin
    S := '';
    Sum := 0;
    for j := Low(Functions) to High(Functions) do
    begin
      FResults[j][i].x := Data[i].x;
      FResults[j][i].y := GaussF(Data[i].x, Functions[j]);
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
var
  ChiSqrMin, ChiSqrLast: single;
  i, N: integer;

  A0: single;
  F0: TGaussFunction;

  GaussFitSets: array [1 .. NPeaks] of TGaussFitSet;

begin
  Randomize;

  F0.A := 1;
  F0.xc := peaks[1];
  F0.W := 0.05;

  A0 := GaussF(peaks[1], F0);

  for i := Low(Functions) to High(Functions) do
  begin
    GaussFitSets[i].x0 := peaks[i];
    GaussFitSets[i].A_Max := DataValue(peaks[i]) / A0 * 1.5;
    GaussFitSets[i].A0 := GaussFitSets[i].A_Max;

    GaussFitSets[i].W0 := 0.04;
    GaussFitSets[i].A_min := 0.001;

    GaussFitSets[i].W_min := 0.03;
    GaussFitSets[i].W_Max := 0.1;

    Functions[i].A := GaussFitSets[i].A0;
    Functions[i].W := GaussFitSets[i].W0;
    Functions[i].xc := GaussFitSets[i].x0;

    GaussFitSets[i].lastA := GaussFitSets[i].A0;
    GaussFitSets[i].lastW := GaussFitSets[i].W0;
  end;

  ChiSqrMin := ChiSqrM;

  N := 0;

  while ChiSqrMin > 0 do
  begin
    for i := Low(Functions) to High(Functions) do
    begin
      GaussFitSets[i].dA := Rnd / 5;
      Functions[i].A := Functions[i].A + GaussFitSets[i].dA;

      if (Functions[i].A < GaussFitSets[i].A_min) then
        Functions[i].A := GaussFitSets[i].A_min;
      if (Functions[i].A > GaussFitSets[i].A_Max) then
        Functions[i].A := GaussFitSets[i].A_Max;

      ChiSqrLast := ChiSqrM;
      while ChiSqrLast < ChiSqrMin do
      begin
        GaussFitSets[i].lastA := Functions[i].A;
        ChiSqrMin := ChiSqrLast;
        GaussFitSets[i].dA := GaussFitSets[i].dA * Random(2);
        Functions[i].A := Functions[i].A + GaussFitSets[i].dA;

        if (Functions[i].A < GaussFitSets[i].A_min) then
        begin
          Functions[i].A := GaussFitSets[i].A_min;
          GaussFitSets[i].lastA := Functions[i].A;
          Break;
        end;
        if (Functions[i].A > GaussFitSets[i].A_Max) then
        begin
          Functions[i].A := GaussFitSets[i].A_Max;
          GaussFitSets[i].lastA := Functions[i].A;
          Break;
        end;

        ChiSqrLast := ChiSqrM;
      end;

      Functions[i].A := GaussFitSets[i].lastA;
      if (Functions[i].A < GaussFitSets[i].A_min) then
        Functions[i].A := GaussFitSets[i].A_min;
      if (Functions[i].A > GaussFitSets[i].A_Max) then
        Functions[i].A := GaussFitSets[i].A_Max;

      GaussFitSets[i].dW := Rnd * Functions[i].W / 10;
      Functions[i].W := Functions[i].W + GaussFitSets[i].dW;

      if (Functions[i].W < GaussFitSets[i].W_min) then
        Functions[i].W := GaussFitSets[i].W_min;
      if (Functions[i].W > GaussFitSets[i].W_Max) then
        Functions[i].W := GaussFitSets[i].W_Max;

      ChiSqrLast := ChiSqrM;
      while ChiSqrLast < ChiSqrMin do
      begin
        GaussFitSets[i].lastW := Functions[i].W;
        ChiSqrMin := ChiSqrLast;
        GaussFitSets[i].dW := GaussFitSets[i].dW * Random(2);
        Functions[i].W := Functions[i].W + GaussFitSets[i].dW;

        if (Functions[i].W < GaussFitSets[i].W_min) then
        begin
          Functions[i].W := GaussFitSets[i].W_min;
          GaussFitSets[i].lastW := Functions[i].W;
          Break;
        end;
        if (Functions[i].W > GaussFitSets[i].W_Max) then
        begin
          Functions[i].W := GaussFitSets[i].W_Max;
          GaussFitSets[i].lastW := Functions[i].W;
          Break;
        end;

        ChiSqrLast := ChiSqrM;
      end;
      Functions[i].W := GaussFitSets[i].lastW;
    end;
    inc(N);
    if N > Nmax then
      Break;
  end;

  CalcResulingCurves;

end;

end.
