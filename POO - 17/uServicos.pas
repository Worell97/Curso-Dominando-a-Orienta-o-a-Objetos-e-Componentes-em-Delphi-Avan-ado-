unit uServicos;

interface

uses
	System.SysUtils, Vcl.Dialogs;
type
	TServicos = class
  strict private
    FValor1: Double;
    FValor2: Double;
    procedure SetValor1(const Value: Double);
    procedure SetValor2(const Value: Double);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    function Somar:Double;
    function Dividir:Double;

    property Valor1 : Double read FValor1 write SetValor1;
    property Valor2 : Double read FValor2 write SetValor2;
  end;

implementation

{ TServicos }

function TServicos.Dividir: Double;
begin
	Result := 0;
	try
		Result := (FValor1 / FValor2);
  except
    on e: EZeroDivide do
    	Showmessage('Divisão por Zero');
  end;
end;

procedure TServicos.SetValor1(const Value: Double);
begin
  FValor1 := Value;
end;

procedure TServicos.SetValor2(const Value: Double);
begin
  FValor2 := Value;
end;

function TServicos.Somar: Double;
begin
  REsult := FValor1 + FValor2;
end;

end.
