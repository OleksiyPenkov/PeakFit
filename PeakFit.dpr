program PeakFit;

uses
  Vcl.Forms,
  frm_main in 'forms\frm_main.pas' {frmMain},
  unit_GaussFit in 'units\unit_GaussFit.pas',
  unit_const in 'units\unit_const.pas',
  unit_utils in 'units\unit_utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
