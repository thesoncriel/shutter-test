unit Frame_CaptureOptionUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, AdvSmoothButton, StdCtrls, Form_InputDialogUnit, Form_CaptureHoleUnit, 
  Class_ImageCapture, FileCtrl, Class_PartList;

type
  TFrame_CaptureOption = class(TFrame)
    GroupBox_CaptureOption: TGroupBox;
    Label2: TLabel;
    Label1: TLabel;
    Edit_StartDelay: TEdit;
    Edit_Interval: TEdit;
    Button_Directory: TAdvSmoothButton;
    Button_Capture: TAdvSmoothButton;
    Button_ShowCaptureForm: TAdvSmoothButton;
    Label3: TLabel;
    ComboBox_Shutter: TComboBox;
    CheckBox_FullScreen: TCheckBox;
    Button_AutoCaptureStart: TAdvSmoothButton;
    Button_AutoCaptureStop: TAdvSmoothButton;
    procedure Button_AutoCaptureStartClick(Sender: TObject);
    procedure Button_AutoCaptureStopClick(Sender: TObject);
    procedure Button_CaptureClick(Sender: TObject);
    procedure Button_DirectoryClick(Sender: TObject);
    procedure Button_ShowCaptureFormClick(Sender: TObject);
    procedure CheckBox_FullScreenClick(Sender: TObject);
    procedure Edit_Click(Sender: TObject);
  private
    FOnAutoCaptureStartEvent: TOnCaptureEvent;
    FOnAutoCaptureStopEvent: TNotifyEvent;
    FOnCaptureEvent: TOnCaptureEvent;
    FSavePath: string;
    { Private declarations }
  protected
  public
    constructor Create(owner: TComponent); override;
    function GetInterval: Integer;
    function GetRectHole: IRectangleHole;
    function GetSavePath: string;
    function GetSelectedPart: string;
    function GetStartDelay: Integer;
    function IsFullScreen: Boolean;
    procedure SetPartList(partList: TPartList);
    { Public declarations }
  published
    property OnAutoCaptureStartEvent: TOnCaptureEvent read FOnAutoCaptureStartEvent
        write FOnAutoCaptureStartEvent;
    property OnAutoCaptureStopEvent: TNotifyEvent read FOnAutoCaptureStopEvent
        write FOnAutoCaptureStopEvent;
    property OnCaptureEvent: TOnCaptureEvent read FOnCaptureEvent write
        FOnCaptureEvent;
  end;

implementation

{$R *.dfm}



constructor TFrame_CaptureOption.Create(owner: TComponent);
begin
  inherited;
  Parent := owner as TWinControl;
end;

procedure TFrame_CaptureOption.Button_AutoCaptureStartClick(Sender: TObject);
begin
  FOnAutoCaptureStartEvent( self, Form_CaptureHole );
end;

procedure TFrame_CaptureOption.Button_AutoCaptureStopClick(Sender: TObject);
begin
  FOnAutoCaptureStopEvent( self );
end;

procedure TFrame_CaptureOption.Button_CaptureClick(Sender: TObject);
begin
  if IsFullScreen or Form_CaptureHole.Showing then
  begin
    FOnCaptureEvent( self, Form_CaptureHole );
  end;
end;

procedure TFrame_CaptureOption.Button_DirectoryClick(Sender: TObject);
var
  sPath: String;
begin
  if SelectDirectory( 'Select Save Directory', '', sPath) = true then
  begin
    FSavePath := sPath;
  end;
end;

procedure TFrame_CaptureOption.Button_ShowCaptureFormClick(Sender: TObject);
begin
  Form_CaptureHole.Show;
end;

procedure TFrame_CaptureOption.CheckBox_FullScreenClick(Sender: TObject);
begin
  Button_ShowCaptureForm.Visible := not CheckBox_FullScreen.Checked;
end;

procedure TFrame_CaptureOption.Edit_Click(Sender: TObject);
begin
  if Form_InputDialog.ShowModal <> mrCancel then
  begin
    (Sender as TEdit).Text := Form_InputDialog.GetValue;
  end;
end;

function TFrame_CaptureOption.GetInterval: Integer;
begin
  Result := StrToInt( Edit_Interval.Text );
end;

function TFrame_CaptureOption.GetRectHole: IRectangleHole;
begin
  Result := Form_CaptureHole;
end;

function TFrame_CaptureOption.GetSavePath: string;
begin
  Result := FSavePath;
end;

function TFrame_CaptureOption.GetSelectedPart: string;
begin
  Result := ComboBox_Shutter.Text;
end;

function TFrame_CaptureOption.GetStartDelay: Integer;
begin
  Result := StrToInt( Edit_StartDelay.Text );
end;

function TFrame_CaptureOption.IsFullScreen: Boolean;
begin
  Result := CheckBox_FullScreen.Checked;
end;

procedure TFrame_CaptureOption.SetPartList(partList: TPartList);
var
  i: Integer;
begin
  for i := 0 to partList.Count - 1 do
  begin
    ComboBox_Shutter.Items.Add( partList[ i ].Name );
  end;

  ComboBox_Shutter.ItemIndex := 0;
end;

end.
