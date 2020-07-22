unit frm_EditorTest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, RzGrids, Vcl.ExtCtrls,
  RzPanel, unit_FunctionEditor, unit_const, RzButton, RzTabs, Vcl.StdCtrls,
  Vcl.Mask, RzEdit, RzSpnEdt;

type
  TfrmEditorTest = class(TForm)
    RzPanel1: TRzPanel;
    btnDemoData: TRzButton;
    btnFit: TRzButton;
    rzpgcntrl1: TRzPageControl;
    rztbshtTabSheet1: TRzTabSheet;
    rztbshtTabSheet2: TRzTabSheet;
    rzpnl1: TRzPanel;
    cbbFunction: TComboBox;
    scrlPanel: TScrollBox;
    btnAdd: TButton;
    procedure btnDemoDataClick(Sender: TObject);
    procedure btnFitClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
  private
    { Private declarations }
    Grids: array of TFunctionEditor;
    FFunctions: TFitSets;
    FMainForm: HWND;

    procedure  DeleteGrids;
    procedure FillTestData;
    procedure SetDefault(var F: TFitSet);
  public
    { Public declarations }
    procedure AddFunction(Pos: single);

    procedure WriteData(Functions: TFitSets; IsDemo: boolean = False);
    function GetData:TFitSets;
    property Functions:TFitSets read FFunctions write FFunctions;
    property MainForm:HWND write FMainForm;
  end;

var
  frmEditorTest: TfrmEditorTest;

implementation

uses
  unit_messages;

{$R *.dfm}

procedure TfrmEditorTest.AddFunction(Pos: single);
var
  N : integer;
begin
  N := Length(FFunctions) + 1;
  SetLength(FFunctions, N);

  SetDefault(FFunctions[N - 1]);
  FFunctions[N - 1].xc.Last := Pos;
  FFunctions[N - 1].xc.min := Pos - 0.25;
  FFunctions[N - 1].xc.max := Pos + 0.25;


  SetLength(Grids, N);

  Grids[N - 1] := TFunctionEditor.Create(scrlPanel);
  Grids[N - 1].Data := Functions[N - 1];end;

procedure TfrmEditorTest.btnDemoDataClick(Sender: TObject);
begin
  FillTestData;
  WriteData(Functions, True);
end;

procedure TfrmEditorTest.btnFitClick(Sender: TObject);
begin
  PostMessage(FMainForm, WM_RECALC, 0, 0);
end;

procedure TfrmEditorTest.btnAddClick(Sender: TObject);
var
  N : integer;
begin
  N := Length(FFunctions) + 1;
  SetLength(FFunctions, N);

  SetDefault(FFunctions[N-1]);

  SetLength(Grids, N);

  Grids[N - 1] := TFunctionEditor.Create(scrlPanel);
  Grids[N - 1].Data := Functions[N - 1];
end;

procedure TfrmEditorTest.DeleteGrids;
var
  i: integer;
begin
  for i := 0 to High(Grids) do
    FreeAndNil(Grids[i]);

  SetLength(Grids, 0);
end;

procedure TfrmEditorTest.FillTestData;
const
  peaks: array [0 .. 4] of single = (227.7, 228.1, 230.8, 231.2, 233);
var
  i: Integer;
begin
  SetLength(FFunctions, 0);
  SetLength(FFunctions, Length(peaks));

  for i := Low(FFunctions) to High(FFunctions) do
  begin
    FFunctions[i].xc.Last  := peaks[i];
    FFunctions[i].xc.min := peaks[i] - 0.25;
    FFunctions[i].xc.max := peaks[i] + 0.25;
    SetDefault(FFunctions[i]);
  end;
end;

function TfrmEditorTest.GetData: TFitSets;
var
  i : Integer;
begin
  SetLength(Result, Length(Grids));
  for I := 0 to High(Grids) do
    Result[i] := Grids[i].Data;
end;

procedure TfrmEditorTest.SetDefault(var F: TFitSet);
begin
    F.xc.RF  := 0.005;

    F.A.Last  := 2000;
    F.A.Max := 4000;
    F.A.min := 50;
    F.A.RF  := 200;

    F.W.Last  := 0.1;
    F.W.min := 0.3;
    F.W.Max := 0.9;
    F.W.RF  := 0.05;

    F.s.Last  := 0.8;
    F.s.min := 0.5;
    F.s.Max := 1;
    F.s.RF  := 0.005;
end;

procedure TfrmEditorTest.WriteData;
var
  i: Integer;
begin
  if (Length(Grids) <> 0) then DeleteGrids;


  SetLength(Grids, High(Functions) + 1);

  for i := High(Grids) downto 0 do
  begin
    Grids[i] := TFunctionEditor.Create(scrlPanel);
    Grids[i].Data := Functions[i];
  end;
end;

end.
