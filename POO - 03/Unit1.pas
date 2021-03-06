﻿unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
	IAnimal = interface
  ['{8C3A2794-51D3-4401-8849-B4A4BF97C70F}']
    function classe: string;

    function GetNome: string;

    procedure SetNome(ANome : String);

    property Nome:String read GetNome write SetNome;
  end;

  IMutante = interface
  ['{A1CDDF49-D45A-4915-B378-053467F17B46}']
    function GetCategoria:String;
  end;

	TAnimal = class(TInterfacedObject, IAnimal)
  	private
    	FNome : string;
    protected
    	function GetNome: string; virtual;
    	procedure SetNome(ANome : String); virtual;
		public
    	function classe: String; virtual;
      constructor Create;
  end;

  THomem = class(TInterfacedObject, IAnimal)
  	private
    	FNome : string;
    protected
    	function GetNome: string; virtual;
    	procedure SetNome(ANome : String); virtual;
		public
    	function classe: String; virtual;
      constructor Create;
  end;

  TCachorro = class(TInterfacedObject, IAnimal)
  	private
    	FNome : string;
    protected
    	function GetNome: string; virtual;
    	procedure SetNome(ANome : String); virtual;
		public
    	function classe: String; virtual;
      constructor Create;
  end;

  TLobisomen = class (TInterfacedObject, IAnimal, IMutante)
  	private
    	FNome : string;
    protected
    	function GetNome: string; virtual;
    	procedure SetNome(ANome : String); virtual;
		public
    	function classe: String; virtual;
      function GetCategoria : String; virtual;
      constructor Create;
  end;


  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    BtnAnimal: TRadioButton;
    BtnHomem: TRadioButton;
    BtnCachorro: TRadioButton;
    BtnLob: TRadioButton;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
var
	obj : IAnimal;
  objMut : IMutante;
begin
	if BtnAnimal.Checked then
		obj := TAnimal.Create
  else if BtnCachorro.Checked then
		obj := TCachorro.Create
  else if BtnHomem.Checked then
		obj := THomem.Create
  else
		obj := TLobisomen.Create;


  ShowMessage(obj.classe);
  ShowMessage(obj.Nome);

  if obj.QueryInterface(IMutante, objMut) = 0 then
  	ShowMessage('Categoria: '+objMut.GetCategoria);


end;

{ THomem }

function THomem.classe: String;
begin
	Result := 'Homen';
end;

constructor THomem.Create;
begin
  inherited Create;
  FNome := 'Joao';
end;

function THomem.GetNome: string;
begin
	Result := FNome;
end;

procedure THomem.SetNome(ANome: String);
begin
  FNome := ANome;
end;

{ TCachorro }

function TCachorro.classe: string;
begin
	Result := 'Cachorro';
end;

constructor TCachorro.Create;
begin
  inherited Create;
  FNome := 'dog';
end;

function TCachorro.GetNome: string;
begin
	Result := FNome;
end;

procedure TCachorro.SetNome(ANome: String);
begin
  FNome := ANome;
end;

{ TAnimal }

function TAnimal.classe: string;
begin
	REsult := 'Animal';
end;

constructor TAnimal.Create;
begin
  inherited Create;
  FNome := 'sapiens';
end;

function TAnimal.GetNome: string;
begin
	Result := FNome;
end;

procedure TAnimal.SetNome(ANome: String);
begin
  FNome := ANome;
end;

{ TLobisomen }

function TLobisomen.GetCategoria: String;
begin
	Result := 'Ficção';
end;

function TLobisomen.classe: String;
begin
	REsult := 'Lobinho';
end;

constructor TLobisomen.Create;
begin
  inherited Create;
  FNome := 'Alien';
end;

function TLobisomen.GetNome: string;
begin
	Result := FNome;
end;

procedure TLobisomen.SetNome(ANome: String);
begin
	FNome := ANome;
end;

end.
