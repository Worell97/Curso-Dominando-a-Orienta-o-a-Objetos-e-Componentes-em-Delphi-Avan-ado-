unit EditNumber;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls;

type
  TEditNumber = class(TEdit)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure KeyPress(var Key: Char); override;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('ComponenteOW', [TEditNumber]);
end;

{ TEditNumber }

procedure TEditNumber.KeyPress(var Key: Char);
begin
	if not CharInSet(Key, [#48..#57, #13, #27, #9]) then
  begin
  	raise Exception.Create('Caracter Inválido, Apenas numeros');
  end;

  inherited;
end;

end.
