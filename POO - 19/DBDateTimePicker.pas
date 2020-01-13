unit DBDateTimePicker;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.ComCtrls, Data.DB,
  Vcl.DBCtrls, Vcl.Forms, Winapi.Messages;

type
  TDBDateTimePicker = class(TDateTimePicker)
  private
    FDataLink: TFieldDataLink;
    function GetDataSource: TDataSource;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(const Value: TDataSource);
    function GetDataField: string;
    procedure DataChange(Sender: TObject);
    { Private declarations }
  protected
    {Protected declarations }
    procedure UpdateData(Sender: TObject);
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure Change(); override;
  published
    { Published declarations }
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DataField: string read GetDataField write SetDataField;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('componenteOW', [TDBDateTimePicker]);
end;

{ TDBDateTimePicker }

procedure TDBDateTimePicker.Change;
begin
	if not(FDataLink.Edit) then
  	FDataLink.Edit;

  FDataLink.Modified;

  inherited;
end;

procedure TDBDateTimePicker.CMExit(var Message: TCMExit);
begin
  inherited;
	try
    FDataLink.UpdateRecord;
  except
  	on Exception do SetFocus;
  end;
end;

constructor TDBDateTimePicker.Create(AOwner: TComponent);
begin
  inherited;
	FDataLink := TFieldDataLink.Create;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
end;

procedure TDBDateTimePicker.DataChange(Sender: TObject);
begin
	if (Assigned(FDataLink.DataSource)) and (Assigned(FDataLink.Field)) then
  	Self.Date := FDataLink.Field.AsDateTime;

end;

function TDBDateTimePicker.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TDBDateTimePicker.GetDataSource: TDataSource;
begin
	Result := FDataLink.DataSource;
end;

procedure TDBDateTimePicker.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TDBDateTimePicker.SetDataSource(const Value: TDataSource);
begin
  FDataLink.DataSource := Value;
end;

procedure TDBDateTimePicker.UpdateData(Sender: TObject);
begin
	if (Assigned(FDataLink.DataSource)) and (Assigned(FDataLink.Field)) then
  	FDataLink.Field.AsDateTime := Self.Date;
end;

end.
