program dOPC_demo;

uses
  Vcl.Forms,
  Unit_main in 'Unit_main.pas' {Form_Main},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Cyan Dusk');
  Application.CreateForm(TForm_Main, Form_Main);
  Application.Run;
end.
