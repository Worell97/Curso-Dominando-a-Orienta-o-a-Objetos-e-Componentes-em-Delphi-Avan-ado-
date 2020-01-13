﻿unit produto;

interface

uses
	Classes;
type
	TProduto = class
    private
    FCodigo: Integer;
    FNome: string;

    public
    	property Codigo: Integer read FCodigo write FCodigo;
      property Nome: string read FNome write FNome;

      constructor Create();
  end;

  TItem = class
	  private
  	  FProduto: TProduto;
      FValor: Double;
      FQtde: Integer;
    public
    	property Produto: TProduto read FProduto write FProduto;
      property Qtde: Integer read FQtde write FQtde;
      property Valor: Double read FValor write FValor;
  end;

  TPedido = class
	  private
      FLista : TList;
    	function GetCount: Integer;
	    function GetTotal: Double; virtual;

    protected
			function GetItem(AIndex : Integer): TItem; virtual;
      procedure SetItem(AIndex: Integer; AItem: TItem); virtual;

  	public
    	property Total: Double read GetTotal;
      property Itens[index : Integer]: TItem read GetItem write SetItem;
      property Count : Integer read GetCount;

      procedure Add(AItem :  TItem);
      constructor Create();
      destructor Destroy; override;
  end;


implementation

{ TProduto }

constructor TProduto.Create();
begin
  inherited Create;
  FCodigo := 0;
  FNome := 'Default';
end;

{ TPedido }

procedure TPedido.Add(AItem: TItem);
begin
	FLista.Add(AItem);
end;

constructor TPedido.Create;
begin
	inherited Create;

  FLista:= TList.Create;
end;

destructor TPedido.Destroy;
var
	i: Integer;
begin
	for I := Count downto 0 do
  begin
    TItem(FLista[I]).Free;
    FLista[I] := nil;
  end;
  FLista.Free;

  inherited;
end;

function TPedido.GetCount: Integer;
begin
	Result := FLista.Count - 1;
end;

function TPedido.GetItem(AIndex: Integer): TItem;
begin
	if AIndex <= FLista.Count - 1 then
  	result := TItem(FLista[AIndex])
  else
  	Result := nil;

end;

function TPedido.GetTotal: Double;
var
	I : Integer;
begin
	Result := 0;
  for I := 0 to Count do
    Result := Result + (Itens[I].Valor * Itens[I].Qtde);
end;

procedure TPedido.SetItem(AIndex: Integer; AItem: TItem);
begin
	if AIndex <= FLista.Count - 1 then
  	FLista[AIndex] := AItem;

end;

end.
