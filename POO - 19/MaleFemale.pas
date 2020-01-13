unit MaleFemale;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls;

type
  TMaleFemale = class(TGroupBox)
  private
    FFeminino: TRadioButton;
    FMasculino: TRadioButton;
    { Private declarations }
  protected
    { Protected declarations }
    procedure CreateWnd; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
    property Masculino : TRadioButton read FMasculino;
    property Feminino : TRadioButton read FFeminino;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('componenteOW', [TMaleFemale]);
end;

{ TMaleFemale }

constructor TMaleFemale.Create(AOwner: TComponent);
begin
  inherited;

  Width := 100;
  Height := 60;

	FMasculino := TRadioButton.Create(Self);
  FMasculino.Parent := Self;
  FMasculino.Caption := '&Masculino';
  FMasculino.Left := 20;
  FMasculino.Top := 18;
  FMasculino.Width := 75;


	FFeminino := TRadioButton.Create(Self);
  FFeminino.Parent := Self;
  FFeminino.Caption := '&Feminino';
  FFeminino.Left := 20;
  FFeminino.Top := 35;
  FFeminino.Width := 75;

  FMasculino.SetSubComponent(True);

end;
procedure TMaleFemale.CreateWnd;
begin
  inherited;
  Caption := '';
end;

end.
