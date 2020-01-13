﻿unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  classe, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
var
	obj: TPessoaFisica;
begin
	obj := TPessoaFisica.Create(Self);
  obj.Usuario := 'devmedia';
  obj.Nome := 'teste';
  obj.PronunciarIdioma;
  obj.PronunciarIdioma('Ingles');
  obj.PronunciarIdioma('Espanhol', 3);
	ShowMessage(obj.Nome);
  obj.Free;
end;

end.
