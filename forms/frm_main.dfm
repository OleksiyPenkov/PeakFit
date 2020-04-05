object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Peak Fit'
  ClientHeight = 752
  ClientWidth = 1009
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TRzStatusBar
    Left = 0
    Top = 733
    Width = 1009
    Height = 19
    BorderInner = fsNone
    BorderOuter = fsNone
    BorderSides = [sdLeft, sdTop, sdRight, sdBottom]
    BorderWidth = 0
    TabOrder = 0
    ExplicitTop = 553
    ExplicitWidth = 851
    object pnlChi: TRzStatusPane
      Left = 0
      Top = 0
      Height = 19
      Align = alLeft
      Caption = ''
      ExplicitLeft = 851
      ExplicitHeight = 20
    end
  end
  object MainToolBar: TRzToolbar
    Left = 0
    Top = 0
    Width = 1009
    Height = 29
    Images = ImageList32
    BorderInner = fsNone
    BorderOuter = fsGroove
    BorderSides = [sdTop]
    BorderWidth = 0
    TabOrder = 1
    ExplicitWidth = 851
  end
  object Chart: TChart
    Left = 0
    Top = 29
    Width = 1009
    Height = 704
    Legend.Visible = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    View3D = False
    Align = alClient
    TabOrder = 2
    ExplicitWidth = 851
    ExplicitHeight = 524
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object MainSeries: TLineSeries
      SeriesColor = clRed
      Brush.BackColor = clDefault
      LinePen.Width = 2
      OutLine.Width = 0
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object SumSeries: TLineSeries
      SeriesColor = 12615680
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object MainMenu: TMainMenu
    Left = 288
    Top = 152
    object File1: TMenuItem
      Caption = 'File'
      object Open1: TMenuItem
        Caption = 'Open'
      end
      object Save1: TMenuItem
        Caption = 'Save'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Print1: TMenuItem
        Caption = 'Print ...'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Action = actFileExit
      end
    end
    object Edit1: TMenuItem
      Caption = 'Edit'
      object Preferences1: TMenuItem
        Caption = 'Preferences'
      end
    end
    object Data1: TMenuItem
      Caption = 'Data'
      object Importformfile1: TMenuItem
        Action = actDataImport
      end
    end
    object Fit1: TMenuItem
      Caption = 'Fit'
      object Gauss1: TMenuItem
        Action = actFitGauss
      end
    end
    object Window1: TMenuItem
      Caption = 'Window'
      object ShowLog1: TMenuItem
        Action = actWinShowLog
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
    end
  end
  object ImageList32: TImageList
    Left = 360
    Top = 152
  end
  object Actions: TActionList
    Left = 416
    Top = 117
    object actFileExit: TAction
      Category = 'File'
      Caption = 'Exit'
      OnExecute = actFileExitExecute
    end
    object actDataImport: TAction
      Category = 'File'
      Caption = 'Import form file'
      OnExecute = actDataImportExecute
    end
    object actFitGauss: TAction
      Category = 'File'
      Caption = 'Fit Gauss'
      ShortCut = 116
      OnExecute = actFitGaussExecute
    end
    object actWinShowLog: TAction
      Category = 'Window'
      Caption = 'Show Log'
      OnExecute = actWinShowLogExecute
    end
  end
  object dlgImportData: TOpenDialog
    DefaultExt = '*.dat'
    Left = 544
    Top = 117
  end
end
