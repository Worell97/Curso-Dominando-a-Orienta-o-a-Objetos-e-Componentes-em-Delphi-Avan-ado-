unit NoCaptionPanel;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.ExtCtrls;

type
  TNoCaptionPanel = class(TPanel)
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure CreateWnd; override;
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('componenteOW', [TNoCaptionPanel]);
end;

{ TNoCaptionPanel }

procedure TNoCaptionPanel.CreateWND;
begin
  inherited;
  Caption := '';
end;

end.
