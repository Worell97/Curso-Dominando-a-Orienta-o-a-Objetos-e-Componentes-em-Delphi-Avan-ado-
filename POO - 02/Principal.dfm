object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 7
    Width = 33
    Height = 13
    Caption = 'Codigo'
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object Label3: TLabel
    Left = 8
    Top = 111
    Width = 24
    Height = 13
    Caption = 'Qtde'
  end
  object Label4: TLabel
    Left = 8
    Top = 160
    Width = 12
    Height = 13
    Caption = 'Vlr'
  end
  object Label5: TLabel
    Left = 152
    Top = 224
    Width = 10
    Height = 23
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 152
    Top = 24
    Width = 97
    Height = 25
    Caption = 'Get Item'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object EdCodigo: TEdit
    Left = 8
    Top = 26
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object EdNome: TEdit
    Left = 8
    Top = 75
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object BitBtn2: TBitBtn
    Left = 152
    Top = 177
    Width = 97
    Height = 25
    Caption = 'Add Item'
    TabOrder = 5
    OnClick = BitBtn2Click
  end
  object EdQtde: TEdit
    Left = 8
    Top = 130
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object EdVlr: TEdit
    Left = 8
    Top = 179
    Width = 121
    Height = 21
    TabOrder = 4
  end
end
