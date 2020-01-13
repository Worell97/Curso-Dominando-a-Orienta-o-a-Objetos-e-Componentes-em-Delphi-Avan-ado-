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
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 232
    Top = 136
    Width = 75
    Height = 25
    Caption = 'BitBtn1'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object BtnAnimal: TRadioButton
    Left = 400
    Top = 24
    Width = 113
    Height = 17
    Caption = 'Animal'
    Checked = True
    TabOrder = 1
    TabStop = True
  end
  object BtnHomem: TRadioButton
    Left = 400
    Top = 47
    Width = 113
    Height = 17
    Caption = 'Homem'
    TabOrder = 2
  end
  object BtnCachorro: TRadioButton
    Left = 400
    Top = 70
    Width = 113
    Height = 17
    Caption = 'Cachorro'
    TabOrder = 3
  end
  object BtnLob: TRadioButton
    Left = 400
    Top = 93
    Width = 113
    Height = 17
    Caption = 'Lobisomen'
    TabOrder = 4
  end
end
