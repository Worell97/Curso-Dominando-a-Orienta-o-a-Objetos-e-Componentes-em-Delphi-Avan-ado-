program Project1;

uses
  Vcl.Forms,
  uFrameMain in 'uFrameMain.pas' {Form1},
  uServicos in 'uServicos.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
