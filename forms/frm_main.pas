unit frm_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VCLTee.TeEngine,
  VCLTee.TeeProcs, VCLTee.Chart, System.ImageList, Vcl.ImgList, RzPanel,
  Vcl.Menus, ActnCtrls, System.Actions, Vcl.ActnList, Vcl.ActnMan,
  Vcl.ExtCtrls, VCLTee.Series, RzStatus, RzButton, unit_messages;

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
    Window1: TMenuItem;
    actWinShowLog: TAction;
    ShowLog1: TMenuItem;
    actWinFunctions: TAction;
    Params1: TMenuItem;
    Background: TLineSeries;
    btnBtnOpen: TRzToolButton;
    btnBtnSave: TRzToolButton;
    btnImport: TRzToolButton;
    btnFit: TRzToolButton;
    btnFunctionsWindow: TRzToolButton;
    actFileSave: TAction;
    actFileOpen: TAction;
    dlgSave: TSaveDialog;
    dlgOpen: TOpenDialog;
    procedure actFileExitExecute(Sender: TObject);
    procedure actDataImportExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actFitGaussExecute(Sender: TObject);
    procedure actWinShowLogExecute(Sender: TObject);
    procedure actWinFunctionsExecute(Sender: TObject);
    procedure actFileSaveExecute(Sender: TObject);
    procedure actFileOpenExecute(Sender: TObject);
  private
    { Private declarations }

    ResultSeries: array of TLineSeries;
    procedure ClearSeries;
    procedure OnCalcMessage(var Msg: TMessage); message WM_RECALC;
    procedure PlotGraphs;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  unit_utils, unit_GaussFit, unit_const, frm_log, frm_EditorTest;

{$R *.dfm}

procedure TfrmMain.actDataImportExecute(Sender: TObject);
begin
  if dlgImportData.Execute then
  begin
    SeriesFromFile(MainSeries, Background, dlgImportData.FileName);
  end;
end;

procedure TfrmMain.actFileExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.actFileOpenExecute(Sender: TObject);
var
  Data, BG: TDataArray;
begin
 if dlgOpen.Execute then
 begin
   LoadProject(MainSeries, Background, dlgOpen.FileName);

     ClearSeries;
   Data := SeriesToData(MainSeries);
   BG   := SeriesToData(Background);
   Fit.NMax := 0;
   Fit.Process(Data, BG);
   PlotGraphs;
   Fit.NMax := 5000;
 end;
end;

procedure TfrmMain.actFileSaveExecute(Sender: TObject);
begin
 if dlgSave.Execute then
   SaveProject(MainSeries, Background, dlgSave.FileName);
end;

procedure TfrmMain.PlotGraphs;
var
  i: Integer;
begin
  SetLength(ResultSeries, High(Fit.Functions) + 1);

  for I := 0 to High(ResultSeries) do
  begin
    ResultSeries[i] := TLineSeries.Create(Chart);
    Chart.AddSeries(ResultSeries[i]);
    ResultSeries[i].LinePen.Width := 2;
  end;

  for i := 0 to High(Fit.Result) do
  begin
    DataToSeries(Fit.Result[i], ResultSeries[i]);
    frmLog.Memo.Lines.Add('Peak ' + IntToStr(i + 1) + ' ' + Fit.Functions[i].ToString);
  end;

  DataToSeries(Fit.Sum, SumSeries);
  pnlChi.Caption := FloatToStrF(Fit.LastChiSqr, ffFixed, 6, 3);

end;

procedure TfrmMain.actFitGaussExecute(Sender: TObject);
var
  Data, BG: TDataArray;

begin
  ClearSeries;
  Data := SeriesToData(MainSeries);
  BG   := SeriesToData(Background);

  Fit.Process(Data, BG);
  PlotGraphs;
end;

procedure TfrmMain.actWinFunctionsExecute(Sender: TObject);
begin
  frmEditorTest.WriteData(Fit.Functions);
  frmEditorTest.MainForm := Self.Handle;
  frmEditorTest.ShowModal;
 end;

procedure TfrmMain.actWinShowLogExecute(Sender: TObject);
begin
  frmLog.Show;
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

//  {$IFDEF  DEBUG}
//  if ParamCount = 1 then
//    SeriesFromFile(MainSeries, Background, ParamStr(1));
//  {$ENDIF}
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Fit);
end;

procedure TfrmMain.OnCalcMessage(var Msg: TMessage);
begin
  Fit.Functions := frmEditorTest.GetData;
  actFitGaussExecute(Self);
  frmEditorTest.WriteData(Fit.Functions);
end;


end.
