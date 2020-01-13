﻿unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, UCliente;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    BitBtn2: TBitBtn;
    Memo2: TMemo;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
  	C : TCliente;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation


{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  TMemo(TBitBtn(Sender).Tag).Lines.Add('testestestestesteste');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
	BitBtn1.Tag := Integer(Memo1);
  BitBtn2.Tag := Integer(Memo2);
end;

end.
