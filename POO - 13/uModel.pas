unit uModel;

interface

type

	TPessoa = class
  private
    FEmail: string;
    FNome: String;
    procedure SetEmail(const Value: string);
    procedure SetNome(const Value: String);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    property Nome : String read FNome write SetNome;
    property Email : string read FEmail write SetEmail;
  end;

  TPessoaFisica = class(TPessoa)
  private
    FCPF: String;
    procedure SetCPF(const Value: String);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }

    property CPF : String read FCPF write SetCPF;
  end;

implementation

{ TPessoa }

procedure TPessoa.SetEmail(const Value: string);
begin
  FEmail := Value;
end;

procedure TPessoa.SetNome(const Value: String);
begin
  FNome := Value;
end;

{ TPessoaFisica }

procedure TPessoaFisica.SetCPF(const Value: String);
begin
  FCPF := Value;
end;

end.
