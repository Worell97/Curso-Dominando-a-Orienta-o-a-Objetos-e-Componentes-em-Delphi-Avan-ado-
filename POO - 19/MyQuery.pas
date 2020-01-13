unit MyQuery;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.StdCtrls, DBGrids,
  Data.DB, FireDAC.Stan.Intf,FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type

  TMyQuery = class(TPanel)
  private
    { Private declarations }
    List: TStringList;
    Panel1: TPanel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    FDataSource: TDataSource;
    FTabela: TFDTable;
    procedure SetDataSource(const Value: TDataSource);
    procedure SetTabela(const Value: TFDTable);



  protected
    { Protected declarations }
    procedure Consulta(Sender: TObject);
    procedure Limpar(Sender: TObject);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure Resize; override;
  published
    { Published declarations }
    property DataSource: TDataSource  read FDataSource write SetDataSource;
    property Tabela: TFDTable read FTabela write SetTabela;
  end;

procedure Register;

implementation

uses
  Winapi.Windows, Vcl.Graphics;

procedure Register;
begin
  RegisterComponents('componenteOW', [TMyQuery]);
end;

{ TMyQuery }

procedure TMyQuery.Consulta(Sender: TObject);
var
	SQL : String;
begin
	Label1.Caption := '';
  if Combobox1.Text <> EmptyStr then
  	if Combobox2.Text <> EmptyStr then
    	if Edit1.Text <> EmptyStr then
      begin
				SQL := SQL + '('+Combobox1.Text + ' ' + Combobox2.Text + ' ' + QuotedStr(Edit1.Text)+')';
      end;
  if Combobox3.Text <> EmptyStr then
  	if Combobox4.Text <> EmptyStr then
    	if Edit2.Text <> EmptyStr then
      begin
				SQL := SQL + ' AND (' + Combobox3.Text + ' ' + Combobox4.Text + ' ' + QuotedStr(Edit2.Text)+')';
      end;

  FTabela.Filter := SQL;
  FTabela.Filtered := True;
  Label1.Caption := Label1.Caption + ' ' +SQL;
end;

constructor TMyQuery.Create(AOwner: TComponent);
begin
  inherited;
	Left := 0;
  Top:= 0;
  Width := 539;
  Height := 348;
  Align := alNone;
  TabOrder := 0;

  Label1 := TLabel.Create(Self);
  with Label1 do
  begin
    Left := 16;
    Top:= 324;
    Width := 28;
    Height := 13;
    Caption := 'Filtro';
    Parent := Self;
  end;

  Edit1 := TEdit.Create(Self);
  with Edit1 do
  begin
    Left := 244;
    Top:= 23;
    Width := 121;
    Height := 21;
    TabOrder := 4;
    Parent := Self;
  end;

  Edit2 := TEdit.Create(Self);
  with Edit2 do
  begin
    Left := 244;
    Top:= 62;
    Width := 121;
    Height := 21;
    TabOrder := 5;
    Parent := Self;
  end;

  DBGrid1 := TDBGrid.Create(Self);
  with DBGrid1 do
  begin
    Parent := Self;
    Left := 8;
    Top:= 93;
    Width := 524;
    Height := 220;
    TabOrder := 6;
    TitleFont.Charset := DEFAULT_Charset;
    TitleFont.Color := clWindowText;
    TitleFont.Height := -11;
    TitleFont.Name := 'MS Sans Serif ';
    TitleFont.Style := [];
  end;

  Button1 := TButton.Create(Self);
  with Button1 do
  begin
    Parent := Self;
    Left := 450;
    Top:= 23;
    Width := 75;
    Height := 25;
    Caption := 'Consultar';
    TabOrder := 7;
    OnClick := Consulta;
  end;

  Button2 := TButton.Create(Self);
  with Button2 do
  begin
    Parent := Self;
    Left := 450;
    Top:= 58;
    Width := 75;
    Height := 25;
    Caption := 'Limpar';
    TabOrder := 8;
    OnClick := Limpar;
  end;

  ComboBox1 := TComboBox.Create(Self);
  with ComboBox1 do
  begin
    Parent := Self;
    Left := 8;
    Top:= 23;
    Width := 165;
    Height := 21;
    ItemHeight := 13;
    Sorted := True;
    TabOrder := 0;
  end;

  ComboBox2 := TComboBox.Create(Self);
  with ComboBox2 do
  begin
    Parent := Self;
    Left := 180;
    Top:= 23;
    Width := 57;
    Height := 21;
    ItemHeight := 13;
    TabOrder := 1;
  end;

  ComboBox3 := TComboBox.Create(Self);
  with ComboBox3 do
  begin
    Parent := Self;
    Left := 8;
    Top:= 62;
    Width := 165;
    Height := 21;
    ItemHeight := 13;
    Sorted := True;
    TabOrder := 2;
  end;

  ComboBox4 := TComboBox.Create(Self);
  with ComboBox4 do
  begin
    Parent := Self;
    Left := 180;
    Top:= 62;
    Width := 57;
    Height := 21;
    ItemHeight := 13;
    TabOrder := 3;
  end;

  List := TStringList.Create;
  with List do
  begin
		Add('=');
		Add('<>');
		Add('>');
		Add('<');
		Add('>=');
		Add('<=');
  end;

end;

destructor TMyQuery.Destroy;
begin
  FreeAndNil(List);
  FreeAndNil(Panel1);
  FreeAndNil(ComboBox1);
  FreeAndNil(ComboBox2);
  FreeAndNil(ComboBox3);
  FreeAndNil(ComboBox4);
  FreeAndNil(Edit1);
  FreeAndNil(Edit2);
  FreeAndNil(Label1);
  FreeAndNil(DBGrid1);
  FreeAndNil(Button1);
  FreeAndNil(Button2);
  FreeAndNil(FDataSource);
  FreeAndNil(FTabela);
  inherited;
end;

procedure TMyQuery.Limpar(Sender: TObject);
begin
	Combobox1.Clear;
	Combobox2.Clear;
	Combobox3.Clear;
	Combobox4.Clear;
  Edit1.Clear;
  Edit2.Clear;
  FTabela.Filtered := False;
end;

procedure TMyQuery.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited;
  if(AComponent = FDataSource) and (AOperation = opRemove) then FDataSource := nil;
  if(AComponent = FTabela) and (AOperation = opRemove) then FTabela := nil;
end;

procedure TMyQuery.Resize;
begin
  inherited;
	Width := 539;
	Height	 := 348;
end;

procedure TMyQuery.SetDataSource(const Value: TDataSource);
begin
  FDataSource := Value;
  DBGrid1.DataSource := Value;
end;

procedure TMyQuery.SetTabela(const Value: TFDTable);
begin
  FTabela := Value;
  FTabela.GetFieldNames(Combobox1.Items);
  FTabela.GetFieldNames(Combobox3.Items);

  Combobox2.Items := List;
  Combobox4.Items := List;
end;

end.

