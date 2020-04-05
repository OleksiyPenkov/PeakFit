unit unit_const;

interface

const

  NPeaks = 3;

  sqrtpi = 1.25331;
  _4ln2  = 2.772588722;

type

  TFitMode = (fmGauss, fmGLCross);

  TDataPoint = record
    x, y: single;
  end;

  TDataArray = array of TDataPoint;

  TResults   = array of TDataArray;


  TVariable =record
    v0   : Single;
    Last : Single;
    d    : Single;
    min, max: Single;
    RF: single; //random factor

    function Bound:boolean;
  end;

  TFitSet = record
    A, xc, W, s: TVariable;

    function ToString: string;
  end;

  TFitSets = array of TFitSet;


implementation

uses
  System.SysUtils;

function TVariable.Bound:boolean;
begin
  Result := False;
  if Last < min then
  begin
    last := min;
    Result := True;
  end;
  if Last > max then
  begin
    Last := max;
    Result := True;
  end;
end;

function TFitSet.ToString:string;
begin
  Result := FloatToStrF(xc.Last, ffFixed, 6, 3) + '  ' +
            FloatToStrF(A.Last, ffFixed, 6, 3) + '  ' +
            FloatToStrF(2 * W.Last, ffFixed, 6, 3) + '  ' +
            FloatToStrF(s.Last, ffFixed, 6, 3);
end;

end.
