unit Frame_ShutterViewUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, AdvPicture, StdCtrls, ExtCtrls, AdvSmoothButton, 
  Frame_RecipeTableUnit, Class_RecipeOperator, ComCtrls;

type
  TFrame_ShutterView = class(TFrame)
    Panel_Left: TPanel;
    Label_PartName: TLabel;
    AdvPicture_PartState: TAdvPicture;
    Label_State: TLabel;
    Panel_RightClient: TPanel;
    Panel_RightTop: TPanel;
    Panel_Table: TPanel;
    Button_Save: TAdvSmoothButton;
    Button_Load: TAdvSmoothButton;
    Button_Edit: TAdvSmoothButton;
    Button_Clear: TAdvSmoothButton;
    procedure AdvPicture_PartStateClick(Sender: TObject);
    procedure Button_ClearClick(Sender: TObject);
    procedure Button_EditClick(Sender: TObject);
    procedure Button_LoadClick(Sender: TObject);
    procedure Button_SaveClick(Sender: TObject);
  private
    FOnChangePartState: TPartActionEvent;
    FRecipeTable: TFrame_RecipeTable;
    FIndex: Integer;
    FState: Boolean;
    function GetRecipeFile: string;
    function GetState: Boolean;
    procedure SetRecipeFile(const Value: string);
    { Private declarations }
  public
    constructor Create(owner: TComponent);
    function GetRecipeData: TListItems;
    procedure InitRecipeTable;
    procedure Save(filePath: string); overload;
    procedure Save; overload;
    procedure SetPartName(partName: string);
    procedure SetState(const Value: Boolean);
    property Index: Integer read FIndex write FIndex;
    property RecipeFile: string read GetRecipeFile write SetRecipeFile;
    property State: Boolean read GetState write SetState;
    property OnChangePartState: TPartActionEvent read FOnChangePartState write
        FOnChangePartState;
    { Public declarations }
  end;

implementation

uses
  Form_RecipeEditorUnit, Form_OperationDialogUnit, Unit_Resources;

{$R *.dfm}

constructor TFrame_ShutterView.Create(owner: TComponent);
begin
  inherited;
  //Parent := owner as TWinControl;
  InitRecipeTable;
end;

procedure TFrame_ShutterView.AdvPicture_PartStateClick(Sender: TObject);
begin
  Form_OperationDialog.SetPartState( Label_PartName.Caption, State );
  
  if Form_OperationDialog.ShowModal <> mrCancel then
  begin
    if Assigned( OnChangePartState ) then
      FOnChangePartState( self, Index, Form_OperationDialog.GetValue );
  end;
end;

procedure TFrame_ShutterView.Button_ClearClick(Sender: TObject);
begin
  FRecipeTable.Clear;
end;

procedure TFrame_ShutterView.Button_EditClick(Sender: TObject);
begin
  Form_RecipeEditor.SetTargetName( Label_PartName.Caption );
  Form_RecipeEditor.SetRecipeTable( FRecipeTable );
  Form_RecipeEditor.ShowModal;
  FRecipeTable.Parent := Panel_Table;
end;

procedure TFrame_ShutterView.Button_LoadClick(Sender: TObject);
begin
  FRecipeTable.OpenXmlWithDialog;
end;

procedure TFrame_ShutterView.Button_SaveClick(Sender: TObject);
begin
  FRecipeTable.SaveXmlWithDialog;
end;

function TFrame_ShutterView.GetRecipeData: TListItems;
begin
  Result := FRecipeTable.GetRecipeData;
end;

function TFrame_ShutterView.GetRecipeFile: string;
begin
  Result := FRecipeTable.FilePath;
end;

function TFrame_ShutterView.GetState: Boolean;
begin
  Result := FState;
end;

procedure TFrame_ShutterView.InitRecipeTable;
begin
  FRecipeTable := TFrame_RecipeTable.Create( self );
  FRecipeTable.InitColumns( g_ShutterRecipeTableColumns );
  FRecipeTable.Parent := Panel_Table;
end;

procedure TFrame_ShutterView.Save(filePath: string);
begin
  // TODO -cMM: TFrame_ShutterView.Save default body inserted
  FRecipeTable.SaveXml( filePath );
end;

procedure TFrame_ShutterView.Save;
begin
  FRecipeTable.SaveXml;
end;

procedure TFrame_ShutterView.SetPartName(partName: string);
begin
  Label_PartName.Caption := partName;
end;

procedure TFrame_ShutterView.SetRecipeFile(const Value: string);
begin
  if Value = '' then exit;
  
  FRecipeTable.SetData( Value );
end;

procedure TFrame_ShutterView.SetState(const Value: Boolean);
begin
  FState := Value;

  if Value = true then
  begin
    AdvPicture_PartState.Picture := g_PicShutterOpen;
    Label_State.Caption := 'Open';
  end
  else
  begin
    AdvPicture_PartState.Picture := g_PicShutterClose;
    Label_State.Caption := 'Close';
  end;
end;

end.
