object Form_Main: TForm_Main
  Left = 0
  Top = 0
  Caption = ':::: Shutter Test Program ::::'
  ClientHeight = 562
  ClientWidth = 798
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 10
  Padding.Top = 10
  Padding.Right = 10
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel_Bottom: TPanel
    Left = 10
    Top = 499
    Width = 778
    Height = 63
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      778
      63)
    object Label_Monitoring: TAdvSmoothLabel
      Left = 576
      Top = 6
      Width = 188
      Height = 50
      Fill.ColorMirror = clNone
      Fill.ColorMirrorTo = clNone
      Fill.Rounding = 0
      Fill.ShadowOffset = 0
      Caption.Text = 'Monitoring...'
      Caption.Font.Charset = ANSI_CHARSET
      Caption.Font.Color = clWindowText
      Caption.Font.Height = -27
      Caption.Font.Name = 'Microsoft Sans Serif'
      Caption.Font.Style = [fsItalic]
      Version = '1.1.0.1'
      Anchors = [akTop, akRight]
      Visible = False
      ExplicitLeft = 560
    end
    object Label_TotalCount: TLabel
      Left = 352
      Top = 13
      Width = 88
      Height = 13
      Caption = 'Total Count (Sec.)'
    end
    object Label_CurrTotal: TLabel
      Left = 354
      Top = 35
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Label_AutoCapture: TAdvSmoothLabel
      Left = 440
      Top = 6
      Width = 216
      Height = 50
      Fill.ColorMirror = clNone
      Fill.ColorMirrorTo = clNone
      Fill.Rounding = 0
      Fill.ShadowOffset = 0
      Caption.Text = 'Auto Capture...'
      Caption.Font.Charset = DEFAULT_CHARSET
      Caption.Font.Color = clWindowText
      Caption.Font.Height = -27
      Caption.Font.Name = 'Tahoma'
      Caption.Font.Style = []
      Caption.ColorStart = clRed
      Caption.ColorEnd = clMaroon
      Version = '1.1.0.1'
      Visible = False
    end
    object Button_Start: TAdvSmoothButton
      Left = 8
      Top = 6
      Width = 161
      Height = 51
      Appearance.Font.Charset = ANSI_CHARSET
      Appearance.Font.Color = clWindowText
      Appearance.Font.Height = -21
      Appearance.Font.Name = 'Times New Roman'
      Appearance.Font.Style = [fsItalic]
      Status.Caption = '0'
      Status.Appearance.Fill.Color = clRed
      Status.Appearance.Fill.ColorMirror = clNone
      Status.Appearance.Fill.ColorMirrorTo = clNone
      Status.Appearance.Fill.GradientType = gtSolid
      Status.Appearance.Fill.BorderColor = clGray
      Status.Appearance.Fill.Rounding = 0
      Status.Appearance.Fill.ShadowOffset = 0
      Status.Appearance.Font.Charset = DEFAULT_CHARSET
      Status.Appearance.Font.Color = clWhite
      Status.Appearance.Font.Height = -11
      Status.Appearance.Font.Name = 'Tahoma'
      Status.Appearance.Font.Style = []
      Caption = 'Start'
      ParentFont = False
      TabOrder = 0
      Version = '1.6.5.2'
      OnClick = Button_StartClick
    end
    object Button_Stop: TAdvSmoothButton
      Left = 175
      Top = 6
      Width = 161
      Height = 51
      Appearance.Font.Charset = ANSI_CHARSET
      Appearance.Font.Color = clWindowText
      Appearance.Font.Height = -21
      Appearance.Font.Name = 'Times New Roman'
      Appearance.Font.Style = [fsItalic]
      Status.Caption = '0'
      Status.Appearance.Fill.Color = clRed
      Status.Appearance.Fill.ColorMirror = clNone
      Status.Appearance.Fill.ColorMirrorTo = clNone
      Status.Appearance.Fill.GradientType = gtSolid
      Status.Appearance.Fill.BorderColor = clGray
      Status.Appearance.Fill.Rounding = 0
      Status.Appearance.Fill.ShadowOffset = 0
      Status.Appearance.Font.Charset = DEFAULT_CHARSET
      Status.Appearance.Font.Color = clWhite
      Status.Appearance.Font.Height = -11
      Status.Appearance.Font.Name = 'Tahoma'
      Status.Appearance.Font.Style = []
      Caption = 'Stop'
      ParentFont = False
      TabOrder = 1
      Version = '1.6.5.2'
      OnClick = Button_StopClick
    end
    object Edit_TotalCount: TEdit
      Left = 391
      Top = 32
      Width = 49
      Height = 21
      TabOrder = 2
      Text = '60'
      OnClick = Edit_TotalCountClick
    end
  end
  object Panel_Background: TPanel
    Left = 10
    Top = 10
    Width = 778
    Height = 489
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Panel_ShutterGroup: TPanel
      Left = 0
      Top = 0
      Width = 603
      Height = 489
      Align = alClient
      TabOrder = 0
    end
    object Panel_VisionViewGroup: TPanel
      Left = 603
      Top = 0
      Width = 175
      Height = 489
      Align = alRight
      Caption = ']'
      TabOrder = 1
    end
  end
  object Timer_ShutterState: TTimer
    Interval = 500
    OnTimer = Timer_ShutterStateTimer
    Left = 8
    Top = 8
  end
end
