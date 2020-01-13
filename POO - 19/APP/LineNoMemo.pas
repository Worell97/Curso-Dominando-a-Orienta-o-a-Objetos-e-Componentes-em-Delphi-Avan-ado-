unit LineNoMemo;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls;

type
  TLineNoMemo = class(TMemo)
  private
    function GetColumNo: Integer;
    function GetLineNo: Integer;
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    property LineNo: Integer read GetLineNo;
    property ColumNo: Integer read GetColumNo;
  end;

procedure Register;

implementation

uses
	Messages;

procedure Register;
begin
  RegisterComponents('componenteOW', [TLineNoMemo]);
end;

{ TLineNoMemo }

function TLineNoMemo.GetColumNo: Integer;
begin
	Result := SelStart - Perform(EM_LINEINDEX, LineNo, 0);
end;

function TLineNoMemo.GetLineNo: Integer;
begin
	Result := Perform(EM_LINEFROMCHAR, 0, 1);
end;

end.
