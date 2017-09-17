//-----------------------------------------------------------------+
// Global Function
// 파일이나 문자열 처리시에 간편하게 쓰고자 만든 함수들의 모음.
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
// 텍스트 파일의 기존 내용에 새로이 추가 해 준다.
// 만약 지정한 경로에 파일이 없을 경우 새로 생성 한다.
// filePath: 내용을 추가 할 텍스트 파일의 경로.
// msg: 추가할 내용.
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
// 지정한 경로에 텍스트 파일을 만든다.
// 만약 그 경로에 해당되는 부모 폴더가 없다면 스스로 만든다.
// filePath: 텍스트 파일을 만들 경로.
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
// 설정한 경로의 폴더를 만든다.
// 만약 상위 폴더가 없다면 그것도 함께 만든다. (재귀 호출 사용)
// directory: 폴더를 만들 경로./
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
// 지정한 경로를 통해 부모 폴더의 경로를 얻는다.
// Directory: 부모 폴더의 경로를 얻고 싶은 전체 경로.
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
// 입력한 문자열을 지정한 문자를 기준으로 쪼개어 준다.
// Delimiter: 쪼갤 기준이 될 문자.
// Input: 쪼갤 대상 문자열.
//     출처 : http://delphi.about.com/cs/adptips2002/a/bltip1102_5.htm
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
    Assert(False, 'StrFind()::String['+IntToStr(Index)+'] Index 오류');
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
