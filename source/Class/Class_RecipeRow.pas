unit Class_RecipeRow;

interface

uses
  Classes;

type
  IRecipeRow = interface(IInterface)
  ['{2F5566B6-BD2C-4246-B793-4897AAC14597}']
    function Cols(columnIndex: Integer): Variant; stdcall;
    function Count: Integer; stdcall;
    procedure SetRowData(strings: TStrings); stdcall;
  end;

  TRecipeRow = class(TInterfacedObject, IRecipeRow)
  public
    Operation: boolean;
    Delay: Integer;
    constructor Create(strings: TStrings);
    function Cols(columnIndex: Integer): Variant; stdcall;
    procedure SetRowData(strings: TStrings); stdcall;
    function Count: Integer; stdcall;
  end;



implementation

uses
  SysUtils;

function TRecipeRow.Cols(columnIndex: Integer): Variant;
begin
  case columnIndex of
    0: Result := Operation;
    1: Result := Delay;  
  end;
end;

function TRecipeRow.Count: Integer;
begin
  Result := 2;
end;

constructor TRecipeRow.Create(strings: TStrings);
begin
  SetRowData( strings );
end;

procedure TRecipeRow.SetRowData(strings: TStrings);
begin
  Operation := LowerCase( strings[ 0 ] ) = 'open';
  Delay := StrToInt( strings[ 1 ] );
end;

end.
