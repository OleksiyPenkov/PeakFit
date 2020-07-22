unit unit_FunctionEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, RzGrids, Vcl.ExtCtrls,
  RzPanel, RzCommon, RzRadChk, unit_const;

type

  TFunctionEditor = class(TRzPanel)
    private
      Grid: TRzStringGrid;
      CheckBox: TRzCheckbox;
    function GetData: TFitSet;
    procedure SetData(const Value: TFitSet);
    function GetChecked: boolean;
    published
      constructor Create(AOwner: TComponent); override;
      destructor Free;

      property Data:TFitSet read GetData write SetData;
      property Checked: boolean read GetChecked;
  end;

implementation

{ TFunctionEditor }

constructor TFunctionEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  //Grid
  Grid := TRzStringGrid.Create(Self);

  //rzpnlPanel1
  Parent := AOwner as TWinControl;
  AlignWithMargins := True;
  Height := 110;
  Align := alTop;
  BorderOuter := fsFlatRounded;
  TabOrder := 0;

  //Grid
  Grid.Name := 'Grid';
  Grid.Parent := Self;
  Grid.AlignWithMargins := True;
  Grid.Align := alClient;
  Grid.DefaultColWidth := 85;
  Grid.FixedColor := 16776176;
  Grid.Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing];
  Grid.TabOrder := 0;
  Grid.FrameVisible := True;
  Grid.Margins.Left  := 27;

  Grid.Cells[0, 1] := 'A';
  Grid.Cells[0, 2] := 'Xc';
  Grid.Cells[0, 3] := 'W';
  Grid.Cells[0, 4] := 'Shape';

  Grid.Cells[1, 0] := 'Value';
  Grid.Cells[2, 0] := 'min';
  Grid.Cells[3, 0] := 'max';

  CheckBox := TRzCheckbox.Create(Self);
  CheckBox.Parent := Self;
  CheckBox.Top := 50;
  CheckBox.Left := 5;
end;

destructor TFunctionEditor.Free;
begin
  FreeAndNil(Grid);
  FreeAndNil(CheckBox);
end;

function TFunctionEditor.GetChecked: boolean;
begin
  if Assigned(CheckBox) then
    Result := CheckBox.Checked;
end;

function TFunctionEditor.GetData: TFitSet;
begin
  Result.A.Last := StrToFloat(Grid.Cells[1, 1]);
  Result.A.min  := StrToFloat(Grid.Cells[2, 1]);
  Result.A.max  := StrToFloat(Grid.Cells[3, 1]);
  Result.A.RF  := 200;

  Result.Xc.Last := StrToFloat(Grid.Cells[1, 2]);
  Result.Xc.min  := StrToFloat(Grid.Cells[2, 2]);
  Result.Xc.max  := StrToFloat(Grid.Cells[3, 2]);
  Result.xc.RF  := 0.005;

  Result.W.Last := StrToFloat(Grid.Cells[1, 3]);
  Result.W.min  := StrToFloat(Grid.Cells[2, 3]);
  Result.W.max  := StrToFloat(Grid.Cells[3, 3]);
  Result.W.RF  := 0.05;

  Result.s.Last := StrToFloat(Grid.Cells[1, 4]);
  Result.s.min  := StrToFloat(Grid.Cells[2, 4]);
  Result.s.max  := StrToFloat(Grid.Cells[3, 4]);
  Result.s.RF  := 0.005;
end;

procedure TFunctionEditor.SetData(const Value: TFitSet);
begin
  Grid.Cells[1, 1] := FloatToStrF(Value.A.Last, ffFixed, 6, 3);
  Grid.Cells[2, 1] := FloatToStrF(Value.A.min, ffFixed, 6, 3);
  Grid.Cells[3, 1] := FloatToStrF(Value.A.max, ffFixed, 6, 3);

  Grid.Cells[1, 2] := FloatToStrF(Value.Xc.Last, ffFixed, 6, 3);
  Grid.Cells[2, 2] := FloatToStrF(Value.Xc.min, ffFixed, 6, 3);
  Grid.Cells[3, 2] := FloatToStrF(Value.Xc.max, ffFixed, 6, 3);

  Grid.Cells[1, 3] := FloatToStrF(Value.W.Last, ffFixed, 6, 3);
  Grid.Cells[2, 3] := FloatToStrF(Value.W.min, ffFixed, 6, 3);
  Grid.Cells[3, 3] := FloatToStrF(Value.W.max, ffFixed, 6, 3);

  Grid.Cells[1, 4] := FloatToStrF(Value.s.Last, ffFixed, 6, 3);
  Grid.Cells[2, 4] := FloatToStrF(Value.s.min, ffFixed, 6, 3);
  Grid.Cells[3, 4] := FloatToStrF(Value.s.max, ffFixed, 6, 3);
end;

end.
