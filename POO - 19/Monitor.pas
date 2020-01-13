unit Monitor;

interface

uses
  System.SysUtils, System.Classes, Vcl.Dialogs, Graphics, Forms, System.UITypes;

type
  TMonitor = class(TComponent)
  private
    { Private declarations }
    Nome: string;
    Estilo : TFontStyles;
    Tamanho: Integer;
    CorAnterior : TColor;
    FForm : TForm;
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('componenteOW', [TMonitor]);
end;

{ TMonitor }

constructor TMonitor.Create(AOwner: TComponent);
begin
  inherited;
	FForm := TForm(Owner);
  Nome := FForm.Caption;
  Tamanho := FForm.Font.Size;
  Estilo := FForm.Font.Style;
  CorAnterior := FForm.Font.Color;

  FForm.Caption := 'Titulo alterado pelo monitor';
  FForm.Font.Size := 20;
 	FForm.Font.Style := [fsBold, fsItalic];
  FForm.Font.Color := clBlue;
end;

procedure TMonitor.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  if (AOperation = opRemove) and (AComponent is TMonitor) then
  begin
    FForm.Caption := Name;
    FForm.Font.Size := Tamanho;
    FForm.Font.Style := Estilo;
    FForm.Font.Color := CorAnterior;
  end;
  inherited;
end;

end.
