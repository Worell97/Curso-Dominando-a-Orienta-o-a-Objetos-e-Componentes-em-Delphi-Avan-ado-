unit uModel;

interface

type
	TUsuario = class
  private
    class var FInstance : TUsuario;
    constructor CreatePrivate();
  public
    constructor Create();
  	class function GetInstance:TUsuario;
	end;

	TConexao = class
	strict private
		class var FInstance: TConexao;
		constructor Create;
	public
		class function GetInstance: TConexao;
	end;

implementation

uses
	System.SysUtils;

{ TUsuario }

constructor TUsuario.Create();
begin
 	raise Exception.Create('Para obter uma instância de TUsuario  utilize a função TUsuario.GetInstance.');
end;

constructor TUsuario.CreatePrivate;
begin

end;

class function TUsuario.GetInstance: TUsuario;
begin
	if not(Assigned(FInstance)) then
   	FInstance := TUsuario.CreatePrivate;

  Result := FInstance;
end;

constructor TConexao.Create;
begin
	inherited;
end;

class function TConexao.GetInstance: TConexao;
begin
	If FInstance = nil Then
	begin
		FInstance := TConexao.Create();
	end;
	Result := FInstance;
end;

end.
