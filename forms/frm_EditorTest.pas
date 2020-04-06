unit frm_EditorTest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, RzGrids, Vcl.ExtCtrls,
  RzPanel, unit_FunctionEditor, unit_const, RzButton;

type
  TfrmEditorTest = class(TForm)
    RzPanel1: TRzPanel;
    btnDemoData: TRzButton;
    btnFit: TRzButton;
    procedure btnDemoDataClick(Sender: TObject);
  private
    { Private declarations }
    Grids: array of TFunctionEditor;
    FFunctions: TFitSets;

    procedure  DeleteGrids;
    procedure FillTestData;
  public
    { Public declarations }
    procedure WriteData(Functions: TFitSets; IsDemo: boolean = False);
    function GetData:TFitSets;
    property Functions:TFitSets read FFunctions write FFunctions;
  end;

var
  frmEditorTest: TfrmEditorTest;

implementation

{$R *.dfm}

procedure TfrmEditorTest.btnDemoDataClick(Sender: TObject);
begin
  FillTestData;
  WriteData(Functions, True);
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
  peaks: array [0 .. 2] of single = (227, 230.86, 233);
var
  i: Integer;
begin
  SetLength(FFunctions, 0);
  SetLength(FFunctions, Npeaks);

  for i := Low(FFunctions) to High(FFunctions) do
  begin
    FFunctions[i].xc.Last  := peaks[i];
    FFunctions[i].xc.min := peaks[i] - 1;
    FFunctions[i].xc.max := peaks[i] + 1;
    FFunctions[i].xc.RF  := 0.005;

    FFunctions[i].A.Last  := 2000;
    FFunctions[i].A.Max := 4000;
    FFunctions[i].A.min := 50;
    FFunctions[i].A.RF  := 200;

    FFunctions[i].W.Last  := 0.1;
    FFunctions[i].W.min := 0.1;
    FFunctions[i].W.Max := 3;
    FFunctions[i].W.RF  := 0.05;

    FFunctions[i].s.Last  := 0.8;
    FFunctions[i].s.min := 0.5;
    FFunctions[i].s.Max := 1;
    FFunctions[i].s.RF  := 0.005;
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

procedure TfrmEditorTest.WriteData;
var
  i: Integer;
begin
  if (Length(Grids) <> 0) then DeleteGrids;


  SetLength(Grids, High(Functions) + 1);

  for i := High(Grids) downto 0 do
  begin
    Grids[i] := TFunctionEditor.Create(self);
    Grids[i].Data := Functions[i];
  end;

end;

end.
