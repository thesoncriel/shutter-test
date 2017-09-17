unit Device_FAVRs232c;

interface

uses SysUtils, AdPort, Device_FAVBase;

type
  TFAVRs232cDevice = class( TFAVDevice )
  private
    FComport: TApdComPort;
  protected
    procedure NewDevice( aDeviceParam: TDeviceParam ); override;
  public
    destructor Destroy; override;
    procedure Initialize; override;
    procedure WriteDevice( ActionValue: Variant ); override;
    property Comport: TApdComPort read FComport;
  end;

implementation

destructor TFAVRs232cDevice.Destroy;
begin
  Comport.Open := False;
  Comport.Free;
  inherited;
end;

procedure TFAVRs232cDevice.Initialize;
begin
  
end;

procedure TFAVRs232cDevice.WriteDevice( ActionValue: Variant );
begin
  inherited;
  //Comport.Output := ActionValue;
  Comport.PutString( ActionValue );
end;

procedure TFAVRs232cDevice.NewDevice( aDeviceParam: TDeviceParam );
const
  cParity: Array [ 0..4 ] of String = ( 'PNONE',
                                        'PODD',
                                        'PEVEN',
                                        'PMARK',
                                        'PSPACE' );

  function GetParity( Value: String ): TParity;
  var
    i: Integer;
  begin
    Result := TParity( 0 );
    for i := 0 to 4 do
      if Uppercase( Value ) = cParity[ i ] then
      begin
        Result := TParity( i );
        exit;
      end;
  end;

begin
  inherited;

  FComport := TApdComPort.Create( nil );
  with FComport do
  begin
    ComNumber := aDeviceParam.PortNum;
    Baud := aDeviceParam.BaudRate;
    Parity := GetParity( aDeviceParam.Parity );
    DataBits := aDeviceParam.DataBit;
    StopBits := aDeviceParam.StopBit;
    LogName := aDeviceParam.DeviceName + '.Log';
    Logging := tlOn;
    Open := True;
  end;
end;

initialization
begin
  FAVDeviceClasses.RegisterClass( 2, TFAVRs232cDevice );
end;

finalization
begin

end;


end.
