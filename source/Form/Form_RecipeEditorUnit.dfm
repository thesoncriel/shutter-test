object Form_RecipeEditor: TForm_RecipeEditor
  Left = 0
  Top = 0
  Caption = '::: Recipe Editor :::'
  ClientHeight = 460
  ClientWidth = 437
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label_PartName: TLabel
    Left = 12
    Top = 15
    Width = 73
    Height = 24
    Caption = 'Shutter 1'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Book Antiqua'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object Label_FilePath: TLabel
    Left = 52
    Top = 84
    Width = 86
    Height = 16
    Caption = 'C:\...\haha.xml'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Panel_RightTop: TPanel
    Left = 155
    Top = 39
    Width = 281
    Height = 41
    Align = alCustom
    Anchors = [akTop, akRight]
    TabOrder = 0
    object Buttom_Save: TAdvSmoothButton
      Left = 24
      Top = 3
      Width = 78
      Height = 35
      Appearance.Font.Charset = ANSI_CHARSET
      Appearance.Font.Color = clWindowText
      Appearance.Font.Height = -16
      Appearance.Font.Name = 'Times New Roman'
      Appearance.Font.Style = []
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
      Caption = 'Save'
      Color = 16759671
      ParentFont = False
      TabOrder = 0
      Version = '1.6.5.2'
      OnClick = Buttom_SaveClick
    end
    object Button_Load: TAdvSmoothButton
      Left = 106
      Top = 3
      Width = 78
      Height = 35
      Appearance.Font.Charset = ANSI_CHARSET
      Appearance.Font.Color = clWindowText
      Appearance.Font.Height = -16
      Appearance.Font.Name = 'Times New Roman'
      Appearance.Font.Style = []
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
      Caption = 'Load'
      Color = 6730751
      ParentFont = False
      TabOrder = 1
      Version = '1.6.5.2'
      OnClick = Button_LoadClick
    end
    object Button_Clear: TAdvSmoothButton
      Left = 190
      Top = 3
      Width = 78
      Height = 35
      Appearance.Font.Charset = ANSI_CHARSET
      Appearance.Font.Color = clWindowText
      Appearance.Font.Height = -16
      Appearance.Font.Name = 'Times New Roman'
      Appearance.Font.Style = []
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
      Caption = 'Clear'
      Color = 8421631
      ParentFont = False
      TabOrder = 2
      Version = '1.6.5.2'
      OnClick = Button_ClearClick
    end
  end
  object Panel_Body: TPanel
    Left = 0
    Top = 106
    Width = 437
    Height = 354
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object Panel_Bottom: TPanel
      Left = 1
      Top = 313
      Width = 435
      Height = 40
      Align = alBottom
      TabOrder = 0
      DesignSize = (
        435
        40)
      object Button_OK: TAdvSmoothButton
        Left = 299
        Top = 2
        Width = 123
        Height = 35
        Anchors = [akRight, akBottom]
        Appearance.Font.Charset = ANSI_CHARSET
        Appearance.Font.Color = clWindowText
        Appearance.Font.Height = -16
        Appearance.Font.Name = 'Times New Roman'
        Appearance.Font.Style = []
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
        Caption = 'OK'
        Color = 8421440
        ParentFont = False
        TabOrder = 0
        Version = '1.6.5.2'
        OnClick = Button_OKClick
      end
    end
    object Panel_Table: TPanel
      Left = 1
      Top = 1
      Width = 435
      Height = 312
      Align = alClient
      Caption = 'Panel_Table'
      TabOrder = 1
    end
  end
end
