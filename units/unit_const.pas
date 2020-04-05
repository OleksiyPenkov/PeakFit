unit unit_const;

interface

const

  NPeaks = 2;

  sqrtpi = 1.25331;
  peaks: array [1 .. NPeaks] of single = (227, 230);

type

  TFitMode = (fmGauss, fmSigma);

  TDataPoint = record
    x, y: single;
  end;

  TDataArray = array of TDataPoint;

  TResults   = array of TDataArray;

  TGaussFunction = record
    A, xc, W: single;
  end;

  TGaussFunctions = array [1 .. NPeaks] of TGaussFunction;

  TSigmaFunction = record
    N, sigma, nu: Single;
  end;

  TGaussFitSet = record
    x0, A0, W0: single;
    lastX, lastA, lastW: single;
    dA, dXc, dW: single;
    xc_min, xc_max: single;
    W_min, W_Max: single;
    A_min, A_Max: single;
  end;


implementation

end.
