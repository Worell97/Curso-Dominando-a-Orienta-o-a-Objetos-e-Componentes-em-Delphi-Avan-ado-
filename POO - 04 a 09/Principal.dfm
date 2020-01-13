object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 192
  ClientWidth = 276
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 30
    Height = 13
    Caption = 'Senha'
  end
  object Label2: TLabel
    Left = 8
    Top = 43
    Width = 46
    Height = 13
    Caption = 'Descri'#231#227'o'
  end
  object BtSelect: TBitBtn
    Left = 96
    Top = 107
    Width = 75
    Height = 25
    Caption = 'Select'
    TabOrder = 0
    OnClick = BtSelectClick
  end
  object EdSenha: TEdit
    Left = 60
    Top = 13
    Width = 172
    Height = 21
    TabOrder = 1
  end
  object EdDescricao: TEdit
    Left = 60
    Top = 40
    Width = 172
    Height = 21
    TabOrder = 2
  end
  object CbAdm: TCheckBox
    Left = 60
    Top = 67
    Width = 97
    Height = 17
    Caption = 'ADM ?'
    TabOrder = 3
  end
  object BtInsert: TBitBtn
    Left = 96
    Top = 138
    Width = 75
    Height = 25
    Caption = 'Insert'
    TabOrder = 4
    OnClick = BtInsertClick
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\Ecosis\dados\TAMADIL.ECO'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    Left = 192
    Top = 72
  end
end
