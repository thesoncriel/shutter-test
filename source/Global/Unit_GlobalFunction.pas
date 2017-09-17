//-----------------------------------------------------------------+
// Global Function
// �����̳� ���ڿ� ó���ÿ� �����ϰ� ������ ���� �Լ����� ����.
//-----------------------------------------------------------------+
unit Unit_GlobalFunction;

interface

uses
  Classes, SysUtils, iniFiles, DB, Variants;
  {Global Function}
  function CreateTextFile(filePath: string): Boolean;
  procedure TextFileAppend(filePath, msg: String);
  function CreateAllDir(directory: String): Boolean;
  function GetParentDir(const Directory: String): String;
  function StringSplit(const Delimiter: Char; Input: string): TStrings;
  function CopyFile(oldFile, newFile: String): Boolean;
  function MoveFile(oldFile, newFile: String): Boolean;

function GetDataFromIniFile(filePath, section: string; keyValue: array of String):
    TStringList; overload;

  function GetDataFromIniFile(filePath, section: string; sKey: String ): string;
    overload;

  function StrFind(const S: String; Sub: Char; var Index: Integer): String;

function BoolToInt(value: Boolean): Integer;

implementation

uses
  Windows;

{Global Function}

//-----------------------------------------------------------------+
// �ؽ�Ʈ ������ ���� ���뿡 ������ �߰� �� �ش�.
// ���� ������ ��ο� ������ ���� ��� ���� ���� �Ѵ�.
// filePath: ������ �߰� �� �ؽ�Ʈ ������ ���.
// msg: �߰��� ����.
//-----------------------------------------------------------------+
procedure TextFileAppend(filePath, msg: String);
var
  targetFile: TextFile;
begin
  CreateTextFile(filePath);
  AssignFile(targetFile, filePath);
  Append(targetFile);
  Writeln(targetFile, msg);
  CloseFile(targetFile);
end;

//-----------------------------------------------------------------+
// ������ ��ο� �ؽ�Ʈ ������ �����.
// ���� �� ��ο� �ش�Ǵ� �θ� ������ ���ٸ� ������ �����.
// filePath: �ؽ�Ʈ ������ ���� ���.
//-----------------------------------------------------------------+
function CreateTextFile(filePath: string): Boolean;
var
  iFileHandlerId: Integer;
begin
  try
    //CreateAllDir(GetParentDir(filePath));
    if FileExists(filePath) = false then
    begin
      iFileHandlerId := FileCreate(filePath);
      SysUtils.FileClose(iFileHandlerId);
    end;
    result := true;
  except
    result := false;
  end;
end;

//-----------------------------------------------------------------+
// ������ ����� ������ �����.
// ���� ���� ������ ���ٸ� �װ͵� �Բ� �����. (��� ȣ�� ���)
// directory: ������ ���� ���./
//-----------------------------------------------------------------+
function CreateAllDir(directory: String): Boolean;
var
  targetFile: TextFile;
  parentPath: String;
  iFileHandlerId: Integer;
begin
  parentPath := GetParentDir(directory);
  try
    if DirectoryExists(parentPath) = false then
    begin
      CreateAllDir(parentPath);
    end;
    CreateDir(directory);
    result := true;
  except
    result := false;
  end;
end;

//-----------------------------------------------------------------+
// ������ ��θ� ���� �θ� ������ ��θ� ��´�.
// Directory: �θ� ������ ��θ� ��� ���� ��ü ���.
//-----------------------------------------------------------------+
function GetParentDir(const Directory: String): String;
var
  TempStr: String;
begin
  TempStr := Directory;
  if (TempStr[Length(Result)] = '\') then
  begin
  Delete(TempStr, Length(TempStr), 1);
  end;
  Result := Copy(TempStr, 1, LastDelimiter('\', TempStr) - 1);
end;

//-----------------------------------------------------------------+
// �Է��� ���ڿ��� ������ ���ڸ� �������� �ɰ��� �ش�.
// Delimiter: �ɰ� ������ �� ����.
// Input: �ɰ� ��� ���ڿ�.
//     ��ó : http://delphi.about.com/cs/adptips2002/a/bltip1102_5.htm
//-----------------------------------------------------------------+
function StringSplit(const Delimiter: Char; Input: string): TStrings;
var
  Strings: TStrings;
begin
  Strings := TStrings.Create;
  //Assert(Assigned(Strings));
  //Strings.Clear;
  Strings.Delimiter := Delimiter;
  Strings.DelimitedText := Input;
  result := @Strings;
end;


function CopyFile(oldFile, newFile: String): Boolean;
begin
  Windows.CopyFile(PChar(oldFile), PChar(newFile), true);
end;

function MoveFile(oldFile, newFile: String): Boolean;
begin
  Windows.MoveFile(PChar(oldFile), PChar(newFile));
end;

function GetDataFromIniFile(filePath, section: string; keyValue: array of String):
    TStringList;
var
  sList: TStringList;
  iniFile: TIniFile;
  i: Integer;
  iLength: Integer;
begin
  sList := TStringList.Create;
  iniFile := TIniFile.Create( filePath );
  iLength := High(KeyValue);
  for i := 0 to iLength do
  begin
    sList.Add( iniFile.ReadString( section, keyValue[ i ], '' ) );
  end;
  iniFile.Free;
  result := sList;

end;

function GetDataFromIniFile(filePath, section: string; sKey: String ): string;
    overload;
var
  sValue : string;
  iniFile: TIniFile;
begin
  Result := '';

  try
    iniFile := TIniFile.Create( filePath );
    sValue := iniFile.ReadString( section, sKey, '' );
    iniFile.Free;
  finally
    result := sValue;
  end;
end;

function StrFind(const S: String; Sub: Char; var Index: Integer): String;
var
  i, len: Integer;
begin
  Result := '';
  len := Length(S);
  if (Index < 1) or (index > len) then
  begin
    Assert(False, 'StrFind()::String['+IntToStr(Index)+'] Index ����');
    Exit;
  end;

  for i:=index to len do
  begin
    if s[i] = Sub then
    begin
      Result := Copy(S, Index, i-Index);
      Index := i+1;
      Exit;
    end;
  end;

  Result := Copy(S, Index, len-Index+1);
  Index := len+1;
end;

function BoolToInt(value: Boolean): Integer;
begin
  if value = true then
    Result := 1
  else
    Result := 0;
end;



end.
