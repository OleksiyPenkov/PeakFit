object frmEditorTest: TfrmEditorTest
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Fitting'
  ClientHeight = 514
  ClientWidth = 487
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
    Top = 474
    Width = 481
    Height = 37
    Align = alBottom
    BorderOuter = fsFlatRounded
    TabOrder = 0
    ExplicitWidth = 476
    object btnDemoData: TRzButton
      Left = 8
      Top = 8
      Caption = 'Demo'
      TabOrder = 0
      OnClick = btnDemoDataClick
    end
    object btnFit: TRzButton
      Left = 399
      Top = 6
      Caption = 'Fit!'
      TabOrder = 1
      OnClick = btnFitClick
    end
  end
  object rzpgcntrl1: TRzPageControl
    Left = 0
    Top = 0
    Width = 487
    Height = 471
    Hint = ''
    ActivePage = rztbshtTabSheet1
    Align = alClient
    TabIndex = 0
    TabOrder = 1
    ExplicitLeft = 96
    ExplicitTop = 24
    ExplicitWidth = 300
    ExplicitHeight = 150
    FixedDimension = 19
    object rztbshtTabSheet1: TRzTabSheet
      Caption = 'Functions'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object rzpnl1: TRzPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 477
        Height = 41
        Align = alTop
        BorderOuter = fsFlatRounded
        TabOrder = 0
        ExplicitLeft = 4
        ExplicitTop = 23
        object edtNPeaks: TRzSpinEdit
          Left = 426
          Top = 11
          Width = 47
          Height = 21
          Max = 100.000000000000000000
          TabOrder = 0
        end
        object cbbFunction: TComboBox
          Left = 8
          Top = 11
          Width = 145
          Height = 21
          TabOrder = 1
          Text = 'Gauss-Lorentz cross'
          Items.Strings = (
            'Gaussian'
            'Gauss-Lorentz Cross'
            'Assym 1'
            'Assym 2')
        end
      end
      object scrlPanel: TScrollBox
        Left = 0
        Top = 47
        Width = 483
        Height = 401
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 1
        ExplicitLeft = 1
        ExplicitTop = 188
        ExplicitWidth = 288
        ExplicitHeight = 260
      end
    end
    object rztbshtTabSheet2: TRzTabSheet
      Caption = 'Parameters'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
end