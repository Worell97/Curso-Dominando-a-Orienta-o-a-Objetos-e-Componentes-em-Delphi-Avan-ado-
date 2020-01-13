﻿unit Principal;

interface

uses
  Winapi.Windows, produto, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    EdCodigo: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EdNome: TEdit;
    Label3: TLabel;
    BitBtn2: TBitBtn;
    EdQtde: TEdit;
    Label4: TLabel;
    EdVlr: TEdit;
    Label5: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

var
	Pedido : TPedido;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  ind: Integer;
begin
	if Trim(EdCodigo.Text) <> '' then
	begin
		ind:= StrToInt(EdCodigo.Text) - 1;
    EdNome.Text := Pedido.Itens[ind].Produto.Nome;
    EdQtde.Text := IntToStr(Pedido.Itens[ind].Qtde);
    EdVlr.Text := FloatToStr(Pedido.Itens[ind].Valor);
	end;


end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var
	Item : TItem;
  Prod : TProduto;
begin
	Prod := TProduto.Create;
  Prod.Codigo := StrToInt(EdCodigo.Text);
  Prod.Nome := EdNome.Text;

  Item := TItem.Create;
  Item.Produto := Prod;
  Item.Qtde := StrToInt(EdQtde.Text);
  Item.Valor := StrToInt(EdVlr.Text);

  Pedido.Add(Item);

  Label5.Caption := FormatFloat('#,##0.00', Pedido.Total);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Pedido.Destroy;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
	Pedido := TPedido.Create;
end;

end.
