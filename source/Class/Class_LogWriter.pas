unit Class_LogWriter;

interface

uses
  Class_PartList, Unit_GlobalFunction;

type
  TLogWriter = class(TObject)
  private
    FFolder: String;
    FCurrFileName: String;
  public
    constructor Create(folderName: string);
    procedure AddToColumn(partList: TPartList);
    procedure CreateNewLog(prefixName: string);
    procedure Write(value: string); overload;
    procedure Write(partList: TPartList); overload;
  end;

implementation

uses
  SysUtils;

constructor TLogWriter.Create(folderName: string);
begin
  //inherited;
  FFolder := folderName;
end;

procedure TLogWriter.AddToColumn(partList: TPartList);
var
  i: Integer;
  sCol: String;
begin
  Write( '===========================================================' );
  sCol := 'Date, Time';
  for i := 0 to partList.Count - 1 do
  begin
    sCol := sCol + ', ' + partList[ i ].Name;
  end;
  Write( sCol );
end;

procedure TLogWriter.CreateNewLog(prefixName: string);
var
  iFileHandlerId: Integer;
  sFileName: String;
begin
  try
    sFileName := FFolder + prefixName + '_' + FormatDateTime( 'yyyy_mm_dd_hh_nn_ss', Now ) + '.txt';
    if FileExists( sFileName ) = false then
    begin
      iFileHandlerId := FileCreate( sFileName );
      SysUtils.FileClose( iFileHandlerId );
      FCurrFileName := sFileName;
    end;
  except

  end;
end;

procedure TLogWriter.Write(value: string);
var
  targetFile: TextFile;
begin
  AssignFile(targetFile, FCurrFileName);
  Append(targetFile);
  Writeln(targetFile, value);
  CloseFile(targetFile);
end;

procedure TLogWriter.Write(partList: TPartList);
var
  i: Integer;
  sCol: String;
begin
  sCol := FormatDateTime( 'yyyy/mm/dd, ', Now ) + FormatDateTime( 'hh:nn:ss', Now );
  for i := 0 to partList.Count - 1 do
  begin
    sCol := sCol + ', ' + IntToStr( BoolToInt( partList[ i ].GetPartState ) );
  end;
  Write( sCol );
end;

end.
