object Frame_RecipeTable: TFrame_RecipeTable
  Left = 0
  Top = 0
  Width = 451
  Height = 304
  Align = alClient
  TabOrder = 0
  object ListView_RecipeTable: TAdvListView
    Left = 0
    Top = 0
    Width = 451
    Height = 304
    Align = alClient
    Columns = <
      item
        MaxWidth = 20
        Width = 19
      end
      item
        AutoSize = True
        Caption = 'Operation'
      end
      item
        AutoSize = True
        Caption = 'Delay Time'
      end>
    ColumnClick = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial Narrow'
    Font.Style = []
    GridLines = True
    HoverTime = -1
    Items.ItemData = {
      014C0000000200000000000000FFFFFFFFFFFFFFFF0100000000000000044F00
      700065006E00023200300000000000FFFFFFFFFFFFFFFF010000000000000005
      43006C006F00730065000231003500FFFFFFFF}
    RowSelect = True
    ParentFont = False
    TabOrder = 0
    ViewStyle = vsReport
    AutoHint = False
    ClipboardEnable = False
    ColumnSize.Save = False
    ColumnSize.Stretch = True
    ColumnSize.Storage = stInifile
    FilterTimeOut = 500
    PrintSettings.FooterSize = 0
    PrintSettings.HeaderSize = 0
    PrintSettings.Time = ppNone
    PrintSettings.Date = ppNone
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.PageNr = ppNone
    PrintSettings.Title = ppNone
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -11
    PrintSettings.Font.Name = 'Tahoma'
    PrintSettings.Font.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -11
    PrintSettings.HeaderFont.Name = 'Tahoma'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'Tahoma'
    PrintSettings.FooterFont.Style = []
    PrintSettings.Borders = pbNoborder
    PrintSettings.BorderStyle = psSolid
    PrintSettings.Centered = False
    PrintSettings.RepeatHeaders = False
    PrintSettings.LeftSize = 0
    PrintSettings.RightSize = 0
    PrintSettings.ColumnSpacing = 0
    PrintSettings.RowSpacing = 0
    PrintSettings.Orientation = poPortrait
    PrintSettings.FixedWidth = 0
    PrintSettings.FixedHeight = 0
    PrintSettings.UseFixedHeight = False
    PrintSettings.UseFixedWidth = False
    PrintSettings.FitToPage = fpNever
    PrintSettings.PageNumSep = '/'
    HTMLHint = False
    HTMLSettings.Width = 100
    HeaderHotTrack = False
    HeaderDragDrop = False
    HeaderFlatStyle = False
    HeaderOwnerDraw = False
    HeaderHeight = 13
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'Tahoma'
    HeaderFont.Style = []
    ProgressSettings.ColorFrom = clSilver
    ProgressSettings.FontColorFrom = clBlack
    ProgressSettings.ColorTo = clWhite
    ProgressSettings.FontColorTo = clGray
    SelectionRTFKeep = False
    ScrollHint = False
    SelectionColor = clHighlight
    SelectionTextColor = clHighlightText
    SizeWithForm = False
    SortDirection = sdAscending
    SortShow = False
    SortIndicator = siLeft
    StretchColumn = True
    SubImages = False
    SubItemEdit = False
    SubItemSelect = False
    VAlignment = vtaCenter
    ItemHeight = 25
    SaveHeader = False
    LoadHeader = True
    ReArrangeItems = True
    DetailView.Visible = False
    DetailView.Column = 0
    DetailView.Font.Charset = DEFAULT_CHARSET
    DetailView.Font.Color = clBlue
    DetailView.Font.Height = -11
    DetailView.Font.Name = 'Tahoma'
    DetailView.Font.Style = []
    DetailView.Height = 16
    DetailView.Indent = 0
    DetailView.SplitLine = False
    OnLeftClickCell = ListView_RecipeTableLeftClickCell
    Version = '1.6.4.3'
    ExplicitHeight = 303
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '*.xml'
    Filter = 'XML File|*.xml'
    Title = 'Save To Recipe XML File'
    Left = 296
    Top = 280
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*.xml'
    Filter = 'XML File|*.xml'
    Title = 'Load To Recipe XML File'
    Left = 328
    Top = 280
  end
end
