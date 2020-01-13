object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 237
  ClientWidth = 237
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LabeledEdit1: TLabeledEdit
    Left = 40
    Top = 24
    Width = 171
    Height = 21
    EditLabel.Width = 33
    EditLabel.Height = 13
    EditLabel.Caption = 'Valor 1'
    TabOrder = 0
  end
  object LabeledEdit2: TLabeledEdit
    Left = 40
    Top = 64
    Width = 171
    Height = 21
    EditLabel.Width = 33
    EditLabel.Height = 13
    EditLabel.Caption = 'Valor 2'
    TabOrder = 1
  end
  object LabeledEdit3: TLabeledEdit
    Left = 40
    Top = 112
    Width = 171
    Height = 21
    EditLabel.Width = 48
    EditLabel.Height = 13
    EditLabel.Caption = 'Resultado'
    TabOrder = 2
  end
  object Button1: TButton
    Left = 40
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Somar'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 136
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Dividir'
    TabOrder = 4
    OnClick = Button2Click
  end
end
