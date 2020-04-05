unit unit_const;

interface

const

  NPeaks = 2;

  sqrtpi = 1.25331;
  _4ln2  = 2.772588722;
type

  TFitMode = (fmGauss, fmSigma);

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

  TGaussFitSet = record
    A, xc, W: TVariable;
  end;

//  TGaussFitSet = record
//    x0, A0, W0: single;
//    lastX, lastA, lastW: single;
//    dA, dXc, dW: single;
//    xc_min, xc_max: single;
//    W_min, W_Max: single;
//    A_min, A_Max: single;
//  end;


implementation

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

end.
