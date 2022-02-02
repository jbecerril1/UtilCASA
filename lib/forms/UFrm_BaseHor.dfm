object FrmEdicionHor: TFrmEdicionHor
  Left = 0
  Top = 0
  Width = 417
  Height = 189
  TabOrder = 0
  OnEnter = FrameEnter
  OnExit = FrameExit
  PixelsPerInch = 96
  object Splitter1: TSplitter
    Left = 0
    Top = 0
    Width = 417
    Height = 2
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 53
  end
  object Panel3: TPanel
    Left = 18
    Top = 2
    Width = 399
    Height = 187
    Align = alClient
    TabOrder = 0
    object Panel1: TPanel
      Left = 1
      Top = 42
      Width = 397
      Height = 144
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 1
      TabOrder = 1
      object gridDatos: TDBGrid
        Left = 1
        Top = 1
        Width = 395
        Height = 142
        Align = alClient
        BorderStyle = bsNone
        Color = clBtnFace
        DataSource = dsDatos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
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
      Left = 1
      Top = 1
      Width = 397
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      OnClick = FrameEnter
      object Bevel1: TBevel
        Left = 0
        Top = 38
        Width = 397
        Height = 3
        Align = alBottom
        Style = bsRaised
        ExplicitTop = 50
        ExplicitWidth = 417
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 2
    Width = 18
    Height = 187
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object Lb_titulo: TGradient
      Left = 0
      Top = 0
      Width = 65
      Height = 187
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
      ExplicitLeft = -24
      ExplicitTop = 88
      ExplicitHeight = 17
    end
  end
  object dsDatos: TDataSource
    Left = 132
    Top = 76
  end
end
