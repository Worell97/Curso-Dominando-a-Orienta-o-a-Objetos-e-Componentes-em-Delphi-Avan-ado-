unit DBButton;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Data.DB, Vcl.Dialogs, System.UITypes;

type

	TAcao = (taNovo, taExcluir, taEditar, taGravar, taCancelar);

  TDBButton = class(TBitBtn)
  private
    FAcao: TAcao;
    FDataSource: TDataSource;
    procedure SetAcao(const Value: TAcao);
    procedure SetDataSource(const Value: TDataSource);
    { Private declarations }
  protected
    { Protected declarations }
    procedure Notification(AComponente: TComponent; AOperation: TOperation); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure Click; override;
  published
    { Published declarations }
    property Acao: TAcao read FAcao write SetAcao;
    property DataSource: TDataSource read FDataSource write SetDataSource;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('componenteOW', [TDBButton]);
end;

{ TDBButton }

procedure TDBButton.Click;
begin
	if Assigned(FDataSource) then
  begin
    case FAcao of
      taNovo: FDataSource.DataSet.Insert;
      taExcluir:
      	if (MessageDlg('Confirma a exclusão?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
        	FDataSource.DataSet.Delete;

      taEditar: FDataSource.DataSet.Edit;
      taGravar: FDataSource.DataSet.Post;
      taCancelar: FDataSource.DataSet.Cancel;
    end;

  end;
  inherited;
end;

constructor TDBButton.Create(AOwner: TComponent);
begin
  inherited;
	FAcao := taNovo;
  Caption := 'Novo';
end;


procedure TDBButton.Notification(AComponente: TComponent; AOperation: TOperation);
begin
  inherited;
	if (AComponente = FDataSource) and (AOperation = opRemove) then
  	FDataSource := nil;

end;

procedure TDBButton.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
  case FAcao of
    taNovo: Caption := 'Novo';
    taExcluir: Caption := 'Excluir';
    taEditar: Caption := 'Editar';
    taGravar: Caption := 'Gravar';
    taCancelar: Caption := 'Cancelar';
  end;
end;

procedure TDBButton.SetDataSource(const Value: TDataSource);
begin
  FDataSource := Value;
end;

end.
