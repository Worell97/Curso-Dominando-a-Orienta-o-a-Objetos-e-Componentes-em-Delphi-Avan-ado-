unit DBReadOnlyNavigator;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.DBCtrls;

type
  TDBReadOnlyNavigator = class(TDBNavigator)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('componenteOW', [TDBReadOnlyNavigator]);
end;

{ TDBReadOnlyNavigator }

constructor TDBReadOnlyNavigator.Create(AOwner: TComponent);
begin
  inherited;
	VisibleButtons := [nbFirst..nbLast,nbRefresh];
end;

end.
