unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, System.UITypes;

type
  TForm1 = class(TForm)
    BtSelect: TBitBtn;
    FDConnection1: TFDConnection;
    Label1: TLabel;
    EdSenha: TEdit;
    EdDescricao: TEdit;
    Label2: TLabel;
    CbAdm: TCheckBox;
    BtInsert: TBitBtn;
    procedure BtSelectClick(Sender: TObject);
    procedure BtInsertClick(Sender: TObject);
  private
  	procedure MyOnBeforeInsert(Sender : TObject; var CanExecute: Boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  IPersist;

{$R *.dfm}

procedure TForm1.BtInsertClick(Sender: TObject);
var
	LTable: IPersist.ITable;
begin
	LTable := IPersist.TTable.Create(FDConnection1, 'USUARIOS', ['LOGIN']);
 	LTable.UseLog := True;
  LTable.FileLog := 'C:\Users\oscar.filho\OneDrive\Curso Dominando a Orientação a Objetos e Componentes em Delphi (Avançado)\POO - 04\filelog.log';
  LTable.OnBeforeInsert := MyOnBeforeInsert;

	LTable.FieldByName('LOGIN'		).asString := 'OSCAR23122';
  LTable.FieldByName('Descricao').asString := 'teste 01';
  LTable.FieldByName('senha'		).asString := '1546';
  LTable.FieldByName('adm'			).asString := 'S';
 	ShowMessage('Registros incluídos: ' + IntToStr(LTable.Insert));

end;

procedure TForm1.BtSelectClick(Sender: TObject);
var
	LTable: IPersist.ITable;
begin
	LTable := IPersist.TTable.Create(FDConnection1, 'USUARIOS', ['LOGIN']);
 	LTable.UseLog := True;
  LTable.FileLog := 'C:\Users\oscar.filho\OneDrive\Curso Dominando a Orientação a Objetos e Componentes em Delphi (Avançado)\POO - 04\filelog.log';
	LTable.FieldByName('LOGIN').asString := 'OSCAR';

  if LTable.select('*') then
  begin
		EdSenha.Text := LTable.FieldByName('SENHA').asString;
    EdDescricao.Text := LTable.FieldByName('descricao').asString;
		CbAdm.Checked := LTable.FieldByName('ADM').asString = 'S';

  end else
  	ShowMessage('Não encontrado!');

end;

procedure TForm1.MyOnBeforeInsert(Sender: TObject; var CanExecute: Boolean);
begin
	CanExecute := MessageDlg('Confirma a execução do processo? ', mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;

end.
