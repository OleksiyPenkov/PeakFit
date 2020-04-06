program PeakFit;

uses
  Vcl.Forms,
  frm_main in 'forms\frm_main.pas' {frmMain},
  unit_GaussFit in 'units\unit_GaussFit.pas',
  unit_const in 'units\unit_const.pas',
  unit_utils in 'units\unit_utils.pas',
  frm_log in 'forms\frm_log.pas' {frmLog},
  unit_FunctionEditor in 'components\unit_FunctionEditor.pas',
  frm_EditorTest in 'forms\frm_EditorTest.pas' {frmEditorTest},
  unit_messages in 'units\unit_messages.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmLog, frmLog);
  Application.CreateForm(TfrmEditorTest, frmEditorTest);
  Application.Run;
end.
