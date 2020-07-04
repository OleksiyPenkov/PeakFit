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
  WindowState = wsMaximized
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
    Color = 15987699
    TabOrder = 0
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
    Height = 44
    Images = ImageList32
    RowHeight = 40
    ButtonLayout = blGlyphTop
    ButtonWidth = 60
    ButtonHeight = 40
    ShowButtonCaptions = True
    TextOptions = ttoShowTextLabels
    BorderInner = fsNone
    BorderOuter = fsGroove
    BorderSides = [sdTop]
    BorderWidth = 0
    Color = 15987699
    TabOrder = 1
    ToolbarControls = (
      btnBtnOpen
      btnBtnSave
      btnImport
      btnFit
      btnFunctionsWindow)
    object btnBtnOpen: TRzToolButton
      Left = 4
      Top = 2
      DisabledIndex = 1
      Layout = blGlyphTop
      Action = actFileOpen
    end
    object btnBtnSave: TRzToolButton
      Left = 64
      Top = 2
      DisabledIndex = 3
      Layout = blGlyphTop
      Action = actFileSave
    end
    object btnImport: TRzToolButton
      Left = 124
      Top = 2
      DisabledIndex = 5
      Layout = blGlyphTop
      Action = actDataImport
      Caption = 'Import'
    end
    object btnFit: TRzToolButton
      Left = 184
      Top = 2
      DisabledIndex = 7
      Layout = blGlyphTop
      Action = actFitGauss
    end
    object btnFunctionsWindow: TRzToolButton
      Left = 244
      Top = 2
      DisabledIndex = 9
      Layout = blGlyphTop
      Action = actWinFunctions
      Caption = 'Functions'
    end
  end
  object Chart: TChart
    Left = 0
    Top = 44
    Width = 1009
    Height = 689
    Legend.Visible = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    View3D = False
    Align = alClient
    TabOrder = 2
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object MainSeries: TLineSeries
      ColorEachLine = False
      SeriesColor = 8404992
      Brush.BackColor = clDefault
      DrawStyle = dsAll
      LinePen.Width = 10
      OutLine.Width = 0
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
      Transparency = 49
    end
    object SumSeries: TLineSeries
      SeriesColor = clRed
      Brush.BackColor = clDefault
      LinePen.Width = 4
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Background: TLineSeries
      SeriesColor = 2971904
      Brush.BackColor = clDefault
      LinePen.Width = 5
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
      object Params1: TMenuItem
        Action = actWinFunctions
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
    end
  end
  object ImageList32: TImageList
    Left = 360
    Top = 152
    Bitmap = {
      494C01010A001800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      00000000000000000000000000000000000000000000CC666600CC666600CC66
      6600CC666600CC666600CC666600CC666600CC666600CC666600CC666600CC66
      6600CC666600CC666600CC666600CC6666000000000099999900999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900999999009999990099999900999999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFCCCC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CC6666000000000099999900000000000000
      000000000000000000000000000000000000CCCCCC0000000000000000000000
      0000000000000000000000000000999999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFCCCC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000009900FFFFFF00CC6666000000000099999900000000000000
      000000000000000000000000000000000000CCCCCC0000000000000000000000
      0000000000009999990000000000999999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFCCCC00FFCCCC00FFCCCC00FFCC
      CC00FFCCCC00FFCCCC00FFCCCC00CC6666000000000099999900000000000000
      000000000000000000000000000000000000CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00999999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFCCCC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CC6666000000000099999900000000000000
      000000000000000000000000000000000000CCCCCC0000000000000000000000
      0000000000000000000000000000999999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000009900FFFFFF00FFCCCC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000009900FFFFFF00CC6666000000000099999900000000000000
      000000000000000000009999990000000000CCCCCC0000000000000000000000
      0000000000009999990000000000999999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC666600FFCCCC00FFCC
      CC00FFCCCC00FFCCCC00FFCCCC00FFCCCC00FFCCCC00FFCCCC00FFCCCC00FFCC
      CC00FFCCCC00FFCCCC00FFCCCC00CC6666000000000099999900CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00999999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFCCCC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CC6666000000000099999900000000000000
      000000000000000000000000000000000000CCCCCC0000000000000000000000
      0000000000000000000000000000999999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFCCCC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CC6666000000000099999900000000000000
      000000000000000000000000000000000000CCCCCC0000000000000000000000
      0000000000000000000000000000999999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000009900FFFFFF00FFCCCC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000009900FFFFFF00CC6666000000000099999900000000000000
      000000000000000000009999990000000000CCCCCC0000000000000000000000
      0000000000009999990000000000999999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC666600FFCCCC00FFCC
      CC00FFCCCC00FFCCCC00FFCCCC00FFCCCC00FFCCCC00FFCCCC00FFCCCC00FFCC
      CC00FFCCCC00FFCCCC00FFCCCC00CC6666000000000099999900CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00999999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFCCCC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CC6666000000000099999900000000000000
      000000000000000000000000000000000000CCCCCC0000000000000000000000
      0000000000000000000000000000999999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFCCCC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CC6666000000000099999900000000000000
      000000000000000000000000000000000000CCCCCC0000000000000000000000
      0000000000000000000000000000999999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFCCCC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CC6666000000000099999900000000000000
      000000000000000000000000000000000000CCCCCC0000000000000000000000
      0000000000000000000000000000999999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC666600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000009900FFFFFF00FFCCCC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000009900FFFFFF00CC6666000000000099999900000000000000
      000000000000000000009999990000000000CCCCCC0000000000000000000000
      0000000000009999990000000000999999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC666600CC666600CC66
      6600CC666600CC666600CC666600CC666600CC666600CC666600CC666600CC66
      6600CC666600CC666600CC666600CC6666000000000099999900999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900999999009999990099999900999999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003399CC000066
      9900006699000066990000669900006699000066990000669900006699000066
      9900006699000066990000000000000000000000000000000000999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900999999009999990000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003399CC0066CCFF003399
      CC0099FFFF0066CCFF0066CCFF0066CCFF0066CCFF0066CCFF0066CCFF0066CC
      FF003399CC0099FFFF0000669900000000000000000099999900CCCCCC009999
      9900E5E5E500CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC0099999900E5E5E50099999900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003399CC0066CCFF003399
      CC0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FF
      FF0066CCFF0099FFFF0000669900000000000000000099999900CCCCCC009999
      9900E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5
      E500CCCCCC00E5E5E50099999900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003399CC0066CCFF003399
      CC0099FFFF0099FFFF00006600003399660099FFFF0099FFFF0099FFFF0099FF
      FF0066CCFF0099FFFF0000669900000000000000000099999900CCCCCC009999
      9900E5E5E500E5E5E50099999900CCCCCC00E5E5E500E5E5E500E5E5E500E5E5
      E500CCCCCC00E5E5E50099999900000000000000000000000000000000000000
      0000000000009933000099330000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009999990099999900000000000000000000000000000000000000
      000000000000000000000000000000000000000000003399CC0066CCFF003399
      CC0099FFFF0099FFFF0033999900339933003399330099FFFF0099FFFF0099FF
      FF0066CCFF0099FFFF0000669900000000000000000099999900CCCCCC009999
      9900E5E5E500E5E5E500CCCCCC009999990099999900E5E5E500E5E5E500E5E5
      E500CCCCCC00E5E5E50099999900000000000000000000000000000000000000
      00000000000099330000CC660000993300000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00999999000000000000000000000000000000
      000000000000000000000000000000000000000000003399CC0066CCFF003399
      CC0099FFFF0099FFFF0099FFCC003399330033CC66003399660099FFFF0099FF
      FF0066CCFF0099FFFF0000669900000000000000000099999900CCCCCC009999
      9900E5E5E500E5E5E500E5E5E50099999900E5E5E500CCCCCC00E5E5E500E5E5
      E500CCCCCC00E5E5E50099999900000000000000000000000000000000000000
      00000000000099330000CC660000CC6600009933000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC009999990000000000000000000000
      000000000000000000000000000000000000000000003399CC0066CCFF003399
      CC0099FFFF0099FFFF0099FFFF000099330066FF99003399330099FFCC0099FF
      FF0066CCFF0099FFFF0000669900000000000000000099999900CCCCCC009999
      9900E5E5E500E5E5E500E5E5E50099999900E5E5E50099999900E5E5E500E5E5
      E500CCCCCC00E5E5E50099999900000000000000000000000000000000000000
      00000000000099330000CC660000CC660000CC66000099330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC00CCCCCC0099999900000000000000
      000000000000000000000000000000000000000000003399CC0099FFFF0099FF
      FF003399CC003399CC003399CC000066330033CC660033CC6600339966003399
      CC003399CC003399CC003399CC00000000000000000099999900E5E5E500E5E5
      E50099999900999999009999990099999900E5E5E500E5E5E500CCCCCC009999
      9900999999009999990099999900000000000000000000000000000000000000
      00000000000099330000CC660000CC660000CC660000CC660000993300000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC00CCCCCC00CCCCCC00999999000000
      000000000000000000000000000000000000000000003399CC0099FFFF0099FF
      FF0099FFFF0099FFFF0099FFFF000080000033CC660033CC66003399330099FF
      FF00006699000000000000000000000000000000000099999900E5E5E500E5E5
      E500E5E5E500E5E5E500E5E5E50099999900E5E5E500E5E5E50099999900E5E5
      E500999999000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC660000CC660000CC660000CC6600009933
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC009999
      99000000000000000000000000000000000000000000000000003399CC0099FF
      FF0099FFFF0099FFFF0099FFFF000080000033CC660033CC6600339933003399
      CC0000000000000000000000000000000000000000000000000099999900E5E5
      E500E5E5E500E5E5E500E5E5E50099999900E5E5E500E5E5E500999999009999
      9900000000000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC660000CC660000CC660000993300000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC00CCCCCC00CCCCCC00999999000000
      0000000000000000000000000000000000000000000000000000000000003399
      CC003399CC003399CC003399CC000099330033CC660033CC6600339933000000
      0000000000000000000000000000000000000000000000000000000000009999
      990099999900999999009999990099999900E5E5E500E5E5E500999999000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC660000CC66000099330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC00CCCCCC0099999900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000066000000800000008000003399330033CC660033CC6600336633000080
      0000008000000000000000000000000000000000000000000000000000000000
      000099999900999999009999990099999900E5E5E500E5E5E500999999009999
      9900999999000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000CC6600009933000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00CCCCCC009999990000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000669966000080000033CC330033CC330033CC660033CC6600339933000066
      0000669966000000000000000000000000000000000000000000000000000000
      0000CCCCCC0099999900E5E5E500E5E5E500E5E5E500E5E5E500999999009999
      9900CCCCCC000000000000000000000000000000000000000000000000000000
      00000000000099330000CC660000993300000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900CCCCCC00999999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000336633000099330033CC330033CC33000099330033663300C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000009999990099999900E5E5E500E5E5E5009999990099999900C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000009933000099330000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009999990099999900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099CC990000800000009900000080000066999900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E5E5E500999999009999990099999900CCCCCC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000006699660033993300CCCCCC0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CCCCCC0099999900CCCCCC0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000993300009933
      0000993300009933000099330000993300009933000099330000993300009933
      0000993300009933000099330000000000000000000000000000999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      990099999900999999009999990000000000000000003399CC00006699000066
      9900006699000066990000669900006699000066990000669900006699000066
      990066CCCC000000000000000000000000000000000099999900999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900CCCCCC000000000000000000000000000000000099330000CC660000CC66
      000099330000E5E5E500CC66000099330000E5E5E500E5E5E500E5E5E5009933
      0000CC660000CC66000099330000000000000000000099999900CCCCCC00CCCC
      CC0099999900E5E5E500CCCCCC0099999900E5E5E500E5E5E500E5E5E5009999
      9900CCCCCC00CCCCCC0099999900000000003399CC003399CC0099FFFF0066CC
      FF0066CCFF0066CCFF0066CCFF0066CCFF0066CCFF0066CCFF0066CCFF003399
      CC00006699000000000000000000000000009999990099999900E5E5E500CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC009999
      9900999999000000000000000000000000000000000099330000CC660000CC66
      000099330000E5E5E500CC66000099330000E5E5E500E5E5E500E5E5E5009933
      0000CC660000CC66000099330000000000000000000099999900CCCCCC00CCCC
      CC0099999900E5E5E500CCCCCC0099999900E5E5E500E5E5E500E5E5E5009999
      9900CCCCCC00CCCCCC0099999900000000003399CC003399CC0066CCFF0099FF
      FF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0066CC
      FF00006699003399CC0000000000000000009999990099999900CCCCCC00E5E5
      E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500CCCC
      CC00999999009999990000000000000000000000000099330000CC660000CC66
      000099330000E5E5E500CC66000099330000E5E5E500E5E5E500E5E5E5009933
      0000CC660000CC66000099330000000000000000000099999900CCCCCC00CCCC
      CC0099999900E5E5E500CCCCCC0099999900E5E5E500E5E5E500E5E5E5009999
      9900CCCCCC00CCCCCC0099999900000000003399CC003399CC0066CCFF0099FF
      FF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0066CC
      FF0066CCCC000066990000000000000000009999990099999900CCCCCC00E5E5
      E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500CCCC
      CC00CCCCCC009999990000000000000000000000000099330000CC660000CC66
      000099330000E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E5009933
      0000CC660000CC66000099330000000000000000000099999900CCCCCC00CCCC
      CC0099999900E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E5009999
      9900CCCCCC00CCCCCC0099999900000000003399CC0066CCFF003399CC0099FF
      FF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0066CC
      FF0099FFFF00006699003399CC000000000099999900CCCCCC0099999900E5E5
      E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500CCCC
      CC00E5E5E5009999990099999900000000000000000099330000CC660000CC66
      0000CC660000993300009933000099330000993300009933000099330000CC66
      0000CC660000CC66000099330000000000000000000099999900CCCCCC00CCCC
      CC00CCCCCC00999999009999990099999900999999009999990099999900CCCC
      CC00CCCCCC00CCCCCC0099999900000000003399CC0066CCFF0066CCCC0066CC
      CC0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0066CC
      FF0099FFFF0066CCCC00006699000000000099999900CCCCCC00CCCCCC00CCCC
      CC00E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500CCCC
      CC00E5E5E500CCCCCC0099999900000000000000000099330000CC660000CC66
      0000CC660000CC660000CC660000CC660000CC660000CC660000CC660000CC66
      0000CC660000CC66000099330000000000000000000099999900CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC0099999900000000003399CC0099FFFF0066CCFF003399
      CC00CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFFFF0099FF
      FF00CCFFFF00CCFFFF00006699000000000099999900E5E5E500CCCCCC009999
      9900E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5
      E500E5E5E500E5E5E50099999900000000000000000099330000CC660000CC66
      0000993300009933000099330000993300009933000099330000993300009933
      0000CC660000CC66000099330000000000000000000099999900CCCCCC00CCCC
      CC00999999009999990099999900999999009999990099999900999999009999
      9900CCCCCC00CCCCCC0099999900000000003399CC0099FFFF0099FFFF0066CC
      FF003399CC003399CC003399CC003399CC003399CC003399CC003399CC003399
      CC003399CC003399CC0066CCFF000000000099999900E5E5E500E5E5E500CCCC
      CC00999999009999990099999900999999009999990099999900999999009999
      99009999990099999900CCCCCC00000000000000000099330000CC6600009933
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0099330000CC66000099330000000000000000000099999900CCCCCC009999
      9900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0099999900CCCCCC0099999900000000003399CC00CCFFFF0099FFFF0099FF
      FF0099FFFF0099FFFF00CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFFFF000066
      99000000000000000000000000000000000099999900E5E5E500E5E5E500E5E5
      E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E5009999
      9900000000000000000000000000000000000000000099330000CC6600009933
      0000FFFFFF00993300009933000099330000993300009933000099330000FFFF
      FF0099330000CC66000099330000000000000000000099999900CCCCCC009999
      9900FFFFFF00999999009999990099999900999999009999990099999900FFFF
      FF0099999900CCCCCC009999990000000000000000003399CC00CCFFFF00CCFF
      FF00CCFFFF00CCFFFF003399CC003399CC003399CC003399CC003399CC000000
      0000000000000000000000000000000000000000000099999900E5E5E500E5E5
      E500E5E5E500E5E5E50099999900999999009999990099999900999999000000
      0000000000000000000000000000000000000000000099330000CC6600009933
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0099330000CC66000099330000000000000000000099999900CCCCCC009999
      9900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0099999900CCCCCC00999999000000000000000000000000003399CC003399
      CC003399CC003399CC0000000000000000000000000000000000000000000000
      0000000000009933000099330000993300000000000000000000999999009999
      9900999999009999990000000000000000000000000000000000000000000000
      0000000000009999990099999900999999000000000099330000E5E5E5009933
      0000FFFFFF00993300009933000099330000993300009933000099330000FFFF
      FF00993300009933000099330000000000000000000099999900E5E5E5009999
      9900FFFFFF00999999009999990099999900999999009999990099999900FFFF
      FF00999999009999990099999900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000099330000993300000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000099999900999999000000000099330000CC6600009933
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0099330000CC66000099330000000000000000000099999900CCCCCC009999
      9900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0099999900CCCCCC0099999900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099330000000000000000
      0000000000009933000000000000993300000000000000000000000000000000
      0000000000000000000000000000000000000000000099999900000000000000
      0000000000009999990000000000999999000000000099330000993300009933
      0000993300009933000099330000993300009933000099330000993300009933
      0000993300009933000099330000000000000000000099999900999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900999999009999990099999900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000993300009933
      0000993300000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000999999009999
      9900999999000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0080008000000000008000BF7E00000000
      8000BF7A000000008000BF00000000008000BF7E000000008000BD7A00000000
      80008000000000008000BF7E000000008000BF7E000000008000BD7A00000000
      80008000000000008000BF7E000000008000BF7E000000008000BF7E00000000
      8000BD7A000000008000800000000000C003C003FFFFFFFF80018001FFFFFFFF
      80018001FFFFFFFF80018001F9FFF9FF80018001F8FFF8FF80018001F87FF87F
      80018001F83FF83F80018001F81FF81F80078007F80FF80FC00FC00FF81FF81F
      E01FE01FF83FF83FF007F007F87FF87FF007F007F8FFF8FFF80FF80FF9FFF9FF
      F83FF83FFFFFFFFFFC7FFC7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC001C001
      8007800780018001000700078001800100030003800180010003000380018001
      0001000180018001000100018001800100010001800180010001000180018001
      000F000F80018001801F801F80018001C3F8C3F880018001FFFCFFFC80018001
      FFBAFFBA80018001FFC7FFC7FFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object Actions: TActionList
    Images = ImageList32
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
      ImageIndex = 4
      OnExecute = actDataImportExecute
    end
    object actFitGauss: TAction
      Category = 'File'
      Caption = 'Fit Gauss'
      ImageIndex = 6
      ShortCut = 116
      OnExecute = actFitGaussExecute
    end
    object actWinShowLog: TAction
      Category = 'Window'
      Caption = 'Show Log'
      OnExecute = actWinShowLogExecute
    end
    object actWinFunctions: TAction
      Category = 'Window'
      Caption = 'Params'
      ImageIndex = 8
      OnExecute = actWinFunctionsExecute
    end
    object actFileSave: TAction
      Category = 'File'
      Caption = 'Save'
      ImageIndex = 2
      OnExecute = actFileSaveExecute
    end
    object actFileOpen: TAction
      Category = 'File'
      Caption = 'Open'
      ImageIndex = 0
      OnExecute = actFileOpenExecute
    end
  end
  object dlgImportData: TOpenDialog
    DefaultExt = '*.dat'
    Left = 544
    Top = 117
  end
  object dlgSave: TSaveDialog
    DefaultExt = '.fit'
    Filter = 'Fit projects|*.fit'
    Left = 544
    Top = 212
  end
  object dlgOpen: TOpenDialog
    Left = 384
    Top = 252
  end
end
