program ShutterTest;
{
 begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm_Main, Form_Main);
  Application.CreateForm(TForm_OperationDialog, Form_OperationDialog);
  Application.CreateForm(TForm_InputDialog, Form_InputDialog);
  Application.CreateForm(TForm_RecipeEditor, Form_RecipeEditor);
  Application.Run;
end.
}
uses
  ExceptionLog,
  Forms,
  Form_MainUnit in '..\form\Form_MainUnit.pas' {Form_Main},
  Form_OperationDialogUnit in '..\Form\Form_OperationDialogUnit.pas' {Form_OperationDialog},
  Form_InputDialogUnit in '..\Form\Form_InputDialogUnit.pas' {Form_InputDialog},
  Form_RecipeEditorUnit in '..\Form\Form_RecipeEditorUnit.pas' {Form_RecipeEditor},
  Frame_ShutterViewUnit in '..\Frame\Frame_ShutterViewUnit.pas' {Frame_ShutterView: TFrame},
  Frame_RecipeTableUnit in '..\Frame\Frame_RecipeTableUnit.pas' {Frame_RecipeTable: TFrame},
  Frame_ShutterViewGroupUnit in '..\Frame\Frame_ShutterViewGroupUnit.pas' {Frame_ShutterViewGroup: TFrame},
  Frame_MainBottomUnit in '..\Frame\Frame_MainBottomUnit.pas' {Frame4: TFrame},
  I7000 in '..\Driver\I7000.PAS',
  Class_Driver_I7000 in '..\Driver\Class_Driver_I7000.pas',
  Class_Part in '..\Class\Class_Part.pas',
  Class_PartList in '..\Class\Class_PartList.pas',
  Class_XmlReadWriter in '..\Class\Class_XmlReadWriter.pas',
  Class_RecipeOperator in '..\Class\Class_RecipeOperator.pas',
  Class_RecipeTable in '..\Class\Class_RecipeTable.pas',
  Class_RecipeRow in '..\Class\Class_RecipeRow.pas',
  Unit_Resources in '..\Global\Unit_Resources.pas',
  Unit_GlobalFunction in '..\Global\Unit_GlobalFunction.pas',
  Class_LogWriter in '..\Class\Class_LogWriter.pas',
  Frame_CaptureOptionUnit in '..\Frame\Frame_CaptureOptionUnit.pas' {Frame_CaptureOption: TFrame},
  Class_ImageCapture in '..\Class\Class_ImageCapture.pas',
  Form_CaptureHoleUnit in '..\Form\Form_CaptureHoleUnit.pas' {Form_CaptureHole},
  pngextra in '..\pngimage\pngextra.pas',
  pngimage in '..\pngimage\pngimage.pas',
  pnglang in '..\pngimage\pnglang.pas',
  zlibpas in '..\pngimage\zlibpas.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm_Main, Form_Main);
  Application.CreateForm(TForm_OperationDialog, Form_OperationDialog);
  Application.CreateForm(TForm_InputDialog, Form_InputDialog);
  Application.CreateForm(TForm_RecipeEditor, Form_RecipeEditor);
  Application.CreateForm(TForm_CaptureHole, Form_CaptureHole);
  Application.Run;
end.
