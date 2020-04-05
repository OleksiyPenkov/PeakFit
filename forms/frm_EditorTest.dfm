object frmEditorTest: TfrmEditorTest
  Left = 0
  Top = 0
  Caption = 'frmEditorTest'
  ClientHeight = 504
  ClientWidth = 455
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RzPanel1: TRzPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 449
    Height = 57
    Align = alTop
    BorderOuter = fsFlatRounded
    TabOrder = 0
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 455
    object btnDemoData: TRzButton
      Left = 16
      Top = 16
      Caption = 'Demo'
      TabOrder = 0
      OnClick = btnDemoDataClick
    end
    object btnFit: TRzButton
      Left = 352
      Top = 16
      ModalResult = 1
      Caption = 'Fit!'
      TabOrder = 1
    end
  end
end
