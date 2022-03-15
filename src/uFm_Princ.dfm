object Fm_Princ: TFm_Princ
  Left = 0
  Top = 0
  Caption = 'Fm_Princ'
  ClientHeight = 919
  ClientWidth = 1237
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = mm1
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object spl1: TSplitter
    Left = 217
    Top = 54
    Height = 846
    ExplicitLeft = 408
    ExplicitTop = 232
    ExplicitHeight = 100
  end
  object stat1: TStatusBar
    Left = 0
    Top = 900
    Width = 1237
    Height = 19
    Panels = <>
  end
  object tlb1: TToolBar
    Left = 0
    Top = 0
    Width = 1237
    Height = 54
    ButtonHeight = 54
    ButtonWidth = 95
    Caption = 'tlb1'
    Images = Dm_Princ.imgl_32
    ShowCaptions = True
    TabOrder = 1
    object btnNvoFolder: TToolButton
      Left = 0
      Top = 0
      Action = Dm_Princ.act_NvoFolder
    end
    object btnNuevaConexion: TToolButton
      Left = 95
      Top = 0
      Action = Dm_Princ.act_NuevaConexion
    end
  end
  object pnl_db: TPanel
    Left = 0
    Top = 54
    Width = 217
    Height = 846
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
    object spl2: TSplitter
      Left = 0
      Top = 650
      Width = 217
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 0
      ExplicitWidth = 262
    end
    object tv1: TTreeView
      Left = 0
      Top = 0
      Width = 217
      Height = 650
      Align = alClient
      AutoExpand = True
      ChangeDelay = 15
      Images = Dm_Princ.imgl_16
      Indent = 20
      PopupMenu = pm_db
      ReadOnly = True
      TabOrder = 0
      OnClick = tv1Click
    end
    object pgc_Det: TPageControl
      Left = 0
      Top = 653
      Width = 217
      Height = 193
      ActivePage = ts_propiedades
      Align = alBottom
      TabOrder = 1
      object ts_propiedades: TTabSheet
        Caption = 'Propiedades'
        object lv_campos: TListView
          Left = 0
          Top = 0
          Width = 209
          Height = 163
          Align = alClient
          Columns = <
            item
              Caption = '#'
            end
            item
              Caption = 'Campos'
            end>
          TabOrder = 0
          ViewStyle = vsReport
        end
      end
      object ts_2: TTabSheet
        Caption = 'ts_2'
        ImageIndex = 1
      end
    end
  end
  object pnl_Cnt: TPanel
    Left = 220
    Top = 54
    Width = 1017
    Height = 846
    Align = alClient
    TabOrder = 3
    object DockTabSet1: TDockTabSet
      Left = 1
      Top = 1
      Width = 1015
      Height = 21
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      SoftTop = True
      Style = tsModernTabs
      DestinationDockSite = pnl_Dock
    end
    object pnl_Dock: TPanel
      Left = 1
      Top = 22
      Width = 1015
      Height = 823
      Align = alClient
      DockSite = True
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 1
      object mmo_1: TMemo
        Left = 1
        Top = 1
        Width = 1013
        Height = 821
        Align = alClient
        Lines.Strings = (
          'mmo_1')
        TabOrder = 0
      end
    end
  end
  object mm1: TMainMenu
    Images = Dm_Princ.imgl_16
    Left = 400
    Top = 96
    object BasedeDatos1: TMenuItem
      Caption = 'Base de Datos'
      object NuevaConexin1: TMenuItem
        Action = Dm_Princ.act_NuevaConexion
      end
    end
  end
  object pm_db: TPopupMenu
    Images = Dm_Princ.imgl_16
    OnPopup = pm_dbPopup
    Left = 392
    Top = 264
    object NuevaCarpeta1: TMenuItem
      Action = Dm_Princ.act_NvoFolder
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object NuevaConexin2: TMenuItem
      Action = Dm_Princ.act_NuevaConexion
    end
  end
end
