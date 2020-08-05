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
    StatusX: TRzStatusPane;
    StatusY: TRzStatusPane;
    actResultExportClpbrd: TAction;
    BtnCopyAll: TRzToolButton;
    oolk1: TMenuItem;
    actToolsShift: TAction;
    Shift1: TMenuItem;
    actFileSaveAs: TAction;
    Saveas1: TMenuItem;
    actFileNew: TAction;
    BtnNew: TRzToolButton;
    actFileLoadFunctions: TAction;
    N3: TMenuItem;
    N4: TMenuItem;
    Loadfunctions1: TMenuItem;
    procedure actFileExitExecute(Sender: TObject);
    procedure actDataImportExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actFitGaussExecute(Sender: TObject);
    procedure actWinShowLogExecute(Sender: TObject);
    procedure actWinFunctionsExecute(Sender: TObject);
    procedure actFileSaveExecute(Sender: TObject);
    procedure actFileOpenExecute(Sender: TObject);
    procedure ChartDblClick(Sender: TObject);
    procedure ChartMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ChartClickSeries(Sender: TCustomChart; Series: TChartSeries;
      ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
    procedure ChartMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure actResultExportClpbrdExecute(Sender: TObject);
    procedure actToolsShiftExecute(Sender: TObject);
    procedure actFileSaveAsExecute(Sender: TObject);
    procedure actFileNewExecute(Sender: TObject);
    procedure actFileLoadFunctionsExecute(Sender: TObject);
  private
    { Private declarations }
    FFileName: string;

    FLastX: single;

    ResultSeries: array of TLineSeries;
    FLastY: Single;
    FSeriesSelected: Boolean;
    FSeriesIndex: Integer;
    SeriesDragStartX: Integer;
    SeriesDragStartY: Integer;
    FPeakSelected: Boolean;
    procedure ClearSeries;
    procedure OnCalcMessage(var Msg: TMessage); message WM_RECALC;
    procedure PlotGraphs;
    procedure UpdateGraphs;
    procedure SetCaption;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  unit_utils, unit_GaussFit, unit_const, frm_log, frm_EditorTest, ClipBrd;

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

procedure TfrmMain.actFileLoadFunctionsExecute(Sender: TObject);
var
  Data, BG: TDataArray;
begin
 if dlgOpen.Execute then
 begin
   ClearSeries;
   Fit.Zero;

   Data := SeriesToData(MainSeries);
   BG   := SeriesToData(Background);

   LoadProject(MainSeries, Background, dlgOpen.FileName, True);

   Fit.NMax := 0;
   Fit.Process(Data, BG);
   PlotGraphs;
   Fit.NMax := 5000;

   SetCaption;
 end;end;


procedure TfrmMain.actFileNewExecute(Sender: TObject);
begin
  MainSeries.Clear;
  Background.Clear;
  ClearSeries;

  Fit.Zero;

  FFileName := 'NONAME';
  SetCaption;
end;

procedure TfrmMain.actFileOpenExecute(Sender: TObject);
var
  Data, BG: TDataArray;
begin
 if dlgOpen.Execute then
 begin
   FFileName := dlgOpen.FileName;

   LoadProject(MainSeries, Background, FFileName);

   ClearSeries;
   Data := SeriesToData(MainSeries);
   BG   := SeriesToData(Background);
   Fit.NMax := 0;
   Fit.Process(Data, BG);
   PlotGraphs;
   Fit.NMax := 5000;

   SetCaption;
 end;
end;

procedure TfrmMain.actFileSaveAsExecute(Sender: TObject);
begin
  if dlgSave.Execute then
  begin
    FFileName := dlgSave.FileName;
    SaveProject(MainSeries, Background, FFileName);
    SetCaption;
  end;
end;

procedure TfrmMain.actFileSaveExecute(Sender: TObject);
begin
 if FFileName = 'NONAME' then
   actFileSaveExecute(Sender)
 else
   SaveProject(MainSeries, Background, FFileName);

  SetCaption;
end;

procedure TfrmMain.PlotGraphs;
var
  i: Integer;
begin
  SetLength(ResultSeries, High(Fit.Functions) + 1);

  for I := 0 to High(ResultSeries) do
  begin
    ResultSeries[i] := TLineSeries.Create(Chart);
    ResultSeries[i].Tag := 100 + i;
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

procedure TfrmMain.SetCaption;
begin
  Caption := 'XPS Peak Fit: ' + ExtractFileName(FFileName);
end;

procedure TfrmMain.actFitGaussExecute(Sender: TObject);
var
  Data, BG: TDataArray;

begin
  try
    Screen.Cursor := crHourGlass;
    ClearSeries;
    Data := SeriesToData(MainSeries);
    BG   := SeriesToData(Background);

    Fit.Process(Data, BG);
    PlotGraphs;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmMain.actResultExportClpbrdExecute(Sender: TObject);
var
  i, j: Integer;
  SL: TStringList;
  S: string;

  procedure AddToLine(Val: single; var S: string);
  begin
    if S = '' then
       S := FloatToStrF(Val, ffFixed, 5, 2
       )
    else
      S := S + chr(9) +  FloatToStrF(Val, ffFixed, 5, 2);
  end;

begin
  SL := TStringList.Create;
  try
    S := 'Binding energy' + chr(9) + 'Intensity' + chr(9) + 'Sum' + chr(9) + 'Background';
    for j := 0 to High(ResultSeries) do
      S := S + chr(9) + 'Peak ' + IntToStr(j+1);
    SL.Add(S);


    S := 'eV';
    for j := 0 to High(ResultSeries) + 3 do
      S := S + chr(9) + 'cps';
    SL.Add(S);

    S := ' '+ chr(9) + ' ' + chr(9) + ' '+ chr(9) + ' ';
    for j := 0 to High(ResultSeries) do
       S := S + chr(9) + FloatToStrF(Fit.Functions[j].xc.Last, ffFixed, 5, 2);
    SL.Add(S);


    for I := 0 to MainSeries.XValues.Count - 2 do
    begin
      S := '';
      AddToLine(MainSeries.XValue[i], S);
      AddToLine(MainSeries.YValue[i], S);
      AddToLine(SumSeries.YValue[i], S);
      AddToLine(Background.YValue[i], S);
      for j := 0 to High(ResultSeries) do
        AddToLine(ResultSeries[j].YValue[i], S);

      SL.Add(S);
    end;
    Clipboard.AsText := SL.Text;
  finally
    FreeAndNil(SL);
  end;
end;

procedure TfrmMain.actToolsShiftExecute(Sender: TObject);
var
  DX : single;
  i: integer;
  S : string;
begin
  S := InputBox('Fit shift','Input hte shifting value','');
  if S = '' then Exit;


  DX := StrToFloat(S);

  for I := 0 to MainSeries.XValues.Count - 2 do
  begin
    MainSeries.XValue[i] := MainSeries.XValue[i] + DX;
    Background.XValue[i] := Background.XValue[i] + DX;
  end;
end;

procedure TfrmMain.actWinFunctionsExecute(Sender: TObject);
begin
  frmEditorTest.WriteData(Fit.Functions);
  frmEditorTest.MainForm := Self.Handle;
  frmEditorTest.Show;
 end;

procedure TfrmMain.actWinShowLogExecute(Sender: TObject);
begin
  frmLog.Show;
end;

procedure TfrmMain.ChartClickSeries(Sender: TCustomChart; Series: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  yv: single;
  MaxY: single;
begin
  FSeriesSelected := True;
  if Series.Tag >= 100 then
    FSeriesIndex    := Series.Tag - 100;

  SeriesDragStartX := X;
  SeriesDragStartY := Y;

  yv := Series.YScreenToValue(Y);
  MaxY := Series.MaxYValue;

  if (MaxY > (0.7 * yv)) and (MaxY < (1.1 * yv)) then
    FPeakSelected := True
  else
    FPeakSelected := False;



end;

procedure TfrmMain.UpdateGraphs;
var
  Data, BG: TDataArray;
begin
   ClearSeries;
   Data := SeriesToData(MainSeries);
   BG   := SeriesToData(Background);
   Fit.NMax := 0;
   Fit.Process(Data, BG);
   PlotGraphs;
   Fit.NMax := 5000;
end;

procedure TfrmMain.ChartDblClick(Sender: TObject);

begin
  if frmEditorTest.Visible then
  begin
    frmEditorTest.AddFunction(FLastX, FLastY);
    Fit.Functions := frmEditorTest.GetData;
    UpdateGraphs;
  end;

end;

procedure TfrmMain.ChartMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  xv, yv: single;
  R: TRect;
  DX, DY: single;
begin

  xv := MainSeries.XScreenToValue(X);
  yv := MainSeries.YScreenToValue(Y);
  StatusX.Caption := FloatToStrF(xv, ffFixed, 6, 2);
  StatusY.Caption := FloatToStrF(yv, ffFixed, 6, 2);

  R := Chart.Legend.RectLegend;

  if (X > R.Left) and (X < R.Right) and (Y > R.Top) and (Y < R.Bottom) then
    Chart.Cursor := crArrow
  else
    Chart.Cursor := crCross;

  FLastX := xv;
  FLastY := yv;




  if FSeriesSelected then
  begin

    DX := MainSeries.XScreenToValue(X) - MainSeries.XScreenToValue(SeriesDragStartX);
    DY := MainSeries.YScreenToValue(Y) - MainSeries.YScreenToValue(SeriesDragStartY);

    if FPeakSelected then
    begin
       if Abs(DX) > abs(DY) then
         Fit.Functions[FSeriesIndex].xc.Last := Fit.Functions[FSeriesIndex].xc.Last + DX
       else
         Fit.Functions[FSeriesIndex].A.Last := Fit.Functions[FSeriesIndex].A.Last + DY
    end
    else
      Fit.Functions[FSeriesIndex].W.Last := Fit.Functions[FSeriesIndex].W.Last + DX;

    UpdateGraphs;
    SeriesDragStartX := X;
    SeriesDragStartY := Y;
  end;
end;

procedure TfrmMain.ChartMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if FSeriesSelected then
  begin
    FSeriesSelected := False;
    frmEditorTest.WriteData(Fit.Functions);
  end;
end;

procedure TfrmMain.ClearSeries;
var
  i: Integer;
begin
  SumSeries.Clear;
  for I := 0 to High(ResultSeries) do
    ResultSeries[i].Free;
  SetLength(ResultSeries, 0);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FFileName := 'NONAME';

  Fit := TFit.Create;

//  {$IFDEF  DEBUG}
//  if ParamCount = 1 then
//    SeriesFromFile(MainSeries, Background, ParamStr(1));
//  {$ENDIF}

  SetCaption;
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
