unit MaleFemaleBoolean;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls;

type

	TOnCheckMasculino = procedure(value : Boolean; Sender : TObject) of object;

  TMaleFemaleBoolean = class(TGroupBox)
  private
  	FCheckMasculino : TRadioButton;
    FCheckFeminino : TRadioButton;
    FOnChange: TNotifyEvent;
    FOnCheckedMasculino: TOnCheckMasculino;
    function GetCheckMasculino: Boolean;
    procedure SetCheckMasculino(const Value: Boolean);
    function GetCheckFeminino: Boolean;
    procedure SetCheckFeminino(const Value: Boolean);
    procedure SetOnChange(const Value: TNotifyEvent);
    procedure SetOnCheckedMasculino(const Value: TOnCheckMasculino);
    { Private declarations }
  protected
    { Protected declarations }
    procedure CreateWnd; override;
    procedure RadioClick(Sendert : TObject);virtual;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
    property CheckMasculino : Boolean read GetCheckMasculino write SetCheckMasculino;
    property CheckFeminino : Boolean read GetCheckFeminino write SetCheckFeminino;
    property OnChange : TNotifyEvent read FOnChange write SetOnChange;
    property OnCheckedMasculino : TOnCheckMasculino read FOnCheckedMasculino write SetOnCheckedMasculino;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('componenteOW', [TMaleFemaleBoolean]);
end;

{ TMaleFemaleBoolean }

constructor TMaleFemaleBoolean.Create(AOwner: TComponent);
begin
  inherited;
  Width := 100;
  Height := 60;

	FCheckMasculino := TRadioButton.Create(Self);
  FCheckMasculino.Parent := Self;
  FCheckMasculino.Caption := '&Masculino';
  FCheckMasculino.Left := 20;
  FCheckMasculino.Top := 18;
  FCheckMasculino.Width := 75;
  FCheckMasculino.OnClick := RadioClick;

	FCheckFeminino := TRadioButton.Create(Self);
  FCheckFeminino.Parent := Self;
  FCheckFeminino.Caption := '&Feminino';
  FCheckFeminino.Left := 20;
  FCheckFeminino.Top := 35;
  FCheckFeminino.Width := 75;
  FCheckFeminino.OnClick := RadioClick;

  FCheckMasculino.SetSubComponent(True);
  FCheckFeminino.SetSubComponent(True);

end;

procedure TMaleFemaleBoolean.CreateWnd;
begin
  inherited;
  Caption := '';
end;

function TMaleFemaleBoolean.GetCheckFeminino: Boolean;
begin
	Result := FCheckFeminino.Checked;
end;

function TMaleFemaleBoolean.GetCheckMasculino: Boolean;
begin
	Result := FCheckMasculino.Checked;
end;

procedure TMaleFemaleBoolean.RadioClick(Sendert: TObject);
begin
  if Assigned(FOnChange) then
  	OnChange(Self);

  if Assigned(FOnCheckedMasculino) then
  	FOnCheckedMasculino(FCheckMasculino.Checked, FCheckMasculino);


end;

procedure TMaleFemaleBoolean.SetCheckFeminino(const Value: Boolean);
begin
	FCheckFeminino.Checked := Value;
end;

procedure TMaleFemaleBoolean.SetCheckMasculino(const Value: Boolean);
begin
	FCheckMasculino.Checked := Value;
  if Assigned(FOnCheckedMasculino) then
  	FOnCheckedMasculino(Value, FCheckMasculino);

end;

procedure TMaleFemaleBoolean.SetOnChange(const Value: TNotifyEvent);
begin
  FOnChange := Value;
end;

procedure TMaleFemaleBoolean.SetOnCheckedMasculino(const Value: TOnCheckMasculino);
begin
  FOnCheckedMasculino := Value;
end;

end.
