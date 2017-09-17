unit Form_CaptureHoleUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Class_ImageCapture, WSDLBind;

const
  WINDOW_BORDER_WIDTH = 6;
  WINDOW_TOP_BORDER_WIDTH = 25;

type
  TForm_CaptureHole = class(TForm, IRectangleHole)
    Panel_Top: TPanel;
    Panel_Bottom: TPanel;
    Panel_Left: TPanel;
    Panel_Right: TPanel;
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
  private
    FHole_XAxis, FHole_YAxis, FHole_Width, FHole_Height: Integer;

  protected
    procedure SetHoleData;
    procedure OnMove(var Message: TMessage); message WM_MOVE;
  public
    function GetHeight: Integer; stdcall;
    function GetWidth: Integer; stdcall;
    function GetXAxis: Integer; stdcall;
    function GetYAxis: Integer; stdcall;
  end;

var
  Form_CaptureHole: TForm_CaptureHole;

implementation

{$R *.dfm}

procedure TForm_CaptureHole.FormMouseMove(Sender: TObject; Shift: TShiftState;
    X, Y: Integer);
begin
  SetHoleData;
end;

procedure TForm_CaptureHole.FormResize(Sender: TObject);
var
  WindowRgn, HoleRgn: HRgn;
  x, y, w, h: Integer;
begin
  WindowRgn := 0;
  GetWindowRgn( Handle, WindowRgn );
  DeleteObject( WindowRgn );
  WindowRgn := CreateRectRgn( 0, 0, Width, Height );
  x := Panel_Left.Width + WINDOW_BORDER_WIDTH;
  y:= Panel_Top.Height + WINDOW_TOP_BORDER_WIDTH;
  w := Width - ( Panel_Right.Width + 6 );
  h := Height - ( Panel_Bottom.Height + 6 );
  HoleRgn := CreateRectRgn( x, y, w, h );
  CombineRgn( WindowRgn, WindowRgn, HoleRgn, RGN_DIFF );
  SetWindowRgn( Handle, WindowRgn, TRUE );
  DeleteObject( HoleRgn );

  //SetHoleData;
end;

function TForm_CaptureHole.GetHeight: Integer;
begin
  Result := FHole_Height;
end;

function TForm_CaptureHole.GetWidth: Integer;
begin
  Result := FHole_Width;
end;

function TForm_CaptureHole.GetXAxis: Integer;
begin
  Result := FHole_XAxis;
end;

function TForm_CaptureHole.GetYAxis: Integer;
begin
  Result := FHole_YAxis;
end;

procedure TForm_CaptureHole.OnMove(var Message: TMessage);
begin
  SetHoleData;
end;

procedure TForm_CaptureHole.SetHoleData;
begin
  FHole_XAxis   := Left + Panel_Left.Width + WINDOW_BORDER_WIDTH;
  FHole_YAxis   := Top + Panel_Top.Height + WINDOW_TOP_BORDER_WIDTH;
  FHole_Width   := Width - ( Panel_Right.Width + WINDOW_BORDER_WIDTH ) - Panel_Left.Width - WINDOW_BORDER_WIDTH;
  FHole_Height  := Height - ( Panel_Bottom.Height + WINDOW_BORDER_WIDTH ) - Panel_Top.Height - WINDOW_TOP_BORDER_WIDTH;
end;

end.
