unit Class_XmlReadWriter;


interface
uses
  XMLDoc, xmldom, ComCtrls, Classes, XMLIntf;

type
  TXmlReader = class(TObject)
  private
    xmlDoc: TXMLDocument;
    nodeList: IDOMNodeList;
    FCurrCount: Integer;
    FListColumns: TListColumns;
    FListItems: TListItems;
  public
    constructor Create(filePath: string); overload;
    constructor Create; overload;
    destructor Destroy; override;
    function ColumnCount: Integer;
    procedure ConvertToListItems;
    function GetFieldValue(childIndex: Integer): string;
    function GetColumns: TStrings;
    function HasNext: boolean;
    procedure MoveFirst;
    function MoveNext: boolean;
    procedure Read(filePath: string);
    function SetParentNodePosition(tagName: string): Boolean;
    property Items: TListItems read FListItems;
    property ListColumns: TListColumns read FListColumns;
  end;

  TXmlWriter = class(TObject)
  private
    xmlDoc: TXMLDocument;
    rootNode: IXMLNode;
  public
    constructor Create;
    procedure SetData(listCols: TListColumns; listItems: TListItems);
    procedure SetRootNode(nodeName: string);
    procedure Write(filePath: string);
  end;

implementation

uses
  SysUtils;

constructor TXmlReader.Create(filePath: string);
begin
  Create;
  Read( filePath );
end;

constructor TXmlReader.Create;
begin
  inherited;
  xmlDoc := TXMLDocument.Create( nil );
  FListColumns := TListColumns.Create( nil );
  FListItems := TListItems.Create( nil );

  FCurrCount := 0;
end;

destructor TXmlReader.Destroy;
begin
  inherited;
  xmlDoc.Free;
//  FListColumns.Free;
//  FListItems.Free;
end;

function TXmlReader.ColumnCount: Integer;
begin
  Result := nodeList[ 0 ].childNodes[ FCurrCount ].childNodes.length;
end;

procedure TXmlReader.ConvertToListItems;
begin
  // TODO -cMM: TXmlReader.ConvertToListItems default body inserted
end;

function TXmlReader.GetFieldValue(childIndex: Integer): string;
var
  sRet: String;
begin
  sRet := nodeList[ 0 ].childNodes[ FCurrCount ].childNodes[ childIndex ].childNodes[ 0 ].nodeValue;
  Result := sRet;
end;

function TXmlReader.GetColumns: TStrings;
var
  strings: TStrings;
  iCol: Integer;
begin
  strings := TStringList.Create;
  for iCol := 0 to ColumnCount - 1 do
  begin
    strings.Append( nodeList[ 0 ].childNodes[ FCurrCount ].childNodes[ iCol ].nodeName )
  end;
  Result := strings;
end;

function TXmlReader.HasNext: boolean;
begin
  if FCurrCount = nodeList[ 0 ].childNodes.length then
  begin
    Result := false;
  end
  else
  begin
    Result := true;
  end;
end;

procedure TXmlReader.MoveFirst;
begin
  FCurrCount := 0;
end;

function TXmlReader.MoveNext: boolean;
var
  bRet: Boolean;
begin
  bRet := HasNext;
  if bRet = true then
  begin
    FCurrCount := FCurrCount + 1;
  end;
  Result := bRet;
end;

procedure TXmlReader.Read(filePath: string);
begin
  if FileExists( filePath ) = false then
  begin
    raise EInOutError.Create( 'File not found : ' + filePath);
  end
  else
  begin
    xmlDoc.LoadFromFile( filePath );
  end;
end;

function TXmlReader.SetParentNodePosition(tagName: string): Boolean;
begin
  nodeList := xmlDoc.DOMDocument.getElementsByTagName( tagName );
  if ( nodeList = nil ) or ( nodeList.length = 0 ) then
  begin
    Result := false;
  end
  else
  begin
    Result := true;
  end;
end;

constructor TXmlWriter.Create;
begin
  xmlDoc := TXMLDocument.Create( nil );
  xmlDoc.Active := true;
  xmlDoc.Encoding := 'UTF-8';
end;

procedure TXmlWriter.SetData(listCols: TListColumns; listItems: TListItems);
var
  rCnt: Integer;
  rowNode: IXMLNode;
  rowSubNode: IXMLNode;
  colNode: IXMLNode;
  cCnt: Integer;
begin
  //if xmlDoc.ChildNodes.Count > 0 then xmlDoc.ChildNodes[ 0 ].ChildNodes.Clear;

  for rCnt := 0 to listItems.Count - 2 do
  begin
    rowNode := rootNode.AddChild( 'row' );

    for cCnt := 0 to listCols.Count - 2 do
    begin
      rowSubNode := rowNode.AddChild( listCols[ cCnt + 1 ].Caption );
      rowSubNode.Text := listItems[ rCnt ].SubItems[ cCnt ];
    end;
  end;
end;

procedure TXmlWriter.SetRootNode(nodeName: string);
begin
//  if xmlDoc.ChildNodes.Count > 0 then
//  begin
//    xmlDoc.ChildNodes.Clear;
//  end;
//
  
  rootNode := xmlDoc.AddChild( nodeName );
end;

procedure TXmlWriter.Write(filePath: string);
begin
  xmlDoc.SaveToFile( filePath );
end;

end.



//constructor TQueryReader.Create(dbType, product: String);
//var
//  xmldoc: TXMLDocument;
//  nodeList: IDOMNodeList;
//  sID: String;
//  i: Integer;
//begin
//  try
//    xmldoc := TXMLDocument.Create( nil );
//    xmldoc.LoadFromFile( GetCurrentDir + XML_FILE_PATH );
//    nodeList := xmldoc.DOMDocument.getElementsByTagName( 'product' );
//    sID := dbType + '.' + product;
//
//    for i := 0 to nodeList.length - 1 do
//    begin
//      if nodeList.item[ i ].attributes.getNamedItem( 'id' ).nodeValue = sID then
//      begin
//        xmlBaseData := nodeList.item[ i ].childNodes;
//        exit;
//      end;
//    end;
//    raise Exception.Create( 'Not exists data about DBType & Product.' );
//  except
//    on e: Exception
//    do raise Exception.Create( 'Can not found file: ' + XML_FILE_PATH );
//  end;
//end;
