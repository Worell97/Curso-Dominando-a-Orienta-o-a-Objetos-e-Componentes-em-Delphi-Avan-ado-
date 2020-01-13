unit uModel;

interface

type
  TEndereco = class
  private
    FLogradouro: string;
    FBairro: string;
    FCEP: String;
    FCidade: string;
    procedure SetBairro(const Value: string);
    procedure SetCEP(const Value: String);
    procedure SetCidade(const Value: string);
    procedure SetLogradouro(const Value: string);
  published
		property Logradouro : string read FLogradouro write SetLogradouro;
    property Bairro : string read FBairro write SetBairro;
    property Cidade : string read FCidade write SetCidade;
    property CEP : String read FCEP write SetCEP;
  end;


	TPessoa = class
  private
    FNome: string;
    FEndereco: TEndereco;
    procedure SetNome(const Value: string);
    procedure SetEndereco(const Value: TEndereco);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
  property Nome : string read FNome write SetNome;
  property Endereco : TEndereco read FEndereco write SetEndereco;

  end;

  TPessoaFisica = class(TPessoa)
  private
    FCPF: string;
    procedure SetCPF(const Value: string);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
  property CPF : string read FCPF write SetCPF;
  end;

  TCliete = class(TPessoaFisica)
  private
		FSaldo: Double;
		FLimiteCredito: Integer;
		procedure SetSaldo(const Value: Double);
		procedure SetLimiteCredito(val: Integer);
		{ private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
		property Saldo: Double read FSaldo write SetSaldo;
		property LimiteCredito: Double read FLimiteCredito write SetLimiteCredito;
	end;

  TPessoaJuridica = class(TPessoa)
  private
    FCNPJ: string;
    procedure SetCNPJ(const Value: string);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
  property CNPJ:string read FCNPJ write SetCNPJ;
  end;

	TFornecedor = class(TPessoaJuridica)
  private
    FPrazoentrega: Integer;
    procedure SetPrazoentrega(const Value: Integer);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }

  property Prazoentrega:Integer read FPrazoentrega write SetPrazoentrega;
  end;



implementation

{ TPessoa }

procedure TPessoa.SetEndereco(const Value: TEndereco);
begin
  FEndereco := Value;
end;

procedure TPessoa.SetNome(const Value: string);
begin
  FNome := Value;
end;

{ TPessoaFisica }

procedure TPessoaFisica.SetCPF(const Value: string);
begin
  FCPF := Value;
end;

{ TCliete }

procedure TCliete.SetSaldo(const Value: Double);
begin
  FSaldo := Value;
end;

{ TPessoaJuridica }

procedure TPessoaJuridica.SetCNPJ(const Value: string);
begin
  FCNPJ := Value;
end;

{ TFornecedor }

procedure TFornecedor.SetPrazoentrega(const Value: Integer);
begin
  FPrazoentrega := Value;
end;

{ TEndereco }

procedure TEndereco.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TEndereco.SetCEP(const Value: String);
begin
  FCEP := Value;
end;

procedure TEndereco.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TEndereco.SetLogradouro(const Value: string);
begin
  FLogradouro := Value;
end;

procedure TCliete.SetLimiteCredito(val: Integer);
begin
end;

end.
