program PeakFit;

uses
  Vcl.Forms,
  frm_main in 'forms\frm_main.pas' {frmMain},
  unit_GaussFit in 'units\unit_GaussFit.pas',
  unit_const in 'units\unit_const.pas',
  unit_utils in 'units\unit_utils.pas',
  frm_log in 'forms\frm_log.pas' {frmLog};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmLog, frmLog);
  Application.Run;
end.
