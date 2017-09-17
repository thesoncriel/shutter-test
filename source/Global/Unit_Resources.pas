unit Unit_Resources;

interface

uses
  AdvPicture, Classes;

procedure InitRes;

const
  IMG_SHUTTER_CLOSE = '.\img\ShutterClose_small.bmp';
  IMG_SHUTTER_OPEN = '.\img\ShutterOpen_small.bmp';
  CONFIG_FILE = '..\Config\Config.ini';
  LOG_FOLDER = '..\Log\';
var
  g_PicShutterOpen: TIPicture;
  g_PicShutterClose: TIPicture;
  g_ShutterRecipeTableColumns: TStrings;
implementation

procedure InitRes;
begin
  g_PicShutterOpen := TIPicture.Create;
  g_PicShutterClose := TIPicture.Create;
  g_PicShutterOpen.LoadFromFile( IMG_SHUTTER_OPEN );
  g_PicShutterClose.LoadFromFile( IMG_SHUTTER_CLOSE );
  g_ShutterRecipeTableColumns := TStringList.Create;
  g_ShutterRecipeTableColumns.Add( 'Operation' );
  g_ShutterRecipeTableColumns.Append( 'DealyTime' );
end;

end.
