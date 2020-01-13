unit MultiLineButton;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Windows;

type
  TMultiLineButton = class(TButton)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure CreateParams(var Params : 	TCreateParams); override;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('componenteOW', [TMultiLineButton]);
end;

{ TMultiLineButton }

procedure TMultiLineButton.CreateParams(var Params: TCreateParams);
begin
  inherited;
	Params.Style := Params.Style or bs_Multiline;
end;

end.
