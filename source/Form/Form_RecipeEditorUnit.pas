unit Form_RecipeEditorUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvSmoothButton, ExtCtrls, StdCtrls, Frame_RecipeTableUnit;

type
  TForm_RecipeEditor = class(TForm)
    Label_PartName: TLabel;
    Label_FilePath: TLabel;
    Panel_RightTop: TPanel;
    Buttom_Save: TAdvSmoothButton;
    Button_Load: TAdvSmoothButton;
    Button_Clear: TAdvSmoothButton;
    Panel_Body: TPanel;
    Panel_Bottom: TPanel;
    Panel_Table: TPanel;
    Button_OK: TAdvSmoothButton;
    procedure Buttom_SaveClick(Sender: TObject);
    procedure Button_CancelClick(Sender: TObject);
    procedure Button_ClearClick(Sender: TObject);
    procedure Button_LoadClick(Sender: TObject);
    procedure Button_OKClick(Sender: TObject);
  private
    FRecipeTable: TFrame_RecipeTable;
    { Private declarations }
  public
    procedure SetRecipeTable(recipeTable: TFrame_RecipeTable);
    procedure SetTargetName(partName: string);
    { Public declarations }
  end;

var
  Form_RecipeEditor: TForm_RecipeEditor;

implementation

{$R *.dfm}

procedure TForm_RecipeEditor.Buttom_SaveClick(Sender: TObject);
begin
  FRecipeTable.SaveXmlWithDialog;
end;

procedure TForm_RecipeEditor.Button_CancelClick(Sender: TObject);
begin
  self.ModalResult := mrCancel;
  self.CloseModal;
end;

procedure TForm_RecipeEditor.Button_ClearClick(Sender: TObject);
begin
  FRecipeTable.Clear;
end;

procedure TForm_RecipeEditor.Button_LoadClick(Sender: TObject);
begin
  FRecipeTable.OpenXmlWithDialog;
end;

procedure TForm_RecipeEditor.Button_OKClick(Sender: TObject);
begin
  self.ModalResult := mrOk;
  self.CloseModal;
end;

procedure TForm_RecipeEditor.SetRecipeTable(recipeTable: TFrame_RecipeTable);
begin
  FRecipeTable := recipeTable;
  FRecipeTable.Parent := Panel_Table;

  if Panel_Table.ControlCount > 0 then
  begin
    self.Panel_Table.RemoveControl( Panel_Table.Controls[ 0 ] );
  end;
  
  self.Panel_Table.InsertControl( FRecipeTable );
  Label_FilePath.Caption := FRecipeTable.FilePath;
end;

procedure TForm_RecipeEditor.SetTargetName(partName: string);
begin
  Label_PartName.Caption := partName;
end;

end.
