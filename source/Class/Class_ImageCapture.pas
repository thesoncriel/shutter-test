unit Class_ImageCapture;

interface

uses
  Windows, Graphics, JPEG, Unit_GlobalFunction, Class_Part, ExtCtrls, pngimage;
  
const
  IMG_NAME_NUM_FORMAT = '_000#';
type
  IRectangleHole = interface(IInterface)
  ['{75B66F01-A33F-4AFF-BE7B-A49E5D30FBC8}']
    function GetHeight: Integer; stdcall;
    function GetWidth: Integer; stdcall;
    function GetXAxis: Integer; stdcall;
    function GetYAxis: Integer; stdcall;
  end;

  TOnCaptureEvent = procedure(Sender: TObject; rectHole: IRectangleHole) of
      object;

  TImageCapture = class(TObject)
  private
    FAutoCapture: Boolean;
    FAutoImgName: string;
    FInterval: Integer;
    FIntervalCount: Integer;
    FRectHole: IRectangleHole;
    FStartDelayCount: Integer;
    FSavePath: String;
    FStartDelay: Integer;
    //FJpg: TJPEGImage;
    FPng: TPNGObject;
    FBitmap: TBitmap;
    FFullScreen: Boolean;
    FImgName: string;
    FStartDate: string;
    FImgCount: Integer;
    FTargetPart: TAbsPart;
    FTimerInterval: Integer;
    FTimer: TTimer;
    procedure SetTargetPart(const Value: TAbsPart);
  protected
    procedure InitCount;
    procedure OnTimer(Sender: TObject);
    procedure SaveImage(bitmap: TBitmap; filePath: String);
    procedure ScreenShot(DestBitmap: TBitmap);
  public
    constructor Create;
    destructor Destroy; override;
    procedure AutoCapture;
    procedure AutoCapturePause;
    procedure AutoCaptureRestart;
    procedure AutoCaptureStart(rectHole: IRectangleHole);
    procedure AutoCaptureStop;
    function Capture(rectHole: IRectangleHole): String; overload;
    function Capture(rectHole: IRectangleHole; filePath: String): string; overload;
    procedure FullScreenShot(DestBitmap: TBitmap);
    procedure SetImageNameFormat(imgName: string);
    procedure SetInterval(strInterval: String); overload;
    procedure SetInterval(interval: Integer); overload;
    procedure SetStartDelay(delay: Integer); overload;
    procedure SetStartDelay(strDelay: String); overload;
    property FullScreen: Boolean read FFullScreen write FFullScreen;
    property SavePath: String read FSavePath write FSavePath;
    property TargetPart: TAbsPart read FTargetPart write SetTargetPart;
    property TimerInterval: Integer read FTimerInterval write FTimerInterval;
  end;



implementation

uses
  SysUtils;

constructor TImageCapture.Create;
begin
  inherited;
  InitCount;
  //FJpg := TJPEGImage.Create;
  FPng := TPNGObject.Create;
  FBitmap := TBitmap.Create;
  FImgName := '';
  FSavePath := 'C:\';
  FTimerInterval := 1000;
  FTimer := TTimer.Create( nil );
  FTimer.OnTimer := OnTimer;
  FTimer.Enabled := false;
end;

destructor TImageCapture.Destroy;
begin
  inherited;
  //FJpg.Free;
  FPng.Free;
  FBitmap.Free;
  FTimer.Free;
end;

procedure TImageCapture.AutoCapture;
var
  sDestFilePath: String;
begin
  if ( FAutoCapture = true ) and ( FTargetPart.GetPartState = true ) then
  begin
    if FStartDelayCount >= FStartDelay then
    begin
      if FIntervalCount >= FInterval then
      begin
        sDestFilePath := FormatFloat( FAutoImgName, FImgCount );
        Capture( FRectHole, sDestFilePath + '.png'{'.jpg'} );
        Inc( FImgCount );
        FIntervalCount := 1;
      end
      else
      begin
        Inc( FIntervalCount );
      end;
    end
    else
    begin
      Inc( FStartDelayCount );
    end;
  end
  else
  begin
    FStartDelayCount := 1;
    FIntervalCount := FInterval + 1;
  end;
end;

procedure TImageCapture.AutoCapturePause;
begin
  FAutoCapture := false;
  FIntervalCount := 1;
  FStartDelayCount := 1;
end;

procedure TImageCapture.AutoCaptureRestart;
begin
  FAutoCapture := true;
end;

procedure TImageCapture.AutoCaptureStart(rectHole: IRectangleHole);
var
  sDir: String;
begin
  FStartDate := DateTimeToStr( Now );
  FStartDate := StringReplace( FStartDate, ':', '_', [ rfReplaceAll ] );

  sDir := FSavePath + '\' + FStartDate + '\';
  CreateAllDir( sDir );
  FAutoImgName := sDir + FImgName + IMG_NAME_NUM_FORMAT;

  FRectHole := rectHole;                    
  //if FileExists( FormatCurr( FAutoImgName, 0 ) ) = false then FImgCount := 0;
  
  FAutoCapture := true;
  FTimer.Interval := FTimerInterval;
  FTimer.Enabled := true;
end;

procedure TImageCapture.AutoCaptureStop;
begin
  FAutoCapture := false;
  FTimer.Enabled := false;
  InitCount;
end;

function TImageCapture.Capture(rectHole: IRectangleHole): String;
var
  sDateTime: String;
begin
  sDateTime := DateTimeToStr( Now );
  //sDateTime := StringReplace( sDateTime, '-', '', [ rfReplaceAll ] );
  sDateTime := StringReplace( sDateTime, ':', '_', [ rfReplaceAll ] );

  Result := Capture( rectHole, FSavePath + '\' + sDateTime + '.png'{'.jpg'} );
end;

function TImageCapture.Capture(rectHole: IRectangleHole; filePath: String):
    string;
begin
  FRectHole := rectHole;
  if FFullScreen = true then
  begin
    FullScreenShot( FBitmap );
  end
  else
  begin
    ScreenShot( FBitmap );
  end;
  SaveImage( FBitmap, filePath );

  Result := filePath;
end;

procedure TImageCapture.FullScreenShot(DestBitmap: TBitmap);
var
  DC: HDC;
begin
  DC := GetDC( GetDesktopWindow );
  try
    DestBitmap.Width := GetDeviceCaps( DC, HORZRES );
    DestBitmap.Height := GetDeviceCaps( DC, VERTRES );
    BitBlt( DestBitmap.Canvas.Handle, 0,0, DestBitmap.Width, DestBitmap.Height, DC, 0, 0, SRCCOPY );
  finally
    ReleaseDC( GetDesktopWindow, DC );
  end;
end;

procedure TImageCapture.InitCount;
begin
  FIntervalCount := FInterval + 1;
  FStartDelayCount := 1;
  FImgCount := 1;
end;

procedure TImageCapture.OnTimer(Sender: TObject);
begin
  AutoCapture;
end;

procedure TImageCapture.SaveImage(bitmap: TBitmap; filePath: String);
begin
  FPng.Assign( bitmap );
  FPng.SaveToFile( filePath );
  //FJpg.Assign( bitmap );
  //FJpg.SaveToFile( filePath );
end;

procedure TImageCapture.SetInterval(strInterval: String);
begin
  SetInterval( StrToInt( strInterval ) );
end;

procedure TImageCapture.SetInterval(interval: Integer);
begin
  FInterval :=  ( 1000 div FTimerInterval) * interval;
end;

procedure TImageCapture.SetStartDelay(delay: Integer);
begin
  FStartDelay := (1000 div FTimerInterval) * delay;
end;

procedure TImageCapture.SetStartDelay(strDelay: String);
begin
  SetStartDelay( StrToInt( strDelay ) );
end;

procedure TImageCapture.ScreenShot(DestBitmap: TBitmap);
var
  DC: HDC;
begin
  DC := GetDC( GetDesktopWindow );
  try
    DestBitmap.Width := FRectHole.GetWidth;// GetDeviceCaps( DC, HORZRES );
    DestBitmap.Height := FRectHole.GetHeight;// GetDeviceCaps( DC, VERTRES );
    BitBlt( DestBitmap.Canvas.Handle, 0,0, DestBitmap.Width, DestBitmap.Height, DC, FRectHole.GetXAxis, FRectHole.GetYAxis, SRCCOPY );
  finally
    ReleaseDC( GetDesktopWindow, DC );
  end;
end;

procedure TImageCapture.SetImageNameFormat(imgName: string);
begin
  FImgName := imgName;
end;

procedure TImageCapture.SetTargetPart(const Value: TAbsPart);
begin
  FTargetPart := Value;
end;

end.
