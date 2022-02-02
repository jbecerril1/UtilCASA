object FrmEdicionVer: TFrmEdicionVer
  Left = 0
  Top = 0
  Width = 417
  Height = 244
  TabOrder = 0
  OnEnter = FrameEnter
  OnExit = FrameExit
  object Splitter1: TSplitter
    Left = 200
    Top = 0
    Width = 2
    Height = 244
    ExplicitLeft = 185
    ExplicitTop = 15
    ExplicitHeight = 221
  end
  object Panel1: TPanel
    Left = 15
    Top = 0
    Width = 185
    Height = 244
    Align = alLeft
    BevelInner = bvLowered
    BorderWidth = 1
    Caption = 'Panel1'
    TabOrder = 0
    object gridDatos: TDBGrid
      Left = 3
      Top = 3
      Width = 179
      Height = 238
      Align = alClient
      BorderStyle = bsNone
      Color = clBtnFace
      DataSource = dsDatos
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgColumnResize, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      OnDblClick = gridDatosDblClick
      OnEnter = gridDatosEnter
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 15
    Height = 244
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object Lb_titulo: TGradient
      Left = 0
      Top = 0
      Width = 65
      Height = 244
      Align = alLeft
      Alignment = taCenter
      AutoSize = False
      Caption = 'Lb_titulo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = False
      ColorTo = clInactiveCaption
      EllipsType = etNone
      GradientType = gtFullVertical
      Indent = 0
      LineWidth = 2
      Orientation = goVertical
      TransparentText = False
      VAlignment = vaTop
      ExplicitLeft = -50
    end
  end
  object dsDatos: TDataSource
    Left = 256
    Top = 36
  end
end
