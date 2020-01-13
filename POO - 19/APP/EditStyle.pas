unit EditStyle;

interface

uses
  System.SysUtils, System.UITypes, System.Classes, Vcl.Controls, Vcl.StdCtrls;

type
  TEditStyle = class(TEdit)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
  end;

procedure Register;

implementation

uses
	Forms, Graphics;

procedure Register;
begin
  RegisterComponents('ComponenteOW', [TEditStyle]);
end;

{ TEditStyle }

constructor TEditStyle.Create(AOwner: TComponent);
begin
  inherited;
  BevelInner := bvLowered;
  BevelKind := bkFlat;
  BevelOuter := bvRaised;
  BorderStyle := bsNone;
  Font.Color := clBlue;
  Font.Style := Font.Style + [fsBold];
end;

end.
