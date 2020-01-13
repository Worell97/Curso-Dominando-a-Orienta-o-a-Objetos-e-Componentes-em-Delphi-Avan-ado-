unit EditValidator;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, System.Math;

type
  ECaracterInvalido = class(Exception);
  EInvalidCPF = class(Exception);
  EInvalidCNPJ = class(Exception);
  EInvalidCEP = class(Exception);
  EInvalidTitulo = class(Exception);
  EInvalidTelefone = class(Exception);
  EInvalidRG = class(Exception);

  TEditType = (etCNPJ, etCPF, etCEP, etTelefone, etTitulo, etRG);

  TEditValidator = class(TEdit)
  private
    FEditType: TEditType;
    FInputMask: Boolean;
    FValidate: Boolean;
    procedure SetEditType(const Value: TEditType);
    procedure SetInputMask(const Value: Boolean);
    procedure SetValidate(const Value: Boolean);
    { Private declarations }
  protected
    { Protected declarations }
    function DoValidate : Boolean; virtual;
    function ValidateCNPJ: Boolean;virtual;
    function ValidateCPF: Boolean;virtual;
    procedure DoExit;override;
  public
    { Public declarations }
    procedure Mascarar; virtual;
    procedure KeyPress(var Key : Char);override;
  published
    { Published declarations }
    property EditType : TEditType read FEditType write SetEditType default etCNPJ;
    property InputMask : Boolean read FInputMask write SetInputMask;
    property Validate: Boolean read FValidate write SetValidate;
  end;

procedure Register;

implementation

uses
	System.MaskUtils;

const
	mskCNPJ = '##.###.#00/0000.00;0;_';
  mskCPF = '###.##0.000-00;0;_';
  mskCEP = '00000-000;0;_';
  mskTelefone = '(##) 000-0000;0;_';
  mskTitulo = '###.##0.00-00;0;_';
  mskRG = '##.##0.000-0;0;_';


procedure Register;
begin
  RegisterComponents('componenteOW', [TEditValidator]);
end;

{ TEditValidator }

procedure TEditValidator.KeyPress(var Key: Char);
begin
	if not(CharInSet(Key, [#48..#57, #9, #13, #27])) then
  begin
    raise ECaracterInvalido.Create('Caractere inválido');
  end;

  inherited;

end;

procedure TEditValidator.Mascarar;
begin
	case FEditType of
    etCNPJ: 					Text := FormatMaskText(mskCNPJ, Text);
    etCPF: 						Text := FormatMaskText(mskCPF, Text);
    etCEP: 						Text := FormatMaskText(mskCEP, Text);
    etTelefone: 			Text := FormatMaskText(mskTelefone, Text);
    etTitulo: 				Text := FormatMaskText(mskTitulo, Text);
    etRG: 						Text := FormatMaskText(mskRG, Text);
  end;
end;

procedure TEditValidator.SetEditType(const Value: TEditType);
begin
  FEditType := Value;
end;

procedure TEditValidator.SetInputMask(const Value: Boolean);
begin
  FInputMask := Value;
end;

procedure TEditValidator.SetValidate(const Value: Boolean);
begin
  FValidate := Value;
end;

procedure TEditValidator.DoExit;
begin
	if Validate then
  	if not(DoValidate) then
    begin
  		case EditType of
      	etCNPJ: 		raise EInvalidCNPJ.Create('CNPJ inválido!');
        etCPF: 			raise EInvalidCPF.Create('CPF inválido!');
        etCEP: 			raise EInvalidCEP.Create('CEP inválido!');
        etTelefone: raise EInvalidTelefone.Create('Telefone inválido!');
        etTitulo: 	raise EInvalidTitulo.Create('Titulo de eleitor inválido!');
        etRG: 			raise EInvalidRG.Create('RG inválido!');
      end;
    end;

  if InputMask then
  	Mascarar;

  inherited;
end;

function TEditValidator.DoValidate: Boolean;
begin
	case FEditType of
    etCNPJ: Result := ValidateCNPJ;
    etCPF: Result := ValidateCPF;
//    etCEP: ;
//    etTelefone: ;
//    etTituloEleitor: ;
//    etRG: ;
  else
		Result := False;
  end;
end;

function TEditValidator.ValidateCNPJ: Boolean;
var
  v: array[1..2] of Word;
  cnpj: array[1..14] of Byte;
  I: Byte;
begin
  try
    for I := 1 to 14 do
      cnpj[i] := StrToInt(Text[i]);
    //Nota: Calcula o primeiro dígito de verificação.
    v[1] := 5*cnpj[1] + 4*cnpj[2]  + 3*cnpj[3]  + 2*cnpj[4];
    v[1] := v[1] + 9*cnpj[5] + 8*cnpj[6]  + 7*cnpj[7]  + 6*cnpj[8];
    v[1] := v[1] + 5*cnpj[9] + 4*cnpj[10] + 3*cnpj[11] + 2*cnpj[12];
    v[1] := 11 - v[1] mod 11;
    v[1] := IfThen(v[1] >= 10, 0, v[1]);
    //Nota: Calcula o segundo dígito de verificação.
    v[2] := 6*cnpj[1] + 5*cnpj[2]  + 4*cnpj[3]  + 3*cnpj[4];
    v[2] := v[2] + 2*cnpj[5] + 9*cnpj[6]  + 8*cnpj[7]  + 7*cnpj[8];
    v[2] := v[2] + 6*cnpj[9] + 5*cnpj[10] + 4*cnpj[11] + 3*cnpj[12];
    v[2] := v[2] + 2*v[1];
    v[2] := 11 - v[2] mod 11;
    v[2] := IfThen(v[2] >= 10, 0, v[2]);
    //Nota: Verdadeiro se os dígitos de verificação são os esperados.
    Result := ((v[1] = cnpj[13]) and (v[2] = cnpj[14]));
  except on E: Exception do
    Result := False;
  end;
end;

function TEditValidator.ValidateCPF: Boolean;
var
  v: array[0..1] of Word;
  cpf: array[0..10] of Byte;
  I: Byte;
begin
  try
    for I := 1 to 11 do
      cpf[i-1] := StrToInt(Text[i]);
    //Nota: Calcula o primeiro dígito de verificação.
    v[0] := 10*cpf[0] + 9*cpf[1] + 8*cpf[2];
    v[0] := v[0] + 7*cpf[3] + 6*cpf[4] + 5*cpf[5];
    v[0] := v[0] + 4*cpf[6] + 3*cpf[7] + 2*cpf[8];
    v[0] := 11 - v[0] mod 11;
    v[1] := IfThen(v[1] >= 10, 0, v[1]);
    //Nota: Calcula o segundo dígito de verificação.
    v[1] := 11*cpf[0] + 10*cpf[1] + 9*cpf[2];
    v[1] := v[1] + 8*cpf[3] +  7*cpf[4] + 6*cpf[5];
    v[1] := v[1] + 5*cpf[6] +  4*cpf[7] + 3*cpf[8];
    v[1] := v[1] + 2*v[0];
    v[1] := 11 - v[1] mod 11;
    v[1] := IfThen(v[1] >= 10, 0, v[1]);
    //Nota: Verdadeiro se os dígitos de verificação são os esperados.
    Result :=  ((v[0] = cpf[9]) and (v[1] = cpf[10]));
  except on E: Exception do
    Result := False;
  end;
end;

end.
