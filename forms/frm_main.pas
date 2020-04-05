unit frm_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VCLTee.TeEngine,
  VCLTee.TeeProcs, VCLTee.Chart, System.ImageList, Vcl.ImgList, RzPanel,
  Vcl.Menus, ActnCtrls, System.Actions, Vcl.ActnList, Vcl.ActnMan,
  Vcl.ExtCtrls, VCLTee.Series, RzStatus;

type
  TfrmMain = class(TForm)
    StatusBar: TRzStatusBar;
    MainMenu: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    N1: TMenuItem;
    Print1: TMenuItem;
    N2: TMenuItem;
    Exit1: TMenuItem;
    Data1: TMenuItem;
    Fit1: TMenuItem;
    Help1: TMenuItem;
    Edit1: TMenuItem;
    Preferences1: TMenuItem;
    MainToolBar: TRzToolbar;
    ImageList32: TImageList;
    Chart: TChart;
    Actions: TActionList;
    actFileExit: TAction;
    MainSeries: TLineSeries;
    actDataImport: TAction;
    dlgImportData: TOpenDialog;
    Importformfile1: TMenuItem;
    actFitGauss: TAction;
    Gauss1: TMenuItem;
    SumSeries: TLineSeries;
    pnlChi: TRzStatusPane;
    procedure actFileExitExecute(Sender: TObject);
    procedure actDataImportExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actFitGaussExecute(Sender: TObject);
  private
    { Private declarations }

    ResultSeries: array of TLineSeries;
    procedure ClearSeries;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  unit_utils, unit_GaussFit, unit_const;

{$R *.dfm}

procedure TfrmMain.actDataImportExecute(Sender: TObject);
begin
  if dlgImportData.Execute then
  begin
    SeriesFromFile(MainSeries, dlgImportData.FileName);
  end;
end;

procedure TfrmMain.actFileExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.actFitGaussExecute(Sender: TObject);
var
  Data: TDataArray;
  i: Integer;
begin
  ClearSeries;
  Data := SeriesToData(MainSeries);
  Fit.Process(Data);

  SetLength(ResultSeries, NPeaks);

  for I := 0 to High(ResultSeries) do
  begin
    ResultSeries[i] := TLineSeries.Create(Chart);
    Chart.AddSeries(ResultSeries[i]);
  end;

  for i := 0 to High(Fit.Result) do
    DataToSeries(Fit.Result[i], ResultSeries[i]);

  DataToSeries(Fit.Sum, SumSeries);
  pnlChi.Caption := FloatToStrF(Fit.LastChiSqr, ffFixed, 6, 3);
end;

procedure TfrmMain.ClearSeries;
var
  i: Integer;
begin
  for I := 0 to High(ResultSeries) do
    ResultSeries[i].Free;
  SetLength(ResultSeries, 0);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Fit := TFit.Create;

  if ParamCount = 1 then
    SeriesFromFile(MainSeries, ParamStr(1));
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Fit);
end;

end.
