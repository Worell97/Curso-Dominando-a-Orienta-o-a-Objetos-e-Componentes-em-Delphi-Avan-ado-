unit ScrollListBox;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls;

type
  TScrollListBox = class(TListBox)
  private
    FHorizontalWidth: Integer;
    procedure SetHorizontalWidth(const Value: Integer);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    property HorizontalWidth : Integer read FHorizontalWidth write SetHorizontalWidth;

  end;

procedure Register;

implementation

uses
  Winapi.Windows, Messages;

procedure Register;
begin
  RegisterComponents('componenteOW', [TScrollListBox]);
end;

{ TScrollListBox }

procedure TScrollListBox.SetHorizontalWidth(const Value: Integer);
begin
  FHorizontalWidth := Value;
  SendMessage(Handle,LB_SETHORIZONTALEXTENT,Value, 0);
end;

end.
