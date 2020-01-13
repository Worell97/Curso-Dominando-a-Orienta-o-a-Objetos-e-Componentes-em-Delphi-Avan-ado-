unit UCliente;

interface

uses
  Vcl.Dialogs;

type

	TCliente = class
  private
    FEmails: String;
    FNome: String;
    procedure SetEmail(const Value: String);
    procedure SetNome(const Value: String);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    class procedure falar;

    property Nome: String read FNome write SetNome;
    property Email: String read FEmails write SetEmail;

  end;

implementation

{ TCliete }

class procedure TCliente.falar;
begin
	Showmessage('Pessoa falando!');
end;

procedure TCliente.SetEmail(const Value: String);
begin

end;

procedure TCliente.SetNome(const Value: String);
begin

end;

end.
