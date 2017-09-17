unit Device_FAVRs485;

interface

uses SysUtils, Device_FAVBase, Device_FAVRs232c;

type
  TFAVRs485Device = class( TFAVRs232cDevice )
  private
    FDriver: TObject;
  public
    function IsDriverNull: Boolean;
    procedure SetDriver( aDriver: TObject );
    property Driver: TObject read FDriver;
  end;

implementation

function TFAVRs485Device.IsDriverNull: Boolean;
begin
  Result := Driver = nil;
end;

procedure TFAVRs485Device.SetDriver( aDriver: TObject );
begin
  FDriver := aDriver;
end;

end.
