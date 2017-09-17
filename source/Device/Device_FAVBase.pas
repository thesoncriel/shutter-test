unit Device_FAVBase;

interface

uses Classes, Contnrs, SysUtils, Dialogs, DB;

type
  TDeviceChangeEvent = procedure ( aDriver: TComponent ) of object;

  TArrayByte = Array [ 0..100 ] of Byte;

  TDeviceParam = record
    DeviceType,
    PortNum,
    BaudRate: Integer;
    DeviceName,
    SubName,
    Parity,
    IpAddress: String;
    DataBit,
    StopBit,
    Channel,
    ID : Integer;
  end;

  TFAVDevice = class
  private
    FBaudRate: Integer;
    FDeviceName: String;
    FDeviceType: Integer;
  protected
    procedure NewDevice(aDeviceParam: TDeviceParam); virtual;
  public
    constructor Create( aDeviceParam: TDeviceParam ); virtual;
    procedure Initialize; virtual; abstract;
    procedure WriteDevice( ActionValue: Variant ); virtual; abstract;
    procedure ReadDevice;  virtual; abstract;
    property BaudRate: Integer read FBaudRate write FBaudRate;
    property DeviceName: String read FDeviceName;
    property DeviceType: Integer read FDeviceType;
  end;

  TFAVDeviceClass = class of TFAVDevice;

  TFAVDeviceClasses = class
  private
    FClassList: TList;
    FMaxCount: Integer;
    procedure Clear;
    procedure Delete( Index: Integer );
    function GetItems(Index: Integer): TFAVDeviceClass;
  public
    constructor Create( MaxClassCount: Integer );
    destructor Destroy; override;
    procedure RegisterClass( Index: Integer; aDeviceClass: TFAVDeviceClass );
    property Items[ Index: Integer ]: TFAVDeviceClass read GetItems; default;
  end;

  TFAVDeviceList = class
  private
    FList: TObjectList;
    function GetDevices( Index: Integer ): TFAVDevice;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Add( aDevice: TFAVDevice );
    procedure InitDevice;
    property Devices[ Index: Integer ]: TFAVDevice read GetDevices; default;
  end;

  procedure CreateDevice( aData: TFields );

var
  FAVDevices: TFAVDeviceList;
  FAVDeviceClasses: TFAVDeviceClasses;

implementation

constructor TFAVDeviceClasses.Create( MaxClassCount: Integer );
var
  i: Integer;
begin
  FMaxCount := MaxClassCount;
  FClassList := TList.Create;

  for i := 0 to FMaxCount do
    FClassList.Add( nil );
end;

destructor TFAVDeviceClasses.Destroy;
begin
  Clear;
  FClassList.Free;
  inherited;
end;

procedure TFAVDeviceClasses.Clear;
var
  i: Integer;
begin
  for i := FClassList.Count - 1 downto 0 do
    Delete( i );

  FClassList.Clear;
end;

procedure TFAVDeviceClasses.Delete( Index: Integer );
begin
  FClassList.Delete( Index );
end;

function TFAVDeviceClasses.GetItems(Index: Integer): TFAVDeviceClass;
begin
  try
    Result := TFAVDeviceClass( FClassList[ Index ] );
  except
    Result := nil;
  end;
end;

procedure TFAVDeviceClasses.RegisterClass( Index: Integer; aDeviceClass:
    TFAVDeviceClass );
begin
  if not ( Index in [ 0..FMaxCount ] ) then
  begin
    MessageDlg( IntToStr( Index ) + ' : ' + aDeviceClass.ClassName + '등록 중 Index Error', mtInformation, [ mbOk ], 0 );
    exit;
  end
  else
  begin
    if Items[ Index ] <> nil then
    begin
      MessageDlg( IntToStr( Index ) + ' : ' + aDeviceClass.ClassName + '등록 중 Error 이미 ' +
                  Items[ Index ].ClassName + ' 이 존재함', mtInformation, [ mbOk ], 0 );
      exit;
    end;
  end;

  FClassList[ Index ] := aDeviceClass;
end;

constructor TFAVDevice.Create( aDeviceParam: TDeviceParam );
begin
  inherited Create;
  FBaudRate := aDeviceParam.BaudRate;
  FDeviceType := aDeviceParam.DeviceType;
  FDeviceName := aDeviceParam.DeviceName;
  NewDevice( aDeviceParam );
  FAVDevices.Add( Self );
end;

procedure TFAVDevice.NewDevice(aDeviceParam: TDeviceParam);
begin
  // TODO -cMM: TFAVDevice.NewDevice default body inserted
end;

constructor TFAVDeviceList.Create;
begin
  inherited;

  FList := TObjectList.Create;
end;

destructor TFAVDeviceList.Destroy;
begin
  FList.Free;
  inherited;
end;

procedure TFAVDeviceList.Add( aDevice: TFAVDevice );
begin
  FList.Add( aDevice );
end;

function TFAVDeviceList.GetDevices( Index: Integer ): TFAVDevice;
begin
  Result := TFAVDevice( FList[ Index ] );
end;

procedure TFAVDeviceList.InitDevice;
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
    Devices[ i ].Initialize;
end;

procedure CreateDevice( aData: TFields );
var
  aParam: TDeviceParam;
//  aObj: TFAVDevice;
begin
  aParam.DeviceType := aData.Fields[ 0 ].AsInteger;
  aParam.PortNum    := aData.Fields[ 1 ].AsInteger;
  aParam.BaudRate   := aData.Fields[ 2 ].AsInteger;
  aParam.DeviceName := aData.Fields[ 3 ].AsString;
  aParam.SubName    := aData.Fields[ 4 ].AsString;
  aParam.Parity     := aData.Fields[ 5 ].AsString;
  aParam.DataBit    := aData.Fields[ 6 ].AsInteger;
  aParam.StopBit    := aData.Fields[ 7 ].AsInteger;
  aParam.Channel    := aData.Fields[ 8 ].AsInteger;
  aParam.IpAddress  := aData.Fields[ 9 ].AsString;
//  aParam.ID         := aData.Fields[ 10 ].AsInteger;

  FAVDeviceClasses[ aParam.DeviceType ].Create( aParam );
  //aObj := FAVDeviceClasses[ aParam.DeviceType ].Create( aParam );
end;

initialization
begin
  FAVDeviceClasses := TFAVDeviceClasses.Create( 6 );
  FAVDevices := TFAVDeviceList.Create;
end;

finalization
begin
  FAVDevices.Free;
end;


end.
