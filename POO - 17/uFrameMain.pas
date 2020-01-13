unit uFrameMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, uServicos;

type
  TForm1 = class(TForm)
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  	Servico : TServicos;
    { Private declarations }
  public
    { Public declarations }
    procedure CarregaValor;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  CarregaValor;
  LabeledEdit3.Text := FloatToStr(Servico.Somar);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  CarregaValor;
  LabeledEdit3.Text := FloatToStr(Servico.Dividir);
end;

procedure TForm1.CarregaValor;
begin
	if LabeledEdit1.Text <> '' then
  begin
		Servico.Valor1 := StrToFloat(LabeledEdit1.Text);
  end
	else
  begin
  	ShowMessage('Informe um valor para o primeiro campo');
  end;

 	if LabeledEdit2.Text <> '' then
  begin
		Servico.Valor2 := StrToFloat(LabeledEdit2.Text);
  end
	else
  begin
  	ShowMessage('Informe um valor para o segundo campo');
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
	Servico := TServicos.Create;
end;

end.
