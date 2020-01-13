unit uModelHelper;

interface

uses
	uModel, Vcl.Dialogs;
type

	TPessoaHelper = class helper for TPessoa
  private

    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    function GetDados:string;
  published
    { published declarations }
  end;

implementation

{ TPessoaHelper }

{ TPessoaHelper }

function TPessoaHelper.GetDados: string;
begin
	ShowMessage('Nome: '+Self.Nome+' Email: '+Self.Email);
end;

end.
