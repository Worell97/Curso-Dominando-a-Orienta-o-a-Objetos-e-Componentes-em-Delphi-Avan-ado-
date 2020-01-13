object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'FrmMain'
  ClientHeight = 470
  ClientWidth = 718
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 112
    Top = 63
    Width = 505
    Height = 305
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 112
    Top = 374
    Width = 500
    Height = 51
    DataSource = DataSource1
    TabOrder = 1
  end
  object DBDateTimePicker1: TDBDateTimePicker
    Left = 112
    Top = 24
    Width = 186
    Height = 21
    Date = 32245.769891180560000000
    Time = 32245.769891180560000000
    TabOrder = 2
    DataSource = DataSource1
    DataField = 'SaleDate'
  end
  object FDTable1: TFDTable
    Active = True
    IndexFieldNames = 'OrderNo'
    ConnectionName = 'DBDEMOS'
    UpdateOptions.UpdateTableName = 'orders'
    TableName = 'orders'
    Left = 16
    Top = 80
  end
  object DataSource1: TDataSource
    DataSet = FDTable1
    Left = 16
    Top = 32
  end
end
