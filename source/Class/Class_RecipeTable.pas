unit Class_RecipeTable;

interface

uses
  Classes, ComCtrls, Class_RecipeRow;

type

  TRecipeTable = class(TObject)
  private
    FRows: TList;
    FCurrRow: Integer;
    function GetRows(Index: Integer): TRecipeRow;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(recipeRow: TRecipeRow);
    function Current: TRecipeRow;
    procedure Delete(index: Integer);
    function HasNext: boolean;
    procedure MoveFirst;
    function MoveNext: Boolean;
    function MovePrev: Boolean;
    function RowCount: integer;
    procedure SetData(listItems: TListItems);
    property CurrentRow: Integer read FCurrRow;
    property Rows[Index: Integer]: TRecipeRow read GetRows; default;
  end;

  
implementation

uses
  SysUtils;


constructor TRecipeTable.Create;
begin
  inherited;
  FRows := TList.Create;
end;

destructor TRecipeTable.Destroy;
begin
  inherited;
  FRows.Clear;
  FRows.Free;
end;

procedure TRecipeTable.Add(recipeRow: TRecipeRow);
begin
  FRows.Add( recipeRow )
end;

function TRecipeTable.Current: TRecipeRow;
begin       self.FRows.Count;
  Result := GetRows( FCurrRow );
end;

procedure TRecipeTable.Delete(index: Integer);
begin
  FRows.Delete( index );
end;

function TRecipeTable.GetRows(Index: Integer): TRecipeRow;
begin
  Result := TRecipeRow( FRows.Items[ Index ] );
end;

function TRecipeTable.HasNext: boolean;
var
  bRet: Boolean;
begin
  bRet := FCurrRow < FRows.Count;
  if ( FCurrRow = 0 ) and ( FRows.Count = 0 ) then
    bRet := false;

  Result := bRet;
end;

procedure TRecipeTable.MoveFirst;
begin
  FCurrRow := 0;
end;

function TRecipeTable.MoveNext: Boolean;
var
  bRet: Boolean;
begin
  bRet := HasNext;

  if bRet = true then
  begin
    FCurrRow := FCurrRow + 1;
  end;
  Result := bRet;
end;

function TRecipeTable.MovePrev: Boolean;
var
  bRet: Boolean;
begin
  bRet := FCurrRow > 0;

  if bRet = true then
  begin
    FCurrRow := FCurrRow - 1;
  end;
  Result := bRet;
end;

function TRecipeTable.RowCount: integer;
begin
  Result := FRows.Count;
end;

procedure TRecipeTable.SetData(listItems: TListItems);
var
  i: Integer;
begin
  for i := 0 to listItems.Count - 2 do
  begin
    Add( TRecipeRow.Create( listItems[ i ].SubItems ) );
  end;
end;




end.
